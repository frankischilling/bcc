# bcc-pdp ↔ kbman 1972 Conformance Matrix

This file maps each section of Ken Thompson's **Users' Reference to B**
(Bell Labs Technical Memorandum, January 7, 1972 - "kbman") to its status
in `bcc-pdp`.  Source: <https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html>

Status legend:

- ✔ - implemented path; see test coverage and limits
- ✚ - implemented with documented deviation (see notes)
- ⚠ - implementation differs from manual but observable behavior matches
- ✗ - not implemented

## §1–2  Introduction & Canonical Syntax

The parser lives in `src/bstmt.c` and `src/bexpr.c`. Declaration prefixes
bind to the following statement, including unbraced function, conditional,
and loop bodies. Automatic names remain local to their function invocation.
✔ Reserved keywords: `auto extrn case if else while switch goto return` (9 only;
the strict 1972 set).
✔ All operators per §2 grammar.

## §3  Rvalues and Lvalues

✔ rvalues are 16-bit words.
✔ Data lvalues use word addresses. Loads, stores, character access, and
syscall wrappers translate to machine byte addresses where needed.

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
| 5.4 | `switch rvalue stmt` + `case constant:` | ✔ - parentheses optional, fall-through (no `break`).  Forward-linked comparison nodes and range-safe jumps; max 32 cases per switch (kbman diagnostic `>c` on overflow). |
| 5.5 | `goto rvalue;` | ✔ Reads the target value and jumps indirectly, including bare named labels. Internal label cells are writable and persist across invocations. |
| 5.6 | `return [(rvalue)];` | ✔ - bare `return` returns 0 |
| 5.7 | rvalue statement | ✔ |
| 5.8 | null `;` | ✔ |

Post-1972 extensions (`break`, `continue`, `~`, `^`, `=^`, `&&`, `||`,
and `auto v[n]`) require `-x`; strict mode rejects them.

## V1 Deployment Limits

The restored Unix V1 test configuration reserves 16 KiB for each process.  The installed compiler
therefore runs as `b00 -> b01 -> b1`, and each binary is checked for both
`text + data <= 16384` and `text + data + bss <= 16384`. The checked
build additionally reserves at least 512 bytes for the parser's arguments
and stack, and 256 bytes for each other compiler process.

Read the current binary sizes from the build rather than a frozen table:

```sh
bash pdp-11/bcc-pdp/tests/check_v1_binaries.sh
```

These totals exclude the argument frame and runtime stack. Passing the binary
size check does not establish that every input or recursion depth fits.
The parser checks its stack against the end of linked storage and reserves
128 bytes for reporting exhaustion. A test derives the expected boundary
from the native executable header, so new storage cannot silently bypass
the guard. Deep expressions, unary chains, and blocks are tested in the
real kernel; the fast observer gives programs a larger stack.

Switch cases are emitted as they arrive rather than sharing one global case
table. Matching dispatch removes the saved selector before entering the
body. Fall-through, computed branches into a body, and branches out of nested
switches therefore leave the runtime stack balanced. All compiler passes
must be rebuilt together after the internal-record change.

## §6  Declarations

✔ Scalar and historical vector autos (`auto v 3`) work in declaration
statements. Numeric and character-valued extents are accepted.
Vector slots hold mutable pointers, for both automatic and external vectors.
Indexing a scalar or parameter loads its pointer value before selecting an element.
A vector slot holds a pointer to its data area. The resolved `vi` record
initializes it where the declaration is executed. The stack frame reserves
space for every automatic before the body runs, including late declarations.
✔ `extrn NAME, ...` registers external references in declaration statements.
✔ Internal labels: `name :` declares; first reference to undeclared name
in expression context creates a forward label reference. Labels are scoped
to their function; unresolved and duplicate definitions are rejected.

## §7  External Definitions

| § | Form | Status |
|---|---|---|
| 7.1 | `name {ival, ival, ...} ;` | ✔ contiguous cells; numeric, character, and string constants or external addresses |
| 7.2 | `name [size] {ival, ival, ...} ;` | ✔ numeric, character, and string constants or external addresses |
| 7.3 | `name(args) stmt` | ✔ includes declaration-prefixed bodies |

