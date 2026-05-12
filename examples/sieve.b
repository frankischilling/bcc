/* Sieve of Eratosthenes using a B vector. */

mark_multiples(composite, p, limit) {
    auto n;
    n = p * p;

    while (n <= limit) {
        composite[n] = 1;
        n =+ p;
    }

    return(0);
}

main() {
    extrn printf;

    auto composite[101];
    auto i, p, limit;

    limit = 100;
    i = 0;
    while (i <= limit) {
        composite[i] = 0;
        i =+ 1;
    }

    p = 2;
    while (p * p <= limit) {
        if (!composite[p])
            mark_multiples(composite, p, limit);
        p =+ 1;
    }

    printf("primes up to %d:*n", limit);
    i = 2;
    while (i <= limit) {
        if (!composite[i])
            printf("%d ", i);
        i =+ 1;
    }
    printf("*n");

    return(0);
}
