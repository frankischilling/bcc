// https://en.wikipedia.org/wiki/Duff%27s_device
duffs_device(s) {
    extrn putchar;
    auto n, count, i;
    count = 0;
    // Count characters in B string (terminated by *e = 004)
    while (char(s, count) != 004) count =+ 1;
    n = (count + 7) / 8;
    i = 0;  // character index
    switch count%8 {
    case 0: while(1) { putchar(char(s, i++));
    case 7:            putchar(char(s, i++));
    case 6:            putchar(char(s, i++));
    case 5:            putchar(char(s, i++));
    case 4:            putchar(char(s, i++));
    case 3:            putchar(char(s, i++));
    case 2:            putchar(char(s, i++));
    case 1:            putchar(char(s, i++));
                       putchar('|');
                       putchar('\n');
                       if (--n <= 0) return;
            }
    }
}

main() {
    duffs_device("The quick brown fox jumps over the lazy dog.");
}
