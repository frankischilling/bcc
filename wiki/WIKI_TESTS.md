# Tests

The [testing guide](../docs/testing.md) is the command reference for the host,
assembly-source, B-written bootstrap, fast PDP-11, and full Unix V1 checks.
Use `make test` for the complete host suite rather than treating one shell
script as the entire test matrix.

## Documentation examples

```sh
python3 tests/test_docs_examples.py
python3 tests/test_docs_examples.py --compiler asm/bccasm
python3 tests/test_docs_examples.py --bootstrap --compiler bootstrap/build/stage3/bbc
python3 tests/test_docs_examples.py --native
```

The checker also reads reviewed sources in `examples/b72/`. Each execution
gets its own temporary working directory, including examples that create
files or directories.

Only explicitly reviewed examples carry a `bcc-example` metadata comment.
The checker compiles them in strict mode, executes them in a temporary
directory, and compares output bytes and exit status. Host examples run in
both shared and inline runtime layouts with 16-bit words. Bootstrap and
native examples are selected by their metadata, so a host-only feature is
not silently presented as portable.

The checker has compilation and execution timeouts. It does not execute
arbitrary fenced fragments or shell instructions from a guide. JSON metadata
records expected output, optional input and exit status, and backend flags.
When adding an example, derive its expected behavior from the relevant
source or documented implementation choice before recording the result.

## Regression coverage

Compiler cases include valid and invalid syntax, expressions, declarations,
labels, calls, storage, and multiple input files. Runtime tests cover
arguments, byte packing, number formatting, short reads, metadata, process
replacement, and historical clocks. Formatting tests deliberately separate
strict B72 behavior from host compatibility formats.

Native tests compare exact bytes, optional file contents, and exit results.
Driver and intermediate-record tests check failures as well as success.
The full-system checks exercise a restored kernel and compare rebuilt
compiler binaries and B library assembly. The fast emulator alone cannot
establish historical syscall behavior.

The test runner rejects missing summaries and runs with no executed tests.
A green test run is evidence for those cases, not proof that every language
feature or arbitrary program is bug-free. Keep new failures as regressions
and record remaining limitations in the conformance notes.
