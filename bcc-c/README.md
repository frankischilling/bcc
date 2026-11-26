# bcc: C-source host compiler

This directory contains the maintained C implementation. The compiler emits C
and uses the host toolchain to produce executables. Its default output is
`../bcc`; keeping that executable at the repository root lets it find the
shared runtime in `../lib/`.

From the repository root:

```sh
make
make test
make test-install
./bcc --strict --pedantic --word=16 examples/hello.b -o hello
```

| File | Responsibility |
| --- | --- |
| `main.c` | Command line, input files, output, toolchain invocation |
| `lexer.c` | Tokens, literals and B escapes |
| `parser.c` | Expressions, declarations and statements |
| `sem.c` | Names and semantic checks |
| `emitter.c` | C output, storage and function cells |
| `runtime_cache.c` | Shared runtime object cache |
| `arena.c`, `util.c`, `bcc.h` | Allocation, helpers and compiler data structures |

See the [architecture guide](../docs/architecture.md), [CLI reference](../docs/cli.md)
and [host runtime](../lib/README.md). The same host regression suite also runs
against [bccasm](../bccasm/README.md). The [B-written compiler](../bcc-b/README.md)
uses this compiler as its seed.
