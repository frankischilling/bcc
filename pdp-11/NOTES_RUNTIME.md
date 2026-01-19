# Runtime and Linking Notes (Unix V1)

Target runtime strategy:
- Prefer the system `libb.a` on Unix V1; avoid shipping our own runtime unless needed.
- Use `ld -lb` to link against `libb.a`. Keep emitted symbols compatible.
- Keep our compiler self-contained in C; minimize libc dependencies (V1 `cc` is minimal).

If additional builtins are required (TODO):
- Provide tiny wrappers in B or assembly for any builtins not in `libb.a`.
- Keep them minimal and callable via standard PDP-11 calling conventions.

Link flow on V1:
1) `cc bcc_v1.c` -> compiler `a.out`
2) `./a.out prog.b > prog.s`
3) `as prog.s`
4) `ld -lb a.out` (plus extra objects if needed)
