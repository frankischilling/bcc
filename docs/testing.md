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
arguments, clock/date conversion, and source-defined library names. Tests of the runner guard against
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
make -C pdp-11/bcc-pdp v1-run B=tests/run/t34_fork.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t35_execv.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t41_eight_names.b
make -C pdp-11/bcc-pdp v1-run B=tests/v1/tty.b
bash pdp-11/bcc-pdp/tools/v1-run.sh pdp-11/bcc-pdp/tests/run/t19a_tilde.b --expect-compile-error
```

The first command rebuilds and compares all four compiler binaries inside
the booted system, then recompiles and compares the B-written library before
using the rebuilt compiler to run a B fixture. Other
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
and remaining gaps, including host stat/terminal layouts, native word-addressed
pointers, and full function-name storage semantics. A bootstrap fixed point
can preserve the same bug across stages. Sanitizer results should state both
which code was instrumented and whether leak checking was available.
