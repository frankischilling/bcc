/* b1drv.c -- b1 driver: reads IC records, dispatches to cg primitives.
 *
 *   b1 [-i IC] [-o OUT.s]
 *
 * Default IC = stdin, OUT = stdout.  Reads records line by line via
 * blex1; each line begins with a tag (n, ps, bin, binc, cl, pr, ...)
 * followed by space-separated decimal args (or a name for cl/pr/ex).
 * After EOF, emitl() writes the .data section.
 */

dbuf[300];
dtag[10];
dnm[10];
dsb[260];
dsk[64];

usage() {
	outinit(2);
	outs("usage: b1 [-i IC] [-o OUT.s]\n");
	exit(1);
}

main(argc, argv) int argv[]; {
	int i, ifd, ofd, in, out;
	char p[];

	i = 1;
	in = 0;
	out = 0;
	while (i < argc) {
		p = argv[i];
		if (p[0] == '-') if (p[1] == 'i') if (p[2] == 0) goto isi;
		if (p[0] == '-') if (p[1] == 'o') if (p[2] == 0) goto iso;
		usage();
	isi:
		i = i + 1;
		if (i >= argc) usage();
		in = argv[i];
		goto nxt;
	iso:
		i = i + 1;
		if (i >= argc) usage();
		out = argv[i];
	nxt:
		i = i + 1;
	}

	if (in) {
		ifd = open(in, 0);
		if (ifd < 0) { outinit(2); outs("b1: open ic\n"); exit(1); }
	} else {
		ifd = 0;
	}
	if (out) {
		ofd = creat(out, 016);   /* V1 mode: ownr+ownw+wrldr (host 0644) */
		if (ofd < 0) { outinit(2); outs("b1: creat out\n"); exit(1); }
	} else {
		ofd = 1;
	}

	icini(ifd);
	outinit(ofd);
	dispat();
	emitl();
	exit(0);
}

disp1() {
	extern dbuf, dtag, dnm, dsb, dsk;
	char dbuf[], dtag[], dnm[], dsb[];
	int dsk[];
	int a, b, c;
	if (tageq(dtag, "n"))   { a = nxti(dbuf); cgnst(a); return (1); }
	if (tageq(dtag, "ps"))  { cgpsh(); return (1); }
	if (tageq(dtag, "bin")) { a = nxti(dbuf); cgbin(a); return (1); }
	if (tageq(dtag, "binc")){ a = nxti(dbuf); b = nxti(dbuf); c = nxti(dbuf); cgbinc(a, b, c); return (1); }
	if (tageq(dtag, "cl"))  { nxtnam(dbuf, dnm); a = nxti(dbuf); cgcll(dnm, a); return (1); }
	if (tageq(dtag, "pr"))  { nxtnam(dbuf, dnm); a = nxti(dbuf); b = nxti(dbuf); cgpro(dnm, a, b); return (1); }
	if (tageq(dtag, "ep"))  { cgepi(); return (1); }
	if (tageq(dtag, "rt"))  { cgret(); return (1); }
	if (tageq(dtag, "lc"))  { a = nxti(dbuf); cglca(a); return (1); }
	if (tageq(dtag, "ar"))  { a = nxti(dbuf); cgara(a); return (1); }
	if (tageq(dtag, "dr"))  { cgdrf(); return (1); }
	if (tageq(dtag, "as"))  { cgasn(); return (1); }
	if (tageq(dtag, "bf"))  { a = nxti(dbuf); cgbrf(a); return (1); }
	if (tageq(dtag, "jm"))  { a = nxti(dbuf); cgjmp(a); return (1); }
	if (tageq(dtag, "lb"))  { a = nxti(dbuf); cglab(a); return (1); }
	if (tageq(dtag, "ex"))  { nxtnam(dbuf, dnm); cgext(dnm); return (1); }
	return (0);
}

