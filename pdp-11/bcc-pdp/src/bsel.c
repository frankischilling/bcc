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

selfns(path) char path[]; {
    extern sellin, selnam, selnum;
    char sellin[], selnam[], name[10];
    int selnum, fd, j;
    selnum = 0;
    fd = open(path, 0);
    if (fd < 0) failmsg("b: no program assembly\n");
    selclr();
    while (selget(fd)) {
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
selfil(path, dest) char path[], dest[]; {
    extern sellin;
    char sellin[];
    int fd, out, n, found;
    fd = open(path, 0);
    if (fd < 0) failmsg("b: missing runtime assembly\n");
    found = 0;
    selclr();
    while (selget(fd)) if (selhas()) { found = 1; break; }
    if (!found) { close(fd); return(0); }
    if (seek(fd, 0, 0) < 0) failmsg("b: cannot rewind runtime\n");
    out = creat(dest, 016);
    if (out < 0) failmsg("b: cannot create selected runtime\n");
    selclr();
    while (n = selget(fd)) {
        if (!selhas()) if (write(out, sellin, n) != n) {
            close(fd); close(out); unlink(dest);
            failmsg("b: runtime write failed\n");
        }
    }
    close(fd); close(out);
    return(1);
}
