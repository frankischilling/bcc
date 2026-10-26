main(){
 extrn argv,open,close,creat,regfn,nfunc,nlabels,dbase,xdbase;auto fd,pass,size;
 if(argv[0]!=4)return(2);
 fd=open(argv[2],0);if(fd<0)fatal("raw open");arscan(fd,regfn);if(close(fd)<0)fatal("raw close");
 fd=open(argv[3],0);if(fd<0)fatal("layout open");xdscan(fd);if(close(fd)<0)fatal("layout close");
 fd=open(argv[3],0);if(fd<0)fatal("records open");metas(fd);if(close(fd)<0)fatal("records close");
 fd=open(argv[3],0);if(fd<0)fatal("labels open");nlabels=xcfscan(fd);if(close(fd)<0)fatal("labels close");
 pass=1;while(pass<=2){
  if(pass==1)xstart(creat("layout",0600));else xstart(1);
  xlblbeg(pass);xrinit(nlabels+2*nfunc,4095,4095);xdbase=dbase;entry();
  fd=open(argv[3],0);if(fd<0)fatal("body open");body(fd);if(close(fd)<0)fatal("body close");
  if(pass==2)datafile(argv[3],argv[4]);xlblend();size=xtell();xfinish();
  dbase=4194304+((4096+size+4095)/4096)*4096;pass++;
 }
 return(0);
}
