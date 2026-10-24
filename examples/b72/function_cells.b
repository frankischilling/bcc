/* bcc-example {"stdout":"9 7\n","native":true,"bootstrap":true} */
/* Replacing a function name does not change a saved copy of its old value. */
first() return(7);
second() return(9);
main() {
    extrn first, second, printf;
    auto saved;
    saved=first;
    first=second;
    printf("%d %d*n",first(),saved());
    return(0);
}
