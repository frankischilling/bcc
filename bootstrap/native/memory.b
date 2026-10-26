/* Native record offsets count down from the saved frame pointer. */
xmcount;
xmframe(n) {
    extrn xmcount,xrvalid;
    auto i;
    if(n<0 | n>8191) xrfail();xmcount=n;
    xstack(0,5);xmov(5,4);xmovim(2,n*8);xbin(3,4,2);
    xmovim(0,0);i=0;
    while(i<n) {xstore(5,-8*(i+1),0);i++;}
    xrvalid=0;
}
xmleave() {xmov(4,5);xstack(1,5);}
xmoff(i) {extrn xmcount;if(i<0 | i>=xmcount) xrfail();return(-8*(i+1));}
xmaddr(i) {xlea(0,5,xmoff(i));xshift(1,0,3);}
xmstore() {xstack(1,1);xshift(0,1,3);xstore(1,0,0);}
xmline(buf) {
    extrn xrvalid,xrdepth;
    auto tag 5,a,b,op,kind;
    icrst();nxtnam(buf,tag);
    if(tageq(tag,"lc")) {
        a=nxti(buf);xrend(buf);xmaddr(a);xrvalid=1;return(1);
    }
    if(tageq(tag,"vi")) {
        a=nxti(buf);b=nxti(buf);xrend(buf);
        if(a>b) xrfail();xmoff(a);xmaddr(b);
        xstore(5,xmoff(a),0);xrvalid=0;return(1);
    }
    if(tageq(tag,"dr")) {
        xrend(buf);if(!xrvalid) xrfail();
        xshift(0,0,3);xload(0,0,0);return(1);
    }
    if(tageq(tag,"ix") | tageq(tag,"as")) {
        xrend(buf);if(!xrvalid | xrdepth<=0) xrfail();
        if(tageq(tag,"ix")) {xstack(1,1);xbin(0,0,1);}
        else xmstore();
        xrdepth--;return(1);
    }
    if(tageq(tag,"po") | tageq(tag,"pi")) {
        a=nxti(buf);xrend(buf);
        if(!xrvalid | a<0 | a>1) xrfail();
        xmov(1,0);xshift(0,1,3);xload(0,1,0);xmov(2,0);xmovim(8,1);
        kind=3;if(a) kind=0;xbin(kind,2,8);xstore(1,0,2);
        if(tageq(tag,"pi")) xmov(0,2);
        return(1);
    }
    if(tageq(tag,"ca") | tageq(tag,"cac")) {
        op=nxti(buf);
        if(tageq(tag,"cac")) {
            a=nxti(buf);b=nxti(buf);
            if(a<0 | b<0 | a==b) xrfail();
            if(op!=100 & op!=101 & op!=102 & op!=103 & op!='<' & op!='>') xrfail();
        }
        xrend(buf);if(!xrvalid | xrdepth<=0) xrfail();
        /* Preserve the captured address while evaluating the operation. */
        xload(1,4,0);xshift(0,1,3);xload(1,1,0);
        xrapply(op);xmstore();xrdepth--;return(1);
    }
    return(0);
}
