/* Emit native PDP-11 instructions using the word-pointer calling convention. */
retl 0;

eop(s) {
    outc('*t');
    bouts(s);
    outc('*n');
}

cgnst(n) {
    bouts("*tmov*t$");
    outd(n);
    bouts("., r0*n");
}

cgpsh() {
    eop("10046");
}

rtcl(name) {
    eop("mov*tr0, -(sp)");
    bouts("*tjsr*tpc, ");
    bouts(name);
    outc('*n');
}

cmpop(brmiss, lfa, lend) {
    eop("cmp*t(sp)+, r0");
    outc('*t');
    bouts(brmiss);
    bouts("*t");lpref();
    outd(lfa);
    outc('*n');
    eop("mov*t$1, r0");
    bouts("*tjmp*t");lpref();
    outd(lend);
    outc('*n');
    lpref();
    outd(lfa);
    bouts(":*n");
    eop("clr*tr0");
    lpref();
    outd(lend);
    bouts(":*n");
}

cgbin(op) {
    if (op == '+') {
        eop("mov*t(sp)+, r1");
        eop("add*tr1, r0");
        return;
    }
    if (op == '-') {
        eop("mov*t(sp)+, r1");
        eop("sub*tr0, r1");
        eop("mov*tr1, r0");
        return;
    }
    if (op == '|') {
        eop("mov*t(sp)+, r1");
        eop("bis*tr1, r0");
        return;
    }
    if (op == '&') {
        eop("mov*t(sp)+, r1");
        eop("com*tr0");
        eop("bic*tr0, r1");
        eop("mov*tr1, r0");
        return;
    }
    if (op == '**') {
        rtcl(".mul");
        return;
    }
    if (op == '/') {
        rtcl(".div");
        return;
    }
    if (op == '%') {
        rtcl(".mod");
        return;
    }
    if (op == 104) {
        rtcl(".shl");
        return;
    }
    if (op == 105) {
        rtcl(".shr");
        return;
    }
    if (op == '^') {
        rtcl(".xor");
        return;
    }
    fatal("cgbin: unhandled op");
}

cgbinc(op, lfa, lend) {
    if (op == 100) {
        cmpop("bne", lfa, lend);
        return;
    }
    if (op == 101) {
        cmpop("beq", lfa, lend);
        return;
    }
    if (op == '<') {
        cmpop("bge", lfa, lend);
        return;
    }
    if (op == '>') {
        cmpop("ble", lfa, lend);
        return;
    }
    if (op == 102) {
        cmpop("bgt", lfa, lend);
        return;
    }
    if (op == 103) {
        cmpop("blt", lfa, lend);
        return;
    }
    fatal("cgbinc: unhandled op");
}

cgcll(nargs) {
    auto i;
    if (nargs < 0 | nargs > 8190) fatal("bad argument count");
    if (nargs == 0) {
        eop("clr*t-(sp)");
        nargs = 1;
    }
    i = 0;
    while (i < nargs / 2) {
        {
            bouts("*tmov*t");
            outd(2 * i);
            bouts(".(sp), r0*n");
            bouts("*tmov*t");
            outd(2 * (nargs - 1 - i));
            bouts(".(sp), r1*n");
            bouts("*tmov*tr0, ");
            outd(2 * (nargs - 1 - i));
            bouts(".(sp)*n");
            bouts("*tmov*tr1, ");
            outd(2 * i);
            bouts(".(sp)*n");
            i = i + 1;
        }
    }
    bouts("*tmov*t");
    outd(2 * nargs);
    bouts(".(sp), r0*n");
    eop("jsr*tpc, (r0)");
    bouts("*tadd*t$");
    outd(2 * (nargs + 1));
    bouts("., sp*n");
}

cgpro(name, nlocals, retlbl) {
    extrn retl;
    retl = retlbl;
    bouts("*n.text*n");
    bouts("*t.globl*t");
    cgsym(name);
    outc('*n');
    cgsym(name);
    bouts(":*n*t.+2*n");
    eop("mov*tr5, -(sp)");
    eop("mov*tsp, r5");
    bouts("*tsub*t$");lpref();
    outd(retlbl);
    bouts("f, sp*n");
}

cgvini(slot, dataoff) {
    eop("mov*tr5, r0");
    bouts("*tsub*t$");
    outd(2 * (dataoff + 1));
    bouts("., r0*n");
    cgword();
    eop("mov*tr5, r1");
    bouts("*tsub*t$");
    outd(2 * (slot + 1));
    bouts("., r1*n");
    eop("mov*tr0, (r1)");
}

