main() {
    extrn putchar;
    auto x;
    x=0;
    switch 3 { case 1: x=100; }
    if(x!=0)return(1);
    switch 1 { case 1: x=+1; case 2: x=+2; }
    if(x!=3)return(2);
    goto entry;
    switch 99 { case 99: x=100; entry: x=+4; }
    if(x!=7)return(3);
    switch -32768 { case -32768: x=+1; }
    switch 0 {}
    if(x!=8)return(4);
    putchar('OK');putchar('*n');
    return(x!=8);
}
