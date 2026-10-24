# Historical conformance references

For reviewed primary-source findings, dialect distinctions, and access limits,
see the [historical source review](SOURCE_REVIEW.md).

The target dialect is Ken Thompson's *Users' Reference to B*, dated January 7,
1972, for the PDP-11. Use the [edited text][kbman] alongside the [original
scan][kbscan] when OCR or punctuation is ambiguous. The other sources below
describe different environments or implementation history.

## Language rules to test

| Area | Reference | Required behavior |
| --- | --- | --- |
| Multiplication assignment | Section 4.11 | Adjacent `=*` multiplies and assigns. A separator between `=` and `*` makes assignment of an indirect value. |
| Word values and addresses | Sections 3 and 12 | PDP-11 values have 16 bits; the implementation uses word addresses. Address arithmetic must preserve a valid address through addition of zero. |
| Character escapes | Section 2.2 | `*(` produces `{`; `*)` produces `}`. Test character constants and strings. |
| Computed branches | Sections 2 and 5.5 | `goto` accepts an expression yielding a label in the current function. Test labels stored in variables and selected by a conditional. |
| Strict syntax | Sections 2 and 6.2 | Automatic vectors use `auto v 3;`. `break`, `continue`, and switch defaults have no statement productions in this dialect. |
| Operator precedence | Sections 4.4 and 4.5 | Addition binds more tightly than shifting: `1 << 2 + 1` yields 8. |

These rules come from the [PDP-11 reference][kbman]. Its sections 4.3 and 4.5
leave some negative division, remainder, and out-of-range shift behavior
undefined. Keep implementation choices for those cases separate from
conformance requirements. Section 4.1 leaves function argument evaluation
order unspecified.

## Other primary sources

