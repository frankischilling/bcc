# Host compiler command line

```sh
bcc [options] input.b ... [-o output]
```

Run `bcc` without an input to print its option list. `bccasm` uses this same
interface. The B-written bootstrap and native PDP-11 driver have separate,
smaller interfaces documented in their own directories.

## Output modes

- With no output-mode flag, compile and link an executable.
- `-o PATH` selects the output path.
- `-c` compiles object files without linking.
- `-S` prints generated C for one input.
- `-E` writes generated C for one input.
- `--asm` prints host assembly for one input, using the C backend.
- `--emit-c` names generated C files `input.b.c` and keeps them; normal
  compilation still continues.
- `--keep-c` retains generated C, including temporary-name output.

Choose one output mode at a time. Generated host assembly can be assembled
and linked with GCC and `-ldl -lm`. It is not PDP-11 assembly.

## Language and storage

- `--strict` selects the January 1972 PDP-11 syntax checks, including the
  eight-character name limit. Dots in names remain a host compatibility
  extension, not strict B syntax.
- `--pedantic`, used with `--strict`, diagnoses disabled extension syntax.
- `--word=host`, `--word=16`, or `--word=32` selects arithmetic/storage mode.
- `--byteptr` and `--wordptr` explicitly select pointer units.
- `--inline-runtime` embeds the runtime in generated C. Otherwise, generated
  units link to the shared runtime and address state.

Strict mode also selects B72 formatting and 004-only string termination in
the host runtime. Default mode retains the documented compatibility formats
and NUL termination. See [formatted I/O](../wiki/WIKI_IO_FUNCTIONS.md).

Strict syntax and word size are independent choices. Strict or 16-bit mode
selects word addressing unless a pointer mode was explicitly requested.
The 32-bit mode still has the native-pointer limitation described in the
conformance notes.

## Host toolchain

- `-g` requests debug information.
- `-Wall` / `-Wno-all` enable or disable the main warning group.
- `-Wextra` / `-Wno-extra` enable or disable extra warnings.
- `-Werror` treats warnings as errors.
- `-l LIB` adds a linker library; it can be repeated. Use `-l ncurses` for
  curses programs so the compiler also includes the required headers.
- `-X FLAG` passes one argument to GCC; repeat it for multiple arguments.

```sh
bcc program.b -X -O3 -X -I/path/to/headers -l example -o program
```

## Inspection and diagnostics

- `-v` prints compilation details.
- `--dump-tokens` shows lexical tokens.
- `--dump-ast` shows the parsed syntax tree.
- `--dump-c` shows generated C.
- `--no-line` omits generated `#line` directives.
- `--verbose-errors` selects descriptive errors instead of short codes.

When reporting a failure, include the source, complete command, word and
pointer modes, compiler revision, and whether the shared or inline runtime
was used. Keep generated C with `--keep-c` when the failure occurs in GCC.
