/* bemit0.c -- b00's cg primitives: each writes one IC record to outfd.
 *
 * b00 links this instead of bcg.c.  bexpr.c and bstmt.c still call cgnst,
 * cgpsh, etc. -- those wrapper funcs serialize the call into a text
 * record on stdout, which b1 reads back.
 *
 * Record format: one record per line.  Tag char + space-separated decimal
 * args + newline.  See README for the full grammar.
 */

/* ---- cg primitives (each emits one IC record) ---- */

cgnst(n) { outs("n "); outd(n); outc('\n'); }
cgpsh()  { outs("ps\n"); }

cgbin(op) { outs("bin "); outd(op); outc('\n'); }

cgbinc(op, lfa, lend) {
	outs("binc ");
	outd(op);  outc(' ');
	outd(lfa); outc(' ');
	outd(lend); outc('\n');
}

iscmp(op) {
	if (op == 100) return (1);
	if (op == 101) return (1);
	if (op == '<')  return (1);
	if (op == '>')  return (1);
	if (op == 102) return (1);
	if (op == 103) return (1);
	return (0);
}

cgcll(name, nargs) char name[]; {
	outs("cl ");
	outs(name); outc(' ');
	outd(nargs); outc('\n');
}

cgpro(name, nloc) char name[]; { }

cgepi()  { outs("Aend\n"); }
cgret()  { outs("rt\n"); }

cglca(off) { outs("lc "); outd(off); outc('\n'); }
cgara(off) { outs("ar "); outd(off); outc('\n'); }
cgdrf()    { outs("dr\n"); }
cgdrfr()   { outs("Rderef\n"); }
cgasn()    { outs("as\n"); }

cgbrf(l) { outs("bf "); outd(l); outc('\n'); }
cgjmp(l) { outs("jm "); outd(l); outc('\n'); }
cglab(l) { outs("lb "); outd(l); outc('\n'); }

cgext(name) char name[]; { outs("ex "); outs(name); outc('\n'); }
cgrname(name) char name[]; { outs("Rname "); outs(name); outc('\n'); }
cgrlbl(name) char name[]; { outs("Rlbl "); outs(name); outc('\n'); }
cgrdef(name) char name[]; { outs("Rdef "); outs(name); outc('\n'); }

/* Raw inline string literal: tag=Slit, len, then len decimal bytes. */
cgslt(buf, len) char buf[]; {
	int j, b;
	outs("Slit ");
	outd(len);
	j = 0;
	while (j < len) {
		outc(' ');
		b = buf[j] & 0377;
		outd(b);
		j = j + 1;
	}
	outc('\n');
}

cguop(op) { outs("uo "); outd(op); outc('\n'); }

cguopn(l1, l2) {
	outs("uon ");
	outd(l1); outc(' ');
	outd(l2); outc('\n');
}

cgaob(isand, l) {
	outs("ao ");
	outd(isand); outc(' ');
	outd(l); outc('\n');
}

cgaoe(l) { outs("aoe "); outd(l); outc('\n'); }

cgtnq(l) { outs("tq "); outd(l); outc('\n'); }

cgtnc(lel, le) {
	outs("tc ");
	outd(lel); outc(' ');
	outd(le);  outc('\n');
}

cgtne(le) { outs("te "); outd(le); outc('\n'); }

cgidx() { outs("ix\n"); }
cgcae(op) { outs("ca "); outd(op); outc('\n'); }

/* Compound assign with comparison op (===, =!=, =<, =<=, =>, =>=).
 * Caller pre-allocates two labels for the cmp/branch sequence. */
cgcaec(op, lfa, lend) {
	outs("cac ");
	outd(op);   outc(' ');
	outd(lfa);  outc(' ');
	outd(lend); outc('\n');
}
cgpoi(isinc) { outs("po "); outd(isinc); outc('\n'); }
cgpri(isinc) { outs("pi "); outd(isinc); outc('\n'); }

cgvini(slot, dataoff) { }

cgaauto(name) char name[]; { outs("Aauto "); outs(name); outc('\n'); }
cgaarg(name, idx) char name[]; {
	outs("Aarg "); outs(name); outc(' '); outd(idx); outc('\n');
}
cgaextrn(name) char name[]; { outs("Aextrn "); outs(name); outc('\n'); }
cgavecsz(name, sz) char name[]; {
	outs("Avec "); outs(name); outc(' '); outd(sz); outc('\n');
}
cgagvec(name) char name[]; { outs("Agvec "); outs(name); outc('\n'); }

/* ---- 1972 strict additions ---- */

/* switch entry: r0 holds expr; push to (sp); jmp Ldisp.  Body inline next. */
cgswb(ldisp) {
	outs("swb "); outd(ldisp); outc('\n');
}

/* switch end: emit pop+exit, then Ldisp + dispatch chain.
 *   ldisp lpop lend ncases  k0 l0 k1 l1 ... */
cgswe(ldisp, lpop, lend, ncases, table) int table[]; {
	int i;
	outs("swe ");
	outd(ldisp); outc(' ');
	outd(lpop);  outc(' ');
	outd(lend);  outc(' ');
	outd(ncases);
	i = 0;
	while (i < ncases) {
		outc(' '); outd(table[2 * i]);
		outc(' '); outd(table[2 * i + 1]);
		i = i + 1;
	}
	outc('\n');
}

/* computed goto: r0 holds target address; emit jmp (r0). */
cggor() { outs("gor\n"); }

/* address-of-label: emit mov $Lid, r0.  Used when a label name appears
 * in expression context (kbman §5.5: goto rvalue). */
cgla(lid) { outs("la "); outd(lid); outc('\n'); }

/* Streaming global-vector emitter (replaces ga/gw for new defns).
 *   gvb name n     -- header (.text, .globl, _name:)
 *   gvc v          -- one constant word
 *   gvn name       -- one address-of-name word (kbman §7.2)
 *   gve            -- footer (.even)
 */
cggvb(name, n) char name[]; {
	outs("gvb ");
	outs(name); outc(' ');
	outd(n); outc('\n');
}

cggvc(v) { outs("gvc "); outd(v); outc('\n'); }

cggvn(name) char name[]; {
	outs("gvn "); outs(name); outc('\n');
}

cggve() { outs("gve\n"); }

cggwd(name, val) char name[]; {
	outs("gw ");
	outs(name); outc(' ');
	outd(val); outc('\n');
}

cggar(name, n, ninit, vals) char name[]; int vals[]; {
	int i;
	outs("ga ");
	outs(name); outc(' ');
	outd(n); outc(' ');
	outd(ninit);
	i = 0;
	while (i < ninit) {
		outc(' ');
		outd(vals[i]);
		i = i + 1;
	}
	outc('\n');
}
