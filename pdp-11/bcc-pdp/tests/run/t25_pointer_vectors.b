/* B72 4.2 and 7.2: indexing reads a pointer value; vectors own pointer cells. */
gv[3] 7,8,9;
at(p) { return(p[1]); }
main() {
    extrn gv, at, putchar;
    auto a 3, b 3, p, q;
    if (gv[1] != 8) return(1);
    a[0] = 10;
    a[1] = 20;
    a[2] = 30;
    p = a;
    p[1] = 42;
    if (a[1] != 42) return(2);
    if (at(a) != 42) return(3);
    if (*&a != a) return(4);
    if (&a == a) return(5);
    q = &p;
    if (q[0] != p) return(6);
    if (*&gv != gv) return(7);
    b[1] = 51;
    a = b;
    if (a[1] != 51) return(8);
    gv = p;
    if (gv[1] != 42) return(9);
    putchar('O'); putchar('K'); putchar('*n');
    return(0);
}
