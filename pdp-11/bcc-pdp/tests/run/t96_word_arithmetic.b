main() {
    extrn putchar;
    auto x,y,v 2;
    x= -1;
    if((x>>1)!=32767) return(1);
    x=>>1;
    if(x!=32767) return(2);
    x=32767; y=x++;
    if(y!=32767 | x!=(-32767-1)) return(3);
    y=x--;
    if(y!=(-32767-1) | x!=32767) return(4);
    x=1; x=<<15;
    if(x!=(-32767-1)) return(5);
    x=0; v[0]=32767; v[1]=7;
    v[x++]=+1;
    if(x!=1 | v[0]!=(-32767-1) | v[1]!=7) return(6);
    x= -1; if((x>>16)!=0 | (x<<16)!=0) return(7);
    x=>>16; if(x!=0) return(8);
    x=1; x=<<16; if(x!=0) return(9);
    x=0; v[0]=7; v[1]=9; v[x++]=<8;
    if(x!=1 | v[0]!=1 | v[1]!=9) return(10);
    putchar('OK'); putchar('*n');
    return(0);
}
