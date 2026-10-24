/* bcgnew.c -- 1972-strict codegen primitives.  Split from bcg.c for
 * V1 cc throughput (large bcg.c was painfully slow under apout).
 */

/* switch entry: r0 = expr; push, jump to dispatcher (skips body). */
cgswb(ldisp) {
	eop("mov\tr0, -(sp)");
	outs("\tjmp\tL");
	outd(ldisp);
	outc('\n');
}

/* switch end: emit pop+exit, then dispatcher chain.  Layout:
 *      <body inline above>
 *      jmp Lpop                  ; fall-through past last case lands here too
 *  Lpop: tst (sp)+; jmp Lend
 *  Ldisp: mov (sp), r0; cmp r0, $K; jeq Lc; ... ; jmp Lpop
 *  Lend:
 */
cgswe(ldisp, lpop, lend, ncases, table) int table[]; {
	int i;
	outs("\tjmp\tL");
	outd(lpop);
	outc('\n');
	outs("L");
	outd(lpop);
	outs(":\n");
	eop("tst\t(sp)+");
	outs("\tjmp\tL");
	outd(lend);
	outc('\n');
	outs("L");
	outd(ldisp);
	outs(":\n");
	eop("mov\t(sp), r0");
	i = 0;
	while (i < ncases) {
		outs("\tcmp\tr0, $");
		outd(table[2 * i]);
		outs(".\n");
		outs("\tbeq\tL");
		outd(table[2 * i + 1]);
		outc('\n');
		i = i + 1;
	}
	outs("\tjmp\tL");
	outd(lpop);
	outc('\n');
	outs("L");
	outd(lend);
	outs(":\n");
}

/* computed goto: r0 already holds target; jmp (r0). */
cggor() {
	eop("jmp\t(r0)");
}

/* address-of-label: emit `mov $L<lid>, r0`. */
cgla(lid) {
	outs("\tmov\t$L");
	outd(lid);
	outs(", r0\n");
}

/* ---- streaming global-vector emitter ---- */

gvnstor 0;
gvinit  0;

cggvb(name, n) char name[]; {
	extern gvnstor, gvinit;
	int gvnstor, gvinit;
	gvnstor = n;
	gvinit  = 0;
	outs("\n.text\n\t.globl\t");
	cgsym(name);
	outc('\n');
	cgsym(name);
	outs(":\n");
}

cggvc(v) {
	extern gvinit;
	int gvinit;
	outc('\t');
	outd(v);
	outs(".\n");
	gvinit = gvinit + 1;
}

cggvn(name) char name[]; {
	extern gvinit;
	int gvinit;
	outc('\t');
	cgsym(name);
	outc('\n');
	gvinit = gvinit + 1;
}

cggvl(id) {
    extern gvinit, nstr;
    int gvinit, nstr;
    if (id < 0 | id >= nstr) fatal("bad literal reference");
    outs("\tS"); outd(id); outc('\n');
    gvinit = gvinit + 1;
}

cggve() {
	extern gvnstor, gvinit;
	int gvnstor, gvinit;
	while (gvinit < gvnstor) {
		outs("\t0.\n");
		gvinit = gvinit + 1;
	}
	outs("\t.even\n");
}

cggvp(name, n) char name[]; {
    cggvb(name, n);
    outs("\t.+2\n");
}

/* V1 as folds case and keeps seven characters. Keep the short lowercase
 * ABI, and give other names collision-free IDs within this compilation.
 * Runtime-private IDs use J; program-private IDs use K. */
snames[900]; /* 200 names of nine bytes, accessed as char[]. */
nsname 0;
libmod 0;

cgsym(name) char name[]; {
    extern snames, nsname, libmod;
    char snames[];
    int nsname, libmod;
    int n, i, idx, base, safe;
    n = 0;
    safe = 1;
    while (name[n]) {
        if (name[n] >= 'A') if (name[n] <= 'Z') safe = 0;
        n = n + 1;
    }
    if (n == 0) fatal("empty external name");
    if (n > 8) fatal("external name too long");
    if (n > 6) safe = 0;
    if (tageq(name, "putchar")) safe = 1;
    if (tageq(name, "getchar")) safe = 1;
    if (tageq(name, "putcha")) safe = 0;
    if (tageq(name, "getcha")) safe = 0;
    if (safe) {
        outc('_'); outs(name); return;
    }
    idx = 0;
    while (idx < nsname) {
        base = idx * 9;
        if (tageq(&snames[base], name)) goto emit;
        idx = idx + 1;
    }
    if (nsname >= 200) fatal("external name table full");
    base = idx * 9;
    i = 0;
    while (i < n) {
        snames[base + i] = name[i];
        i = i + 1;
    }
    snames[base + n] = 0;
    nsname = nsname + 1;
emit:
    if (libmod) outc('J');
    else outc('K');
    outd(idx);
}
