fvalue(index){extrn dbase,xrvalid;xmovim(0,dbase/8+index);xrvalid=1;}
record(s){extrn char,lchar;auto b 16,i,c;i=0;while((c=char(s,i))!=4&c!=0){lchar(b,i,c);i++;}lchar(b,i,0);if(!xfline(b))if(!xmline(b))xrline(b);}
guard(){auto p;xjcc(4,22);p=xtell();xmovim(0,60);xmovim(7,78);xsys();if(xtell()!=p+22)xfail();}
entry(){
 extrn mainidx;
 xmov(3,4);xmovim(5,123456789);xmframe(0);
 fvalue(mainidx);record("dr");record("ps");xcall(0);xmleave();
 xbin(5,4,3);guard();xmovim(2,123456789);xbin(5,5,2);guard();
 xstack(0,0);xmov(6,4);xmovim(0,1);xmovim(7,1);xmovim(2,8);xsys();
 xmovim(0,60);xmovim(7,0);xsys();
 xmark(4095);xmovim(0,60);xmovim(7,77);xsys();
}
body(fd){
 extrn pbuf,flocals,fpars,nlabels,nfunc;auto cur,tag 5,name 5,i,n;
 cur= -1;icini(fd);
 while(getln(pbuf,1040)){
  icrst();nxtnam(pbuf,tag);
  if(tageq(tag,"pr")){
   if(cur>=0)fatal("nested emitted function");nxtnam(pbuf,name);cur=findfn(name);
   if(cur<0)fatal("unknown function");n=nxti(pbuf);n=nxti(pbuf);xrend(pbuf);
   xfpro(nlabels+cur,fpars[cur],flocals[cur]);xcfbeg(nlabels+nfunc+cur);goto next;
  }
  if(tageq(tag,"ep")){
   if(cur<0)fatal("emitted end outside function");n=nxti(pbuf);xrend(pbuf);
   if(n!=flocals[cur])fatal("local count changed");xcfend();xfend();cur= -1;goto next;
  }
  if(cur<0)fatal("emitted record outside function");
  if(tageq(tag,"ex")){
   nxtnam(pbuf,name);xrend(pbuf);i=findfn(name);if(i<0)fatal("unsupported external symbol");fvalue(i);goto next;
  }
  if(!xcfline(pbuf))if(!xfline(pbuf))if(!xmline(pbuf))xrline(pbuf);
 next:;
 }
 if(cur>=0)fatal("unfinished emitted function");
}
putword(fd,v){extrn lchar,write;auto b 4,i;i=0;while(i<8){lchar(b,i,v&255);v=v>>8;i++;}if(write(fd,b,8)!=8)fatal("function data write");}
datafile(path){extrn creat,close,nfunc,nlabels;auto fd,i;fd=creat(path,0600);if(fd<0)fatal("function data open");i=0;while(i<nfunc){putword(fd,4198400+xlref(nlabels+i));i++;}if(close(fd)<0)fatal("function data close");}
