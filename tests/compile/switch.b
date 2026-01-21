/* Switch statement tests */
main() {
    auto x, y;

    x = 2;

    switch (x) {
    case 1:
        y = 10;
        break;
    case 2:
        y = 20;
        break;
    case 3:
        y = 30;
        break;
    default:
        y = 0;
    }

    /* Switch without default */
    switch (x) {
    case 1:
        y = 1;
        break;
    case 2:
        y = 2;
        break;
    }

    return(y);
}
