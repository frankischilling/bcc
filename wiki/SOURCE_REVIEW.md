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

### Full first-edition manual

The complete OCR of the [November 1971 manual](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/UNIX_ProgrammersManual_Nov71.pdf)
was read. Damaged characters and numerical tables still need checks against
original pages before they become test expectations.

The system-call pages make several distinctions that a host wrapper can hide:
`open` uses zero for reading and any nonzero mode for writing; `read` may
return fewer bytes than requested; an open file survives its last directory
link until it is closed. `stat` uses a 34-byte record, not a modern host
`struct stat`. Ordinary-file seek offsets and block-device offsets also have
different units.

The November terminal interface passes three words: two DC11 control/status
register values and a mode word. Bit `010` disables echo. Raw mode bypasses
line editing and the special treatment of EOT, interrupt, and quit characters.
The console device is different: its page says `stty` and `gtty` do not apply.
These are target-specific interfaces, not an invitation to expose host
`termios` fields directly.

The manual documents defects as well as contracts: `tell` does not work,
`ctime` does not wrap correctly at the year boundary, and `cmp` can miss an
extra trailing byte in an odd-sized file. BCC should not reproduce those
failures. Bootstrap checks need exact lengths and bytes rather than trusting
that historical comparison utility alone.

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

## June 1972 Unix is not the first edition

The body of the [second-edition manual](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v2/v2man.pdf)
was read, including its command, syscall, library, device, and file-format
sections. The front-matter indexes were only partly inspected. OCR damage
still limits exact readings of some tables and operators.

Its preface warns that installations differ and that the assembler and
loader have just been reorganized. The new executable header has eight
words, begins with `0407`, and is excluded from the loaded text. Text, data,
and bss have separate sizes; relocation has a word per text or data word.
The introductory ordering of file sections conflicts with the later offset
formulas, so an implementation needs surviving objects and tool source too.
This format must not replace the first edition's six-word `0405` header.

The terminal mode bit `010` now enables echo, the opposite of the November
1971 description. Library input/output buffers grow from 134 to 518 bytes.
The `wait` page describes a packed termination status in MQ, while `exit`
provides the child's low status byte. These changes need explicit version
boundaries in host emulation and restored-system tests.

The B command is now documented as `bc`, with object-file compilation,
optional suppression of linking, and libraries under `/usr/lib`. Its page
still lists restrictions on external initializers as bugs. Supporting the
language's valid initializers does not require copying those defects.

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

### BCPL manuals and later changes

