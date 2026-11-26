/* Names occupy nine packed bytes; classes and offsets occupy B cells. */
snam[900];
scls[200];
soff[200];
nsy 0;
nameat(a,base,b) {
    extrn char;
    auto i,ca,cb;
    i=0;
    while(1) {
        ca=char(a,base+i);cb=char(b,i);
        if(ca!=cb) return(0);
        if(ca==0) return(1);
        i++;
    }
}
nmcpy(base,src) {
    extrn snam,char,lchar;
    auto i,c;
    i=0;
    while(i<8) {
        c=char(src,i);
        if(c==0) goto pad;
        lchar(snam,base+i,c);i++;
    }
 pad:
    while(i<9) {lchar(snam,base+i,0);i++;}
}
/* Buckets preserve reverse insertion order without scanning unrelated names. */
buckets[32]; snext[200];
symfnd(name) {
    extrn snam,buckets,snext,char;
    auto i;
    i=buckets[char(name,0)&31];
    while(i) {
        i--;
        if(nameat(snam,i*9,name)) return(i);
        i=snext[i];
    }
    return(-1);
}
symadd(name,cls,off) {
    extrn scls,soff,nsy,buckets,snext,char;
    auto idx,h;
    if(nsy>=200) fatal("symbol table full");
    idx=nsy;nmcpy(idx*9,name);
    scls[idx]=cls;soff[idx]=off;nsy++;
    h=char(name,0)&31;snext[idx]=buckets[h];buckets[h]=idx+1;
    return(idx);
}
