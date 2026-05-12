/* Count digit characters in a string. */

text "unix v1 1971, b 1972, c 1973";

zero_counts(a, n) {
    auto i;
    i = 0;
    while (i < n) {
        a[i] = 0;
        i =+ 1;
    }

    return(0);
}

count_digits(s, counts) {
    auto i, c;

    i = 0;
    while ((c = char(s, i)) != '*e') {
        if (c >= '0' & c <= '9')
            counts[c - '0'] =+ 1;
        i =+ 1;
    }

    return(0);
}

main() {
    extrn printf;

    auto counts[10];
    auto i;

    zero_counts(counts, 10);
    count_digits(text, counts);

    i = 0;
    while (i < 10) {
        printf("%d: %d*n", i, counts[i]);
        i =+ 1;
    }

    return(0);
}
