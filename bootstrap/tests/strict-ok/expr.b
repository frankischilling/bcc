main() {
    auto x, y;
    x = 5;
    y = 2;
    x =+ y * 3;
    if (x != 11) return(1);
    if ((x > 10 ? 7 : 9) != 7) return(2);
    return(0);
}
