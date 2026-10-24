# Assembly-source compiler

`bccasm` builds the host compiler from checked-in x86-64 GNU assembler
sources. It has the same command-line interface as `bcc`; it is not a
separate B dialect or a PDP-11 compiler.

```sh
make -C asm
make -C asm check
make -C asm bootstrap
```

The last command assembles a fresh staged executable and runs the host
suite against it. This is a staged assembly build, not B self-hosting.
The B-written compiler and its three-stage check live in `../bootstrap/`.

## Keeping the snapshots current

The maintained compiler sources are in `../src/`. After changing them, run:

```sh
make -C asm regenerate
```

`regenerate.py` uses GCC to emit GNU assembler source. Its manifest records
the compiler version, flags, and source/output hashes. Normal builds check
those hashes and fail if the snapshots are stale. They assemble with `as`
and link with the host C toolchain. Regeneration requires an x86-64 GCC
host; these are not portable assembly sources or NASM input.

B programs use the same C runtime as the main compiler. The build places
`libb.c`, `libb.h`, `btarget.h`, `binit.h`, `bunix.h`, and `bformat.h` beside the executable so shared-runtime
compilation works in every supported word mode. The older handwritten
`runtime.s` is retained as historical project material but is not linked:
it does not implement the current translated-address ABI.

`--asm` emits a program's host assembly through the C backend. Assemble and
link that output with the host compiler, including `-ldl -lm`. It does not
emit PDP-11 assembly.
