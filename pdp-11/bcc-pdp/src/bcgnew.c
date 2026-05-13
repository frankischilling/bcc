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
	outs("\n.text\n\t.globl\t_");
	outs(name);
	outc('\n');
	outc('_');
	outs(name);
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
	outs("\t_");
	outs(name);
	outc('\n');
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
