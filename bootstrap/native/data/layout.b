/* Static storage uses eight-byte cells; code entry addresses remain bytes. */
xdnames[5120]; xdoffs[1024]; xdsizes[1024]; xdkinds[1024];
xdcount; xdwords; xdlits; xdladdr[512]; xdlens[512]; xdbuf[520];
xdfail() {fatal("native data: invalid or unsupported layout");}
xdreset() {
    extrn xdcount,xdwords,xdlits;
    if(65535+1==0 | 2147483647+1<0) xdfail();
    xdcount=0;xdwords=0;xdlits=0;
}
xdalloc(n) {
    extrn xdwords;auto old;
    if(n<0 | n>2097152-xdwords) xdfail();
    old=xdwords;xdwords=+n;return(old);
}
xdfind(name) {
    extrn xdnames,xdcount;auto i;
    i=0;while(i<xdcount){if(tageq(xdnames+i*5,name))return(i);i++;}
    return(-1);
}
xddefine(name,kind,size) {
    extrn xdnames,xdcount,xdoffs,xdsizes,xdkinds,char,lchar;
    auto i,slot;
    if(!arname(name) | xdfind(name)>=0 | xdcount>=1024) xdfail();
    slot=xdcount++;i=0;
    while(i<9){lchar(xdnames+slot*5,i,char(name,i));i++;}
    xdoffs[slot]=xdalloc(size);xdsizes[slot]=size;xdkinds[slot]=kind;
    return(slot);
}
/* Other expression records belong to the code pass, not this scanner. */
xdscan(fd) {
    extrn xdbuf,xdlits,xdladdr,xdlens,xdwords;
    auto tag 5,name 5,global 5,kind,count,init,body,n,i,c;
    xdreset();kind=0;body=0;icini(fd);
    while(getln(xdbuf,1040)) {
        icrst();nxtnam(xdbuf,tag);
        if(tageq(tag,"gvb") | tageq(tag,"gvp")) {
            if(kind | body) xdfail();nxtnam(xdbuf,global);
            if(!arname(global)) xdfail();count=nxti(xdbuf);xrend(xdbuf);
            if(count<0 | count>8190) xdfail();
            kind=1;if(tageq(tag,"gvp"))kind=2;init=0;goto next;
        }
        if(tageq(tag,"gvc") | tageq(tag,"gvn") | tageq(tag,"gvl")) {
            if(!kind | init>=128) xdfail();
            if(tageq(tag,"gvc"))n=xrnum(xdbuf);
            if(tageq(tag,"gvn")){nxtnam(xdbuf,name);if(!arname(name))xdfail();}
            if(tageq(tag,"gvl")){n=nxti(xdbuf);if(n<0 | n>=512)xdfail();}
            xrend(xdbuf);init++;goto next;
        }
        if(tageq(tag,"gve")) {
            if(!kind) xdfail();xrend(xdbuf);n=count;if(init>n)n=init;
            if(kind==1 & n==0)n=1;
            xddefine(global,kind,n+(kind==2));kind=0;goto next;
        }
        if(tageq(tag,"pr")) {
            if(kind | body)xdfail();nxtnam(xdbuf,name);
            n=nxti(xdbuf);i=nxti(xdbuf);xrend(xdbuf);
            if(n<0 | i<0)xdfail();xddefine(name,3,1);body=1;goto next;
        }
        if(tageq(tag,"ep")) {
            if(!body | kind)xdfail();n=nxti(xdbuf);xrend(xdbuf);
            if(n<0 | n>8191)xdfail();body=0;goto next;
        }
        if(tageq(tag,"Slit") | tageq(tag,"Glit")) {
            if(kind)xdfail();if(tageq(tag,"Slit") & !body)xdfail();
            n=nxti(xdbuf);if(n<1 | n>256 | xdlits>=512)xdfail();
            i=0;while(i<n){c=nxti(xdbuf);if(c<0 | c>255)xdfail();i++;}
            xrend(xdbuf);if(c!=4)xdfail();
            xdlens[xdlits]=n;xdladdr[xdlits++]=xdalloc((n+7)/8);goto next;
        }
        if(!body | kind)xdfail();
     next:;
    }
    if(kind | body)xdfail();return(xdwords);
}
