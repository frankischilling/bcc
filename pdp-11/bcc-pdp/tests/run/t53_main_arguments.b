/* Preserve the optional main parameters' user-argument layout. */
main(count, values) {
    extrn argv, char, putchar;
    if (count!=2 | argv[0]!=3) return(1);
    if (values[0]!=argv[2] | values[1]!=argv[3]) return(2);
    if (char(values[0],0)!='a' | char(values[1],0)!='b') return(3);
    putchar('OK'); putchar('*n');
    return(0);
}
