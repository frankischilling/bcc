# Testing the compiler variants

Use an x86-64 Linux host with GCC, GNU binutils, Python 3, Bash, and Make.
Ordinary tests do not need curses headers. Curses programs need their
development package and `-l ncurses`.

## Host, assembly-source, and B-written builds

```sh
make
make test
make test-install
make -C asm check
make -C asm bootstrap
make -C bootstrap test
```

The host runner checks suite exit status and reported failures, and rejects
missing summaries or zero executed tests. It covers both runtime layouts,
16-bit translated addresses, function values, emitted assembly, process
arguments, clock/date conversion, source-defined library names, and packed
character output. Character tests check exact bytes rather than terminal text. Vector tests
compile size assertions against emitted storage and then execute the B
programs; checking values alone would miss an extra allocated element. Argument tests distinguish the predefined vector
from compatibility calls and check multi-file access, mutable pointer cells,
empty arguments, and main parameters. Global-storage tests also exercise
cross-file initialization order, contiguous simple definitions, cycles,
mutations, duplicate definitions, and statement-bodied functions. Host-only
compatibility cases check argument-dependent global initializers and ensure
that invoking initialization twice does not reset globals. Tests of the runner guard against
false-green reports.

`bccasm` runs the same host suite. The B-written compiler runs lexical and
expression cases at each of its three stages, separately from the generated-C
fixed-point check. The installation test uses a temporary prefix containing
spaces and checks both runtime layouts.

## Fast native PDP-11 checks

```sh
git submodule update --init pdp-11/unix-v1
make -C pdp-11/bcc-pdp
bash pdp-11/bcc-pdp/tests/run/run.sh
bash pdp-11/bcc-pdp/tests/ext/run.sh
python3 pdp-11/bcc-pdp/tests/driver_cases.py
python3 pdp-11/bcc-pdp/tests/ic_cases.py
python3 pdp-11/bcc-pdp/tests/image_tools.py
python3 pdp-11/bcc-pdp/tests/file_verification.py
python3 pdp-11/bcc-pdp/tests/runtime_selection.py
python3 pdp-11/bcc-pdp/tests/build_lock.py
bash pdp-11/bcc-pdp/tests/check_v1_binaries.sh
```

The native compiler is built with the pinned historical C compiler under
apout. Each execution case gets a temporary tool root. Output bytes, optional
exit expectations, and optional `.files.json` contents are checked; missing
expected-output files fail the run. Oversized programs are rejected before
execution.

The pinned emulator's 0405 mode ignores exit results and does not correctly
return fork/wait PIDs. The fast runner therefore uses an outer 0407 container
with V2-compatible syscall observation, leaving the compiled V1 text and
addresses unchanged. A skipped loader-header word tags the container as V2
to avoid the emulator's checksum/size-based guesses. A nonzero-result fixture ensures this observation stays
active. It is not an independent V1 kernel oracle; tty calls, in particular,
are stubs in apout.

The driver tests cover successful compilation, invalid/missing input,
unresolved symbols, oversized output, stale completion records, and an
assembler that returns success without doing its work. Internal-record tests
exercise bounds checks before fixed buffers can overflow.

## Real Unix V1 checks

```sh
git submodule update --init --recursive pdp-11/unix-v1
python3 -m pip install pexpect==4.9.0
make -C pdp-11/bcc-pdp v1-selfhost B=tests/run/t26_postfix_index.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t27_ctime_check.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t32_time_registers.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t33_files.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t99_open_modes.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t34_fork.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t35_execv.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t41_eight_names.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t43_forward_labels.b
make -C pdp-11/bcc-pdp v1-run B=tests/v1/tty.b
bash pdp-11/bcc-pdp/tools/v1-run.sh pdp-11/bcc-pdp/tests/run/t19a_tilde.b --expect-compile-error
```

