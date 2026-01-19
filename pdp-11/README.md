# PDP-11 / Unix V1 B Compiler Plan (for SimH UNIX v1 Restoration)

This project targets development, testing, and validation of a B-to-PDP-11 C compiler using the reconstructed 1st Edition UNIX system in the [jserv/unix-v1 Restoration Repository](https://github.com/jserv/unix-v1). All compilation and execution will be performed inside the SimH PDP-11 emulator, booting disk images produced by this repository, which provides a historically faithful environment. (See also: Warren Toomey's "The Restoration of Early UNIX Artifacts.")

## Primary Environment and Emulator

- **System**: 1st Edition UNIX, reconstructed, running on SimH's PDP-11 emulation
- **Emulator**: [SimH PDP-11 Emulator](https://github.com/simh/simh)
- **Boot/disks**: Built using `make` per unix-v1 repo; images (rf0.dsk, rk0.dsk) bootable with SimH
- **Login workflow**: 
    - Boot SimH per README (`make run` or `./simh.cfg`), log in as `root`
    - Basic commands: `ls -l`, `chdir`, `ed` (sole editor), etc.
    - Shutdown: Ctrl-E, followed by `q`
- **Toolchain**: 
    - `/bin/cc` (early C compiler—2nd Edition dialect)
    - `/bin/as` (Unix V1 assembler)
    - `/bin/ld` (linker)
    - `/usr/lib/libb.a` (B runtime)
    - No modern libc; minimize dependencies outside these tools

## Compilation Pipeline (inside SimH/UNIX v1):

1. Write `.b` (B source) file on the UNIX v1 system (use `ed`)
2. Compile: our C-based B-compiler (to be named, e.g. `bcc_v1.c`), running on the PDP-11, converts `.b` to PDP-11 assembly (in V1 Unix `as` syntax)
3. Assemble: `as program.s` → produces object file
4. Link: `ld -lb a.out` (plus any extra objects as needed)

## Constraints & Conventions

- **Target platform**: PDP-11/20, 16-bit words, word-addressed pointers, string literals terminate with octal 004 (`*e`)
- **Language/tool limitations**: 
    - K&R C style (no ANSI/prototypes)
    - No preprocessor (`#define`, `#include`, etc., not available)
    - No `struct` (oldest C can't parse them)
    - Pointer types declared as arrays: (`char s[]; int argv[];`) not `*`
- **Runtime**: Depend exclusively on system `libb.a` for builtins and runtime; only add minimal fallbacks if absolutely needed
- **Output**: Generate `.s` files in V1 assembly; do not attempt automation of assembly/link steps—use system's own `as`/`ld`
- **Testing platform**: Binaries and source must build and run inside SimH-simulated PDP-11 UNIX v1 disk images

## Implementation Steps

- Build a minimal Thompson-style B front-end (lexer and parser) in C, compatible with the early UNIX v1 cc
    - Support token forms: classic B operators (`=+`, `=-`, etc), multi-char constants, *e strings
- Emit assembly in V1 `as` syntax:
    - Function prologue/epilogue using r5 as frame, `jsr pc` for calls, preserve callee-save regs (r2–r5)
    - Place global/static data and emitted string literals in `.data`/`.text` as per V1 conventions
- Integration:
    - Optionally, add host `--pdp11-v1` output flag (if run on modern host)
    - Deliver a standalone C source (`pdp11/bcc_v1.c`) for compilation via V1 `/bin/cc` directly under SimH UNIX

## Immediate Next Tasks

- Review/define V1 assembly boilerplate templates (function headers, label conventions, string/data emission)
- Implement a simple lexer and parser skeleton, confirming it compiles with UNIX v1 `/bin/cc`
- Wire minimal codegen for expressions/statements (print/loop/test)
- Add tiny `.b` test programs under `pdp11/tests/` on the UNIX v1 filesystem, to verify codegen and system I/O using the V1 runtime and system tools

## References

- [1st Edition UNIX Restoration repo/README](https://github.com/jserv/unix-v1)
- [SimH PDP-11 Emulator](https://github.com/simh/simh)
- 1st Edition UNIX Programmer's Manual: [cat-v.org mirror](https://man.cat-v.org/unix-1st/) & [PDF](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v1/UNIX_ProgrammersManual_Nov71.pdf)
- V1 kernel implementation doc: [PreliminaryUnixImplementationDocument_Jun72.pdf](http://www.bitsavers.org/pdf/att/unix/Early_UNIX/PreliminaryUnixImplementationDocument_Jun72.pdf)
- PDP-11/20 handbook: [PDF](http://www.bitsavers.org/pdf/dec/pdp11/handbooks/PDP1120_Handbook_1972.pdf)
- Early C reference: ["C Reference Manual" (1974)](https://web.archive.org/web/20240425202413/https://www.bell-labs.com/usr/dmr/www/cman74.pdf)
- [7th Edition Unix at 40 (video)](https://www.youtube.com/watch?v=TcUdsO11P4I)

For repository layout, building, operation, and licensing, see unix-v1 repo README and LICENSE.
