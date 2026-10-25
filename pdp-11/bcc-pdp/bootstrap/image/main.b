main(){
    extrn argv,open,close,creat,phase,pc,origin,ncount,tok,binfd;
    auto pass,i,fd,size;
    if(argv[0]<3){errinit();bouts("usage: bimage output input ...*n");return(1);}
    i=3;while(i<=argv[0]){if(nameeq(argv[2],argv[i]))fatal("output is an input file");i++;}
    initops();pass=1;size=0;
    while(pass<=2){
        phase=pass;pc=0;origin=16396;i=0;while(i<10)ncount[i++]=0;
        if(pass==2){
            binfd=creat(argv[2],036);if(binfd<0)fatal("cannot create output");
            header(0405);header(size+12);header(0);header(0);header(0);header(0);
        }
        i=3;
        while(i<=argv[0]){
            fd=open(argv[i],0);if(fd<0)fatal("cannot open source");lexinit(fd);next();
            while(tok){if(tok==10|tok==';')next();else stmt();}
            if(close(fd)<0)fatal("input close failed");i++;
        }
        if(pc&1)ebyte(0);
        if(pass==1)size=pc;
        else{if(size!=pc)fatal("image phase mismatch");bflush();if(close(binfd)<0)fatal("output close failed");}
        pass++;
    }
    return(0);
}
