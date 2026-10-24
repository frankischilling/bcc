# Native PDP-11 B compiler

This compiler targets the restored Unix V1 environment and emits native
PDP-11/20 code. Its language baseline is Thompson's January 1972 B manual.
It is written in the early C dialect accepted by the historical toolchain
pinned under `../unix-v1`; it is not cross-compiled from C99 with modern GCC.

Three processes split the compiler: `b00` parses B into intermediate records,
`b01` resolves names, and `b1` emits V1 assembler syntax. A small native `b`
driver runs the passes and assembler. Arguments are arranged so the leftmost
argument is nearest the return address; R5 is the frame pointer and R0 holds
a function result. Multiplication and division do not require EIS instructions.

This is not complete B72 conformance. The [status notes](CONFORMANCE.md) and
[repository-wide source comparison](../../wiki/HISTORICAL_CONFORMANCE.md)
describe the remaining differences.

## Build and fast tests

From the repository root:

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

Make builds apout, assembles `crt0.o`, and prepares a private filesystem copy
for the historical C compiler. Each B execution test uses another temporary
copy, so intermediate files from one case cannot make another case pass.
Expected output is compared as bytes, including NULs and trailing newlines.
Optional `.files.json` fixtures check file contents outside the B API.

```sh
make -C pdp-11/bcc-pdp test-run B=tests/run/t01_hello.b
```

The pinned emulator's raw 0405 mode discards exit results and mishandles
fork/wait PIDs. For fast execution checks, `apout_image.py` wraps unchanged
V1 instruction/data bytes in a 0407 test container and selects apout's
V2-compatible syscall handling. The inner V1 header still branches to the
same 040014 entry address; a skipped header word explicitly tags V2 handling.
This exposes nonzero results; it does not prove
real V1 kernel behavior. `tools/run-apout.sh --raw-v1 FILE.b` retains the
unmodified emulator mode for comparison. TTY calls are stubs in apout and
are checked only in the full-system suite.

## Full Unix V1 checks

These need the nested SIMH source and Python's `pexpect` package:

```sh
git submodule update --init --recursive pdp-11/unix-v1
python3 -m pip install pexpect==4.9.0
make -C pdp-11/bcc-pdp v1-selfhost B=tests/run/t26_postfix_index.b
make -C pdp-11/bcc-pdp v1-run B=tests/run/t27_ctime_check.b
make -C pdp-11/bcc-pdp v1-run B=tests/v1/tty.b
```

The self-host check rebuilds all three passes and the C-written driver inside
Unix V1, compares each binary with the apout-built version, installs the
rebuilt binaries, recompiles the B-written runtime and compares its assembly,
and compiles/runs the selected B program. This is an
in-system C rebuild, not the separate B-written bootstrap compiler.

The console runner checks ASCII output and treats a CPU halt or kernel panic
as failure. Binary data assertions belong inside the test program, as in
`t27_ctime_check.b`; the terminal can discard NUL output. Use the fast suite
for byte-exact file and output checks.

`tools/v1-run.sh FILE.b --expect-compile-error` checks that a failed pass is
diagnosed and produces no executable. `--trace-stages` runs each pass directly
before testing the driver and captures diagnostic progress.

## Safe image layout

The pinned filesystem builder leaves the kernel's swap blocks marked free.
Without correction, larger temporary files can overwrite saved processes.
The BCC image workflow checks that files do not overlap the reserved area,
reserves RF blocks 432–1023, and restores the image's reserved tail after
boot-image installation.

Only the small `/bin/b` driver lives on the root disk. The three passes are
installed in `/usr/lib/bcc/`; runtime files are in `/usr/lib/`, and sources
are in `/usr/src/bcc/`. B compiler scratch files use `/usr/tmp/`.

The generated image also changes the historical assembler/compiler scratch
path templates from `/tmp/` to `/usr/`. These replacements have the same
length and leave instruction bytes and binary offsets unchanged. The pinned
source tree is not patched. Unit tests check the overlay and reserved-block
validation. Full-system runs are serialized because staging and disk images
are shared, and the console listener binds only to loopback.

To install a rebuilt binary manually, copy it and restore its V1 execute bit.
Do not use `mv` across the root and `/usr` filesystems:

```text
chdir /usr/src/bcc
cc b00drv.c bstmt.c bexpr.c blex.c bemit0.c butil.c
cp a.out /usr/lib/bcc/b00
chmod 36 /usr/lib/bcc/b00
```

Use `make v1-selfhost` for the complete checked sequence.

## Native driver and runtime

The driver accepts `b [-x] [-v] source.b`. `-x` enables compatibility syntax;
`-v` prints phase progress. Each compiler pass can write an explicit
completion record with `-s FILE`. The driver requires those records and
checks the pinned assembler's diagnostic stream, rather than relying only
on child status that the V1 kernel does not provide. Output headers, size,
reads, writes, and installation are checked before reporting success.

`runtime/brt.s` contains arithmetic helpers and syscall wrappers. Filenames
and exec arguments are converted from B's `004` terminator to Unix NUL
termination. `execv` takes a count, `execl` accepts an explicit `arg0`, `fork`
uses the V1 two-return convention, and `time` reads the KE11 AC/MQ result.
`stty` and `gtty` use syscall numbers 31 and 32.

`runtime/libb.b` implements `printn`, `printf`, `getstr`, and the date
formatter. Signed division truncates toward zero; remainders follow the
dividend. Negative printing and bases above 10 are extensions to the manual's
non-negative `printn` example.

## Limits and differences

- Pointers are byte-addressed, not the manual's word addresses. Vector
  names have mutable pointer cells, and indexing loads a pointer value
  before selecting an element.
- Function-name storage and indirect calls still need further native
  conformance work. Forward label values work within their function; missing
  and duplicate labels are rejected by the resolver.
- The startup argument vector keeps at most 31 entries, including the
  program name at `argv[1]`. Its count reports only stored entries. The
  optional `main(count, values)` extension still receives user arguments
  only, excluding the program name.
- Character constants require one or two characters; empty, oversized,
  and unfinished constants are rejected.
- Source strings are limited to 255 bytes plus the B terminator. Oversized
  or unterminated literals and oversized intermediate records are rejected.
- Syscall path conversion is limited to 255 bytes. Exec accepts up to 64
  arguments with 512 bytes of converted argument strings.
- Numeric and character constants can specify vector sizes. The front end
  rejects individual vectors above 8,190 elements and declared automatic
  frames above 8,191 words, including pointer cells, before counters wrap.
  These ceilings do not guarantee enough stack remains beside the code.
- The compiler has fixed symbol, vector, case, and literal tables. The
  binary-size check covers code/data/BSS; programs also need stack space.
- Identifiers may contain up to eight characters; longer names are rejected.
  The V1 assembler folds case and keeps seven characters, so the compiler
  assigns private symbols to long or uppercase external names. These names
  remain distinct within one B source file, but their generated symbols are
  not a stable interface for separately compiled files. Up to 200 names can
  use this mapping. Short lowercase names keep the runtime calling interface.
- Out-of-range shifts, division by zero, and some negative arithmetic cases
  are not specified by the B manual. Implementation choices are not
  conformance requirements.
