/* B72 sections 4.1, 4.2, and 7.1: index expressions and scalar data tails. */
data 11,22,33;
pass(p) { return(p); }
main() {
    extrn data, pass, putchar;
    auto a 2, rows 2, p;
    if (data != 11) return(1);
    if ((&data)[1] != 22) return(2);
    p = &data;
    if (p[2] != 33) return(3);
    a[0] = 41;
    a[1] = 42;
    rows[0] = a;
    rows[1] = p;
    if (rows[0][1] != 42) return(4);
    if (pass(a)[0] != 41) return(5);
    if ((a+0)[1] != 42) return(6);
    rows[0][1]++;
    if (a[1] != 43) return(7);
    putchar('O'); putchar('K'); putchar('*n');
    return(0);
}
