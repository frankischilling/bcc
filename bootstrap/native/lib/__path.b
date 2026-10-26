/* Convert a B pathname to Linux bytes without invoking writable char cells. */
__path(out,s) {
    auto i,c,shift;
    if(!s)return(-1);
    i=0;
    while(i<4096){
        shift=(i&7)<<3;c=(s[i>>3]>>shift)&255;
        if(c==4)c=0;
        if(!(i&7))out[i>>3]=0;
        out[i>>3]=out[i>>3]|(c<<shift);
        if(!c)return(i);
        i++;
    }
    return(-1);
}
