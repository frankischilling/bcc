/* Record diagnostics, labels and completion markers. */
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
