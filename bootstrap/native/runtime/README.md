# Native runtime and process entry

These B-written modules emit Linux x86-64 primitives and entry code.
The [native tool guide](../README.md) describes the surrounding compiler.

## Primitives

`runtime/emit.b` and `runtime/path.b` emit Linux x86-64 implementations of
`char`, `lchar`, `read`, `write`, `close`, `seek`, `exit`, `open`, `creat`,
`chmod`, `unlink`, `fork`, and `wait`. The emitted functions use the counted-argument B call
frame from `calls.b`, not the C calling convention. They make Linux system
calls directly and do not link a C runtime.

Call `xfpro(id, xbicnt(op), 0)`, then `xbuiltin(op)`, then `xfend()`.
Operation IDs 0 through 10 cover `char` through `unlink`; 12 and 13 select
`fork` and `wait`. ID 11 is reserved for the `argv` data provider and is not
a valid `xbuiltin` operation. ID 14 is the private raw `__sys` bridge described
below. The emitter rejects an
unknown operation, a mismatched declared argument count, a missing function
frame, or a nonempty expression stack. Private branches consume the label
budget supplied to `xrinit`. At execution time, too few actual arguments
branch to that configuration's fault handler. Extra arguments are allowed;
`exit()` without an argument uses the zero-padded argument cell.

Character offsets count bytes, while buffer and pathname pointers count
64-bit words. `lchar` stores the low byte and returns the original argument.
File operations return -1 on a syscall error; `seek` returns zero on success,
not the resulting position. Short reads and writes are returned to the caller
without an automatic retry. `open` selects read access for mode zero and write
access otherwise, matching the existing host compatibility interface.

Pathnames accept EOT or NUL. Each call copies at most 4,095 pathname bytes
into its own stack buffer, leaving the caller's string unchanged. Null and
overlong paths return -1. This is a length limit, not validation of arbitrary
memory addresses. `creat` and `chmod` translate the six-bit Unix V1 permission
field; larger values retain the existing host POSIX-mode extension.

The syscall numbers come from the
[Linux x86-64 syscall table](https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_64.tbl).
These are host implementations of selected runtime operations, not PDP-11
instruction sequences or a complete historical runtime.

The process primitives follow the [B72 library interface](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html):
`fork()` returns zero in the child and its process ID in the parent, while
`wait()` returns a completed child's process ID rather than its exit status.
Both map kernel errors to -1. The native implementation uses Linux `fork` and
`wait4`, without a shell. It does not add a status-output argument to the
historical `wait` interface. Tests check no-child failure, reaping, a nonzero
child exit status, process-local memory changes, saved function values, and
source-defined replacements.


```sh
python3 bootstrap/native/test_runtime.py
```

On Linux x86-64 the test executes generated images with an empty tool-search
path. It checks argument counts, preserved stack and frame registers, packed
bytes, short and failed I/O, wide offsets, pathname boundaries, and permission
translation. File tests use a temporary directory. Permission translation is
checked for all 64 historical modes without creating set-user-ID files.
Other platforms build the images but report native execution as skipped.

The focused runtime fixture calls these primitives by numeric ID. The
whole-program constructor also binds source-level imports for this initial
set, as described below. A separate entry module packs the predefined
argument vector. General allocation and the remaining library interfaces are still missing. The emitters themselves still run through the
seed's C-backed runtime. This is groundwork for native self-compilation, not
a completed self-hosting compiler.

## Import selection

`runtime/imports.b` scans resolved records for references to the supported
primitive names and for source definitions of those names. It selects a
provider only when a name is referenced but never defined in the input.
Definitions are collected across the whole input before selection, so a later
function, scalar, or vector definition takes precedence too. Unused primitives
are not added. Unknown names remain unresolved and fail in the data/code pass.

Call `xbiscan(fd)` before `xbicopy(fd,out,visit)`, reopening the same unchanged
input for the second pass. The latter copies the records and appends empty
function records for the selected providers. The callback receives the
NUL-terminated name, operation ID, and declared argument count. ID 11 denotes
the predefined `argv` data cell, with count zero, rather than a function; it
is emitted as a zero-initialized scalar record. ID 15 similarly supplies the
private `__env` cell; it holds the inherited Linux environment-vector byte
address, not a word pointer or a historical B external. The caller
must supply distinct input and output files and close both descriptors;
`xbicopy` flushes but does not close its output. These are internal compiler
interfaces, not a general linker or a parser for untrusted object formats.

The call-test constructor records which functions came from this selection.
Only those bodies are replaced with primitive implementations. Their address
cells go through the ordinary static-data path, so saved function values,
address initializers, assignment through `&char`, and indirect calls keep the
same behavior as source functions. A source function named `char` is never
replaced just because its name matches a primitive.

`test_calls.py` checks these cases, real file I/O through source-level calls,
stdout and stderr writes, exit status, and argument-count faults. It also
initializes an imported `argv` cell with the entry module below. It still uses
a result-reporting entry point rather than normal process startup. Import
selection does not remove the seed's C dependency or establish native
self-compilation.

## Argument vector

`runtime/argv.b` emits `xargvec(limit)` for the Linux x86-64 process-entry
stack, before a B function frame is created. The emitted code copies the
kernel's argument strings into independent, word-aligned storage and builds
`[argc, arg0, arg1, ...]`. Strings retain their NUL terminators, including
empty strings and bytes equal to EOT. This is the predefined B `argv` vector,
not the host compatibility function `argv(index)` that returns EOT strings.

At completion, RAX contains the vector's word pointer and RDX contains the
argument count. R8 contains the original environment-vector byte address for the private
runtime bridge. RSP is unchanged; the other working registers may be clobbered.
The emitter requires no active function frame or stacked expression operands.
It uses the configured fault label for an invalid initial count, a null
argument pointer, an allocation failure, or insufficient copy space.

The count limit is 4,095 arguments, including the executable name. The
allocation budget includes the vector, terminators, and per-string alignment.
It must be a multiple of eight between 16 bytes and 16 MiB. The call-test
constructor uses 1 MiB. Storage is an anonymous read/write mapping retained
until process exit, not a general allocator. Mapping constants follow the
[Linux memory-mapping interface](https://github.com/torvalds/linux/blob/master/include/uapi/asm-generic/mman-common.h).

```sh
python3 bootstrap/native/test_argv.py
```

Tests check empty arguments, embedded EOT and high bytes, word boundaries,
long strings, many arguments, exact allocation limits, and independent storage
without changing the kernel's original argument bytes. The call constructor
connects this vector to source-level `argv` references while preserving source
definitions, local shadows, address initializers, and assignment to the global
cell. It still uses a binary-result test entry point and rejects parameters
on `main`. The compatibility argument functions and a general installed compiler
remain unfinished.

## Private kernel bridge

`__sys(number,a,b,c,d,e,f)` is a private host bridge for this B-maintained
runtime and driver. It takes raw Linux argument values, including byte
addresses, and returns the raw kernel result, including negative error numbers.
It is not a portable or historical B library function. Ordinary B-facing
wrappers still translate errors to their documented results. `__env` supplies
the inherited environment pointer for the exec wrapper.
