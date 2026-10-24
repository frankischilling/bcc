# Runtime library

The host compiler uses `lib/libb.c` and its private headers, either linked
with generated C or embedded by `--inline-runtime`. It does not ship a
separate historical `libb.a`. Native PDP-11 programs use assembly syscall
wrappers and a B-written library under `pdp-11/bcc-pdp/runtime/`.

These implementations share tested interfaces, but are not interchangeable
Unix ABIs. Declare the library names you use with `extrn`. Host convenience
functions are not evidence that those functions existed in the selected
historical B environment.

## Interface map

- Characters and strings: `char`, `lchar`, `getchar`, `putchar`, `getstr`,
  `putstr`. See [strings](WIKI_STRING_OPERATIONS.md).
- Formatting: `printf` and `printn`. See [formatting rules](WIKI_IO_FUNCTIONS.md).
- Descriptors: `open`, `creat`, `close`, `read`, `write`, `seek`.
- Filesystem: `chdir`, `chmod`, `chown`, `link`, `unlink`, `stat`, `fstat`,
  `mkdir` (also available as `makdir`). See [file I/O](WIKI_FILE_IO.md).
- Processes and identity: `fork`, `wait`, `execl`, `execv`, `exit`, `getuid`,
  `setuid`. Host permission checks remain in force.
- Time: `time` and `ctime`, described below.
- Terminal and interrupts: `gtty`, `stty`, `intr`, with the limits below.

Host additions include `alloc`, `free`, `abort`, `system`, `usleep`, `argc`,
function-style `argv(i)`, `print`, `putnum`, `flush`,
`openr`, `openw`, `reread`, and `callf`. Do not assume the native compiler
implements every host helper. The host ABI declarations are in
[`libb.h`](../lib/libb.h), and source-name binding is in
[`src/emitter.c`](../src/emitter.c).

## Supplied library bindings

A program can supply its own function or data cell for a library name.
Formatting follows those bindings when it calls `char`, `putchar`, and
`printn`; line input follows `getchar` and `lchar`. Changing a supplied cell
also changes later callbacks. See the [output-capture example](../examples/b72/library_capture.b).
Host calls and function values resolve supplied library definitions even
when the provider was compiled into a separate object. Ordinary separate
B-object linking still requires strict mode when a name is not a known
runtime entry; compatibility mode also exposes C calls.

This is not yet writable storage for every host-owned built-in. Without a
supplied source cell, taking a built-in's address or replacing its binding
still has the documented host limits. The dynamic C-call bridge is a host
interop helper, not an ordinary historical library binding.

## Host command-line replay

`reread()` makes subsequent character input replay the program name and
arguments, joined with spaces and followed by a newline. After that input
ends, reading resumes from standard input. Empty arguments preserve their
space-separated positions; shell quoting is not reconstructed. With no
arguments after the program name, the helper leaves input unchanged.

Calling it again replaces any unread replay. It uses an anonymous seekable
file, so long argument lists do not depend on pipe capacity and repeated calls
do not accumulate open descriptors. This is a host helper, not a B72 library
entry.

## Library names vary by date

