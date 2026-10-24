# Checked B72 examples

These small programs use strict syntax and have recorded output checked by
`tests/test_docs_examples.py` on the host, B-written bootstrap, and native
PDP-11 compiler.

- `formatting.b`: signed decimal/octal, packed character pairs, and the
  historical handling of repeated percent signs.
- `function_cells.b`: replacing a source function while retaining its old value.
- `counted_arguments.b`: reading a counted argument list beyond the declared parameters.
- `parameter_cells.b`: walking the declared argument cells in order.
- `label_cells.b`: replacing a label value and observing it on later calls.
- `directory.b`: the historical `mkdir` name and directory status flag.

```sh
./bcc --strict --pedantic --word=16 examples/b72/formatting.b -o formatting
./formatting
python3 tests/test_docs_examples.py
python3 tests/test_docs_examples.py --native
```

Run `directory.b` in a scratch directory: it creates `b72dir` and fails if
that name already exists. The automated checker supplies a fresh working
directory for each execution. These examples demonstrate tested behavior;
they do not imply that every historical feature has been implemented.
