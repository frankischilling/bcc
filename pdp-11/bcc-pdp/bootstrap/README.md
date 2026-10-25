# B-written native passes

This directory contains experimental B implementations of the frontend,
resolver, paged instruction encoder, PDP-11 assembly generator, and native
image writer. A B-written runtime selector and build driver connect these
components. They are
not installed in place of the native C passes. The B versions run through a
separate [paged execution engine](vm/README.md), which keeps most of their
code and data in files to fit the PDP-11 process limit.

The host comparison builds still use C and the host runtime. The native seed
compiler builds the execution engine. The installed build still uses the
historical assembler; an experimental B image writer can replace that
construction step for supported inputs. Runtime assembly and external test
drivers remain. These are
[bootstrap components](../../../wiki/BOOTSTRAP.md), not a completed
independent toolchain.

## Source layout

- `src/buffered_io.b` buffers compiler output in 256-byte blocks, formats
  record fields, and writes completion markers after successful output.
  Diagnostics remain immediate. `src/io.b` is the smaller unbuffered variant
  used where only diagnostics and markers need those helpers.
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

The test reserves 3,072 data cells, checks that the last cell survives the
loop, and uses a separate 512-byte code cache. The complete test image,
including its fixture writer and primitive runtime, occupies 10,872 bytes
with the current seed. The compiler omits the unused B-written library (4,396 bytes), exec
helpers (804 bytes), and process/metadata helpers (658 bytes). Linking all
three would put this test over the limit.
Calls, local frames, the remaining operators, and a B-written instruction
encoder are not implemented by this experiment. This is not a size estimate
for a complete B interpreter.

The VM harness reports host wall time around guest compilation and execution.
Those timings include emulator and console overhead; they are not PDP-11
hardware timings or a fair native-versus-interpreted benchmark by themselves.
The experiment checks whether paged code is practical in this environment,
not whether the B compiler can already use it.

The kernel checks build in `/usr/tmp` on the RK disk. The smaller RF root
filesystem also holds swap and kernel storage; a large assembler output
and its converted copy can exhaust its free space. This choice changes the
scratch filesystem, not the 16 KB process-memory limit.

The newer `vm/` experiment adds call frames, operators, paged data, primitive
I/O, and argument startup. It has separate tests; the eight-operation
example above remains a small independent check. A B-written encoder now accompanies the independent Python seed encoder.
The native C-written compiler still builds the engine.


## Frontend and code generators

The [frontend](frontend/README.md) emits unresolved compiler records. The
[encoder](encoder/README.md) converts resolved records into VM images. The [native assembly generator](codegen/README.md) provides a separate
output path for PDP-11 instructions. None replaces an installed native pass yet. Their B sources can be built as host
comparison programs or encoded for the paged engine:

```sh
python3 pdp-11/bcc-pdp/bootstrap/tools/build_passes.py frontend frontend.vm
python3 pdp-11/bcc-pdp/bootstrap/tools/build_passes.py resolver resolver.vm
python3 pdp-11/bcc-pdp/bootstrap/tools/build_passes.py encoder encoder.vm
python3 pdp-11/bcc-pdp/bootstrap/tools/build_passes.py codegen codegen.vm
python3 pdp-11/bcc-pdp/bootstrap/test_passes.py --vm
```

The test compares the frontend with the C seed on the native source corpus
and compiler sources, then compares encoder images byte-for-byte across all
three host word models. `--vm` also runs the B frontend, B resolver, and B
encoder in sequence under both VM builds, then executes each generated image
and checks its output and status. Each stage receives a freshly initialized
heap file. Python launches the tests and checks results; it does not replace
any of the three B passes in that pipeline.

`--self-test` additionally runs those three B passes on each pass's own B
source and compares the rebuilt instruction images with the seed images.
It is a slow source-level fixed-point check for VM images, not a native
executable bootstrap. The engine and its primitive runtime still come from
the native C-written seed toolchain. The test driver is also external.

These passes still have limits: the B frontend does not yet duplicate the native
C stack-exhaustion diagnostics, and the B encoder is not a complete validator
for hostile record files. Neither experimental pass should be advertised as
a hardened replacement for the installed compiler.


The separate kernel pipeline check runs each B pass inside Unix V1, carries
its output bytes to the next stage, and runs the resulting program there:

```sh
python3 pdp-11/bcc-pdp/bootstrap/test_passes_v1.py
```

Use `--case calls`, `--case names`, or `--case conditional` for one case.
`--failure-dir PATH` preserves the generated disk images if a check fails.
The harness restarts the guest between stages; it is not a resident B-written
compiler driver or an independent build of the execution engine.


Native assembly comparisons have their own checks:

```sh
python3 pdp-11/bcc-pdp/bootstrap/test_codegen.py --vm
python3 pdp-11/bcc-pdp/bootstrap/test_codegen_v1.py
```

The host checks compare complete assembly bytes and diagnostics across three
word models. The VM checks also use output files and completion markers, so
they exercise the B close-result convention. The kernel check compares a
program with globals, a call, and a computed goto against the native C pass.
It does not claim that every native code-generation case has run in the guest.


To check native engine reconstruction under the application emulator:

```sh
python3 pdp-11/bcc-pdp/bootstrap/test_native_rebuild.py
```

This compares every frontend record, resolver record, assembly byte, and
final native engine byte with the C-seeded reference. It deliberately retains
the historical assembler, runtime-selection helper, image converter, and
runtime assembly. Those dependencies are visible in the test; a matching
engine does not remove them.


## B-written executable construction

The [native image writer](image/README.md) reads the backend's selected
assembly files and writes a fixed-origin `0405` executable directly. It does
not invoke the historical assembler or the Python image converter. Its tests
still use both as independent byte references:

```sh
python3 pdp-11/bcc-pdp/bootstrap/test_image.py --vm
python3 pdp-11/bcc-pdp/bootstrap/test_image_v1.py
```

The first check compares assembly fixtures, valid native corpus programs,
and the execution engine across three host word models. It tests malformed
and over-limit inputs separately. Rejected B fixtures do not reach the image
writer and are counted separately. The VM option checks selected programs
under both execution models.

The kernel check runs the B writer in Unix V1, reads its executable bytes
and execute permission from the disk image, then boots again and runs the
saved executable. The second boot uses a C-seeded verification launcher;
it is not part of executable construction. This is a component check, not
a complete B-written compiler driver or an independent runtime rebuild.


## B-written driver and runtime regeneration

The [build driver](driver/README.md) runs the B passes itself, with a fresh
heap file and completion marker for each child. The [runtime selector](selector/README.md)
keeps retained assembly unchanged. The [target template emitter](runtime/README.md)
regenerates startup and primitive assembly from B-maintained instruction
templates; the code generator's `-L` mode rebuilds the B library without an
external namespace-rewriting command.

```sh
python3 pdp-11/bcc-pdp/bootstrap/test_toolchain.py
```

The application-emulator test removes the seed runtime assembly files before
regenerating them with the B driver. It then compiles and runs a program,
checks output modes, and tests failed passes and protected paths. The isolated
application root contains no C compiler or assembler. Seed creation and
independent byte references still use the existing tools outside that root.


The in-system version is `test_toolchain_v1.py`. Its optional `--self-test`
mode rebuilds every toolchain component from B inside Unix V1, with exact
comparisons in the guest and from the resulting disk image. This can take
many hours and holds the native build lock. See the
[testing guide](../../../docs/testing.md#b-driven-toolchain-checks) for the
timeout, retained failure files, and distinction between the seed and the
rebuild.
