# B language guide

BCC's historical baseline is Thompson's January 7, 1972 PDP-11 B reference.
The repository contains several implementations and host conveniences;
choosing a compiler or a flag changes which parts of that baseline are
modeled. Start with the [README](../README.md) for build commands and the
[conformance notes](HISTORICAL_CONFORMANCE.md) for evidence and known gaps.

## A small program

<!-- bcc-example {"stdout":"hello\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn printf;
    printf("hello*n");
    return(0);
}
```

Strict programs use `/* comments */`, names of at most eight characters,
asterisk character escapes, and parenthesized return values. An automatic
vector is written `auto v 3;`, not `auto v[3];`. Initialize an automatic
scalar with a following assignment; `auto n 3;` declares a vector rather
than setting a scalar to three.

## Read by topic

- [Words and literals](WIKI_DATA_TYPES.md): numeric modes, packed characters,
  string terminators, and EOF.
- [Arrays and pointers](WIKI_ARRAYS_POINTERS.md): cells versus vectors,
  address units, indexing, and lifetime.
- [Functions](WIKI_FUNCTIONS.md): parameters, recursion, function values,
  return syntax, and backend limits.
- [Control flow](WIKI_CONTROL_STRUCTURES.md): conditions, loops, switches,
  and computed branches.
- [Strings](WIKI_STRING_OPERATIONS.md): packed-byte access and buffer sizes.
- [Formatted I/O](WIKI_IO_FUNCTIONS.md): B72 formatting and host extensions.
- [File I/O](WIKI_FILE_IO.md): byte counts, permissions, and descriptors.
- [Runtime](WIKI_RUNTIME_LIBRARY.md): Unix interfaces and emulation limits.
- [Examples](WIKI_EXAMPLES.md) and [tests](WIKI_TESTS.md).

The [CLI guide](../docs/cli.md) covers host options. The
[B-written bootstrap](../bootstrap/README.md) and
[native PDP-11 compiler](../pdp-11/bcc-pdp/README.md) have their own interfaces.
Do not assume a host flag is accepted by the native driver.

## Dialects are not interchangeable

Default host mode accepts compatibility syntax. `--strict --pedantic`
selects the PDP-11 syntax checks, while `--word=16` separately selects
16-bit arithmetic with translated addresses. These options do not make a
host executable into an original PDP-11 process image or implement every
historical library detail.

Some syntax rejected by this baseline appears in other historical B
dialects. Kernighan's H6070/MH-TSS tutorial is useful, but its library and
some statement forms differ from the PDP-11 manual. The
[source comparison](HISTORICAL_CONFORMANCE.md) records those distinctions.
