# Historical conformance references

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
Both the shared and inline runtimes are exercised; cross-file pointer tests
use the shared runtime.

The C99 compiler translates 16-bit B addresses through registered host
storage. It keeps host-sized storage cells and relies on GNU-compatible C
extensions. This does not reproduce an original process image, threaded
object code, or the Unix V1 syscall ABI. The host exec wrappers now accept the counted vector and explicit arg0
from section 8, converting packed B strings before calling libc. Runtime
time, stat, and terminal interfaces still need separate ABI conformance work. The 32-bit mode
is arithmetic emulation with native pointers; arithmetic on those pointers
can still truncate them. Function values can be called through variables and expressions; mutable
function-name cells are not yet a complete implementation of section 7.3.
The B-written bootstrap now shares the tested expression and lexical rules,
but computed label values and 16-bit storage are still missing there.
The separate native PDP-11 compiler retains its
documented byte addresses and placeholder date formatter.


[kbman]: https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html
[kbscan]: https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.pdf
[btut]: https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.pdf
[man71]: https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man71.pdf
[setup]: https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist/setup.pdf
[aap]: https://github.com/aap/b
[aaph]: https://github.com/aap/b/blob/master/b.h
[aapc]: https://github.com/aap/b/blob/master/b.c
[aapv1]: https://github.com/aap/b/blob/master/unix1_bdir/README
