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

The early executable has a six-word header beginning with octal `0205`.
Its text size includes that header. Symbols occupy twelve-byte entries,
and relocation uses a variable-length bit encoding. These details must not
be replaced with the later `0407` layout by assumption.

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

## Findings to check in the implementation

These are audit questions, not claims that the corresponding fixes are done:

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
| 010 | [B Reference Manual_djvu.txt](https://archive.org/download/b-reference-manual/B%20Reference%20Manual_djvu.txt) | Retrieved; not yet reviewed |
| 011 | [User's Reference to B V4.0.pdf](https://archive.org/download/b-reference-manual/User%27s%20Reference%20to%20B%20V4.0.pdf) | Larger PDF retrieved; not yet reviewed |
| 012 | [User's Reference to B V4.0_djvu.txt](https://archive.org/download/b-reference-manual/User%27s%20Reference%20to%20B%20V4.0_djvu.txt) | Retrieved; not yet reviewed |

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
| 025 | [man11.pdf](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man11.pdf) | Retrieved; not yet reviewed |
| 026 | [V1/man/man1/ld.1](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man1/ld.1) | Read in full |
| 027 | [man12.pdf](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man12.pdf) | Retrieved; not yet reviewed |
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
| 040 | [GitHub - aap/b: B compiler · GitHub](https://github.com/aap/b) | Retrieved; not yet reviewed |
| 041 | [b/unix1_bdir at master · aap/b · GitHub](https://github.com/aap/b/tree/master/unix1_bdir) | Retrieved; not yet reviewed |
| 042 | [TUHS B compiler restored](https://www.tuhs.org/pipermail/tuhs/2023-July/028602.html) | Retrieved; not yet reviewed |
| 043 | [B](https://squoze.net/B/) | Not retrieved: 503: Service Unavailable |
| 044 | [programs](https://squoze.net/B/programs/) | Not retrieved: 503: Service Unavailable |
| 045 | [install](https://squoze.net/B/install) | Not retrieved: 503: Service Unavailable |
| 046 | [GitHub - rswier/pdp11-B: A project to recreate the B compiler for the PDP-11 as authentically as ...](https://github.com/rswier/pdp11-B) | Retrieved; not yet reviewed |
| 047 | [GitHub - DoctorWkt/pdp7-unix: A project to resurrect Unix on the PDP-7 from a scan of the origina...](https://github.com/DoctorWkt/pdp7-unix) | Retrieved; not yet reviewed |
| 048 | [TUHS Listing of early Unix source code from the Computer History Museum.](https://www.tuhs.org/pipermail/tuhs/2025-May/031942.html) | Retrieved; not yet reviewed |
| 049 | [GitHub - philbudne/pdp7-unix at tmg · GitHub](https://github.com/philbudne/pdp7-unix/tree/tmg) | Retrieved; not yet reviewed |
| 050 | [pdp7-unix/blob/tmg/misc/tmg-notes.txt](https://github.com/philbudne/pdp7-unix/blob/tmg/misc/tmg-notes.txt) | Retrieved; not yet reviewed |
| 051 | [pdp7-unix/blob/tmg/src/other/pbtmg/b.t](https://github.com/philbudne/pdp7-unix/blob/tmg/src/other/pbtmg/b.t) | Retrieved; not yet reviewed |
| 052 | [GitHub - DoctorWkt/unix-jun72: The working source code to PDP-11 Unix from 1972. · GitHub](https://github.com/DoctorWkt/unix-jun72) | Retrieved; not yet reviewed |
| 053 | [GitHub - TheBrokenPipe/Research-UNIX-V2-Beta: A Research UNIX V2 beta from 1972 brought back to l...](https://github.com/TheBrokenPipe/Research-UNIX-V2-Beta) | Retrieved; not yet reviewed |
| 054 | [TUHS 1972 UNIX V2 "Beta" Resurrected](https://www.tuhs.org/pipermail/tuhs/2025-February/031420.html) | Retrieved; not yet reviewed |
| 055 | [GitHub - aap/abc: (OBSOLETE) A B Compiler for x86 · GitHub](https://github.com/aap/abc) | Retrieved; not yet reviewed |
| 056 | [GitHub - dobyrch/dbc: B compiler front end implemented using Flex+Bison+LLVM · GitHub](https://github.com/dobyrch/dbc) | Retrieved; not yet reviewed |
| 057 | [toomey.pdf](https://www.usenix.org/event/usenix09/tech/full_papers/toomey/toomey.pdf) | Not retrieved: 403: Forbidden |
| 058 | [restoration-early-unix-artifacts](https://www.usenix.org/conference/usenix-09/restoration-early-unix-artifacts) | Not retrieved: 403: Forbidden |

### Waterloo and GCOS documentation

| ID | Reference | Review status |
| --- | --- | --- |
| 059 | [B Language Reference Manual](https://www.thinkage.ca/gcos/expl/b/manu/manu.html) | Retrieved; not yet reviewed |
| 060 | [The B Tutorial Guide](https://www.thinkage.ca/gcos/expl/b/tuto/tuto.html) | Retrieved; not yet reviewed |
| 061 | [The B Environment Manual](https://www.thinkage.ca/gcos/expl/b/envi/manu/manu.html) | Retrieved; not yet reviewed |
| 062 | [B I/O Program Logic Manual](https://www.thinkage.ca/gcos/expl/b/iopl/manu.html) | Retrieved; not yet reviewed |
| 063 | [Index for "expl b lib"](https://www.thinkage.ca/gcos/expl/b/lib/index.html) | Retrieved; not yet reviewed |
| 064 | [BMAC - GMAP macros for writing B subroutines.](https://www.thinkage.ca/gcos/expl/b/bmac/expl.html) | Retrieved; not yet reviewed |
| 065 | [COMMAND - command to invoke the B compiler.](https://www.thinkage.ca/gcos/expl/b/comm.html) | Retrieved; not yet reviewed |
| 066 | [DIRECTIVES - B compiler directives.](https://www.thinkage.ca/gcos/expl/b/dire.html) | Retrieved; not yet reviewed |
| 067 | [ENTRY - entry to your program from B setup.](https://www.thinkage.ca/gcos/expl/b/entr.html) | Retrieved; not yet reviewed |
| 068 | [FORTRAN - mixing Fortran 66 and B routines.](https://www.thinkage.ca/gcos/expl/b/fort.html) | Retrieved; not yet reviewed |
| 069 | [UNITS - default I/O units and how to use I/O units.](https://www.thinkage.ca/gcos/expl/b/unit.html) | Retrieved; not yet reviewed |
| 070 | [STRING - string I/O support.](https://www.thinkage.ca/gcos/expl/b/stri.html) | Retrieved; not yet reviewed |
| 071 | [COROUTINES - the B co-routine package.](https://www.thinkage.ca/gcos/expl/b/coro/expl.html) | Retrieved; not yet reviewed |
| 072 | [SYSLIB - routines for privileged system programs.](https://www.thinkage.ca/gcos/expl/b/sysl/expl.html) | Retrieved; not yet reviewed |
| 073 | [TAPE - tape I/O in B.](https://www.thinkage.ca/gcos/expl/b/tape.html) | Retrieved; not yet reviewed |
| 074 | [B Obscure Feature Finder (BOFF)](https://www.thinkage.ca/gcos/expl/boff/manu/manu.html) | Retrieved; not yet reviewed |
| 075 | [Index for "expl b"](https://www.thinkage.ca/gcos/expl/b/index.html) | Retrieved; not yet reviewed |
| 076 | [Computer Museum at the University of Waterloo : text : Computer Manual's Compendium 2017.11.66](https://computermuseum.uwaterloo.ca/index.php/Detail/objects/2535) | Retrieved; not yet reviewed |

### Language history and related dialects

| ID | Reference | Review status |
| --- | --- | --- |
| 077 | [Chistory](https://cm-bell-labs.github.io/who/dmr/chist.html) | Retrieved; not yet reviewed |
| 078 | [Early Unix history and evolution](https://cm-bell-labs.github.io/who/dmr/hist.html) | Retrieved; not yet reviewed |
| 079 | [Primeval C: two very early compilers](https://cm-bell-labs.github.io/who/dmr/primevalC.html) | Read in full |
| 080 | [cman74.pdf](https://cm-bell-labs.github.io/who/dmr/cman74.pdf) | OCR available; not yet reviewed |
| 081 | [cman.pdf](https://cm-bell-labs.github.io/who/dmr/cman.pdf) | Retrieved; not yet reviewed |
| 082 | [HOPL C Transcript](https://cm-bell-labs.github.io/who/dmr/hopl.html) | Retrieved; not yet reviewed |
| 083 | [CS-76-45.pdf](https://cs.uwaterloo.ca/research/tr/1976/CS-76-45.pdf) | Full OCR text read; ambiguous symbols need visual checks |

### BCPL sources

| ID | Reference | Review status |
| --- | --- | --- |
| 084 | [History of BCPL](https://softwarepreservation.computerhistory.org/BCPL/) | Retrieved; not yet reviewed |
| 085 | [Richards-BCPL-ReferenceManual.pdf](https://softwarepreservation.computerhistory.org/BCPL/project_mac/Richards-BCPL-ReferenceManual.pdf) | OCR available; not yet reviewed |
| 086 | [BCPL Reference Manual (1967)](https://cm-bell-labs.github.io/who/dmr/bcpl.html) | Read in full |
| 087 | [1476793.1476880](https://dl.acm.org/doi/10.1145/1476793.1476880) | Not retrieved: 403: Forbidden |
| 088 | [spe.4380010204](https://onlinelibrary.wiley.com/doi/10.1002/spe.4380010204) | Not retrieved: 403: Forbidden |
| 089 | [Richards-Intcode_for_BCPL-1975.pdf](https://softwarepreservation.computerhistory.org/BCPL/cambridge/Richards-Intcode_for_BCPL-1975.pdf) | Retrieved; not yet reviewed |
| 090 | [Richards-Bootstrapping_BCPL-1973.pdf](https://softwarepreservation.computerhistory.org/BCPL/cambridge/Richards-Bootstrapping_BCPL-1973.pdf) | Retrieved; not yet reviewed |
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
| 100 | [threaded_code.pdf](https://www.ittc.ku.edu/~kulkarni/teaching/archieve/EECS800-Spring-2008/threaded_code.pdf) | Retrieved; not yet reviewed |
| 101 | [360825.360849](https://dl.acm.org/doi/10.1145/360825.360849) | Not retrieved: 403: Forbidden |
| 102 | [Indirect.Threaded.Code.p330-dewar.pdf](https://figforth.org.uk/library/Indirect.Threaded.Code.p330-dewar.pdf) | Not retrieved: 465: Unknown |
| 103 | [Thompson_1984_ReflectionsonTrustingTrust.pdf](https://www.cs.cmu.edu/~rdriley/487/papers/Thompson_1984_ReflectionsonTrustingTrust.pdf) | Retrieved; not yet reviewed |
| 104 | [358198.358210](https://dl.acm.org/doi/10.1145/358198.358210) | Not retrieved: 403: Forbidden |

### PDP-11 hardware manuals

| ID | Reference | Review status |
| --- | --- | --- |
| 105 | [PDP-11_Handbook_Second_Edition_1970.pdf](https://www.bitsavers.org/pdf/dec/pdp11/1120/PDP-11_Handbook_Second_Edition_1970.pdf) | Not retrieved: 403: Forbidden |
| 106 | [KA11_ProcessorMan_Sep1970.pdf](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/KA11_ProcessorMan_Sep1970.pdf) | Not retrieved: 403: Forbidden |
| 107 | [KE11-A_ExtendedArithElem.pdf](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/KE11-A_ExtendedArithElem.pdf) | Not retrieved: 403: Forbidden |
| 108 | [pdp11-40.pdf](https://pdos.csail.mit.edu/6.828/2005/readings/pdp11-40.pdf) | Retrieved; not yet reviewed |
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
