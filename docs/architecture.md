# Compiler architecture

## Host compiler

`src/main.c` handles arguments, input files, runtime lookup, generated files,
and host-toolchain subprocesses. It collects function names across input
files before compiling individual units.

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
programs also need space for their runtime stack.

Native `runtime/brt.s` supplies startup-adjacent helpers and syscall wrappers;
`runtime/libb.b` supplies library routines written in B. The native compiler
still uses byte-addressed B pointers. The test guide distinguishes fast
emulation from full-system Unix V1 behavior and documents the image safeguards.
