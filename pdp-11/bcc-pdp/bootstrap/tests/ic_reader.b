main(){
    extrn creat,write,close,open;
    auto buf 32,tag 5,fd,n;
    fd=creat("rec.ic",016);if(fd<0)return(1);
    if(write(fd,"n -32768*n",9)!=9)return(2);
    if(close(fd)<0)return(3);
    fd=open("rec.ic",0);if(fd<0)return(4);
    icini(fd);if(!getln(buf,64))return(5);
    icrst();nxtnam(buf,tag);if(!tageq(tag,"n"))return(6);
    n=nxti(buf);if(n!=-32768)return(7);
    if(getln(buf,64))return(8);
    if(close(fd)<0)return(9);
    outinit(1);outd(n);outc('*n');return(0);
}
