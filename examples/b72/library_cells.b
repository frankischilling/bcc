/* bcc-example {"stdout":"OK\n","native":true,"bootstrap":true} */
/* Temporarily capture output, then restore the library implementation. */
count;
capture(c) {
    extrn count;
    count++;
    return(c);
}
main() {
    extrn putchar, capture, count;
    auto saved, cell;
    saved = putchar;
    cell = &putchar;
    *cell = capture;
    putchar('x');
    *cell = saved;
    if (count != 1) return(1);
    putchar('OK');
    putchar('*n');
    return(0);
}
