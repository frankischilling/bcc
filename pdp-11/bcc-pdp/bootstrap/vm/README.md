# Experimental B execution engine

This engine is written in B and runs on the PDP-11 under Unix V1. It keeps
instructions and most program data in files, so a B-written compiler pass
can use more storage than its native code and data would fit in one process.
It is a bootstrap experiment, not the installed compiler or a historical
B instruction format.

The existing C-written native compiler builds the engine. A
[B-written encoder](../encoder/README.md) translates resolved compiler records
into its instruction file; an independent Python encoder supplies seed images
and comparison results. The [B build driver](../driver/README.md) uses B-maintained image and runtime
components after the seed. The complete in-guest source rebuild has a separate
long-running check; individual engine tests do not establish that result.

## Files

- `fetch.b` reads 16-bit instruction words through eight 64-byte cache lines.
- `arithmetic.b` implements 16-bit operations.
- `heap.b` keeps eight 64-byte heap pages in memory and writes dirty pages back.
- `primitives.b` translates virtual pointers for I/O and character operations.
- `execute.b` runs instructions and stores call frames in the paged heap.
- `main.b` opens the instruction file and an existing `heap.vm` file.

`../tools/build_vm.py` combines the modules in that order. Its default output
is an application-emulator test image. Use `--raw-v1` for a kernel image or
`--source-only` for combined B source. The source and image are different
outputs; neither is a replacement for the installed native compiler.

The [instruction format](FORMAT.md) records the current opcodes and calling
convention for the B-written encoder work.

## Checks

From the repository root, after building both compilers:

```sh
make
make -C pdp-11/bcc-pdp
python3 pdp-11/bcc-pdp/bootstrap/test_vm.py
python3 pdp-11/bcc-pdp/bootstrap/test_vm_reentry.py
python3 pdp-11/bcc-pdp/bootstrap/test_vm_encoder.py
python3 pdp-11/bcc-pdp/bootstrap/test_vm_resolver.py
python3 pdp-11/bcc-pdp/bootstrap/test_vm_v1.py
python3 pdp-11/bcc-pdp/bootstrap/test_passes.py --vm
python3 pdp-11/bcc-pdp/bootstrap/test_passes_v1.py
python3 pdp-11/bcc-pdp/bootstrap/test_codegen.py --vm
python3 pdp-11/bcc-pdp/bootstrap/test_codegen_v1.py
python3 pdp-11/bcc-pdp/bootstrap/test_vm_v1_limits.py
```

The instruction tests compare arithmetic, recursion, frame limits, page
replacement, byte access, and file I/O in the native emulator and the host
compiler's 16-bit model. The resolver comparison checks output bytes,
diagnostics, and success or failure against the C-written resolver.
Frontend rejection cases are counted separately.

The kernel check boots Unix V1, compiles the engine inside the guest, runs
the B-written resolver, and reads its output back from the RK disk for an
exact comparison. It uses `/usr/tmp`, not the smaller root filesystem.
The harness restores the source files it temporarily stages in the disk
image inputs. It does not preserve the generated emulator disk images.

## Current limits

The instruction file holds at most 32,700 words. The virtual heap holds
8,192 words, with address zero reserved. Globals and a downward-growing
stack share that heap. Heap files must already contain 16,384 zero bytes
before a fresh run. The current driver does not create unique temporary
files or protect a caller from reusing another run's heap.

Primitive calls cover read, write, open, creat, close, char, lchar, exit,
unlink, seek, putchar, and getchar. Internal startup operations read
arguments and allocate initial storage. File descriptors are the engine's
native descriptors, not a separately virtualized descriptor table. Reads
and writes transfer at most 256 bytes per call and can return a short count.
This is enough for the resolver's buffered-record interface, not a claim
that the whole library has been ported.

The engine checks instruction and heap bounds, but it is not a security
sandbox. Compiled code shares its heap with frame metadata and can call
native file primitives. Only run programs you trust.

Shifts by a negative count or a count of 16 or more yield zero in this
experimental PDP-11 model. Those cases are not promised by the historical
B language description. They differ from BCC's host masked-count extension.
The normal arithmetic, comparison, and character operations use 16-bit
words and little-endian bytes.

A successful resolver run is one compiler-pass milestone. It does not prove
a complete compiler rebuild, a stable instruction ABI, or a bootstrap
without the original seed tools.

## Paging cost

Instruction and heap caches each occupy 512 bytes. The native engine's
loaded image occupies 15,728 bytes with the current seed, leaving 656 bytes
for its native stack and arguments. Virtual program frames live in the
separate heap file.

In a recorded Unix V1 check, encoding a small resolved program took 6.3
seconds with these caches, compared with 24.1 seconds using the earlier
one-line instruction cache and two larger heap pages. Those are host wall
times for one emulator workload, not physical PDP-11 timings or a general
speed guarantee. This small encoding check does not establish a full encoder rebuild; that
requires a separate end-to-end image comparison.
