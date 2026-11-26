/* Select runtime groups without changing retained assembly bytes. */
infd 0; ibuf[128]; ipos 0; ilen 0;
line[520]; llen 0; lend 0;
names[2560]; used[512]; needlib 0; needexec 0; needmeta 0;
word(c){return((c>='A'&c<='Z')|(c>='a'&c<='z')|(c>='0'&c<='9')|c=='_');}
input(path){extrn infd,ipos,ilen,open;infd=open(path,0);if(infd<0)fatal("cannot open input");ipos=0;ilen=0;}
get(){extrn infd,ipos,ilen,ibuf,read,char;
 if(ipos>=ilen){ilen=read(infd,ibuf,256);ipos=0;if(ilen<0)fatal("input read failed");}
 if(!ilen)return(-1);return(char(ibuf,ipos++));}
piece(){extrn line,llen,lend,lchar;auto c;llen=0;lend=0;
 while(llen<1040){c=get();if(c<0){lend=1;return(llen);}lchar(line,llen++,c);if(c==10){lend=1;return(llen);}}
 return(llen);}
inputend(){extrn infd,close;if(close(infd)<0)fatal("input close failed");}
textis(buf,n,s){extrn char;auto i,c;i=0;
 while((c=char(s,i))!=4){if(i>=n|char(buf,i)!=c)return(0);i++;}return(i==n);}
nameis(start,n,s){extrn line,char;auto i,c;i=0;
 while((c=char(s,i))!=4){if(i>=n|char(line,start+i)!=c)return(0);i++;}return(i==n);}
lookup(raw,create){extrn names,used,char,lchar;auto h,start,i;
 h=0;i=0;while(i<10)h=(h*33+char(raw,i++))&511;start=h;
 while(used[h]){i=0;while(i<10){if(char(names,h*10+i)!=char(raw,i))goto other;i++;}return(1);
 other:h=(h+1)&511;if(h==start)goto full;}
 if(!create)return(0);i=0;while(i<10){lchar(names,h*10+i,char(raw,i));i++;}used[h]=1;return(1);
 full:if(create)fatal("runtime definition table full");return(0);}
defcell(create){extrn line,llen,lend,char,lchar;auto a,z,i,raw 5,n;
 if(!lend|llen>=1040)return(0);a=0;z=llen;
 if(z)if(char(line,z-1)==10)z--;
 if(z)if(char(line,z-1)==13)z--;
 while(z){i=char(line,z-1);if(i!=' '&i!=9)goto trimmed;z--;}
 trimmed:while(a<z){i=char(line,a);if(i!=' '&i!=9)goto leading;a++;}
 leading:if(z-a<3|z-a>10)return(0);
 if(char(line,a)!='_'|char(line,z-1)!=':')return(0);
 i=a+1;while(i<z-1){if(!word(char(line,i++)))return(0);}
 n=z-a-1;i=0;while(i<n){lchar(raw,i,char(line,a+i));i++;}while(i<10)lchar(raw,i++,0);
 return(lookup(raw,create));}
refs(){extrn line,llen,needlib,needexec,needmeta,char;auto i,j,n,edge;
 if(llen>=1040){needlib=1;needexec=1;needmeta=1;return;}
 i=0;
 while(i<llen){
  edge=1;if(i)edge= !word(char(line,i-1));
  if(char(line,i)=='_')if(edge){
   j=i+1;while(j<llen&word(char(line,j)))j++;n=j-i;
   if(!needlib)if(nameis(i,n,"_printn")|nameis(i,n,"_printf")|nameis(i,n,"_getstr")|nameis(i,n,"_ctime"))needlib=1;
   if(!needexec)if(nameis(i,n,"_execl")|nameis(i,n,"_execv"))needexec=1;
   if(!needmeta)if(nameis(i,n,"_fork")|nameis(i,n,"_wait")|nameis(i,n,"_chdir")|nameis(i,n,"_link")|nameis(i,n,"_chmod")|nameis(i,n,"_chown")|nameis(i,n,"_stat")|nameis(i,n,"_fstat")|nameis(i,n,"_stty")|nameis(i,n,"_gtty")|nameis(i,n,"_setuid")|nameis(i,n,"_getuid")|nameis(i,n,"_time")|nameis(i,n,"_mkdir")|nameis(i,n,"_makdir"))needmeta=1;
   i=j;goto again;
  }
  i++;
 again:;
 }
}
scanfile(path,defs){extrn lend;auto first;input(path);first=1;
 while(piece()){if(first){refs();if(defs)defcell(1);}first=lend;}inputend();}
