# Building BCC with B

The goal is a compiler toolchain maintained in B that can rebuild itself
without a C compiler, GNU binutils, or another external compiler or assembler
after the seed stage. This includes the compiler, bootstrap compiler, runtime,
and executable-building tools. The native PDP-11 path
must perform its B-to-B rebuild on the PDP-11, not merely produce a binary
on a modern host.

That goal is not implemented yet. The existing build paths prove different
things, and their names should not obscure the remaining dependencies.

## What works now

- The [host compiler](../src/) is written in C and emits C. Both building it
  and compiling B programs use a host C toolchain.
- [bccasm](../asm/README.md) assembles checked-in x86-64 GNU assembler
  snapshots of that C compiler. It still uses host assembler/linker tools
  and the C-output backend. A staged assembly build is not B self-hosting.
- The [B-written bootstrap](../bootstrap/README.md) builds three compiler
  stages and compares their generated C. Its source uses the host
  compatibility surface and runtime helpers. It still emits C and invokes
  a C compiler to make executables.
- The [native PDP-11 compiler](../pdp-11/bcc-pdp/README.md) rebuilds its three
  passes and driver inside the restored system using the early C toolchain.
  It also rebuilds the B-written part of its runtime. The four compiler
  binaries and runtime assembly are compared as exact disk-file bytes.
  This is an in-system C rebuild, not a compiler written in B.

