/* Read little-endian instruction words through a 128-byte cache. */
cache[64]; pc 0; page -1; nbyte 0; codefd 0;
fetch() {
    extrn cache,pc,page,nbyte,codefd,seek,read,char,exit;
    auto p,i,w,hi;
    if(pc<0 | pc>=16384) exit(11);
    p=pc/64;
    if(p!=page) {
        if(seek(codefd,p*128,0)<0) exit(12);
        nbyte=read(codefd,cache,128);
        if(nbyte<0) exit(13);
        page=p;
    }
    i=(pc%64)*2;
    if(i+1>=nbyte) exit(14);
    w=char(cache,i);hi=char(cache,i+1);
    if(hi>=128) hi=hi-256;
    pc++;return(w+hi*256);
}
