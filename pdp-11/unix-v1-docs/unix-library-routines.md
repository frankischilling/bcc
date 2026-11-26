# November 1971 Unix assembly library

This is an editorial summary of section III of the first-edition *Unix
Programmer's Manual*, not a verbatim transcription. The previous overview
incorrectly described a later C library. Consult the [local scan](unix-library-routines.pdf)
or [complete original manual](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/UNIX_ProgrammersManual_Nov71.pdf#page=141)
for the original calling sequences and limitations.

## Library and calling conventions

The routines are kept in `/etc/liba.a`. Their interfaces use registers and
inline arguments, not C prototypes. For example, `atoi` takes a callback
through an R5 calling sequence and returns its result in MQ. The callback
supplies a character in R0; the first unused character remains there.

The section covers:

- `atof`, `atoi`, `ftoa`, and `itoa`: numeric conversion using character
  callbacks. The callback must preserve the other registers.
- `ctime` and `ptime`: time conversion and printing, using the AC/MQ time
  returned by the system. The `ctime` page documents a year-boundary bug.
- `exp`, `log`, `sin`, and `cos`: floating-point calculations with the
  simulator active. Their error behavior is described per routine.
- `fptrap`: simulation of a subset of PDP-11/45 floating-point instructions.
  Its presence does not make the host processor a PDP-11/45.
- `getw`, `getc`, and `fopen`: buffered input.
- `putc`, `putw`, `fcreat`, and `flush`: buffered output.
- `mesg`: output of an inline NUL-terminated string.
- `switch`: a value/label table dispatcher, terminated by a null label.

## Buffered I/O layout

The caller supplies a word-aligned 134-byte buffer: three words for the file
descriptor, remaining character count, and current character pointer, followed
by 128 data bytes. This is not a C `FILE` object. The larger 518-byte buffer
belongs to the June 1972 manual and must not be substituted here.

`getc` reports EOF or a read error through the carry bit. `getw` and `getc`
may be mixed without requiring an even file position. `flush` writes buffered
output but does not close the file. The output routines do not all report
errors: the manual specifies an error result for `fcreat`, but not for the
other buffered-output calls.

## Relationship to B

B-callable library routines are described separately in the B manual and
`/etc/libb.a` listing. A similar routine name does not imply the same ABI.
BCC's native runtime has its own calling convention; see
[the maintained runtime notes](../NOTES_RUNTIME.md).
