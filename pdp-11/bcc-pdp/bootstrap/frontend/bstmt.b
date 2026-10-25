/* Parse declarations and statements into unresolved compiler records. */
nswc 0;
swdpt 0;
swdisp 0;
brkl 0;
contl 0;
hasbrk 0;
hascont 0;

cpname(dst, src) {
    auto i;
    i = 0;
    while (1) {
        {
            if (i >= 8) goto br0;
            if (char(src, i) == 0) goto br0;
            lchar(dst, i, char(src, i));
            i = i + 1;
        }
    }
    br0:;
    while (i < 9) {
        {
            lchar(dst, i, 0);
            i = i + 1;
        }
    }
}

prog() {
    extrn tok, tnam;
    auto name 5;
    while (tok != 0) {
        {
            if (tok != 1) fatal("expected name at top level");
            cpname(name, tnam);
            gettok();
            if (tok == '(') fdef(name); else gdef(name);
        }
    }
}

gconst() {
    extrn tok, tval;
    auto neg, v;
    neg = 0;
    if (tok == '-') {
        neg = 1;
        gettok();
    }
    if (tok != 2) if (tok != 4) fatal("expected constant");
    v = tval;
    gettok();
    if (neg) v = norm16(- v);
    return(v);
}

vsize() {
    extrn tval;
    if (tval < 0 | tval > 8190) fatal("bad vector size");
    return(tval + 1);
}

gival() {
    extrn tok, tnam, tstrbuf, tstrlen;
    if (tok == 3) {
        cgslt(tstrbuf, tstrlen, 1);
        gettok();
        return;
    }
    if (tok == 1) {
        cggvn(tnam);
        gettok();
        return;
    }
    cggvc(gconst());
}

gdef(name) {
    extrn tok, tval;
    auto n, ninit;
    if (tok == '[') {
        gettok();
        n = 0;
        if (tok == 2 | tok == 4) {
            n = vsize() - 1;
            gettok();
        }
        if (tok != ']') fatal("expected ] in global vector");
        gettok();
        cgagvec(name);
        cggvp(name, n);
        ninit = 0;
        while (tok != ';') {
            {
                if (tok == 0) fatal("unexpected EOF in global vector");
                if (ninit >= 128) fatal("too many vector initializers");
                gival();
                ninit = ninit + 1;
                if (tok == ',') {
                    gettok();
                    goto cn0;
                }
                if (tok != ';') fatal("expected , or ; in global vector");
            }
            cn0:;
        }
        cggve();
        gettok();
        return;
    }
    cggvb(name, 0);
    ninit = 0;
    while (tok != ';') {
        {
            if (tok == 0) fatal("unexpected EOF in global");
            if (ninit >= 128) fatal("too many global initializers");
            gival();
            ninit = ninit + 1;
            if (tok == ',') {
                gettok();
                goto cn1;
            }
            if (tok != ';') fatal("expected , or ; in global");
        }
        cn1:;
    }
    if (ninit == 0) cggvc(0);
    cggve();
    gettok();
}
nlocal 0;
decl() {
    extrn tok, tval, tnam, extflg, nlocal;
    auto saved 5;
    auto kind, sz;
    kind = tok;
    gettok();
    while (1) {
        {
            if (tok != 1) fatal("expected declaration name");
            cpname(saved, tnam);
            gettok();
            if (kind == 11) cgaextrn(saved); else {
                cgaauto(saved);
                sz = 1;
                if (tok == '[') {
                    if (! extflg) fatal("auto [] requires -x");
                    gettok();
                    if (tok != 2) if (tok != 4) fatal("expected vector size");
                    sz = vsize();
                    gettok();
                    if (tok != ']') fatal("expected ] after vector size");
                    gettok();
                    cgavecsz(saved, sz);
                } else if (tok == 2 | tok == 4) {
                    sz = vsize();
                    gettok();
                    cgavecsz(saved, sz);
                }
                if (nlocal > 8191 - sz) fatal("auto frame too large");
                nlocal = nlocal + sz;
            }
            if (tok != ',') goto br0;
            gettok();
        }
    }
    br0:;
    if (tok != ';') fatal("expected ; after declaration");
    gettok();
}

fdef(name) {
    extrn tok, tnam, nlocal;
    auto nargs;
    if (tok != '(') fatal("expected ( after function name");
    gettok();
    bouts("Adef ");
    outs(name);
    outc('*n');
    nargs = 0;
    if (tok != ')') {
        while (1) {
            {
                if (tok != 1) fatal("expected parameter name");
                cgaarg(tnam, nargs);
                nargs = nargs + 1;
                gettok();
                if (tok != ',') goto br0;
                gettok();
            }
        }
        br0:;
    }
    if (tok != ')') fatal("expected ) in arg list");
    gettok();
    nlocal = 0;
    stmt();
    cgepi();
}

