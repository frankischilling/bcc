/* Cache 16-bit instruction words in eight direct-mapped 64-byte lines. */
cache[256]; ctag[8] -1,-1,-1,-1,-1,-1,-1,-1; cbytes[8]; cbase[8] 0,32,64,96,128,160,192,224;
pc 0; codefd 0;
fetch() {
    extrn cache,ctag,cbytes,cbase,pc,codefd,seek,read,exit;
    auto p,i,s,q;
    if(pc<0 | pc>=16384) exit(11);
    p=pc>>5;s=p&7;
    if(ctag[s]==p) goto found;
    q=cache+cbase[s];
    if(seek(codefd,p*64,0)<0) exit(12);
    cbytes[s]=read(codefd,q,64);
    if(cbytes[s]<0) exit(13);
    ctag[s]=p;
 found:
    i=pc&31;
    if(i*2+1>=cbytes[s]) exit(14);
    q=cache+cbase[s];pc++;return(q[i]);
}
