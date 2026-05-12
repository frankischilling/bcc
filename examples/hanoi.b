/* Recursive Towers of Hanoi. */

move_disks(n, from, to, spare) {
    extrn printf;

    if (n == 0)
        return(0);

    move_disks(n - 1, from, spare, to);
    printf("move disk %d from %c to %c*n", n, from, to);
    move_disks(n - 1, spare, to, from);

    return(0);
}

main() {
    move_disks(3, 'A', 'C', 'B');
    return(0);
}
