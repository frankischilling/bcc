# B-maintained target instruction templates

These B sources emit the PDP-11 startup and primitive-runtime assembly used
by the native image writer:

```text
rtgen [-s marker] startup-output primitive-output
```

`startup.b` contains entry and argument-storage templates. `prims.b` contains
the existing target instruction sequences for arithmetic, character handling,
and system-call adapters. `io.b` writes them in checked 256-byte blocks.
The optional marker is written after both output files close successfully.

This removes the need to read separate startup or primitive `.s` files when
regenerating the toolchain after its seed. It does not make those instruction
sequences portable B algorithms. The target-specific templates remain explicit
backend code; the ordinary B library is rebuilt from `runtime/libb.b` through
the compiler instead.

The emitted files are compared byte-for-byte with the native seed's versions.
The image writer then turns the selected assembly into a native executable
without calling an external assembler or image converter.

Template strings use B's asterisk escapes. Backslashes needed by the assembler
syntax remain literal bytes. Tests compare the complete emitted files, not
just whether they can be assembled.