marker(){extrn line,llen,lend,char;auto n,c;
 if(!lend|llen>=1040)return(0);
 if(!llen)return(0);if(char(line,0)!='/')return(0);n=llen;
 while(n){c=char(line,n-1);if(c!=' '&c!=9&c!=13&c!=10)goto trimmed;n--;}
 trimmed:if(textis(line,n,"/ bcc-exec-begin"))return(1);
 if(textis(line,n,"/ bcc-exec-end"))return(2);
 if(textis(line,n,"/ bcc-meta-begin"))return(3);
 if(textis(line,n,"/ bcc-meta-end"))return(4);return(0);}
obuf[128];
putline(fd){
 extrn line,llen,obuf,char,lchar,write;
 auto i,j,n,buf;
 i=0;while(i<llen){n=llen-i;if(n>256)n=256;buf=line;
  if(i){j=0;while(j<n){lchar(obuf,j,char(line,i+j));j++;}buf=obuf;}
  if(write(fd,buf,n)!=n)fatal("output write failed");i=i+n;
 }
}
filter(src,dst,prim,keep){
 extrn line,llen,lend,needexec,needmeta,creat,write,close;
 auto fd,first,skip,active,m,group,omit;
 fd=creat(dst,016);if(fd<0)fatal("cannot create output");
 if(!keep)goto done;
 input(src);first=1;active=0;skip=0;
 while(piece()){
  if(first){
   skip=defcell(0);m=0;
   if(prim&(!needexec|!needmeta))if(!skip)m=marker();
   if(m){
    group=1;if(m>2)group=2;
    omit=(group==1&!needexec)|(group==2&!needmeta);
    if(m&1){if(active)fatal("nested runtime group");active=group;}
    else{if(active!=group)fatal("unmatched runtime group end");active=0;}
    if(omit)skip=1;
   }
   if((active==1&!needexec)|(active==2&!needmeta))skip=1;
  }
  if(!skip)putline(fd);
  first=lend;
 }
 if(active)fatal("unterminated runtime group");inputend();
 done:if(close(fd)<0)fatal("output close failed");
}
main(){
 extrn argv,needlib;auto i,j,first,done;
 first=2;done=0;
 if(argv[0]==8){if(!iss(argv[2]))goto usage;done=argv[3];first=4;}
 else if(argv[0]!=6)goto usage;
 i=first+3;while(i<=first+4){j=first;while(j<i){if(same(argv[i],argv[j]))fatal("output aliases another file");j++;}i++;}
 if(done){i=first;while(i<=first+4){if(same(done,argv[i]))fatal("marker aliases another file");i++;}}
 scanfile(argv[first],1);if(needlib)scanfile(argv[first+2],0);
 filter(argv[first+1],argv[first+3],1,1);
 filter(argv[first+2],argv[first+4],0,needlib);
 if(done)markok(done);return(0);
 usage:errinit();bouts("usage: selector [-s marker] program primitive library out-primitive out-library*n");return(1);
}
iss(p){extrn char;if(char(p,0)!='-')return(0);if(char(p,1)!='s')return(0);return(char(p,2)==0);}

same(a,b){extrn char;auto i,x,y;i=0;while(1){x=char(a,i);y=char(b,i++);if(x!=y)return(0);if(!x|x==4)return(1);}}
