# B-written build driver

This experimental PDP-11 driver runs the B frontend, resolver, code generator,
runtime selector, and native image writer. It forks the execution engine for
each pass, prepares a fresh heap file, and requires a completion marker before
starting the next pass. It does not invoke a C compiler, assembler, `sed`, or
Python between passes.

It is not installed as `/bin/b`. The normal native compiler remains the C
seed, and the host compiler still emits C. The driver currently expects its
tools and scratch files in a caller-owned working directory.

## Prepare a seed

From the repository root on the development host:

```sh
make -C pdp-11/bcc-pdp
python3 pdp-11/bcc-pdp/bootstrap/tools/build_toolchain.py /tmp/b-toolchain
python3 pdp-11/bcc-pdp/bootstrap/test_toolchain.py
```

Choose a directory that does not exist. Seed construction uses the native
C-written passes, the independent Python instruction encoder, the historical
assembler, and the image converter. That is an initial seed, not a B-only
build. `seed.json` records the revision, dirty-worktree status, source hashes,
seed-tool hashes, native-image hashes, and instruction-image sizes.

The directory includes self-contained B sources for every component. The
`seed.json` manifest stays on the development host; it is not a guest tool.
The builder checks that sources, raw records, resolved records, and instruction
images fit the guest's 65,535-byte file-size field. Native
`engine` and `driver` files use the Unix V1 executable format; they are not
Linux executables. The test harness uses observation copies under the native
application emulator, leaving constructed executable bytes unchanged.

## Commands inside Unix V1

After staging the toolchain in a private guest working directory:

```sh
./driver -r
./driver -b
./driver input.b result
./result
```

`-r` regenerates `bmain.s` and `brt.s` from B-maintained target instruction
templates. `-b` compiles `libb.b` into `libb.s`, including its separate label
namespace. Both commands deliberately replace their generated runtime files.
The primitive templates remain PDP-11-specific instructions, not a portable
high-level B runtime implementation.

Other output modes take an input and a new output filename:

- `-v` builds a paged instruction image for the execution engine.
- `-s` emits native program assembly.
- `-l` emits raw library assembly, without a program-end label.
- `-L` emits bundled-library assembly with a separate internal label namespace.

For example, `./driver -v bf.b fron.new` rebuilds the frontend instruction
image from its B source. Running arbitrary instruction images directly still
requires the engine's caller-owned heap-file protocol. The build driver
prepares that file for its own compiler passes.

## Ownership and limits

Use a directory dedicated to this toolchain. The driver replaces `heap.vm`,
`raw.ic`, `code.ic`, `prog.s`, `selrt.s`, `sellib.s`, and `done`. These names and
the tool filenames cannot be used as ordinary source or output arguments.
Ordinary outputs must not already exist. Generated files can remain after a
failed build; a missing completion marker prevents the next pass from running.

Path aliases and concurrent builds are not supported. Use short filenames
that fit the guest filesystem's eight-character components. Child arguments
have a 128-byte, word-aligned storage budget to leave space for the engine's
native stack. This driver is not a filesystem or process sandbox.

The optional long check rebuilds all seven instruction images and the native
engine and driver from B, comparing each result with the seed:

```sh
python3 pdp-11/bcc-pdp/bootstrap/test_toolchain.py --self-test
```

This check runs under the application emulator. A complete in-guest source
bootstrap must be verified separately; successfully compiling a program in
the guest does not prove that all toolchain sources rebuild there.
