# BCC

BCC compiles B programs through a C backend with GNU extensions and the GNU
toolchain. Its
language baseline is Ken Thompson's January 7, 1972 PDP-11 *Users' Reference
to B*. The repository also contains an x86-64 assembly-source build, a
B-written bootstrap compiler, and a separate native PDP-11 compiler.

Historical compatibility is a work in progress. Syntax, word arithmetic,
runtime interfaces, and the original Unix process image are different
parts of that work. The [conformance notes](wiki/HISTORICAL_CONFORMANCE.md)
record the sources, tested behavior, and remaining differences.

## Build and run

The host build needs GCC, Make, and a Unix-like environment. Tests also need
Python 3 and Bash. Curses headers are optional unless a program uses curses.

```sh
git clone https://github.com/frankischilling/bcc.git
cd bcc
make
./bcc --strict --pedantic --word=16 examples/hello.b -o hello
./hello
make test
```

A small B program looks like this:

<!-- bcc-example {"stdout":"hello\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn printf;
    printf("hello*n");
    return(0);
}
```

For a user-local installation:

```sh
make install PREFIX="$HOME/.local"
```

The installer places the compiler in `bin/` and its runtime sources in
`bin/lib/`. Keep them together: the compiler finds the runtime relative to
its executable. GCC is still needed when compiling B programs. `DESTDIR`
is supported for staged installations; `make test-install` checks that an
installed compiler can find both runtime layouts.

## Choose a build

- **`bcc`** is the maintained C-source host compiler. It supports shared or
  inline runtimes, multiple input files, and host/16/32-bit word modes. B
  library names have writable cells, so programs can replace a function
  and later restore its saved value.
- **[`bccasm`](asm/README.md)** builds the same compiler from checked-in
  x86-64 GNU assembler snapshots. Source and output hashes catch stale
  snapshots. Generated B programs use the same runtime as `bcc`.
- **[`bootstrap/`](bootstrap/README.md)** contains a compiler written in B.
  Its three-stage test compares generated C and runs conformance programs
  through every stage. It currently targets host-sized storage.
- **[`pdp-11/bcc-pdp/`](pdp-11/bcc-pdp/README.md)** is a separate compiler
  built with the restored historical C toolchain. It emits native PDP-11
  assembly, supports mutable function cells and general function-valued
  calls, and accepts string-valued external initializers. It has both fast
  tests and full Unix V1 system tests.

```sh
make -C asm check
make -C asm bootstrap
make -C bootstrap test
```

These are different checks. Assembling a staged `bccasm` is not B
self-hosting, and rebuilding the native C-written compiler inside Unix V1
is not the same as the B-written bootstrap's fixed-point test.

The [long-term bootstrap goal](wiki/BOOTSTRAP.md) is a B-maintained compiler,
runtime, and executable-building toolchain on both the host and PDP-11,
without an external C compiler or assembler after the seed stage. The
current build paths still have those dependencies. An experimental
[B-written execution engine](pdp-11/bcc-pdp/bootstrap/vm/README.md) now runs
the B-written resolver inside Unix V1 with exact output checks. Experimental
[B compiler passes](pdp-11/bcc-pdp/bootstrap/README.md#frontend-and-code-generators)
also run through that engine. A [B-written native image writer](pdp-11/bcc-pdp/bootstrap/image/README.md)
can construct supported PDP-11 executables without an external assembler or
image converter. An experimental [B build driver](pdp-11/bcc-pdp/bootstrap/driver/README.md)
now runs the passes and regenerates the target runtime files from B-maintained
sources after its seed. It is not installed as the normal compiler. Complete
in-guest source bootstrapping and a host native-output backend remain separate
work; the existing host builds still depend on C. An experimental
[B-written ELF image writer](bootstrap/native/README.md) can package x86-64
instruction bytes. B-written instruction and label encoders can construct
calls, loops, branches, and integer operations for those images, but they are
not yet a B-to-native compiler.

## Dialect and word modes

For the selected PDP-11 dialect, use:

```sh
./bcc --strict --pedantic --word=16 program.b -o program
```

Use `auto v 3;` for a three-word automatic vector. In this dialect, `break`,
`continue`, and `default` are ordinary identifiers, not control statements.
The default compatibility mode accepts additional syntax, including forms
found in other historical B implementations. Kernighan's tutorial describes
a different environment, so it is not interchangeable with the PDP-11 manual.

In strict mode, define external data at file scope and declare it with `extrn`
inside each function that uses it. A definition elsewhere in the file does
not make the name visible in every function. The declaration must precede
its first use. Function values need the same declaration, except for a
function's own name. Bare calls still infer an external for compatibility.

Adjacent operators matter:

```b
x =* 10;     /* multiply and assign */
x = *p;     /* assign the value through p */
x =- 1;     /* subtract and assign */
x = -1;     /* assign negative one */
```

String literals end with octal `004`. B escapes include `*n`, `*t`, `*e`, `*0`,
`**`, `*(`, and `*)`; the last two represent braces. Addition binds more
tightly than shifting, so `1 << 2 + 1` means `1 << (2 + 1)`.

`--word=host` wraps arithmetic at the host pointer width. Shifts fill
vacated bits with zero in every word mode. `--word=16` wraps arithmetic and
translates B addresses through registered host storage, with two characters
per B word. It selects word addressing by default, as does `--strict`.
`--byteptr` or `--wordptr` overrides that choice. `--word=32` wraps arithmetic
but retains native pointers, which can still be truncated by arithmetic.

Source functions retain all supplied argument cells, including those beyond
the declared parameter names. The [counted-argument example](examples/b72/counted_arguments.b)
shows how to walk such a list without depending on the host C calling convention.

The host 16-bit mode does not reproduce a PDP-11 process image. The separate
native compiler emits PDP-11 code with word-addressed data pointers; its
runtime converts those pointers at byte-oriented syscall boundaries.

## Compiler output and runtime

```sh
./bcc first.b second.b -o program
./bcc -S program.b > program.c
./bcc --asm program.b > program.s
gcc program.s -ldl -lm -o program
./bcc --emit-c --keep-c program.b -o program
```

`-S` emits C, not assembly. `--asm` lowers the complete program through the
C backend and emits host assembly. See the [CLI guide](docs/cli.md) for the
other modes and flags.

The host runtime provides B string and byte operations, formatted output,
file/process functions, and compatibility helpers. Shared runtime state is
the default and is used for multi-file programs. `--inline-runtime` embeds
the runtime in generated C instead.

The host `execv(path, argv, count)` uses a counted vector; `execl` accepts an
explicit `arg0`. The shell-free `system` extension supports quoted arguments
but performs no shell expansion or redirection. `callf` and `B_CALLF_LIB`
provide host-side foreign-call support; these are not a native V1 ABI.

`time` and `ctime(time, date)` use the V1 60 Hz, high-word-first clock format.
The date buffer is caller-owned and holds 15 characters plus NUL. That
32-bit clock wraps after roughly 2.27 years; it cannot represent today's
full date. Host stat and terminal layouts still need historical ABI work.

## Native PDP-11 tests

```sh
git submodule update --init pdp-11/unix-v1
make -C pdp-11/bcc-pdp
bash pdp-11/bcc-pdp/tests/run/run.sh
bash pdp-11/bcc-pdp/tests/ext/run.sh
```

The [testing guide](docs/testing.md) explains the fast runner's compatibility
container, byte-exact output checks, real-kernel tests, and in-system rebuild.
The full-system tests reserve swap space in the generated disk image and
keep compiler scratch files on the larger `/usr` disk. They do not alter the
pinned historical source files.

The predefined `argv` vector includes the argument count at index zero and
the program name at index one. It is distinct from the host `argv(i)`
compatibility function. The [runtime guide](wiki/WIKI_RUNTIME_LIBRARY.md#command-line-arguments)
explains the layouts and string terminators.

## Documentation and source layout

- [Testing and validation](docs/testing.md)
- [Command-line options](docs/cli.md)
- [Compiler architecture](docs/architecture.md)
- [Historical conformance and source hierarchy](wiki/HISTORICAL_CONFORMANCE.md)
- [B language guide](wiki/B_LANGUAGE.md)
- [Historical source review](wiki/SOURCE_REVIEW.md)
- [Runtime guide](wiki/WIKI_RUNTIME_LIBRARY.md)
- [Native compiler status](pdp-11/bcc-pdp/CONFORMANCE.md)

Rebuild B object files made with earlier versions. External data now uses
contiguous cell storage rather than the old pointer-based representation
of multiword simple globals.

The host compiler is in `src/`, with its runtime in `lib/`. Regression tests
are in `tests/`; example programs are in `examples/`. Variant-specific build
and test code stays under `asm/`, `bootstrap/`, and `pdp-11/bcc-pdp/`.

Known gaps include host filesystem/terminal emulation
limits, native cross-file symbol linkage, and 16-bit bootstrap storage.
Passing tests establish the cases they check, not a claim that the compiler
is bug-free or fully equivalent to the original implementation.

## References

- [Thompson's PDP-11 B manual](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
  and [original scan](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.pdf)
- [Kernighan's B tutorial](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.pdf)
- [November 1971 Unix manual, section VII excerpt](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man71.pdf)
- [Setting Up UNIX](https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist/setup.pdf)
- [Unix Heritage Society](https://www.tuhs.org/)
- [aap/b reconstruction](https://github.com/aap/b)
- [Mike Taylor's libb.a analysis](https://www.miketaylor.org.uk/tech/libb-a.html)

Maintained by [frankischilling](https://github.com/frankischilling).
See [LICENSE](LICENSE) for BCC's GPLv3 license. Historical materials and
pinned dependencies retain their own license notices.
