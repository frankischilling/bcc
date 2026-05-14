main() {
    auto a[3], p;
    a[0] = 3;
    a[1] = 4;
    p = &a[0];
    if (*p != 3) return(1);
    if (a[1] != 4) return(2);
    return(0);
}
