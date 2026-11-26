/* bcc-example {"stdout":"OK\n","native":true,"bootstrap":true} */
/* Run in a scratch directory: this creates a directory named b72dir. */
main() {
    extrn mkdir, stat, printf;
    auto status 20;
    if(mkdir("b72dir",016)<0) return(1);
    if(stat("b72dir",status)<0) return(2);
    if(!(status[1]&040000)) return(3);
    printf("OK*n");
    return(0);
}
