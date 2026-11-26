main() {
    auto i, s;
    i = 0;
    s = 0;
    while (i < 5) {
        s = s + i;
        i++;
    }
    switch (s) {
    case 10:
        return(0);
    default:
        return(1);
    }
}
