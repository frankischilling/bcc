/* butil.c -- output buffer + error reporting.
 * Written in V1 C dialect (last1120c): no #include, no void, no _ in names,
 * no for/||/+=/struct, K&R only, B-style globals.
 */

lineno 1;
outfd 1;
outdiag 0;
extflg 0;       /* b00: nonzero enables post-1972 compatibility extensions */

outinit(fd) {
	extern outfd, outdiag;
	outfd = fd;
	outdiag = 0;
}

outc(c) {
	extern outfd, outdiag;
    int outdiag;
	char b[2];
	b[0] = c;
    if (write(outfd, b, 1) != 1) {
        if (outdiag) {
            if (write(1, b, 1) == 1) return;
        }
        exit(1);
    }
}

outs(s) char s[]; {
	int i;
	i = 0;
	while (s[i]) {
		outc(s[i]);
		i = i + 1;
	}
}

outd(n) {
	char buf[8];
	int i;
	if (n == 0) { outc('0'); return; }
	if (n == 0100000) { outs("-32768"); return; }
	if (n < 0) { outc('-'); n = -n; }
	i = 0;
	while (n) {
		buf[i] = '0' + (n % 10);
		i = i + 1;
		n = n / 10;
	}
	while (i) {
		i = i - 1;
		outc(buf[i]);
	}
}

outln() { outc('\n'); }

fatal(s) char s[]; {
	extern lineno, outfd;
	int outfd;
	errinit();
	outc('\n');
	outs("bcc: line ");
	outd(lineno);
	outs(": ");
	outs(s);
	outc('\n');
	exit(1);
}

fatalst(s, a) char s[]; char a[]; {
	extern lineno, outfd;
	int outfd;
	errinit();
	outc('\n');
	outs("bcc: line ");
	outd(lineno);
	outs(": ");
	outs(s);
	outs(" ");
	outs(a);
	outc('\n');
	exit(1);
}

nlab 0;

newl() {
	extern nlab;
	int nlab;
	int id;
	id = nlab;
	nlab = nlab + 1;
	return (id);
}

errinit() {
    extern outfd, outdiag;
    outfd = 2;
    outdiag = 1;
}

/* Explicit completion works even when V1 wait has no child status. */
markok(path) char path[]; {
    int fd;
    fd = creat(path, 016);
    if (fd < 0) exit(1);
    if (write(fd, "ok", 2) != 2) exit(1);
    close(fd);
}
