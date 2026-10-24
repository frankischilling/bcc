# B-written bootstrap compiler

`src/bbc.b` is a compiler written in B. The host `bcc` builds stage 1;
stage 1 builds stage 2; stage 2 builds stage 3.

```sh
make
make -C bootstrap test
```

The tests run expression and lexical conformance cases through all three
stages, execute accepted programs, reject selected invalid syntax, and
compare the C emitted by all three stages. Matching output is a bootstrap
fixed-point check, not proof that the compiler implements every B rule.
The bootstrap compiler currently targets the host C runtime and does not
replace the separate native PDP-11 compiler.

When invoked by its build-tree path, `bbc` finds the runtime relative to
that path. If you move the executable or launch it through `PATH`, supply
the runtime directory explicitly:

```sh
/path/to/bbc --libdir /path/to/bcc/lib program.b -o program
```

Input, output, library, and extra compiler arguments are quoted for the
runtime's shell-free command parser. Spaces and apostrophes in paths are
supported; shell expansion and redirection are not performed.

`-S` prints generated C. `--emit-c` writes it beside each input without
compiling. `--strict --pedantic` selects the bootstrap compiler's stricter
syntax checks. Token and AST dumps are not implemented here.

Character constants must contain at least one character. Strict mode allows
one or two; compatibility mode allows up to four. Unfinished constants fail
compilation rather than producing a partial value.

External vectors allocate the larger of the declared size and initializer
count. The tests compile size assertions as well as running programs, so
extra allocation and truncated initializer lists cannot pass unnoticed.
The C backends reserve a backing word for an empty vector, but it has no
usable elements.

## Remaining differences

Computed branches use function-local label values, including forward
references. The bootstrap compiler still uses host-sized, byte-addressed
storage rather than the host compiler's 16-bit address translation. Function-valued calls are covered, but mutable
function-name storage and complete block-scope resolution still need work.
Those are separate from the generated-C fixed-point check.
