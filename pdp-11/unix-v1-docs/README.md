# Historical Unix documents

This directory contains scanned manual sections, working Markdown
transcriptions, and a later C manual. They are different kinds of evidence.
The Markdown files are not a certified or complete transcription of the
November 1971 manual; some contain omissions, transcription errors, or
editorial additions.

Use the [original first-edition scan](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/UNIX_ProgrammersManual_Nov71.pdf)
by K. Thompson and D. M. Ritchie to check exact wording. The
[source review](../../wiki/SOURCE_REVIEW.md) records review scope and known
version differences. The first edition describes the PDP-11/20-era system,
not a C-based PDP-11/45 Unix environment.

## Files

- `manintro.md` and `manintro.pdf`: manual introduction.
- `unix-commands-p1` through `unix-commands-p4`: command sections.
- `unix-sys-calls.md` and `unix-sys-calls-p2.md`: system-call transcriptions.
- `unix-library-routines.pdf`: section III, assembly-language subroutines.
  Its Markdown companion is a sourced summary, not a verbatim transcription.
- `unix-special-files`, `unix-file-formats`, `unix-user-maintained-software`,
  and `unix-miscellaneous`: the remaining manual sections. The file-format
  PDF retains the filename `unix-file-foramts.pdf`.
- `CMAN74.md`, `CMAN74_full.tex`, and `CMAN74.pdf`: local renditions of a
  later C reference. Compare them with Ritchie's
  [January 15, 1974 memorandum](https://cm-bell-labs.github.io/who/dmr/cman74.pdf).
  They are not a description of the restored early C compiler's exact dialect.

November 1971 section III describes routines in `/etc/liba.a` with assembly
calling sequences. It does not document a K&R C standard library, `stdio.h`,
or a `malloc`/`scanf` API. Nor does the first-edition syscall list contain
`pipe`. The older overview incorrectly attributed those later facilities
to this manual.

The historical pages describe programs as they existed, including defects.
Keep such defects distinct from BCC's intended behavior. Editorial corrections
should be labeled rather than silently changing a quotation. For example,
the file-format transcription retains the printed `0205` number but explains
why the `br .+14` instruction is actually `0405`.

For supported build steps and the compiler's current runtime, use
[`bcc-pdp/README.md`](../bcc-pdp/README.md), not the historical command examples.
