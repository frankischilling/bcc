/* Print primes up to 50 */

isprime(n) {
    auto i;
    if (n < 2) return(0);
    if (n == 2) return(1);
    if (n % 2 == 0) return(0);
    i = 3;
    while (i * i <= n) {
        if (n % i == 0)
            return(0);
        i = i + 2;
    }
    return(1);
}

printnum(n) {
    if (n >= 10)
        printnum(n / 10);
    putchar('0' + n % 10);
}

main() {
    auto i, count;
    count = 0;
    i = 2;
    while (i <= 50) {
        if (isprime(i)) {
            printnum(i);
            putchar(' ');
            count = count + 1;
        }
        i = i + 1;
    }
    putchar('*n');
    return(count);
}
