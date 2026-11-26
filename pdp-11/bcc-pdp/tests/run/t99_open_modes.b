main() {
    extrn creat, open, close, read, write, char, putchar;
    auto fd, data 2;
    fd = creat("openmode", 017);
    if (fd < 0) return(1);
    if (write(fd, "abc", 3) != 3) return(2);
    close(fd);
    fd = open("openmode", 2);
    if (fd < 0) return(3);
    if (write(fd, "Z", 1) != 1) return(4);
    if (read(fd, data, 1) != -1) return(5);
    close(fd);
    fd = open("openmode", -1);
    if (fd < 0) return(6);
    if (write(fd, "Y", 1) != 1) return(7);
    close(fd);
    fd = open("openmode", 0);
    if (fd < 0) return(8);
    if (read(fd, data, 3) != 3) return(9);
    if (char(data, 0) != 'Y' | char(data, 1) != 'b' | char(data, 2) != 'c') return(10);
    if (write(fd, "X", 1) != -1) return(11);
    close(fd);
    putchar('O'); putchar('K'); putchar('*n');
    return(0);
}
