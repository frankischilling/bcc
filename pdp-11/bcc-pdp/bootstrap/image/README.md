# Native image writer

This B-written tool reads the assembly emitted by the native B backend and
writes a fixed-origin Unix V1 executable. It writes the six-word `0405`
header itself; constructing the output does not call an external assembler,
linker, or image converter. The tool is experimental and does not replace
the installed compiler's assembler step.

Build a host comparison executable from the repository root:

```sh
python3 pdp-11/bcc-pdp/bootstrap/tools/build_passes.py image /tmp/bimage \
  --host-bcc ./bcc --word 16
/tmp/bimage program bmain.s brt.s program.s
```

The input files must already contain the selected startup code, primitive
runtime, any required B library assembly, and generated program assembly.
Runtime selection and compiler-driver replacement are separate work. The
host comparison build still uses the host C toolchain. Omitting `--host-bcc`
builds a paged instruction image using the native C seed and Python encoder.

## Accepted input

The writer supports the PDP-11 instructions and addressing modes used by
BCC, labels and forward references, repeated single-digit local labels,
absolute and text-relative expressions, `.text`, `.globl`, `.byte`, `.even`,
angle-quoted byte strings, and forward location-counter padding. Names use
seven significant characters and ignore case. Expressions follow the early
assembler's left-to-right evaluation, with square brackets for grouping.
The native runtime's `ac` and `mq` names refer to the KE11 hardware registers.

This is not a general replacement for the historical assembler. It does not
produce relocatable objects or support separate data/BSS sections, conditional
assembly, archives, or arbitrary system-call name tables. Signed division
uses the B execution model; agreement on every historical assembler arithmetic
edge case has not been established. The fixed origin is octal `40014`.

## Limits and failure behavior

The complete native file, including its 12-byte header, cannot exceed 16 KB.
There are 1,024 symbol slots, including predefined names and local-label
instances. Expression nesting is bounded to 16 active atoms. The writer
rejects unresolved symbols, out-of-range branches, odd-addressed words,
unsupported syntax, output-size overflow, and failed I/O.

The output is opened only after the layout pass. A failure during the output
pass can leave an incomplete file; callers must discard it when the writer
returns failure. Use a new temporary output path and publish it only after a
successful run. Exact input/output filename matches are rejected, but path
aliases and hard links are not detected. The caller owns file isolation.

The native creation mode includes execute permission. Host execution models
map permissions differently, so use the Unix V1 kernel check to verify native
file creation and execution rather than inferring them from host file modes.

`test_image.py --engine-vm` also reconstructs the full native execution engine
under both VM builds. This is a slow comparison test with a 30-minute limit
per engine run. The ordinary `--vm` check uses smaller selected programs.
