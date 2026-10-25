/* bdrv.c -- /bin/b: compiler driver inside V1 Unix.
 *
 * Usage:  b [-x] [-v] src.b
 *
 * Chains:   b00 -o /usr/tmp/b.r1 src.b
 *           b01 -i /usr/tmp/b.r1 -o /usr/tmp/b.r2
 *           b1  -i /usr/tmp/b.r2 -o /usr/tmp/b.s
 *           as /usr/lib/bmain.s /usr/lib/brt.s /usr/lib/libb.s /usr/tmp/b.s
 * Selects library labels after b1 so program definitions take precedence.
 * Leaves a.out in the current directory.
 *
 * Written in V1 last1120c dialect (same as the bcc-pdp sources):
 * no `char *` declarators, no `**`, no preprocessor, no `for`, etc.
 * Helper sa() lets us store a string-literal address into an int slot
 * (V1 cc rejects the direct assignment but accepts it through a fn arg).
 */

verbose 0;
aslog 0;
b0arg[8];
b1arg[8];
asarg[8];

/* set int-slot to value, where value is a char[] (i.e. pointer).
 * V1 cc treats arr[i] = char[]-typed-arg as int = int, which works. */
sa(arr, i, val) int arr[]; char val[]; {
	arr[i] = val;
}

main(argc, argv) int argv[]; {
	extern b0arg, b1arg, asarg, verbose, aslog, uselib;
	int b0arg[], b1arg[], asarg[];
	char src[];
	int i, ext, verbose, aslog, uselib;
	if (argc < 2) {
		puterr("usage: b [-x] [-v] src.b\n", 25);
		exit(1);
	}
	i = 1;
	ext = 0;
	src = argv[i];
    while (src[0] == '-') {
        if (src[2] != 0) exit(1);
        if (src[1] == 'x') ext = 1;
        else if (src[1] == 'v') verbose = 1;
        else exit(1);
        i = i + 1;
        if (i >= argc) exit(1);
        src = argv[i];
    }
    if (i + 1 != argc) exit(1);

	/* V1 exec copies strings backward in place. Keep the stack-owned
	 * source filename last so later strings cannot overwrite it. */
	sa(b0arg, 0, "b00");
	if (ext) {
		sa(b0arg, 1, "-x");
		sa(b0arg, 2, "-o");
		sa(b0arg, 3, "/usr/tmp/b.r1");
		sa(b0arg, 4, "-s");
		sa(b0arg, 5, "/usr/tmp/b.ok");
		sa(b0arg, 6, src);
		b0arg[7] = 0;
	} else {
		sa(b0arg, 1, "-o");
		sa(b0arg, 2, "/usr/tmp/b.r1");
		sa(b0arg, 3, "-s");
		sa(b0arg, 4, "/usr/tmp/b.ok");
		sa(b0arg, 5, src);
		b0arg[6] = 0;
	}
	runp("/usr/lib/bcc/b00", b0arg);

	sa(b1arg, 0, "b01");
	sa(b1arg, 1, "-i");
	sa(b1arg, 2, "/usr/tmp/b.r1");
	sa(b1arg, 3, "-o");
	sa(b1arg, 4, "/usr/tmp/b.r2");
	sa(b1arg, 5, "-s");
	sa(b1arg, 6, "/usr/tmp/b.ok");
	b1arg[7] = 0;
	runp("/usr/lib/bcc/b01", b1arg);

	sa(b1arg, 0, "b1");
	sa(b1arg, 1, "-i");
	sa(b1arg, 2, "/usr/tmp/b.r2");
	sa(b1arg, 3, "-o");
	sa(b1arg, 4, "/usr/tmp/b.s");
	sa(b1arg, 5, "-s");
	sa(b1arg, 6, "/usr/tmp/b.ok");
	b1arg[7] = 0;
	runp("/usr/lib/bcc/b1", b1arg);

    unlink("/usr/tmp/b.br");
    unlink("/usr/tmp/b.lb");
    selfns("/usr/tmp/b.s");
	sa(asarg, 0, "as");
	sa(asarg, 1, "/usr/lib/bmain.s");
	sa(asarg, 2, "/usr/lib/brt.s");
	sa(asarg, 3, "/usr/lib/libb.s");
    if (selfil("/usr/lib/brt.s", "/usr/tmp/b.br")) sa(asarg, 2, "/usr/tmp/b.br");
    if (uselib) {
        if (selfil("/usr/lib/libb.s", "/usr/tmp/b.lb")) sa(asarg, 3, "/usr/tmp/b.lb");
        sa(asarg, 4, "/usr/tmp/b.s");
        asarg[5] = 0;
    } else {
        sa(asarg, 3, "/usr/tmp/b.s");
        asarg[4] = 0;
    }
	aslog = 1;
    unlink("a.out");
	unlink("/usr/tmp/b.aslog");
	run("/bin/as", asarg);
	checkas();

	/* /bin/as is the V2 assembler emitting 0407 a.out; V1 kernel exec
	 * needs 0405.  Rewrite the header in place. */
	note("converting header");
	fixout("a.out");
	note("header converted");

	/* V1 as leaves a.out without the exec bit set. */
	if (chmod("a.out", 036) < 0) exit(1);   /* exec+ownr+ownw+wrldr */

	unlink("/usr/tmp/b.r1");
	unlink("/usr/tmp/b.r2");
	unlink("/usr/tmp/b.s");
    unlink("/usr/tmp/b.br");
    unlink("/usr/tmp/b.lb");
	exit(0);
}

