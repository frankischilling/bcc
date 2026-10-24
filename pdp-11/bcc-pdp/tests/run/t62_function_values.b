pack(a,b,c) { return(a*100+b*10+c); }
other(a,b,c) { return(a+b+c); }
apply(f,a,b,c) { return(f(a,b,c)); }
choose() { extrn pack; return(pack); }
main() {
    auto f,v 2;
    extrn pack,other,apply,choose,putchar;
    f=pack;
    if(f(1,2,3)!=123) return(1);
    if(apply(f,2,3,4)!=234) return(2);
    v[0]=pack; v[1]=other;
    if(v[0](3,4,5)!=345 | v[1](3,4,5)!=12) return(3);
    if((1?pack:other)(4,5,6)!=456) return(4);
    if((0?pack:other)(4,5,6)!=15) return(5);
    if(choose()(5,6,7)!=567) return(6);
    putchar('OK'); putchar('*n');
    return(0);
}
