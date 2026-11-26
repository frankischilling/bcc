f(a,b,c,d,e) { return(a+b*2+c*3+d*4+e*5); }
zero() { return(17); }
main() {
    auto i,p,q;
    extrn f,zero,putchar;
    p=f; q=zero; i=0;
    while(i<2000) {
        if(p(1,2,3,4,5)!=55 | q()!=17) return(1);
        i++;
    }
    putchar('OK'); putchar('*n');
    return(0);
}