[Kernighan's tutorial][btut] describes H6070/MH-TSS B, as its introduction
states. Section 26, printed page 12, includes `break` and `default`; section
25 also uses a bracketed automatic vector. These constructs are historical B
features in that environment. Describe them as extensions to the chosen
PDP-11 dialect rather than claiming that they were never part of B. Its
section 28 describes TSS I/O units, so it is not a substitute for Unix system
call documentation.

The README's [November 1971 manual link][man71] is a section VII excerpt.
The `/etc/bc` and `/etc/ba` entries describe the compiler and assembly phases.
The `/etc/bilib` entry, PDF page 4, lists missing compound assignments under
BUGS. Reproducing those missing operations would reproduce a documented
implementation defect, rather than implement the language reference.

[Setting Up UNIX][setup] is a distribution installation document. Its first
page covers tape and disk bootstrapping; its time-conversion section explains
site configuration of `ctime.c`. It provides environment and deployment
context, not a B grammar or a specification for B expressions.

## Comparing with aap/b

[aap/b][aap] supplies a separate reconstruction and useful executable
comparison material. Its README distinguishes the C bootstrap compiler,
the B compiler, and the Unix v1 reconstruction. Its
[`b.h` operator table][aaph] separates addition from shifts and includes
`=*`; [`b.c`][aapc] parses computed branches and both automatic-vector
spellings. That compiler also accepts `break` and `default`.

Select the matching dialect before comparing results. In particular, the C
bootstrap compiler's `mapch()` maps `*e` to NUL and does not implement the
PDP-11 brace escape mappings. Its behavior cannot decide those conformance
tests. The [Unix v1 notes][aapv1] also distinguish restored runtime files
from a deliberately invented compact interpreter representation.

## Validation scope

A useful conformance test has an expected result derived from a cited rule,
then compiles and runs the program. Comparing two compilers can expose a
difference, but the reference must decide whether that difference is a bug.
Record the dialect, word mode, pointer model, and source section with each
historical test. Keep language behavior, runtime compatibility, and exact
historical object-code reproduction as separate claims.

## Implemented checks and remaining limits

See [the testing guide](../docs/testing.md) for host, assembly-source,
B-written bootstrap, and native PDP-11 commands. Host assembly output is
compiled through the C backend, then assembled and executed by the tests.
Function-valued variables, vector entries, conditional callees, and B EOF
handling are also checked.


`make test` runs the existing suite and `tests/test_b72_conformance.py`.
The added cases exercise operator adjacency, brace and quote escapes, embedded zero bytes, shift
precedence, ordered bitwise evaluation, label values and function scope,
strict extension handling, 16-bit address arithmetic, two-byte character
packing, packed file I/O, recursion, heap reuse, and cross-file pointers.
Both the shared and inline runtimes are exercised, including cross-file
pointer arguments.

The C99 compiler translates 16-bit B addresses through registered host
storage. It keeps host-sized storage cells and relies on GNU-compatible C
extensions. This does not reproduce an original process image, threaded
object code, or the Unix V1 syscall ABI. The host exec wrappers now accept the counted vector and explicit arg0
from section 8, converting packed B strings before calling libc. Host status calls now fill the V1 field layout rather than copying a host
structure. Disk addresses are unavailable and creation time uses host status-
change time; these approximations are documented in the runtime guide. Terminal
interfaces still need separate ABI conformance work. The 32-bit mode
is arithmetic emulation with native pointers; arithmetic on those pointers
can still truncate them. Source-defined and runtime-owned function names have
writable cells. Calls read their current values, while saved function values
retain the original bodies. Address-based changes and cross-file references
are tested. B definitions can replace library names such as `printn` and
`printf`, as the manual's examples do. Formatting and line-input callbacks
follow those definitions, including separately compiled providers. Private
syscall and byte-marshalling helpers remain internal. Source functions receive
contiguous copies of all supplied arguments, so a routine can walk beyond its
last named parameter as the manual's `printf` example does.
The B-written bootstrap now shares the tested expression and lexical rules,
including computed label values and writable source-function cells. Its strict mode now uses word-addressed
pointers, while compatibility mode keeps byte addresses. It still lacks
16-bit storage.
The native compiler now loads pointer values before indexing scalar and
parameter expressions, and gives external vectors mutable pointer cells.
It resolves forward label values within their function and diagnoses missing
or duplicate labels before assembly. Native function names and runtime
functions now have mutable cells, and calls accept general function-valued
expressions. Tests cover saved values, address-based replacement, nested calls,
and library interposition. Native external initializers also accept writable strings, including empty
strings and embedded NULs. Regressions check stable storage for repeated
evaluation of one literal and separate storage for equal literals in
different source locations. The C emitter no longer merges those writable
objects by content. Native data pointers now use word addresses as in section
12, with byte conversion at memory and syscall boundaries. Argument strings
are copied into word-aligned storage. Function and label values retain their
code-entry representation.

The manual's example 9.2 ends with a packed pair of newlines passed to
`putchar`. Character constants use high-byte-first numeric packing, and
`putchar` emits both bytes when the high byte is nonzero. This differs from
little-endian string storage. Tests compare exact bytes, including NULs,
across host, inline, bootstrap, and native runtimes.

Section 7.1's multiple initializers form contiguous cells starting at the
name's address; the name itself reads the first cell. The host and bootstrap
backends now preserve that distinction from section 7.2's vector pointer.
Tests cover cross-file and cyclic address initializers, both file orders,
mutations, and string-valued cells. Automatic vector extents use element
counts too, not an extra element beyond the stated size.

The predefined `argv` vector keeps its count in element zero and the program
name in element one. Its strings retain native NUL termination. Host
`argv(i)` and optional main parameters are compatibility interfaces with a
separate zero-based array; native main parameters retain their documented
user-argument-only layout. Tests cover empty strings, cross-file access,
shadowing, mutation, and the address of the predefined vector cell.

The host clock and both date formatters use the [V1 time representation][v1time]:
32 bits of 60 Hz ticks since January 1, 1971, high word first. `ctime(time,date)`
writes 15 characters and a NUL into the caller's 16-byte buffer, without a
newline. The 32-bit clock wraps after roughly 2.27 years, as the original
manual warns; it cannot represent today's full calendar date. Tests cover
word/day/year boundaries, the 1972 leap day, the maximum tick value, and
guard bytes beyond the output buffer.


[kbman]: https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html
[kbscan]: https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.pdf
[btut]: https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.pdf
[man71]: https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man71.pdf
[setup]: https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist/setup.pdf
[aap]: https://github.com/aap/b
[aaph]: https://github.com/aap/b/blob/master/b.h
[aapc]: https://github.com/aap/b/blob/master/b.c
[aapv1]: https://github.com/aap/b/blob/master/unix1_bdir/README

[v1time]: https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man2/time.2

## Native runtime and validation

The native wrappers now use inline syscall argument words, convert B path
and exec strings to Unix termination, and implement the counted exec vector.
The fork wrapper follows the parent/child return-instruction convention;
time reads AC/MQ, and tty wrappers use the restored kernel's syscall table.
Signed division and remainder use the same documented truncation choice as
the host implementation, and printing handles the most-negative word.

The fast emulator is not sufficient evidence for V1 syscall behavior. Its
raw 0405 mode discards exit results, fork/wait PID handling is incomplete,
and tty calls are stubs. The test runner's compatibility container exposes
results without changing B instruction/data bytes; real-kernel tests check
the corresponding behavior in a booted system. The image workflow also
reserves the kernel's swap blocks before allocating compiler scratch files.

Declaration statements are checked against the canonical grammar and section 6.
Strict host/bootstrap mode and the native compiler bind each declaration
prefix to its following statement and reserve automatic storage for the
function invocation. Tests cover late vectors, loop and conditional bodies,
nested-block visibility, dangling `else`, and malformed declaration lists.

The native executable header is checked against the [November 1971 a.out
format](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man5/a.out.5). The driver
and host-side test converter emit stripped files with the correct field
positions and text length. A V2 symbol-table length is not a V1 data-area
length; copying it there had caused a real execution failure.

## Formatting and documentation checks

The shared and inline host runtimes use one formatting implementation.
Strict mode follows section 9.3's signed octal, four conversions, and unknown-
conversion fallback; compatibility formatting remains a separate interface.
No argument is fetched for an unknown conversion. Strict string output and
the native runtime preserve embedded NUL bytes until 004. Tests cover signed
minimum values and the selected word width; extra printn bases remain
explicit extensions beyond section 9.1.

Strict parsers reject unparenthesized value returns, top-level auto, and
equals-style external initializers. Bare returns no longer generate invalid
C return statements. A host bare-return value of zero is an implementation
choice, not a historical guarantee. Strict mode is still not a proof that
every accepted program belongs to the exact historical grammar.

The wiki's complete examples carry executable checks. This replaces earlier
claims of nested functions, closures, guaranteed left-to-right argument
evaluation, and C-style automatic initialization. Tests establish the stated
examples, not complete historical equivalence.

Internal label storage now follows section 6.3 across the three backends:
cells are function-local, writable, and retained between invocations. Tests
exercise their addresses and both bare and computed branches after mutation.
The host library also exposes the section 8 spelling `mkdir`; `makdir` remains
an alias. The bootstrap accepts the historical zero-argument `exit()` call
and separates source-defined function and data symbols from host C declarations.

Strict host identifiers are isolated from C headers: B functions and data
can use names such as `select` and `FILE`, and locals can use `errno` or
`word`. Tests cover same-file and cross-file definitions, saved function
values, and source-defined functions named `malloc` or `strlen`. The bootstrap
uses private names for locals and parameters as well as external bindings.
Host compatibility mode retains its older naming/interop rules and does not
have the same complete identifier isolation.

## Date-specific library names

The November 1971 `/etc/libb.a` entry, page 15 of the [section VII excerpt][man71],
lists `getchr`, `putchr`, `makdir`, and `intr`. January 1972's section 8 uses
`getchar`, `putchar`, and `mkdir` and does not list `intr`. Preserve these
version distinctions; calling the earlier names modern additions is wrong.
A table of names alone does not establish their exact calling or byte-output
semantics. The reconstruction's source filenames can also differ from the
symbols they export, so check the actual declarations rather than inferring
an API from a filename.

Ritchie's [introduction to CSTR 8](https://cm-bell-labs.github.io/who/dmr/bintro.html)
identifies the January 1973 report as the Honeywell 6070/MH-TSS description.
Johnson's [reference](https://cm-bell-labs.github.io/who/dmr/bref.html) includes
features outside the selected PDP-11 grammar, including `~`, `^`, and switch
`default`. It is comparison evidence for other B dialects, not a reason to
silently change the January 1972 strict mode.

Native program definitions take precedence over bundled library cells. This
allows source routines such as the manual's `printn` and `printf` examples
to coexist with the runtime instead of failing with duplicate assembler
symbols. Matching runtime labels are removed before assembly, while their
unused bodies remain. That is not a reproduction of the original archive
loader or its exact output size.
