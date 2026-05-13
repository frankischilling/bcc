add(a, b) {
    return(a + b);
}

mul(a, b) {
    return(a * b);
}

main() {
    extrn putchar;
    auto r;
    r = add(3, 4);
    putchar('0' + r);
    r = mul(2, 3);
    putchar('0' + r);
    putchar('*n');
    return(0);
}
