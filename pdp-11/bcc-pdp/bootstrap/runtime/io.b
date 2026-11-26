/* Emit the target-specific startup and primitive instruction templates. */
rbuf[128]; rpos 0; rfd 0;
fail(){extrn exit;errmsg("runtime output failed*n",22);exit(1);}
errmsg(s,n){extrn write;if(write(2,s,n)!=n)write(1,s,n);}
flush(){extrn rbuf,rpos,rfd,write;if(rpos)if(write(rfd,rbuf,rpos)!=rpos)fail();rpos=0;}
emit(s){extrn char,lchar,rbuf,rpos;auto i,c;i=0;
 while((c=char(s,i++))!=4){lchar(rbuf,rpos++,c);if(rpos==256)flush();}}
start(path){extrn creat,rfd,rpos;rpos=0;rfd=creat(path,016);if(rfd<0)fail();}
finish(){extrn close,rfd;flush();if(close(rfd)<0)fail();}
main(){
 extrn argv,write;auto first,done;
 first=2;done=0;
 if(argv[0]==5){if(!iss(argv[2]))goto usage;done=argv[3];first=4;}
 else if(argv[0]!=3)goto usage;
 if(same(argv[first],argv[first+1]))fail();
 if(done)if(same(done,argv[first])|same(done,argv[first+1]))fail();
 start(argv[first]);startup();finish();start(argv[first+1]);prims();finish();
 if(done)emarkok(done);return(0);
 usage:errmsg("usage: rtgen [-s marker] startup primitive*n",43);return(1);
}
iss(p){extrn char;if(char(p,0)!='-')return(0);if(char(p,1)!='s')return(0);return(char(p,2)==0);}
emarkok(path){extrn creat,write,close,unlink,exit;auto fd;
 fd=creat(path,016);if(fd<0)exit(1);
 if(write(fd,"ok",2)!=2){close(fd);unlink(path);exit(1);}
 if(close(fd)<0){unlink(path);exit(1);}
}

same(a,b){extrn char;auto i,x,y;i=0;while(1){x=char(a,i);y=char(b,i++);if(x!=y)return(0);if(!x)return(1);}}
