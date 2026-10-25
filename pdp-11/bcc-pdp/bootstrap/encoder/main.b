main() {
    extrn argv,infile,phase,cp,dsize,creat,close;
    auto fd,size;
    if(argv[0]!=3) {errinit();bouts("usage: encoder input output*n");return(1);}
    infile=argv[2];layout();phase=2;cp=0;
    e1(26,dsize);e2(28,16,dsize-16);cp=cp+dsize-16;
    bootcode();codeemit();size=cp;
    fd=creat(argv[3],016);if(fd<0) fatal("cannot create image");
    outinit(fd);phase=3;cp=0;
    e1(26,dsize);e2(28,16,dsize-16);dataemit();bootcode();codeemit();
    if(cp!=size) fatal("image layout changed");
    oflush();
    if(close(fd)<0) fatal("output close failed");
    return(0);
}
