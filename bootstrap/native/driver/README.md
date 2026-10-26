# Native command driver

The B-written driver accepts one source path:

```sh
driver input.b -o new-program
driver input.b > program-image
```

It locates sibling tools through `/proc/self/exe`, copies the input once into a
private scratch directory, and runs the frontend, resolver, constructor, and
image writer. Its private exec bridge preserves NUL-terminated OS paths and
arguments, including EOT and non-UTF-8 bytes. It does not use the B library's
EOT string convention for filenames, a shell, or an external command launcher.
Failed passes stop the build; image-write failures reach the driver exit status.

Scratch files belong to that invocation. Parallel invocations do not share the
constructor's fixed filenames or overwrite files in the caller's directory.
The driver uses a private per-process umask for scratch files, so restrictive
caller masks do not make its workspace unusable. Ordinary success and failure
paths remove the private files and directory.
An interrupted or killed process can leave its directory under
`/tmp/bcc-native-PID-N`; there is no signal-cleanup handler yet. The driver
requires Linux procfs, writable `/tmp`, and source/tool paths within its
4 KiB pathname buffers.

## Named executable output

`-o` writes a complete image into an exclusively created temporary file in the
output directory, checks the writes, sync and closes, then publishes it with
[link(2)](https://man7.org/linux/man-pages/man2/link.2.html). It never replaces
an existing destination, including symbolic links, dangling links, hardlinks,
or the input itself. Concurrent writers to one destination cannot overwrite
one another. The output directory must support hard links.

The requested file mode is 0700, filtered by the caller's original umask. The
driver restores that mask before creating the output temporary file; it does
not force executable permission when the caller disabled it. No external
`chmod` is needed with a normal executable-permitting mask. Output files are
not created when compilation fails.

The publication is atomic, not a promise of crash durability: the directory
entry is not explicitly synced. Interrupted runs can leave `.bcc-output-*`
temporary files. Standard-output mode remains available, but shell redirection
can truncate an input before the compiler starts; prefer `-o` when protecting
an existing path matters.

## Runtime providers

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
parallel invocations, preserved caller files, and a full output device. Named
output tests also cover writer races, symlinks/hardlinks, file-size limits,
restrictive umasks, and control-byte paths. The
same B driver rebuilds all five native tools byte-for-byte. It is still an
experimental single-input compiler, not a replacement for all installed
`bcc` options, word models, runtime functions, or the PDP-11 compiler.

See [build and export instructions](../README.md#try-the-verified-native-tools).


The implementation is split between `main.b` (input and pass coordination),
`process.b` (OS-string process arguments), and `output.b` (named output).
The driver checks can be run against an exported bundle without modifying it:

```sh
python3 bootstrap/native/test_driver.py --tools bootstrap/build/native-verified
```
