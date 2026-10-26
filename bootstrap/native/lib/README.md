# Native B library

The B sources in this directory supply strict character/string I/O and the selected
B72 formatting rules. `printf` recognizes `%d`, `%o`, `%c`, and `%s`.
An unknown conversion prints `%` and revisits the following character without
consuming an argument. This is not C's percent handling: `%%d` with argument
42 prints `%42`. `printn` supports bases 2 through 16 and negative values as
existing BCC extensions, including the minimum signed word without overflow.

`putchar` writes the high byte first when it is nonzero, then the low byte;
only the low 16 bits affect output. `getchar` reads one byte and returns EOT
on end-of-file or read failure. `getstr` stops at newline or EOT, stores an EOT
terminator, and returns the character count. It does not have a buffer-size
argument; callers must provide enough writable storage. These initial helpers
use descriptors zero and one, not the host compatibility runtime's redirected
input/output-unit state.

`%s` and `putstr` stop at EOT, not NUL. Embedded NUL bytes are preserved.
Predefined `argv` strings instead end with NUL; convert their terminator or
use `write` with an explicit byte count rather than passing them directly to
these strict string functions. The compatibility `argv(index)` helper is not
implemented by this native subset.

Library calls resolve the current writable function cells. Formatting honors
replacements for `char`, `putchar`, and `printn`; `getstr` honors replacements
for `getchar` and `lchar`. Saved originals remain callable after rebinding.
Low-level character packing and byte input do not invoke replacement `lchar`
or `char` functions, matching the host runtime's separation of those operations.
Counted-frame checks reject missing arguments, and `printf` reports a short
conversion argument list instead of reading beyond it. Output helpers retain
the existing runtime's unchecked-write behavior; use `write` directly when
its returned count must be checked.

The native rebuild test includes standard-I/O cases and host-reference
comparisons where the interfaces match. They cover embedded NUL/EOT bytes,
packed pairs, wide numbers, unknown and trailing conversions, argument counts,
source definitions, callbacks, and saved function values. You can also test an
exported bundle:

```sh
python3 bootstrap/native/test_stdio.py --tools bootstrap/build/native-verified --reference ./bcc
```

The language baseline is [B72 sections 8 and 9](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html).
The wider integer, base-16, safety, and additional string-helper behavior above
follows BCC's existing strict runtime; it is not all claimed as historical B72.

## Counted process replacement

`execv.b` implements B's explicit argument count, converts EOT/NUL strings
without changing them, and inherits the current process environment. It accepts at most 255 arguments,
a pathname of at most 4,095 bytes, and 62,400 total copied pathname/argument
bytes including terminators. Failure returns -1; success replaces the process.
These bounds are native implementation limits, not promises from B72.

The [driver](../driver/README.md) selects these providers and their dependencies.
The private syscall and environment interfaces are described in the
[runtime guide](../runtime/README.md#private-kernel-bridge).
