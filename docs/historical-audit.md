# Historical audit

This audit started from the compiler layout merged in PR #2. The findings
below distinguish the January 1972 PDP-11 B grammar from host compatibility
extensions and from operating-system behavior.

## Findings

| Area | Evidence and correction |
| --- | --- |
| External definitions | Thompson §2 and §§7.1–7.2 describe constants and names as initializers and a constant as the optional vector extent. Strict host and B-bootstrap parsers enforce those forms. The PDP-11 seed and B frontend now reject a comma without a following initializer. Negative literal initializers remain supported because existing historical-style sources use them. |
| Statements and expressions | Thompson §2 and §5.4 specify a switch rvalue followed by a statement. The host and bootstrap parsers now accept a selector such as `(1)+1`. Strict mode rejects standalone comma expressions and top-level `extrn` declarations. The bootstrap also distinguishes a conditional argument from the following argument separator. |
| Malformed source | Compatibility hexadecimal constants require a digit after the prefix. Host and bootstrap parsers diagnose excessive recursion and expression nesting. The 512-depth guards are implementation limits; they are not specified by the historical manual. |
| Runtime | Host argument indexing checks the full word before indexing. Host and native Linux file operations reject invalid descriptors and counts before narrowing or accessing buffers. Zero-count I/O remains valid with a null buffer. The host redirection extension preserves full pathnames and closes retired nonstandard descriptors. |
| Assembly snapshots | A manifest with missing assembly entries could pass the old check. The verifier now requires all expected files, matching source hashes and generation flags. It can also reproduce the recorded assembly with the matching compiler. |

Primary references are in [the archive](../historical-docs/README.md). The
[Thompson transcription](https://cm-bell-labs.github.io/who/dmr/kbman.html)
provides section numbers alongside the scanned original. The Unix V1
system-call transcriptions are in [unix-v1-docs](../historical-docs/unix-v1-docs/).
The PDP-11 review also consulted the 1970 DEC handbook's addressing and
instruction tables and the KE11-A manual DEC-11-HKEA-D, §§1.1 and 2.1.
The native arithmetic peripheral is memory-mapped; it must not be replaced
with the later PDP-11 EIS instruction set.

## Reproducing the checks

See [testing.md](testing.md) for the full build matrix. The new parser tests
include deterministic malformed-source mutations and deliberately excessive
nesting. The runtime tests check observable results, including unchanged
buffers, file offsets, and file contents after rejected operations.

The assembly snapshots in this change were generated with GCC 13.3.0 on
Ubuntu 24.04. This replaces the previous generation compiler and accounts
for substantial changes to the generated files. Use the exact compiler
version recorded in the manifest to run:

```sh
python3 bccasm/regenerate.py --check
python3 bccasm/regenerate.py --verify --cc gcc
```

The second command regenerates into a temporary directory and compares the
bytes; it does not overwrite the checked-in snapshots.

The native Linux rebuild was checked for byte-for-byte equality across
three stages, followed by a rebuild from the final native driver. The
PDP-11 review built the pinned restoration on a Linux filesystem, booted
Unix V1 under SIMH, rebuilt all four compiler binaries and the library
assembly, and checked the results against the disk image. Both new
initializer rejection cases also ran under Unix V1.

## Outstanding questions

Thompson §4.1.8 describes evaluation of arguments before the function
designator. Current BCC implementations capture the function value first.
The [aap/b reconstructed compiler](https://github.com/aap/b/blob/8779d9e8684d1daaa47c6fab1705194d732863bb/unix1_bdir/bc.B)
emits the designator before the call mark and arguments. Its
[reconstructed call routines](https://github.com/aap/b/blob/8779d9e8684d1daaa47c6fab1705194d732863bb/unix1_bdir/bilib/n123.s)
save the function address in the call frame before argument evaluation.
The reconstruction's own README describes missing and reconstructed
material; the pinned Unix V1 tree does not supply an independently
recovered original B compiler and runtime. Preserve the current behavior
until additional evidence resolves the disagreement.

Passing the tests establishes the cases exercised by the tests. It does
not establish that every source path has been audited, that arbitrary
malformed input is safe, or that the modern runtimes reproduce every Unix
V1 detail. Further work includes broader differential tests of arithmetic
and storage boundaries, full source-level review of the remaining code
generators and runtime functions, and independent examination of the
assembler, linker, loader and executable records. The full B-only goal
still requires verification of the remaining seed dependencies.
