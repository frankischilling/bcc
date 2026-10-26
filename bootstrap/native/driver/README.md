# Native command driver

`driver/main.b` accepts one source path and writes a Linux x86-64 executable to
standard output. It locates its sibling tools through `/proc/self/exe`, copies
the input once into a new mode-0700 scratch directory, and runs the frontend,
resolver, constructor, and image writer. It uses `fork`, counted `execv`, and
direct wait calls, not a shell or an external command launcher. Failed passes
stop the build; final image-write failures reach the driver exit status.

Scratch files belong to that invocation. Parallel invocations do not share the
constructor's fixed filenames or overwrite files in the caller's directory.
Ordinary success and failure paths remove the private files and directory.
An interrupted or killed process can leave its directory under
`/tmp/bcc-native-PID-N`; there is no signal-cleanup handler yet. The driver
requires Linux procfs, writable `/tmp`, and source/tool paths within its
4 KiB pathname buffers.

For a referenced library name without a source definition, the driver appends
the matching bundled B source and reruns the frontend and resolver. It repeats
this for library dependencies, adding each provider at most once. A source
function, scalar, or vector prevents replacement, including definitions later
in the file. A missing provider or a file that fails to define its advertised
name stops the build. The catalog currently includes `execv`, `printf`,
`printn`, `putchar`, `getchar`, `putstr`, and `getstr`.

See the [B library guide](../lib/README.md) for provider behavior and limits.

Tests cover process replacement, argument and environment preservation, invalid
counts and strings, source overrides, missing tools and runtime sources,
parallel invocations, preserved caller files, and a full output device. The
same B driver rebuilds all five native tools byte-for-byte. It is still an
experimental single-input compiler, not a replacement for all installed
`bcc` options, word models, runtime functions, or the PDP-11 compiler.

See [build and export instructions](../README.md#try-the-verified-native-tools).
