# Building BCC with B

The goal is a B-written compiler toolchain that can rebuild itself without
calling GCC or GNU binutils after the seed stage. The native PDP-11 path
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
   on snapshots regenerated from C with GCC.

The existing C and assembly-source builds remain useful seeds and comparison
implementations during this work. A native-output prototype that cannot yet
compile its own source is not a completed bootstrap.

## Native PDP-11 path

The current process boundaries provide useful places to replace one component
at a time: parsing to records, resolving names, emitting target code, and
running the passes. A mixed B/C pipeline can establish compatibility during
the port, but it is an intermediate state.

A literal translation of the early C files is not sufficient:

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

The eventual B-written passes and driver must rebuild their own B sources
inside the restored system. Keeping the historical assembler is a possible
transition; it is not GNU binutils, but it is still an external tool. It is
not the final goal. The completed path needs a B-written assembler or a
direct native executable writer too. Any remaining target-specific glue
must be stated explicitly.

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
