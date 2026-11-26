/* Names use nine packed bytes regardless of the host word size. */
snam[1152]; scls[1024]; soff[1024]; symlimit 1024;
ghbuf[1024]; ghlimit 8191;
resinit() {
    if(65535+1==0 | 2147483647+1<0)
        fatal("64-bit resolver requires 64-bit words");
    return(0);
}
