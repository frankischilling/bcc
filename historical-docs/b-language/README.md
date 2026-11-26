# B language and its predecessors

Use Ken Thompson's January 1972 manual as the primary language reference
for the PDP-11 target. The Honeywell and Waterloo documents describe other
B environments; the BCPL and Eh documents help explain where the dialects
diverged. Do not infer PDP-11 behavior from those manuals alone.

Local copies are under `historical-docs/downloads/b-language/`. The
[manifest](sources.json) records their filenames, source URLs and SHA-256
hashes.

| Document | Relevance |
| --- | --- |
| [Ken Thompson, Users' Reference to B (January 7, 1972)](https://cm-bell-labs.github.io/who/dmr/kbman.pdf) | Original PDP-11 manual scan; syntax, storage, expression rules, library interfaces and examples. |
| [S. C. Johnson, Users' Reference to B on MH-TSS (1973)](https://minnie.tuhs.org/Mirrors/Dennis/bref.pdf) | Original scanned reference from Bell Labs CSTR 8; Honeywell 6070 dialect, not the PDP-11 ABI. |
| [B. W. Kernighan, A Tutorial Introduction to the Language B (1973)](https://minnie.tuhs.org/Mirrors/Dennis/btut.pdf) | Original scanned tutorial from CSTR 8; examples and contemporary language usage. |
| [Martin Richards, BCPL Reference Manual, MIT Project MAC M-352 (1967)](https://softwarepreservation.computerhistory.org/BCPL/project_mac/Richards-BCPL-ReferenceManual.pdf) | Karl Kleine's scan, with examples missing from the other copy. |
| [BCPL Reference Manual, Neumann copy (1967)](https://cm-bell-labs.github.io/who/dmr/bcpl.tif) | Original marked-up scan preserved by Dennis Ritchie; useful for checking notation and provenance. |
| [University of Waterloo, CS-75-29 (1975)](https://cs.uwaterloo.ca/research/tr/1975/CS-75-29.pdf) | Contemporary discussion of portability and using B as a systems implementation language. |
| [P. Braga, Eh Reference Manual (1976)](https://cs.uwaterloo.ca/research/tr/1976/CS-76-45.pdf) | Related language with explicit changes from B. |
| [Waterloo B Reference Manual (1978)](https://archive.org/download/b-reference-manual/B%20Reference%20Manual.pdf) | Later Honeywell/Waterloo B syntax, storage and library conventions. |
| [User's Reference to B, version 4.0 (1979)](https://archive.org/download/b-reference-manual/User%27s%20Reference%20to%20B%20V4.0.pdf) | Later reference with revised calling and runtime conventions. |
| [Thinkage B Language Reference Manual](https://www.thinkage.ca/gcos/expl/b/manu/manu.html) | Later GCOS8 language rules and extensions. |
| [Thinkage B Tutorial Guide](https://www.thinkage.ca/gcos/expl/b/tuto/tuto.html) | Examples for the later GCOS8 dialect. |
| [Dennis Ritchie, The Development of the C Language (1993)](https://cm-bell-labs.github.io/who/dmr/chist.html) | Firsthand account of the transition from BCPL through B to C. |

For searchable text, see Ritchie's [Thompson manual transcription](https://cm-bell-labs.github.io/who/dmr/kbman.html),
[CSTR 8 introduction and transcriptions](https://cm-bell-labs.github.io/who/dmr/bintro.html),
and [BCPL provenance notes](https://cm-bell-labs.github.io/who/dmr/bcpl.html).
Check the scans for ambiguous operators and punctuation. The [BCPL History
Collection](https://softwarepreservation.computerhistory.org/BCPL/) also
indexes early compiler sources and later BCPL documents.

The [source review](../../wiki/SOURCE_REVIEW.md) and [historical conformance
guide](../../wiki/HISTORICAL_CONFORMANCE.md) describe which of these sources
apply to BCC's strict dialect and which describe later or different systems.

The archive preserves original files, including copyright notices. Permission
to study or download a manual is not necessarily permission to redistribute
it. These copies remain local; the tracked catalog provides the source
locations and hashes.