The first command rebuilds and compares all four compiler binaries inside
the booted system, then recompiles and compares the B-written library before
using the rebuilt compiler to run a B fixture. After the simulator closes its
disks, a separate host filesystem reader checks all four installed binaries
and the generated library assembly against pre-boot references. It compares
lengths and every byte, rather than relying only on the guest's `cmp` or
console output. The reader's unit tests include odd lengths, trailing NULs,
sparse blocks, indirect blocks, and malformed images. Other
cases cover date bytes and guards, hardware time registers, files, processes,
the actual tty interface, and eight-character/case-sensitive B names.

The console is not a binary-output channel: it can discard NULs. The full
system date fixture checks those bytes in memory and prints an ASCII verdict.
This does not weaken the byte-exact fast tests. CPU halts, kernel panics,
missing executables, and output mismatches fail the full-system runner.

The image workflow reserves swap/kernel blocks and moves scratch files off
the small root disk. It validates the generated image before booting; tests
must not bypass that check. The [native guide](../pdp-11/bcc-pdp/README.md)
explains these safeguards and the offset-preserving historical-tool overlay.

## Interpreting a green run

Tests establish specific cases, not complete historical equivalence. See
[the conformance notes](../wiki/HISTORICAL_CONFORMANCE.md) for primary sources
and remaining gaps, including host terminal mapping, native cross-file
linkage, and host-sized storage in the B-written bootstrap. A bootstrap fixed point
can preserve the same bug across stages. Sanitizer results should state both
which code was instrumented and whether leak checking was available.

`tests/test_declarations.py` runs the declaration fixtures through all host
word/runtime layouts and each bootstrap stage. Native tests use the same
positive source files. The suite also rejects malformed name lists, missing
bodies, duplicate locals, and malformed parameter lists.

`tests/test_open_runtime.py` checks zero/read and nonzero/write modes across
host word sizes, both runtime layouts, and all bootstrap stages. It includes
values that would become zero if narrowed to a C `int`. Native open-mode tests
run under both the application emulator and the restored kernel.

`tests/test_identifier_bytes.py` also rejects physical NULs before, between,
or after source definitions. Rejection tests require a compiler diagnostic;
a signal or sanitizer failure is not an acceptable rejection.

`tests/test_unix_metadata.py` checks status fields against controlled host
files, including size/time wraparound, guard cells, failed calls, directory
flags, and historical permission conversion. It runs both host layouts and
word modes, plus the three bootstrap stages.

Native word-address tests cover pointer increments, differences, static
initializers, packed strings, file-buffer offsets, exec vectors, and copied
argument alignment. `tests/argv_storage.py` also checks the fixed argument
capacity and startup rejection before copies reach program data. The real
V1 runner accepts repeated `--argument` options for simple shell words; it
rejects shell metacharacters rather than interpolating them into commands.

## Reviewed documentation examples

`tests/test_docs_examples.py` compiles and runs marked examples from the
README, wiki, and guides. The host suite checks shared and inline runtimes;
each bootstrap stage and the native CI job check examples marked for them.
Expected output is compared as bytes, so embedded NULs cannot disappear in
text normalization. See the [wiki test guide](../wiki/WIKI_TESTS.md) for
metadata and focused commands.

Formatting regressions check strict signed octal and unknown conversions
separately from host compatibility formats, along with minimum integers,
word widths, invalid bases, and embedded NULs. Read regressions ensure that
short, zero-length, failed, and EOF reads do not erase untouched bytes.

## Publishing the GitHub wiki

The reviewed source pages live in `wiki/`. The GitHub wiki is a separate
Git repository. After committing and pushing the source revision, prepare
a local wiki checkout with:

```sh
git clone https://github.com/frankischilling/bcc.wiki.git ../bcc.wiki
python3 scripts/sync_wiki.py ../bcc.wiki --revision HEAD
git -C ../bcc.wiki diff
python3 scripts/sync_wiki.py ../bcc.wiki --revision HEAD --check
```

The script does not commit or push. Review the prepared diff, then publish
it with the wiki repository's normal Git workflow.
It preserves existing page URLs and converts repository-relative links to
pinned source links. It refuses to copy source pages that differ from the
requested commit, so a published page cannot quietly describe uncommitted
changes. Unknown wiki pages are left alone.

