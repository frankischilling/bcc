# bcc-pdp

A B compiler for **PDP-11 Unix 1st Edition** (1972), written in V1 C and
running natively under V1.  Strict conformance to Ken Thompson's
**Users' Reference to B** (Bell Labs Technical Memorandum, 1972-01-07,
known as "kbman").  See [CONFORMANCE.md](CONFORMANCE.md) for the
section-by-section status matrix.

Three PDP-11 a.out passes -- `b00` (lex + parse, emits raw intermediate
code), `b01` (symbol classification and IC resolution), and `b1` (reads
resolved IC, emits V1 `as`) -- keep each compiler process inside V1's
16 KB address-space budget.  They are built by V1 `cc` (the 1972 last1120c
compiler) running under [apout](../unix-v1/tools/apout) on the host.
No gcc anywhere in the pipeline.  Inside SIMH they self-host from
`/usr/src/bcc/`.

- Target CPU: PDP-11/20 (no EIS -- software muldiv in `runtime/brt.s`).
- Calling convention: args pushed left-to-right, return in R0, R5 frame.
- Emits V1 `as` syntax; links with `as bmain.s brt.s prog.s`.

## Build

```sh
make            # apout-V1-cc compiles src/*.c -> build/b00 + build/b01 + build/b1
```

The build does:

1.  `tools/build-apout-root.sh` materializes `build/aroot/`, a unified
    V1 filesystem (merges `fs/root` + `fs/usr` + `crt0.o`).
2.  Sources for each binary are staged into `build/aroot/`, then
    `apout build/aroot/bin/cc *.c` runs the actual 1972 cc binary on
    them, producing PDP-11 `a.out` binaries under `build/`.

## Compile + run a B program

```sh
make test-run B=tests/run/t01_hello.b
# -> hello
```

`tools/run-apout.sh` does:

1.  Run `build/b00` under apout to compile the `.b` to raw `prog.ic`.
2.  Run `build/b01` under apout to resolve symbols into `prog.r2`.
3.  Run `build/b1` under apout to translate `prog.r2` to `prog.s`.
4.  Assemble `bmain.s + brt.s + prog.s` with V1 `as` (also under apout).
5.  Execute the resulting `a.out` under apout.

Run the canonical test suite:

```sh
tests/run/run.sh
tests/ext/run.sh      # opt-in -x extension mode
# PASS t01_hello
# PASS t02_arith
# PASS t03_loop
# PASS t04_if
# PASS t05_vec
```

## Install into SIMH V1

```sh
tools/install_v1.sh           # both scripts live in bcc-pdp/tools/
tools/rebuild_v1.sh           # repack ../unix-v1/build/rk0.dsk / rf0.dsk
cd ../unix-v1 && make run     # boot SIMH
```

`install_v1.sh` drops:

| Host path                               | Inside V1               |
|------------------------------------------|--------------------------|
| `build/b00`                              | `/bin/b00` (`rf0:bin/`)  |
| `build/b01`                              | `/bin/b01`               |
| `build/b1`                               | `/bin/b1`                |
| `build/b`                                | `/bin/b`  (driver)       |
| `runtime/bmain.s`, `runtime/brt.s`       | `/usr/lib/`  (`rk0:lib/`)|
| `src/*.c`                                | `/usr/src/bcc/`          |
| `examples/*.b`                           | `/usr/src/bcc/examples/` |

V1 mounts two disks: `rf0` (root, `/`) and `rk0` (`/usr`).  Binaries live
on root; runtime stubs and self-host sources live on usr -- mirroring
how V1's own `cc` (`/bin/cc`) + `c0` / `c1` (`/usr/lib/c0`, `c1`) are
laid out.

After booting SIMH, log in as `root` (no password) and run:

```
# b prog.b
# ./a.out
```

Or run the same loop non-interactively from the host:

```sh
make v1-run B=tests/run/t01_hello.b
```

