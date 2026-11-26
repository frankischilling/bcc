check(a,b,c) {
    extrn check;
    auto p;
    p= &a;
    if(p[0]!=a | p[1]!=b | p[2]!=c) return(1);
    p[1]=42;
    if(b!=42) return(2);
    if(a) if(check(a-1,22,33)) return(3);
    return(p[0]!=a | p[1]!=42 | p[2]!=c);
}
main() {
    extrn check, putchar;
    auto b;
    b=22;
    if(check(3,b,33) | b!=22) return(1);
    putchar('OK'); putchar('*n');
    return(0);
}
