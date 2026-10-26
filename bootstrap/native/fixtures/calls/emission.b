fvalue(index){extrn fnames,xrvalid;xmovim(0,xdaddr(fnames+index*5));xrvalid=1;}
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
 extrn pbuf,flocals,fpars,fbuiltin,nlabels,nfunc,xrvalid;auto cur,tag 5,name 5,i,n,lit;
 cur= -1;lit=0;icini(fd);
 while(getln(pbuf,1040)){
  icrst();nxtnam(pbuf,tag);
  if(tageq(tag,"pr")){
   if(cur>=0)fatal("nested emitted function");nxtnam(pbuf,name);cur=findfn(name);
   if(cur<0)fatal("unknown function");n=nxti(pbuf);n=nxti(pbuf);xrend(pbuf);
   xfpro(nlabels+cur,fpars[cur],flocals[cur]);if(fbuiltin[cur]<0)xcfbeg(nlabels+nfunc+cur);goto next;
  }
  if(tageq(tag,"ep")){
   if(cur<0)fatal("emitted end outside function");n=nxti(pbuf);xrend(pbuf);
   if(n!=flocals[cur])fatal("local count changed");if(fbuiltin[cur]>=0)xbuiltin(fbuiltin[cur]);else xcfend();xfend();cur= -1;goto next;
  }
  if(tageq(tag,"Slit") | tageq(tag,"Glit")){
   if(tageq(tag,"Slit")){xmovim(0,xdlit(lit));xrvalid=1;}lit++;goto next;
  }
  if(cur<0)goto next;
  if(tageq(tag,"la")){i=nxti(pbuf);xrend(pbuf);xmovim(0,xdcla(i));xrvalid=1;goto next;}
  if(tageq(tag,"st")){i=nxti(pbuf);xrend(pbuf);xmovim(0,xdlit(i));xrvalid=1;goto next;}
  if(tageq(tag,"ex")){
   nxtnam(pbuf,name);xrend(pbuf);xmovim(0,xdaddr(name));xrvalid=1;goto next;
  }
  if(!xcfline(pbuf))if(!xfline(pbuf))if(!xmline(pbuf))xrline(pbuf);
 next:;
 }
 if(cur>=0)fatal("unfinished emitted function");
}
fnentry(name){extrn nlabels;auto i;i=findfn(name);if(i<0)fatal("unknown data function");return(4198400+xlref(nlabels+i));}
lbentry(id){return(4198400+xlref(xcfmap(id,1,0)));}
datafile(input,path){
 extrn open,creat,close,fnentry,lbentry,dbase;auto fd,out;
 fd=open(input,0);out=creat(path,0600);if(fd<0 | out<0)fatal("static data open");
 xdemit(fd,out,dbase,fnentry,lbentry);
 if(close(fd)<0 | close(out)<0)fatal("static data close");
}
