/* Output that resembles a shell prompt is still program output. */
main() {
    extrn putchar;
    auto i, j;
    putchar('#'); putchar(' ');
    i = 0;
    while (i < 100) {
        j = 0;
        while (j < 30000) j++;
        i++;
    }
    putchar('O'); putchar('K'); putchar('*n');
    return(0);
}
