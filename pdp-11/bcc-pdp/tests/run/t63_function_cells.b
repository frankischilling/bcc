f() { return(7); }
g() { return(9); }
refs[1] f;
main() {
    auto p,saved;
    extrn f,g,refs,putchar;
    p= &f; saved=f;
    if(*p!=f | refs[0]!=p) return(1);
    f=g;
    if(f()!=9 | (*refs[0])()!=9 | saved()!=7) return(2);
    *p=saved;
    if(f()!=7) return(3);
    putchar('OK'); putchar('*n');
    return(0);
}
