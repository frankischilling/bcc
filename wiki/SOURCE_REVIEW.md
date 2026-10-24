# Historical source review

BCC uses Thompson's January 7, 1972 PDP-11 B manual as its language baseline.
Other B manuals describe different machines, libraries, or later dialects. They
are useful evidence, but a feature in one of them is not automatically a
requirement for strict PDP-11 B.

This review records what was actually read, what it establishes, and how it
applies to the compiler. The inventory includes all 128 supplied links. A
successful download or OCR pass does not mean a source has been reviewed.
The review date is October 24, 2026; unfinished entries remain marked below.

## How to use the evidence

- Use the original PDP-11 manual for language rules and the contemporary Unix
  manual for the operating-system interfaces it references.
- Check an original page when OCR changes an operator, number, or grammar rule.
  Keep the corrected reading and its page reference together.
- Treat reconstructions and other compilers as comparison tools. A matching
  output is useful, but it does not overrule a primary source.
- Keep documented historical defects separate from the intended language.
  BCC does not deliberately reproduce missing operators or unchecked tables.
- Distinguish a source-language bootstrap, an assembly-source build, and a
  compiler rebuilt inside a restored operating system. They establish different
  things. A fixed point alone is not proof of historical equivalence.

## PDP-11 B: the baseline

[Thompson's manual](https://cm-bell-labs.github.io/who/dmr/kbman.html) was read
in full. The [original PDF](https://cm-bell-labs.github.io/who/dmr/kbman.pdf)
was checked on PDF pages 13-14, printed pages 11-12, for operator details.
The supplied PDF URL ended in `.pdfA`; that URL is broken.

The manual specifies 16-bit values, word addresses, EOT-terminated strings,
and one- or two-character constants. Automatic vector sizes are element
counts, not the Honeywell convention of a highest subscript. Its identifier
alphabet includes backspace, and its octal rule explicitly permits `09`.

The original pages say that `&` and `|` evaluate left to right. They also
confirm `=!=`, which the HTML assignment list mistranscribes. Evaluation
order and implicit external declarations therefore need separate checks in
the host and bootstrap emitters; C's rules are not a substitute for B's.

The library description includes counted `execv`, terminated `execl`, and
specific status, time, and terminal layouts. Its threaded implementation and
reported loader defects must not be confused with BCC's native-code backend
or treated as features to recreate.

## Honeywell B is a different target

### Kernighan's tutorial

The complete [tutorial PDF](https://cm-bell-labs.github.io/who/dmr/btut.pdf)
was read, including its supplied appendices. Appendix E is omitted in this
edition. The tutorial targets H6070 MH-TSS: 36-bit words, four nine-bit
characters per word, GMAP names, and unit-based I/O.

Its bracketed automatic vectors, `break`, `default`, and negative octal
formatting differ from the PDP-11 baseline. Its statement that octal numbers
cannot contain 8 or 9 must not replace Thompson's explicit rule. The shared
ideas are still useful: calls pass values, assigning a vector copies its
pointer rather than its elements, and spaces matter in old-style compound
assignments.

The printed `flip` example on PDF page 15 saves the wrong operand and does
not swap. That was checked visually. Examples need executable tests, not
blind transcription. The foreign-call section also requires scalar arguments
by address; BCC's pointer-based `callf` is not a Honeywell Fortran/GMAP ABI.

### Johnson's MH-TSS reference

The complete [HTML reference](https://cm-bell-labs.github.io/who/dmr/bref.html)
was read; selected sections were compared with its PDF rendition. The
transcription explicitly omits the diagnostics table.

This version distinguishes 36-bit values, 18-bit data addresses, and code
addresses in the other half of a word. It permits an implicit external name
when its first use is followed by `(`. That rule is not stated in the same
way in Thompson's PDP-11 declaration section.

The runtime uses I/O units and an MH-TSS system-command unit. `getstr` returns
the buffer; `getvec(n)` allocates `n+1` words. Those contracts do not redefine
BCC's separately documented helpers. The reference also explains argument
slots, the first two arguments arriving in registers, and `nargs`.

Its six-character external-name restrictions and context-dependent logical
operators describe that implementation. They are not portable requirements
for every B compiler. Some malformed examples and punctuation in the
transcription still require original-page checks before being used as evidence.

## November 1971 Unix tools and runtime

The complete [section VII excerpt](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man71.pdf)
and the listed individual B tool/library pages were read. They distinguish
`bc` (source to intermediate code), `ba` (intermediate code to assembler),
`bilib` (threaded operators), and `libb.a` (callable routines). `brt1` must
be loaded first and `brt2` last.

The pages explicitly say the B command is defunct and describe a command
file instead. This agrees with the script-based usage in the January manual.
The library list includes `getchr`, `putchr`, `makdir`, and `intr`; those
names have contemporary evidence, not just a modern reconstruction.

The boot-procedure pages reserve the highest 16K words of the RF disk for
standalone programs. Restored-system staging must respect reserved regions.
The remaining excerpt covers login, initialization, terminal conventions,
and other runtime libraries. It supplies environment context, not additional
B grammar.

[Mike Taylor's transcription](https://www.miketaylor.org.uk/tech/libb-a.html)
was also read. It identifies itself as a hand transcription of the 1971
library page, so it is an alternative rendition rather than an independent
language specification.

### Assembler, linker, and file formats

The complete [assembler](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man1/as.1),
[linker](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man1/ld.1),
[a.out](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man5/a.out.5), and
[archive](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man5/archive.5)
pages were read.

The assembler's punctuation, numeric labels, string syntax, and predefined
system-call names differ from DEC PAL-11R. Its output includes symbols and
relocation information; it is not a modern GNU object format.

The early executable has a six-word header beginning with octal `0405`.
The manual prints `0205` beside `br .+14`, but that number is inconsistent
with the instruction. The original scan confirms the printed typo; DEC's
[BR description](https://pdos.csail.mit.edu/6.828/2005/readings/pdp11-40.pdf#page=83)
gives opcode `0400` plus the word displacement. Skipping the twelve-byte
header requires displacement five, hence `0405`, as used by BCC's native
image writer. Its text size includes the header. Symbols occupy twelve-byte
entries, and relocation uses a variable-length bit encoding. These details
must not be replaced with the later `0407` layout by assumption.

An archive starts with octal `0177555`, uses sixteen-byte member headers,
and pads odd-sized members without changing their recorded size. The linker
loads objects in order and searches libraries for unresolved references.
BCC's native runtime-label selection is not an implementation of that archive
linker. The linker's documented fixed temporary files also explain why
concurrent restored-tool invocations need isolation.

## Related languages and historical context

### Early C compiler artifacts

Ritchie's complete [early compiler account](https://cm-bell-labs.github.io/who/dmr/primevalC.html)
was read. It dates `last1120c` and `prestruct-c` only approximately to
1972-73 and explains why tape dates can be misleading. The earlier compiler
uses PDP-11/20 arithmetic hardware and lacks several later C facilities.
It also reuses initialization-code storage for temporary work.

These artifacts explain constraints on the restored C toolchain. They do
not make BCC an original 1971 B compiler, nor do they make a successful
native self-rebuild equivalent to the B-written bootstrap.

### Accounts of B, C, and early Unix

Ritchie's complete [C development history](https://cm-bell-labs.github.io/who/dmr/chist.html)
and [Unix evolution paper](https://cm-bell-labs.github.io/who/dmr/hist.html)
were read. They describe several versions and transitions, not one frozen
language or operating-system interface.

The C history explains B's mutable vector pointers, packed strings, word
addresses, threaded execution, and later native-code experiments. It also
places increment operators before the PDP-11 port. Its retrospective examples
must still be checked against the target's contemporary manual: an account
of B generally is not a precise specification of January 1972 PDP-11 B.

The Unix account distinguishes PDP-7 word-based file I/O from PDP-11 byte
I/O, and early process and directory mechanisms from their successors.
Its explanation of shared file offsets after `fork` matters when testing
runtime wrappers. Later pipelines and C-era facilities must not be silently
attributed to the November 1971 system.

### BCPL source provenance

Ritchie's complete [1967 BCPL provenance account](https://cm-bell-labs.github.io/who/dmr/bcpl.html)
was read. It distinguishes differently typed copies, omitted examples,
edited OCR, publication notation, and the notation actually accepted by CTSS.
Those differences matter when citing a page or interpreting a symbol.

The account also distinguishes early compiler behavior from what the manual
actually specifies. Modern BCPL operators and lexical conventions must not be
projected backward onto the version from which B developed.

### Eh, November 1976

The full OCR text of [Braga's Eh Reference Manual](https://cs.uwaterloo.ca/research/tr/1976/CS-76-45.pdf)
was read. Ambiguous operator glyphs still need visual checking. This is an
Eh manual, not a missing edition of the PDP-11 B manual.

Eh changes identifier rules, uses NUL-terminated strings, reverses compound
assignment spelling, changes precedence, and defines operand evaluation
order. Its string and word `select` statements, byte indexing, interrupt
control, and inline machine statements belong to Eh. The appendix explicitly
compares these choices with B. They are useful context, not features to add
to strict BCC under the name of historical accuracy.

## Later GCOS8 manuals

### Waterloo's 1978 and 1979 reference manuals

The complete supplied OCR texts of the [September 1978 reference](https://archive.org/download/b-reference-manual/B%20Reference%20Manual_djvu.txt)
and [March 1979 version 4.0 reference](https://archive.org/download/b-reference-manual/User%27s%20Reference%20to%20B%20V4.0_djvu.txt)
were read, including diagnostics and library indexes. The OCR is damaged in
places; exact syntax and tables need scan checks before becoming test fixtures.
These are Honeywell/Waterloo manuals, not additional PDP-11 B editions.

They explicitly describe changes from earlier B: logical operators, floating
point, expanded switches, and changed operator rules. Both use NUL-terminated
strings and upper-bound vector declarations. Their unspecified binary operand
evaluation order must not replace the PDP-11 manual's explicit rules for
`&` and `|`.

Version 4.0 announces a new stack format and revised file-opening conventions.
Its entry/return linkage includes frame information, stack checks, and separate
return information for interception and debugging. The older and newer calling
sequences must not be mixed. Neither is the calling convention of BCC's
PDP-11 backend or host runtime. The library indexes establish names and brief
purposes, not complete contracts for every routine listed.

### Language reference and tutorial

The complete Thinkage [language reference](https://www.thinkage.ca/gcos/expl/b/manu/manu.html)
and [tutorial](https://www.thinkage.ca/gcos/expl/b/tuto/tuto.html) were read,
including their appendices. They describe a substantially later GCOS8 dialect:
floating-point operators, BCD constants, manifests, inclusion directives,
additional loops, case ranges, and different precedence and assignment rules.
Most importantly, their `*e` is ASCII NUL, not PDP-11 B's EOT.

Their name rules distinguish compiler significance from the linker's shorter,
case-folded names. Their startup argument vector begins with the command name
and ends with `-1`; it is not the PDP-11 count-prefixed external `argv`.
These differences belong in compatibility documentation, not silent changes
to strict mode.

The tutorial is useful for explanations of vector pointers, call-by-value,
and explicit initialization. Its examples are teaching examples, not a
complete test suite. The reference itself directs readers to individual
library explanations for newer details. Differences between editions, such
as the available unit range, should remain visible rather than being combined
into an imaginary single version of B.

### Runtime environment

The complete [environment manual](https://www.thinkage.ca/gcos/expl/b/envi/manu/manu.html)
was read. It describes the shared B, C, and Pascal runtime, including AR7 stack
indexing, A/Q argument passing, call and return linkage, frame limits, heap
management, cleanup traps, and debug tables.

Its variable-argument entry routine, `.VNTRY`, moves the callee beyond the
actual argument block and supplies a pointer to that block. This is useful
comparative evidence for handling more arguments than a function declares.
It does not prescribe the binary layout of BCC's host or PDP-11 frames.

The manual also distinguishes releasing storage for reuse from returning
memory to the operating system. Its cleanup traps are associated with
individual invocations and must be handled during non-local transfers.
These are runtime design lessons, not evidence that the January PDP-11
language includes every later GCOS facility.

### I/O internals

The complete [I/O logic manual](https://www.thinkage.ca/gcos/expl/b/iopl/manu.html)
was read, including the control-vector descriptions. It separates stable
public calls from internal layouts that can change between releases.

The library uses mutable dispatch entries for character, record, block,
seek, and error handling. Error recovery restores saved entries. B word
pointers and C/Pascal byte pointers have different representations, even
though the same library accepts both. Logical records and physical blocks
are also distinct.

These details support careful interface and state-transition tests. They do
not make GCOS seek values equivalent to Unix byte offsets, or its unit-based
I/O equivalent to Unix file descriptors.

### Supporting documentation

The supplied supporting pages were read in full:

- [BMAC](https://www.thinkage.ca/gcos/expl/b/bmac/expl.html) describes GMAP
  macros and register conventions, not a portable B calling convention.
- The [command](https://www.thinkage.ca/gcos/expl/b/comm.html) and
  [directive](https://www.thinkage.ca/gcos/expl/b/dire.html) pages describe
  loading, random-library updates, and object-deck metadata.
- [Program entry](https://www.thinkage.ca/gcos/expl/b/entr.html) documents
  `.BSET` command-line processing and its argument-vector layout.
- [Fortran interoperability](https://www.thinkage.ca/gcos/expl/b/fort.html)
  includes calling and I/O-unit attachment rules, with explicit limitations.
  It is not a specification for BCC's dynamic host-symbol bridge.
- [Units](https://www.thinkage.ca/gcos/expl/b/unit.html) describes saved
  bindings beneath reopened units; [string I/O](https://www.thinkage.ca/gcos/expl/b/stri.html)
  uses the same high-level stream operations on NUL-terminated buffers.
- The [coroutine overview](https://www.thinkage.ca/gcos/expl/b/coro/expl.html)
  is an introduction and index, not a complete package specification.
- [SYSLIB](https://www.thinkage.ca/gcos/expl/b/sysl/expl.html) describes
  release-dependent GCOS system facilities. [Tape I/O](https://www.thinkage.ca/gcos/expl/b/tape.html)
  has label, continuation-reel, positioning, and unsupported-operation rules.
- The [library index](https://www.thinkage.ca/gcos/expl/b/lib/index.html) and
  [documentation index](https://www.thinkage.ca/gcos/expl/b/index.html) were
  read as indexes. Reading them is not the same as reviewing every linked
  routine's specification.

The [Waterloo museum entry](https://computermuseum.uwaterloo.ca/index.php/Detail/objects/2535)
describes a binder containing manuals. It is a catalog record, not an online
copy of all those manuals.

### BOFF

The complete [BOFF manual](https://www.thinkage.ca/gcos/expl/boff/manu/manu.html)
was read. It distinguishes the executing frame from the frame being examined,
and describes symbol lookup, test calls, breakpoints, checkpoints, and image
patching. In its GCOS environment, B function and label values are writable
transfer instructions.

A debugger test call can change globals and write files even when it uses a
separate stack. Restoring a memory checkpoint does not undo external I/O.
The debugger also has its own expression operators and pointer interpretation;
its expression evaluator is not a substitute for compiler conformance tests.
The manual documents limitations in symbol names, context tracking,
checksums, and breakpoints rather than claiming that debugging is transparent.

## Restoration reports and tool limitations

The [aap/b README](https://github.com/aap/b) was read as a project overview;
that is not a claim that its entire source tree has been reviewed. It
separates the C seed, B-written passes, threaded targets, and Unix restoration.
The [2023 restoration announcement](https://www.tuhs.org/pipermail/tuhs/2023-July/028602.html)
was read in full. It distinguishes recovered runtime material from reconstructed
compiler logic and records uncertainties in intermediate code and conditional
expression generation. Program comparisons are evidence, not a blanket oracle.

The complete [TMG reconstruction report](https://www.tuhs.org/pipermail/tuhs/2025-May/031942.html)
says the original compiler was missing and describes a reconstruction from
the runtime, with uncertainty about original space limits. The complete
[V2-beta report](https://www.tuhs.org/pipermail/tuhs/2025-February/031420.html)
describes a system combining V1 syscall behavior with later memory and
executable-format support. Its emulator observations are dated observations,
not universal guarantees about every restored system.

The complete [2009 Unix restoration paper](https://www.usenix.org/event/usenix09/tech/full_papers/toomey/toomey.pdf)
was read through the public web copy. It records restoration patches, memory
limits, seed executables, and the distinction between an application emulator
and a restored kernel. Its dated account should be compared with later
artifact analyses rather than treated as a timeless description of every
tape or reconstruction. BCC's full-system checks must state which restored
system and patches they use.

The two remaining November 1971 command excerpts,
[man11](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man11.pdf) and
[man12](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man12.pdf), were
also read in full. The debugger's word-address display explicitly doubles a
stored B address. More importantly for validation, `cmp` documents that a
one-byte length difference can escape comparison. Full-system bootstrap
checks must therefore establish exact lengths and bytes, not merely trust a
quiet invocation of an old comparison tool. The other command pages describe
the surrounding tools and their limitations, not additional B syntax.

## Compiler structure and bootstrap evidence

### BCPL's intermediate-code bootstrap

Richards's complete [1973 bootstrap paper](https://softwarepreservation.computerhistory.org/BCPL/cambridge/Richards-Bootstrapping_BCPL-1973.pdf)
and [INTCODE description, revised in 1975](https://softwarepreservation.computerhistory.org/BCPL/cambridge/Richards-Intcode_for_BCPL-1975.pdf)
were read, including the latter's assembler and interpreter listing. The
extracted listing has apparent transcription errors, so it is not a ready-to-run
implementation.

The papers distinguish a compiler's portable intermediate representation
from the smaller interpreter used to get it running on a new machine.
A working bootstrap also needs character conversion, storage conventions,
and operating-system interfaces. The interpreter is a possible starting
point, not proof that a later native toolchain is independent of its seed.

For BCC, a B-written frontend that emits C still depends on a C toolchain.
Removing GCC and binutils from subsequent rebuilds requires a B-written
backend plus executable construction, or an assembler and linker, and an
appropriate runtime. This is a separate goal from the current generated-C
fixed point. The choice of target and seed remains to be investigated after
the source review and accuracy fixes.

### Threaded code

Bell's complete [1973 paper](https://www.ittc.ku.edu/~kulkarni/teaching/archieve/EECS800-Spring-2008/threaded_code.pdf)
was read. It describes dispatch through routine addresses, inline parameters,
and combinations of threaded and native code. Its speed and size measurements
are tied to particular hardware and workloads; they are not performance
promises for a new B implementation.

The paper helps explain the historical B runtime. It does not require BCC
to use that runtime to implement the language, or make threaded output the
same thing as a native compiler bootstrap.

### What a fixed point proves

Thompson's complete [1984 lecture](https://www.cs.cmu.edu/~rdriley/487/papers/Thompson_1984_ReflectionsonTrustingTrust.pdf)
was read. Its compiler example shows why inspecting source and reproducing
a binary are not, by themselves, proof that a seed compiler is trustworthy.
BCC should record seed provenance and distinguish reproducibility checks
from independent semantic tests. No claim of a trusted-from-nothing bootstrap
follows from matching successive builds.

### Language comparisons

Ritchie's complete [HOPL talk transcript](https://cm-bell-labs.github.io/who/dmr/hopl.html)
was read. It compares naming, dereferencing, machine-word models, portability,
and practical system interfaces across contemporary languages. It is a
retrospective explanation, not an additional B grammar. Its discussion of
machine-dependent words supports documenting target layouts explicitly
instead of calling every host configuration a PDP-11 implementation.

## PDP-11 hardware evidence

The complete extracted text of the [1970 handbook scan](https://deramp.com/downloads/mfe_archive/011-Digital%20Equipment%20Corporation/00%20Digital%20Handbooks/11%20PDP-11%20Family/PDP-11%20Handbook/PDP-11_Handbook_Second_Edition_1970.pdf)
was read; diagrams and uncertain OCR glyphs have not all been checked
visually. The scan was obtained from a public mirror because the supplied
copy could not be retrieved.

The handbook distinguishes byte addresses from word-sized values, specifies
source-before-destination address calculation, keeps stack-pointer byte
operations aligned, and sign-extends `MOVB` into a register. Its arithmetic
right shift is not B's zero-filling right shift. The native backend must
implement the language operation rather than substitute a similarly named
instruction.

The KA11 instruction set must also be kept separate from later PDP-11
extensions. A footnote on printed page 46 gives special autoincrement
behavior for `JMP` and `JSR`; that needs original-page and model-specific
checking before using it to change an emulator or code generator. Hardware
examples and opcode tables are evidence to cross-check, not infallible tests.

The complete OCR text of the [May 1971 KE11-A manual](https://deramp.com/downloads/mfe_archive/011-Digital%20Equipment%20Corporation/08%20PDP-11/05%20Unibus%20Options/KE11%20Extended%20Arithmatic%20Elements/KE11-A%201120%20Extended%20Arithmetic%20Element/01%20KE11-A%20Documentation/KE11-A_ExtendedArithElem.pdf)
was also read. Its diagrams, equations, and some numeric tables still need
visual verification. It describes a memory-mapped Unibus arithmetic device,
not the later processor's multiply and divide instructions.

Loading MQ sign-extends into AC, so loading a double-word dividend requires
careful ordering. Division produces a signed quotient and a remainder with
the dividend's sign; overflow makes the result unusable. Logical and arithmetic
shifts differ, and the device's status register is not the processor status
word. These distinctions matter when auditing native arithmetic helpers and
the emulator used to test them.

## Findings to check in the implementation

These are audit questions, not claims that the corresponding fixes are done:

- Do native bootstrap comparisons check exact file sizes and all bytes,
  including an odd trailing byte?
- Does generated code preserve the PDP-11 manual's left-to-right evaluation
  of `&` and `|`, including side effects on the same variable?
- Does strict `open` treat every nonzero mode as write access, as the cited
  library description says?
- Do strict declaration rules distinguish internal names from implicit
  external calls, rather than inheriting the Honeywell rule accidentally?
- Which parts of the three-word terminal interface can the host model
  faithfully, and which depend on DC-11 hardware? The 1971 and 1972 echo
  flags must be distinguished.

See [historical conformance](HISTORICAL_CONFORMANCE.md) for implemented
behavior and current limits, and [testing](WIKI_TESTS.md) for the checks.

## Reference inventory

"Read" below describes the review scope, not a promise that every feature in
that source is implemented. Alternative copies and archive indexes are kept
in the inventory so that missing or duplicated material is visible.


### B texts and project entry point

| ID | Reference | Review status |
| --- | --- | --- |
| 001 | [GitHub - frankischilling/bcc: A modern compiler for Ken Thompson's B programming language, transl...](https://github.com/frankischilling/bcc) | Retrieved; not yet reviewed |
| 002 | [Thompson's B Manual](https://cm-bell-labs.github.io/who/dmr/kbman.html) | Read in full |
| 003 | [kbman.pdfA](https://cm-bell-labs.github.io/who/dmr/kbman.pdfA) | Supplied URL is 404; corrected PDF checked on pages 13-14 |
| 004 | [btut.pdf](https://cm-bell-labs.github.io/who/dmr/btut.pdf) | Read in full |
| 005 | [btut.ms](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.html) | Retrieved; not yet reviewed |
| 006 | [bref.ms](https://cm-bell-labs.github.io/who/dmr/bref.html) | Read in full |
| 007 | [bref.pdf](https://cm-bell-labs.github.io/who/dmr/bref.pdf) | PDF rendition: selected sections checked |
| 008 | [B Programming Language Manuals : University of Waterloo : Free Download, Borrow, and Streaming : ...](https://archive.org/details/b-reference-manual) | Retrieved; not yet reviewed |
| 009 | [B Reference Manual.pdf](https://archive.org/download/b-reference-manual/B%20Reference%20Manual.pdf) | PDF retrieval returned 503; OCR copy is available at 010 |
| 010 | [B Reference Manual_djvu.txt](https://archive.org/download/b-reference-manual/B%20Reference%20Manual_djvu.txt) | Complete supplied OCR read; damaged syntax and tables need scan checks |
| 011 | [User's Reference to B V4.0.pdf](https://archive.org/download/b-reference-manual/User%27s%20Reference%20to%20B%20V4.0.pdf) | Larger PDF retrieved; not yet reviewed |
| 012 | [User's Reference to B V4.0_djvu.txt](https://archive.org/download/b-reference-manual/User%27s%20Reference%20to%20B%20V4.0_djvu.txt) | Complete supplied OCR read; damaged syntax and tables need scan checks |

### Early Unix manuals and archives

| ID | Reference | Review status |
| --- | --- | --- |
| 013 | [UNIX_ProgrammersManual_Nov71.pdf](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/UNIX_ProgrammersManual_Nov71.pdf) | OCR available; not yet reviewed |
| 014 | [Index of /Archive/Distributions/Research/Dennis_v1](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/) | Retrieved; not yet reviewed |
| 015 | [Unix Manual, first edition](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/1stEdman.html) | Retrieved; not yet reviewed |
| 016 | [V1/man/man7/bc.7](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man7/bc.7) | Read in full |
| 017 | [V1/man/man7/ba.7](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man7/ba.7) | Read in full |
| 018 | [man71.pdf](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man71.pdf) | Read in full |
| 019 | [V1/man/man7/bilib.7](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man7/bilib.7) | Read in full |
| 020 | [V1/man/man7/brt1.7](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man7/brt1.7) | Read in full |
| 021 | [V1/man/man7/libb.a.7](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man7/libb.a.7) | Read in full |
| 022 | [Mike Taylor - The B Library in First Edition Unix](https://www.miketaylor.org.uk/tech/libb-a.html) | Read in full |
| 023 | [V1/man/man1/b.1](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man1/b.1) | Read in full |
| 024 | [V1/man/man1/as.1](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man1/as.1) | Read in full |
| 025 | [man11.pdf](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man11.pdf) | Read in full |
| 026 | [V1/man/man1/ld.1](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man1/ld.1) | Read in full |
| 027 | [man12.pdf](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man12.pdf) | Read in full |
| 028 | [V1/man/man5/a.out.5](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man5/a.out.5) | Read in full |
| 029 | [V1/man/man5/archive.5](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man5/archive.5) | Read in full |
| 030 | [v2man.pdf](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v2/v2man.pdf) | Retrieved; not yet reviewed |
| 031 | [Index of /Archive/Distributions/Research/Dennis_v2](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v2/) | Retrieved; not yet reviewed |
| 032 | [Index of /Archive/Distributions/Research/1972_stuff](https://www.tuhs.org/Archive/Distributions/Research/1972_stuff/) | Retrieved; not yet reviewed |
| 033 | [Index of /Archive/Applications/Dennis_Tapes](https://www.tuhs.org/Archive/Applications/Dennis_Tapes/) | Retrieved; not yet reviewed |
| 034 | [Index of /Archive/Applications/Dennis_Tapes/Gao_Analysis](https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/) | Retrieved; not yet reviewed |
| 035 | [Index of /Archive/Distributions/Research/McIlroy_v0](https://www.tuhs.org/Archive/Distributions/Research/McIlroy_v0/) | Retrieved; not yet reviewed |
| 036 | [the-earliest-unix-code-an-anniversary-source-code-release](https://computerhistory.org/blog/the-earliest-unix-code-an-anniversary-source-code-release/) | Not retrieved: 403: Forbidden |
| 037 | [102785108](https://www.computerhistory.org/collections/catalog/102785108) | Not retrieved: 403: Forbidden |
| 038 | [setup.pdf](https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist/setup.pdf) | Retrieved; not yet reviewed |
| 039 | [Index of /Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist](https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist/) | Retrieved; not yet reviewed |

### Restorations and implementation evidence

| ID | Reference | Review status |
| --- | --- | --- |
| 040 | [GitHub - aap/b: B compiler · GitHub](https://github.com/aap/b) | Project README read; source tree not exhaustively reviewed |
| 041 | [b/unix1_bdir at master · aap/b · GitHub](https://github.com/aap/b/tree/master/unix1_bdir) | Retrieved; not yet reviewed |
| 042 | [TUHS B compiler restored](https://www.tuhs.org/pipermail/tuhs/2023-July/028602.html) | Read in full |
| 043 | [B](https://squoze.net/B/) | Not retrieved: 503: Service Unavailable |
| 044 | [programs](https://squoze.net/B/programs/) | Not retrieved: 503: Service Unavailable |
| 045 | [install](https://squoze.net/B/install) | Not retrieved: 503: Service Unavailable |
| 046 | [GitHub - rswier/pdp11-B: A project to recreate the B compiler for the PDP-11 as authentically as ...](https://github.com/rswier/pdp11-B) | Retrieved; not yet reviewed |
| 047 | [GitHub - DoctorWkt/pdp7-unix: A project to resurrect Unix on the PDP-7 from a scan of the origina...](https://github.com/DoctorWkt/pdp7-unix) | Retrieved; not yet reviewed |
| 048 | [TUHS Listing of early Unix source code from the Computer History Museum.](https://www.tuhs.org/pipermail/tuhs/2025-May/031942.html) | Read in full |
| 049 | [GitHub - philbudne/pdp7-unix at tmg · GitHub](https://github.com/philbudne/pdp7-unix/tree/tmg) | Retrieved; not yet reviewed |
| 050 | [pdp7-unix/blob/tmg/misc/tmg-notes.txt](https://github.com/philbudne/pdp7-unix/blob/tmg/misc/tmg-notes.txt) | Retrieved; not yet reviewed |
| 051 | [pdp7-unix/blob/tmg/src/other/pbtmg/b.t](https://github.com/philbudne/pdp7-unix/blob/tmg/src/other/pbtmg/b.t) | Retrieved; not yet reviewed |
| 052 | [GitHub - DoctorWkt/unix-jun72: The working source code to PDP-11 Unix from 1972. · GitHub](https://github.com/DoctorWkt/unix-jun72) | Retrieved; not yet reviewed |
| 053 | [GitHub - TheBrokenPipe/Research-UNIX-V2-Beta: A Research UNIX V2 beta from 1972 brought back to l...](https://github.com/TheBrokenPipe/Research-UNIX-V2-Beta) | Retrieved; not yet reviewed |
| 054 | [TUHS 1972 UNIX V2 "Beta" Resurrected](https://www.tuhs.org/pipermail/tuhs/2025-February/031420.html) | Read in full |
| 055 | [GitHub - aap/abc: (OBSOLETE) A B Compiler for x86 · GitHub](https://github.com/aap/abc) | Retrieved; not yet reviewed |
| 056 | [GitHub - dobyrch/dbc: B compiler front end implemented using Flex+Bison+LLVM · GitHub](https://github.com/dobyrch/dbc) | Retrieved; not yet reviewed |
| 057 | [toomey.pdf](https://www.usenix.org/event/usenix09/tech/full_papers/toomey/toomey.pdf) | Full paper read through web retrieval; direct download failed |
| 058 | [restoration-early-unix-artifacts](https://www.usenix.org/conference/usenix-09/restoration-early-unix-artifacts) | Not retrieved: 403: Forbidden |

### Waterloo and GCOS documentation

| ID | Reference | Review status |
| --- | --- | --- |
| 059 | [B Language Reference Manual](https://www.thinkage.ca/gcos/expl/b/manu/manu.html) | Read in full |
| 060 | [The B Tutorial Guide](https://www.thinkage.ca/gcos/expl/b/tuto/tuto.html) | Read in full |
| 061 | [The B Environment Manual](https://www.thinkage.ca/gcos/expl/b/envi/manu/manu.html) | Read in full |
| 062 | [B I/O Program Logic Manual](https://www.thinkage.ca/gcos/expl/b/iopl/manu.html) | Read in full |
| 063 | [Index for "expl b lib"](https://www.thinkage.ca/gcos/expl/b/lib/index.html) | Library index read; linked routine pages not individually reviewed |
| 064 | [BMAC - GMAP macros for writing B subroutines.](https://www.thinkage.ca/gcos/expl/b/bmac/expl.html) | Read in full |
| 065 | [COMMAND - command to invoke the B compiler.](https://www.thinkage.ca/gcos/expl/b/comm.html) | Read in full |
| 066 | [DIRECTIVES - B compiler directives.](https://www.thinkage.ca/gcos/expl/b/dire.html) | Read in full |
| 067 | [ENTRY - entry to your program from B setup.](https://www.thinkage.ca/gcos/expl/b/entr.html) | Read in full |
| 068 | [FORTRAN - mixing Fortran 66 and B routines.](https://www.thinkage.ca/gcos/expl/b/fort.html) | Read in full |
| 069 | [UNITS - default I/O units and how to use I/O units.](https://www.thinkage.ca/gcos/expl/b/unit.html) | Read in full |
| 070 | [STRING - string I/O support.](https://www.thinkage.ca/gcos/expl/b/stri.html) | Read in full |
| 071 | [COROUTINES - the B co-routine package.](https://www.thinkage.ca/gcos/expl/b/coro/expl.html) | Read in full |
| 072 | [SYSLIB - routines for privileged system programs.](https://www.thinkage.ca/gcos/expl/b/sysl/expl.html) | Read in full |
| 073 | [TAPE - tape I/O in B.](https://www.thinkage.ca/gcos/expl/b/tape.html) | Read in full |
| 074 | [B Obscure Feature Finder (BOFF)](https://www.thinkage.ca/gcos/expl/boff/manu/manu.html) | Read in full |
| 075 | [Index for "expl b"](https://www.thinkage.ca/gcos/expl/b/index.html) | Read in full |
| 076 | [Computer Museum at the University of Waterloo : text : Computer Manual's Compendium 2017.11.66](https://computermuseum.uwaterloo.ca/index.php/Detail/objects/2535) | Read in full |

### Language history and related dialects

| ID | Reference | Review status |
| --- | --- | --- |
| 077 | [Chistory](https://cm-bell-labs.github.io/who/dmr/chist.html) | Read in full |
| 078 | [Early Unix history and evolution](https://cm-bell-labs.github.io/who/dmr/hist.html) | Read in full |
| 079 | [Primeval C: two very early compilers](https://cm-bell-labs.github.io/who/dmr/primevalC.html) | Read in full |
| 080 | [cman74.pdf](https://cm-bell-labs.github.io/who/dmr/cman74.pdf) | OCR available; not yet reviewed |
| 081 | [cman.pdf](https://cm-bell-labs.github.io/who/dmr/cman.pdf) | Retrieved; not yet reviewed |
| 082 | [HOPL C Transcript](https://cm-bell-labs.github.io/who/dmr/hopl.html) | Read in full |
| 083 | [CS-76-45.pdf](https://cs.uwaterloo.ca/research/tr/1976/CS-76-45.pdf) | Full OCR text read; ambiguous symbols need visual checks |

### BCPL sources

| ID | Reference | Review status |
| --- | --- | --- |
| 084 | [History of BCPL](https://softwarepreservation.computerhistory.org/BCPL/) | Retrieved; not yet reviewed |
| 085 | [Richards-BCPL-ReferenceManual.pdf](https://softwarepreservation.computerhistory.org/BCPL/project_mac/Richards-BCPL-ReferenceManual.pdf) | OCR available; not yet reviewed |
| 086 | [BCPL Reference Manual (1967)](https://cm-bell-labs.github.io/who/dmr/bcpl.html) | Read in full |
| 087 | [1476793.1476880](https://dl.acm.org/doi/10.1145/1476793.1476880) | Not retrieved: 403: Forbidden |
| 088 | [spe.4380010204](https://onlinelibrary.wiley.com/doi/10.1002/spe.4380010204) | Not retrieved: 403: Forbidden |
| 089 | [Richards-Intcode_for_BCPL-1975.pdf](https://softwarepreservation.computerhistory.org/BCPL/cambridge/Richards-Intcode_for_BCPL-1975.pdf) | Full text and appendix read; listing transcription issues remain |
| 090 | [Richards-Bootstrapping_BCPL-1973.pdf](https://softwarepreservation.computerhistory.org/BCPL/cambridge/Richards-Bootstrapping_BCPL-1973.pdf) | Read in full |
| 091 | [Scan 2.PDF](https://people.csail.mit.edu/saltzer/Multics/MHP-Saltzer-060508/filedrawers/177.bcpl/Scan%202.PDF) | OCR available; not yet reviewed |
| 092 | [richards-manual-1974.pdf](https://softwarepreservation.computerhistory.org/BCPL/cambridge/richards-manual-1974.pdf) | Retrieved; not yet reviewed |
| 093 | [bcpl-language-and-its-compiler](https://www.cambridge.org/bd/universitypress/subjects/computer-science/programming-languages-and-applied-logic/bcpl-language-and-its-compiler?format=PB&isbn=9780521286817) | Not retrieved: 403: Forbidden |
| 094 | [9780521286817_toc.pdf](https://assets.cambridge.org/97805212/86817/toc/9780521286817_toc.pdf) | Retrieved; not yet reviewed |
| 095 | [BCPLCTSS](https://www.cl.cam.ac.uk/~mr10/BCPLCTSS.html) | Retrieved; not yet reviewed |
| 096 | [BCPL and Tripos Archive](https://www.cl.cam.ac.uk/~mr10/Archive.html) | Retrieved; not yet reviewed |
| 097 | [cpl2bcpl.pdf](https://www.cl.cam.ac.uk/~mr10/cpl2bcpl.pdf) | Retrieved; not yet reviewed |
| 098 | [bcplman.pdf](https://www.cl.cam.ac.uk/~mr10/bcplman.pdf) | Retrieved; not yet reviewed |

### Threaded code and bootstrap trust

| ID | Reference | Review status |
| --- | --- | --- |
| 099 | [362248.362270](https://dl.acm.org/doi/10.1145/362248.362270) | Not retrieved: 403: Forbidden |
| 100 | [threaded_code.pdf](https://www.ittc.ku.edu/~kulkarni/teaching/archieve/EECS800-Spring-2008/threaded_code.pdf) | Complete Bell paper read; adjacent article excluded |
| 101 | [360825.360849](https://dl.acm.org/doi/10.1145/360825.360849) | Not retrieved: 403: Forbidden |
| 102 | [Indirect.Threaded.Code.p330-dewar.pdf](https://figforth.org.uk/library/Indirect.Threaded.Code.p330-dewar.pdf) | Not retrieved: 465: Unknown |
| 103 | [Thompson_1984_ReflectionsonTrustingTrust.pdf](https://www.cs.cmu.edu/~rdriley/487/papers/Thompson_1984_ReflectionsonTrustingTrust.pdf) | Full lecture text read; code figures not independently transcribed |
| 104 | [358198.358210](https://dl.acm.org/doi/10.1145/358198.358210) | Not retrieved: 403: Forbidden |

### PDP-11 hardware manuals

| ID | Reference | Review status |
| --- | --- | --- |
| 105 | [PDP-11_Handbook_Second_Edition_1970.pdf](https://www.bitsavers.org/pdf/dec/pdp11/1120/PDP-11_Handbook_Second_Edition_1970.pdf) | Complete extracted text read from public mirror; diagrams not all checked |
| 106 | [KA11_ProcessorMan_Sep1970.pdf](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/KA11_ProcessorMan_Sep1970.pdf) | Not retrieved: 403: Forbidden |
| 107 | [KE11-A_ExtendedArithElem.pdf](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/KE11-A_ExtendedArithElem.pdf) | Full OCR read from public mirror; diagrams and numeric tables need checks |
| 108 | [pdp11-40.pdf](https://pdos.csail.mit.edu/6.828/2005/readings/pdp11-40.pdf) | BR instruction checked on PDF page 83; remainder pending |
| 109 | [PDP-11_40_Processor_Handbook_1972.pdf](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/handbooks/PDP-11_40_Processor_Handbook_1972.pdf) | Not retrieved: 403: Forbidden |

### Host language and toolchain references

| ID | Reference | Review status |
| --- | --- | --- |
| 110 | [n1256.pdf](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf) | Retrieved; not yet reviewed |
| 111 | [Top (Using the GNU Compiler Collection (GCC))](https://gcc.gnu.org/onlinedocs/gcc/) | Retrieved; not yet reviewed |
| 112 | [C Extensions (Using the GNU Compiler Collection (GCC))](https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html) | Retrieved; not yet reviewed |
| 113 | [Top (Using as)](https://sourceware.org/binutils/docs/as/) | Retrieved; not yet reviewed |
| 114 | [Top (LD)](https://sourceware.org/binutils/docs/ld/) | Retrieved; not yet reviewed |
| 115 | [x86 psABIs / x86-64 psABI · GitLab](https://gitlab.com/x86-psABIs/x86-64-ABI) | Retrieved; not yet reviewed |

### Repository snapshots and catalog records

| ID | Reference | Review status |
| --- | --- | --- |
| 116 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/README.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/README.md) | Retrieved; not yet reviewed |
| 117 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/asm/README.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/asm/README.md) | Retrieved; not yet reviewed |
| 118 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/asm/bootstrap/README.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/asm/bootstrap/README.md) | Retrieved; not yet reviewed |
| 119 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/bcc-pdp/README.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/bcc-pdp/README.md) | Retrieved; not yet reviewed |
| 120 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/bcc-pdp/CONFORMANCE.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/bcc-pdp/CONFORMANCE.md) | Retrieved; not yet reviewed |
| 121 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/NOTES_RUNTIME.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/NOTES_RUNTIME.md) | Retrieved; not yet reviewed |
| 122 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/NOTES_ASSEMBLY.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/NOTES_ASSEMBLY.md) | Retrieved; not yet reviewed |
| 123 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/unix-v1-docs/README.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/unix-v1-docs/README.md) | Retrieved; not yet reviewed |
| 124 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/wiki/B_LANGUAGE.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/wiki/B_LANGUAGE.md) | Retrieved; not yet reviewed |
| 125 | [b-reference-manual](https://archive.org/metadata/b-reference-manual) | Retrieved; not yet reviewed |
| 126 | [bcc/blob/main/README.md](https://github.com/frankischilling/bcc/blob/main/README.md) | Retrieved; not yet reviewed |
| 127 | [bcc/blob/main/pdp-11/bcc-pdp/README.md](https://github.com/frankischilling/bcc/blob/main/pdp-11/bcc-pdp/README.md) | Retrieved; not yet reviewed |
| 128 | [bcc/blob/main/asm/README.md](https://github.com/frankischilling/bcc/blob/main/asm/README.md) | Retrieved; not yet reviewed |
