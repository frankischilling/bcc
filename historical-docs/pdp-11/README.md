# PDP-11/20 hardware and assembly references

The manuals here describe the KA11 processor and the peripherals used in the
PDP-11/20 era. They are the hardware references for the PDP-11 backend,
instruction encoder and emulator. The local [project notes](project-notes/)
are BCC documentation, not DEC publications.

The original scans are stored under `historical-docs/downloads/pdp-11/`.
[sources.json](sources.json) records the exact download URL and SHA-256 of
each PDF so the same files can be recovered and checked later. Page counts
below are PDF page counts, including covers and unnumbered pages.

## Digital Equipment Corporation manuals

| Original document | PDF pages | Scope |
| --- | ---: | --- |
| [PDP-11 Handbook, second edition (1970)](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/PDP-11_Handbook_Second_Edition_1970.pdf) | 116 | Registers, addressing modes, instruction repertoire, condition codes, traps, Unibus and console operation. Copyright 1969. |
| [KA11 Processor Manual (September 1970)](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/KA11_ProcessorMan_Sep1970.pdf) | 168 | Early processor manual for the original KA11. |
| [KA11 Processor Manual, fifth printing (May 1972), DEC-11-HR2B-D](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/KA11_ProcessorMan.pdf) | 91 | Detailed instruction execution, addressing and processor state diagrams. Copyright 1970, 1971, 1972. |
| [PDP-11/20 System Manual (May 1973), DEC-11-HR1B-D](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/1120_SystemManual.pdf) | 27 | System components, configuration, console, loading and operation. |
| [KE11-A Extended Arithmetic Element (1971), DEC-11-HKEA-D](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/KE11-A_ExtendedArithElem.pdf) | 47 | Arithmetic device programming, registers, multiplication, division, shifts and hardware behavior. |
| [KY11-A Programmer's Console Manual (September 1970)](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/1120/KY11A_ConsoleManual_Sep1970.pdf) | 21 | Programmer's console controls and hardware. |
| [PDP-11/20 Processor Handbook (1972)](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/handbooks/PDP-1120_Handbook_1972.pdf) | 234 | Processor instructions, addressing, interrupts and the KE11-A programming reference in chapter 8 of part I. |
| [PDP-11 Peripherals Handbook (1972)](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/handbooks/PDP-11_PeripheralsHbk_1972.pdf) | 306 | Device descriptions and programming references. |
| [PDP-11 Conventions Manual (September 1970), DEC-11-HR6A-D](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/handbooks/DEC-11-HR6A-D_PDP-11_Conventions_197009.pdf) | 39 | Hardware conventions and system integration. |
| [PAL-11R Assembler Programmer's Manual (May 1971), DEC-11-ASDB-D](https://bitsavers.trailing-edge.com/pdf/dec/pdp11/dos-batch/DEC-11-ASDB-D_PAL-11R_Assembler_Programmers_Manual_May71.pdf) | 86 | DEC assembly language and assembler conventions. The Unix assembler has its own syntax and object format. |

## Contemporary architecture paper

[A New Architecture for Mini-Computers: The DEC PDP-11](https://archive.computerhistory.org/resources/text/DEC/pdp-11/dec.pdp-11.a_new_architecture_for_mini-computers-the_dec_pdp-11.1970.102630380.pdf),
by G. Bell, R. Cady, H. McFarland, B. Delagi, J. O'Laughlin, R. Noonan
and W. Wulf (1970), is the original architecture paper from the Spring
Joint Computer Conference. The Computer History Museum scan contains 19
PDF pages. It explains the design goals, instruction and register organization,
and Unibus architecture. No separate redistribution permission was established.

## Reading order

Use the 1970 handbook for base instruction encoding and addressing. Consult
the KA11 manuals when a question involves the processor's internal behavior
or instruction execution. The two printings are distinct documents and have
different page counts.

For arithmetic, consult the KE11-A manual and the 1972 processor handbook.
The KA11 has no native multiply or divide instructions. The optional KE11-A
is a Unibus peripheral with memory-mapped registers; later processors have
different instruction capabilities. Do not infer 11/20 behavior from a later
PDP-11 instruction set.

The [Unix references](../unix/README.md) cover `as`, `ld`, system calls and
`a.out`. PAL-11R is useful for comparison, but its object format is not the
Unix executable format.

## Redistribution

DEC is the original publisher and its copyright notices remain in the
scans. No explicit permission to redistribute these complete manuals was
established. Keep the PDFs in the ignored download directory; track the
catalog and source links. Public access to the scans is not a license.

The main Bitsavers host returned HTTP 403 during retrieval on November 26,
2026. The trailing-edge mirror supplied all ten manuals. All eleven PDFs,
including the CHM paper, passed PDF header/trailer and page-tree checks and
have distinct SHA-256 digests.
