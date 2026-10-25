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