That command stages `B` into the V1 root filesystem as `v1.b`, installs the current
`b00`/`b01`/`b1`/`b` binaries, rebuilds the disk images, boots SIMH, logs in as
root, runs `b ./v1.b`, then runs `./a.out`.

`/bin/b` is a small V1-C program that fork+exec's `/bin/b00`, `/bin/b01`,
`/bin/b1`, then `/bin/as`, leaving the linked `a.out` in the current directory.
V1's shell predates `$n` parameter expansion in scripts, so `b` must be
a compiled binary, not a shell script.

Self-host (rebuild all three binaries inside V1):

```
# cd /usr/src/bcc
# cc b00drv.c bstmt.c bexpr.c blex.c bemit0.c butil.c
# mv a.out /bin/b00
# cc b01drv.c blex1.c bsym.c butil.c
# mv a.out /bin/b01
# cc b1drv.c bcg.c bcgnew.c blex1.c blit.c butil.c
# mv a.out /bin/b1
# cc bdrv.c
# mv a.out /bin/b
```

## V1 C dialect quirks the source navigates

| Constraint                  | Workaround used in source            |
|-----------------------------|---------------------------------------|
| No preprocessor             | No `#include` / `#define`; token codes inline |
| No `void`                   | All fns implicit `int`                |
| No `struct`                 | Parallel arrays (`snam[]`/`scls[]`/`soff[]`) |
| No `*p` pointer declarators | `int p[]` / `char p[]` only           |
| No `**` in K&R param decl   | `main(argc, argv) int argv[]`         |
| No `_` in identifiers       | camelCase / no-sep (e.g. `symfnd`)    |
| Linker symbols 7-char max   | C identifiers <=6 chars where shared  |
| No `for` loop               | Hand-written `while`                  |
| `+=` rejected; `=+` OK      | Explicit `i = i + 1`                  |
| `||` rejected               | Nested `if` / range checks            |
| Bare `&& fn()` rejected     | Stash in var first                    |
| Locals inside blocks reject | Declare all locals at function start  |
| Negative global init        | Init to 0, set in startup fn          |
| Global `int` / `char` decl  | B-style `name initval;` / `arr[size];` |
| Octal default (`42.` for dec) | Already match V1 `as` emit style     |

## Layout

```
src/                      compiler + driver -- V1-clean C files
  b00drv.c                b00 driver, argv, file IO
  b01drv.c                b01 resolver, symbol classification
  b1drv.c                 b1 driver, IC dispatch loop
  bstmt.c                 statement parser, function defs (b00)
  bexpr.c                 expression parser (b00)
  blex.c                  lexer (b00)
  blex1.c                 IC-record mini-scanner (b01/b1)
  bsym.c                  symbol table (b01)
  bemit0.c                cg primitive stubs -> raw IC records (b00)
  bcg.c                   codegen primitives -> V1 as (b1)
  blit.c                  streaming string-literal emit (b1)
  butil.c                 outc/outs/outd, fatal, label counter
  bdrv.c                  /bin/b -- fork/exec b00 + b01 + b1 + as
runtime/
  bmain.s                 crt0 -- argc/argv to _main + populate _argv[]
  brt.s                   .mul / .div / .mod / .shl / .shr / .xor +
                          char/lchar + 23 V1 syscall wrappers
  libb.b                  printn, printf, getstr in B (kbman §9.1, §9.3)
  libb.s                  ^^ compiled by build/b00 + build/b01 + build/b1
tests/run/                .b end-to-end tests + expected stdout
tools/
  build-apout-root.sh     stage unified V1 root for apout cc
  run-apout.sh            compile + assemble + run under apout
  install_v1.sh           drop binaries into pdp-11/unix-v1/fs/{root,usr}/
  rebuild_v1.sh           repack rk0.dsk / rf0.dsk after install
build/
  aroot/                  apout filesystem root
  b00                     lex + parse pass (V1 a.out)
  b01                     symbol resolver pass (V1 a.out)
  b1                      assembly emitter pass (V1 a.out)
  b                       driver (V1 a.out)
```

