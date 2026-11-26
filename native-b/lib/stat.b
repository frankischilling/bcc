stat(path,out) {
    extrn __path,__stat,__sys;
    auto bytes 512,k 18,r;
    if((&path)[-1]<2)return(-1);
    if(!out)return(-1);
    if(__path(bytes,path)<0)return(-1);
    r=__sys(4,bytes<<3,k<<3,0,0,0,0);
    if(r<0)return(-1);
    return(__stat(out,k));
}
