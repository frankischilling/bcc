/* Emit switches, writable label cells, globals and collision-free names. */
cgswb(ldisp) {
    eop("mov*tr0, -(sp)");
    bouts("*tjmp*t");lpref();
    outd(ldisp);
    outc('*n');
}

cgswc(ldisp, lnext, value, lbody) {
    cgjmp(lbody);
    cglab(ldisp);
    bouts("*tcmp*t(sp), $");
    outd(value);
    bouts(".*n");
    eop("beq*t1f");
    cgjmp(lnext);
    bouts("1:*n");
    eop("tst*t(sp)+");
    cglab(lbody);
}

cgswe(last, lend) {
    cgjmp(lend);
    cglab(last);
    eop("tst*t(sp)+");
    cglab(lend);
}

cggor() {
    eop("jmp*t(r0)");
}

cgla(lid) {
    bouts("*tmov*t$");lpref();
    outd(lid);
    bouts("v, r0*n");
    eop("clc");
    eop("ror*tr0");
}

cglval(lid) {
    lpref();
    outd(lid);
    bouts("v:*t");lpref();
    outd(lid);
    outc('*n');
}
gvnstor 0; gvinit 0;
cggvb(name, n) {
    extrn gvnstor, gvinit;
    gvnstor = n;
    gvinit = 0;
    bouts("*n.text*n*t.globl*t");
    cgsym(name);
    outc('*n');
    cgsym(name);
    bouts(":*n");
}

cggvc(v) {
    extrn gvinit;
    outc('*t');
    outd(v);
    bouts(".*n");
    gvinit = gvinit + 1;
}

cggvn(name) {
    extrn gvinit;
    bouts("*t[");
    cgsym(name);
    bouts("-start+40014]\/2*n");
    gvinit = gvinit + 1;
}

cggvl(id) {
    extrn gvinit, nstr;
    if (id < 0 | id >= nstr) fatal("bad literal reference");
    bouts("*t[");spref();
    outd(id);
    bouts("-start+40014]\/2*n");
    gvinit = gvinit + 1;
}

cggve() {
    extrn gvnstor, gvinit;
    auto count;
    while (gvinit < gvnstor) {
        {
            count = gvnstor - gvinit;
            if (count > 8191) count = 8191;
            bouts("*t.=.+");
            outd(count * 2);
            bouts(".*n");
            gvinit = gvinit + count;
        }
    }
    bouts("*t.even*n");
}

cggvp(name, n) {
    cggvb(name, n);
    bouts("*t[.+2-start+40014]\/2*n");
}
snames [900]; nsname 0; libmod 0;
cgsym(name) {
    extrn snames, nsname, libmod;
    auto n, i, idx, base, safe;
    n = 0;
    safe = 1;
    while (char(name, n)) {
        {
            if (char(name, n) >= 'A') if (char(name, n) <= 'Z') safe = 0;
            if (char(name, n) == 8) safe = 0;
            n = n + 1;
        }
    }
    if (n == 0) fatal("empty external name");
    if (n > 8) fatal("external name too long");
    if (n > 6) safe = 0;
    if (tageq(name, "putchar")) safe = 1;
    if (tageq(name, "getchar")) safe = 1;
    if (tageq(name, "putcha")) safe = 0;
    if (tageq(name, "getcha")) safe = 0;
    if (safe) {
        outc('_');
        outs(name);
        return;
    }
    idx = 0;
    while (idx < nsname) {
        {
            base = idx * 9;
            if (snmatch(base, name)) goto emit;
            idx = idx + 1;
        }
    }
    if (nsname >= 200) fatal("external name table full");
    base = idx * 9;
    i = 0;
    while (i < n) {
        {
            lchar(snames, base + i, char(name, i));
            i = i + 1;
        }
    }
    lchar(snames, base + n, 0);
    nsname = nsname + 1;
    emit:
    if (libmod) outc('J'); else outc('K');
    outd(idx);
}

snmatch(base,name) {
    extrn snames,char;
    auto i,c;
    i=0;
    while (1) {
        c=char(snames,base+i);
        if (c!=char(name,i)) return(0);
        if (!c) return(1);
        i++;
    }
}