The complete OCR texts of the [1967 reference](https://softwarepreservation.computerhistory.org/BCPL/project_mac/Richards-BCPL-ReferenceManual.pdf)
and [April 1973 manual](https://people.csail.mit.edu/saltzer/Multics/MHP-Saltzer-060508/filedrawers/177.bcpl/Scan%202.PDF)
were read, along with the complete extracted [November 1974 manual](https://softwarepreservation.computerhistory.org/BCPL/cambridge/richards-manual-1974.pdf).
Some symbols in the scans remain uncertain. The editions differ; none is a
substitute for the selected B manual.

The 1967 text describes a highest-subscript vector bound, all-ones true,
mutable function cells, a numeric global vector, and implementation-dependent
parts of arithmetic. Its argument-list rule requires enough formal parameters
for the longest call. That is not a reason to impose the same restriction on
PDP-11 B.

The 1973 and 1974 manuals distinguish truth-value and bit contexts, describe
contiguous argument cells, and provide explicit mechanisms for non-local
transfers. They also document the IBM 370's EBCDIC characters, word model,
and runtime. Their extension appendices separate optional facilities from
the common language. The 1974 edition adds library and compiler facilities;
those changes should not be attributed to the earlier edition.

Richards's complete [CPL-to-BCPL account](https://www.cl.cam.ac.uk/~mr10/cpl2bcpl.pdf)
was read. It explains the small abstract machine, pointer arithmetic, static
free variables, and global-vector linkage, while also discussing much later
language changes. It is valuable design history, not a single dated language
specification.

The [CTSS distribution page](https://www.cl.cam.ac.uk/~mr10/BCPLCTSS.html)
and [Tripos archive page](https://www.cl.cam.ac.uk/~mr10/Archive.html) were
read as overviews, not as reviews of every archived file. The CTSS page
separates preserved 1968 source from a modified version for a modern runtime.
That distinction must remain visible when using it for comparison.

The complete [BCPL preservation catalog](https://softwarepreservation.computerhistory.org/BCPL/)
was read. It separates ports, source archives, later extensions, and
retrospective accounts, sometimes recording conflicting recollections.
Its TX-2 and Essex histories distinguish an intermediate-code compiler from
the target backend, relocatable output, and loader needed to finish a port.
The catalog is a guide to those artifacts, not evidence that every linked
artifact has been inspected.

The supplied Cambridge book PDF contains only a three-page table of
contents. It was read, but the book itself was not available from that file.
Archive.org metadata likewise identifies editions and download derivatives;
it does not establish language rules.

### The 1974 C manuals

The complete OCR text of the [January 1974 memorandum](https://cm-bell-labs.github.io/who/dmr/cman74.pdf)
and the complete extracted text of the [other supplied C manual](https://cm-bell-labs.github.io/who/dmr/cman.pdf)
were read, including examples and appendices. The second copy includes an
additional implementation-differences appendix. Neither describes the earliest
C compiler used by the restored Unix environment exactly.

These manuals retain some B-era conventions, including octal digits 8 and 9,
but differ from B in types, array and function values, and right-shift behavior.
Their contiguous-argument `printf` example depends on the contemporary ABI;
it does not justify treating separate parameters as an array in modern ISO C.
The implementation appendix also names known compiler defects and differences
between Unix and GCOS. Intended rules, actual compiler behavior, and target
layout must be checked separately.

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

### What the restoration repositories establish

The README files for [aap/b's Unix restoration](https://github.com/aap/b/tree/master/unix1_bdir),
[rswier/pdp11-B](https://github.com/rswier/pdp11-B),
[the PDP-7 restoration](https://github.com/DoctorWkt/pdp7-unix),
[its TMG branch](https://github.com/philbudne/pdp7-unix/tree/tmg),
[June 1972 Unix](https://github.com/DoctorWkt/unix-jun72), and
[V2 beta](https://github.com/TheBrokenPipe/Research-UNIX-V2-Beta) were read.
They describe different reconstructed systems, seed tools, patches, and
memory layouts. A restoration's name is not enough to identify its ABI.
Some preparatory processing runs on the host rather than inside old Unix.

The complete [TMG reconstruction notes](https://github.com/philbudne/pdp7-unix/blob/tmg/misc/tmg-notes.txt)
and [reconstructed B grammar](https://github.com/philbudne/pdp7-unix/blob/tmg/src/other/pbtmg/b.t)
were also read. The notes label uncertainties and missing material. The
grammar is an incomplete dialect, not another authoritative statement of
PDP-11 B. The notes describe an especially useful bootstrap distinction:
a translator can reproduce its generated text while the target assembler
still cannot assemble that text. Source-level agreement is not an executable
self-hosting result.

The [CHM release article](https://computerhistory.org/blog/the-earliest-unix-code-an-anniversary-source-code-release/)
contains provisional identifications of early listings. Later analysis can
revise those identifications; a tentative attribution should stay tentative.
Directory indexes and the V4 setup document were read as provenance and
environment evidence, not as a claim that every linked distribution was
reviewed.

The [aap/abc](https://github.com/aap/abc) and [dbc](https://github.com/dobyrch/dbc)
READMEs describe modern implementations with their own restrictions. The
former is marked obsolete and derives from an early C compiler; the latter
uses LLVM and documents unsupported cases. Neither is a substitute for the
contemporary B manual, and neither README review establishes whole-tree
correctness.

The declaration and expression paths in
[`unix1_bdir/bc.B` at revision 8779d9e](https://github.com/aap/b/blob/8779d9e8684d1daaa47c6fab1705194d732863bb/unix1_bdir/bc.B)
were inspected separately. They mark a definition's own name external and
infer an external when an otherwise undeclared name is followed by `(`.
The reconstruction calls that inference a best-effort way to recognize calls.
It does not settle every scope question in the original manual, or justify
making every external data definition implicitly visible in every function.
Those distinctions need explicit tests rather than a blanket change to all
undeclared names.

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
fixed point. The host goal covers `bcc`, `bccasm`, and the existing bootstrap. A separate
native goal replaces the PDP-11 compiler's early-C implementation with B and
rebuilds it on the PDP-11. Both need a documented seed and a complete rebuild
path; these remain work after the source review and accuracy fixes.

### Threaded code

Bell's complete [1973 paper](https://www.ittc.ku.edu/~kulkarni/teaching/archieve/EECS800-Spring-2008/threaded_code.pdf)
was read. It describes dispatch through routine addresses, inline parameters,
and combinations of threaded and native code. Its speed and size measurements
are tied to particular hardware and workloads; they are not performance
promises for a new B implementation.

The paper helps explain the historical B runtime. It does not require BCC
to use that runtime to implement the language, or make threaded output the
same thing as a native compiler bootstrap.

Dewar's complete [1975 indirect-threaded-code paper](https://figforth.org.uk/library/Indirect.Threaded.Code.p330-dewar.pdf)
was read separately. It adds an indirection through an address cell and
explains the resulting operand and representation choices. Its measured
tradeoffs remain machine-specific. Neither threaded-code paper specifies
BCC's source-language semantics.

### Modern BCPL is implementation guidance, not the B baseline

The extracted text of Richards's [current Cintsys/Cintpos guide](https://www.cl.cam.ac.uk/~mr10/bcplman.pdf)
was read from beginning to end, including its libraries, command reference,
compiler chapters, installation instructions, examples, and appendices. The
retrieved copy is dated June 24, 2026. Diagrams whose contents were omitted
by text extraction still need visual review; this is not a claim that every
figure has been checked.

This guide describes a living BCPL implementation, not the January 1972 B
dialect. Its floating-point additions, pattern matching, conditional
compilation, length-prefixed strings, and global-vector conventions must
not become B72 rules by accident. Chapter 8 dates the removal of writable
non-global function and label cells to 1980. BCC must retain B's earlier
writable cells.

The implementation chapters give several useful checks for BCC's planned
B-written backend:

- Keep source semantics separate from the target instruction set. The
  frontend, intermediate representation, and code generator have distinct
  responsibilities. Document each intermediate instruction's stack effect
  and the state expected at branch destinations.
- Distinguish byte addresses, word addresses, and entry addresses throughout
  the backend and runtime. The guide's native examples convert aligned data
  addresses to word pointers; that does not make arbitrary byte pointers
  interchangeable with B pointers.
- Preserve values across indirect stores only when aliasing permits it.
  Section 9.3.2 reloads a local after an indirect store because the store
  could have changed that local. This is a useful regression pattern for
  any future register-caching optimization.
- Validate relative branch ranges. The Cintcode design uses resolving
  halfwords; the MC package instead requires an appropriate short or long
  branch and diagnoses an insufficient short range. Neither justifies
  silently truncating a displacement in a native backend.
- Calculate constants using the intended target representation. The guide
  explicitly warns that a compiler's own word width can limit constants
  generated for a wider target. BCC's target-width tests must remain
  independent of the host compiler's arithmetic.

The section titled "Bootstrapping Cintsys" describes starting an existing
interpreter and loading modules. Chapter 13 separately explains rebuilding
that interpreter in C and then compiling the BCPL components with supplied
compiled modules. The native path in sections 11.1 and 13.7 still needs
C initialization code, a C runtime interface, handwritten assembly, and
external compilation/linking. These are useful designs, but none proves
a compiler has eliminated its C or assembler dependencies. BCC's
[bootstrap requirements](BOOTSTRAP.md) distinguish those milestones.

Some parts of the guide are explicitly unfinished or describe planned
behavior. The Sial introduction says newer constructs are unsupported,
while later sections describe floating-point operators added in 2014 and
their implementation in `sial-686`. That inconsistency needs a
version-specific source check, not a blanket claim that all Sial backends
support or reject those operators. Sections 10.3 and 10.4 have headings
but no explanatory text, and appendix B is marked under construction.
The console, networking, graphics, and sound APIs are contemporary system
interfaces, not evidence for Unix V1's B library ABI.

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

The complete extracted text of the [1972 PDP-11/40 handbook](https://pdos.csail.mit.edu/6.828/2005/readings/pdp11-40.pdf)
was also read, including addressing, instructions, programming techniques,
memory management, processor options, and appendices. OCR formulas and
some diagrams remain uncertain. The branch page and the processor-family
comparison on printed page 9-3 were checked visually.

The family comparison separates the 11/20's external arithmetic option
from the 11/40's internal extended instruction set. It lists `XOR`, `SOB`,
`MARK`, `SXT`, and `RTT` as additions to the later basic set. A future B-written
PDP-11 backend must not emit them merely because a newer handbook or a
host emulator recognizes them. The existing target uses the earlier
instruction set and memory-mapped arithmetic device.

Chapters 3 through 5 confirm word-sized SP increments even for byte
operations, register sign extension by `MOVB`, and the distinction between
hardware linkage and a software argument convention. `CMP` tests source
minus destination, unlike `SUB`, which stores destination minus source.
Signed comparisons need the overflow-aware conditions, not just the sign
bit. Branch displacements count words from the following instruction;
large transfers need a different encoding rather than a truncated offset.

Memory-management, privileged-mode, floating-point, and programmable
stack-limit descriptions are model- and option-specific. They do not
replace the restored kernel's actual process-memory limits. Appendix C's
timings depend on addressing modes, memory, and installed options, so they
are not universal costs for BCC's native instructions. Appendix A contains
an older-model ISP description and floating-point material; its notation
and scope need checking against the specific CPU, not literal translation
from noisy OCR.

### Terminal hardware and restored-kernel boundaries

The register descriptions and tables in the [September 1973 DC11 manual](https://deramp.com/downloads/mfe_archive/011-Digital%20Equipment%20Corporation/08%20PDP-11/05%20Unibus%20Options/DC11%20Asynchronous%20Line%20Interface/DC11%20Documentation/DC11-A%20Manual%20DEC-11-HDCD-D%20Sep73.pdf)
were checked visually on PDF pages 11-12. Receiver and transmitter speed
selectors occupy bits 3-4, but the four rates depend on the installed clock
option. Receiver bits 9-10 select character width; transmitter bit 8 selects
one versus two stop bits. Other bits report hardware state or control modem
signals, so these words cannot simply hold host `termios` flag values.

This is a later hardware manual, not proof of every 1971 installation's
configuration. The pinned restored kernel also needs separate inspection:
its terminal input code tests `010` as echo-enable, unlike the November
manual's echo-disable description. Native wrappers expose the restored
kernel. Host emulation must name its chosen contract and distinguish mapped
software modes from hardware behavior it cannot reproduce.

## Host toolchain and repository evidence

The selected [C99 consolidated draft](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf)
clauses reviewed here cover integer representations, pointer conversions,
expression sequencing, calls, shifts, inline definitions, and variable
arguments. This is not a review of the entire standard.

C's bitwise operators do not establish left-to-right operand evaluation.
Signed overflow, oversized shifts, incompatible function calls, and reading
past supplied variadic arguments can also be undefined. A B frontend must
implement its own target semantics rather than inherit those cases from C.
Pointer/integer conversions need explicit platform assumptions, and inline
runtime definitions do not automatically share mutable state across modules.
These clauses support separate arithmetic, call-adapter, and multi-file
runtime tests.

The GNU compiler, assembler, and linker entry pages were inspected as host
toolchain references, not historical B specifications. Their indexes are not
the full manuals. The x86-64 ABI was retrieved through the project's official
PDF artifact. The copy is dated March 12, 2025; its complete extracted text
was read, including object files, loading, relocations, unwind information,
ILP32, TLS, CET, and the appendices. This does not establish that BCC
implements every facility described there.

The [AMD64 ABI](https://gitlab.com/x86-psABIs/x86-64-ABI/-/jobs/artifacts/master/raw/x86-64-ABI/abi.pdf?job=build)
requires stack alignment and preserved registers across ordinary calls, and
passes the first integer arguments in registers. A C argument list is not a
contiguous B parameter vector: BCC must construct that representation itself.
Variadic calls carry vector-register information in `al`; the Linux syscall
interface uses `r10` rather than `rcx` for its fourth argument and clobbers
`rcx` and `r11`. A future B-written native host backend must distinguish those
interfaces rather than reuse one call sequence for both.

The ELF chapters matter for removing the external linker. LP64 output uses
ELFCLASS64, little-endian encoding, machine identifier 62, and explicit
addends in `Elf64_Rela` relocations. A linker must check whether a truncated
32-bit relocation reconstructs the full value by the required zero or sign
extension. Loadable segment offsets and virtual addresses must have matching
page offsets, and uninitialized data must begin as zero. Those are separate
tests from whether a tiny executable happens to start.

Process entry is not an ordinary function call: the initial stack contains
`argc`, pointers to arguments and environment strings, and an auxiliary
vector. An entry routine must convert that state to B's string and pointer
representation. ILP32/x32 is a distinct ABI with 32-bit pointers and ELFCLASS32;
selecting 32-bit B arithmetic on an LP64 host does not implement it.

The unwind and CET chapters describe additional contracts, not B language
features. Handwritten assembly needs accurate frame descriptions if unwinding
through it is supported. An output file must not advertise indirect-branch
or shadow-stack compatibility without implementing the corresponding
requirements. A static, syscall-based first backend can avoid a dynamic
loader, PLT, and TLS implementation, but that is a deliberately narrower
output target, not full coverage of the ABI. Chapter 8 itself is unfinished,
and section 3.5 marks its code examples as non-normative; examples still
need assembly and execution checks before use.

The supplied repository snapshots were read in full. They are project claims,
not independent historical evidence. Several old claims were wrong: automatic
vectors were described as initialized scalars, function names as unsuitable
for `extrn`, and native rebuilds as complete B self-hosting. The old native
planning notes also described a system-library link path that the maintained
compiler does not use.

The local first-edition document overview mixed in later C facilities,
including `stdio.h`, `scanf`, and `malloc`, and incorrectly named the
PDP-11/45 as its hardware. November 1971 section III instead describes
assembly routines in `/etc/liba.a`. Its replacement summary cites the scan
and keeps the 134-byte buffer layout distinct from the second edition's
518-byte layout. Other working transcriptions remain subject to checking;
removing those false overview claims does not certify every transcription.

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

## Checks following the review

The host and B-written bootstrap already sequence bitwise `&` and `|`
operands left to right. Existing executable tests cover the side effects;
this review did not establish a new defect in those paths.

The `open` review did find a full-word conversion bug. A nonzero host B word
whose low C `int` bits were zero selected read-only access. Both shared and
inline runtimes now compare the B word itself. The native wrapper normalizes
nonzero modes to one: that preserves the old kernel contract and avoids the
application emulator's later read/write interpretation of other mode values.
Tests check access direction, initial offset, preservation of existing file
contents, and failure to open a missing file.

The native self-rebuild now has an independent host-side disk check. It saves
references before boot, then reads installed binaries and generated library
assembly after the simulator closes its disk images. Comparisons include
exact lengths and every byte, including an odd trailing byte or NUL. This
strengthens the existing rebuild test; it does not turn the C-written native
compiler into a B-written one.

A separate lexical check found that a physical NUL outside a literal could
make the host and bootstrap silently stop reading source. They now diagnose
that byte rather than treating it as end-of-file. `*0` remains the supported
escape for a NUL in literal data. Native parsing already rejects the
outside-literal case.

The native argument-vector check also exposed a deliberate old limit: startup
kept only 31 strings, including the program name. The B manual describes the
kernel argument count and vector, not that truncation rule. Startup now
allocates the complete vector on the stack and checks its size before copying
strings. Fast tests cover forty and one hundred user arguments, empty strings,
and storage overlap; a real-kernel exec fixture checks forty user arguments.
Kernel exec limits and available process memory still apply.

The native no-argument `exit()` path was also reading the saved callee value
as an optional status argument. A fast-observer reproduction returned 190
instead of zero. Empty native calls now reserve an unused zero word; direct
and function-value `exit()` calls terminate with zero in that observer, while
an explicit status remains intact. This is not a claim that the original V1
kernel reports modern process exit status.

A full-system regression also showed that the runner could mistake program
output containing `# ` for the shell prompt and stop before the program
finished. It now waits for a fresh shell-generated completion marker. Separate
protocol tests and kernel fixtures check prompt-like text, empty output, and
output without a final newline. These remain text-console checks, not a
replacement for byte-exact file verification.

The B-written bootstrap also treated a negative source-read result as end of
file. On the host, opening a directory as source could therefore succeed and
emit an empty C translation unit. Read errors now fail before parsing. All
three bootstrap stages test the error separately from missing files, valid
source, and genuinely empty source in both syntax modes. The native source
and intermediate-record scanners had the same error: a failed read could
accept a truncated unit or record. Fault-injection tests compile the actual
scanners with a controlled read routine and distinguish initial and mid-input
errors from ordinary EOF.

The native intermediate-code reader now checks signed decimal fields before
arithmetic can wrap. Previously, malformed records such as `n 65536`, `n -`,
and `n 1x` silently became constants. Boundary tests retain both -32768 and
32767, including leading zeros, while rejecting missing digits, junk, and
out-of-range values. This validates the compiler's internal format; it does
not change B's separately documented wrapping literal scanner.

A separate scope audit against sections 6.1 and 6.3 found that all three
implementations made top-level data definitions visible inside functions
without `extrn`. The native resolver also rejected a local label sharing a
name with an otherwise undeclared external object. The manual requires an
external declaration before first use in each function; an unbound internal
name must instead resolve to a label. Bare-call inference remains a documented
compatibility exception, and a function's own name is available for recursion.
Strict lookup now separates those linkage definitions from declarations in
each function. New cross-backend tests check use-before-declaration,
function-local declarations, saved function values, local shadowing, and
declaration conflicts. Broader regression checks remain necessary; these
cases do not establish complete language conformance.

Private-pseudoterminal tests exposed null-buffer crashes in host `gtty` and
`stty`. Both runtime layouts now reject a null buffer before dereferencing
it. The checks preserve the terminal settings, verify the three-word output
boundary, and retain missing-argument diagnostics. This is a buffer-safety
fix, not the still-missing translation from host termios fields to the
historical DC11 register layout.

The restored kernel and the fast observer also provide different stack
budgets. The kernel configuration used by these tests sets `ecore - core` to octal `040000` (16 KiB),
whereas the observer starts V1/V2 argument stacks just below the KE11 range.
A 16-parenthesis expression passed the observer but failed in the kernel.
Reducing recursive parser frames made it work in the kernel too. The parser
now reserves diagnostic space above the linked storage boundary and reports
stack exhaustion before overwriting that storage. Header-based boundary
tests and real-kernel rejection tests cover the guard; a passing binary-size
check alone does not account for stack use.

Three separate native switch tests exposed overwritten outer case entries,
out-of-range branches across large bodies, and stack growth when `goto` left
a switch. Case dispatch is now streamed as independent comparison nodes.
A matching node removes its selector before entering the body; fall-through
and branches into or out of the body do not remove another word. Tests cover
32 cases in each of two nested switches, long bodies, repeated escapes,
no match, fall-through, and negative case constants. These are implementation
corrections to the control-flow rules, not new B syntax.

A seed-toolchain check showed that the historical C driver can leave an
`a.out` after the linker reports an unresolved symbol. Checking for a fresh
file was therefore not enough. Native builds now require the expected clean
progress output, a complete executable image, and room for arguments and
stack. Tests reject unresolved symbols, malformed C, oversized images, and
stale output. The in-system rebuild checks compiler diagnostics too, before
comparing and installing the result. This closes a validation gap; it does
not turn the C-written compiler into a B-written one. The
[bootstrap goals](BOOTSTRAP.md) describe that separate work.

The June 1972 manual's preface explicitly warns that installations differed
in hardware, memory configuration, and software versions. It singles out
absolute core locations and says the assembler and loader had been reorganized
in anticipation of the PDP-11/45. That is another reason to attach ABI and
memory claims to an edition and tested configuration, rather than treating
one restored image as a universal early-Unix machine.

## Reference inventory

"Read" below describes the review scope, not a promise that every feature in
that source is implemented. Alternative copies and archive indexes are kept
in the inventory so that missing or duplicated material is visible.


### B texts and project entry point

| ID | Reference | Review status |
| --- | --- | --- |
| 001 | [GitHub - frankischilling/bcc: A modern compiler for Ken Thompson's B programming language, transl...](https://github.com/frankischilling/bcc) | Project README snapshot read; project claims checked against primary sources |
| 002 | [Thompson's B Manual](https://cm-bell-labs.github.io/who/dmr/kbman.html) | Read in full |
| 003 | [kbman.pdfA](https://cm-bell-labs.github.io/who/dmr/kbman.pdfA) | Original PDF checked on pages 13-14; full HTML read |
| 004 | [btut.pdf](https://cm-bell-labs.github.io/who/dmr/btut.pdf) | Read in full |
| 005 | [btut.ms](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.html) | HTML rendition read; omitted appendix and transcription defects noted |
| 006 | [bref.ms](https://cm-bell-labs.github.io/who/dmr/bref.html) | Read in full |
| 007 | [bref.pdf](https://cm-bell-labs.github.io/who/dmr/bref.pdf) | PDF rendition: selected sections checked |
| 008 | [B Programming Language Manuals : University of Waterloo : Free Download, Borrow, and Streaming : ...](https://archive.org/details/b-reference-manual) | Catalog description and download inventory read |
| 009 | [B Reference Manual.pdf](https://archive.org/download/b-reference-manual/B%20Reference%20Manual.pdf) | Scan download failed; complete corresponding OCR text read as entry 010 |
| 010 | [B Reference Manual_djvu.txt](https://archive.org/download/b-reference-manual/B%20Reference%20Manual_djvu.txt) | Complete supplied OCR read; damaged syntax and tables need scan checks |
| 011 | [User's Reference to B V4.0.pdf](https://archive.org/download/b-reference-manual/User%27s%20Reference%20to%20B%20V4.0.pdf) | Scan retrieved; complete corresponding OCR text read as entry 012; not all pages visually checked |
| 012 | [User's Reference to B V4.0_djvu.txt](https://archive.org/download/b-reference-manual/User%27s%20Reference%20to%20B%20V4.0_djvu.txt) | Complete supplied OCR read; damaged syntax and tables need scan checks |

### Early Unix manuals and archives

| ID | Reference | Review status |
| --- | --- | --- |
| 013 | [UNIX_ProgrammersManual_Nov71.pdf](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/UNIX_ProgrammersManual_Nov71.pdf) | Complete scan OCR read; ambiguous glyphs and tables need visual checks |
| 014 | [Index of /Archive/Distributions/Research/Dennis_v1](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/) | Directory index read; linked contents not exhaustively reviewed |
| 015 | [Unix Manual, first edition](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/1stEdman.html) | Complete provenance and index page read |
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
| 030 | [v2man.pdf](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v2/v2man.pdf) | Complete OCR text read, including preface, contents and index; ambiguous glyphs need visual checks |
| 031 | [Index of /Archive/Distributions/Research/Dennis_v2](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v2/) | Directory index read; linked contents not exhaustively reviewed |
| 032 | [Index of /Archive/Distributions/Research/1972_stuff](https://www.tuhs.org/Archive/Distributions/Research/1972_stuff/) | Directory index read; linked contents not exhaustively reviewed |
| 033 | [Index of /Archive/Applications/Dennis_Tapes](https://www.tuhs.org/Archive/Applications/Dennis_Tapes/) | Directory index read; linked contents not exhaustively reviewed |
| 034 | [Index of /Archive/Applications/Dennis_Tapes/Gao_Analysis](https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/) | Directory index read; linked contents not exhaustively reviewed |
| 035 | [Index of /Archive/Distributions/Research/McIlroy_v0](https://www.tuhs.org/Archive/Distributions/Research/McIlroy_v0/) | Directory index read; linked contents not exhaustively reviewed |
| 036 | [the-earliest-unix-code-an-anniversary-source-code-release](https://computerhistory.org/blog/the-earliest-unix-code-an-anniversary-source-code-release/) | Complete museum article read through web retrieval; direct fetch failed |
| 037 | [102785108](https://www.computerhistory.org/collections/catalog/102785108) | Not retrieved: 403: Forbidden |
| 038 | [setup.pdf](https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist/setup.pdf) | Complete setup document read |
| 039 | [Index of /Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist](https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist/) | Directory index read; linked contents not exhaustively reviewed |

### Restorations and implementation evidence

| ID | Reference | Review status |
| --- | --- | --- |
| 040 | [GitHub - aap/b: B compiler · GitHub](https://github.com/aap/b) | Project README read; source tree not exhaustively reviewed |
| 041 | [b/unix1_bdir at master · aap/b · GitHub](https://github.com/aap/b/tree/master/unix1_bdir) | Complete project or directory README read; not a full source-tree audit |
| 042 | [TUHS B compiler restored](https://www.tuhs.org/pipermail/tuhs/2023-July/028602.html) | Read in full |
| 043 | [B](https://squoze.net/B/) | Not retrieved: 503: Service Unavailable |
| 044 | [programs](https://squoze.net/B/programs/) | Not retrieved: 503: Service Unavailable |
| 045 | [install](https://squoze.net/B/install) | Not retrieved: 503: Service Unavailable |
| 046 | [GitHub - rswier/pdp11-B: A project to recreate the B compiler for the PDP-11 as authentically as ...](https://github.com/rswier/pdp11-B) | Complete project or directory README read; not a full source-tree audit |
| 047 | [GitHub - DoctorWkt/pdp7-unix: A project to resurrect Unix on the PDP-7 from a scan of the origina...](https://github.com/DoctorWkt/pdp7-unix) | Complete project or directory README read; not a full source-tree audit |
| 048 | [TUHS Listing of early Unix source code from the Computer History Museum.](https://www.tuhs.org/pipermail/tuhs/2025-May/031942.html) | Read in full |
| 049 | [GitHub - philbudne/pdp7-unix at tmg · GitHub](https://github.com/philbudne/pdp7-unix/tree/tmg) | Complete project or directory README read; not a full source-tree audit |
| 050 | [pdp7-unix/blob/tmg/misc/tmg-notes.txt](https://github.com/philbudne/pdp7-unix/blob/tmg/misc/tmg-notes.txt) | Complete raw reconstruction notes read; author marks uncertainties |
| 051 | [pdp7-unix/blob/tmg/src/other/pbtmg/b.t](https://github.com/philbudne/pdp7-unix/blob/tmg/src/other/pbtmg/b.t) | Complete raw reconstructed TMG B grammar read; incomplete dialect |
| 052 | [GitHub - DoctorWkt/unix-jun72: The working source code to PDP-11 Unix from 1972. · GitHub](https://github.com/DoctorWkt/unix-jun72) | Complete project or directory README read; not a full source-tree audit |
| 053 | [GitHub - TheBrokenPipe/Research-UNIX-V2-Beta: A Research UNIX V2 beta from 1972 brought back to l...](https://github.com/TheBrokenPipe/Research-UNIX-V2-Beta) | Complete project or directory README read; not a full source-tree audit |
| 054 | [TUHS 1972 UNIX V2 "Beta" Resurrected](https://www.tuhs.org/pipermail/tuhs/2025-February/031420.html) | Read in full |
| 055 | [GitHub - aap/abc: (OBSOLETE) A B Compiler for x86 · GitHub](https://github.com/aap/abc) | Complete project or directory README read; not a full source-tree audit |
| 056 | [GitHub - dobyrch/dbc: B compiler front end implemented using Flex+Bison+LLVM · GitHub](https://github.com/dobyrch/dbc) | Complete project or directory README read; not a full source-tree audit |
| 057 | [toomey.pdf](https://www.usenix.org/event/usenix09/tech/full_papers/toomey/toomey.pdf) | Full paper read through web retrieval; direct download failed |
| 058 | [restoration-early-unix-artifacts](https://www.usenix.org/conference/usenix-09/restoration-early-unix-artifacts) | Conference entry read; paper reviewed separately |

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
| 080 | [cman74.pdf](https://cm-bell-labs.github.io/who/dmr/cman74.pdf) | Complete scan OCR read; damaged glyphs need visual checks |
| 081 | [cman.pdf](https://cm-bell-labs.github.io/who/dmr/cman.pdf) | Complete manual text read, including examples and appendices |
| 082 | [HOPL C Transcript](https://cm-bell-labs.github.io/who/dmr/hopl.html) | Read in full |
| 083 | [CS-76-45.pdf](https://cs.uwaterloo.ca/research/tr/1976/CS-76-45.pdf) | Full OCR text read; ambiguous symbols need visual checks |

### BCPL sources

| ID | Reference | Review status |
| --- | --- | --- |
| 084 | [History of BCPL](https://softwarepreservation.computerhistory.org/BCPL/) | Complete preservation catalog read; linked artifacts not all reviewed |
| 085 | [Richards-BCPL-ReferenceManual.pdf](https://softwarepreservation.computerhistory.org/BCPL/project_mac/Richards-BCPL-ReferenceManual.pdf) | Full original-scan OCR read; exact glyphs need visual checks |
| 086 | [BCPL Reference Manual (1967)](https://cm-bell-labs.github.io/who/dmr/bcpl.html) | Read in full |
| 087 | [1476793.1476880](https://dl.acm.org/doi/10.1145/1476793.1476880) | Not retrieved: 403: Forbidden |
| 088 | [spe.4380010204](https://onlinelibrary.wiley.com/doi/10.1002/spe.4380010204) | Publisher abstract and references read; full article unavailable |
| 089 | [Richards-Intcode_for_BCPL-1975.pdf](https://softwarepreservation.computerhistory.org/BCPL/cambridge/Richards-Intcode_for_BCPL-1975.pdf) | Full text and appendix read; listing transcription issues remain |
| 090 | [Richards-Bootstrapping_BCPL-1973.pdf](https://softwarepreservation.computerhistory.org/BCPL/cambridge/Richards-Bootstrapping_BCPL-1973.pdf) | Read in full |
| 091 | [Scan 2.PDF](https://people.csail.mit.edu/saltzer/Multics/MHP-Saltzer-060508/filedrawers/177.bcpl/Scan%202.PDF) | Full 1973 manual OCR read, including appendices; glyph checks remain |
| 092 | [richards-manual-1974.pdf](https://softwarepreservation.computerhistory.org/BCPL/cambridge/richards-manual-1974.pdf) | Complete 1974 manual text read, including appendices |
| 093 | [bcpl-language-and-its-compiler](https://www.cambridge.org/bd/universitypress/subjects/computer-science/programming-languages-and-applied-logic/bcpl-language-and-its-compiler?format=PB&isbn=9780521286817) | Not retrieved: 403: Forbidden |
| 094 | [9780521286817_toc.pdf](https://assets.cambridge.org/97805212/86817/toc/9780521286817_toc.pdf) | Complete three-page table of contents read; not the book |
| 095 | [BCPLCTSS](https://www.cl.cam.ac.uk/~mr10/BCPLCTSS.html) | Distribution overview read; archive source not exhaustively reviewed |
| 096 | [BCPL and Tripos Archive](https://www.cl.cam.ac.uk/~mr10/Archive.html) | Archive overview read; linked files not exhaustively reviewed |
| 097 | [cpl2bcpl.pdf](https://www.cl.cam.ac.uk/~mr10/cpl2bcpl.pdf) | Complete paper read |
| 098 | [bcplman.pdf](https://www.cl.cam.ac.uk/~mr10/bcplman.pdf) | Complete extracted text read; diagrams omitted by extraction still need visual review |

### Threaded code and bootstrap trust

| ID | Reference | Review status |
| --- | --- | --- |
| 099 | [362248.362270](https://dl.acm.org/doi/10.1145/362248.362270) | Publisher page unavailable; complete paper read at entry 100 |
| 100 | [threaded_code.pdf](https://www.ittc.ku.edu/~kulkarni/teaching/archieve/EECS800-Spring-2008/threaded_code.pdf) | Complete Bell paper read; adjacent article excluded |
| 101 | [360825.360849](https://dl.acm.org/doi/10.1145/360825.360849) | Publisher page unavailable; complete paper read at entry 102 |
| 102 | [Indirect.Threaded.Code.p330-dewar.pdf](https://figforth.org.uk/library/Indirect.Threaded.Code.p330-dewar.pdf) | Complete two-page paper read through web retrieval; figures need visual checks |
| 103 | [Thompson_1984_ReflectionsonTrustingTrust.pdf](https://www.cs.cmu.edu/~rdriley/487/papers/Thompson_1984_ReflectionsonTrustingTrust.pdf) | Full lecture text read; code figures not independently transcribed |
| 104 | [358198.358210](https://dl.acm.org/doi/10.1145/358198.358210) | Publisher page unavailable; complete lecture read at entry 103 |

### PDP-11 hardware manuals

| ID | Reference | Review status |
| --- | --- | --- |
| 105 | [PDP-11_Handbook_Second_Edition_1970.pdf](https://www.bitsavers.org/pdf/dec/pdp11/1120/PDP-11_Handbook_Second_Edition_1970.pdf) | Complete extracted text read from public mirror; diagrams not all checked |
| 106 | [KA11_ProcessorMan_Sep1970.pdf](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/KA11_ProcessorMan_Sep1970.pdf) | Not retrieved: 403: Forbidden |
| 107 | [KE11-A_ExtendedArithElem.pdf](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/KE11-A_ExtendedArithElem.pdf) | Full OCR read from public mirror; diagrams and numeric tables need checks |
| 108 | [pdp11-40.pdf](https://pdos.csail.mit.edu/6.828/2005/readings/pdp11-40.pdf) | Complete extracted text read; BR and processor-family pages visually checked; other diagrams and OCR formulas need checks |
| 109 | [PDP-11_40_Processor_Handbook_1972.pdf](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/handbooks/PDP-11_40_Processor_Handbook_1972.pdf) | Alternate scan unavailable; complete extracted text of matching handbook reviewed at entry 108 |

### Host language and toolchain references

| ID | Reference | Review status |
| --- | --- | --- |
| 110 | [n1256.pdf](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf) | Reviewed clauses 6.2.6.2, 6.3.2.3, 6.5, 6.5.2.2, 6.5.7, 6.7.4, and 7.15; not the whole standard |
| 111 | [Top (Using the GNU Compiler Collection (GCC))](https://gcc.gnu.org/onlinedocs/gcc/) | Manual overview and relevant contents inspected; not all linked chapters |
| 112 | [C Extensions (Using the GNU Compiler Collection (GCC))](https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html) | Extension overview read; linked extension chapters not all reviewed |
| 113 | [Top (Using as)](https://sourceware.org/binutils/docs/as/) | Assembler overview and relevant contents inspected; not all linked chapters |
| 114 | [Top (LD)](https://sourceware.org/binutils/docs/ld/) | Linker overview and contents read; not all linked chapters |
| 115 | [x86 psABIs / x86-64 psABI · GitLab](https://gitlab.com/x86-psABIs/x86-64-ABI) | Official ABI PDF (March 12, 2025): complete extracted text read; implementation coverage is separate |

### Repository snapshots and catalog records

| ID | Reference | Review status |
| --- | --- | --- |
| 116 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/README.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/README.md) | Complete pinned repository document read; not independent historical evidence |
| 117 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/asm/README.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/asm/README.md) | Complete pinned repository document read; not independent historical evidence |
| 118 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/asm/bootstrap/README.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/asm/bootstrap/README.md) | Complete pinned repository document read; not independent historical evidence |
| 119 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/bcc-pdp/README.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/bcc-pdp/README.md) | Complete pinned repository document read; not independent historical evidence |
| 120 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/bcc-pdp/CONFORMANCE.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/bcc-pdp/CONFORMANCE.md) | Complete pinned repository document read; not independent historical evidence |
| 121 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/NOTES_RUNTIME.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/NOTES_RUNTIME.md) | Complete pinned repository document read; not independent historical evidence |
| 122 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/NOTES_ASSEMBLY.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/NOTES_ASSEMBLY.md) | Complete pinned repository document read; not independent historical evidence |
| 123 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/unix-v1-docs/README.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/pdp-11/unix-v1-docs/README.md) | Complete pinned repository document read; not independent historical evidence |
| 124 | [bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/wiki/B_LANGUAGE.md](https://github.com/frankischilling/bcc/blob/c16e24a6013a5e84d71b1aacfea5f43aab3fddd0/wiki/B_LANGUAGE.md) | Complete pinned repository document read; not independent historical evidence |
| 125 | [b-reference-manual](https://archive.org/metadata/b-reference-manual) | Complete archive metadata read; not a language specification |
| 126 | [bcc/blob/main/README.md](https://github.com/frankischilling/bcc/blob/main/README.md) | Retrieved main snapshot matches corresponding pinned document; read in full |
| 127 | [bcc/blob/main/pdp-11/bcc-pdp/README.md](https://github.com/frankischilling/bcc/blob/main/pdp-11/bcc-pdp/README.md) | Retrieved main snapshot matches corresponding pinned document; read in full |
| 128 | [bcc/blob/main/asm/README.md](https://github.com/frankischilling/bcc/blob/main/asm/README.md) | Retrieved main snapshot matches corresponding pinned document; read in full |
