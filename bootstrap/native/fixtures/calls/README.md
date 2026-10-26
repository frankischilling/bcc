# Call test constructors

These B files are fixtures for `test_calls.py`, not installed compiler passes.
The test runner builds them in a private temporary directory and owns their
input and output paths. Do not run their file-writing entry points in a
working directory containing files you need to keep.

- `abi.b` constructs focused call-frame and invalid-API cases.
- `metadata.b` collects declared parameter counts and local-frame sizes.
- `emission.b` resolves source-function symbols to writable cells and lowers
  their bodies with the native libraries.
- `driver.b` selects runtime providers, then coordinates two code-layout passes
  and static data output.

The whole-function constructor emits a binary-result reporting entry point for
comparison, not normal startup. Imported `argv` data uses the native entry
argument packer, but `main` parameters and compatibility argument functions
remain unsupported. It binds the initial Linux runtime primitives when a referenced name has no
source definition. Other unresolved symbols are rejected. Globals, vectors, address initializers, writable strings,
and label cells use the static-data modules. Control lowering handles switches
and computed goto. It is useful evidence that the
libraries work together, but it is not a general B compiler or a completed
self-hosting path.

The constructor has 200 function-metadata slots. The host-configured resolver has
a 1,024-symbol budget that includes function-local imports and declarations, so
a source program can reach that limit earlier. These fixture limits do not
replace the normal host compiler's limits.