Matching stages are useful regression evidence. They do not independently
prove the seed trustworthy or the implementation historically complete.
The [source review](SOURCE_REVIEW.md#what-a-fixed-point-proves) explains the
separate trust question.

## Host path

The current B frontend constructs C expressions and statements. Removing
its C compiler subprocess therefore requires a real backend change, not
just a different build script.

A self-contained host path needs:

1. A B-written frontend and intermediate representation that retain the
   tested language behavior, including writable function/label cells,
   declaration scope, evaluation order, and the supported word models.
2. Native instruction selection and executable construction. The existing
   assembly-source target is x86-64 Linux; other ABIs and executable formats
   need their own implementations and tests.
3. B-written runtime support with an explicit target interface for entry,
   system calls, allocation, and process arguments. Calls into the present
   C runtime cannot be hidden behind a claim of toolchain independence.
4. A B-written assembler/linker or image writer. The bccasm path must be
   reproducible from B-maintained sources, rather than continuing to depend
   on snapshots regenerated from C with GCC. A candidate design for bccasm
   is a generated assembly form of the B compiler, assembled by the B-written
   toolchain. It remains a design to implement and test, not an existing path.

A [B-written ELF image writer](../bootstrap/native/README.md) now packages
already-generated x86-64 instruction and data bytes without invoking an
assembler or linker. A B-written encoding library also emits selected integer,
branch, memory, and syscall instructions directly. Its separate two-pass label
resolver handles forward and backward calls and jumps, checks layout consistency,
and rejects undefined labels. An integer-operation selector handles 64-bit
arithmetic, comparisons, shifts, and unary operations while preserving the
host's word behavior. Tests compare the bytes and execute the resulting images
on Linux x86-64. Building these components still uses the C-output toolchain.
The full runtime, remaining source constructs, normal startup, and independent
build driver remain necessary.

The [wide record frontend](../bootstrap/native/frontend/README.md) shares the
B parser while selecting 64-bit numeric helpers. The PDP-11 configuration
continues to normalize literals to 16 bits. The wide configuration still has
eight-character identifiers and bounded parser storage, so it is not a drop-in
replacement for the existing host frontend. It emits records rather than an
executable.

The [parameter metadata reader](../bootstrap/native/README.md#function-parameter-metadata)
collects declared argument counts before resolution discards unused parameter
declarations. It checks record boundaries and indices; call lowering and the
native host runtime are separate components.

The [scalar record lowerer](../bootstrap/native/README.md#scalar-record-lowering)
turns straight-line arithmetic records into x86-64 instructions, with checked
operand-stack balance and division-fault branches. Calls and control flow use
separate modules. A
[local-memory lowerer](../bootstrap/native/README.md#local-storage-and-pointer-records)
adds local cells, automatic vectors, word-addressed pointers, and assignments.
A [control-flow lowerer](../bootstrap/native/README.md#structured-control-flow)
adds statement branches, loops, conditional expressions, and early returns.
The [call builder](../bootstrap/native/README.md#native-function-calls) supplies
argument blocks and function entries. Integration fixtures now construct
native images from restricted multi-function source programs, including
recursion and writable function cells. [Static data construction](../bootstrap/native/README.md#static-data)
adds global cells, vectors, named-address initializers, and separate writable
storage for each string occurrence. [Switch dispatch and computed goto](../bootstrap/native/README.md#switch-dispatch-and-computed-goto)
add nested cases and mutable label cells. Normal startup remains separate work.
The result-reporting test constructor is not a general source compiler.

[Native runtime primitives](../bootstrap/native/README.md#native-runtime-primitives)
now generate direct Linux x86-64 implementations of packed-byte access, basic
file I/O, path operations, and process exit. They use the B call frame and
need no linked C runtime in the resulting image. The whole-program test constructor now binds these imports only when the
source does not define the name, preserving writable function cells and
user-defined replacements. Process-argument startup, allocation, and
formatted I/O are still missing. These primitives do not
change the normal compiler's C-toolchain dependency.

A separate [host resolver storage module](../bootstrap/native/README.md#host-resolver-storage)
raises its symbol capacity to 1,024 and its buffered initializer records to
8,191 bytes. The PDP-11 configuration retains its smaller limits. The expanded
constructor can now resolve its own source, but cannot yet compile itself to
a working native executable.

The existing C and assembly-source builds remain useful seeds and comparison
implementations during this work. A native-output prototype that cannot yet
compile its own source is not a completed bootstrap.

## Native PDP-11 path

The current process boundaries provide useful places to replace one component
at a time: parsing to records, resolving names, emitting target code, and
running the passes. A mixed B/C pipeline can establish compatibility during
the port, but it is an intermediate state.

A literal translation of the early C files is not sufficient:

Literal pools count toward the memory budget too, not just zero-filled
buffers and symbol tables. Paging code alone does not remove that data cost.

- B data pointers count words. C byte pointers and offsets into packed
  character buffers need explicit byte indexing through `char` and `lchar`.
- Source strings and Unix argument strings have different termination
  conventions. File names, compiler records, and syscall boundaries need
  deliberate conversions.
- The restored process memory is small. Code, static storage, arguments,
  temporary buffers, and recursive frames all count. The current parser's
  stack tests already show why fitting the executable alone is insufficient.
- File reads must distinguish errors from EOF, and failed child tools must
  not leave an output that the driver accepts as successful.
  Native passes check output closes before writing their completion markers;
  a failed marker close removes the marker. The driver checks the converted
  executable's close before installing it.

The eventual B-written passes and driver must rebuild their own B sources
inside the restored system. Keeping the historical assembler is a possible
transition; it is not GNU binutils, but it is still an external tool. It is
not the final goal. The completed path needs a B-written assembler or a
direct native executable writer too, together with a B-written runtime.
Target-specific instruction sequences must be produced by the B toolchain;
a permanent C or handwritten assembly implementation is not the intended
endpoint. The seed may contain those languages, but its role and the point
where it is no longer used must be recorded.

## B resolver experiment

[`pdp-11/bcc-pdp/bootstrap`](../pdp-11/bcc-pdp/bootstrap/README.md) contains
an experimental B-written resolver. Its output, diagnostics, and success or
failure agree with the native C resolver in 393 host-side comparisons across
the 16-bit, 32-bit, and host-word models. The frontend rejects another 21
fixtures before they reach the resolver; those are reported separately.

The shared B-written record reader and I/O helpers also compile and run
inside Unix V1. Their kernel tests check file creation, record parsing,
`-32768`, EOF, block boundaries, reopening an input, and exact output. The
reader buffers 128 bytes at a time and preserves short-read and error handling.
These checks establish that those components run on the target, not that the
complete resolver fits there.

Direct native code still exceeds the memory budget. One reduced-runtime
assembly experiment occupied 24,808 bytes before allowing for its stack,
above the 16,384-byte process limit. That is not the installed compiler.

The small eight-operation paging example remains an independent kernel
check. It counts to 1,000, crosses a code-page boundary, and checks its last
reserved data cell. It does not implement the full instruction set.

The newer [B-written execution engine](../pdp-11/bcc-pdp/bootstrap/vm/README.md)
adds call frames, operators, paged data, primitive I/O, and argument startup.
It runs the B-written resolver inside Unix V1, with the harness comparing
the resulting file bytes against the C-written pass. The engine uses eight
64-byte pages for each of its instruction and heap caches. Its 8,192-word virtual
heap holds globals and frames in a caller-supplied backing file.

Each instruction image has its own static-data and code sizes. The seed
manifest produced by the [toolchain builder](../pdp-11/bcc-pdp/bootstrap/tools/build_toolchain.py)
records those counts and source hashes. These are virtual storage counts,
not resident PDP-11 process sizes; the native engine must still fit the
kernel's separate 16 KB process limit.

The seed path still uses the C-written compiler to build the engine and
resolve the B source. An independent Python encoder creates seed instruction
files. A B-written frontend and instruction encoder now accompany the
resolver. The test pipeline runs all three B passes in sequence and checks
the resulting images and program behavior in both execution models.

The optional source-rebuild check runs that pipeline on each pass's B source
and compares the resulting instruction image with the seed image. That check
alone is not a native executable rebuild. The separate B-driven toolchain
check also rebuilds native engine and driver images. File-descriptor virtualization,
temporary-file ownership, a complete runtime, host native instruction
generation, and a complete independent build driver remain unfinished.

The instruction limit is 32,700 words, below the reserved primitive-call
addresses. The encoder's static tables use much of the 8,192-word heap.
Check `data_words` in the seed manifest before changing their capacities;
arguments and call frames need the remaining space. Buffered compiler output
uses checked 256-byte writes and an explicit flush before closing the output.

A [B-written native code generator](../pdp-11/bcc-pdp/bootstrap/codegen/README.md)
also emits the native pass's assembly. The B frontend, resolver, and this
code generator have reproduced the execution engine's native bytes through
the historical assembler and image converter. That check used the native
application emulator. A separate Unix V1 check compares this generator's
assembly for a smaller program with globals, a call, and a computed goto.
Those checks retain the assembler and runtime assembly.

A [B-written native image writer](../pdp-11/bcc-pdp/bootstrap/image/README.md)
now accepts the backend's selected assembly files and writes a fixed-origin
Unix V1 executable directly. Its output path does not call an assembler,
linker, or Python image converter. Comparison tests keep the historical
assembler as an independent reference, rather than using it to construct
the B writer's output.

A kernel component check runs the writer inside Unix V1, checks its output
bytes and native execute permission, then runs the saved executable in a
second boot. The verification launcher still uses the seed. A B-written selector now
performs runtime selection for the experimental driver. The writer is not a
general relocatable assembler, and the B driver is not installed in place
of the existing compiler driver. This removes
one construction dependency for supported inputs, not all bootstrap
dependencies.

The B frontend does not reproduce the C seed's physical-stack exhaustion
diagnostic. The encoder expects resolved compiler records and is not a
complete arbitrary-input validator. These experimental components are not
installed in place of the native C passes.

## B-driven native construction

The [B build driver](../pdp-11/bcc-pdp/bootstrap/driver/README.md) runs compiler
passes through the engine, clears each pass's heap, and checks a completion
marker before continuing. Its ordinary build path invokes no C compiler,
assembler, Python encoder, or namespace-rewriting utility after the seed.
The [runtime selector](../pdp-11/bcc-pdp/bootstrap/selector/README.md) removes
only overridden labels and unused primitive groups, preserving retained bytes.

The driver can regenerate startup and primitive assembly from
[B-maintained target templates](../pdp-11/bcc-pdp/bootstrap/runtime/README.md)
and rebuild the ordinary B library from `libb.b`. The code generator assigns
the bundled library's label namespace directly. These templates remain
PDP-11-specific instruction sequences, not portable high-level B algorithms.
They are part of the backend, rather than a separate assembler dependency.

The seed builder still uses the existing C-written passes, assembler, and
Python helpers. Its manifest records the direct tools and inputs. Application
checks remove runtime assembly from the isolated tool directory before asking
the B driver to regenerate it. The guest check uses a success-only test entry,
compares the runtime and executable bytes from disk, and executes the result.
That verifies the construction path, not a complete in-guest rebuild of every
toolchain source or the trustworthiness of the original seed.

The optional `test_toolchain_v1.py --self-test` check rebuilds all seven
instruction images and both native executables from B inside Unix V1. It
also regenerates the two runtime templates and library assembly. All twelve
outputs must match in guest-side comparisons and independent disk-file reads.
This is a many-hour verification command, not an assertion that the full
rebuild has passed. The [testing guide](../docs/testing.md#b-driven-toolchain-checks)
describes its deadline and retained failure evidence.

The driver expects a caller-owned working directory and short guest paths.
It is experimental, not the installed `/bin/b`. The host compiler and bccasm
still need a native-output backend and B-maintained runtime work before they
can meet the same post-seed dependency goal.

## Completion checks

A completed path needs more than a successful stage-1 build:

- Record the seed revision, tools, inputs, and build commands.
- Build successive compiler and runtime stages from fresh directories.
  Compare lengths and every byte, including odd-sized outputs.
- Run the same positive and negative language/runtime checks against each
  stage. Do not omit cases simply because the new backend lacks a feature.
- Check emitted assembly, executable loading, cross-file bindings, argument
  layouts, and error handling independently of the compiler's own verdict.
- Record subprocess execution during the rebuild and make forbidden host
  compiler/assembler/linker invocations fail. Renaming GCC to `cc`, or leaving
  a fallback on PATH, does not remove the dependency.
- Keep reference tools used by the test harness separate from tools needed
  to construct the compiler. A verifier may compare files without becoming
  part of the native compiler's build path.
- On the PDP-11, test inside the kernel as well as the fast observer. Verify
  memory exhaustion, compiler diagnostics, and the exact installed images.

Until those checks exist and pass, the accurate descriptions remain
"B-written C-output compiler" and "native C self-rebuild," not a completed
B-native bootstrap.
