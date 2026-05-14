# bccasm Bootstrap

This directory bootstraps a fresh `bccasm` from the assembly sources under
`../generated/` plus the assembly runtime in `../runtime.s`.

Run:

```sh
make -C asm/bootstrap bootstrap
```

Outputs:

- `stage1/bccasm` - freshly assembled and linked compiler
- `stage1/lib/runtime.o` - freshly assembled runtime used by generated programs
- `stage1/lib/libb.h` - symlink to the shared runtime ABI header

The `bootstrap` target validates the stage compiler by running `../check.sh`
with `BCC` pointed at `stage1/bccasm`.
