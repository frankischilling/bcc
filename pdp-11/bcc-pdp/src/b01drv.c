/* b01drv.c -- resolver between b00 raw IC and b1.
 *
 * Classifies declarations into the symbol table, rewrites name and label
 * references, and passes ordinary IC records through.
 */

dbuf[520]; /* 1040 bytes: enough for 256 decimal literal bytes. */
dtag[5];
dnm[5];
pndcls 0;

fnsy[5];
nlocs 0;
hdrdn 1;
infun 0;

/* Delay only the short initializer records, not their literal bytes. */
ghbuf[1024];
ghlen 0;
ghon 0;
glits 0;

ghchar(c) {
	extern ghbuf, ghlen;
	char ghbuf[];
	int ghlen;
	if (ghlen >= 2047) fatal("global records too large");
	ghbuf[ghlen++] = c;
	ghbuf[ghlen] = 0;
}

ghtext(s) char s[]; {
	int i;
	i = 0;
	while (s[i]) ghchar(s[i++]);
}

ghnum(n) {
	if (n >= 10) ghnum(n / 10);
	ghchar(n % 10 + '0');
}

usage() {
	errinit();
	outs("usage: b01 [-i raw.ic] [-o resolved.ic]\n");
	exit(1);
}

main(argc, argv) int argv[]; {
	extern nlab;
	int nlab;
	int i, ifd, ofd, in, out, done;
	char p[];

	nlab = 30000;

	i = 1;
	in = 0;
	out = 0;
	done = 0;
	while (i < argc) {
		p = argv[i];
		if (p[0] == '-') if (p[1] == 's') if (p[2] == 0) goto isdone;
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
		goto nxt;
		goto nxt;
	isdone:
		i = i + 1;
		if (i >= argc) usage();
		done = argv[i];
	nxt:
		i = i + 1;
	}

	if (in) {
		ifd = open(in, 0);
		if (ifd < 0) { errinit(); outs("b01: open\n"); exit(1); }
	} else {
		ifd = 0;
	}
	if (out) {
		ofd = creat(out, 016);
		if (ofd < 0) { errinit(); outs("b01: creat\n"); exit(1); }
	} else {
		ofd = 1;
	}

	icini(ifd);
	outinit(ofd);
	rewrt();
	if (ofd != 1) close(ofd);
	if (done) markok(done);
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
    extern fnsy, nlocs, hdrdn, infun;
    char fnsy[];
    int nlocs, hdrdn, infun;
    int retl;
    if (!infun) return;
    if (hdrdn) return;
    retl = newl();
    outs("pr "); outs(fnsy); outc(' ');
    outd(nlocs); outc(' '); outd(retl); outc('\n');
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

regext(name) char name[]; {
	extern scls;
	int scls[];
	int sid, cls;
	sid = symfnd(name);
	if (sid < 0) return (symadd(name, 3, 0));
	cls = scls[sid];
	if (cls == 4) return (sid);
	if (cls == 7) return (sid);
	scls[sid] = 3;
	return (sid);
}

rrname(name) char name[]; {
	extern scls, soff, pndcls;
	int scls[], soff[], pndcls;
	int sid;
	sid = symfnd(name);
	/* An undeclared internal name denotes a function-local label. */
	if (sid < 0) sid = symadd(name, 5, newl());
	pndcls = scls[sid];
	if (pndcls == 5 | pndcls == 8) {
		outs("la "); outd(soff[sid]); outc('\n');
		return;
	}
	if (pndcls == 6) {
		outs("lc "); outd(soff[sid]); outc('\n');
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
	if (pndcls == 5 | pndcls == 8) return;
	outs("dr\n");
}

rrlbl(name) char name[]; {
	extern scls, soff;
	int scls[], soff[];
	int sid;
	sid = symfnd(name);
	if (sid < 0) sid = symadd(name, 5, newl());
	if (scls[sid] != 5 & scls[sid] != 8) {
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
	if (scls[sid] == 8) fatal("duplicate label");
	if (scls[sid] != 5) fatal("label name collision");
	scls[sid] = 8;
	outs("lb ");
	outd(soff[sid]);
	outc('\n');
}

rewrt() {
	extern dbuf, dtag, dnm, fnsy, nlocs, hdrdn, pndcls;
	extern infun, fnst, nsy, scls, soff, ghbuf, ghlen, ghon, glits;
	char dbuf[], dtag[], dnm[], fnsy[], ghbuf[];
	int nlocs, hdrdn, pndcls, infun, fnst, nsy, ghlen, ghon, glits;
	int scls[], soff[];
	int idx, sz, base, sid;

	while (1) {
		if (!getln(dbuf, 1040)) {
			if (ghon) fatal("unfinished global definition");
			return;
		}
		icrst();
		nxtnam(dbuf, dtag);

		if (tageq(dtag, "Gstr")) {
			if (!ghon) fatal("literal outside global definition");
			outs("Glit"); outs(&dbuf[4]); outc('\n');
			ghtext("gvl "); ghnum(glits); ghchar('\n');
			glits = glits + 1;
			continue;
		}
		if (tageq(dtag, "Slit")) glits = glits + 1;
		if (tageq(dtag, "gvc") | tageq(dtag, "gvn")) {
			if (!ghon) fatal("initializer outside definition");
			ghtext(dbuf); ghchar('\n');
			continue;
		}
		if (tageq(dtag, "gve")) {
			if (!ghon) fatal("global end without definition");
			outs(ghbuf); echoln(dbuf);
			ghon = 0;
			continue;
		}

		if (tageq(dtag, "Adef")) {
			nxtnam(dbuf, dnm);
			cp9(fnsy, dnm);
			regsym(dnm, 4, 0);
			fnst = nsy;
			nlocs = 0;
			hdrdn = 0;
			infun = 1;
			pndcls = 0;
			emitpr();
			continue;
		}
		if (tageq(dtag, "Aauto")) {
			nxtnam(dbuf, dnm);
            if (symfnd(dnm) >= fnst) fatal("duplicate local name");
			if (nlocs >= 8191) fatal("auto frame too large");
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
            if (sz < 1 | sz > 8191) fatal("bad auto size");
            if (base > 8191 - sz) fatal("auto frame too large");
            nlocs = base + sz;
            outs("vi "); outd(base); outc(' ');
            outd(base + sz - 1); outc('\n');
			continue;
		}
		if (tageq(dtag, "Aarg")) {
			nxtnam(dbuf, dnm);
			idx = nxti(dbuf);
            if (symfnd(dnm) >= fnst) fatal("duplicate parameter");
			symadd(dnm, 2, idx);
			continue;
		}
		if (tageq(dtag, "Aextrn")) {
			nxtnam(dbuf, dnm);
			regext(dnm);
			continue;
		}
		if (tageq(dtag, "Agvec")) {
			nxtnam(dbuf, dnm);
			regsym(dnm, 7, 0);
			continue;
		}
		if (tageq(dtag, "Aend")) {
			sid = fnst;
			while (sid < nsy) {
				if (scls[sid] == 5) fatal("undefined internal label");
				sid = sid + 1;
			}
			emitpr();
			outs("ep "); outd(nlocs); outc('\n');
			symtrn();
			hdrdn = 1;
			infun = 0;
			pndcls = 0;
			continue;
		}

		if (infun) emitpr();

		if (tageq(dtag, "Rname") | tageq(dtag, "Rcall")) {
			nxtnam(dbuf, dnm);
			/* Preserve implicit external declarations for bare calls. */
			if (tageq(dtag, "Rcall")) if (symfnd(dnm) < 0) regext(dnm);
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
		if (tageq(dtag, "gvb") | tageq(dtag, "gvp")) {
			nxtnam(dbuf, dnm);
			idx = nxti(dbuf);
			if (symfnd(dnm) < 0) symadd(dnm, 3, 0);
			if (ghon) fatal("nested global definition");
			ghon = 1;
			ghlen = 0;
			ghtext(dbuf); ghchar('\n');
			pndcls = 0;
			continue;
		}

		pndcls = 0;
		echoln(dbuf);
	}
}
