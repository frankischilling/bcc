kind;nargs;params;
num(s){extrn char;auto i,n,c;i=0;n=0;while((c=char(s,i++))>='0'&c<='9')n=n*10+c-'0';return(n);}
line(s){extrn char,lchar;auto b 16,i,c;i=0;while((c=char(s,i))!=4&c!=0){lchar(b,i,c);i++;}lchar(b,i,0);if(!xfline(b))if(!xmline(b))xrline(b);}
value(n){extrn xrvalid;xmovim(0,n);xrvalid=1;}
target(id){value(4198400+xlref(id));}
guard(){auto p;xjcc(4,22);p=xtell();xmovim(0,60);xmovim(7,78);xsys();if(xtell()!=p+22)xfail();}
verify(){xbin(5,4,3);guard();xmovim(2,123456789);xbin(5,5,2);guard();}
report(){xstack(0,0);xmov(6,4);xmovim(0,1);xmovim(7,1);xmovim(2,8);xsys();xmovim(0,60);xmovim(7,0);xsys();}
emit(){
 extrn kind,nargs,params,xrvalid;auto i;
 xmov(3,4);xmovim(5,123456789);xmframe(1);
 line("lc 0");line("ps");value(42);line("as");
 if(kind==6)value(0);else target(1);line("ps");
 i=0;while(i<nargs){if(kind==4){line("lc 0");line("dr");}else if(kind==5)value(5);else value(i+1);line("ps");i++;}
 xcall(nargs);
 if(kind==4){line("ps");line("lc 0");line("dr");line("bin 43");}
 xmleave();verify();report();
 xmark(4095);xmleave();verify();xmovim(0,60);xmovim(7,77);xsys();
 if(kind==7|kind==8){while(xtell()&7)xbyte(144);if(kind==7)xnum(-1,8);else xnum(32768,8);xmark(1);xmovim(0,0);xret();return;}
 xfpro(1,params,0);
 if(kind==0){xfarg(0);line("dr");line("ps");xfarg(1);line("dr");line("bin 43");}
 if(kind==1){xfarg(0);xmovim(1,nargs-1);xbin(0,0,1);line("dr");}
 if(kind==2)xfargc();
 if(kind==3){
  xfargc();xmovim(2,0);xmovim(1,0);xlea(8,5,24);xmark(2);
  xbin(5,1,0);xcond(13,3);xload(9,8,0);xbin(0,2,9);
  xmovim(10,8);xbin(0,8,10);xmovim(10,1);xbin(0,1,10);xbranch(1,2);
  xmark(3);xmov(0,2);
 }
 if(kind==4){xfarg(0);line("ps");value(99);line("as");}
 if(kind==5){
  xfarg(0);line("dr");xmovim(1,0);xbin(5,0,1);xcond(14,2);
  line("ps");target(1);line("ps");xfarg(0);line("dr");xmovim(1,1);xbin(3,0,1);line("ps");xcall(1);line("bin 43");xbranch(1,3);
  xmark(2);value(0);xmark(3);
 }
 if(kind==6)value(0);
 if(kind==9){xfarg(params-1);line("dr");}
 xfend();
}

bad(){
 extrn kind;
 if(kind==20){xcall(-1);return;}
 if(kind==21){xcall(4096);return;}
 if(kind==22){xcall(0);return;}
 if(kind==23){value(1);xcall(0);return;}
 if(kind==24){target(1);line("ps");value(7);xcall(1);return;}
 if(kind==25){xfarg(0);return;}
 if(kind==26){xfargc();return;}
 if(kind==27){xfend();return;}
 if(kind==28){xfpro(1,-1,0);return;}
 if(kind==29){xfpro(1,32768,0);return;}
 if(kind==30){xfpro(1,1,0);xfarg(1);return;}
 if(kind==31){xfpro(1,1,0);xfarg(-1);return;}
 if(kind==32){xfpro(1,1,0);xfpro(2,1,0);return;}
 if(kind==33){xfpro(1,1,0);value(0);line("ps");xfend();return;}
 if(kind==34){xfpro(1,1,0);xfend();return;}
 if(kind==35){xfpro(1,1,0);value(0);xfend();xfend();return;}
 if(kind==36){xrinit(100,102,4095);target(1);line("ps");xcall(0);return;}
 if(kind==37){line("cl");return;}
 if(kind==38){target(1);line("ps");line("cl 0 1");return;}
 if(kind==39){xfpro(1,1,0);line("ar 0 1");return;}
 if(kind==40){xfpro(4096,1,0);return;}
 if(kind==41){xfpro(1,1,-1);return;}
 if(kind==42){xfpro(1,1,8192);return;}
 if(kind==43){target(1);line("ps");xcall(0);xmark(4095);return;}
 if(kind==44){xfpro(1,0,0);value(0);xfend();xfpro(1,0,0);return;}
 xrfail();
}
main(){
 extrn argv,kind,nargs,params,creat;auto pass;
 if(argv[0]!=4)return(2);
 kind=num(argv[2]);nargs=num(argv[3]);params=num(argv[4]);pass=1;
 while(pass<=2){
  if(pass==1)xstart(creat("layout",0600));else xstart(1);
  xlblbeg(pass);xrinit(100,4094,4095);
  if(kind>=20)bad();else emit();
  xlblend();xfinish();pass++;
 }
 return(0);
}
