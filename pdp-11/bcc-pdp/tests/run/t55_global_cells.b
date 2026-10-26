data 11,22,33;
refs[2] data,data;
main() {
    auto p;
    extrn data, refs, putchar;
    p = &data;
    if (data!=11 | p[1]!=22 | p[2]!=33) return(1);
    if (refs[0]!=p | refs[1]!=p) return(2);
    p[0]=99; p[1]=77;
    if (data!=99 | p[1]!=77) return(3);
    putchar('OK'); putchar('*n');
    return(0);
}
