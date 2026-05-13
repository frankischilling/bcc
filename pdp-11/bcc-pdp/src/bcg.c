/* bcg.c -- codegen primitives.  Emits V1 as syntax.
 *
 * Naming: V1 as truncates linker symbols to 7 chars after _ prefix, so
 * every function name here is <=5 chars with unique 5-char prefix.
 *
 * Stack-machine convention: lvalue = address in R0; rvalue = value in R0.
 * TOS holds an address or saved operand; binops pop TOS and produce R0.
 *
 * Op-code constants used in switch arms below (literal -- V1 cc has no
 * preprocessor):
 *   100 T_EQ  101 T_NE  102 T_LE  103 T_GE
 *   104 T_SHL 105 T_SHR
 */

retl 0;          /* current function's return label */

eop(s) char s[]; {
	outc('\t');
	outs(s);
	outc('\n');
}

cgnst(n) {
	/* V1 as defaults to octal; "." suffix forces decimal. */
	outs("\tmov\t$");
	outd(n);
	outs("., r0\n");
}

asnum(n) {
	outd(n);
	outc('.');
}

cgpsh() {
	eop("mov\tr0, -(sp)");
}

/* runtime call helper: stack = [LHS]; R0 = RHS.  Pushes R0, then jsr. */
rtcl(name) char name[]; {
	eop("mov\tr0, -(sp)");
	outs("\tjsr\tpc, ");
	outs(name);
	outc('\n');
}

/* compare op: emit cmp + branch-on-miss + 0/1 selector.
 * Caller supplies both labels (allocated via newl). */
cmpop(brmiss, lfa, lend) char brmiss[]; {
	eop("cmp\t(sp)+, r0");
	outc('\t');
	outs(brmiss);
	outs("\tL");
	outd(lfa);
	outc('\n');
	eop("mov\t$1, r0");
	outs("\tjmp\tL");
	outd(lend);
	outc('\n');
	outs("L");
	outd(lfa);
	outs(":\n");
	eop("clr\tr0");
	outs("L");
	outd(lend);
	outs(":\n");
}

/* Non-compare binop only.  Compares use cgbinc (caller-supplied labels). */
cgbin(op) {
	if (op == '+') {
		eop("mov\t(sp)+, r1");
		eop("add\tr1, r0");
		return;
	}
	if (op == '-') {
		eop("mov\t(sp)+, r1");
		eop("sub\tr0, r1");
		eop("mov\tr1, r0");
		return;
	}
	if (op == '|') {
		eop("mov\t(sp)+, r1");
		eop("bis\tr1, r0");
		return;
	}
	if (op == '&') {
		eop("mov\t(sp)+, r1");
		eop("com\tr0");
		eop("bic\tr0, r1");
		eop("mov\tr1, r0");
		return;
	}
	if (op == '*')  { rtcl(".mul"); return; }
	if (op == '/')  { rtcl(".div"); return; }
	if (op == '%')  { rtcl(".mod"); return; }
	if (op == 104) { rtcl(".shl"); return; }    /* T_SHL */
	if (op == 105) { rtcl(".shr"); return; }    /* T_SHR */
	if (op == '^')  { rtcl(".xor"); return; }
	fatal("cgbin: unhandled op");
}

/* Compare binop with caller-supplied labels. */
cgbinc(op, lfa, lend) {
	if (op == 100) { cmpop("bne", lfa, lend); return; }   /* T_EQ */
	if (op == 101) { cmpop("beq", lfa, lend); return; }   /* T_NE */
	if (op == '<')  { cmpop("bge", lfa, lend); return; }
	if (op == '>')  { cmpop("ble", lfa, lend); return; }
	if (op == 102) { cmpop("bgt", lfa, lend); return; }   /* T_LE */
	if (op == 103) { cmpop("blt", lfa, lend); return; }   /* T_GE */
	fatal("cgbinc: unhandled op");
}

