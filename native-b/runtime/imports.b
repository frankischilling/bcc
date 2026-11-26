/* Select providers only after seeing every source definition. */
xbinames[] "char","lchar","read","write","close","seek","exit","open","creat","chmod","unlink","argv","fork","wait","__sys","__env";
xbidefs[16]; xbirefs[16]; xbibuf[520];
xbiwhich(name){extrn xbinames;auto i;i=0;while(i<16){if(tageq(name,xbinames[i]))return(i);i++;}return(-1);}
xbiscan(fd){
    extrn xbidefs,xbirefs,xbibuf;auto i,tag 5,name 5,def,ref;
    i=0;while(i<16){xbidefs[i]=0;xbirefs[i]=0;i++;}icini(fd);
    while(getln(xbibuf,1040)){
        icrst();nxtnam(xbibuf,tag);
        def=tageq(tag,"pr") | tageq(tag,"gvb") | tageq(tag,"gvp");
        ref=tageq(tag,"ex") | tageq(tag,"gvn");
        if(def | ref){
            nxtnam(xbibuf,name);if(!arname(name))xrfail();i=xbiwhich(name);
            if(i>=0){if(def)xbidefs[i]=1;if(ref)xbirefs[i]=1;}
        }
    }
}
/* The caller supplies a fresh output, then closes both descriptors. */
xbicopy(fd,out,visit){
    extrn xbidefs,xbirefs,xbibuf,xbinames,char,lchar;
    auto i,j,c,name 5;
    outinit(out);icini(fd);
    while(getln(xbibuf,1040)){outs(xbibuf);outln();}
    i=0;while(i<16){
        if(xbirefs[i] & !xbidefs[i]){
            j=0;while((c=char(xbinames[i],j))!=4 & c!=0){lchar(name,j++,c);}lchar(name,j,0);
            if(i==11){
                if(visit(name,i,0))xrfail();
                bouts("gvb argv 1*ngvc 0*ngve*n");
            }else if(i==15){
                if(visit(name,i,0))xrfail();
                bouts("gvb __env 1*ngvc 0*ngve*n");
            }else{
                if(visit(name,i,xbicnt(i)))xrfail();
                bouts("pr ");outs(name);bouts(" 0 0*nep 0*n");
            }
        }
        i++;
    }
    oflush();
}
