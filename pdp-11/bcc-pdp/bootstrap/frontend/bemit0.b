/* Write unresolved compiler records for the parser. */
cgnst(n) {
    bouts("n ");
    outd(n);
    outc('*n');
}

cgpsh() {
    bouts("ps*n");
}

cgbin(op) {
    bouts("bin ");
    outd(op);
    outc('*n');
}

cgbinc(op, lfa, lend) {
    bouts("binc ");
    outd(op);
    outc(' ');
    outd(lfa);
    outc(' ');
    outd(lend);
    outc('*n');
}

iscmp(op) {
    if (op == 100) return(1);
    if (op == 101) return(1);
    if (op == '<') return(1);
    if (op == '>') return(1);
    if (op == 102) return(1);
    if (op == 103) return(1);
    return(0);
}

cgcll(nargs) {
    bouts("cl ");
    outd(nargs);
    outc('*n');
}

cgepi() {
    bouts("Aend*n");
}

cgret() {
    bouts("rt*n");
}

cgdrf() {
    bouts("dr*n");
}

cgdrfr() {
    bouts("Rderef*n");
}

cgasn() {
    bouts("as*n");
}

cgbrf(l) {
    bouts("bf ");
    outd(l);
    outc('*n');
}

cgjmp(l) {
    bouts("jm ");
    outd(l);
    outc('*n');
}

cglab(l) {
    bouts("lb ");
    outd(l);
    outc('*n');
}

cgrname(name, call) {
    if (call) bouts("Rcall "); else bouts("Rname ");
    outs(name);
    outc('*n');
}

cgrlbl(name) {
    bouts("Rlbl ");
    outs(name);
    outc('*n');
}

cgrdef(name) {
    bouts("Rdef ");
    outs(name);
    outc('*n');
}

cgslt(buf, len, global) {
    auto j, b;
    if (global) bouts("Gstr "); else bouts("Slit ");
    outd(len);
    j = 0;
    while (j < len) {
        {
            outc(' ');
            b = char(buf, j) & 0377;
            outd(b);
            j = j + 1;
        }
    }
    outc('*n');
}

cguop(op) {
    bouts("uo ");
    outd(op);
    outc('*n');
}

cguopn(l1, l2) {
    bouts("uon ");
    outd(l1);
    outc(' ');
    outd(l2);
    outc('*n');
}

cgtnq(l) {
    bouts("tq ");
    outd(l);
    outc('*n');
}

cgtnc(lel, le) {
    bouts("tc ");
    outd(lel);
    outc(' ');
    outd(le);
    outc('*n');
}

cgtne(le) {
    bouts("te ");
    outd(le);
    outc('*n');
}

cgidx() {
    bouts("ix*n");
}

cgcae(op) {
    bouts("ca ");
    outd(op);
    outc('*n');
}

cgcaec(op, lfa, lend) {
    bouts("cac ");
    outd(op);
    outc(' ');
    outd(lfa);
    outc(' ');
    outd(lend);
    outc('*n');
}

cgpoi(isinc) {
    bouts("po ");
    outd(isinc);
    outc('*n');
}

cgpri(isinc) {
    bouts("pi ");
    outd(isinc);
    outc('*n');
}

cgaauto(name) {
    bouts("Aauto ");
    outs(name);
    outc('*n');
}

cgaarg(name, idx) {
    bouts("Aarg ");
    outs(name);
    outc(' ');
    outd(idx);
    outc('*n');
}

cgaextrn(name) {
    bouts("Aextrn ");
    outs(name);
    outc('*n');
}

cgavecsz(name, sz) {
    bouts("Avec ");
    outs(name);
    outc(' ');
    outd(sz);
    outc('*n');
}

cgagvec(name) {
    bouts("Agvec ");
    outs(name);
    outc('*n');
}

cgswb(ldisp) {
    bouts("swb ");
    outd(ldisp);
    outc('*n');
}

cgswc(ldisp, lnext, value, lbody) {
    bouts("swc ");
    outd(ldisp);
    outc(' ');
    outd(lnext);
    outc(' ');
    outd(value);
    outc(' ');
    outd(lbody);
    outc('*n');
}

cgswe(last, lend) {
    bouts("swx ");
    outd(last);
    outc(' ');
    outd(lend);
    outc('*n');
}

cggor() {
    bouts("gor*n");
}

cggvb(name, n) {
    bouts("gvb ");
    outs(name);
    outc(' ');
    outd(n);
    outc('*n');
}

cggvc(v) {
    bouts("gvc ");
    outd(v);
    outc('*n');
}

cggvn(name) {
    bouts("gvn ");
    outs(name);
    outc('*n');
}

cggve() {
    bouts("gve*n");
}

cggvp(name, n) {
    bouts("gvp ");
    outs(name);
    outc(' ');
    outd(n);
    outc('*n');
}
