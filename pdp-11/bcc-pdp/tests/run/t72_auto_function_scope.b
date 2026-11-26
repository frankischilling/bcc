main() {
    extrn putchar;
    { auto x; x=37; }
    if(x!=37)return(1);
    if(1) auto y; y=41;
    if(y!=41)return(2);
    auto v 2; v[0]=x;v[1]=y;
    { auto w 2; w[0]=v[0];w[1]=v[1]; }
    if(w[0]+w[1]!=78)return(3);
    putchar('OK');putchar('*n');return(0);
}
