time 17;
printn 42;
main() {
    extrn time, printn, write;
    if(time!=17 | printn!=42) return(1);
    if(write(1,"OK*n",3)!=3) return(2);
    return(0);
}
