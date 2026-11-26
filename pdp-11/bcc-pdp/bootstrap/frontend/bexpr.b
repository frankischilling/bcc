/* Parse expressions using the B operator precedence table. */
rprc 0;
rop 0;

binfo() {
    extrn tok, rprc, rop;
    auto t;
    t = tok;
    if (t == 109) {
        rprc = 1;
        rop = t;
        return(1);
    }
    if (t == 108) {
        rprc = 2;
        rop = t;
        return(1);
    }
    if (t == '|') {
        rprc = 3;
        rop = '|';
        return(1);
    }
    if (t == '^') {
        rprc = 4;
        rop = '^';
        return(1);
    }
    if (t == '&') {
        rprc = 5;
        rop = '&';
        return(1);
    }
    if (t == 100) {
        rprc = 6;
        rop = t;
        return(1);
    }
    if (t == 101) {
        rprc = 6;
        rop = t;
        return(1);
    }
    if (t == '<') {
        rprc = 7;
        rop = t;
        return(1);
    }
    if (t == '>') {
        rprc = 7;
        rop = t;
        return(1);
    }
    if (t == 102) {
        rprc = 7;
        rop = t;
        return(1);
    }
    if (t == 103) {
        rprc = 7;
        rop = t;
        return(1);
    }
    if (t == 104) {
        rprc = 8;
        rop = t;
        return(1);
    }
    if (t == 105) {
        rprc = 8;
        rop = t;
        return(1);
    }
    if (t == '+') {
        rprc = 9;
        rop = t;
        return(1);
    }
    if (t == '-') {
        rprc = 9;
        rop = t;
        return(1);
    }
    if (t == '**') {
        rprc = 10;
        rop = t;
        return(1);
    }
    if (t == '/') {
        rprc = 10;
        rop = t;
        return(1);
    }
    if (t == '%') {
        rprc = 10;
        rop = t;
        return(1);
    }
    return(0);
}

aeqop(t) {
    if (t == 130) return('+');
    if (t == 131) return('-');
    if (t == 132) return('**');
    if (t == 133) return('/');
    if (t == 134) return('%');
    if (t == 135) return('&');
    if (t == 136) return('|');
    if (t == 137) return('^');
    if (t == 138) return(104);
    if (t == 139) return(105);
    if (t == 140) return(100);
    if (t == 141) return(101);
    if (t == 142) return('<');
    if (t == 143) return(102);
    if (t == 144) return('>');
    if (t == 145) return(103);
    fatal("aeqop: bad token");
    return(0);
}

isasn() {
    extrn tok;
    if (tok == '=') return(1);
    if (tok >= 130) if (tok <= 145) return(1);
    return(0);
}

namelv() {
    extrn tok, tnam;
    auto i;
    auto name 5;
    i = 0;
    while (i < 9) {
        {
            lchar(name, i, char(tnam, i));
            i = i + 1;
        }
    }
    gettok();
    cgrname(name, tok == '(');
    return(1);
}

atomlv() {
    extrn tok, tval, tstr, tnam, tstrbuf, tstrlen;
    if (tok == 2) {
        cgnst(tval);
        gettok();
        return(0);
    }
    if (tok == 4) {
        cgnst(tval);
        gettok();
        return(0);
    }
    if (tok == 3) {
        cgslt(tstrbuf, tstrlen, 0);
        gettok();
        return(0);
    }
    if (tok == '(') {
        gettok();
        exprv();
        if (tok != ')') fatal("expected )");
        gettok();
        return(0);
    }
    if (tok == '&') {
        gettok();
        if (! primlv()) fatal("& requires lvalue");
        return(0);
    }
    if (tok == '**') {
        gettok();
        if (unary()) cgdrf();
        return(1);
    }
    if (tok == 1) return(namelv());
    fatal("expected expression");
    return(0);
}

primlv() {
    ;
    return(primtl(atomlv()));
}

