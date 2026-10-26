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

## Pathnames and identity

`chdir`, `link`, and `getuid` are also implemented in B. The pathname calls
return zero on success and -1 on error. They accept EOT- or NUL-terminated
strings, copy at most 4,095 bytes per pathname, and leave the input unchanged.
Missing arguments, null paths, and overlong strings fail before a syscall.
These checks do not validate arbitrary pointers. `getuid` returns the Linux
real user ID, not a reconstructed first-edition user table.

The shared private `__path` provider packs bytes directly, so replacing `char`
or `lchar` does not alter OS pathname conversion. The public function cells
remain writable, and saved originals remain callable. Tests check errors,
existing destinations, unchanged strings, non-UTF-8 names, boundary lengths,
and function replacement. Run them against an exported bundle with:

```sh
python3 bootstrap/native/test_paths.py --tools bootstrap/build/native-verified --reference ./bcc
```

## File status

`stat` and `fstat` translate Linux status into the same V1-shaped record as the
C-backed host runtime. Supply 20 B cells. Success writes the first 17 cells;
the remaining three are preserved. Missing arguments, null buffers, pathname
errors, and failed syscalls return -1 without changing the output buffer.

The record contains the low 16 inode and size bits, V1 permission/type flags,
packed link-count and owner bytes, and wrapped 60-Hz creation/modification
values. Linux status-change time substitutes for birth time, and disk-address
cells are zero. These are host approximations, not a native V1 disk record.
The adapter uses the 144-byte Linux x86-64 status structure internally; it does
not copy that structure into the caller's B buffer.

Tests cover all output cells and surrounding guards, permission flags,
directories, symbolic links, size and timestamp wrapping, source overrides,
saved function cells, and errors. Synthetic records check truncated owner/link
fields and timestamp extremes without changing system ownership or time.

```sh
python3 bootstrap/native/test_metadata.py --tools bootstrap/build/native-verified --reference ./bcc
```

## Clock and date buffers

`time` converts Linux realtime seconds and nanoseconds into two B cells,
high word first, containing the low 32 bits of 60-Hz ticks since January 1,
1971. This wraps after about 2.27 years; it is not an unbounded modern timestamp.
An explicit null destination is allowed, as in the host runtime. A failed clock
call returns -1 and leaves a non-null destination unchanged.

`ctime` converts that wrapped value into 15 printable date bytes plus a NUL,
with no newline. Supply 16 writable bytes, not a pointer to a shared libc
buffer. Bytes after that range are preserved, and input/output overlap is
supported. Null pointers or missing arguments return -1. The result is not an
EOT-terminated B string. Conversion packs bytes directly instead of calling
the program's writable `char` or `lchar` cells.

The date tests cover 90 vectors, including month/year boundaries, leap day,
subsecond truncation, and the largest wrapped value. Other cases check buffer
guards, overlapping storage, replaced functions, clock failure, and realtime
values bounded by host observations. The metadata adapters share the same
private tick converter.

```sh
python3 bootstrap/native/test_clock.py --tools bootstrap/build/native-verified --reference ./bcc
```

## Counted process replacement

`execv.b` implements B's explicit argument count, converts EOT/NUL strings
without changing them, and inherits the current process environment.
Path and argument packing is private: replacing `char` or `lchar` does not
change the bytes sent to the kernel. It accepts at most 255 arguments,
a pathname of at most 4,095 bytes, and 62,400 total copied pathname/argument
bytes including terminators. Failure returns -1; success replaces the process.
These bounds are native implementation limits, not promises from B72.

The [driver](../driver/README.md) selects these providers and their dependencies.
The private syscall and environment interfaces are described in the
[runtime guide](../runtime/README.md#private-kernel-bridge).
