/* Lower scalar expression records, keeping their temporary stack balanced. */
xrdepth; xrvalid; xrnext; xrlimit; xrfault;
xrfail() {fatal("x64 scalar: invalid or unsupported records");}
xrinit(base,limit,fail) {
    extrn xrdepth,xrvalid,xrnext,xrlimit,xrfault;
    if(65535+1==0 | 2147483647+1<0) xrfail();
    if(base<0 | limit>4096 | base>=limit) xrfail();
    if(fail<0 | fail>4095) xrfail();
    if(fail>=base & fail<limit) xrfail();
    xrdepth=0;xrvalid=0;xrnext=base;xrlimit=limit;xrfault=fail;
}
/* Accumulate negatively so the minimum signed word never needs negation. */
xrnum(buf) {
    extrn bcur,char;
    auto n,neg,c,d,last;
    skpws(buf);neg=0;
    if(char(buf,bcur)=='-') {neg=1;bcur++;}
    c=char(buf,bcur);if(c<'0' | c>'9') xrfail();
    n=0;last=7;if(neg) last=8;
    while((c=char(buf,bcur))>='0' & c<='9') {
        d=c-'0';
        if(n< -922337203685477580) xrfail();
        if(n== -922337203685477580) if(d>last) xrfail();
        n=n*10-d;bcur++;
    }
    if(c!=0 & c!=' ') xrfail();
    if(neg) return(n);return(-n);
}
xrend(buf) {if(skpws(buf)!=0) xrfail();}
xrline(buf) {
    extrn xrdepth,xrvalid,xrnext,xrlimit,xrfault;
    auto tag 5,op,base,a,b;
    icrst();nxtnam(buf,tag);
    if(tageq(tag,"n")) {
        op=xrnum(buf);xrend(buf);xmovim(0,op);xrvalid=1;return;
    }
    if(tageq(tag,"ps")) {
        xrend(buf);if(!xrvalid | xrdepth>=4096) xrfail();
        xstack(0,0);xrdepth++;xrvalid=0;return;
    }
    if(tageq(tag,"bin") | tageq(tag,"binc")) {
        op=nxti(buf);
        if(tageq(tag,"binc")) {
            a=nxti(buf);b=nxti(buf);
            if(a<0 | b<0 | a==b) xrfail();
            if(op!=100 & op!=101 & op!=102 & op!=103 & op!='<' & op!='>') xrfail();
        }
        xrend(buf);if(!xrvalid | xrdepth<=0) xrfail();
        base=0;
        if(op=='/' | op=='%' | op==104 | op==105) {
            if(xrnext+1>=xrlimit) xrfail();
            base=xrnext;xrnext=xrnext+2;
        }
        xstack(1,1);xrdepth--;xbinary(op,base,xrfault);return;
    }
    if(tageq(tag,"uo") | tageq(tag,"uon")) {
        if(tageq(tag,"uo")) op=nxti(buf);
        else {
            a=nxti(buf);b=nxti(buf);
            if(a<0 | b<0 | a==b) xrfail();op='!';
        }
        xrend(buf);if(!xrvalid) xrfail();xunop(op);return;
    }
    xrfail();
}
xrendex() {
    extrn xrdepth,xrvalid;
    if(xrdepth!=0 | !xrvalid) xrfail();
}
