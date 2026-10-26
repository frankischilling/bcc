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
replace the separate native PDP-11 compiler. See the
[B-native bootstrap goals](../wiki/BOOTSTRAP.md) for the remaining dependencies
and the checks needed for a self-contained rebuild.

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
compiling. Strict mode rejects names longer than eight characters; ordinary
compatibility mode keeps long names. `--strict --pedantic` selects the
bootstrap compiler's stricter syntax checks. Token and AST dumps are not implemented here.

Strict external declarations are checked per function and must precede use.
Top-level definitions no longer bypass `extrn`, and declarations cannot turn
a parameter, automatic variable, or label into an external. The compiler
checks a limit of 2,048 external names per function. Bare calls retain the
existing implicit-external compatibility rule.

Strict declaration prefixes bind to the following statement. Automatic cells
are emitted at function entry, with vector pointer initialization left at each
declaration. This preserves function-wide storage through nested blocks and
allows declarations in unbraced bodies. Compatibility mode retains C-style
block declarations.

Decimal and octal literals wrap to the host word width. The minimum signed
word is emitted as a valid C expression rather than negating an unrepresentable
positive magnitude. Tests include that boundary in local expressions, global
initializers, and vectors through the B stages. This is the host storage model,
not a claim that historical machines used 64-bit words.

Character constants must contain at least one character. Strict mode allows
one or two; compatibility mode allows up to four. Unfinished constants fail
compilation rather than producing a partial value. Failed source reads are
reported separately from end of file; an unreadable input must not become an
empty or truncated translation unit. Generated-output writes and file closes
are checked too. Diagnostics go to standard error, even when standard output
or the generated C file cannot be written.

External vectors allocate the larger of the declared size and initializer
count. The tests compile size assertions as well as running programs, so
extra allocation and truncated initializer lists cannot pass unnoticed.
The C backends reserve a backing word for an empty vector, but it has no
usable elements.

The predefined `argv` vector and the `argv(i)` compatibility call use their
respective count-prefixed and zero-based layouts. External name initializers
refer to addresses, not the current contents of those variables. Tests cover
both scalar and vector initializers, including the predefined argument cell.

The compiler scans the project's definitions before lowering each input.
C-keyword names are kept distinct from ordinary B names. Its statement
parser handles function bodies during that scan too, including
unbraced and labeled bodies. External data is stored as cell arrays, so a
simple definition with several initializers is accessible through `&name`.

Checked limits are 1,024 functions and 2,048 external data names per project,
256 input files, and 256 extra compiler options. Exceeding them produces a
diagnostic before a table write. The tests exercise each limit's rejection.

## Remaining differences

Computed branches use writable function-local label cells, including forward
references. Their contents persist across invocations. Source-defined functions, external data, parameters, and automatic names
use private C names to avoid collisions with host library declarations. Strict mode uses word-addressed pointers; compatibility mode keeps
byte-addressed pointers. Storage is still host-sized rather than the host
compiler's translated 16-bit model. Source-function cells are writable and
preserve saved callable values, including across input files. Runtime-owned
library functions use the same writable-cell interface. Compatibility
block-scope resolution still needs work.
These limits are separate from the generated-C fixed-point check.


## Host-native backend work

The experimental [ELF image writer](native/README.md) is written in B. It
packages existing x86-64 instruction bytes and data without calling an
assembler or linker. It does not yet turn B source into native instructions;
the bootstrap compiler above still emits C.
