# Host-native image construction

`elfimage.b` packages existing x86-64 instruction bytes and data into a Linux
ELF64 executable. It is written in B and invokes no assembler or linker while
writing the image. It does not translate B source to machine instructions,
resolve symbols, apply relocations, or rebuild the compiler.

The writer is still built through BCC's C-output path and uses its host
runtime. This is one piece of the native backend, not a self-hosted host
compiler. The executable it produces has no interpreter or C runtime unless
the supplied instruction bytes implement one themselves.

## Build and use

From the repository root:

```sh
make
mkdir -p bootstrap/build/native
./bcc --strict --pedantic --word=host bootstrap/native/elfimage.b -o bootstrap/build/native/elfimage
bootstrap/build/native/elfimage code.bin data.bin 4096 0 > candidate.elf
```

The arguments are the instruction file, initialized-data file, zero-filled
storage size, and entry offset within the instructions. Sizes and offsets are
decimal. The instruction file must be nonempty and the entry offset must be
inside it. The two input files must be seekable. Each input and the zero-filled
storage size is limited to 16 MiB. The writer supports BCC's host and 32-bit
word models, not the PDP-11's 16-bit model.

Use a fresh output path and check the exit status before making it executable.
A failed write or close leaves an incomplete or untrusted output that the
caller must discard. Do not redirect over either input: the shell would
truncate that file before the writer starts. The writer does not set file
permissions or install the result.

## Layout

- The image base is `0x400000`; instructions start at `0x401000`.
- The first load segment contains the headers and instructions, with read
  and execute permissions.
- Initialized data begins at the next 4 KiB boundary after the instructions.
  Its address is `0x400000 + align_up(4096 + code_size, 4096)`. The second load
  segment has read and write permissions and includes the zero-filled tail.
- A `PT_GNU_STACK` header requests a non-executable stack.
- There are no section headers, dynamic linker, symbol table, or relocations.

Instruction bytes must already use these addresses or suitable relative
addressing. The writer checks file sizes and header values, not whether the
supplied instructions are valid or safe to run. Inputs must remain unchanged
during the two-pass read; changing their sizes is rejected, but same-length
concurrent edits are not detected.

