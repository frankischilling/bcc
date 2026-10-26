/* B call blocks contain the actual count followed by contiguous argument cells. */
xfactive 0;xfparams 0;
xfpro(id,params,locals) {
    extrn xfactive,xfparams,xrdepth;
    if(xfactive | xrdepth | params<0 | params>32767) xrfail();
    xlid(id);while(xtell()&7)xbyte(144);
    xnum(params,8);xmark(id);xfactive=1;xfparams=params;xmframe(locals);
}
xfarg(index) {
    extrn xfactive,xfparams,xrvalid;
    if(!xfactive | index<0 | index>=xfparams)xrfail();
    xlea(0,5,24+index*8);xshift(1,0,3);xrvalid=1;
}
xfargc(){extrn xfactive,xrvalid;if(!xfactive)xrfail();xload(0,5,16);xrvalid=1;}
xfend(){
    extrn xfactive,xrdepth,xrvalid;
    if(!xfactive | xrdepth | !xrvalid)xrfail();
    xmleave();xret();xfactive=0;xrvalid=0;
}
xcall(n) {
    extrn xrdepth,xrvalid,xrfault;
    auto base,i;
    if(n<0 | n>4095 | xrdepth<n+1 | xrvalid)xrfail();
    /* Validate the header before borrowing RBX or allocating another block. */
    xload(10,4,n*8);xbin(6,10,10);xcond(4,xrfault);
    xload(2,10,-8);xmovim(0,0);xbin(5,2,0);xcond(12,xrfault);
    xmovim(0,32767);xbin(5,2,0);xcond(15,xrfault);
    xstack(0,3);xmov(3,4);
    i=n;if(i<1)i=1;xmovim(8,i);xbin(5,2,8);xjcc(14,3);base=xtell();xmov(8,2);if(xtell()!=base+3)xrfail();
    xmov(2,8);xmovim(1,1);xbin(0,2,1);xshift(0,2,3);xbin(3,4,2);
    xmovim(0,n);xstore(4,0,0);
    i=0;while(i<n){xload(0,3,8*(n-i));xstore(4,8*(i+1),0);i++;}
    xbin(0,2,4);xlea(9,4,8*(n+1));xmovim(0,0);xmovim(1,8);
    /* These fixed-size local branches do not consume global label slots. */
    base=xtell();xbin(5,9,2);xjcc(13,15);i=xtell();
    xstore(9,0,0);xbin(0,9,1);xrel(1,base-xtell()-5);
    if(xtell()!=i+15)xrfail();
    xjump(0,10);
    xmov(4,3);xstack(1,3);xmovim(2,8*(n+1));xbin(0,4,2);
    xrdepth=xrdepth-n-1;xrvalid=1;
}
xfline(buf){
    auto tag 5,n;icrst();nxtnam(buf,tag);
    if(tageq(tag,"ar")){n=nxti(buf);xrend(buf);xfarg(n);return(1);}
    if(tageq(tag,"cl")){n=nxti(buf);xrend(buf);xcall(n);return(1);}
    return(0);
}
