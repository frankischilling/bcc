/* Select 64-bit B word operations: RCX is left, RAX is right and result. */
xcmpout(cond) {xset(cond,0);xmovzx(0,0);}
xbinary(op,base,fail) {
    auto kind;
    if(op=='+') {xbin(0,0,1);return;}
    if(op=='-') {xbin(3,1,0);xmov(0,1);return;}
    if(op=='**') {xmul(0,1);return;}
    if(op=='&') {xbin(2,0,1);return;}
    if(op=='|') {xbin(1,0,1);return;}
    if(op=='^') {xbin(4,0,1);return;}
    kind= -1;
    if(op=='<') kind=12;if(op=='>') kind=15;
    if(op==100) kind=4;if(op==101) kind=5;
    if(op==102) kind=14;if(op==103) kind=13;
    if(kind>=0) {xbin(5,1,0);xcmpout(kind);return;}
    if(base<0 | base>4094) xfail();
    if(op==104 | op==105) {
        /* A full-word shift is zero; other counts retain the host masked extension. */
        xmovim(2,64);xbin(5,0,2);xcond(4,base);
        xmov(8,1);xmov(1,0);xmov(0,8);
        kind=0;if(op==105) kind=1;xshiftc(kind,0);xbranch(1,base+1);
        xmark(base);xmovim(0,0);xmark(base+1);return;
    }
    if(op=='/' | op=='%') {
        if(fail<0 | fail>4095 | fail==base | fail==base+1) xfail();
        xmovim(2,0);xbin(5,0,2);xcond(4,fail);
        /* Avoid IDIV's signed-overflow trap without changing B word wrapping. */
        xmovim(2,-9223372036854775807-1);xbin(5,1,2);xcond(5,base);
        xmovim(2,-1);xbin(5,0,2);xcond(5,base);
        if(op=='/') xmov(0,1);else xmovim(0,0);
        xbranch(1,base+1);xmark(base);
        xmov(8,0);xmov(0,1);xcqo();xunary(2,8);
        if(op=='%') xmov(0,2);
        xmark(base+1);return;
    }
    xfail();
}
xunop(op) {
    if(op=='-') {xunary(1,0);return;}
    if(op=='!') {xbin(6,0,0);xcmpout(4);return;}
    if(op==126) {xunary(0,0);return;}
    xfail();
}
