/* Report the packed vector as a count followed by its NUL-terminated strings. */
number(s){auto n;icrst();n=xrnum(s);xrend(s);return(n);}
report(){
    auto outer,inner,done;outer=100;inner=101;done=102;
    xmov(12,0);xshift(0,12,3);xmov(13,2);
    xmovim(0,1);xmovim(7,1);xmov(6,12);xmovim(2,8);xsys();xlea(12,12,8);
    xmark(outer);xbin(6,13,13);xcond(4,done);
    xload(6,12,0);xshift(0,6,3);xmov(8,6);xmovim(2,0);
    xmark(inner);xloadb(0,8,0);xlea(8,8,1);xlea(2,2,1);xbin(6,0,0);xcond(5,inner);
    xmovim(0,1);xmovim(7,1);xsys();xlea(12,12,8);xmovim(0,1);xbin(3,13,0);xbranch(1,outer);
    xmark(done);xmovim(0,60);xmovim(7,0);xsys();
}
main(){
    extrn argv,creat;auto pass,limit,mode;
    if(argv[0]!=3)return(2);limit=number(argv[2]);mode=number(argv[3]);
    pass=1;while(pass<=2){
        if(pass==1)xstart(creat("layout",0600));else xstart(1);
        xlblbeg(pass);xrinit(200,4095,4095);
        if(mode==1){xmovim(0,4096);xstore(4,0,0);}
        if(mode==2){xmovim(0,0);xstore(4,8,0);}
        if(mode==3){xmovim(0,0);xstore(4,0,0);}
        if(mode==6){xmovim(0,-1);xstore(4,0,0);}
        xargvec(limit);
        if(mode==4){
            xmov(8,0);xshift(0,8,3);xload(8,8,8);xshift(0,8,3);
            xload(10,4,8);xloadb(11,10,0);xmovim(9,33);xstoreb(8,0,9);
            xloadb(9,10,0);xbin(5,9,11);xcond(5,4095);
        }
        report();
        xmark(4095);xmovim(0,60);xmovim(7,77);xsys();
        xlblend();xfinish();pass++;
    }
    return(0);
}
