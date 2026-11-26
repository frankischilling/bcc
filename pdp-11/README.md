# PDP-11 BCC

The maintained native compiler is in [`bcc-pdp/`](bcc-pdp/README.md).
It runs in the restored Unix V1 environment pinned by the `unix-v1`
submodule and emits native PDP-11/20 code. This is a separate compiler,
not a `--pdp11-v1` mode of the host C99 compiler.

Three early-C passes parse B, resolve names, and emit assembler input.
The native driver assembles that output with BCC's bundled startup and
runtime. It does not link against the original threaded B `libb.a`.
See [runtime notes](NOTES_RUNTIME.md), [assembly notes](NOTES_ASSEMBLY.md),
and the [conformance matrix](bcc-pdp/CONFORMANCE.md).

## Build and check

From the repository root:

```sh
git submodule update --init --recursive pdp-11/unix-v1
make -C pdp-11/bcc-pdp
bash pdp-11/bcc-pdp/tests/run/run.sh
```

The native compiler README describes the additional dependencies and commands
for full-system tests. Fast application-emulator tests and tests inside the
restored kernel are separate checks, with different limitations.

## Bootstrap boundary

The current self-host test rebuilds the C-written compiler and driver using
the restored C toolchain inside Unix V1. It also rebuilds the B-written part
of the runtime. It does not rebuild a compiler written in B.

The next bootstrap goal is a native B-written compiler that runs and rebuilds
on the PDP-11. That requires a native B implementation, its runtime, and an
executable-output path independent of the seed C compiler. It is separate
from the host `bcc`, `bccasm`, and `bootstrap/` work. Neither goal is complete
merely because generated C or assembler text reaches a fixed point.

## Historical sources

The [source review](../wiki/SOURCE_REVIEW.md) distinguishes January 1972
PDP-11 B, November 1971 Unix, later Unix editions, and reconstructed systems.
The files in [`unix-v1-docs/`](unix-v1-docs/README.md) include scans and
working transcriptions; they are not all verified primary-source text.
