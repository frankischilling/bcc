chdir(path) {
    extrn __path,__sys;
    auto bytes 512,r;
    if((&path)[-1]<1)return(-1);
    if(__path(bytes,path)<0)return(-1);
    r=__sys(80,bytes<<3,0,0,0,0,0);
    return(r<0?-1:r);
}
