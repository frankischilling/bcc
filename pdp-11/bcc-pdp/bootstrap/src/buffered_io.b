/* Buffer compiler output in 256-byte blocks; write diagnostics immediately. */
lineno 1;
outfd 1;
outdiag 0;
nlab 0;

obufio[128]; oposio 0;
oflush() {
    extrn oposio,obufio,outfd,write,exit;
    if(oposio) if(write(outfd,obufio,oposio)!=oposio) exit(1);
    oposio=0;
}
outinit(fd) {
    extrn outfd,outdiag,oposio;
    oflush();outfd=fd;outdiag=0;oposio=0;
}
outc(c) {
    extrn outfd,outdiag,lchar,write,exit,obufio,oposio;
    auto b 1;
    if(!outdiag){lchar(obufio,oposio++,c);if(oposio==256)oflush();return;}
    lchar(b,0,c);
    if(write(outfd,b,1)!=1){if(write(1,b,1)==1)return;exit(1);}
}
/* IC buffers are NUL-terminated; B source literals end with EOT. */
outs(s) {
    extrn char;
    auto i,c;
    i=0;
    while(c=char(s,i++)) outc(c);
}
bouts(s) {
    extrn char;
    auto i,c;
    i=0;
    while((c=char(s,i++))!=4) {
        if(c==0) return;
        outc(c);
    }
}
outd(n) {
    extrn char,lchar;
    auto buf 4,i;
    if(n==0) {outc('0');return;}
    if(n==-32768) {bouts("-32768");return;}
    if(n<0) {outc('-');n= -n;}
    i=0;
    while(n) {
        lchar(buf,i,'0'+n%10);
        i++; n=n/10;
    }
    while(i) outc(char(buf,--i));
}
outln() {outc('*n');}
errinit() {
    extrn outfd,outdiag;
    oflush();outfd=2;outdiag=1;
}
fatal(s) {
    extrn lineno,exit;
    errinit();outc('*n');bouts("bcc: line ");outd(lineno);
    bouts(": ");bouts(s);outc('*n');exit(1);
}
fatalst(s,a) {
    extrn lineno,exit;
    errinit();outc('*n');bouts("bcc: line ");outd(lineno);
    bouts(": ");bouts(s);outc(' ');outs(a);outc('*n');exit(1);
}
newl() {
    extrn nlab;
    auto id;
    if(nlab==32767) fatal("label table overflow");
    id=nlab; nlab++;return(id);
}
markok(path) {
    extrn creat,write,close,unlink,exit;
    auto fd;
    fd=creat(path,016);
    if(fd<0) exit(1);
    if(write(fd,"ok",2)!=2) {close(fd);unlink(path);exit(1);}
    if(close(fd)<0) {unlink(path);exit(1);}
}
