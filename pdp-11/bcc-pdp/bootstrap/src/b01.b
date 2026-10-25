/* Resolve raw compiler records; byte offsets do not depend on word size. */
dbuf[520]; dtag[5]; dnm[5]; fnsy[5];
pndcls 0; compat 0; nlocs 0; hdrdn 1; infun 0;
ghbuf[1024]; ghlen 0; ghon 0; glits 0;

ghchar(c) {
    extrn ghbuf,ghlen,lchar;
    if(ghlen>=2047) fatal("global records too large");
    lchar(ghbuf,ghlen++,c);lchar(ghbuf,ghlen,0);
}
ghtext(s) {
    extrn char;
    auto i,c;
    i=0;while(c=char(s,i++)) ghchar(c);
}
ghbtext(s) {
    extrn char;
    auto i,c;
    i=0;
    while((c=char(s,i++))!=4) {
        if(c==0) return;
        ghchar(c);
    }
}
ghnum(n) {
    if(n>=10) ghnum(n/10);
    ghchar(n%10+'0');
}
usage() {
    extrn exit;
    errinit();bouts("usage: b01 [-i raw.ic] [-o resolved.ic]*n");exit(1);
}
main() {
    extrn argv,nlab,char,open,creat,close,exit;
    auto i,ifd,ofd,in,out,done,p;
    nlab=30000;i=2;in=0;out=0;done=0;
    while(i<=argv[0]) {
        p=argv[i];
        if(char(p,0)=='-') if(char(p,1)=='s') if(char(p,2)==0) goto isdone;
        if(char(p,0)=='-') if(char(p,1)=='i') if(char(p,2)==0) goto isi;
        if(char(p,0)=='-') if(char(p,1)=='o') if(char(p,2)==0) goto iso;
        usage();
     isi:
        if(++i>argv[0]) usage();
        in=argv[i];goto nxt;
     iso:
        if(++i>argv[0]) usage();
        out=argv[i];goto nxt;
     isdone:
        if(++i>argv[0]) usage();
        done=argv[i];
     nxt:
        i++;
    }
    ifd=0;ofd=1;
    if(in) {ifd=open(in,0);if(ifd<0) fatal("b01: open");}
    if(out) {ofd=creat(out,016);if(ofd<0) fatal("b01: creat");}
    icini(ifd);outinit(ofd);rewrt();
    if(ofd!=1) if(close(ofd)<0) fatal("cannot close output");
    if(done) markok(done);
    exit(0);
}
cp9(dst,src) {
    extrn char,lchar;
    auto i;
    i=0;while(i<9) {lchar(dst,i,char(src,i));i++;}
}
echoln(buf) {outs(buf);outc('*n');}
emitpr() {
    extrn fnsy,nlocs,hdrdn,infun;
    auto retl;
    if(!infun | hdrdn) return;
    retl=newl();bouts("pr ");outs(fnsy);outc(' ');
    outd(nlocs);outc(' ');outd(retl);outc('*n');hdrdn=1;
}
regsym(name,cls,off) {
    extrn scls,soff;
    auto sid;
    sid=symfnd(name);
    if(sid<0) return(symadd(name,cls,off));
    scls[sid]=cls;soff[sid]=off;return(sid);
}
symloc(name) {
    extrn compat,infun,fnst,fnsy;
    auto sid;
    sid=symfnd(name);
    if(!compat) if(infun) if(sid<fnst)
        if(!nameat(name,0,fnsy)) return(-1);
    return(sid);
}
regext(name) {
    extrn scls,compat,infun,fnst;
    auto sid,cls;
    sid=symfnd(name);
    if(sid<0) return(symadd(name,3,0));
    if(!compat) if(infun) {
        if(sid<fnst) return(symadd(name,3,0));
        if(scls[sid]!=3) fatal("external declaration follows internal use");
    }
    cls=scls[sid];
    if(cls==4 | cls==7) return(sid);
    scls[sid]=3;return(sid);
}
rrname(name) {
    extrn scls,soff,pndcls;
    auto sid;
    sid=symloc(name);
    if(sid<0) sid=symadd(name,5,newl());
    pndcls=scls[sid];
    if(pndcls==5 | pndcls==8) {
        bouts("la ");outd(soff[sid]);outc('*n');return;
    }
    if(pndcls==6 | pndcls==1) {
        bouts("lc ");outd(soff[sid]);outc('*n');return;
    }
    if(pndcls==2) {
        bouts("ar ");outd(soff[sid]);outc('*n');return;
    }
    bouts("ex ");outs(name);outc('*n');
}
rrderef() {bouts("dr*n");}
rrlbl(name) {rrname(name);rrderef();bouts("gor*n");}
rrdef(name) {
    extrn scls,soff;
    auto sid;
    sid=symloc(name);
    if(sid<0) sid=symadd(name,5,newl());
    if(scls[sid]==8) fatal("duplicate label");
    if(scls[sid]!=5) fatal("label name collision");
    scls[sid]=8;bouts("lb ");outd(soff[sid]);outc('*n');
}
rewrt() {
    extrn dbuf,dtag,dnm,fnsy,nlocs,hdrdn,pndcls,lchar;
    extrn infun,fnst,nsy,scls,soff,ghbuf,ghlen,ghon,glits,compat;
    auto idx,sz,base,sid;
    while(getln(dbuf,1040)) {
        icrst();nxtnam(dbuf,dtag);
        if(tageq(dtag,"Acompat")) {compat=1;goto nextrec;}
        if(tageq(dtag,"Gstr")) {
            if(!ghon) fatal("literal outside global definition");
            lchar(dbuf,1,'l');lchar(dbuf,2,'i');lchar(dbuf,3,'t');
            echoln(dbuf);
            ghbtext("gvl ");ghnum(glits);ghchar('*n');
            glits++;goto nextrec;
        }
        if(tageq(dtag,"Slit")) glits++;
        if(tageq(dtag,"gvc") | tageq(dtag,"gvn")) {
            if(!ghon) fatal("initializer outside definition");
            ghtext(dbuf);ghchar('*n');goto nextrec;
        }
        if(tageq(dtag,"gve")) {
            if(!ghon) fatal("global end without definition");
            outs(ghbuf);echoln(dbuf);ghon=0;goto nextrec;
        }
        if(tageq(dtag,"Adef")) {
            nxtnam(dbuf,dnm);cp9(fnsy,dnm);regsym(dnm,4,0);
            fnst=nsy;nlocs=0;hdrdn=0;infun=1;pndcls=0;
            emitpr();goto nextrec;
        }
        if(tageq(dtag,"Aauto")) {
            nxtnam(dbuf,dnm);
            if(symfnd(dnm)>=fnst) fatal("duplicate local name");
            if(nlocs>=8191) fatal("auto frame too large");
            symadd(dnm,1,nlocs);nlocs++;goto nextrec;
        }
        if(tageq(dtag,"Avec")) {
            nxtnam(dbuf,dnm);sz=nxti(dbuf);sid=symfnd(dnm);
            if(sid<0) fatal("Avec without Aauto");
            scls[sid]=6;base=soff[sid];
            if(sz<1 | sz>8191) fatal("bad auto size");
            if(base>8191-sz) fatal("auto frame too large");
            nlocs=base+sz;bouts("vi ");outd(base);outc(' ');
            outd(base+sz-1);outc('*n');goto nextrec;
        }
        if(tageq(dtag,"Aarg")) {
            nxtnam(dbuf,dnm);idx=nxti(dbuf);
            if(symfnd(dnm)>=fnst) fatal("duplicate parameter");
            symadd(dnm,2,idx);goto nextrec;
        }
        if(tageq(dtag,"Aextrn")) {nxtnam(dbuf,dnm);regext(dnm);goto nextrec;}
        if(tageq(dtag,"Agvec")) {nxtnam(dbuf,dnm);regsym(dnm,7,0);goto nextrec;}
        if(tageq(dtag,"Aend")) {
            sid=fnst;
            while(sid<nsy) {if(scls[sid]==5) fatal("undefined internal label");sid++;}
            emitpr();bouts("ep ");outd(nlocs);outc('*n');sid=fnst;
            while(sid<nsy) {
                if(scls[sid]==8) {bouts("lv ");outd(soff[sid]);outc('*n');}
                sid++;
            }
            symtrn();hdrdn=1;infun=0;pndcls=0;goto nextrec;
        }
        if(infun) emitpr();
        if(tageq(dtag,"Rname") | tageq(dtag,"Rcall")) {
            nxtnam(dbuf,dnm);
            if(tageq(dtag,"Rcall")) if(symloc(dnm)<0) regext(dnm);
            rrname(dnm);goto nextrec;
        }
        if(tageq(dtag,"Rderef")) {rrderef();pndcls=0;goto nextrec;}
        if(tageq(dtag,"Rlbl")) {nxtnam(dbuf,dnm);rrlbl(dnm);pndcls=0;goto nextrec;}
        if(tageq(dtag,"Rdef")) {nxtnam(dbuf,dnm);rrdef(dnm);pndcls=0;goto nextrec;}
        if(tageq(dtag,"gvb") | tageq(dtag,"gvp")) {
            nxtnam(dbuf,dnm);idx=nxti(dbuf);
            if(symfnd(dnm)<0) symadd(dnm,3,0);
            if(ghon) fatal("nested global definition");
            ghon=1;ghlen=0;ghtext(dbuf);ghchar('*n');pndcls=0;goto nextrec;
        }
        pndcls=0;echoln(dbuf);
     nextrec:;
    }
    if(ghon) fatal("unfinished global definition");
}
