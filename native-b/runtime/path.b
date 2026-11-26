/* Translate the small V1 permission field, retaining POSIX-mode compatibility. */
xbimasks[] 32,2048,16,73,8,256,4,128,2,36,1,18;
xbimode() {
    extrn xbimasks;auto base,i;
    base=xbilabs(7);xmovim(1,63);xbin(5,6,1);xcond(7,base+6);
    xmovim(0,0);i=0;
    while(i<6){
        xmov(2,6);xmovim(1,xbimasks[i*2]);xbin(2,2,1);xbin(6,2,2);xcond(4,base+i);
        xmovim(1,xbimasks[i*2+1]);xbin(1,0,1);xmark(base+i);i++;
    }
    xmov(6,0);xmark(base+6);xshift(0,6,32);xshift(1,6,32);
}
/* The path copy is local to this call and accepts either EOT or NUL. */
xbipath(op) {
    auto base,sysno;
    if(op<7 | op>10)xrfail();base=xbilabs(4);sysno=2;
    if(op==8)sysno=85;if(op==9)sysno=90;if(op==10)sysno=87;
    xload(8,5,24);xshift(0,8,3);xbin(6,8,8);xcond(4,base+2);
    xmovim(2,4096);xbin(3,4,2);xmov(9,4);xmovim(10,4095);xmovim(2,1);
    xmark(base);xloadb(0,8,0);xbin(6,0,0);xcond(4,base+1);
    xmovim(1,4);xbin(5,0,1);xcond(4,base+1);
    xbin(6,10,10);xcond(4,base+2);
    xstoreb(9,0,0);xbin(0,8,2);xbin(0,9,2);xbin(3,10,2);xbranch(1,base);
    xmark(base+1);xmovim(0,0);xstoreb(9,0,0);xmov(7,4);
    if(op!=10)xload(6,5,32);
    if(op==7){xbin(6,6,6);xcmpout(5);xmov(6,0);}
    if(op==8 | op==9)xbimode();
    xmovim(0,sysno);xsys();xbierr();xbranch(1,base+3);
    xmark(base+2);xmovim(0,-1);xmark(base+3);
}
