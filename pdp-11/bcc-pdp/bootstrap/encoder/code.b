fnidx -1; retid 0; litno 0; pending 0; paddr 0;
boolout(no,end) {
    branch(no);number(1);jump(end);label(no);number(0);label(end);
}
codeone() {
    extrn dbuf,dtag,dnm,fnidx,retid,ssize,scode,soff,cp,phase,pending,paddr;
    auto a,b,s;
    if(tageq(dtag,"ex")) {nxtnam(dbuf,dnm);s=symfnd(dnm);paddr=soff[s];pending=1;return(1);}
    if(tageq(dtag,"n")) {number(nxti(dbuf));return(1);}
    if(tageq(dtag,"ps")) {e0(8);return(1);}
    if(tageq(dtag,"lc")) {e1(13,nxti(dbuf));return(1);}
    if(tageq(dtag,"dr")) {e0(15);return(1);}
    if(tageq(dtag,"cl")) {e1(10,nxti(dbuf));return(1);}
    if(tageq(dtag,"ar")) {e1(14,nxti(dbuf));return(1);}
    if(tageq(dtag,"bin")) {e1(9,nxti(dbuf));return(1);}
    if(tageq(dtag,"bf")) {branch(nxti(dbuf));return(1);}
    if(tageq(dtag,"lb")) {label(nxti(dbuf));return(1);}
    if(tageq(dtag,"jm")) {jump(nxti(dbuf));return(1);}
    if(tageq(dtag,"as")) {e0(16);return(1);}
    if(tageq(dtag,"rt")) {if(fnidx<0) fatal("return outside function");jump(retid);return(1);}
    if(tageq(dtag,"pr")) {
        if(fnidx>=0) fatal("nested function");
        nxtnam(dbuf,dnm);fnidx=symfnd(dnm);a=nxti(dbuf);retid=nxti(dbuf);
        if(phase==2) scode[fnidx]=cp;
        else if(scode[fnidx]!=cp) fatal("function layout changed");
        e1(11,ssize[fnidx]);return(1);
    }
    if(tageq(dtag,"ep")) {
        if(fnidx<0) fatal("epilogue outside function");
        label(retid);e0(12);fnidx= -1;return(1);
    }
    if(tageq(dtag,"gor")) {e0(17);return(1);}
    if(tageq(dtag,"ix")) {e1(9,43);return(1);}
    return(0);
}
codetwo() {
    extrn dbuf,dtag,lcell;
    auto a,b,c,i;
    if(tageq(dtag,"binc") | tageq(dtag,"cac")) {
        a=nxti(dbuf);b=nxti(dbuf);c=nxti(dbuf);
        i=9;if(tageq(dtag,"cac")) i=21;
        e1(i,a);boolout(b,c);return(1);
    }
    if(tageq(dtag,"uo")) {e1(18,nxti(dbuf));return(1);}
    if(tageq(dtag,"uon")) {
        a=nxti(dbuf);b=nxti(dbuf);e1(18,33);boolout(a,b);return(1);
    }
    if(tageq(dtag,"po") | tageq(dtag,"pi")) {
        a=nxti(dbuf);b=1;if(!a) b= -1;
        i=19;if(tageq(dtag,"pi")) i=20;
        e1(i,b);return(1);
    }
    if(tageq(dtag,"vi")) {a=nxti(dbuf);b=nxti(dbuf);e2(22,a,b);return(1);}
    if(tageq(dtag,"ca")) {e1(21,nxti(dbuf));return(1);}
    if(tageq(dtag,"la")) {
        i=findlab(nxti(dbuf));if(!lcell[i]) fatal("missing label cell");
        number(lcell[i]);return(1);
    }
    return(0);
}
codethr() {
    extrn dbuf,dtag,litaddr,litno,nlits,cp;
    auto a,b,c,d;
    if(tageq(dtag,"tq")) {branch(nxti(dbuf));return(1);}
    if(tageq(dtag,"tc")) {a=nxti(dbuf);b=nxti(dbuf);jump(b);label(a);return(1);}
    if(tageq(dtag,"te") | tageq(dtag,"aoe")) {label(nxti(dbuf));return(1);}
    if(tageq(dtag,"ao")) {
        a=nxti(dbuf);b=nxti(dbuf);
        if(a) branch(b);else {e1(7,cp+4);jump(b);}
        return(1);
    }
    if(tageq(dtag,"swb")) {e0(8);jump(nxti(dbuf));return(1);}
    if(tageq(dtag,"swc")) {
        a=nxti(dbuf);b=nxti(dbuf);c=nxti(dbuf);d=nxti(dbuf);
        jump(d);label(a);e0(23);e0(8);number(c);e1(9,100);
        branch(b);e0(24);label(d);return(1);
    }
    if(tageq(dtag,"swx")) {
        a=nxti(dbuf);b=nxti(dbuf);jump(b);label(a);e0(24);label(b);return(1);
    }
    if(tageq(dtag,"Slit") | tageq(dtag,"Glit")) {
        if(litno>=nlits) fatal("invalid literal count");
        if(tageq(dtag,"Slit")) number(litaddr[litno]);
        litno++;return(1);
    }
    if(tageq(dtag,"st")) {
        a=nxti(dbuf);if(a<0 | a>=nlits) fatal("invalid literal reference");
        number(litaddr[a]);return(1);
    }
    if(tageq(dtag,"gvb") | tageq(dtag,"gvp") | tageq(dtag,"gvc") | tageq(dtag,"gvn")) return(1);
    if(tageq(dtag,"gvl") | tageq(dtag,"gve") | tageq(dtag,"lv")) return(1);
    return(0);
}
codeemit() {
    extrn fnidx,litno,close,dbuf,dtag,pending,paddr;
    auto fd;
    fd=reopen();fnidx= -1;litno=0;pending=0;
    while(nextrec()) {
        if(pending) {
            pending=0;
            if(tageq(dtag,"dr")) {e1(2,paddr);goto next;}
            number(paddr);
        }
        if(codeone()) goto next;
        if(codetwo()) goto next;
        if(!codethr()) {outs(dbuf);outc('*n');fatal("unsupported record");}
     next:;
    }
    if(pending) {number(paddr);pending=0;}
    if(close(fd)<0) fatal("input close failed");
    if(fnidx>=0) fatal("unfinished function");
}
