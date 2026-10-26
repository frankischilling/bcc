/* Labels keep their identity across calls, functions, and writable cells. */
f(n) {
    if(n) return(&done);
    return(done);
 done: return(11);
}
g(n) {
    if(n) return(&done);
    return(done);
 done: return(22);
}
main() {
    extrn f,g,putchar;
    if(f(0)==g(0)) return(1);
    if(f(0)!=f(0) | g(0)!=g(0)) return(2);
    if(f(1)==g(1) | *f(1)!=f(0) | *g(1)!=g(0)) return(3);
    putchar('OK');putchar('*n');
    return(0);
}