cgepi(nlocals) {
    extrn retl;
    if (nlocals < 0 | nlocals > 8191) fatal("bad frame size");
    lpref();
    outd(retl);
    bouts(":*n");
    eop("mov*tr5, sp");
    eop("mov*t(sp)+, r5");
    eop("rts*tpc");
    lpref();
    outd(retl);
    bouts("f = ");
    outd(2 * nlocals);
    bouts(".*n");
}

cgret() {
    extrn retl;
    bouts("*tjmp*t");lpref();
    outd(retl);
    outc('*n');
}

cglca(off) {
    eop("mov*tr5, r0");
    bouts("*tsub*t$");
    outd(2 * (off + 1));
    bouts("., r0*n");
    cgword();
}

cgara(off) {
    eop("mov*tr5, r0");
    bouts("*tadd*t$");
    outd(2 * (off + 2));
    bouts("., r0*n");
    cgword();
}

cglod(kind, off, name) {
    bouts("*tmov*t");
    if (kind == 3) cgsym(name); else {
        if (kind == 1) off = - 2 * (off + 1); else off = 2 * (off + 2);
        outd(off);
        bouts(".(r5)");
    }
    bouts(", r0*n");
}

cgword() {
    eop("asr*tr0");
}

cgbyte() {
    eop("asl*tr0");
}

cgdrf() {
    cgbyte();
    eop("mov*t(r0), r0");
}

cgasn() {
    eop("mov*t(sp)+, r1");
    eop("asl*tr1");
    eop("mov*tr0, (r1)");
}

cgbrf(l) {
    eop("tst*tr0");
    bouts("*tbne*t1f*n");
    bouts("*tjmp*t");lpref();
    outd(l);
    outc('*n');
    bouts("1:*n");
}

cgjmp(l) {
    bouts("*tjmp*t");lpref();
    outd(l);
    outc('*n');
}

cglab(l) {
    lpref();
    outd(l);
    bouts(":*n");
}

cgext(name) {
    bouts("*tmov*t$");
    cgsym(name);
    bouts(", r0*n");
    cgword();
}

cgsta(id) {
    bouts("*tmov*t$");spref();
    outd(id);
    bouts(", r0*n");
    cgword();
}

cguop(op) {
    if (op == '-') {
        eop("neg*tr0");
        return;
    }
    if (op == '~') {
        eop("com*tr0");
        return;
    }
    fatal("cguop: unhandled");
}

cguopn(l1, l2) {
    eop("tst*tr0");
    bouts("*tbne*t");lpref();
    outd(l1);
    outc('*n');
    eop("mov*t$1, r0");
    bouts("*tjmp*t");lpref();
    outd(l2);
    outc('*n');
    lpref();
    outd(l1);
    bouts(":*n");
    eop("clr*tr0");
    lpref();
    outd(l2);
    bouts(":*n");
}

cgaob(isand, l) {
    eop("tst*tr0");
    if (isand) bouts("*tbne*t1f*n"); else bouts("*tbeq*t1f*n");
    bouts("*tjmp*t");lpref();
    outd(l);
    outc('*n');
    bouts("1:*n");
}

cgaoe(l) {
    lpref();
    outd(l);
    bouts(":*n");
}

cgtnq(l) {
    eop("tst*tr0");
    bouts("*tbne*t1f*n");
    bouts("*tjmp*t");lpref();
    outd(l);
    outc('*n');
    bouts("1:*n");
}

cgtnc(lel, le) {
    bouts("*tjmp*t");lpref();
    outd(le);
    outc('*n');
    lpref();
    outd(lel);
    bouts(":*n");
}

cgtne(le) {
    lpref();
    outd(le);
    bouts(":*n");
}

cgidx() {
    eop("mov*t(sp)+, r1");
    eop("add*tr1, r0");
}

cgcae(op) {
    eop("mov*tr0, -(sp)");
    eop("mov*t2(sp), r0");
    cgdrf();
    eop("mov*tr0, -(sp)");
    eop("mov*t2(sp), r0");
    cgbin(op);
    eop("tst*t(sp)+");
    cgasn();
}

cgcaec(op, lfa, lend) {
    eop("mov*tr0, -(sp)");
    eop("mov*t2(sp), r0");
    cgdrf();
    eop("mov*tr0, -(sp)");
    eop("mov*t2(sp), r0");
    cgbinc(op, lfa, lend);
    eop("tst*t(sp)+");
    cgasn();
}

cgpoi(isinc) {
    cgbyte();
    eop("mov*tr0, r1");
    eop("mov*t(r1), r0");
    if (isinc) eop("inc*t(r1)"); else eop("dec*t(r1)");
}

cgpri(isinc) {
    cgbyte();
    eop("mov*tr0, r1");
    if (isinc) eop("inc*t(r1)"); else eop("dec*t(r1)");
    eop("mov*t(r1), r0");
}
