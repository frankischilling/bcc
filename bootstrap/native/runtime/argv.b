/* Called at Linux process entry, before a B frame changes the initial stack. */
xargvec(limit){
    extrn xfactive,xrdepth,xrvalid,xrfault;auto base;
    if(xfactive | xrdepth | limit<16 | limit>16777216 | limit%8)xrfail();
    base=xbilabs(4);
    xmov(12,4);xload(13,12,0);xmovim(0,4095);xbin(5,13,0);xcond(7,xrfault);
    xmov(14,13);xmovim(0,1);xbin(0,14,0);xshift(0,14,3);
    xmovim(0,limit);xbin(5,14,0);xcond(7,xrfault);
    /* Anonymous writable memory belongs to this process until exit. */
    xmovim(0,9);xmovim(7,0);xmovim(6,limit);xmovim(2,3);
    xmovim(10,34);xmovim(8,-1);xmovim(9,0);xsys();
    xbin(6,0,0);xcond(8,xrfault);xmov(5,0);
    xmov(15,5);xbin(0,15,14);xlea(14,5,8);xlea(9,5,limit);
    xstore(5,0,13);xmov(3,13);xlea(12,12,8);
    xmark(base);xbin(6,3,3);xcond(4,base+3);
    xload(8,12,0);xbin(6,8,8);xcond(4,xrfault);
    xmov(0,15);xshift(1,0,3);xstore(14,0,0);
    xmark(base+1);xbin(5,15,9);xcond(3,xrfault);
    xloadb(0,8,0);xstoreb(15,0,0);xlea(8,8,1);xlea(15,15,1);
    xbin(6,0,0);xcond(5,base+1);
    xlea(15,15,7);xmovim(0,-8);xbin(2,15,0);
    xlea(12,12,8);xlea(14,14,8);xmovim(0,1);xbin(3,3,0);xbranch(1,base);
    xmark(base+3);xmov(0,5);xshift(1,0,3);xmov(2,13);xrvalid=1;
}
