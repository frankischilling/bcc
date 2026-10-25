/* Experimental driver: all files live in a caller-owned build directory. */
args[10]; zeros[128];
fail(){extrn exit;errmsg("B build failed*n",15);exit(1);}
errmsg(s,n){extrn write;if(write(2,s,n)!=n)write(1,s,n);}
run(n){
 extrn args,zeros,creat,write,close,unlink,open,read,char,fork,wait,execv,exit;
 auto fd,i,p,b 2;
 if(argbytes(n)>128)fail();
 unlink("done");fd=open("done",0);if(fd>=0){close(fd);fail();}
 fd=creat("heap.vm",016);if(fd<0)fail();i=0;
 while(i<64){if(write(fd,zeros,256)!=256)fail();i++;}
 if(close(fd)<0)fail();
 p=fork();if(p<0)fail();
 if(!p){execv("./engine",args,n);exit(1);}
 if(wait()!=p)fail();
 fd=open("done",0);if(fd<0)fail();
 if(read(fd,b,3)!=2)fail();if(char(b,0)!='o'|char(b,1)!='k')fail();
 if(close(fd)<0)fail();unlink("done");
}
main(){
 extrn args,argv,write,char;
 auto mode,in,out,buildlib;
 mode=0;buildlib=0;
 if(argv[0]==2){
  if(option(argv[2],'r')){
   args[0]="engine";args[1]="runtime";args[2]="-s";args[3]="done";
   args[4]="bmain.s";args[5]="brt.s";run(6);return(0);
  }
  if(option(argv[2],'b')){
   mode='L';buildlib=1;in="libb.b";out="libb.s";goto start;
  }
 }
 if(argv[0]==3){in=argv[2];out=argv[3];}
 else{
  if(argv[0]!=4)goto usage;
  if(char(argv[2],0)!='-')goto usage;
  mode=char(argv[2],1);if(mode!='v'&mode!='s'&mode!='l'&mode!='L')goto usage;
  if(char(argv[2],2)!=0)goto usage;
  in=argv[3];out=argv[4];
 }
 goto start;
 usage:errmsg("usage: driver [-v|-s|-l|-L] input output*n",41);return(1);
 start:
 if(buildlib)goto ready;
 if(reserved(in))fail();
 if(reserved(out))fail();
 if(same(in,out))fail();
 if(exists(out))fail();
 ready:;
 args[0]="engine";args[1]="front.vm";args[2]="-o";args[3]="raw.ic";
 args[4]="-s";args[5]="done";args[6]=in;run(7);
 args[1]="resolve";args[2]="-i";args[3]="raw.ic";args[4]="-o";
 args[5]="code.ic";args[6]="-s";args[7]="done";run(8);
 if(mode=='v'){args[1]="encoder";args[2]="-s";args[3]="done";args[4]="code.ic";args[5]=out;run(6);return(0);}
 args[1]="codegen";args[3]="code.ic";args[5]="prog.s";
 if(mode=='s'|mode=='l'|mode=='L')args[5]=out;
 if(mode=='l'|mode=='L'){args[8]="-l";if(mode=='L')args[8]="-L";run(9);}else run(8);
 if(mode=='s'|mode=='l'|mode=='L')return(0);
 args[1]="select";args[2]="-s";args[3]="done";args[4]="prog.s";
 args[5]="brt.s";args[6]="libb.s";args[7]="selrt.s";args[8]="sellib.s";run(9);
 args[1]="image";args[2]="-s";args[3]="done";args[4]=out;
 args[5]="bmain.s";args[6]="selrt.s";args[7]="sellib.s";args[8]="prog.s";run(9);
 return(0);
}

/* These names belong to the toolchain or its per-build scratch files. */
rnames[] "engine","driver","front.vm","resolve","codegen","select","runtime","image","encoder","bmain.s","brt.s","libb.s","heap.vm","raw.ic","code.ic","prog.s","selrt.s","sellib.s","done";
reserved(p){extrn rnames;auto i;i=0;while(i<19){if(same(p,rnames[i++]))return(1);}return(0);}
same(a,b){extrn char;auto i,x,y;i=0;while(1){x=char(a,i);y=char(b,i++);if(x==4)x=0;if(y==4)y=0;if(x!=y)return(0);if(!x)return(1);}}
exists(p){extrn stat;auto status 21;return(stat(p,status)>=0);}

/* Leave room for the engine's native stack as startup copies its arguments. */
argbytes(n){extrn args,char;auto total,i,j,c;
 total=n+n+2;i=0;
 while(i<n){j=0;while(1){c=char(args[i],j);if(!c|c==4)goto ended;j++;if(j>128)return(129);}
 ended:j++;if(j&1)j++;total=total+j;if(total>128)return(129);i++;}
 return(total);
}

option(p,c){extrn char;if(char(p,0)!='-')return(0);if(char(p,1)!=c)return(0);return(char(p,2)==0);}
