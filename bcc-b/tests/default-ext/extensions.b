// default mode accepts host bcc extensions
values[] { 0x10, 'abcd' };
text "a\n";
gradient "@#*+ ";

single(x) return(x + later_global);

bare() {
    return;
}

uses_later() {
    return(later_global);
}

later_global 7;

main() {
    auto x;
    auto local 3;
    x = 1;
    x += 2;
    if (x != 3) return(1);
    if (!(0 || 1)) return(2);
    if (values[0] != 16) return(3);
    if (char(text, 1) != 10) return(4);
    if (char(gradient, 2) != '*') return(5);
    if (single(5) != 12) return(6);
    if (uses_later() != 7) return(7);
    local[0] = 9;
    if (local[0] != 9) return(8);
    switch x {
    case 3:
        x = 4;
    }
    if (x != 4) return(9);
    if (bare() != 0) return(10);
    return(0);
}