disp2() {
	extern dbuf, dtag, dnm;
	char dbuf[], dtag[], dnm[];
	int a, b, c;
	if (tageq(dtag, "st"))  { a = nxti(dbuf); cgsta(a); return (1); }
	if (tageq(dtag, "uo"))  { a = nxti(dbuf); cguop(a); return (1); }
	if (tageq(dtag, "uon")) { a = nxti(dbuf); b = nxti(dbuf); cguopn(a, b); return (1); }
	if (tageq(dtag, "ao"))  { a = nxti(dbuf); b = nxti(dbuf); cgaob(a, b); return (1); }
	if (tageq(dtag, "aoe")) { a = nxti(dbuf); cgaoe(a); return (1); }
	if (tageq(dtag, "tq"))  { a = nxti(dbuf); cgtnq(a); return (1); }
	if (tageq(dtag, "tc"))  { a = nxti(dbuf); b = nxti(dbuf); cgtnc(a, b); return (1); }
	if (tageq(dtag, "te"))  { a = nxti(dbuf); cgtne(a); return (1); }
	if (tageq(dtag, "ix"))  { cgidx(); return (1); }
	if (tageq(dtag, "ca"))  { a = nxti(dbuf); cgcae(a); return (1); }
	if (tageq(dtag, "cac")) { a = nxti(dbuf); b = nxti(dbuf); c = nxti(dbuf); cgcaec(a, b, c); return (1); }
	if (tageq(dtag, "po"))  { a = nxti(dbuf); cgpoi(a); return (1); }
	if (tageq(dtag, "pi"))  { a = nxti(dbuf); cgpri(a); return (1); }
	if (tageq(dtag, "vi"))  { a = nxti(dbuf); b = nxti(dbuf); cgvini(a, b); return (1); }
	if (tageq(dtag, "gw"))  { nxtnam(dbuf, dnm); a = nxti(dbuf); cggwd(dnm, a); return (1); }
	return (0);
}

disp3() {
	extern dbuf, dtag, dnm, dsb, dsk;
	char dbuf[], dtag[], dnm[], dsb[];
	int dsk[];
	int a, b, ld, lp, le, nc, ii, sid, slen, j;
	if (tageq(dtag, "ga")) {
		nxtnam(dbuf, dnm);
		a = nxti(dbuf);
		b = nxti(dbuf);
		cggab(dnm, a, b, dbuf);
		return (1);
	}
	if (tageq(dtag, "swb")) { a = nxti(dbuf); cgswb(a); return (1); }
	if (tageq(dtag, "swe")) {
		ld = nxti(dbuf);
		lp = nxti(dbuf);
		le = nxti(dbuf);
		nc = nxti(dbuf);
		ii = 0;
		while (ii < nc) {
			dsk[2 * ii]     = nxti(dbuf);
			dsk[2 * ii + 1] = nxti(dbuf);
			ii = ii + 1;
		}
		cgswe(ld, lp, le, nc, dsk);
		return (1);
	}
	if (tageq(dtag, "gor")) { cggor(); return (1); }
	if (tageq(dtag, "la"))  { a = nxti(dbuf); cgla(a); return (1); }
	if (tageq(dtag, "gvb")) { nxtnam(dbuf, dnm); a = nxti(dbuf); cggvb(dnm, a); return (1); }
	if (tageq(dtag, "gvc")) { a = nxti(dbuf); cggvc(a); return (1); }
	if (tageq(dtag, "gvn")) { nxtnam(dbuf, dnm); cggvn(dnm); return (1); }
	if (tageq(dtag, "gve")) { cggve(); return (1); }
	if (tageq(dtag, "Slit")) {
		slen = nxti(dbuf);
		j = 0;
		while (j < slen) {
			dsb[j] = nxti(dbuf);
			j = j + 1;
		}
		sid = litinl(slen, dsb);
		cgsta(sid);
		return (1);
	}
	return (0);
}

/* Read one IC line, dispatch to the matching cg primitive. */
dispat() {
	extern dbuf, dtag;
	char dbuf[], dtag[];
	while (1) {
		if (!getln(dbuf, 300)) return;
		icrst();
		nxtnam(dbuf, dtag);
		if (disp1()) continue;
		if (disp2()) continue;
		if (disp3()) continue;
		outinit(2);
		outs("b1: bad tag '");
		outs(dtag);
		outs("'\n");
		exit(1);
	}
}
