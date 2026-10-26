/* Test-only one-call images; the Python harness owns every input and output. */
op; nargs; datalen; dbase 0; vals[8]; ptrs[8];
number(s,skip){extrn bcur;auto n;icrst();bcur=skip;n=xrnum(s);xrend(s);return(n);}
line(s){extrn char,lchar;auto b 16,i,c;i=0;while((c=char(s,i))!=4&c!=0){lchar(b,i,c);i++;}lchar(b,i,0);xrline(b);}
value(n){extrn xrvalid;xmovim(0,n);xrvalid=1;}
guard(){auto p;xjcc(4,22);p=xtell();xmovim(0,60);xmovim(7,78);xsys();if(xtell()!=p+22)xfail();}
report(){
 extrn dbase,datalen;
 xstack(0,0);xmov(6,4);xmovim(0,1);xmovim(7,1);xmovim(2,8);xsys();
 if(datalen){xmovim(6,dbase);xmovim(0,1);xmovim(7,1);xmovim(2,datalen);xsys();}
 xmovim(0,60);xmovim(7,0);xsys();
}
emit(){
 extrn op,nargs,vals,ptrs,dbase,xrvalid;auto i,target,n;
 target=op+1;if(op==12)target=8;
 xmov(3,4);xmovim(5,123456789);xmframe(0);
 value(4198400+xlref(target));line("ps");i=0;
 while(i<nargs){n=vals[i];if(ptrs[i])n=dbase/8+n/8;value(n);line("ps");i++;}
 xcall(nargs);
 if(op==12){xmov(7,0);xmovim(6,3);xmovim(2,0);xmovim(0,72);xsys();xmovim(1,3);xbin(2,0,1);}
 xmleave();xbin(5,4,3);guard();xmovim(2,123456789);xbin(5,5,2);guard();report();
 xmark(4095);xmovim(0,60);xmovim(7,77);xsys();
 i=0;while(i<=10){xfpro(i+1,xbicnt(i),0);xbuiltin(i);xfend();i++;}
 xfpro(12,1,0);xload(6,5,24);xbimode();xmov(0,6);xrvalid=1;xfend();
}
bad(){
 extrn op;
 if(op==20){xbuiltin(-1);return;}if(op==21){xbuiltin(11);return;}
 if(op==22){xbuiltin(0);return;}
 if(op==23){xfpro(1,1,0);xbuiltin(0);return;}
 if(op==24){xfpro(1,2,0);value(1);line("ps");xbuiltin(0);return;}
 if(op==25){xrinit(100,101,4095);xbilabs(2);return;}
 if(op==26){xbipath(6);return;}
 if(op==27){xbicnt(11);return;}
 xrfail();
}
main(){
 extrn argv,op,nargs,datalen,vals,ptrs,dbase,char,creat;auto pass,i,s,size;
 if(argv[0]<4)return(2);op=number(argv[2],0);nargs=number(argv[3],0);datalen=number(argv[4],0);
 if(nargs<0 | nargs>8 | argv[0]!=nargs+4 | datalen<0 | datalen>8192)return(2);
 if(op<0 | (op>12 & op<20))return(2);
 i=0;while(i<nargs){s=argv[5+i];ptrs[i]=char(s,0)=='p';vals[i]=number(s,ptrs[i]);if(ptrs[i])if(vals[i]<0 | vals[i]%8) return(2);i++;}
 pass=1;while(pass<=2){
  if(pass==1)xstart(creat("layout",0600));else xstart(1);
  xlblbeg(pass);xrinit(100,4095,4095);if(op>=20)bad();else emit();
  xlblend();size=xtell();xfinish();dbase=4194304+((4096+size+4095)/4096)*4096;pass++;
 }
 return(0);
}
