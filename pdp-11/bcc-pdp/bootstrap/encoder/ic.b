/* The compiler records use ASCII fields and NUL-terminated work buffers. */
bcur 0;
icfd 0; ibuf[64]; ipos 0; ilen 0;
getln(buf,max) {
    extrn icfd,ibuf,ipos,ilen,read,char,lchar;
    auto i,c;
    i=0;
    while(1) {
        if(ipos>=ilen) {
            ilen=read(icfd,ibuf,128);ipos=0;
            if(ilen<0) fatal("cannot read IC");
        }
        if(ilen==0) {lchar(buf,i,0);return(i!=0);}
        c=char(ibuf,ipos++);
        if(c=='*n') {lchar(buf,i,0);return(1);}
        if(i>=max-1) fatal("IC line too long");
        lchar(buf,i++,c);
    }
}
icini(fd) {
    extrn icfd,bcur,ipos,ilen;
    icfd=fd;bcur=0;ipos=0;ilen=0;
}
icrst() {extrn bcur;bcur=0;}
skpws(buf) {
    extrn bcur,char;
    while(char(buf,bcur)==' ') bcur++;
    return(char(buf,bcur));
}
nxti(buf) {
    extrn bcur,char;
    auto v,neg,digit,last,c;
    skpws(buf);neg=0;
    if(char(buf,bcur)=='-') {neg=1;bcur++;}
    c=char(buf,bcur);
    if(c<'0' | c>'9') fatal("bad IC integer");
    last=7;if(neg) last=8;
    v=0;
    while((c=char(buf,bcur))>='0' & c<='9') {
        digit=c-'0';
        if(v< -3276) fatal("IC integer out of range");
        if(v==-3276) if(digit>last) fatal("IC integer out of range");
        v=v*10-digit;bcur++;
    }
    if(c!=0 & c!=' ') fatal("bad IC integer");
    if(neg) return(v);
    return(-v);
}
nxtnam(buf,name) {
    extrn bcur,char,lchar;
    auto i,c;
    skpws(buf);i=0;
    while(i<8) {
        c=char(buf,bcur);
        if(c==0 | c==' ') goto pad;
        lchar(name,i++,c);bcur++;
    }
 pad:
    while(i<=8) lchar(name,i++,0);
}
/* Only the second operand is a B literal; the first is a raw IC token. */
tageq(a,b) {
    extrn char;
    auto i,ca,cb;
    i=0;
    while(1) {
        ca=char(a,i);cb=char(b,i);
        if(cb==4) cb=0;
        if(ca!=cb) return(0);
        if(ca==0) return(1);
        i++;
    }
}
