/* Pack target words explicitly, even when the seed uses wider B cells. */
obuf[64]; opos 0;
oflush() {
    extrn outfd,obuf,opos,write;
    if(opos) if(write(outfd,obuf,opos)!=opos) fatal("cannot write image");
    opos=0;
}
e0(value) {
    extrn phase,cp,obuf,opos,lchar;
    if(cp>=32700) fatal("code exceeds VM range");
    if(phase==3) {
        lchar(obuf,opos,value&255);lchar(obuf,opos+1,value>>8);
        opos=+2;if(opos==128) oflush();
    }
    cp++;
}
e1(op,a) {e0(op);e0(a);}
e2(op,a,b) {e0(op);e0(a);e0(b);}
number(v) {e1(1,v);}
load(at) {e1(2,at);}
store(at) {e1(3,at);}
jump(id) {e1(6,labval(id));}
branch(id) {e1(7,labval(id));}
call0(target) {number(target);e0(8);e1(10,0);}
argbyte(cell) {
    number(32714);e0(8);load(3);e0(8);load(cell);e0(8);e1(10,2);
}
bootcode() {
    extrn ownargv,soff,scode;
    auto s;
    call0(32713);store(2);
    number(32715);e0(8);load(2);e1(4,1);e0(8);e1(10,1);store(1);branch(-7);
    load(1);e0(8);load(2);e0(16);
    s=symlit("argv");if(s>=0) if(!ownargv) {load(1);store(soff[s]);}
    number(0);store(3);
    label(-1);
    load(3);e0(8);load(2);e1(9,60);branch(-6);
    number(0);store(4);
    label(-2);
    argbyte(4);branch(-3);
    load(4);e1(4,1);store(4);jump(-2);
    label(-3);
    number(32715);e0(8);load(4);e1(4,2);e0(8);number(2);e1(9,47);
    e0(8);e1(10,1);store(5);branch(-7);
    load(1);e0(8);load(3);e1(4,1);e1(9,43);e0(8);load(5);e0(16);
    number(0);store(6);
    label(-4);
    argbyte(6);store(7);
    number(32707);e0(8);load(5);e0(8);load(6);e0(8);load(7);e0(8);e1(10,3);
    load(7);branch(-5);
    load(6);e1(4,1);store(6);jump(-4);
    label(-5);
    load(3);e1(4,1);store(3);jump(-1);
    label(-6);
    s=symlit("main");number(scode[s]);e0(8);load(2);e0(8);load(1);e1(4,1);e0(8);e1(10,2);e0(0);
    label(-7);number(1);e0(0);
}
dataemit() {
    extrn dbuf,dtag,dnm,soff,ssize,scode,scls,nsy,lcell,lpc;
    extrn litaddr,nlits,dsize,cp,close,firstch;
    auto fd,s,n,i,c,low,used;
    fd=reopen();s= -1;used=0;
    while(nextrec()) {
        if(firstch!='g' & firstch!='p' & firstch!='S' & firstch!='G' & firstch!='l') goto next;
        if(firstch=='p') if(!tageq(dtag,"pr")) goto next;
        if(firstch=='l') if(!tageq(dtag,"lv")) goto next;
        if(tageq(dtag,"pr")) {
            nxtnam(dbuf,dnm);i=symfnd(dnm);e0(scode[i]);goto next;
        }
        if(tageq(dtag,"gvb") | tageq(dtag,"gvp")) {
            nxtnam(dbuf,dnm);s=symfnd(dnm);used=0;
            if(tageq(dtag,"gvp")) {e0(soff[s]+1);used++;}
            goto next;
        }
        if(tageq(dtag,"gvc")) {e0(nxti(dbuf));used++;goto next;}
        if(tageq(dtag,"gvn")) {
            nxtnam(dbuf,dnm);i=symfnd(dnm);e0(soff[i]);used++;goto next;
        }
        if(tageq(dtag,"gvl")) {
            i=nxti(dbuf);if(i<0 | i>=nlits) fatal("invalid literal reference");
            e0(litaddr[i]);used++;goto next;
        }
        if(tageq(dtag,"gve")) {
            while(used<ssize[s]) {e0(0);used++;}
            s= -1;goto next;
        }
        if(tageq(dtag,"Slit") | tageq(dtag,"Glit")) {
            n=nxti(dbuf);i=0;low=0;
            while(i<n) {
                c=nxti(dbuf)&255;
                if(i&1) e0(low|(c<<8));else low=c;
                i++;
            }
            if(n&1) e0(low);
            goto next;
        }
        if(tageq(dtag,"lv")) {i=findlab(nxti(dbuf));e0(lpc[i]);}
     next:;
    }
    if(close(fd)<0) fatal("input close failed");
    i=0;
    while(i<nsy) {if(scls[i]==4 | scls[i]==5) e0(scode[i]);i++;}
    if(cp!=dsize-11) fatal("data layout changed");
}
