/* Test constructor metadata, including selected native runtime providers. */
fnames[1000];fpars[200];flocals[200];fseen[200];fbuiltin[200];nfunc 0;nlabels;dbase 0;mainidx;
pbuf[520];haveargv 0;haveenv 0;normal 0;
findfn(name){extrn fnames,nfunc;auto i;i=0;while(i<nfunc){if(tageq(fnames+i*5,name))return(i);i++;}return(-1);}
regfn(name,count){
 extrn fnames,fpars,flocals,fseen,fbuiltin,nfunc,char,lchar;auto i,slot;
 if(findfn(name)>=0|nfunc>=200)fatal("duplicate or excessive function definitions");
 slot=nfunc++;i=0;while(i<9){lchar(fnames+slot*5,i,char(name,i));i++;}
 fpars[slot]=count;flocals[slot]= -1;fseen[slot]=0;fbuiltin[slot]= -1;return(0);
}
metas(fd){
 extrn pbuf,flocals,fseen,nfunc,fpars,mainidx;auto tag 5,name 5,cur,n,i;
 cur= -1;icini(fd);
 while(getln(pbuf,1040)){
  icrst();nxtnam(pbuf,tag);
  if(tageq(tag,"pr")){
   if(cur>=0)fatal("nested function");nxtnam(pbuf,name);cur=findfn(name);
   if(cur<0)fatal("function metadata mismatch");if(fseen[cur])fatal("duplicate function body");
   fseen[cur]=1;n=nxti(pbuf);n=nxti(pbuf);xrend(pbuf);goto next;
  }
  if(tageq(tag,"ep")){
   if(cur<0)fatal("function end outside body");n=nxti(pbuf);xrend(pbuf);
   if(n<0|n>8191)fatal("invalid local count");flocals[cur]=n;cur= -1;goto next;
  }
  /* xdscan checks static records before this function metadata pass. */
 next:;
 }
 if(cur>=0)fatal("unfinished function");i=0;
 while(i<nfunc){if(flocals[i]<0)fatal("missing function body");i++;}
 mainidx=findfn("main");if(mainidx<0)fatal("missing main");
 if(fpars[mainidx])fatal("entry parameters unsupported");
}

regbi(name,op,count){
 extrn fbuiltin,nfunc,haveargv,haveenv;
 if(op==11){haveargv=1;return(0);}
 if(op==15){haveenv=1;return(0);}
 regfn(name,count);fbuiltin[nfunc-1]=op;return(0);
}
