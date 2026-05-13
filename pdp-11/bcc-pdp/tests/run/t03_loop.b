main() {
    extrn putchar;
    auto i;
    i = 0;
    while (i < 5) {
        putchar('0' + i);
        i = i + 1;
    }
    putchar('*n');
    return(0);
}
