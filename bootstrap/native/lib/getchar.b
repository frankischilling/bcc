/* The B end marker also represents end-of-file and read failure. */
getchar() {
    extrn __sys;
    auto bytes 1,n;
    bytes[0]=0;n=__sys(0,0,bytes<<3,1,0,0,0);
    if(n==1)return(bytes[0]&255);
    return(4);
}
