fstat(fd,out) {
    extrn __stat,__sys;
    auto k 18,r;
    if((&fd)[-1]<2)return(-1);
    if(!out)return(-1);
    r=__sys(5,fd,k<<3,0,0,0,0);
    if(r<0)return(-1);
    return(__stat(out,k));
}