## Intermediate Code

Text, one record per line.  `b00` emits raw IC, `b01` consumes declaration
and reference records (`A*`, `R*`) and emits resolved IC for `b1`.

| Tag    | Args                | Meaning                                |
|--------|---------------------|----------------------------------------|
| `n`    | n                   | const -> R0                            |
| `ps`   |                     | push R0                                |
| `bin`  | op                  | non-compare binop (+, -, *, /, ...)    |
| `binc` | op lfa lend         | compare binop (==, !=, <, >, <=, >=)   |
| `cl`   | name nargs          | call                                   |
| `pr`   | name nloc retl      | prologue (retl = return label)         |
| `ep`   |                     | epilogue                               |
| `rt`   |                     | return jump                            |
| `lc`   | off                 | local addr                             |
| `ar`   | off                 | arg addr                               |
| `dr`   |                     | deref R0                               |
| `as`   |                     | assign  (`*TOS = R0`)                  |
| `bf`   | l                   | branch-on-false                        |
| `jm`   | l                   | jump                                   |
| `lb`   | l                   | label def                              |
| `ex`   | name                | extern addr                            |
| `Slit` | len bytes...        | streamed string literal                |
| `uo`   | op                  | non-! unary (`-`, `~`)                 |
| `uon`  | l1 l2               | logical `!`                            |
| `ao`   | isand l             | `&&` / `||` begin (isand=1 for `&&`)   |
| `aoe`  | l                   | `&&` / `||` end                        |
| `tq`   | l                   | ternary `?` begin                      |
| `tc`   | lel le              | ternary `:` middle                     |
| `te`   | le                  | ternary end                            |
| `ix`   |                     | index (`TOS + 2*R0`)                   |
| `ca`   | op                  | compound assign (`*TOS OP= R0`)        |
| `cac`  | op lfa lend         | compound assign with compare op        |
| `po`   | isinc               | post-inc/dec                           |
| `pi`   | isinc               | pre-inc/dec                            |
| `vi`   | slot dataoff        | vector-auto pointer init               |
| `gw`   | name value          | (legacy) scalar word defn              |
| `ga`   | name n ni values... | (legacy) vector defn (constants only)  |
| `gvb`  | name n              | global-vector header                   |
| `gvc`  | value               | one constant word                      |
| `gvn`  | name                | one address-of-name word (kbman §7.2)  |
| `gve`  |                     | global-vector footer (`.even`)         |
| `swb`  | ldisp               | switch entry (push expr, jmp dispatch) |
| `swe`  | ldisp lpop lend nc {k l}* | switch end + dispatch chain      |
| `gor`  |                     | computed goto (`jmp (r0)`)             |
| `Adef`/`Aend` | name / none  | function boundary consumed by `b01`    |
| `Aauto`/`Aarg`/`Aextrn`/`Avec` | ... | declarations consumed by `b01` |
| `Agvec`| name                | global vector symbol marker            |
| `Rname`/`Rderef` | name / none | name reference and value coercion     |
| `Rlbl`/`Rdef` | name         | goto-label use and label definition    |
| `la`   | lid                 | address-of-label (mov $Llid, r0)      |

## Language status - strict kbman 1972 conformance

Implemented (every kbman section):

