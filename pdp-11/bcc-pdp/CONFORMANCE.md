# bcc-pdp ↔ kbman 1972 Conformance Matrix

This file maps each section of Ken Thompson's **Users' Reference to B**
(Bell Labs Technical Memorandum, January 7, 1972 - "kbman") to its status
in `bcc-pdp`.  Source: <https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html>

Status legend:

- ✔ - implemented per spec
- ✚ - implemented with documented deviation (see notes)
- ⚠ - implementation differs from manual but observable behavior matches
- ✗ - not implemented

## §1–2  Introduction & Canonical Syntax

The parser lives in `src/bstmt.c` and `src/bexpr.c`. It does not yet cover
the full grammar: declarations are restricted to the beginning of a braced
function body, and string constants are not accepted as external initializers.
✔ Reserved keywords: `auto extrn case if else while switch goto return` (9 only;
the strict 1972 set).
✔ All operators per §2 grammar.

## §3  Rvalues and Lvalues

✔ rvalues are 16-bit words.
✚ Lvalues are **byte addresses**, not word addresses (kbman §12 specifies
word-addressed; this compiler is byte-addressed. See
[README.md](README.md) Deviations.).

## §4  Expression Evaluation

| § | Topic | Status |
|---|---|---|
| 4.1 | Primary | ✔ names, numeric/character/string constants, parentheses, indexing, and general function-valued calls |
| 4.2 | Unary `-` `!` `*` `&` `++` `--` | ✔ - `~` removed (not in kbman) |
| 4.3 | Multiplicative `*` `/` `%` | ✔ via runtime `.mul .div .mod` |
| 4.4 | Additive `+` `-` | ✔ |
| 4.5 | Shift `<<` `>>` | ✔ via runtime `.shl .shr` |
| 4.6 | Relational `<` `<=` `>` `>=` | ✔ |
| 4.7 | Equality `==` `!=` | ✔ |
| 4.8 | AND `&` (bitwise) | ✔ - `&&` removed |
| 4.9 | OR `|` (bitwise) | ✔ - `||` removed |
| 4.10 | Conditional `?:` | ✔ |
| 4.11 | All 15 B72 compound assigns | ✔ - `=^` removed (not in kbman binary set) |

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

Measured `text + data + bss` for the current sources:

| Binary | Role | Current total |
|---|---|---:|
| `b00` | lex + parse + raw IC | 15758 bytes |
| `b01` | symbols + IC resolution | 9626 bytes |
| `b1` | assembly emitter | 15726 bytes |
| `b` | driver | 4082 bytes |

These totals exclude the argument frame and runtime stack. Passing the binary
size check does not establish that every input or recursion depth fits.

## §6  Declarations

✚ Scalar and historical vector autos (`auto v 3`) work at the start of a
braced function body. Numeric and character-valued extents are accepted.
Vector slots hold mutable pointers, for both automatic and external vectors.
Indexing a scalar or parameter loads its pointer value before selecting an element.
The pointer still uses byte units, so this does not resolve the §12 deviation.
Vector slot holds pointer
to data area, initialized at function entry by the resolved `vi` IC record.
✚ `extrn NAME, ...` registers an external reference in the same declaration prefix.
✔ Internal labels: `name :` declares; first reference to undeclared name
in expression context creates a forward label reference. Labels are scoped
to their function; unresolved and duplicate definitions are rejected.

## §7  External Definitions

| § | Form | Status |
|---|---|---|
| 7.1 | `name {ival, ival, ...} ;` | ✚ contiguous cells; numeric/character values and external addresses, but no string initializers |
| 7.2 | `name [size] {ival, ival, ...} ;` | ✚ numeric/character values and external addresses; no string initializers |
| 7.3 | `name(args) stmt` | ✚ ordinary statement bodies work; declaration statements still require the braced prefix |

A name initializer emits the mapped assembler symbol (the byte address of
the named external) at the data slot. Unlike the manual, the native parser
currently rejects string initializers such as `message "hello";`.

Function names are mutable cells initialized to code addresses. Taking `&f`
addresses the cell; reading `f` obtains its current function value. This also
applies to native runtime functions. Tests replace `putchar`, call `printn`,
and verify that its calls use the replacement, then restore the saved value.

## §8  Library Functions

The runtime exposes the documented function names, but a wrapper name alone
does not establish ABI compatibility. The implementation is split between
assembly syscall wrappers and B library functions:

| Function | File | Notes |
|---|---|---|
| `char(s, i)` | `runtime/brt.s` | byte-addressed: `s` is byte addr |
| `lchar(s, i, c)` | `runtime/brt.s` | |
| `chdir`, `chmod`, `chown` | `runtime/brt.s` | V1 syscalls 12, 15, 16 |
| `close` | `runtime/brt.s` | V1 syscall 6 |
| `creat` | `runtime/brt.s` | V1 syscall 8 |
| `ctime` | `runtime/libb.b` | Converts high-word-first 60 Hz time since 1971 into 15 date characters plus NUL; tested at word/day/year boundaries and leap day |
| `execl`, `execv` | `runtime/brt.s` | Counted vectors/explicit arg0; B strings converted to Unix termination before syscall 11 |
| `exit` | `runtime/brt.s` | V1 syscall 1 |
| `fork` | `runtime/brt.s` | V1 syscall 2 |
| `fstat` | `runtime/brt.s` | V1 syscall 28 |
| `getchar`, `putchar`, `putstr` | `runtime/brt.s` | via `read`/`write` |
| `getstr` | `runtime/libb.b` | line-based read into byte string |
| `getuid` | `runtime/brt.s` | V1 syscall 24 |
| `gtty` | `runtime/brt.s` | V1 syscall 32 |
| `link`, `unlink` | `runtime/brt.s` | V1 syscalls 9, 10 |
| `mkdir` (called `makdir`) | `runtime/brt.s` | V1 syscall 14 (super-user only on early V1) |
| `open`, `read`, `write` | `runtime/brt.s` | V1 syscalls 5, 3, 4 |
| `printf` | `runtime/libb.b` | kbman §9.3 adapted for byte ptrs |
| `printn` | `runtime/libb.b` | based on §9.1, with negative-number/base-16 extensions |
| `seek` | `runtime/brt.s` | V1 syscall 19 |
| `setuid` | `runtime/brt.s` | V1 syscall 23 |
| `stat` | `runtime/brt.s` | V1 syscall 18 |
| `stty` | `runtime/brt.s` | V1 syscall 31 |
| `time` | `runtime/brt.s` | V1 syscall 13; high/low words read from AC/MQ |
| `wait` | `runtime/brt.s` | V1 syscall 7 |

Predefined `argv[]` (kbman §8 last paragraph): a pointer cell and a 32-word vector populated by
`runtime/bmain.s` from the V1 kernel argument frame.  `argv[0] = argc`,
`argv[1..argv[0]]` are byte-address pointers to argument strings.
The program name occupies `argv[1]`; user arguments start at `argv[2]`.
At most 31 string pointers fit, and the count reports only stored entries.
Strings retain the kernel's NUL terminator. The fixed capacity is a limit,
not full reproduction of the historical argument vector. For compatibility,
optional `main(count, values)` parameters exclude the program name.

## §9  Examples

✔ `examples/printn.b` - kbman §9.1 verbatim
✔ `examples/e.b` - kbman §9.2 (scaled to 200 digits - full 4000 takes
  > an hour under apout)
✔ `examples/printfdemo.b` - exercises kbman §9.3 printf

## §12  Implementation

⚠ Direct PDP-11 codegen, not threaded code.
- kbman §12 describes a threaded-code interpreter (`r3 = PC`, `r4 = display`,
  `r5 = stack`).  This compiler emits direct calls and arithmetic instead;
  there is no interpreter loop. No comparative speed claim is made here.
- Lvalues are byte addresses (kbman §12 uses word addresses `asr` shift).

## §13  Nasties

The kbman "nasties" list documents bugs in the original implementation.
The implementation addresses several of them:

1. Regression tests cover the supported operators; they do not prove that
   every combination parses correctly.
2. The IC dispatcher checks record lengths and rejects unknown records.
3. ✔ All 15 B72 compound assigns (`=&`, `===`, `=!=`, `=<=`, `=<`, `=>=`, `=>`,
   `=/`) implemented - kbman noted these as `bilib` gaps.
4. ✔ External vector init by name works (`emitg → cggvn`).
5. External symbols are prefixed or mapped to private names, rather than
   passed directly to the assembler as directive names. Eight-character
   names and case distinctions are preserved within a source file.

## Reference

- [Ken Thompson, *Users' Reference to B*, January 7, 1972](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
- Mirror of the same: <https://www.bell-labs.com/usr/dmr/www/kbman.html> (defunct)
- [README.md](README.md) - build, test, deployment
- [examples/README.md](examples/README.md) - example walkthrough

## Validation limits

The fast runner uses an unchanged-text compatibility container to observe
results that the pinned apout 0405 mode discards. Full-system tests remain
separate and cover real V1 files, processes, tty state, and time registers.
See [the test guide](../../docs/testing.md). The native compiler still needs
work on word-addressed pointers, declaration-statement grammar, string-valued
external initializers, and cross-file linkage for mapped external names. Table
entries above describe implemented paths, not a claim of complete conformance.
