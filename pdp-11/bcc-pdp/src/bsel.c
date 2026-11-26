/* Keep program definitions in preference to bundled library cells.
 * Removing a label emits no bytes: retained library bodies keep their layout.
 * Input is compiler-generated assembly, not arbitrary assembler syntax.
 */
selbuf[256];
sellin[520];
selnam[1000];
selnum 0;
selpos 0;
sellen 0;
seltail 0;
selpart 0;
uselib 0;
usexec 0;
usemet 0;

selclr() {
    extern selpos, sellen, seltail, selpart;
    int selpos, sellen, seltail, selpart;
    selpos = 0; sellen = 0; seltail = 0; selpart = 0;
}

/* Long data lines are copied in chunks, never mistaken for public labels. */
selget(fd) {
    extern selbuf, sellin, selpos, sellen, seltail, selpart;
    char selbuf[], sellin[];
    int selpos, sellen, seltail, selpart, n, c;
    n = 0; selpart = seltail; seltail = 0;
    while (1) {
        if (selpos >= sellen) {
            sellen = read(fd, selbuf, 512);
            selpos = 0;
            if (sellen < 0) failmsg("b: runtime read failed\n");
            if (sellen == 0) break;
        }
        if (n >= 1039) { seltail = 1; break; }
        c = selbuf[selpos++];
        sellin[n++] = c;
        if (c == '\n') break;
    }
    sellin[n] = 0;
    return(n);
}

/* Recognize a standalone public label; copy its name without the colon. */
sellab(s, name) char s[], name[]; {
    extern seltail, selpart;
    int seltail, selpart, i, n, c;
    name[0] = 0;
    if (seltail | selpart) return(0);
    i = 0; n = 0;
    while (s[i] == ' ' | s[i] == '\t') i++;
    if (s[i] != '_') return(0);
    while (1) {
        c = s[i++];
        if (c == ':') break;
        if (c == 0 | c == '\n' | n >= 9) { name[0] = 0; return(0); }
        name[n++] = c;
    }
    while (s[i] == ' ' | s[i] == '\t' | s[i] == '\r') i++;
    if (s[i] != 0 & s[i] != '\n') { name[0] = 0; return(0); }
    name[n] = 0;
    return(1);
}

/* Match complete external names, not prefixes such as _ctimex. */
selchr(c) {
    return(c >= 'a' & c <= 'z' | c >= 'A' & c <= 'Z' |
           c >= '0' & c <= '9' | c == '_');
}

selstr(s, i, word) char s[], word[]; {
    int i, j;
    j = 0;
    while (word[j]) {
        if (s[i++] != word[j++]) return(0);
    }
    return(!selchr(s[i]));
}

selref(s, which) char s[]; {
    extern seltail, selpart;
    int seltail, selpart, i, prev, which;
    /* A split line is ambiguous; retaining the library is always safe. */
    if (seltail | selpart) return(1);
    i = 0; prev = 0;
    while (s[i]) {
        if (s[i] == '_') if (!selchr(prev)) {
            if (which == 2) {
                if (selstr(s, i, "_fork")) return(1);
                if (selstr(s, i, "_wait")) return(1);
                if (selstr(s, i, "_chdir")) return(1);
                if (selstr(s, i, "_link")) return(1);
                if (selstr(s, i, "_chmod")) return(1);
                if (selstr(s, i, "_chown")) return(1);
                if (selstr(s, i, "_stat")) return(1);
                if (selstr(s, i, "_fstat")) return(1);
                if (selstr(s, i, "_stty")) return(1);
                if (selstr(s, i, "_gtty")) return(1);
                if (selstr(s, i, "_setuid")) return(1);
                if (selstr(s, i, "_getuid")) return(1);
                if (selstr(s, i, "_time")) return(1);
                if (selstr(s, i, "_mkdir")) return(1);
                if (selstr(s, i, "_makdir")) return(1);
            } else if (which == 1) {
                if (selstr(s, i, "_execv")) return(1);
                if (selstr(s, i, "_execl")) return(1);
            } else {
                if (selstr(s, i, "_printn")) return(1);
                if (selstr(s, i, "_printf")) return(1);
                if (selstr(s, i, "_getstr")) return(1);
                if (selstr(s, i, "_ctime")) return(1);
            }
        }
        prev = s[i++];
    }
    return(0);
}

