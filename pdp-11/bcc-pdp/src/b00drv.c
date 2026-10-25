/* b00drv.c -- lex/parse driver: argv handling + file IO.
 *
 * Usage:  b00 [-x] [-o out.ic] in.b
 * Reads in.b, writes IC (intermediate code) records to out.ic (or stdout).
 * IC is line-oriented text; b1 reads it back and emits V1 as.
 *
 * V1 cc dialect: no #include, no FILE*, no void.  argv is int[] of
 * pointers; we re-deref via `char p[]; p = argv[i]`.
 */

usage() {
	errinit();                              /* stderr */
	outs("usage: b00 [-x] [-o out.ic] in.b\n");
	exit(1);
}

main(argc, argv) int argv[]; {
	extern extflg;
	int extflg;
	int i, fdin, fdout, in, out, done;
	char p[];

	i = 1;
	in = 0;
	out = 0;
	done = 0;
	while (i < argc) {
		p = argv[i];
		if (p[0] == '-') if (p[1] == 's') if (p[2] == 0) goto isdone;
		if (p[0] == '-') if (p[1] == 'x') if (p[2] == 0) goto isext;
		if (p[0] == '-') if (p[1] == 'o') if (p[2] == 0) goto isopt;
		goto noopt;
	isext:
		extflg = 1;
		goto next;
	isopt:
		i = i + 1;
		if (i >= argc) usage();
		out = argv[i];
		goto next;
	noopt:
		if (p[0] != '-') {
			if (in) usage();
			in = argv[i];
		} else {
			usage();
		}
		goto next;
	isdone:
		i = i + 1;
		if (i >= argc) usage();
		done = argv[i];
	next:
		i = i + 1;
	}
	if (!in) usage();

	fdin = open(in, 0);
	if (fdin < 0) {
		errinit();
		outs("b00: cannot open input\n");
		exit(1);
	}
	if (out) fdout = creat(out, 016);     /* V1 mode: ownr+ownw+wrldr (host 0644) */
	else     fdout = 1;
	if (fdout < 0) {
		errinit();
		outs("b00: cannot create output\n");
		exit(1);
	}

	stkini();
	lexini(fdin);
	outinit(fdout);
	if (extflg) outs("Acompat\n");

	gettok();
	prog();
	if (fdout != 1) if (close(fdout)) exit(1);
	if (done) markok(done);
	exit(0);
}