The [November 1971 library list](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man71.pdf#page=15)
includes `getchr`, `putchr`, `makdir`, and `intr`. The January 1972 B reference
instead describes `getchar`, `putchar`, and `mkdir` in its library section.
Those older names are not modern inventions. BCC retains several of them,
but a shared name does not prove identical semantics: the host `putchr`
helper writes one low byte, while `putchar` supports packed character pairs.
The host signal wrapper is also not a reconstruction of the original
interpreter's interrupt-handler mechanism.

## Arguments and process replacement

The predefined vector `argv` contains a count at index zero and the program
name at index one. Its argument strings use Unix NUL termination. Host
`argc()` and `argv(i)` are separate compatibility calls: their indexing
starts at zero for the program name, and function-style `argv(i)` returns a
B-terminated copy. Do not confuse either interface with optional main
parameters, whose conventions differ between host and native builds.

`execv(path,vector,count)` passes exactly `count` strings, including the
new program's argument zero. `execl` takes the path followed by arguments
and a zero sentinel. Both replace the current process on success and return
on failure. The host wrappers convert packed strings before calling libc;
they are not direct calls with host `char **` pointers.

`fork()` returns zero in the child and a process ID in the parent, or a
negative result on failure. `wait()` returns a process ID; do not interpret
that value as an exit status. Host-sized process IDs need not fit in a
16-bit B word. The fast native test observer is not a substitute for tests
inside the restored Unix kernel.

## File status

Host `stat` and `fstat` use the
[November 1971 status layout](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man2/stat.2),
not a host `struct stat`. Supply 20 B cells. A successful host call fills
17 cells and leaves the final three untouched; failure leaves the buffer
unchanged. Null buffers are rejected.

- Cell 0: low 16 bits of the inode number.
- Cell 1: allocation, directory, large-file, and permission flags.
- Cell 2: link count in the low byte, owner ID in the high byte.
- Cell 3: byte size modulo 65,536.
- Cells 4-11: zero; host disk block addresses are not V1 addresses.
- Cells 12-13 and 14-15: creation and modification times, high word first.
- Cell 16: zero, reserved.

The host's status-change time substitutes for unavailable creation time.
The large-file flag reflects a size above 4,096 bytes. V1's owner/other
permission fields cannot represent independent host group permissions.
Use 16-bit mode for byte access at PDP-11 offsets. These are explicit host
approximations, not a reconstructed disk inode. Native calls use the
restored filesystem and kernel's record.

## Time and date

`time(tv)` writes two words, high word first, containing a 32-bit count of
60 Hz ticks since January 1, 1971. The count wraps after about 2.27 years;
it cannot encode today's date without wrapping. `ctime(tv,date)` writes
15 printable characters and a NUL into a 16-byte destination, with no
newline. It is not a B-terminated string.

<!-- bcc-example {"stdout":"Jan  1 00:00:00\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn ctime, char, putchar;
    auto tv 2, date 8, i;
    tv[0]=0; tv[1]=0;
    ctime(tv,date);
    i=0;
    while(i<15) { putchar(char(date,i)); i=+1; }
    putchar('*n');
    return(0);
}
```

See the [V1 time entry](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man2/time.2)
and the date-boundary tests for the representation, not the modern Unix
seconds-since-1970 interface.

## Terminal and signal limits

The host `gtty` and `stty` wrappers currently expose three host `termios`
flag fields: input, output, and local flags. These are not the V1 terminal
control-word layout. Native wrappers call the restored kernel, while the
fast emulator stubs tty operations. Test tty behavior in the full system;
do not infer it from a fast test passing.

Host `intr(on)` changes SIGINT handling. It is not an implementation of
arbitrary historical interrupt handlers. Programs that alter terminal
settings must save and restore them, including on error paths.

## Allocation and interoperability

`alloc(n)` allocates host storage for `n` B cells; `free(p)` releases it.
Negative sizes and sizes whose byte count would overflow are rejected before
allocation. A zero-size request returns a freeable address backed by one host
cell; it does not promise any usable elements. Do not use a pointer after
freeing it. The translated 16-bit address pool is finite. Invalid sizes and
allocation failures terminate the program with a diagnostic rather than
raising a recoverable B exception.

`callf` is a host compatibility bridge, not an emulator for a Honeywell
Fortran or GMAP calling convention. It resolves selected shims and dynamic
symbols using the host ABI. `B_CALLF_LIB` selects an optional shared library;
any library loaded this way executes native code in the program's process.
See [`lib/libb.c`](../lib/libb.c) for dispatch, argument conversion, and
supported built-in shims before defining an external wrapper. No arbitrary
foreign ABI or floating-point argument convention is promised.

## Replacement and error handling

Source-defined library functions replace host source-level calls, including
function values. Internal calls within the bundled host runtime still use
its own helpers. All three compilers support writable cells for source-defined functions.
The native runtime also exposes writable library cells and interposition;
the host and bootstrap still lack that complete runtime interface.

Return conventions are per function, not a universal zero/success rule.
In particular, printing and string helpers should not be used as reliable
I/O error reporting. See the [conformance notes](HISTORICAL_CONFORMANCE.md)
for remaining differences and the [testing guide](../docs/testing.md) for
checks that distinguish host behavior from real-kernel behavior.
