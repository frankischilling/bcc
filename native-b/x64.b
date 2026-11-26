/* Small x86-64 encoding library for the B native backend. Register IDs are 0..15. */
xbuf[128]; xpos; xfd; xtotal;
xops[] 1,9,33,41,49,57,133;
xshifts[] 4,5,7;

xfail() {extrn write,exit;write(2,"x64: invalid operand or I/O failure*n",36);exit(1);}
xflush() {
    extrn write,xbuf,xpos,xfd;
    if(xpos) if(write(xfd,xbuf,xpos)!=xpos) xfail();
    xpos=0;
}
xbyte(v) {
    extrn xbuf,xpos,xtotal,lchar;
    lchar(xbuf,xpos++,v);xtotal++;
    if(xpos==512) xflush();
}
xnum(v,n) {while(n) {xbyte(v&255);v=v>>8;n--;}}
xstart(fd) {
    extrn xfd,xpos,xtotal;
    if(fd<0|fd>2147483647|65535+1==0|2147483647+1<0) xfail();
    xfd=fd;xpos=0;xtotal=0;
}
xtell() {extrn xtotal;return(xtotal);}
xfinish() {extrn xfd,close;xflush();if(close(xfd)<0) xfail();}
xreg(r) {if(r<0|r>15) xfail();}
xdisp(d) {if(d<(-2147483647-1)|d>2147483647) xfail();}
xrex(w,r,b) {xbyte(64+w*8+(r>>3)*4+(b>>3));}
xmod(r,b) {xbyte(192+(r&7)*8+(b&7));}
xmem(r,b,d) {
    xbyte(128+(r&7)*8+(b&7));
    if((b&7)==4) xbyte(36);
    xnum(d,4);
}
xmovim(r,v) {xreg(r);xrex(1,0,r);xbyte(184+(r&7));xnum(v,8);}
xmov(d,s) {xreg(d);xreg(s);xrex(1,s,d);xbyte(137);xmod(s,d);}
xload(d,b,off) {xreg(d);xreg(b);xdisp(off);xrex(1,d,b);xbyte(139);xmem(d,b,off);}
xstore(b,off,s) {xreg(b);xreg(s);xdisp(off);xrex(1,s,b);xbyte(137);xmem(s,b,off);}
xlea(d,b,off) {xreg(d);xreg(b);xdisp(off);xrex(1,d,b);xbyte(141);xmem(d,b,off);}
xloadb(d,b,off) {
    xreg(d);xreg(b);xdisp(off);xrex(1,d,b);xbyte(15);xbyte(182);xmem(d,b,off);
}
xstoreb(b,off,s) {
    xreg(b);xreg(s);xdisp(off);
    if(s>=4|b>=8) xrex(0,s,b);
    xbyte(136);xmem(s,b,off);
}
/* add, or, and, sub, xor, cmp, test */
xbin(kind,d,s) {
    extrn xops;
    xreg(d);xreg(s);if(kind<0|kind>6) xfail();
    xrex(1,s,d);xbyte(xops[kind]);xmod(s,d);
}
xmul(d,s) {xreg(d);xreg(s);xrex(1,d,s);xbyte(15);xbyte(175);xmod(d,s);}
/* not, neg, idiv; division uses the processor's RDX:RAX pair. */
xunary(kind,r) {
    auto group;
    xreg(r);if(kind<0|kind>2) xfail();
    group=kind+2;if(kind==2) group=7;
    xrex(1,0,r);xbyte(247);xmod(group,r);
}
/* shl, shr, sar; immediate counts follow the processor's count masking. */
xshift(kind,r,count) {
    extrn xshifts;
    xreg(r);if(kind<0|kind>2|count<0|count>255) xfail();
    xrex(1,0,r);
    if(count==1) {xbyte(209);xmod(xshifts[kind],r);return;}
    xbyte(193);xmod(xshifts[kind],r);xbyte(count);
}
xshiftc(kind,r) {
    extrn xshifts;
    xreg(r);if(kind<0|kind>2) xfail();
    xrex(1,0,r);xbyte(211);xmod(xshifts[kind],r);
}
/* push or pop */
xstack(kind,r) {
    xreg(r);if(kind<0|kind>1) xfail();
    if(r>=8) xrex(0,0,r);
    xbyte(80+kind*8+(r&7));
}
/* indirect call or jump */
xjump(kind,r) {
    xreg(r);if(kind<0|kind>1) xfail();
    if(r>=8) xrex(0,0,r);
    xbyte(255);xmod(2+kind*2,r);
}
/* relative call or jump; displacement starts at the end of this instruction. */
xrel(kind,d) {
    xdisp(d);if(kind<0|kind>1) xfail();
    xbyte(232+kind);xnum(d,4);
}
xjcc(cond,d) {
    xdisp(d);if(cond<0|cond>15) xfail();
    xbyte(15);xbyte(128+cond);xnum(d,4);
}
xset(cond,r) {
    xreg(r);if(cond<0|cond>15) xfail();
    if(r>=4) xrex(0,0,r);
    xbyte(15);xbyte(144+cond);xmod(0,r);
}
xmovzx(d,s) {xreg(d);xreg(s);xrex(1,d,s);xbyte(15);xbyte(182);xmod(d,s);}
xcqo() {xbyte(72);xbyte(153);}
xret() {xbyte(195);}
xsys() {xbyte(15);xbyte(5);}
