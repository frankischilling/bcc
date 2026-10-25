main() {
    extrn open,close;
    auto fd,hr,hw,n;
    fd=open("one.vm",0);hr=open("heap.vm",0);hw=open("heap.vm",1);
    if(fd<0 | hr<0 | hw<0) return(1);
    n=vmrun(fd,hr,hw);if(n!=42) return(2);close(fd);
    fd=open("two.vm",0);if(fd<0) return(3);
    n=vmrun(fd,hr,hw);if(n!=43) return(4);
    if(close(fd)<0 | close(hr)<0 | close(hw)<0) return(5);
    return(0);
}