/* Emit a stripped V1 executable. V2 symbol/relocation records are not V1
 * records; they must not be copied or reported as zero-fill data. */
fixout(name) char name[]; {
	int fdin, fdout, hdr[8], nhdr[6], n, left;
	char buf[512];
	fdin = open(name, 0);
	if (fdin < 0) badout("b: no assembler output\n");
	n = read(fdin, hdr, 16);
	if (n != 16) badout("b: truncated assembler output\n");
    if (hdr[0] != 0407) badout("b: bad assembler output\n");
    if (hdr[1] < 0) badout("b: program exceeds 16 KB\n");
    if (hdr[1] > 16372) badout("b: program exceeds 16 KB\n");
    n = hdr[1] & 1;
    if (n != 0) badout("b: odd text size\n");
    if (hdr[2] != 0) badout("b: unsupported data segment\n");
    if (hdr[3] != 0) badout("b: unsupported bss segment\n");
	nhdr[0] = 0405;
	nhdr[1] = 12 + hdr[1];
	nhdr[2] = 0;
	nhdr[3] = 0;
	nhdr[4] = 0;
	nhdr[5] = 0;
	fdout = creat(".b.aout", 036);
	if (fdout < 0) badout("b: cannot create converted output\n");
	if (write(fdout, nhdr, 12) != 12) badout("b: header write failed\n");
    left = hdr[1];
    while (left > 0) {
        n = left;
        if (n > 512) n = 512;
        n = read(fdin, buf, n);
        if (n <= 0) badout("b: truncated program text\n");
        if (write(fdout, buf, n) != n) badout("b: output write failed\n");
        left = left - n;
    }
	close(fdin);
	if (close(fdout)) badout("b: output close failed\n");
	if (unlink(name) < 0) badout("b: cannot replace output\n");
	if (link(".b.aout", name) < 0) badout("b: cannot install output\n");
	unlink(".b.aout");
}

badout(s) char s[]; {
    unlink("a.out");
    unlink(".b.aout");
    failmsg(s);
}

run(prog, args) char prog[]; int args[]; {
    extern aslog;
    int p, child, status, aslog;
    note(prog);
    p = fork();
    if (p < 0) {
        puterr("b: fork failed\n", 15);
        exit(1);
    }
    if (p == 0) {
        if (aslog) {
            close(1);
            if (creat("/usr/tmp/b.aslog", 016) != 1) exit(1);
        }
        execv(prog, args);
        puterr("b: exec failed\n", 15);
        exit(1);
    }
    /* The C wrapper accepts wait(&status); V1 kernels may return no status. */
    child = wait(&status);
    while (child != p) {
        if (child < 0) {
            puterr("b: wait failed\n", 15);
            exit(1);
        }
        child = wait(&status);
    }
    if (status != 0) {
        if (aslog) unlink("a.out");
        exit(1);
    }
}

note(s) char s[]; {
    extern verbose;
    int verbose, n;
    if (!verbose) return;
    n = 0;
    while (s[n]) n = n + 1;
    puterr("b: ", 3);
    puterr(s, n);
    puterr("\n", 1);
}

/* Early shells may leave descriptor 2 closed. */
puterr(s, n) char s[]; {
    if (write(2, s, n) < 0) write(1, s, n);
}

runp(prog, args) char prog[]; int args[]; {
    int fd, n;
    char mark[4];
    unlink("/usr/tmp/b.ok");
    run(prog, args);
    fd = open("/usr/tmp/b.ok", 0);
    if (fd < 0) {
        puterr("b: pass failed\n", 15);
        exit(1);
    }
    n = read(fd, mark, 3);
    close(fd);
    unlink("/usr/tmp/b.ok");
    if (n != 2) exit(1);
    if (mark[0] != 'o') exit(1);
    if (mark[1] != 'k') exit(1);
}

/* The pinned assembler prints exactly I and II on a successful assembly. */
checkas() {
    int fd, n, ok;
    char text[512];
    fd = open("/usr/tmp/b.aslog", 0);
    if (fd < 0) badout("b: no assembler log\n");
    n = read(fd, text, 6);
    ok = n == 5;
    if (ok) {
        if (text[0] != 'I') ok = 0;
        if (text[1] != '\n') ok = 0;
        if (text[2] != 'I') ok = 0;
        if (text[3] != 'I') ok = 0;
        if (text[4] != '\n') ok = 0;
    }
    seek(fd, 0, 0);
    n = read(fd, text, 512);
    while (n > 0) {
        write(1, text, n);
        n = read(fd, text, 512);
    }
    close(fd);
    unlink("/usr/tmp/b.aslog");
    if (!ok) badout("b: assembler failed\n");
}

failmsg(s) char s[]; {
    int n;
    n = 0;
    while (s[n]) n = n + 1;
    puterr(s, n);
    exit(1);
}
