main() {
    extrn open,close,putchar;
    auto fd,hr,hw,n,i,c;
    fd=open("code.vm",0);if(fd<0) return(1);
    hr=open("heap.vm",0);if(hr<0) return(2);
    hw=open("heap.vm",1);if(hw<0) return(3);
    n=vmrun(fd,hr,hw);
    if(close(fd)<0 | close(hr)<0 | close(hw)<0) return(4);
    i=12;
    while(i>=0) {
        c=(n>>i)&15;
        if(c<10) c=c+'0';else c=c+'a'-10;
        putchar(c);i=i-4;
    }
    putchar('*n');return(0);
}
