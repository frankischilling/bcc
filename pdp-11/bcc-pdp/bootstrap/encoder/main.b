main() {
    extrn argv,infile,phase,cp,dsize,creat,close;
    auto fd,size,out,done;
    done=0;
    if(argv[0]==3){infile=argv[2];out=argv[3];}
    else if(argv[0]==5){
        if(!iss(argv[2]))goto usage;
        done=argv[3];infile=argv[4];out=argv[5];
    }
    else goto usage;
    if(same(infile,out))fatal("output is the input file");
    if(done)if(same(done,infile)|same(done,out))fatal("marker aliases another file");
    layout();phase=2;cp=0;
    e1(26,dsize);e2(28,16,dsize-16);cp=cp+dsize-16;
    bootcode();codeemit();size=cp;
    fd=creat(out,016);if(fd<0) fatal("cannot create image");
    outinit(fd);phase=3;cp=0;
    e1(26,dsize);e2(28,16,dsize-16);dataemit();bootcode();codeemit();
    if(cp!=size) fatal("image layout changed");
    oflush();
    if(close(fd)<0) fatal("output close failed");
    if(done)emarkok(done);return(0);
 usage:errinit();bouts("usage: encoder [-s marker] input output*n");return(1);
}

iss(p){extrn char;if(char(p,0)!='-')return(0);if(char(p,1)!='s')return(0);return(char(p,2)==0);}
same(a,b){extrn char;auto i,x,y;i=0;while(1){x=char(a,i);y=char(b,i++);if(x!=y)return(0);if(!x|x==4)return(1);}}
emarkok(path){extrn creat,write,close,unlink,exit;auto fd;
 fd=creat(path,016);if(fd<0)exit(1);
 if(write(fd,"ok",2)!=2){close(fd);unlink(path);exit(1);}
 if(close(fd)<0){unlink(path);exit(1);}
}