/* Return 1 if op is a compare op (needs 2 labels). */
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
	int i;
	/* Caller pushed args left-to-right (so rightmost arg is TOS).
	 * Reverse the top N stack words so leftmost arg ends up at TOS.
	 * After this, callee sees arg i at 2*(i+2)(r5) regardless of
	 * how many args were declared vs passed (varargs-friendly,
	 * matches the kbman §9.3 printf assumption). */
	i = 0;
	while (i < nargs / 2) {
		outs("\tmov\t");
		outd(2 * i);
		outs(".(sp), r0\n");
		outs("\tmov\t");
		outd(2 * (nargs - 1 - i));
		outs(".(sp), r1\n");
		outs("\tmov\tr0, ");
		outd(2 * (nargs - 1 - i));
		outs(".(sp)\n");
		outs("\tmov\tr1, ");
		outd(2 * i);
		outs(".(sp)\n");
		i = i + 1;
	}
	outs("\tjsr\tpc, _");
	outs(name);
	outc('\n');
	if (nargs == 1) {
		eop("tst\t(sp)+");
		return;
	}
	if (nargs > 1) {
		outs("\tadd\t$");
		outd(2 * nargs);
		outs("., sp\n");
	}
}

cgpro(name, nlocals, retlbl) char name[]; {
	extern retl;
	int retl;
	retl = retlbl;
	outs("\n.text\n");
	outs("\t.globl\t_");
	outs(name);
	outc('\n');
	outc('_');
	outs(name);
	outs(":\n");
	eop("mov\tr5, -(sp)");
	eop("mov\tsp, r5");
	if (nlocals > 0) {
		outs("\tsub\t$");
		outd(2 * nlocals);
		outs("., sp\n");
	}
}

/* vector-auto init: write &data[0] into v's slot.
 *   slot     -- local offset where the v-pointer lives
 *   dataoff  -- local offset of the first data cell
 * Local at offset o is at address r5 - 2*(o+1). */
cgvini(slot, dataoff) {
	eop("mov\tr5, r0");
	outs("\tsub\t$");
	outd(2 * (dataoff + 1));
	outs("., r0\n");
	eop("mov\tr5, r1");
	outs("\tsub\t$");
	outd(2 * (slot + 1));
	outs("., r1\n");
	eop("mov\tr0, (r1)");
}

cggwd(name, val) char name[]; {
	outs("\n.text\n\t.globl\t_");
	outs(name);
	outc('\n');
	outc('_');
	outs(name);
	outs(":\n\t");
	asnum(val);
	outc('\n');
	outs("\t.even\n");
}

cggar(name, n, ninit, vals) char name[]; int vals[]; {
	int i;
	outs("\n.text\n\t.globl\t_");
	outs(name);
	outc('\n');
	outc('_');
	outs(name);
	outs(":\n");
	i = 0;
	while (i < n) {
		outc('\t');
		if (i < ninit) asnum(vals[i]);
		else           asnum(0);
		outc('\n');
		i = i + 1;
	}
	outs("\t.even\n");
}

cggab(name, n, ninit, buf) char name[]; char buf[]; {
	int i;
	outs("\n.text\n\t.globl\t_");
	outs(name);
	outc('\n');
	outc('_');
	outs(name);
	outs(":\n");
	i = 0;
	while (i < n) {
		outc('\t');
		if (i < ninit) asnum(nxti(buf));
		else           asnum(0);
		outc('\n');
		i = i + 1;
	}
	outs("\t.even\n");
}

cgepi() {
	extern retl;
	int retl;
	outs("L");
	outd(retl);
	outs(":\n");
	eop("mov\tr5, sp");
	eop("mov\t(sp)+, r5");
	eop("rts\tpc");
}

cgret() {
	extern retl;
	int retl;
	outs("\tjmp\tL");
	outd(retl);
	outc('\n');
}

cglca(off) {
	/* local i: addr = r5 - 2*(off+1) */
	eop("mov\tr5, r0");
	outs("\tsub\t$");
	outd(2 * (off + 1));
	outs("., r0\n");
}

cgara(off) {
	/* arg i: addr = r5 + 2*(off+2) */
	eop("mov\tr5, r0");
	outs("\tadd\t$");
	outd(2 * (off + 2));
	outs("., r0\n");
}

cgdrf() {
	eop("mov\t(r0), r0");
}

cgasn() {
	/* TOS = addr, R0 = value.  *addr = value; R0 stays. */
	eop("mov\t(sp)+, r1");
	eop("mov\tr0, (r1)");
}

cgbrf(l) {
	eop("tst\tr0");
	outs("\tbne\t1f\n");
	outs("\tjmp\tL");
	outd(l);
	outc('\n');
	outs("1:\n");
}

cgjmp(l) {
	outs("\tjmp\tL");
	outd(l);
	outc('\n');
}

cglab(l) {
	outs("L");
	outd(l);
	outs(":\n");
}

cgext(name) char name[]; {
	outs("\tmov\t$_");
	outs(name);
	outs(", r0\n");
}

