# Examples

The chapter examples are complete programs with checked output:

- [Hello](B_LANGUAGE.md).
- [Parameters, recursion, and function values](WIKI_FUNCTIONS.md).
- [Contiguous cells and pointer arithmetic](WIKI_ARRAYS_POINTERS.md).
- [Loops and switches](WIKI_CONTROL_STRUCTURES.md).
- [Packed characters](WIKI_DATA_TYPES.md).
- [Building strings and preserving NUL bytes](WIKI_STRING_OPERATIONS.md).
- [Formatting](WIKI_IO_FUNCTIONS.md).
- [Writing and reading a file](WIKI_FILE_IO.md).
- [Formatting a historical date](WIKI_RUNTIME_LIBRARY.md).

The documentation test compiles these programs rather than maintaining
handwritten examples of their generated C. To inspect current generated C,
use `bcc -E program.b`; the output depends on the compiler revision, word
mode, pointer mode, and runtime layout.

## Repository examples

The [`examples/`](../examples/) directory also contains larger programs:
`euclid.b`, `sieve.b`, `binary_search.b`, `hanoi.b`, `string_bytes.b`,
`digit_histogram.b`, `mandelbrot.b`, and `brainfuck.b`, among others.
These are project examples, not transcriptions certified as strict PDP-11 B.
Some use host compatibility syntax or libraries.

```sh
./bcc examples/euclid.b -o euclid
./euclid
```

Interactive and graphical examples have additional requirements. For
example, curses programs require curses headers and `-l ncurses`;
`donut.b` uses host helpers and terminal output. Do not assume such examples
are native PDP-11 test cases. Inspect their inputs and dependencies before
running them, especially examples that create files or change terminal state.

Tutorial-derived programs should be read in their original dialect context.
Kernighan's tutorial describes H6070/MH-TSS B, not the Unix syscall library.
The [historical source guide](HISTORICAL_CONFORMANCE.md) explains why a
program from one source may require adaptation for another environment.
