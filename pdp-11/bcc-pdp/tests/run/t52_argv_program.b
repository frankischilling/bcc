main() {
    extrn argv, char, putchar;
    if (argv[0]!=1 | !argv[1]) return(1);
    if (!char(argv[1],0)) return(2);
    putchar('OK'); putchar('*n');
    return(0);
}
