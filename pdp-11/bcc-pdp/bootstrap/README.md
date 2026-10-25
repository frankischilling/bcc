# B-written native passes

This directory contains an experimental B version of the `b01` resolver.
It is not installed in place of the native C pass. The source matches the
reference resolver in host-side comparisons, but the current generated
native program does not fit the PDP-11's 16 KB process limit.

The host compiler still builds these tests through C and uses its C runtime.
The native frontend, code generator, and driver also remain C-written. This
is one component of the [B bootstrap work](../../../wiki/BOOTSTRAP.md), not
a completed self-hosting toolchain.

## Source layout

- `src/io.b` writes packed bytes, formats signed record fields, reports errors,
  and writes the driver's completion marker after successful output.
- `src/ic.b` reads bounded records and checks signed 16-bit decimal fields.
- `src/symbols.b` stores symbol names as packed bytes, with separate B-cell
  arrays for their classes and offsets.
- `src/b01.b` resolves declarations, names, and labels, and reorders global
  initializer records around literal data.

Record buffers use NUL terminators. B source literals use EOT terminators.
The separate output and comparison helpers preserve that distinction. Byte
positions are accessed through `char` and `lchar`, rather than treating a B
pointer increment as one byte.

## Comparison checks

From the repository root:

```sh
make
make -C pdp-11/bcc-pdp
python3 pdp-11/bcc-pdp/bootstrap/test_resolver.py
```

The harness builds the B source for the host compiler's 16-bit, 32-bit, and
host-word models. Each version runs on the modern host. The reference C
resolver runs under the native application emulator. Their output bytes,
diagnostics, and success/failure results must agree on the native test corpus
and additional malformed-record cases.

Fixtures rejected by the frontend do not exercise the resolver and are
reported separately. These comparisons do not establish that the B resolver
fits, runs, or rebuilds itself inside Unix V1. Native memory use and the
remaining compiler/runtime ports are separate checks.

## Unix V1 component check

```sh
bash pdp-11/bcc-pdp/bootstrap/test_v1.sh
```

This boots the restored kernel, compiles the B-written I/O and record-reader
modules with the installed seed compiler, and runs the result. The program
creates a record file, reads its tag and signed minimum value, checks EOF,
and prints `-32768`. The harness checks the exact output. It does not run the
full resolver or replace any installed compiler pass.

## Compact-code experiment

`experiments/paged.b` is a small B-written execution loop with eight
operations and a 512-byte code cache. It creates a test instruction file,
counts to 1,000, and branches across a cache-page boundary. `test_v1.sh`
compiles and runs it inside Unix V1 and requires `OK` as its exact output.

The complete test image, including its fixture writer and linked runtime,
occupies 10,786 bytes with the current seed. That leaves room for this test's
stack, but is not a size estimate for a complete B interpreter. Calls, local
frames, the remaining operators, compiler-sized data, and a B-written
instruction encoder are not implemented by this experiment.

The VM harness reports host wall time around guest compilation and execution.
Those timings include emulator and console overhead; they are not PDP-11
hardware timings or a fair native-versus-interpreted benchmark by themselves.
The experiment checks whether paged code is practical in this environment,
not whether the B compiler can already use it.
