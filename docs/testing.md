# Testing the compiler variants

Run these commands from the repository root on an x86-64 Linux host with
GCC, GNU binutils, Python 3, and Make. Ordinary tests do not need curses
headers. Programs using curses need its development package and `-l ncurses`.

```sh
make
make test
make -C asm check
make -C asm bootstrap
make -C bootstrap test
```

The host runner checks suite exit status and reported failures, and rejects
missing summaries or zero executed tests. It tests both runtime layouts,
16-bit translated addresses, function values, emitted assembly, and process
arguments. Tests of the runner itself guard against false-green reports.
The assembly-source compiler runs the same suite, rather than a separate
set of weaker smoke tests. The B-written compiler also runs focused lexical
and expression cases at each stage, separate from its fixed-point check.

## Native PDP-11 tests

The historical toolchain is pinned as a submodule:

```sh
git submodule update --init pdp-11/unix-v1
make -C pdp-11/bcc-pdp
bash pdp-11/bcc-pdp/tests/run/run.sh
bash pdp-11/bcc-pdp/tests/ext/run.sh
bash pdp-11/bcc-pdp/tests/check_v1_binaries.sh
```

Make builds the host apout emulator and prepares the historical C toolchain.
The native compiler is built with that historical compiler, not cross-compiled
from its source with modern GCC. Each test compiles in a temporary filesystem
copy. Compiler errors, exit status, and output bytes are checked, including
NULs and trailing newlines. A missing expected-output file is a failure.

The binary check verifies the a.out header and 16 KB text/data/BSS limit for
all four passes/driver binaries. It does not install anything into the
restored system tree. These checks run under apout, not a booted SIMH kernel.
A full-system boot and an in-system rebuild remain separate validation tasks.

## What a green run does not establish

Tests cover specific cases, not complete historical compatibility. See
[the conformance notes](../wiki/HISTORICAL_CONFORMANCE.md) for the primary
sources and known gaps. In particular, runtime time/stat/terminal layouts,
native byte-addressed pointers, and the native date formatter still need
work. A bootstrap fixed point can preserve the same bug across stages.
