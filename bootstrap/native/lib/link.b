link(from,to) {
    extrn __path,__sys;
    auto first 512,second 512,r;
    if((&from)[-1]<2)return(-1);
    if(__path(first,from)<0)return(-1);
    if(__path(second,to)<0)return(-1);
    r=__sys(86,first<<3,second<<3,0,0,0,0);
    return(r<0?-1:r);
}
