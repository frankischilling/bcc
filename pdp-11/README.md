# PDP-11 / Unix V1 B Compiler Plan

Goal: Ship a B compiler written in C that runs on Unix V1 (PDP-11), emits PDP-11 assembly consumable by `as`, and links with `ld -lb` against the system `libb.a`. Keep the existing gcc/libc toolchain for modern hosts intact; this is an additional backend/target.

Pipeline (on V1):
1) `.b` source → (our C compiler) → PDP-11 assembly (Unix V1 `as` syntax)
2) `as program.s`
3) `ld -lb a.out` (plus any extra objects)

Key constraints:
- Target: Unix V1, PDP-11, 16-bit words, word-addressed pointers, strings terminated with 004 (`*e`).
- Tooling available: `/bin/cc`, `/bin/as`, `/bin/ld`, `/usr/lib/libb.a`.
- No libc dependencies beyond what V1 `cc` provides; code should be K&R-friendly and small.
- Rely on system `libb.a` for runtime; only add minimal builtins if strictly needed.

Implementation outline:
- Front-end: Thompson B lexer/parser in C (K&R style), supporting classic tokens (`=+`, `=-`, etc.), `*e` strings, multi-char constants.
- No preprocessor → lines starting with # (like #define) blow up.
- No struct (in the earlier compiler) → struct token { ... } can’t parse.
- Pointer declarations aren’t written with * yet → you must declare pointers in the old “array-style”: char s[];, int argv[];, etc.
- Codegen: Emit V1 `as` syntax. Use r5 as frame pointer, jsr pc for calls, callee-save as needed (r2–r5). Data sections for globals and strings.
- Output: Assembly only; leave assembling/linking to `as`/`ld`.
- Integration: Add a `--pdp11-v1` (or similar) flag on the host compiler to emit V1 assembly, or provide a standalone C source (`pdp11/bcc_v1.c`) that can be built directly on V1.

Next steps:
- Define assembly templates (prologue/epilogue, label naming, string emission).
- Implement lexer/parser skeleton in C (V1-compatible).
- Wire minimal expr/stmt codegen to prove hello-world and simple loops.
- Add tiny test B programs under `pdp11/tests/` to exercise I/O and arithmetic.
