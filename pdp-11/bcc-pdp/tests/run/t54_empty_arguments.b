main() {
    extrn argv, char, putchar;
    if (argv[0]!=3) return(1);
    if (char(argv[2],0)!=0 | char(argv[3],3)!=' ') return(2);
    putchar('OK'); putchar('*n');
    return(0);
}
