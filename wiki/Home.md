# BCC wiki

BCC is a B compiler project with a host C backend, an x86-64 assembly-source
build, a B-written bootstrap compiler, and a separate native PDP-11 compiler.
Its historical language baseline is Thompson's January 7, 1972 PDP-11
*Users' Reference to B*. Historical compatibility remains work in progress.

## Start here

- [Build and run BCC](../README.md).
- [Language guide](B_LANGUAGE.md).
- [Compiler options](../docs/cli.md).
- [Historical sources and remaining differences](HISTORICAL_CONFORMANCE.md).

## Language and library

- [Words and literals](WIKI_DATA_TYPES.md).
- [Control flow](WIKI_CONTROL_STRUCTURES.md).
- [Functions](WIKI_FUNCTIONS.md).
- [Arrays and pointers](WIKI_ARRAYS_POINTERS.md).
- [Strings](WIKI_STRING_OPERATIONS.md).
- [Formatted output](WIKI_IO_FUNCTIONS.md).
- [File I/O](WIKI_FILE_IO.md).
- [Runtime library](WIKI_RUNTIME_LIBRARY.md).
- [Unix interfaces](WIKI_SYSTEM_CALLS.md).

## Examples and development

- [Examples](WIKI_EXAMPLES.md), including [runnable strict programs](../examples/b72/README.md).
- [Tests](WIKI_TESTS.md) and [all backend test commands](../docs/testing.md).
- [Architecture](../docs/architecture.md).
- [Assembly-source build](../asm/README.md).
- [B-written bootstrap](../bootstrap/README.md).
- [Native PDP-11 build](../pdp-11/bcc-pdp/README.md).

The chapter examples are executed by the documentation test. Claims about
language rules, host emulation, and original Unix behavior are kept separate;
a green build is not proof that the whole implementation is bug-free.
