# Early Unix manuals and implementation

These are contemporary documents from Bell Laboratories, with later
commentary and a source license for reference. The first two manuals describe the PDP-11/20
era. The 1974 C memorandum and sixth-edition documents describe later
systems and should not be used as evidence for an earlier C dialect or
executable format without checking the earlier source.

The original files are stored under `historical-docs/downloads/unix/`.
[sources.json](sources.json) contains their original download URLs and
SHA-256 digests. The existing [first-edition sections and working
transcriptions](../unix-v1-docs/README.md) remain separate from these
complete scans.

## First and second editions

| Original document | Use |
| --- | --- |
| [UNIX Programmer's Manual, first edition, November 3, 1971](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/UNIX_ProgrammersManual_Nov71.pdf) | Complete edition, including the `as(I)`, `ld(I)`, system call, subroutine and `a.out(V)` references. It supplements the existing individually scanned sections. |
| [UNIX Programmer's Manual, second edition, June 12, 1972](https://bitsavers.trailing-edge.com/pdf/att/unix/Early_UNIX/Unix_2nd_Edition_Manual_Jun72.pdf) | Complete edition with revised assembler, loader, file formats and the early `cc(I)` command. Its preface explains that the assembler and loader were reorganized in anticipation of the PDP-11/45. |
| [Kernel Subroutine Descriptions, March 1972](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/Kernel_Subroutine_Descriptions_Mar72.pdf) | Contemporary descriptions of kernel routines. |
| [Preliminary Release of Unix Implementation, June 1972](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/PreliminaryUnixImplementationDocument_Jun72.pdf) | Early Unix implementation listing; the surviving V1 kernel source in the Unix Heritage Society tree was recovered from this document. |
| [Unix Users Talk Notes, January 1973](https://bitsavers.trailing-edge.com/pdf/att/unix/Early_UNIX/Unix_Users_Talk_Notes_Jan73.pdf) | Contemporary material about Unix use. |
| [PDP-11 TMG Manual (1972)](https://www.tuhs.org/Archive/Distributions/Research/1972_stuff/tmg.pdf) | 24-page scan of the manual for the compiler-writing language used in early Unix. |
| [The UNIX Time-Sharing System, early draft](https://www.tuhs.org/Archive/Distributions/Research/McIlroy_v0/UnixEditionZero.txt) | Recovered text transcription of an early description of Unix. The exact date is uncertain. |

Read the first-edition `as(I)`, `ld(I)` and `a.out(V)` entries together.
They describe assembly syntax, symbol resolution, relocation and the
six-word executable header for that edition. The printed branch opcode in
the V1 manual contains an apparent error; see the existing
[file-format transcription](../unix-v1-docs/unix-file-formats.md) and check
the implementation when resolving it. Do not substitute the later Unix
executable layout. The second-edition manual is useful for identifying
changes, including differences in assembler behavior and file formats.

## Third through fifth editions

These documents record later Unix systems. The V3 preface specifically
warns that installations with a PDP-11/20 cannot use all the described
software and should consult the earlier manuals instead.

| Document | Use |
| --- | --- |
| [UNIX Programmer's Manual, third edition (February 1973)](https://bitsavers.trailing-edge.com/pdf/att/unix/3rd_Edition/UNIX_Programmers_Manual_Third_Edition_Feb73.pdf) | 276-page original scan; later commands, system calls and maintenance documentation. |
| [UNIX Programmer's Manual, fourth edition (November 1973)](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v4/v4man.tar.gz) | Recovered roff manual source archive, not a page scan. The [archive notes](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v4/Readme.v4man) document its provenance. |
| [UNIX Programmer's Manual, fifth edition (June 1974)](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v5/v5man.pdf) | 306-page scan of the fifth edition. |
| [D. M. Ritchie and K. Thompson, The UNIX Time-Sharing System](https://www.cs.cmu.edu/~15712/papers/ritchie74.pdf) | 11-page original journal article, *Communications of the ACM* 17(7), July 1974, pp. 365-375, DOI [10.1145/361011.361061](https://doi.org/10.1145/361011.361061). Describes the PDP-11/40 and /45 system, rather than the earlier 11/20 implementation. |

## Early C and assembler documentation

| Original document | Use |
| --- | --- |
| [D. M. Ritchie, The C Reference Manual, January 15, 1974 (TM 74-1273-1)](https://cm-bell-labs.github.io/who/dmr/cman74.pdf) | The original Bell Labs memorandum scan. The existing `CMAN74` renditions in this repository are different files. |
| [Documents for Use with the UNIX Time-Sharing System, sixth edition (1975)](https://archive.computerhistory.org/resources/access/text/2024/10/102659317-05-01-acc.pdf) | Computer History Museum scan, accession 102659317. Contains the C reference manual, Kernighan's C tutorial and Ritchie's UNIX Assembler Reference Manual. Use as a later comparison. |
| [D. M. Ritchie, UNIX Assembler Reference Manual](https://www.tom-yam.or.jp/2238/ref/as.pdf) | Stand-alone 11-page groff rendition produced in 2003 from the historical text. Useful for searching assembler syntax separately from the sixth-edition scan; it is not a new original edition or a V1 specification. |

Ritchie's [Very early C compilers and language](https://cm-bell-labs.github.io/who/dmr/primevalC.html)
describes two surviving 1972-73 compilers and links their source. An unchanged
copy of the HTML is preserved locally as `primevalC.html`. The earlier
`last1120c` compiler lacks structures; its surviving source is stronger
evidence for that dialect than the January 1974 memorandum. Ritchie's
[1972 Unix talk notes](https://cm-bell-labs.github.io/who/dmr/notes.html)
are an author-edited web rendition of contemporary notes, with later
annotations. The original individual compiler files remain linked from
Ritchie's page; no reconstructed compiler tree is included here.

The [TUHS first-edition source tree](https://www.tuhs.org/cgi-bin/utree.pl?file=V1)
and [second-edition source tree](https://www.tuhs.org/cgi-bin/utree.pl?file=V2)
provide browsable surviving code and manual text. They are separate from
the original scans. The V1 OCR and local transcriptions should be checked
against the scanned pages when exact wording or octal values matter.

## Redistribution

The second- and third-edition manuals carry a 1972 Bell Telephone Laboratories
copyright notice and explicitly require written permission for reproduction
or distribution outside the Laboratories. The fifth-edition manual carries
1972, 1973 and 1974 Bell Telephone Laboratories copyright notices. The sixth-edition volume says
that its documentation is supplied under a Western Electric software
agreement. Keep these scans local. No separate permission to redistribute
the other manuals, transcriptions or commentary was established either.
The 1974 ACM article has an express non-profit republication permission
conditional on preserving the copyright notice, publication reference, date,
and acknowledgement of ACM's permission. It remains in the ignored directory
with the other reference documents.

The [Caldera license letter, January 23, 2002](https://www.tuhs.org/Archive/Caldera-license.pdf)
is included as a rights reference. It grants rights to named ancient Unix
source code, including PDP-11 versions 1 through 7, subject to its conditions.
It also specifies conditions for redistribution of source and documentation.
The grant is scoped to named source code; it does not establish that every
independently published Bell Labs manual scan is covered. Treat the historical
documents as local reference copies unless their specific rights are confirmed.

All originals and the license letter are kept under the ignored downloads
directory. Track this catalog and the manifest. Downloads were retrieved on
November 26, 2026. The PDF files were checked for headers, trailers and page
trees, the V4 tar archive for readable members, and the HTML and text for
expected content. Each manifest entry records the exact file's SHA-256 digest.
