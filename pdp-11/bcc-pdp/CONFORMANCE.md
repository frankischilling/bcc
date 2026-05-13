# bcc-pdp ↔ kbman 1972 Conformance Matrix

This file maps each section of Ken Thompson's **Users' Reference to B**
(Bell Labs Technical Memorandum, January 7, 1972 - "kbman") to its status
in `bcc-pdp`.  Source: <https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html>

Status legend:

- ✔ - implemented per spec
- ✚ - implemented with documented deviation (see notes)
- ⚠ - implementation differs from manual but observable behavior matches
- ✗ - not implemented (none, currently)

## §1–2  Introduction & Canonical Syntax

✔ Full BNF in `src/bstmt.c` and `src/bexpr.c`.
✔ Reserved keywords: `auto extrn case if else while switch goto return` (9 only;
the strict 1972 set).
✔ All operators per §2 grammar.

## §3  Rvalues and Lvalues

✔ rvalues are 16-bit words.
✚ Lvalues are **byte addresses**, not word addresses (kbman §12 specifies
word-addressed; this compiler is byte-addressed.  Faster.  See
[README.md](README.md) Deviations.).

## §4  Expression Evaluation

| § | Topic | Status |
|---|---|---|
| 4.1 | Primary | ✔ name, decimal/octal const, char `'c'`/`'cc'`, string, `(...)`, `v[i]`, `f(...)` |
| 4.2 | Unary `-` `!` `*` `&` `++` `--` | ✔ - `~` removed (not in kbman) |
| 4.3 | Multiplicative `*` `/` `%` | ✔ via runtime `.mul .div .mod` |
| 4.4 | Additive `+` `-` | ✔ |
| 4.5 | Shift `<<` `>>` | ✔ via runtime `.shl .shr` |
| 4.6 | Relational `<` `<=` `>` `>=` | ✔ |
| 4.7 | Equality `==` `!=` | ✔ |
| 4.8 | AND `&` (dual logical+bitwise) | ✔ - `&&` removed |
| 4.9 | OR `|` (dual logical+bitwise) | ✔ - `||` removed |
| 4.10 | Conditional `?:` | ✔ |
| 4.11 | All 16 compound assigns | ✔ - `=^` removed (not in kbman binary set) |

## §5  Statements

| § | Statement | Status |
|---|---|---|
| 5.1 | compound `{...}` | ✔ |
| 5.2 | `if (rvalue) stmt [else stmt]` | ✔ |
| 5.3 | `while (rvalue) stmt` | ✔ |
| 5.4 | `switch rvalue stmt` + `case constant:` | ✔ - no parens around rvalue, fall-through (no `break`).  Linear `cmp/beq` dispatcher; max 32 cases per switch (kbman diagnostic `>c` on overflow). |
| 5.5 | `goto rvalue;` | ✔ - bare label name → direct `jmp Lname`; otherwise eval rvalue → `jmp (r0)`.  Label as rvalue: `mov $Lid, r0`. |
| 5.6 | `return [(rvalue)];` | ✔ - bare `return` returns 0 |
| 5.7 | rvalue statement | ✔ |
| 5.8 | null `;` | ✔ |

Post-1972 extensions (`break`, `continue`, `~`, `^`, `=^`, `&&`, `||`,
and `auto v[n]`) require `-x`; strict mode rejects them.

## V1 Deployment Limits

Unix V1 gives each process 16 KB of address space.  The installed compiler
therefore runs as `b00 -> b01 -> b1`, and each binary is checked for both
`text + data <= 16384` and `text + data + bss <= 16384`.

Current installed budgets:

| Binary | Role | Current total |
|---|---|---:|
| `b00` | lex + parse + raw IC | 15304 bytes |
| `b01` | symbols + IC resolution | 10474 bytes |
| `b1` | assembly emitter | 12504 bytes |
| `b` | driver | 2016 bytes |

## §6  Declarations

✔ `auto NAME [const]` - scalar or historical vector autos (`auto v 3`).
Vector slot holds pointer
to data area, initialized at function entry by the resolved `vi` IC record.
✔ `extrn NAME, ...` - register external reference.
✔ Internal labels: `name :` declares; first reference to undeclared name
in expression context creates an implicit C_EXTRN.

## §7  External Definitions