cgsta(id) {
	outs("\tmov\t$S");
	outd(id);
	outs(", r0\n");
}

/* Non-! unary only.  ! uses cguopn (caller-supplied labels). */
cguop(op) {
	if (op == '-') { eop("neg\tr0"); return; }
	if (op == '~') { eop("com\tr0"); return; }
	fatal("cguop: unhandled");
}

/* Logical NOT: caller supplies two labels. */
cguopn(l1, l2) {
	eop("tst\tr0");
	outs("\tbne\tL");
	outd(l1);
	outc('\n');
	eop("mov\t$1, r0");
	outs("\tjmp\tL");
	outd(l2);
	outc('\n');
	outs("L");
	outd(l1);
	outs(":\n");
	eop("clr\tr0");
	outs("L");
	outd(l2);
	outs(":\n");
}

/* short-circuit && / ||:  isand=1 for &&, =0 for ||.
 * Caller supplies the end-label l (later passed to cgaoe). */
cgaob(isand, l) {
	eop("tst\tr0");
	if (isand) outs("\tbne\t1f\n");
	else       outs("\tbeq\t1f\n");
	outs("\tjmp\tL");
	outd(l);
	outc('\n');
	outs("1:\n");
}

cgaoe(l) {
	outs("L");
	outd(l);
	outs(":\n");
}

/* ?: begin: caller supplies the else-arm label. */
cgtnq(l) {
	eop("tst\tr0");
	outs("\tbne\t1f\n");
	outs("\tjmp\tL");
	outd(l);
	outc('\n');
	outs("1:\n");
}

/* ?: middle: caller supplies the prior else label lel and the new end le. */
cgtnc(lel, le) {
	outs("\tjmp\tL");
	outd(le);
	outc('\n');
	outs("L");
	outd(lel);
	outs(":\n");
}

cgtne(le) {
	outs("L");
	outd(le);
	outs(":\n");
}

cgidx() {
	/* TOS = base, R0 = idx.  R0 = base + 2*idx. */
	eop("asl\tr0");
	eop("mov\t(sp)+, r1");
	eop("add\tr1, r0");
}

cgcae(op) {
	/* Stack: [addr]; R0 = rhs.  *addr = *addr OP rhs; R0 = new value.
	 * For non-compare op only (compares go through cgcaec). */
	eop("mov\tr0, -(sp)");         /* save rhs   -> [addr, rhs]     */
	eop("mov\t2(sp), r0");         /* r0 = addr (peek 2 below TOS)  */
	eop("mov\t(r0), r0");          /* r0 = *addr (LHS for binop)    */
	eop("mov\tr0, -(sp)");         /* push LHS  -> [addr, rhs, LHS] */
	eop("mov\t2(sp), r0");         /* r0 = rhs (RHS for binop)      */
	cgbin(op);                      /* pops LHS; r0 = result         */
	eop("tst\t(sp)+");             /* discard rhs                    */
	eop("mov\t(sp)+, r1");         /* pop addr                       */
	eop("mov\tr0, (r1)");          /* *addr = result                 */
}

/* Compound assign with comparison op.  Same shape as cgcae but uses
 * cgbinc with caller-supplied labels (1972 §4.11 ===, =!=, =<, =<=, =>, =>=). */
cgcaec(op, lfa, lend) {
	eop("mov\tr0, -(sp)");
	eop("mov\t2(sp), r0");
	eop("mov\t(r0), r0");
	eop("mov\tr0, -(sp)");
	eop("mov\t2(sp), r0");
	cgbinc(op, lfa, lend);          /* pops LHS; r0 = 0 or 1 */
	eop("tst\t(sp)+");
	eop("mov\t(sp)+, r1");
	eop("mov\tr0, (r1)");
}

cgpoi(isinc) {
	/* post-inc/dec: R0 = address.  After: R0 = old *addr; *addr += 1. */
	eop("mov\tr0, r1");
	eop("mov\t(r1), r0");
	if (isinc) eop("inc\t(r1)");
	else       eop("dec\t(r1)");
}

cgpri(isinc) {
	/* pre-inc/dec: R0 = address.  After: *addr += 1; R0 = new value. */
	eop("mov\tr0, r1");
	if (isinc) eop("inc\t(r1)");
	else       eop("dec\t(r1)");
	eop("mov\t(r1), r0");
}

/* unused placeholders; kept for forward compatibility */
cgrtz() {}
cginc(o) {}
cgdec(o) {}

/* 1972-strict additions live in bcgnew.c (split for V1 cc throughput). */
