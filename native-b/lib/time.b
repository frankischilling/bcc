time(out) {
    extrn __sys,__ticks;
    auto now 2,t;
    if((&out)[-1]<1)return(-1);
    if(__sys(228,0,now<<3,0,0,0,0)<0)return(-1);
    t=__ticks(now[0],now[1]);
    if(out){out[0]=t>>16;out[1]=t&65535;}
    return(0);
}