primtl(lv) {
    extrn tok;
    auto nargs;
    while (1) {
        {
            if (tok == '(') {
                if (lv) cgdrfr();
                cgpsh();
                nargs = 0;
                gettok();
                if (tok != ')') {
                    while (1) {
                        {
                            exprv();
                            cgpsh();
                            nargs = nargs + 1;
                            if (tok == ')') goto br1;
                            if (tok != ',') fatal("expected , in args");
                            gettok();
                        }
                    }
                    br1:;
                }
                gettok();
                cgcll(nargs);
                lv = 0;
            } else if (tok == '[') {
                if (lv) cgdrfr();
                gettok();
                cgpsh();
                exprv();
                if (tok != ']') fatal("expected ]");
                gettok();
                cgidx();
                lv = 1;
            } else {
                if (tok == 106) {
                    if (! lv) fatal("++ requires lvalue");
                    gettok();
                    cgpoi(1);
                    return(0);
                }
                if (tok == 107) {
                    if (! lv) fatal("-- requires lvalue");
                    gettok();
                    cgpoi(0);
                    return(0);
                }
                return(lv);
            }
        }
    }
}

unary() {
    extrn tok;
    auto l1, l2;
    ;
    if (tok == '-') {
        gettok();
        if (unary()) cgdrfr();
        cguop('-');
        return(0);
    }
    if (tok == '~') {
        gettok();
        if (unary()) cgdrfr();
        cguop('~');
        return(0);
    }
    if (tok == '!') {
        gettok();
        if (unary()) cgdrfr();
        l1 = newl();
        l2 = newl();
        cguopn(l1, l2);
        return(0);
    }
    if (tok == 106) {
        gettok();
        if (! unary()) fatal("++ requires lvalue");
        cgpri(1);
        return(0);
    }
    if (tok == 107) {
        gettok();
        if (! unary()) fatal("-- requires lvalue");
        cgpri(0);
        return(0);
    }
    return(primlv());
}

binary(minprc) {
    extrn tok, rprc, rop;
    auto prec, op, islv, lfa, lend, lrhs;
    ;
    while (binfo()) {
        {
            prec = rprc;
            op = rop;
            if (prec < minprc) return;
            gettok();
            if (op == 108) {
                lfa = newl();
                lend = newl();
                cgbrf(lfa);
                islv = unary();
                if (islv) cgdrfr();
                binary(prec + 1);
                cgbrf(lfa);
                cgnst(1);
                cgjmp(lend);
                cglab(lfa);
                cgnst(0);
                cglab(lend);
                goto cn0;
            }
            if (op == 109) {
                lrhs = newl();
                lfa = newl();
                lend = newl();
                cgbrf(lrhs);
                cgnst(1);
                cgjmp(lend);
                cglab(lrhs);
                islv = unary();
                if (islv) cgdrfr();
                binary(prec + 1);
                cgbrf(lfa);
                cgnst(1);
                cgjmp(lend);
                cglab(lfa);
                cgnst(0);
                cglab(lend);
                goto cn0;
            }
            cgpsh();
            islv = unary();
            if (islv) cgdrfr();
            binary(prec + 1);
            if (iscmp(op)) {
                lfa = newl();
                lend = newl();
                cgbinc(op, lfa, lend);
            } else {
                cgbin(op);
            }
        }
        cn0:;
    }
}

exprv() {
    extrn tok;
    ;
    if (tok == '(') {
        gettok();
        exprv();
        if (tok != ')') fatal("expected )");
        gettok();
        exprtl(primtl(0));
        return;
    }
    exprtl(unary());
}

exprtl(islv) {
    extrn tok;
    auto op, bop, le, lend, lfa;
    op = 0;
    if (islv) op = isasn();
    if (op) {
        op = tok;
        gettok();
        cgpsh();
        exprv();
        if (op == '=') {
            cgasn();
        } else {
            bop = aeqop(op);
            if (iscmp(bop)) {
                lfa = newl();
                lend = newl();
                cgcaec(bop, lfa, lend);
            } else {
                cgcae(bop);
            }
        }
        return;
    }
    if (islv) cgdrfr();
    binary(1);
    if (tok == '?') {
        gettok();
        le = newl();
        cgtnq(le);
        exprv();
        if (tok != ':') fatal("expected :");
        gettok();
        lend = newl();
        cgtnc(le, lend);
        exprv();
        cgtne(lend);
    }
}

expr() {
    exprv();
}
