/* Character constants and string bytes have different ordering. */
main() {
    auto v 2;
    extrn putchar, char;
    if ('AB' != 16706 | 'A*0' != 16640 | '*0B' != 66) return(1);
    v[0]='ab'; v[1]='cd';
    if (char(v,0)!='b' | char(v,1)!='a') return(2);
    if (char(v,2)!='d' | char(v,3)!='c') return(3);
    putchar(0); putchar('A*0'); putchar('*0B'); putchar(65408);
    return(0);
}
