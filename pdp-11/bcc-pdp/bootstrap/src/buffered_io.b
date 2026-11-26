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
