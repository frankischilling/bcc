/* Array tests */
global[10];
initialized[] { 1, 2, 3, 4, 5 };

main() {
    auto local[5];
    auto i;

    /* Array access */
    global[0] = 1;
    global[9] = 10;

    /* Local array */
    local[0] = 100;
    local[4] = 500;

    /* Initialized array access */
    i = initialized[0];
    i = initialized[4];

    /* Computed index */
    i = 3;
    global[i] = 42;

    return(global[i]);
}
