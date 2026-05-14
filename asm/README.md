# bccasm

`bccasm` is an assembly-source build of the full BCC compiler.

The files under `generated/` are x86-64 assembly lowered from the current
compiler implementation. The resulting binary is linked from assembly objects,
not from C compiler objects, and preserves the existing BCC CLI and behavior.

Generated B programs link against `asm/lib/runtime.o`, an assembly runtime
object. The runtime header is linked from `../lib/libb.h` so generated C keeps
the same ABI contract. The assembly runtime exports the public `libb.h` runtime
surface, including core I/O, files, strings, printing, process/time wrappers,
terminal wrappers, `callf`/`B_CALLF_LIB` dynamic lookup, word helpers, and
assignment helpers.

Build:

```sh
make -C asm
```

Verify:

```sh
make -C asm check
```

Bootstrap a fresh staged compiler:

```sh
make -C asm bootstrap
```

The build assembles `.s` sources with `as` and links the compiler executable
with `gcc` for the host process startup and system libraries. Runtime allocation,
process execution, `system`, sleep, time, and file operations are implemented
with Linux syscalls; `ctime`, signal registration, and dynamic symbol loading use
the platform C/dynamic-loader ABI because those are library facilities rather
than raw B operations.

Smoke test:

```sh
./asm/bccasm tests/run/exit_42.b -o /tmp/exit_42
/tmp/exit_42
```
