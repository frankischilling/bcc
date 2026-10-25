/* Static layout and code labels for the experimental B-written encoder. */
ssize[200]; scode[200];
lids[1280]; lpc[1280]; lcell[1280]; nlabels 0;
litaddr[512]; nlits 0; dsize 16;
dbuf[520]; dtag[5]; dnm[5]; gname[5];
phase 0; cp 0; infile 0; ownargv 0; firstch 0;
alloc(n) {
    extrn dsize;
    auto at;
    if(n<0 | n>=8192-dsize) fatal("static data fills VM heap");
    at=dsize;dsize=+n;return(at);
}
refsym(name) {
    auto s;
    s=symfnd(name);if(s<0) s=symadd(name,0,0);return(s);
}
defsym(name,kind,count) {
    extrn scls,soff,ssize;
    auto s;
    s=refsym(name);if(scls[s]) fatal("duplicate external");
    scls[s]=kind;soff[s]=alloc(count);ssize[s]=count;
    return(s);
}
/* Keys are shifted away from zero, the empty-slot marker. */
findlab(id) {
    extrn lids,lpc,lcell,nlabels;
    auto i,key,first;
    if(id< -7) fatal("bad code label");
    if(id<0) i=(id&32767)%1280;
    else {
        i=id>>5;key=id|i;first=id&i;
        i=((key&(-1-first))&32767)%1280;
    }
    key=id+8;first=i;
    while(lids[i]) {
        if(lids[i]==key) return(i);
        i=(i+1)%1280;
        if(i==first) fatal("too many code labels");
    }
    if(nlabels>=1280) fatal("too many code labels");
    lids[i]=key;lpc[i]= -1;lcell[i]=0;nlabels++;
    return(i);
}
labval(id) {
    extrn lpc,phase;
    auto i;
    i=findlab(id);
    if(lpc[i]<0) {if(phase==3) fatal("undefined code label");return(0);}
    return(lpc[i]);
}
label(id) {
    extrn lpc,phase,cp;
    auto i;
    i=findlab(id);
    if(phase==2) {
        if(lpc[i]>=0) fatal("duplicate code label");
        lpc[i]=cp;return;
    }
    if(lpc[i]!=cp) fatal("label layout changed");
}
prim(name) {
    if(tageq(name,"read")) return(32701);
    if(tageq(name,"write")) return(32702);
    if(tageq(name,"open")) return(32703);
    if(tageq(name,"creat")) return(32704);
    if(tageq(name,"close")) return(32705);
    if(tageq(name,"char")) return(32706);
    if(tageq(name,"lchar")) return(32707);
    if(tageq(name,"exit")) return(32708);
    if(tageq(name,"unlink")) return(32709);
    if(tageq(name,"seek")) return(32710);
    if(tageq(name,"putchar")) return(32711);
    if(tageq(name,"getchar")) return(32712);
    return(0);
}
symlit(name) {
    extrn nsy,snam,char,lchar;
    auto raw 5,i,c;
    i=0;
    while(i<8) {c=char(name,i);if(c==4 | c==0) goto end;lchar(raw,i,c);i++;}
 end:lchar(raw,i,0);return(symfnd(raw));
}
reopen() {
    extrn infile,open;
    auto fd;
    fd=open(infile,0);if(fd<0) fatal("cannot open input");icini(fd);return(fd);
}
nextrec() {
    extrn dbuf,dtag,firstch,char;
    if(!getln(dbuf,1040)) return(0);
    icrst();nxtnam(dbuf,dtag);firstch=char(dtag,0);return(1);
}
