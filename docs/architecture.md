# Compiler architecture

## Host compiler

`src/main.c` handles arguments, input files, runtime lookup, generated files,
and host-toolchain subprocesses. It collects function and external-data names across input files before
compiling individual units. C-keyword mappings are deterministic across files,
so names such as `int` and `b_int` remain distinct.

`src/lexer.c` reads B tokens and escapes. `src/parser.c` builds the syntax
tree. `src/sem.c` resolves declarations, function/label scope, and strict-mode
checks. `src/emitter.c` lowers the checked tree to C. `src/arena.c` owns
compiler allocations; `src/util.c` contains shared helpers and diagnostics.

Executable, object, and host-assembly output use the same C representation.
Assembly emission asks the host compiler to lower that C with `-S`; it is
not an independent handwritten B backend.

## Runtime and 16-bit addresses

`lib/libb.c` implements host runtime calls. `lib/libb.h` declares the API and
word operations. `lib/btarget.h` maps 16-bit B addresses onto host storage.
The host cells remain host-sized; packed character access translates the
selected B word layout rather than treating those cells as raw PDP-11 RAM.

The shared runtime keeps one address registry across compilation units.
Function-local registrations are released on return, and heap registrations
are removed when freed. Function values use their own address conversion.
The inline emitter carries equivalent runtime code, so changes to either
layout need tests against both. Inline 16-bit translation units share their
address-map storage through common symbols rather than creating a separate
map for each source file. Inline argument metadata is shared too, so a
function in another input file sees the same process arguments.

The predefined `argv` cell points to a count-prefixed vector with native
NUL-terminated strings. Compatibility calls retain a separate zero-based
array of EOT-terminated strings. Generated main wrappers obtain that array
directly; they must not reconstruct it from a pointer to the first string.

String storage is keyed by literal occurrence, not by byte content. Each
occurrence has writable storage that persists across calls. Equal literals
elsewhere do not share mutations through `lchar`. The collection and emission
passes reuse the same occurrence rather than allocating storage per evaluation.

In strict mode, automatic names have function-wide storage after declaration.
The C emitter reserves their cells at function entry and leaves vector pointer
initialization at the declaration. Declaration prefixes are grouped with their
following statement, so an `if` or `while` controls both. Compatibility mode
keeps the existing C-style block scoping.

## External storage

Every B external data object is a C array of cells. Reading its B name reads
cell zero. A simple definition such as `data 11,22,33;` places all three
values at consecutive locations starting at `&data`. A vector definition
still has a pointer cell plus separate element storage.

The shared and inline C emitters use the same declaration and initializer
helpers. In 16-bit mode, every file registers its complete objects before
any address initializers run. This uses [GCC constructor priorities](https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html):
101 for address registration, then 102 for registering each file's initializer.
`lib/binit.h` keeps that list shared across files. The main wrapper sets up
arguments before running the initializers, once each. This also preserves
compatibility initializers that call `argc()` or read `argv`. A forward
reference must not register only the first word of a larger object.

Generated B data objects must be rebuilt together after this layout change.
A C caller inspecting generated storage should use an array declaration,
not the previous scalar declaration. The generated C shows any name mangling. A C entry point embedding generated
B modules should call `__b_setargs` and `__b_init` before using their data.

## Other compiler builds

The assembly-source build contains GNU assembler snapshots of the host
compiler. `asm/regenerate.py` refreshes them and records hashes. Its tests
use the same host suite, including generated-assembly execution.

The bootstrap compiler is written in B and emits C. Its label prepass uses
the same statement parser as emission, so forward and computed branches can
resolve labels within a function. Three stages are checked for matching C
and for executable behavior; a fixed point alone can preserve a shared bug.

The native PDP-11 compiler has three processes: `b00` parses to intermediate
records, `b01` resolves names, and `b1` emits V1 assembler syntax. A small
native driver runs those passes and the historical assembler. Splitting the
passes keeps their code/data/BSS within the 16 KB process budget, although
programs also need space for their runtime stack. Native frame allocation uses
a forward assembler constant whose value is emitted after the body has been
parsed. Late automatic declarations therefore contribute to the same frame;
vector initialization records stay at their source execution points.

Native `runtime/brt.s` supplies startup-adjacent helpers and syscall wrappers;
`runtime/libb.b` supplies library routines written in B. The native compiler
uses word-addressed B data pointers. Public B function symbols address mutable
cells initialized to the function body. Every call saves the callee value on
the stack, evaluates and reverses the arguments into the existing ABI order,
then calls that saved address. Cleanup removes the arguments and the saved
callee. For external string initializers, `b01` buffers the short definition
and cell records while streaming literal bytes first. The cells are emitted
together afterward, with references to the literal labels. This avoids
putting string bytes between adjacent cells or retaining every literal in
the compiler's small address space. Arithmetic helpers with private dot-prefixed names remain direct
assembly calls. The test guide distinguishes fast
emulation from full-system Unix V1 behavior and documents the image safeguards.

