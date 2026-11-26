/* Host-native literals require a 64-bit seed or self-hosted compiler. */
frontini() {
    if(65535+1==0 | 2147483647+1<0)
        fatal("64-bit frontend requires 64-bit words");
    return(0);
}
wordval(v) {return(v);}
