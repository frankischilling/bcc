/* bcc-example {"stdout":"-42\n","native":true,"bootstrap":true} */
/* Capture output from printf by supplying its putchar binding. */
out[16];used;
putchar(c) {
    extrn out,used,lchar;
    auto high;
    high=(c>>8)&0377;
    if(high)lchar(out,used++,high);
    lchar(out,used++,c);
    return(c);
}
main() {
    extrn printf,out,used,write;
    printf("%d*n",-42);
    if(used!=4)return(1);
    write(1,out,used);
    return(0);
}
