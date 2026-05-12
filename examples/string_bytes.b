/* Byte-level string handling with char() and lchar(). */

copy_string(src, dst) {
    auto i, c;

    i = 0;
    while (1) {
        c = char(src, i);
        lchar(dst, i, c);
        if (c == '*e')
            return(i);
        i =+ 1;
    }
}

uppercase_string(s) {
    auto i, c;

    i = 0;
    while ((c = char(s, i)) != '*e') {
        if (c >= 'a' & c <= 'z')
            lchar(s, i, c - 'a' + 'A');
        i =+ 1;
    }

    return(0);
}

main() {
    extrn printf;

    auto buf[32];
    copy_string("bell labs b", buf);
    uppercase_string(buf);
    printf("%s*n", buf);

    return(0);
}
