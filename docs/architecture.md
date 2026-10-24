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
still uses byte-addressed B pointers. Public B function symbols address mutable
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
