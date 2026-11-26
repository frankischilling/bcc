# Host runtime (libb)

The C-source compiler and the assembly-source build share this runtime. The
host B-written compiler also uses it when compiling the C it emits. Keep the
runtime next to the compiler executable in a directory named `lib`.

`libb.c` and `libb.h` provide the library and its public declarations. The
other headers handle word sizes, initialization, calls, Unix interfaces,
formatting and primitive operations for shared and inline runtime builds.

The [runtime guide](../wiki/WIKI_RUNTIME_LIBRARY.md) documents the B-facing
interfaces. The [native B runtime](../native-b/runtime/README.md) and
[PDP-11 runtime](../pdp-11/bcc-pdp/README.md) have their own target-specific
implementations.
