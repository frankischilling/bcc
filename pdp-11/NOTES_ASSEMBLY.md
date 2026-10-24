# Native PDP-11 assembly notes

BCC's native emitter targets the restored Unix assembler, not GNU `as` or
DEC PAL-11R. The current implementation is in `bcc-pdp/src/bcg.c` and its
companion emitter files. The [native compiler guide](bcc-pdp/README.md)
describes the complete pipeline.

## Calling convention

R0 carries a function result and R5 is the frame pointer. The caller evaluates
arguments left to right, then reverses their stack slots so the first argument
is closest to the return address. After the callee saves R5, argument zero is
at `4(r5)`, argument one at `6(r5)`, and so on. Locals are below R5.

Function cells hold code addresses. A handwritten call to a runtime binding
uses `jsr pc, *_putchar`; jumping to `_putchar` itself would execute the cell
as an instruction. The emitter also supports computed callees. Data pointers
use word addresses, so dereferencing a B pointer requires conversion to a
byte address. A code address is not a B data-pointer value.

## Assembler and executable versions

The pinned assembler produces a later `0407` container. The native driver
validates that output and writes a stripped `0405` V1 executable. The V1
header has six words and its text size includes the header. It is not the
later eight-word text/data/bss header.

See [a.out(V), November 1971](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man5/a.out.5)
and the [source review](../wiki/SOURCE_REVIEW.md) for the field layouts and
the original manual's printed `0205` typo. Do not reuse V2 relocation or
symbol records under a V1 header.

The output targets PDP-11/20 instructions. Multiplication and division use
runtime helpers rather than assuming the processor has EIS instructions.
The full-system tests exercise the assembled program in the restored kernel;
the fast harness uses a separate test container to expose emulator results.
