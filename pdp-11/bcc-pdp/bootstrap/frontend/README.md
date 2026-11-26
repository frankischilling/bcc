# B-written frontend

These modules parse the native compiler's B dialect and emit its unresolved
records. They are maintained B source, not files regenerated from C during
the build. `lex.b` handles tokens and packed strings; `bstmt.b` handles
declarations and statements; `bexpr.b` handles expressions; `bemit0.b` writes
records; `driver.b` handles files and options. The frontend shares the
resolver's packed-byte output routines in `src/io.b`.

The parser follows the native seed's strict mode by default. `-x` enables
its compatibility statements. Names retain eight significant characters,
integer tokens wrap to 16 bits, and source string bytes are distinct from
NUL-terminated record fields. The lexer counts a lookahead newline when it
is consumed, including after a number. In strict mode, `break`, `continue`,
and `default` can be ordinary names.

The native C frontend remains the installed compiler. This B port is an
experimental pass for the paged execution engine. It does not reproduce
the C seed's physical-stack exhaustion diagnostic. The VM enforces its own
frame bounds; host builds of this port do not have that protection. Do not
use it as an unrestricted-input replacement for the installed compiler.

From the repository root, after building the host and native seed compilers:

```sh
python3 pdp-11/bcc-pdp/bootstrap/tools/build_passes.py frontend frontend.vm
python3 pdp-11/bcc-pdp/bootstrap/tools/build_passes.py frontend frontend-host --host-bcc ./bcc
./frontend-host -o raw.ic input.b
python3 pdp-11/bcc-pdp/bootstrap/test_passes.py
```

The host executable uses the current C-based host toolchain. The `.vm` file
is an instruction image, not a PDP-11 executable. See the parent README for
pipeline checks and the remaining bootstrap dependencies.
