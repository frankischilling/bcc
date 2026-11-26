/* Pack the output bytes for the little-endian native host. */
putchar(c) {
    extrn __sys;
    auto bytes 1,hi,n;
    if((&c)[-1]<1)return(-1);
    hi=(c>>8)&255;n=1;
    if(hi){bytes[0]=hi|((c&255)<<8);n=2;}
    else bytes[0]=c&255;
    __sys(1,1,bytes<<3,n,0,0,0);
    return(c);
}
