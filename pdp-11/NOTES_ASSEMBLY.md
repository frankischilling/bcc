# Unix V1 `as` / PDP-11 Assembly Notes (Stub)

This is a scratchpad for the assembly dialect we need to emit.

Assumptions (to verify):
- Prologue/epilogue: use `jsr pc, func`, r5 as frame pointer, stack grows down.
- Registers: r0/r1 temps; r2–r5 callee-saved; pc, sp, r5 (fp).
- Data: `.text`, `.data`, labels as bare symbols; word constants via `.word`; bytes via `.byte`.
- Strings: bytes with a trailing 004 terminator (B `*e`); align as needed.
- Calls: `jsr pc, name`; return via `rts pc`.
- a.out: V1 format (header TBD); linking handled by `ld -lb`.

To decide/confirm:
- Exact `as` syntax for directives and labels on V1.
- Stack frame layout for parameters/locals.
- How `cc` on V1 passes args to functions; mirror that for generated calls.
- Any quirks in relocation or symbol naming.
