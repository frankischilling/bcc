# Native runtime and linking

The maintained compiler uses its own runtime under `bcc-pdp/runtime/`:

- `bmain.s` sets up B's argument vector and calls the program's `main` cell.
- `brt.s` provides arithmetic, character I/O, and system-call wrappers.
- `libb.b` provides printing, line input, and date formatting. The native
  compiler generates the checked-in `libb.s` from it.

The driver assembles startup, selected runtime definitions, and program
assembly together. Program definitions can replace library bindings; runtime
selection avoids duplicate definitions. See the [native compiler guide](bcc-pdp/README.md)
for the build commands and current limits.

This is not the historical threaded-code calling convention. The original
`bilib`, `brt1`, `brt2`, and `libb.a` cannot be substituted just by adding
`ld -lb`. The original runtime is useful comparison material, not a binary
compatible library for BCC's native output.

B data pointers count words, while character indices and read/write lengths
count bytes. Filename and exec wrappers translate B's `004` terminator to
Unix NUL termination. Public function names have writable cells containing
code addresses; handwritten calls must load the cell's value.

The [conformance notes](bcc-pdp/CONFORMANCE.md) distinguish implemented
wrappers from their host and restored-system limitations. In particular,
a fast emulator result does not establish terminal behavior in the kernel.
