/* Names occupy ten packed bytes; classes and offsets occupy B cells. */
snam[1000];
scls[200];
soff[200];
nsy 0;
fnst 0;
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
symfnd(name) {
    extrn snam,nsy;
    auto i;
    i=nsy-1;
    while(i>=0) {
        if(nameat(snam,i*10,name)) return(i);
        i--;
    }
    return(-1);
}
symadd(name,cls,off) {
    extrn scls,soff,nsy;
    auto idx;
    if(nsy>=200) fatal("symbol table full");
    idx=nsy;nmcpy(idx*10,name);
    scls[idx]=cls;soff[idx]=off;nsy++;
    return(idx);
}
symtrn() {extrn nsy,fnst;nsy=fnst;}
