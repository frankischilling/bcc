# Staged assembly-source build

This target assembles and links the checked-in x86-64 GNU assembly snapshots
under `../generated/` into a fresh compiler. It checks their recorded source
and output hashes before building.

```sh
make -C asm/bootstrap bootstrap
```

The result is `stage1/bccasm`. Its `stage1/lib/` directory contains copies of
the shared host runtime sources: `libb.c`, `libb.h`, `btarget.h`, `binit.h`,
`bunix.h`, and `bformat.h`. Compiling a B program still uses GCC and that C
runtime; this target does not build a separate handwritten assembly runtime.

The `bootstrap` target runs `../check.sh` with the new compiler. This is a
staged assembly-source build, not B-language self-compilation. For the
compiler written in B and its three-stage fixed-point check, see
[`../../bootstrap/`](../../bootstrap/README.md).
