count;
putchar(c) { extrn count; count++; return(c); }
printn(n,b) { extrn putchar; putchar('P'); return(0); }
main() {
    extrn count, printn, printf, write;
    printn(42,10);
    printf("%d %o",12,8);
    if(count!=4) return(1);
    if(write(1,"OK*n",3)!=3) return(2);
    return(0);
}
