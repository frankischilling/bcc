/* Emit only after layout and code labels are known. Descriptors stay open. */
xdout[512]; xdused; xdwrote; xdfd; xdbase;
xdflush() {
    extrn xdout,xdused,xdfd,write;
    if(xdused)if(write(xdfd,xdout,xdused)!=xdused)fatal("native data: write failed");
    xdused=0;
}
xdbyte(v) {
    extrn xdout,xdused,xdwrote,lchar;
    if(xdwrote>=16777216)xdfail();
    lchar(xdout,xdused++,v);xdwrote++;if(xdused==4096)xdflush();
}
xdword(v) {auto i;i=0;while(i<8){xdbyte(v&255);v=v>>8;i++;}}
xdaddr(name) {
    extrn xdoffs,xdbase;auto s;s=xdfind(name);
    if(s<0)fatal("native data: unresolved symbol");return(xdbase/8+xdoffs[s]);
}
xdlit(n) {
    extrn xdlits,xdladdr,xdbase;
    if(n<0 | n>=xdlits)fatal("native data: unknown literal");
    return(xdbase/8+xdladdr[n]);
}
xdemit(fd,out,base,entry,label) {
    extrn xdused,xdwrote,xdfd,xdbase,xdbuf,xdwords,xdcount;
    extrn xdoffs,xdsizes,xdkinds,xdlits,xdladdr,xdlens,xdcells,xdcoffs;
    auto tag 5,name 5,kind,count,init,values 128,slot,lit,n,i,v,seen,cseen;
    if(base<0 | base%8 | base>9223372036837998592)xdfail();
    xdbase=base;xdfd=out;xdused=0;xdwrote=0;
    kind=0;slot= -1;lit=0;seen=0;cseen=0;icini(fd);
    while(getln(xdbuf,1040)) {
        icrst();nxtnam(xdbuf,tag);
        if(tageq(tag,"gvb") | tageq(tag,"gvp")) {
            if(kind)xdfail();nxtnam(xdbuf,name);slot=xdfind(name);
            count=nxti(xdbuf);xrend(xdbuf);kind=1;if(tageq(tag,"gvp"))kind=2;
            if(slot<0)xdfail();if(xdkinds[slot]!=kind)xdfail();init=0;goto next;
        }
        if(tageq(tag,"gvc") | tageq(tag,"gvn") | tageq(tag,"gvl")) {
            if(!kind | init>=128)xdfail();
            if(tageq(tag,"gvc"))v=xrnum(xdbuf);
            if(tageq(tag,"gvn")){nxtnam(xdbuf,name);v=xdaddr(name);}
            if(tageq(tag,"gvl"))v=xdlit(nxti(xdbuf));
            xrend(xdbuf);values[init++]=v;goto next;
        }
        if(tageq(tag,"gve")) {
            if(!kind)xdfail();xrend(xdbuf);n=count;if(init>n)n=init;
            if(kind==1 & n==0)n=1;
            if(xdsizes[slot]!=n+(kind==2) | xdwrote/8!=xdoffs[slot])xdfail();
            if(kind==2)xdword(xdbase/8+xdoffs[slot]+1);
            i=0;while(i<n){v=0;if(i<init)v=values[i];xdword(v);i++;}
            kind=0;seen++;goto next;
        }
        if(tageq(tag,"pr")) {
            if(kind)xdfail();nxtnam(xdbuf,name);slot=xdfind(name);
            if(slot<0)xdfail();
            if(xdkinds[slot]!=3 | xdwrote/8!=xdoffs[slot])xdfail();
            v=entry(name);if(v<=0)xdfail();xdword(v);seen++;goto next;
        }
        if(tageq(tag,"Slit") | tageq(tag,"Glit")) {
            if(kind | lit>=xdlits)xdfail();n=nxti(xdbuf);
            if(n!=xdlens[lit] | xdwrote/8!=xdladdr[lit])xdfail();
            i=0;while(i<n){v=nxti(xdbuf);if(v<0 | v>255)xdfail();xdbyte(v);i++;}
            if(v!=4)xdfail();xrend(xdbuf);while(xdwrote%8)xdbyte(0);
            lit++;goto next;
        }
        if(tageq(tag,"lv")) {
            if(kind | !label)xdfail();n=nxti(xdbuf);xrend(xdbuf);slot=xdclfind(n);
            if(slot<0)xdfail();if(xdwrote/8!=xdcoffs[slot])xdfail();
            v=label(n);if(v<=0)xdfail();xdword(v);cseen++;goto next;
        }
     next:;
    }
    if(kind | lit!=xdlits | seen!=xdcount | cseen!=xdcells | xdwrote!=xdwords*8)xdfail();
    xdflush();return(xdwrote);
}