A name initializer emits the word address of the named external cell. String initializers hold the address
of writable, B-terminated byte storage. Empty strings and embedded NULs
are preserved. Tests interleave strings with numeric cells and definitions
with function bodies, so literal emission cannot break contiguous storage.

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
| `char(s, i)` | `runtime/brt.s` | `s` is a word address; `i` is a byte index |
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
| `printf` | `runtime/libb.b` | Argument traversal uses word-addressed cells |
| `printn` | `runtime/libb.b` | based on §9.1, with negative-number/base-16 extensions |
| `seek` | `runtime/brt.s` | V1 syscall 19 |
| `setuid` | `runtime/brt.s` | V1 syscall 23 |
| `stat` | `runtime/brt.s` | V1 syscall 18 |
| `stty` | `runtime/brt.s` | V1 syscall 31 |
| `time` | `runtime/brt.s` | V1 syscall 13; high/low words read from AC/MQ |
| `wait` | `runtime/brt.s` | V1 syscall 7 |

Predefined `argv[]` (kbman §8 last paragraph): a writable pointer cell and a stack-allocated vector populated by
`runtime/bmain.s` from the V1 kernel argument frame.  `argv[0] = argc`,
`argv[1..argv[0]]` are word-address pointers to aligned copies of argument strings.
The program name occupies `argv[1]`; user arguments start at `argv[2]`.
All arguments supplied by the kernel are retained; startup checks vector and
string storage against the program boundary instead of truncating the count.
Strings retain the kernel's NUL terminator. Kernel exec limits and available
process memory still constrain the total. For compatibility,
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
- Data lvalues use the section 12 word-address model. Opaque function and
  label values identify code entries.

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
work on cross-file linkage for mapped external names. Table
entries above describe implemented paths, not a claim of complete conformance.

Internal label cells are emitted after the function epilogue and initialized
to their code-entry values. Taking a label's address yields a word pointer
to its cell; loading, replacing, and indirect branching use that storage.
The label-cell regression checks saved values, address-based writes, bare
and parenthesized goto, and changes retained by later calls.

Program definitions now take precedence over bundled library cells during
assembly. Regressions define `putchar`, `printn`, and `printf`, check calls
from retained library routines, and use library names for external data.
Both the host runner and the native driver select matching public labels.
When the program references none of `printn`, `printf`, `getstr`, or `ctime`,
the driver and fast runner omit the whole B-written library. References,
address constants, and source definitions of those names all retain it;
ambiguous long assembly lines retain it too. Primitive exec routines and their private buffers are also omitted when
neither the program nor the retained library names them. The process/metadata group is selected the same way, including references
from retained library code. Shared core pathname helpers remain linked. This is not general archive loading or per-function dead-code
removal: retained library bodies keep their layout.

## Direct reads

The emitter combines adjacent local, parameter, or external address records
and dereferences into a single PDP-11 `mov`. Address values still use B word
units. A label, another record, or end of input flushes a pending address;
the emitter does not move a memory read across those boundaries. Saved
function values are still read before their arguments are evaluated.

The focused checks cover direct reads, saved addresses, overwritten values,
consecutive addresses, and double indirection. The native execution suite
and the in-system compiler rebuild also check the resulting code.

## Output completion

A compiler pass writes its completion marker only after its output file
closes successfully. If the marker's own close fails, the pass removes it.
The driver also rejects a failed close of the converted executable instead
of installing it as `a.out`.

The early C library returns 0 or 1 from `close`; the B runtime returns 0 or
-1. The callers check the appropriate convention. Fault-injection tests
cover the three C passes, the host-built B resolver in three word models,
the driver's selected runtime files, and its final image. These checks complement the kernel rebuild;
the kernel test does not simulate storage failures.

## Character return values

`lchar` writes the low byte and returns the original character word, matching
BCC's host runtime and the tutorial's string-copy convention. The PDP-11
reference lists the store but does not specify a return value. Regression
checks cover 004-terminated copying and values whose stored byte differs
from the returned word; they do not attribute this stronger BCC contract to
the historical PDP-11 manual.

## Zero-filled storage

The native emitter reserves zero-filled globals with bounded location-counter
advances rather than printing one zero word per line. The allocation and
loadable bytes are unchanged. The checks compare compact output with its
expanded word-by-word form, including partially initialized vectors, and
verify chunking for the full signed IC field range.

This also reduces the historical assembler's temporary token file. One
larger VM experiment produced 66,560 bytes of tokens, beyond the restored
kernel's 16-bit file-position range. Compact reservations reduced that file
to 62,464 bytes and allowed the same 14,592-byte program to build in the
kernel. This is not an increase in process memory or a new general linker.

The emitter also writes `010046` as an octal instruction word for the common
`mov r0,-(sp)` stack push. This reduces assembler tokens without changing
the machine instruction. Tests expand those words back into mnemonics and
compare the complete loadable images for calls, recursion, arithmetic,
vector accesses, and assignment.
