/* Write native assembly and check output completion using B error conventions. */
usage() {
    extrn exit;
    errinit();bouts("usage: b1 [-l] [-i IC] [-o OUT.s]*n");exit(1);
}
main() {
    extrn argv,char,open,creat,close,exit,libmod;
    auto i,in,out,done,p,fdin,fdout;
    i=2;in=0;out=0;done=0;
    while (i<=argv[0]) {
        p=argv[i];
        if (char(p,0)=='-') {
            if (char(p,1)=='l') if (char(p,2)==0) {libmod=1;goto next;}
            if (char(p,1)=='s') if (char(p,2)==0) {i++;if (i>argv[0]) usage();done=argv[i];goto next;}
            if (char(p,1)=='i') if (char(p,2)==0) {i++;if (i>argv[0]) usage();in=argv[i];goto next;}
            if (char(p,1)=='o') if (char(p,2)==0) {i++;if (i>argv[0]) usage();out=argv[i];goto next;}
        }
        usage();
        next:i++;
    }
    fdin=0;if (in) fdin=open(in,0);
    if (fdin<0) {errinit();bouts("b1: open ic*n");return(1);}
    fdout=1;if (out) fdout=creat(out,016);
    if (fdout<0) {errinit();bouts("b1: creat out*n");return(1);}
    icini(fdin);outinit(fdout);dispat();
    if (!libmod) bouts("*n.globl .bend*n.bend:*n");
    if (fdout!=1) if (close(fdout)<0) return(1);
    if (done) markok(done);
    return(0);
}
