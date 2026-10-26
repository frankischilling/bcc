/* Translate Linux x86-64 status into the host runtime's V1-shaped B cells. */
__stat(out,k) {
    auto mode,dir,flags,i,t;
    mode=k[3]&4294967295;dir=(mode&0170000)==040000;flags=0120000;
    if(dir)flags=flags|040000;
    if(k[6]>4096)flags=flags|010000;
    if(mode&04000)flags=flags|040;
    if(!dir)if(mode&0111)flags=flags|020;
    if(mode&0400)flags=flags|010;
    if(mode&0200)flags=flags|004;
    if(mode&04)flags=flags|002;
    if(mode&02)flags=flags|001;
    i=0;while(i<17)out[i++]=0;
    out[0]=k[1]&65535;out[1]=flags;
    out[2]=(((k[3]>>32)&255)<<8)|(k[2]&255);
    out[3]=k[6]&65535;
    t=(k[13]-31536000)*60+k[14]*60/1000000000;
    out[12]=(t>>16)&65535;out[13]=t&65535;
    t=(k[11]-31536000)*60+k[12]*60/1000000000;
    out[14]=(t>>16)&65535;out[15]=t&65535;
    return(0);
}
