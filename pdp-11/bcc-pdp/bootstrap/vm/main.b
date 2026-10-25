/* Open the bytecode and caller-owned heap file. This is not the final driver. */
main() {
    extrn argv,open,close;
    auto fd,hr,hw,n;
    if(argv[0]<2) return(1);
    fd=open(argv[2],0);if(fd<0) return(1);
    hr=open("heap.vm",0);if(hr<0) return(2);
    hw=open("heap.vm",1);if(hw<0) return(3);
    n=vmrun(fd,hr,hw);
    if(close(fd)<0 | close(hr)<0 | close(hw)<0) return(4);
    return(n);
}
