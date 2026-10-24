choose(n) auto x; {x=n+1;return(x);}
outer(n) if(n) auto x; if(n==1) return(7); else return(9); else return(11);
main() {
    auto n;
    extrn choose,outer,putchar;
    if(choose(3)!=4 | outer(0)!=11 | outer(1)!=7 | outer(2)!=9)return(1);
    n=0;
    if(0) auto x; n=1;
    if(n!=0)return(2);
    if(1) extrn choose; n=choose(4);
    if(n!=5)return(3);
    putchar('OK');putchar('*n');return(0);
}
