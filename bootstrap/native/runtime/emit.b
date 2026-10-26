/* Linux x86-64 primitives using the native B counted-argument call frame. */
xbiarity[] 2,3,3,3,1,3,1,2,2,2,1,-1,0,0,7;
xbicnt(op){extrn xbiarity;if(op<0 | op>14 | op==11)xrfail();return(xbiarity[op]);}
xbilabs(n){
    extrn xrnext,xrlimit;auto base;
    if(n<1 | xrnext<0 | xrnext>xrlimit | n>xrlimit-xrnext)xrfail();
    base=xrnext;xrnext=+n;return(base);
}
xbierr(){auto done;done=xbilabs(1);xbin(6,0,0);xcond(9,done);xmovim(0,-1);xmark(done);}
xbuiltin(op){
    extrn xfactive,xfparams,xrdepth,xrvalid,xrfault;auto count;
    count=xbicnt(op);if(!xfactive | xrdepth | xfparams!=count)xrfail();
    if(op==6)count=0;
    xload(0,5,16);xmovim(1,count);xbin(5,0,1);xcond(12,xrfault);
    if(op==0){
        xload(0,5,24);xshift(0,0,3);xload(1,5,32);xbin(0,0,1);xloadb(0,0,0);goto done;
    }
    if(op==1){
        xload(1,5,24);xshift(0,1,3);xload(2,5,32);xbin(0,1,2);
        xload(0,5,40);xstoreb(1,0,0);goto done;
    }
    if(op==2 | op==3){
        xload(7,5,24);xload(6,5,32);xshift(0,6,3);xload(2,5,40);
        xmovim(0,op-2);xsys();xbierr();goto done;
    }
    if(op==4){xload(7,5,24);xmovim(0,3);xsys();xbierr();goto done;}
    if(op==5){
        xload(7,5,24);xload(6,5,32);xload(2,5,40);xmovim(0,8);xsys();
        xbin(6,0,0);xcmpout(12);xunary(1,0);goto done;
    }
    if(op==6){xload(7,5,24);xmovim(0,60);xsys();xbyte(15);xbyte(11);goto done;}
    if(op==12){xmovim(0,57);xsys();xbierr();goto done;}
    if(op==13){
        xmovim(7,-1);xmovim(6,0);xmovim(2,0);xmovim(10,0);
        xmovim(0,61);xsys();xbierr();goto done;
    }
    if(op==14){
        xload(0,5,24);xload(7,5,32);xload(6,5,40);xload(2,5,48);
        xload(10,5,56);xload(8,5,64);xload(9,5,72);xsys();goto done;
    }
    xbipath(op);
 done:xrvalid=1;
}