The format follows the [ELF header](https://gabi.xinuos.com/elf/02-eheader.html)
and [program loading](https://gabi.xinuos.com/elf/07-pheader.html) specifications.
The x86-64 machine identifier and stack-header value are also defined in the
[Linux ELF interface](https://github.com/torvalds/linux/blob/master/include/uapi/linux/elf.h).
This is a modern target format, not a historical B or PDP-11 executable format.

## Checks

```sh
python3 bootstrap/native/test_elfimage.py
python3 bootstrap/native/test_elfimage.py --close-faults
make -C bootstrap native-test
```

The tests compare every output byte with an independent layout calculation,
check page boundaries and invalid inputs, and exercise delayed close failures
when requested. On Linux x86-64 they also execute fixtures that exit with a
known status, write initialized data, and read and modify zero-filled storage.
The writer runs with an empty tool-search path. Execution checks are reported
as skipped on other architectures; header comparisons still run.

`native-test` also builds and tests the writer through all three B-written
bootstrap stages. Those stages still emit C. Matching their image output is
useful evidence, but it is not the missing B-to-native backend.

## Instruction encoder

`x64.b` is a B library that emits a limited set of x86-64 instruction forms.
Concatenate it with an emitter's B source, compile that emitter with the seed
toolchain, and run it to produce instruction bytes for `elfimage.b`. This
removes an assembler from that construction step. It does not yet compile
ordinary B expressions or statements into native code.

The encoder requires 64-bit B words. Register IDs follow the instruction
encoding: RAX, RCX, RDX, RBX, RSP, RBP, RSI, RDI are 0 through 7; R8 through
R15 are 8 through 15. A byte operand uses the corresponding low-byte register,
including SPL, BPL, SIL and DIL, not AH, CH, DH or BH.

Call `xstart(fd)` before emitting anything. It takes ownership of the output
descriptor. `xtell()` reports bytes emitted, including bytes still buffered;
`xfinish()` flushes and closes the descriptor, checking both operations.
Invalid operands and I/O failures terminate with a nonzero status. Discard
failed output. Internal byte, prefix, and ModRM helpers are not checked public
interfaces.

The supported interfaces are:

- `xmovim(reg,value)` and `xmov(dst,src)` for 64-bit immediate and register moves.
- `xload(dst,base,disp)`, `xstore(base,disp,src)`, and `xlea(dst,base,disp)` for
  memory operations. Displacements are signed 32-bit values and always occupy
  four bytes, including zero. RSP and R12 bases receive the required SIB byte.
- `xloadb` and `xstoreb` have the same argument order as their word counterparts.
  A byte load zero-extends to 64 bits. `xmovzx(dst,src)` zero-extends a low-byte
  register.
- `xbin(kind,dst,src)` uses kinds 0 through 6 for add, or, and, subtract, xor,
  compare, and test. `xmul(dst,src)` emits the two-register signed multiply.
- `xunary(kind,reg)` uses 0 for not, 1 for negate, and 2 for signed divide.
  Division uses RDX:RAX; `xcqo()` sign-extends RAX into that pair.
- `xshift(kind,reg,count)` and `xshiftc(kind,reg)` use 0 for left shift, 1 for
  logical right shift, and 2 for arithmetic right shift. The latter takes its
  count from CL. Immediate counts are bytes, 0 through 255; processor masking
  applies. These are instruction encodings, not a choice of B shift semantics.
- `xstack(kind,reg)` uses 0 for push and 1 for pop.
- `xjump(kind,reg)` emits an indirect call (0) or jump (1). `xrel(kind,disp)`
  emits their relative forms. Relative displacements are signed 32-bit values
  measured from the end of the instruction.
- `xjcc(condition,disp)` and `xset(condition,reg)` use the processor's condition
  codes 0 through 15: overflow, not-overflow, below, above-or-equal, equal,
  not-equal, below-or-equal, above, sign, not-sign, parity, not-parity, less,
  greater-or-equal, less-or-equal, greater.
- `xret()` emits a near return and `xsys()` emits a syscall instruction.

The library does not resolve labels, allocate registers, impose a calling
convention, or validate runtime memory addresses. Indexed and RIP-relative
addressing, floating-point/vector instructions, and assembly-text parsing are
not implemented. The eventual compiler backend must supply those pieces it
needs and enforce its language semantics above these machine operations.

Encoding rules were checked against AMD's Architecture Programmer's Manual,
Volume 3, revision 3.36, especially the REX and operand-addressing sections
([manufacturer manual mirror](https://www.scs.stanford.edu/~zyedidia/docs/x86/amd-manual-v3.pdf)).
The [GNU assembler's encoding selectors](https://www.sourceware.org/binutils/docs-2.35/as/i386_002dMnemonics.html)
let the independent test oracle request the same fixed-width forms.

```sh
python3 bootstrap/native/test_x64.py
python3 bootstrap/native/test_x64.py --close-faults
```

Tests compare register combinations, displacement boundaries, byte-register
forms, conditions, shifts, and branches with the reference assembler. Separate
fixtures use the B encoder and B ELF writer to build executables that exercise
arithmetic, memory, calls, conditions, stack operations, and Linux syscalls.
The assembler is used only for the comparison, not to construct those fixtures.

## Code labels

`labels.b` adds two-pass numeric label resolution to `x64.b`. Concatenate both
files with the emitter's source. Labels range from 0 through 4095; label zero
and a label at byte offset zero are both valid. Different labels may name the
same offset.

For each pass, open a fresh output, call `xstart(fd)`, then `xlblbeg(pass)`.
Emit the program, call `xlblend()`, and finish with `xfinish()`. Pass 1 records
label positions and writes placeholder branch displacements. Discard that
output. Pass 2 emits the resolved instructions. Only a successful second-pass
output is a candidate for the ELF writer.

- `xmark(id)` defines a label at the current byte offset.
- `xbranch(kind,id)` emits a relative call (0) or jump (1).
- `xcond(condition,id)` emits a conditional jump using the encoder's condition
  numbers. Calls and jumps occupy five bytes; conditional jumps occupy six.

Forward and backward references use the same interface. Undefined or duplicate
labels, invalid pass ordering, changed label positions, and a changed total
size are errors. After finishing both passes, another pass 1 starts a fresh
layout and clears the old labels. As with the instruction encoder, discard
output after any error.

The emitter must supply the same program in both passes. These checks validate
its layout, not every instruction or operand: changing an instruction without
changing its size may not be detected. There is no branch shortening, named
symbol table, data relocation, register allocator, or B calling convention in
this module. It is not a source-language compiler or a general linker.

```sh
python3 bootstrap/native/test_labels.py
```

The checks compare forward and backward branch bytes, use every condition code
and all 4,096 label IDs, reject inconsistent layouts, and reuse the resolver
for a second program. Linux x86-64 checks also execute a forward call, a backward
loop, and a jump across more than one output-buffer block. Construction uses
the B encoder and ELF writer with an empty tool-search path. `native-test`
runs these checks through the host seed and all three B bootstrap stages.
