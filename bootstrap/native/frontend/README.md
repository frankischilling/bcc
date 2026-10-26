# Experimental 64-bit record frontend

This configuration reuses the B-written PDP-11 parser with separate numeric
helpers. It reads B source and writes unresolved compiler records with 64-bit
literal values. It does not produce assembly, an executable, or a self-hosted
host compiler.

The parser and I/O code remain shared. `word64.b` supplies literal normalization
and a startup check for 64-bit B cells; `decimal64.b` prints signed record fields,
including the minimum signed value. The native PDP-11 build selects its original
16-bit helpers instead. Widening this configuration does not change the native
PDP-11 compiler's word rules.

## Build and run

From the repository root:

```sh
make
mkdir -p bootstrap/build/native
python3 bootstrap/native/frontend/build.py bootstrap/build/native/front64
bootstrap/build/native/front64 -o records.ic program.b
```

The seed helper joins the B modules and invokes the selected compiler. It still
uses the C-output build path and current host runtime. Once built, the frontend itself reads source and
writes records without invoking a compiler or Python.

To save the complete B source without invoking a compiler:

```sh
python3 bootstrap/native/frontend/build.py bootstrap/build/native/front64.b --source-only
```

`--compiler` selects a different seed executable. Add `--bootstrap` when that
executable is one of the B-written C-output bootstrap stages. The produced
frontend refuses to run if it was built with 16-bit or 32-bit B cells.

The record pass shares the native frontend's command syntax: `-x` enables its
compatibility syntax, `-o` selects an output, and `-s` names a completion marker.
Without `-o`, records go to standard output. Wide numeric records must not be
fed to the 16-bit PDP-11 encoders.

For example, `main(){return(65536);}` produces an `n 65536` record. The
16-bit BCC configuration normalizes the same literal to `n 0`.

## Scope and limits

Decimal and octal literals normalize to 64-bit word patterns. Oversized literals
wrap as they do in BCC's host word model. Character constants still contain one
or two characters, and strings still end with EOT in the generated records.

This is not a replacement for the existing host frontend. It retains the
shared parser's eight-character identifiers, 255-byte string-content limit,
vector-size and automatic-frame limits, and bounded initializer lists. In
particular, it cannot parse the long identifiers in the existing host bootstrap
compiler unchanged. Its `-x` mode is the native parser's compatibility mode,
not a promise to accept every host extension.

A complete host path still needs record resolution and native lowering with the
host's parameter, pointer, label, function-cell, and runtime behavior. The
existing PDP-11 resolver drops unused argument declarations; a host resolver
must retain enough information to reproduce BCC's zero-filled missing
parameters. That host policy is not a guarantee taken from the PDP-11 manual.
The instruction, label, and word-operation libraries do not supply that whole path.

## Checks

```sh
python3 bootstrap/native/test_frontend.py
```

The checks cover wide and wrapping literals, the minimum signed value, retained
name and string limits, record output and completion markers, self-parsing, and
the seed helper's command-line paths. They also reject wrong-width builds.
`native-test` repeats the applicable checks through all three B bootstrap stages.
Parsing its own source is not the same as rebuilding its executable.