Object-output tests compile separate strict B units and link them back
together, check default and explicit object names, reject ambiguous output
paths, and verify that hard links, symlinks, and retained-C paths cannot
overwrite an input. Identifier tests cover host-header names and distinguish
source-defined B functions from similarly named C interoperability helpers.

Allocation tests cover valid and zero-size requests, negative counts, the
minimum word, and host byte-count overflow. They run through shared/inline
runtimes and every bootstrap stage; the large-value fixture is chosen to
expose multiplication overflow without requiring a large successful allocation.

Source-function-cell checks cover saved bodies, persistent changes, addresses
in external initializers, cross-file replacement, references to main, and
source-defined library names. A compatibility-only check changes main during
global initialization; another ensures repeated runtime initialization does
not reset a changed function cell.

Native library-selection tests cover unchanged files, replacements, aliases,
external data definitions, and declaration-only references. Driver and full-
system tests also compile programs that replace `printn`, `printf`, and
`putchar`, verifying that retained library calls reach the program's cells.

Native Make invocations and full-system staging share one host lock outside
`build/`, so cleaning the build cannot unlink a held lock. The shell entry
points use the same lock order, and nested Make calls reuse their caller's
locked scope. The fast runner copies the compiler passes, emulator, and
runtime under a shared lock, then executes those private copies. Lock tests
exercise two Make processes and a shell-script/Make pair against shared
scratch files, including nested entry points.

Parameter-layout checks cover adjacent cells, mutation through their addresses,
call-by-value, recursive invocations, retained heap allocations between freed
frames, cross-file calls, callable parameters, and compatibility-mode local
shadowing. The common argument-cell case also runs on native PDP-11 and in
Unix V1.

Word-arithmetic cases check zero-filled shifts, signed comparison results,
wrapping at both limits, unary negation, multiplication, division, remainder,
and single-evaluation updates. Boundary results are BCC's defined behavior,
not a claim that the historical manual specified every overflow case.

CI also runs the host suite with AddressSanitizer and UndefinedBehaviorSanitizer
on the compiler, then instruments generated arithmetic programs. Inline-runtime
cases instrument their runtime too; the cached shared runtime is built separately
and is not instrumented by the extra compiler flag. Leak detection is disabled
for these runs.

Command-replay tests include empty arguments, long argument lists, fallback to
standard input, and repeated replacement of unread input under a small descriptor
limit. They run against linked and inline runtimes and all bootstrap stages.

Call-frame tests cover extra arguments, missing declared arguments, mutation
through argument addresses, recursion, nested calls, separately compiled source
files, captured callees, and calls through both source and runtime function
values. The native tests and counted-argument example cover supplied arguments;
zero-filling missing arguments is tested only as a host/bootstrap extension.

Library-binding tests replace functions and data cells, change callbacks during
formatting, and link library-name providers as separate objects. They check
negative-number delegation and the host line-input return contracts. Native
coverage exercises the same supplied callbacks and verifies the B-written library
through its full-system rebuild.

An old-layout C object guards the three-field call registry against accidental
layout expansion. Its adjacent data must not be interpreted as a named binding.
Both linked and inline runtime tests exercise that object. This is a regression
check for the previous call-frame layout, not a promise of general object-ABI
compatibility across compiler versions.

Identifier-byte tests generate source containing ASCII backspace explicitly.
They cover each name position, parameters and labels, the eight-character bound,
encoding collisions, and separate host objects. The native fast checks and a
full-system fixture exercise the same byte alphabet without relying on terminal
editing. Octal checks include the documented 09 and 018 forms.

The library-binding suite also saves, replaces, and restores runtime-owned
cells, including through external address initializers and across input
files. It checks saved variadic function values, extra argument evaluation,
missing-argument diagnostics, and shared inline-runtime output state. The
bootstrap runs the same applicable cases through all three stages.
