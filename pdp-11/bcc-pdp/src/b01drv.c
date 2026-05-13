/* b01drv.c -- resolver between b00 raw IC and b1.
 *
 * Classifies declarations into the symbol table, rewrites name and label
 * references, and passes ordinary IC records through.
 */

dbuf[300];
dtag[10];
dnm[10];
pndcls 0;

fnsy[5];
nlocs 0;
hdrdn 1;
nvini 0;
vinis[16];
infun 0;

usage() {
	outinit(2);
	outs("usage: b01 [-i raw.ic] [-o resolved.ic]\n");
	exit(1);
}

main(argc, argv) int argv[]; {
	extern nlab;
	int nlab;
	int i, ifd, ofd, in, out;
	char p[];

	nlab = 30000;

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
		if (ifd < 0) { outinit(2); outs("b01: open\n"); exit(1); }
	} else {
		ifd = 0;
	}
	if (out) {
		ofd = creat(out, 016);
		if (ofd < 0) { outinit(2); outs("b01: creat\n"); exit(1); }
	} else {
		ofd = 1;
	}

	icini(ifd);
	outinit(ofd);
	rewrt();
	exit(0);
}

cp9(dst, src) char dst[]; char src[]; {
	int i;
	i = 0;
	while (i < 9) {
		dst[i] = src[i];
		i = i + 1;
	}
}

echoln(buf) char buf[]; {
	int i;
	i = 0;
	while (buf[i]) {
		outc(buf[i]);
		i = i + 1;
	}
	outc('\n');
}

emitpr() {
	extern fnsy, nlocs, nvini, vinis, hdrdn, infun;
	char fnsy[];
	int nlocs, nvini, hdrdn, infun;
	int vinis[];
	int retl, i;
	if (!infun) return;
	if (hdrdn) return;
	retl = newl();
	outs("pr ");
	outs(fnsy); outc(' ');
	outd(nlocs); outc(' ');
	outd(retl); outc('\n');
	i = 0;
	while (i < nvini) {
		outs("vi ");
		outd(vinis[2 * i]); outc(' ');
		outd(vinis[2 * i + 1]); outc('\n');
		i = i + 1;
	}
	hdrdn = 1;
}

regsym(name, cls, off) char name[]; {
	extern scls, soff;
	int scls[], soff[];
	int sid;
	sid = symfnd(name);
	if (sid < 0) return (symadd(name, cls, off));
	scls[sid] = cls;
	soff[sid] = off;
	return (sid);
}

rrname(name) char name[]; {
	extern scls, soff, pndcls;
	int scls[], soff[], pndcls;
	int sid;
	sid = symfnd(name);
	if (sid < 0) sid = symadd(name, 3, 0);
	pndcls = scls[sid];
	if (pndcls == 5) {
		outs("la "); outd(soff[sid]); outc('\n');
		return;
	}
	if (pndcls == 6) {
		outs("lc "); outd(soff[sid]); outc('\n');
		outs("dr\n");
		return;
	}
	if (pndcls == 1) {
		outs("lc "); outd(soff[sid]); outc('\n');
		return;
	}
	if (pndcls == 2) {
		outs("ar "); outd(soff[sid]); outc('\n');
		return;
	}
	outs("ex "); outs(name); outc('\n');
}

rrderef() {
	extern pndcls;
	int pndcls;
	if (pndcls == 5) return;
	if (pndcls == 6) return;
	if (pndcls == 7) return;
	outs("dr\n");
}

rrlbl(name) char name[]; {
	extern scls, soff;
	int scls[], soff[];
	int sid;
	sid = symfnd(name);
	if (sid < 0) sid = symadd(name, 5, newl());
	if (scls[sid] != 5) {
		rrname(name);
		rrderef();
		outs("gor\n");
		return;
	}
	outs("jm ");
	outd(soff[sid]);
	outc('\n');
}

rrdef(name) char name[]; {
	extern scls, soff;
	int scls[], soff[];
	int sid;
	sid = symfnd(name);
	if (sid < 0) sid = symadd(name, 5, newl());
	if (scls[sid] != 5) fatal("label name collision");
	outs("lb ");
	outd(soff[sid]);
	outc('\n');
}

rewrt() {
	extern dbuf, dtag, dnm, fnsy, nlocs, nvini, vinis, hdrdn, pndcls;
	extern infun, fnst, nsy, scls, soff;
	char dbuf[], dtag[], dnm[], fnsy[];
	int nlocs, nvini, hdrdn, pndcls, infun, fnst, nsy;
	int vinis[], scls[], soff[];
	int idx, sz, base, sid;

	while (1) {
		if (!getln(dbuf, 300)) return;
		icrst();
		nxtnam(dbuf, dtag);

		if (tageq(dtag, "Adef")) {
			nxtnam(dbuf, dnm);
			cp9(fnsy, dnm);
			regsym(dnm, 4, 0);
			fnst = nsy;
			nlocs = 0;
			nvini = 0;
			hdrdn = 0;
			infun = 1;
			pndcls = 0;
			continue;
		}
		if (tageq(dtag, "Aauto")) {
			nxtnam(dbuf, dnm);
			symadd(dnm, 1, nlocs);
			nlocs = nlocs + 1;
			continue;
		}
		if (tageq(dtag, "Avec")) {
			nxtnam(dbuf, dnm);
			sz = nxti(dbuf);
			sid = symfnd(dnm);
			if (sid < 0) fatal("Avec without Aauto");
			scls[sid] = 6;
			base = soff[sid];
			if (nvini >= 8) fatal("too many vector autos");
			vinis[2 * nvini] = base;
			vinis[2 * nvini + 1] = base + sz - 1;
			nvini = nvini + 1;
			nlocs = base + sz;
			continue;
		}
		if (tageq(dtag, "Aarg")) {
			nxtnam(dbuf, dnm);
			idx = nxti(dbuf);
			symadd(dnm, 2, idx);
			continue;
		}
		if (tageq(dtag, "Aextrn")) {
			nxtnam(dbuf, dnm);
			regsym(dnm, 3, 0);
			continue;
		}
		if (tageq(dtag, "Agvec")) {
			nxtnam(dbuf, dnm);
			regsym(dnm, 7, 0);
			continue;
		}
		if (tageq(dtag, "Aend")) {
			emitpr();
			outs("ep\n");
			symtrn();
			hdrdn = 1;
			infun = 0;
			pndcls = 0;
			continue;
		}

		if (infun) emitpr();

		if (tageq(dtag, "Rname")) {
			nxtnam(dbuf, dnm);
			rrname(dnm);
			continue;
		}
		if (tageq(dtag, "Rderef")) {
			rrderef();
			pndcls = 0;
			continue;
		}
		if (tageq(dtag, "Rlbl")) {
			nxtnam(dbuf, dnm);
			rrlbl(dnm);
			pndcls = 0;
			continue;
		}
		if (tageq(dtag, "Rdef")) {
			nxtnam(dbuf, dnm);
			rrdef(dnm);
			pndcls = 0;
			continue;
		}
		if (tageq(dtag, "gvb")) {
			nxtnam(dbuf, dnm);
			idx = nxti(dbuf);
			if (symfnd(dnm) < 0) symadd(dnm, 3, 0);
			outs("gvb ");
			outs(dnm); outc(' ');
			outd(idx); outc('\n');
			pndcls = 0;
			continue;
		}

		pndcls = 0;
		echoln(dbuf);
	}
}
