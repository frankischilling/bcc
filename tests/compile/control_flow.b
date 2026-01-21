/* Control flow tests */
main() {
    auto i, sum;

    /* If-else */
    if (1)
        i = 1;

    if (0)
        i = 0;
    else
        i = 1;

    /* While loop */
    i = 0;
    while (i < 10)
        i = i + 1;

    /* While with block */
    sum = 0;
    i = 1;
    while (i <= 10) {
        sum = sum + i;
        i = i + 1;
    }

    /* Nested if */
    if (i > 5)
        if (i < 15)
            sum = 1;
        else
            sum = 2;
    else
        sum = 0;

    return(sum);
}
