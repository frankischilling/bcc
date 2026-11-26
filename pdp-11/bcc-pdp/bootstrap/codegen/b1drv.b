/* Read resolved compiler records and dispatch to native code-generation routines. */
dbuf[520];
dtag[5];
dnm[5];
dsb[130];
adkind 0;
adoff 0;

adflsh() {
    extrn adkind, adoff, dnm;
    if (adkind == 1) cglca(adoff);
    if (adkind == 2) cgara(adoff);
    if (adkind == 3) cgext(dnm);
    adkind = 0;
}

disp1() {
    extrn adkind, adoff;
    extrn dbuf, dtag, dnm, dsb;
    auto a, b, c;
    if (tageq(dtag, "n")) {
        a = nxti(dbuf);
        cgnst(a);
        return(1);
    }
    if (tageq(dtag, "ps")) {
        cgpsh();
        return(1);
    }
    if (tageq(dtag, "bin")) {
        a = nxti(dbuf);
        cgbin(a);
        return(1);
    }
    if (tageq(dtag, "binc")) {
        a = nxti(dbuf);
        b = nxti(dbuf);
        c = nxti(dbuf);
        cgbinc(a, b, c);
        return(1);
    }
    if (tageq(dtag, "cl")) {
        a = nxti(dbuf);
        cgcll(a);
        return(1);
    }
    if (tageq(dtag, "pr")) {
        nxtnam(dbuf, dnm);
        a = nxti(dbuf);
        b = nxti(dbuf);
        cgpro(dnm, a, b);
        return(1);
    }
    if (tageq(dtag, "ep")) {
        a = nxti(dbuf);
        cgepi(a);
        return(1);
    }
    if (tageq(dtag, "rt")) {
        cgret();
        return(1);
    }
    if (tageq(dtag, "lc")) {
        adoff = nxti(dbuf);
        adkind = 1;
        return(1);
    }
    if (tageq(dtag, "ar")) {
        adoff = nxti(dbuf);
        adkind = 2;
        return(1);
    }
    if (tageq(dtag, "dr")) {
        cgdrf();
        return(1);
    }
    if (tageq(dtag, "as")) {
        cgasn();
        return(1);
    }
    if (tageq(dtag, "bf")) {
        a = nxti(dbuf);
        cgbrf(a);
        return(1);
    }
    if (tageq(dtag, "jm")) {
        a = nxti(dbuf);
        cgjmp(a);
        return(1);
    }
    if (tageq(dtag, "lb")) {
        a = nxti(dbuf);
        cglab(a);
        return(1);
    }
    if (tageq(dtag, "ex")) {
        nxtnam(dbuf, dnm);
        adkind = 3;
        return(1);
    }
    return(0);
}

disp2() {
    extrn dbuf, dtag, dnm;
    auto a, b, c;
    if (tageq(dtag, "st")) {
        a = nxti(dbuf);
        cgsta(a);
        return(1);
    }
    if (tageq(dtag, "uo")) {
        a = nxti(dbuf);
        cguop(a);
        return(1);
    }
    if (tageq(dtag, "uon")) {
        a = nxti(dbuf);
        b = nxti(dbuf);
        cguopn(a, b);
        return(1);
    }
    if (tageq(dtag, "ao")) {
        a = nxti(dbuf);
        b = nxti(dbuf);
        cgaob(a, b);
        return(1);
    }
    if (tageq(dtag, "aoe")) {
        a = nxti(dbuf);
        cgaoe(a);
        return(1);
    }
    if (tageq(dtag, "tq")) {
        a = nxti(dbuf);
        cgtnq(a);
        return(1);
    }
    if (tageq(dtag, "tc")) {
        a = nxti(dbuf);
        b = nxti(dbuf);
        cgtnc(a, b);
        return(1);
    }
    if (tageq(dtag, "te")) {
        a = nxti(dbuf);
        cgtne(a);
        return(1);
    }
    if (tageq(dtag, "ix")) {
        cgidx();
        return(1);
    }
    if (tageq(dtag, "ca")) {
        a = nxti(dbuf);
        cgcae(a);
        return(1);
    }
    if (tageq(dtag, "cac")) {
        a = nxti(dbuf);
        b = nxti(dbuf);
        c = nxti(dbuf);
        cgcaec(a, b, c);
        return(1);
    }
    if (tageq(dtag, "po")) {
        a = nxti(dbuf);
        cgpoi(a);
        return(1);
    }
    if (tageq(dtag, "pi")) {
        a = nxti(dbuf);
        cgpri(a);
        return(1);
    }
    if (tageq(dtag, "vi")) {
        a = nxti(dbuf);
        b = nxti(dbuf);
        cgvini(a, b);
        return(1);
    }
    return(0);
}

