# B-written instruction encoder

This pass converts resolved native compiler records into an image for the
paged B execution engine. It emits little-endian 16-bit words directly;
no assembler or linker is involved in that conversion. It does not emit a
native executable and is not a replacement for the native `b1` code generator.

The encoder makes three input scans: static layout, code sizing and labels,
then output. It buffers input and output in 128-byte blocks. External names
use 32 first-character buckets with up to 200 entries. Code labels use a
1,280-slot open-addressed table, and up to 512 literal occurrences have
separate data addresses. A full table fails rather than looping
forever. The image must fit 32,700 code words and leave space in the
8,192-word heap for arguments and execution frames.

Adjacent external-address and dereference records use the VM's direct-load
operation. A label or any other intervening record prevents that combination.
The Python seed encoder implements the same encoding independently, so the
test compares every output byte rather than only a program's exit status.

The input is expected to come from the resolver. Some malformed records are
rejected, but this is not a complete validator for arbitrary intermediate
files. The output is created only after layout and sizing succeed. An I/O
failure during emission can still leave a partial file; callers must require
successful completion before using it. This prototype does not implement the
installed native driver's completion-marker protocol.

Build a host comparison executable from the repository root:

```sh
python3 pdp-11/bcc-pdp/bootstrap/tools/build_passes.py encoder encoder-host --host-bcc ./bcc
./encoder-host code.ic output.vm
```

That build still uses the allowed C-based seed. Running the resulting B
encoder performs the image conversion itself. Building the execution engine,
writing native executable images, and replacing the remaining runtime and
driver dependencies are separate bootstrap tasks.