| kbman § | Feature | Status |
|---|---|---|
| 2 | Canonical syntax | ✔ |
| 3 | rvalues, lvalues (16-bit word) | ✔ |
| 4.1 | primary expressions | ✔ - names, decimal & octal constants, char `'c'`/`'cc'`, strings, parens, vectors, calls |
| 4.2 | unary `-` `!` `*` `&` `++` `--` | ✔ |
| 4.3..4.7 | multiplicative, additive, shift, relational, equality | ✔ |
| 4.8 | `&` (single, dual logical+bitwise) | ✔ |
| 4.9 | `|` (single, dual logical+bitwise) | ✔ |
| 4.10 | conditional `?:` | ✔ |
| 4.11 | all 16 compound assigns: `= =\| =& === =!= =< =<= => =>= =<< =>> =+ =- =% =* =/` | ✔ |
| 5.1 | compound `{...}` | ✔ |
| 5.2 | `if/else` | ✔ |
| 5.3 | `while` | ✔ |
| 5.4 | `switch rvalue stmt` + `case constant:` (no parens, fall-through) | ✔ |
| 5.5 | `goto rvalue;` (label name OR computed) | ✔ |
| 5.6 | `return` / `return(rvalue)` | ✔ |
| 5.7 | rvalue statement | ✔ |
| 5.8 | null statement `;` | ✔ |
| 6 | `auto`, `extrn`, internal (label) declarations | ✔ |
| 7.1 | simple defn `name ival, ival, ...;` (no `=`!) | ✔ |
| 7.2 | vector defn `name[size] ival, ival, ...;` with name initializers | ✔ |
| 7.3 | function definitions | ✔ |
| 8 | library: `char lchar putchar getchar putstr getstr printf printn open close creat read write seek exit fork wait link unlink chdir chmod chown stat fstat setuid getuid time stty gtty execl execv mkdir ctime` + predefined `argv` vector | ✔ |
| 9.1 | `printn(n,b)` example - works as-is | ✔ |
| 9.2 | `e` to ~200 digits - works (slow under apout) | ✔ |
| 9.3 | `printf` example - adapted (see deviations) | ✔ |

### Documented deviations from kbman

- **Pointer model is byte-addressed.**  kbman §12 specifies word-addressed
  lvalues with `asl` on every dereference (matching the threaded-code
  interpreter).  This compiler emits direct PDP-11 code with byte addresses,
  which is faster.  Affects `printf`: the manual's `adx++` to walk the
  argument frame becomes `adx = adx + 2` here.  The B-source `runtime/libb.b`
  documents the deviation inline.
- **8-character identifiers.**  V1 `as` truncates linker symbols to 7
  characters after the `_` prefix; the compiler enforces a hard 8-char
  identifier limit to preserve uniqueness.  kbman doesn't specify a limit.
- **`argv` is a 32-word vector.**  `argv[0]` is `argc`; `argv[1..argv[0]]`
  are the argument string pointers.  Excess args (>31) are truncated.
- **String terminator.**  `*e` (octal 04) per kbman §5.6.
- **Post-1972 extensions are opt-in** with `b00 -x`, `/bin/b -x`, or
  `B0FLAGS=-x tools/run-apout.sh`.  Strict mode rejects:
  `~` (bitwise NOT), `^` (XOR), `&&` (short-circuit AND), `||`
  (short-circuit OR), `=^` (compound XOR-assign), keywords `break`,
  `continue`, and bracketed auto vectors.  Use single `&`/`|` (dual
  logical+bitwise per kbman §4.8/4.9), `goto label;` instead of
  `break/continue`, and `auto v 3;` instead of `auto v[3];`.

### Library functions

Hosted in two files:

- **`runtime/brt.s`** - PDP-11 assembly: `char`, `lchar`, `putchar`,
  `getchar`, `write`, `read`, `open`, `close`, `creat`, `seek`, `exit`,
  `putstr`, `fork`, `wait`, `unlink`, `link`, `chdir`, `chmod`, `chown`,
  `stat`, `fstat`, `setuid`, `getuid`, `time`, `stty`, `gtty`, `execl`,
  `execv`, `makdir`, `ctime`, plus internal helpers `.mul .div .mod .shl .shr .xor`.
- **`runtime/libb.b`** - written in B itself, compiled by the new passes
  into `runtime/libb.s`: `printn` (kbman §9.1 verbatim), `printf` (kbman
  §9.3 adapted for byte-addressed pointers), `getstr`.

Predefined external `argv[]` lives in `runtime/bmain.s` and is populated
by `start:` from the V1 kernel's argc/argv on the stack.
