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
failure agree with the native C resolver in 381 host-side comparisons across
the 16-bit, 32-bit, and host-word models. The frontend rejects another 21
fixtures before they reach the resolver; those are reported separately.

The shared B-written record reader and I/O helpers also compile and run
inside Unix V1. Their kernel test checks file creation, record parsing,
`-32768`, EOF, and exact output. This establishes that those components run
on the target, not that the complete resolver fits there.

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

The resolver image contains 9,536 instruction-file words, including startup
and static-data loading, with 3,386 words reserved for its initial data.
These are virtual storage counts, not resident PDP-11 process sizes. The
native engine still has to fit the kernel's separate 16 KB process limit.

This path still uses the C-written seed to build the engine and resolve the
B source. A Python encoder creates the instruction file. File-descriptor
virtualization, temporary-file ownership, a complete runtime, and the
remaining compiler passes are unfinished. Running one compiler pass in B
is useful evidence for the design, not a completed self-host.

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
