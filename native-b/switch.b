/* Only the dispatch chain carries a selector on the runtime stack. */
xswchain[16]; xswcases[16]; xswdepth;
xswbeg() {extrn xswdepth;xswdepth=0;}
xswend() {extrn xswdepth;if(xswdepth)xrfail();}
xswline(buf) {
    extrn xswchain,xswcases,xswdepth,xrdepth,xrvalid;
    auto tag 5,a,b,value,body,top;
    icrst();nxtnam(buf,tag);
    if(tageq(tag,"swb")) {
        a=xcfmap(nxti(buf),4,0);xrend(buf);
        if(!xrvalid | xrdepth | xswdepth>=16)xrfail();
        xswchain[xswdepth]=a;xswcases[xswdepth++]=0;
        xstack(0,0);xbranch(1,a);xrvalid=0;return(1);
    }
    if(tageq(tag,"swc")) {
        a=xcfmap(nxti(buf),4,0);b=xcfmap(nxti(buf),4,0);
        value=xrnum(buf);body=xcfmap(nxti(buf),1,0);xrend(buf);
        if(xrdepth | xswdepth<=0 | a==b)xrfail();top=xswdepth-1;
        if(xswchain[top]!=a | xswcases[top]>=32)xrfail();
        xswchain[top]=b;xswcases[top]++;
        xbranch(1,body);xmark(a);xload(0,4,0);xmovim(1,value);
        xbin(5,0,1);xcond(5,b);xstack(1,0);xmark(body);
        xrvalid=0;return(1);
    }
    if(tageq(tag,"swx")) {
        a=xcfmap(nxti(buf),4,0);b=xcfmap(nxti(buf),1,0);xrend(buf);
        if(xrdepth | xswdepth<=0)xrfail();
        if(xswchain[xswdepth-1]!=a)xrfail();xswdepth--;
        xbranch(1,b);xmark(a);xstack(1,0);xmark(b);
        xrvalid=0;return(1);
    }
    return(0);
}