stmt() {
    extrn tok, tnam, tval, tstr, nswc, swdpt, swdisp;
    extrn extflg, brkl, contl, hasbrk, hascont;
    auto first, second, save1, save2, save3, save4;
    auto saved 5;
    ;
    again:
    while (tok == 10 | tok == 11) {
        decl();
    }
    if (tok == '{') {
        gettok();
        while (tok != '}') {
            {
                if (tok == 0) fatal("unexpected EOF in block");
                stmt();
            }
        }
        gettok();
        return;
    }
    if (tok == ';') {
        gettok();
        return;
    }
    if (tok == 12) {
        gettok();
        if (tok != '(') fatal("expected ( after if");
        gettok();
        expr();
        if (tok != ')') fatal("expected )");
        gettok();
        first = newl();
        cgbrf(first);
        stmt();
        if (tok == 13) {
            gettok();
            second = newl();
            cgjmp(second);
            cglab(first);
            stmt();
            cglab(second);
        } else {
            cglab(first);
        }
        return;
    }
    if (tok == 14) {
        gettok();
        if (tok != '(') fatal("expected ( after while");
        gettok();
        first = newl();
        second = newl();
        cglab(first);
        expr();
        if (tok != ')') fatal("expected )");
        gettok();
        cgbrf(second);
        save1 = brkl;
        save2 = contl;
        save3 = hasbrk;
        save4 = hascont;
        brkl = second;
        contl = first;
        hasbrk = 1;
        hascont = 1;
        stmt();
        brkl = save1;
        contl = save2;
        hasbrk = save3;
        hascont = save4;
        cgjmp(first);
        cglab(second);
        return;
    }
    if (tok == 19) {
        gettok();
        first = newl();
        second = newl();
        expr();
        cgswb(first);
        if (swdpt >= 16) fatal("switch nesting too deep");
        swdpt = swdpt + 1;
        save1 = nswc;
        save2 = swdisp;
        nswc = 0;
        swdisp = first;
        save3 = brkl;
        save4 = hasbrk;
        brkl = second;
        hasbrk = 1;
        stmt();
        cgswe(swdisp, second);
        brkl = save3;
        hasbrk = save4;
        nswc = save1;
        swdisp = save2;
        swdpt = swdpt - 1;
        return;
    }
    if (tok == 20) {
        if (swdpt == 0) fatal("case outside switch");
        gettok();
        first = gconst();
        if (tok != ':') fatal("expected : after case constant");
        gettok();
        if (nswc >= 32) fatal(">c");
        second = newl();
        save1 = newl();
        cgswc(swdisp, second, first, save1);
        swdisp = second;
        nswc = nswc + 1;
        goto again;
    }
    if (tok == 15) {
        gettok();
        if (tok == '(') {
            gettok();
            expr();
            if (tok != ')') fatal("expected )");
            gettok();
        } else {
            cgnst(0);
        }
        if (tok != ';') fatal("expected ; after return");
        gettok();
        cgret();
        return;
    }
    if (tok == 17) {
        if (! extflg) fatal("break removed in strict 1972 mode");
        if (! hasbrk) fatal("break outside loop/switch");
        gettok();
        if (tok != ';') fatal("expected ; after break");
        gettok();
        cgjmp(brkl);
        return;
    }
    if (tok == 18) {
        if (! extflg) fatal("continue removed in strict 1972 mode");
        if (! hascont) fatal("continue outside loop");
        gettok();
        if (tok != ';') fatal("expected ; after continue");
        gettok();
        cgjmp(contl);
        return;
    }
    if (tok == 16) {
        gettok();
        if (tok == 1) {
            cpname(saved, tnam);
            save1 = tval;
            save2 = tstr;
            gettok();
            if (tok == ';') {
                cgrlbl(saved);
                gettok();
                return;
            }
            pushtok();
            tok = 1;
            cpname(tnam, saved);
            tval = save1;
            tstr = save2;
        }
        expr();
        if (tok != ';') fatal("expected ; after goto");
        gettok();
        cggor();
        return;
    }
    if (tok == 1) {
        cpname(saved, tnam);
        save1 = tval;
        save2 = tstr;
        gettok();
        if (tok == ':') {
            cgrdef(saved);
            gettok();
            goto again;
        }
        pushtok();
        tok = 1;
        cpname(tnam, saved);
        tval = save1;
        tstr = save2;
    }
    expr();
    if (tok != ';') fatal("expected ; after expression");
    gettok();
}
