main() {
    extrn putchar;
    auto x;
    x = 7;
    if (x > 5)
        putchar('Y');
    else
        putchar('N');
    if (x == 7)
        putchar('=');
    else
        putchar('!');
    putchar('*n');
    return(0);
}
