# B-written runtime selection

The selector preserves retained assembly bytes while removing public labels
that a program defines itself. It includes the B library when a program
mentions one of its public functions, and omits unused primitive exec or
process-metadata groups. It follows the existing selector's conservative
handling of long lines rather than guessing that a split name is unused.

Its arguments are:

```text
selector [-s marker] program primitive library out-primitive out-library
```

The output library is empty when no B-library group is needed. When supplied,
the completion marker is written only after both outputs close successfully.
Callers own marker freshness and file isolation. Exact output/input and marker
aliases are rejected; hard links and alternate path spellings are not detected.

Input is read in 256-byte blocks, with 1,040-byte line pieces. Writes are split
into blocks no larger than 256 bytes so the same source works through the
execution engine. Public definitions use a 512-slot table. The selector does
not rename library labels; the code generator's `-L` mode assigns that namespace.
