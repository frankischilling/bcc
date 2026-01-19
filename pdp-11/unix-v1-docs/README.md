# UNIX V1 Documentation - Markdown Transcriptions

This directory contains markdown transcriptions of the original UNIX Programmer's Manual (First Edition, November 1971).

## Original Source

These documents are transcriptions of the scanned PDFs from the original UNIX Programmer's Manual by K. Thompson and D.M. Ritchie. The manual was prepared using the `ed` text editor and `roff` formatting program.

## Manual Structure

The manual is divided into seven sections:

### I. Commands (4 parts)
- `unix-commands-p1.md` - Commands A-M (ar, as, B, bas, bcd, boot, cat, chdir, chmod, chown, cmp, cp, db, dbppt)
- `unix-commands-p2.md` - Commands N-Z (dc, df, dsw, dtf, du, ed, find, for, form, hup, lbppt, ld, ln, ls, mail, mesg, mkdir, mkfs, mount, mv, nm, od, pr, rew, rkd, rkf, rkl, rm, rmdir, roff, sdate, sh, stat, strip, su, sum, tap, tm, tty, type, umount, un, wc, who, write)
- `unix-commands-p3.md` - Additional commands (continued)
- `unix-commands-p4.md` - Final commands (wc, who, write)

### II. System Calls (2 parts)
- `unix-sys-calls.md` - Basic system calls (break, cemt, chdir, chmod, chown, close, creat, exec, exit, fork, fstat, getuid, gtty, ilgins, intr, link, mkdir, mknod, open, pipe, read, rele, seek, setuid, stat, stime, stty, tell, time, umount, unlink, wait, write)
- `unix-sys-calls-p2.md` - Advanced system calls (mount, open, quit, read, rele, seek, setuid, smdate, stat, stime, stty, tell, time, umount, unlink, wait, write)

### III. Subroutines
- `unix-library-routines.md` - Standard C library functions (atof, atoi, ctime, exp, fptrap, ftoa, getw/getc/fopen, itoa, log, mesg, ptime, putc/putw/fcreat/flush, sin/cos, switch)

### IV. Special Files
- `unix-special-files.md` - Device files and I/O (/dev/mem, /dev/ppt, /dev/rf0, /dev/rk0, /dev/tap0-7, /dev/tty, /dev/tty0-5)

### V. File Formats
- `unix-file-formats.md` - Data file structures

### VI. User-Maintained Programs
- `unix-user-maintained-software.md` - Contributed software

### VII. Miscellaneous
- `unix-miscellaneous.md` - System internals, boot procedures, libraries, init, login/logout

## Additional Documents

- `manintro.md` - Manual introduction and conventions
- `CMAN74.md` - C Reference Manual (1974, K&R)
- `CMAN74_full.tex` - LaTeX version of C Reference Manual
- `CMAN74.pdf` - Compiled PDF of LaTeX C Manual
- `pdpbcc.c` - Minimal B compiler skeleton (PDP-11 C)

## Manual Conventions

Each entry follows a standard format:

- **NAME**: Brief description
- **SYNOPSIS**: Usage syntax
- **DESCRIPTION**: Detailed explanation
- **FILES**: Related files
- **SEE ALSO**: Related entries
- **DIAGNOSTICS**: Error messages
- **BUGS**: Known issues
- **OWNER**: Responsible person

## Historical Context

This represents UNIX in its earliest documented form:
- **Date**: November 3, 1971
- **System**: UNIX Version 1
- **Hardware**: PDP-11/45
- **Authors**: K. Thompson, D.M. Ritchie

## Related Materials

- Original scanned PDFs in this directory
- `pdpbcc.c` - Minimal B compiler skeleton
- Modern C Reference Manual transcription

## Transcription Notes

- ✅ Content transcribed from scanned originals
- ✅ Formatting converted to modern markdown
- ✅ Historical code examples preserved
- ✅ PDP-11 specific details maintained
- ✅ Cross-references updated where possible
- ✅ All seven manual sections completed
- ✅ LaTeX version of C Reference Manual created
- ✅ Historical B compiler skeleton included
- ✅ Complete UNIX Version 1 documentation preserved

This represents a comprehensive digital archive of the earliest UNIX documentation, covering the complete Programmer's Manual from November 3, 1971.
