# B-written native code generator

This experimental pass reads resolved compiler records and emits PDP-11
assembly. It follows the native C generator's word-pointer calling convention,
including writable function and label cells, argument reversal, computed
gotos, mutable literal occurrences, and collision-free external names.

The source is split by responsibility:

- `bcg.b` emits operations, calls, frames, and branches.
- `bcgnew.b` handles switches, globals, label cells, and symbol names.
- `blit.b` streams each literal into a separate writable data block.
- `b1drv.b` dispatches compiler records, combining adjacent address/load records.
- `driver.b` handles `-i`, `-o`, the library namespace flag `-l`, and the
  successful-output marker `-s`.

The pass shares the resolver's packed-byte I/O and record-reading modules.
Assembly templates are EOT-terminated B strings; record names are
NUL-terminated bytes. Those are separate output paths. File-close checks
use B's negative-error convention, not the early C library's positive-error
convention.

The historical assembler still turns this output into an executable. Runtime
selection and image conversion also remain external helpers. Emitting exact
assembly is a compiler-port milestone, not an assembler-free bootstrap.

Build a host comparison executable from the repository root:

```sh
python3 pdp-11/bcc-pdp/bootstrap/tools/build_passes.py codegen codegen-host --host-bcc ./bcc
./codegen-host -i code.ic -o program.s
```

The host build still uses the C-based seed. A VM image of this pass runs under
the paged B engine; it is not a directly loaded PDP-11 compiler executable.
The installed native compiler continues to use the C-written `b1` pass.


`-L` emits bundled-library assembly with a separate internal label namespace.
It includes `-l` behavior and assigns the B/C/LC prefixes during code emission,
so a library rebuild does not need a separate `sed` pass. Ordinary `-l` output
retains its existing namespace for byte comparisons with the seed.