| § | Form | Status |
|---|---|---|
| 7.1 | `name {ival, ival, ...} ;` | ✔ - no `=` between name and ivals (matches kbman) |
| 7.2 | `name [size] {ival, ival, ...} ;` | ✔ - ivals can be constants OR names (address-of) |
| 7.3 | `name(args) stmt` | ✔ |

`ival` accepts a constant or a name; a name initializer emits `.word _name`
(byte address of the named external) at the data slot.

## §8  Library Functions

All kbman §8 functions are provided.  Two implementation files:

| Function | File | Notes |
|---|---|---|
| `char(s, i)` | `runtime/brt.s` | byte-addressed: `s` is byte addr |
| `lchar(s, i, c)` | `runtime/brt.s` | |
| `chdir`, `chmod`, `chown` | `runtime/brt.s` | V1 syscalls 12, 15, 16 |
| `close` | `runtime/brt.s` | V1 syscall 6 |
| `creat` | `runtime/brt.s` | V1 syscall 8 |
| `ctime` | `runtime/brt.s` | not a V1 syscall - stub zero-fills 16-byte buf |
| `execl`, `execv` | `runtime/brt.s` | V1 syscall 11 (exec) |
| `exit` | `runtime/brt.s` | V1 syscall 1 |
| `fork` | `runtime/brt.s` | V1 syscall 2 |
| `fstat` | `runtime/brt.s` | V1 syscall 28 |
| `getchar`, `putchar`, `putstr` | `runtime/brt.s` | via `read`/`write` |
| `getstr` | `runtime/libb.b` | line-based read into byte string |
| `getuid` | `runtime/brt.s` | V1 syscall 24 |
| `gtty` | `runtime/brt.s` | V1 syscall 21 |
| `link`, `unlink` | `runtime/brt.s` | V1 syscalls 9, 10 |
| `mkdir` (called `makdir`) | `runtime/brt.s` | V1 syscall 14 (super-user only on early V1) |
| `open`, `read`, `write` | `runtime/brt.s` | V1 syscalls 5, 3, 4 |
| `printf` | `runtime/libb.b` | kbman §9.3 adapted for byte ptrs |
| `printn` | `runtime/libb.b` | kbman §9.1 verbatim |
| `seek` | `runtime/brt.s` | V1 syscall 19 |
| `setuid` | `runtime/brt.s` | V1 syscall 23 |
| `stat` | `runtime/brt.s` | V1 syscall 18 |
| `stty` | `runtime/brt.s` | V1 syscall 20 |
| `time` | `runtime/brt.s` | V1 syscall 13 |
| `wait` | `runtime/brt.s` | V1 syscall 7 |

Predefined `argv[]` (kbman §8 last paragraph): 32-word vector populated by
`runtime/bmain.s` from the V1 kernel argument frame.  `argv[0] = argc`,
`argv[1..argv[0]]` are byte-address pointers to argument strings.

## §9  Examples

✔ `examples/printn.b` - kbman §9.1 verbatim
✔ `examples/e.b` - kbman §9.2 (scaled to 200 digits - full 4000 takes
  > an hour under apout)
✔ `examples/printfdemo.b` - exercises kbman §9.3 printf

## §12  Implementation

⚠ Direct PDP-11 codegen, not threaded code.
- kbman §12 describes a threaded-code interpreter (`r3 = PC`, `r4 = display`,
  `r5 = stack`).  This compiler emits direct calls and arithmetic instead;
  faster (2-5×), no interpreter loop, but produces larger code.
- Lvalues are byte addresses (kbman §12 uses word addresses `asr` shift).

## §13  Nasties

The kbman "nasties" list documents bugs in the original implementation.
This compiler avoids all of them:

1. ✔ All operator combinations parse correctly.
2. ✔ Single-pass IC dispatch handles every record type.
3. ✔ All 16 compound assigns (`=&`, `===`, `=!=`, `=<=`, `=<`, `=>=`, `=>`,
   `=/`) implemented - kbman noted these as `bilib` gaps.
4. ✔ External vector init by name works (`emitg → cggvn → .word _name`).
5. ✔ Names like `byte`, `endif`, `even`, `globl` are still avoidable;
   we recommend not using them as B identifiers.

## Reference

- [Ken Thompson, *Users' Reference to B*, January 7, 1972](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
- Mirror of the same: <https://www.bell-labs.com/usr/dmr/www/kbman.html> (defunct)
- [README.md](README.md) - build, test, deployment
- [examples/README.md](examples/README.md) - example walkthrough
