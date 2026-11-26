/* Shared I/O for B-written native passes. Buffers contain packed bytes. */
lineno 1;
outfd 1;
outdiag 0;

outinit(fd) {
    extrn outfd,outdiag;
    outfd=fd; outdiag=0;
}
outc(c) {
    extrn outfd,outdiag,lchar,write,exit;
    auto b 1;
    lchar(b,0,c);
    if(write(outfd,b,1)!=1) {
        if(outdiag) if(write(1,b,1)==1) return;
        exit(1);
    }
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

errinit() {
    extrn outfd,outdiag;
    outfd=2; outdiag=1;
}
fatal(s) {
    extrn lineno,exit;
    errinit();outc('*n');bouts("bcc: line ");outd(lineno);
    bouts(": ");bouts(s);outc('*n');exit(1);
}
