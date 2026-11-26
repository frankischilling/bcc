/* Linux bridge for the counted B execv interface. No C argv is retained. */
execv(path,args,count) {
    extrn __sys,__env,__path;
    auto bytes 7800, pointers 256, used,i,c,p,start,offset;
    /* The native frame stores the actual count immediately before path. */
    if((&path)[-1]<3)return(-1);
    if(!path | count<0 | count>255)return(-1);
    if(count)if(!args)return(-1);
    used=__path(bytes,path);if(used<0)return(-1);used++;
    i=0;
    while(i<count){
        p=args[i];if(!p)return(-1);start=used;
        pointers[i]=(bytes<<3)+used;
        while(1){
            if(used>=62400)return(-1);
            offset=used-start;c=(p[offset>>3]>>((offset&7)<<3))&255;
            if(c==4)c=0;
            if(!(used&7))bytes[used>>3]=0;
            bytes[used>>3]=bytes[used>>3]|(c<<((used&7)<<3));used++;
            if(!c)goto argend;
        }
 argend:i++;
    }
    pointers[count]=0;
    __sys(59,bytes<<3,pointers<<3,__env,0,0,0);
    return(-1);
}
