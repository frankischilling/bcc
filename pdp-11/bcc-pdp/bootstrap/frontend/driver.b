/* Read one source file and write records for the resolver. */
extflg 0;
usage() {
    extrn exit;
    errinit();bouts("usage: b00 [-x] [-o out.ic] input.b*n");exit(1);
}
main() {
    extrn argv,char,open,creat,close,extflg;
    auto i,in,out,done,p,fdin,fdout;
    i=2;in=0;out=0;done=0;
    while (i<=argv[0]) {
        p=argv[i];
        if (char(p,0)=='-') {
            if (char(p,1)=='x') if (char(p,2)==0) {extflg=1;goto next;}
            if (char(p,1)=='s') if (char(p,2)==0) {i++;if (i>argv[0]) usage();done=argv[i];goto next;}
            if (char(p,1)=='o') if (char(p,2)==0) {i++;if (i>argv[0]) usage();out=argv[i];goto next;}
            usage();
        }
        if (in) usage();in=argv[i];
        next:i++;
    }
    if (!in) usage();
    fdin=open(in,0);
    if (fdin<0) {errinit();bouts("b00: cannot open input*n");return(1);}
    fdout=1;if (out) fdout=creat(out,016);
    if (fdout<0) {errinit();bouts("b00: cannot create output*n");return(1);}
    lexini(fdin);outinit(fdout);
    if (extflg) bouts("Acompat*n");
    gettok();prog();
    if (fdout!=1) if (close(fdout)<0) return(1);
    if (done) markok(done);
    return(0);
}