selfns(path) char path[]; {
    extern sellin, selnam, selnum, uselib, usexec, usemet;
    char sellin[], selnam[], name[10];
    int selnum, uselib, usexec, usemet, fd, j;
    selnum = 0; uselib = 0; usexec = 0; usemet = 0;
    fd = open(path, 0);
    if (fd < 0) failmsg("b: no program assembly\n");
    selclr();
    while (selget(fd)) {
        if (selref(sellin, 0)) uselib = 1;
        if (selref(sellin, 1)) usexec = 1;
        if (selref(sellin, 2)) usemet = 1;
        if (sellab(sellin, name)) {
            if (selnum >= 200) failmsg("b: too many external definitions\n");
            j = 0;
            while (name[j]) { selnam[selnum*10+j] = name[j]; j++; }
            selnam[selnum*10+j] = 0;
            selnum++;
        }
    }
    close(fd);
}

/* Library calls can need exec even when the program does not name it. */
seldep(path) char path[]; {
    extern sellin, usexec, usemet;
    char sellin[];
    int usexec, usemet, fd;
    fd = open(path, 0);
    if (fd < 0) failmsg("b: missing runtime assembly\n");
    selclr();
    while (selget(fd)) {
        if (selref(sellin, 1)) usexec = 1;
        if (selref(sellin, 2)) usemet = 1;
    }
    close(fd);
}

selmark(s, name) char s[], name[]; {
    int i;
    i = 0;
    while (name[i]) { if (s[i] != name[i]) return(0); i++; }
    while (s[i] == ' ' | s[i] == '\t' | s[i] == '\r' | s[i] == '\n') i++;
    return(s[i] == 0);
}

selgrp(s) char s[]; {
    extern seltail, selpart;
    int seltail, selpart;
    if (seltail | selpart) return(0);
    if (selmark(s, "/ bcc-exec-begin")) return(1);
    if (selmark(s, "/ bcc-exec-end")) return(-1);
    if (selmark(s, "/ bcc-meta-begin")) return(2);
    if (selmark(s, "/ bcc-meta-end")) return(-2);
    return(0);
}

selhas() {
    extern sellin, selnam, selnum;
    char sellin[], selnam[], name[10];
    int selnum, i, j;
    if (!sellab(sellin, name)) return(0);
    i = 0;
    while (i < selnum) {
        j = 0;
        while (name[j] == selnam[i*10+j]) {
            if (name[j] == 0) return(1);
            j++;
        }
        i++;
    }
    return(0);
}

/* Return zero when the original file can be used without making a copy. */
selfil(path, dest, omit) char path[], dest[]; {
    extern sellin;
    char sellin[];
    int fd, out, n, found, omit, group, kind, drop;
    fd = open(path, 0);
    if (fd < 0) failmsg("b: missing runtime assembly\n");
    found = omit;
    selclr();
    if (!found) while (selget(fd)) if (selhas()) { found = 1; break; }
    if (!found) { close(fd); return(0); }
    if (seek(fd, 0, 0) < 0) failmsg("b: cannot rewind runtime\n");
    out = creat(dest, 016);
    if (out < 0) failmsg("b: cannot create selected runtime\n");
    selclr(); group = 0;
    while (n = selget(fd)) {
        if (omit) {
            kind = selgrp(sellin);
            if (kind > 0) {
                if (group) { unlink(dest); badout("b: nested runtime group\n"); }
                group = kind;
                drop = omit & kind;
                if (drop) continue;
            }
            if (kind < 0) {
                if (group != -kind) { unlink(dest); badout("b: unmatched runtime group end\n"); }
                group = 0;
                drop = omit & -kind;
                if (drop) continue;
            }
        }
        /* Early C treats & in branch conditions as logical conjunction. */
        drop = omit & group;
        if (!drop) if (!selhas()) if (write(out, sellin, n) != n) {
            close(fd); close(out); unlink(dest);
            failmsg("b: runtime write failed\n");
        }
    }
    if (group) { unlink(dest); badout("b: unterminated runtime group\n"); }
    close(fd);
    if (close(out)) { unlink(dest); badout("b: runtime close failed\n"); }
    return(1);
}
