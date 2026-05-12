/* Euclid's algorithm for greatest common divisor. */

gcd(a, b) {
    auto t;

    while (b != 0) {
        t = b;
        b = a % b;
        a = t;
    }

    return(a);
}

main() {
    extrn printf;

    auto a, b;
    a = 252;
    b = 198;

    printf("gcd(%d, %d) = %d*n", a, b, gcd(a, b));
    return(0);
}
