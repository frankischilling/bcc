/* Two write-back pages for the experimental 8192-word heap. */
hbuf[512]; htag[2] -1,-1; hdirty[2]; hbase[2] 0,256;
hcur 0; hnext 0; hread 0; hwrite 0; ibuf[128];
sp 8192; fp 0; floor 128;
valid(at) {
    extrn exit;
    if(at<1 | at>=8192) exit(16);
    return(at);
}
hflush(slot) {
    extrn hbuf,htag,hdirty,hbase,hwrite,seek,write,exit;
    if(!hdirty[slot]) return;
    if(seek(hwrite,htag[slot]*512,0)<0) exit(30);
    if(write(hwrite,hbuf+hbase[slot],512)!=512) exit(30);
    hdirty[slot]=0;
}
hpage(at) {
    extrn hbuf,htag,hbase,hcur,hnext,hread,seek,read,exit;
    auto pg,p;
    valid(at);
    pg=at>>8;
    if(htag[0]==pg) {hcur=0;goto found;}
    if(htag[1]==pg) {hcur=1;goto found;}
    hcur=hnext;
    hflush(hcur);
    p=hbuf+hbase[hcur];
    if(seek(hread,pg*512,0)<0) exit(31);
    if(read(hread,p,512)!=512) exit(31);
    htag[hcur]=pg;
 found:
    hnext=1-hcur;
    return(hbuf+hbase[hcur]);
}
hget(at) {
    auto p;
    p=hpage(at);
    return(p[at&255]);
}
hset(at,v) {
    extrn hcur,hdirty;
    auto p;
    p=hpage(at);
    p[at&255]=v;
    hdirty[hcur]=1;
    return(v);
}
hbyte(byte) {
    extrn exit;
    auto w;
    if(byte<2 | byte>=16384) exit(16);
    w=hget(byte>>1);
    if(byte&1) return(w>>8);
    return(w&255);
}
hput(byte,c) {
    extrn exit;
    auto w,low,at;
    if(byte<2 | byte>=16384) exit(16);
    at=byte>>1;
    w=hget(at);
    low=c&255;
    if(byte&1) {low=low<<8;w=w&255;}
    else w=w&65280;
    hset(at,w|low);
    return(c);
}
push(v) {
    extrn sp,floor,exit;
    if(sp<=floor) exit(18);
    sp--;
    hset(sp,v);
}
pop() {
    extrn sp,exit;
    auto v;
    if(sp>=8192) exit(19);
    v=hget(sp);
    sp++;
    return(v);
}