disp3() {
    extrn dbuf, dtag, dnm, dsb;
    auto a, b, ld, ln, value, lb, sid, slen, j;
    if (tageq(dtag, "swb")) {
        a = nxti(dbuf);
        if (a < 0) fatal("bad switch label");
        cgswb(a);
        return(1);
    }
    if (tageq(dtag, "swc")) {
        ld = nxti(dbuf);
        ln = nxti(dbuf);
        value = nxti(dbuf);
        lb = nxti(dbuf);
        if (ld < 0 | ln < 0 | lb < 0) fatal("bad switch label");
        cgswc(ld, ln, value, lb);
        return(1);
    }
    if (tageq(dtag, "swx")) {
        a = nxti(dbuf);
        b = nxti(dbuf);
        if (a < 0 | b < 0) fatal("bad switch label");
        cgswe(a, b);
        return(1);
    }
    if (tageq(dtag, "gor")) {
        cggor();
        return(1);
    }
    if (tageq(dtag, "la")) {
        a = nxti(dbuf);
        cgla(a);
        return(1);
    }
    if (tageq(dtag, "lv")) {
        a = nxti(dbuf);
        cglval(a);
        return(1);
    }
    if (tageq(dtag, "gvp")) {
        nxtnam(dbuf, dnm);
        a = nxti(dbuf);
        cggvp(dnm, a);
        return(1);
    }
    if (tageq(dtag, "gvb")) {
        nxtnam(dbuf, dnm);
        a = nxti(dbuf);
        cggvb(dnm, a);
        return(1);
    }
    if (tageq(dtag, "gvc")) {
        a = nxti(dbuf);
        cggvc(a);
        return(1);
    }
    if (tageq(dtag, "gvn")) {
        nxtnam(dbuf, dnm);
        cggvn(dnm);
        return(1);
    }
    if (tageq(dtag, "gvl")) {
        a = nxti(dbuf);
        cggvl(a);
        return(1);
    }
    if (tageq(dtag, "gve")) {
        cggve();
        return(1);
    }
    if (tageq(dtag, "Slit") | tageq(dtag, "Glit")) {
        slen = nxti(dbuf);
        if (slen < 0) fatal("negative literal length");
        if (slen > 256) fatal("literal length too large");
        j = 0;
        while (j < slen) {
            {
                lchar(dsb, j, nxti(dbuf));
                j = j + 1;
            }
        }
        sid = litinl(slen, dsb);
        if (tageq(dtag, "Slit")) cgsta(sid);
        return(1);
    }
    return(0);
}

dispat() {
    extrn adkind, adoff, dnm;
    extrn dbuf, dtag;
    while (1) {
        {
            if (! getln(dbuf, 1040)) {
                adflsh();
                return;
            }
            icrst();
            nxtnam(dbuf, dtag);
            if (adkind) {
                if (tageq(dtag, "dr")) {
                    cglod(adkind, adoff, dnm);
                    adkind = 0;
                    goto cn0;
                }
                adflsh();
            }
            if (disp1()) goto cn0;
            if (disp2()) goto cn0;
            if (disp3()) goto cn0;
            errinit();
            bouts("b1: bad tag '");
            outs(dtag);
            bouts("'*n");
            exit(1);
        }
        cn0:;
    }
}
