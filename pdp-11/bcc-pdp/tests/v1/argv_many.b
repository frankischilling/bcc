/* Re-enter the same image with more arguments than the old startup limit. */
main(count, values) {
    extrn argv, execv, char, putchar;
    auto v 41, i;
    if (argv[0] == 1) {
        v[0] = "chosen";
        i = 1;
        while (i < 41) { v[i] = "x"; i++; }
        execv("./a.out", v, 41);
        return(1);
    }
    if (argv[0] != 41 | count != 40) return(2);
    if (char(argv[1], 0) != 'c') return(3);
    i = 0;
    while (i < count) {
        if (values[i] != argv[i+2] | char(values[i], 0) != 'x') return(4);
        i++;
    }
    putchar('OK'); putchar('*n');
    return(0);
}
