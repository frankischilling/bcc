/* Format signed PDP-11 record fields in any seed word model. */
outd(n) {
    extrn char,lchar;
    auto buf 4,i;
    if(n==0) {outc('0');return;}
    if(n==-32768) {bouts("-32768");return;}
    if(n<0) {outc('-');n= -n;}
    i=0;
    while(n) {
        lchar(buf,i,'0'+n%10);
        i++; n=n/10;
    }
    while(i) outc(char(buf,--i));
}