`lib/bunix.h` provides the Unix V1 metadata and permission conversions shared
by the linked and inline host runtimes. Status records are written field by
field into B cells, never copied from the host structure. Installed and staged
compilers carry this header, and it participates in the runtime cache key.

Bootstrap strict mode passes the same word-addressing selection to generated
C and the linked runtime. Compatibility mode keeps byte-addressed pointers.
The pointer-step and guarded status-buffer tests catch mismatches between
those two compilation units.

Native static pointer initializers use absolute word-address expressions based
on the fixed 040014 load origin. Dynamic lvalue addresses are converted to
word units; loads, stores, and byte-oriented syscalls convert back at their
boundaries. Function and label values remain opaque code-entry values.
Startup copies kernel argument strings into aligned stack storage and checks
that the copies cannot reach the assembled program end. The normal emitter
defines that end marker; library-only output does not.

Native executable conversion emits only the fixed-origin text with a stripped
V1 header. The text length includes the 12-byte header. Incompatible V2 symbol
and relocation metadata is discarded, not copied into a V1 section or
reported as zero-fill memory. Conversion failure removes the partial output.

Internal label cells have static lifetime, not automatic lifetime. The C
backends store function-local numeric dispatch values in writable cells.
The native backend emits cells after each epilogue, initialized to code
addresses; even a bare goto loads its target through the cell. Address-of
uses the same data-pointer units as other cells.

`lib/bformat.h` is shared by the linked and inline host runtimes. It keeps
strict formatting separate from compatibility formatting; the runtime cache
key includes that selection and the header contents.

Strict host emission uses private C names for B identifiers, including
external calls compiled separately. C macros exposed through the host
compatibility external mechanism are checked by their original spelling.
The bootstrap also namespaces its local and parameter bindings. Source-
defined functions named after C APIs do not receive C pointer or string
conversions just because their names match.

Source-defined functions use data cells separate from their private C bodies.
The host registers those cells before address initializers, then initializes
their callable values once during startup. Calls, saved values, and address-
based replacements use the cells. The host-sized bootstrap can initialize
its function cells directly from body addresses. Both main wrappers read the
main cell after global initialization. Bundled host-runtime callbacks are a
separate remaining interposition task.

The native driver's `bsel.c` module selects library definitions before
assembly. It recognizes public labels in compiler-generated output, then
filters matching labels from the runtime while preserving its code and data.
Buffered reads keep this step practical inside V1. Temporary copies are
created only for affected runtime files. This is symbol precedence, not
archive-member extraction or dead-code elimination.

Host source-function cells change the generated object ABI: rebuild all B
objects with the same compiler and runtime modes. A function's public binding
is data, while its executable body has a private C name. Separate strict
objects therefore use the same cell interface for calls and replacements.

Parameter references carry a binding index after semantic analysis. The host
emitter copies all supplied arguments into one per-invocation word array and
uses those cells for reads, writes, and address-of. The whole array receives
one translated-address registration in 16-bit mode. The bootstrap uses the
same storage shape; its local-name lookup and compatibility block scopes keep
a shadowing local distinct from the parameter cell.

`lib/bcall.h` keeps the active argument frame and a registry of source-function
bodies. A source call saves the callee value, evaluates its arguments, and
passes the complete argument block to a private zero-parameter C body. The body
copies those words into its parameter storage and zero-fills missing declared
parameters. Calls restore the previous frame on return, including nested and
recursive calls. Source functions compiled in separate files share the registry.
Runtime function values use checked word-array adapters. Compatibility C
function values retain their foreign-call path.
The bootstrap emits the same source-function interface.

Named binding records retain a B name and its cell address, separately from
the call registry's original three-field records. Data definitions register
only a binding, without a source-code entry. Default library
calls can therefore find a supplied definition without depending on C symbol
interposition or the compilation order of separate files. Formatting and line-input
callbacks use the same argument-frame path as other B calls. Private string and
syscall marshalling still uses the runtime's own byte-access helpers.

`lib/bprimitives.h` owns the default library cells and their adapters. A
registry indexes names and original code values separately: replacing a cell
changes later named calls without invalidating a saved original value.
Supplied B definitions redirect the name entry to their own cell. Inline
modules share weak cell definitions and I/O state; each module can register
its private runtime bodies. The adapters check the argument count before
calling a typed C helper. Formatting reads from a bounded word array for B
calls and from `va_list` for the public C entry point.
