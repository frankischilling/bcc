/* BCC captures assignment destinations before their right-hand sides. */
main(){
    extrn putchar;
    auto x,y,v 2;
    x=0;v[0]=5;v[1]=10;v[x++]=(x=1);if(x!=1 | v[0]!=1 | v[1]!=10)return(1);
    x=0;v[0]=5;v[1]=10;v[x++]=+(x=1);if(x!=1 | v[0]!=6 | v[1]!=10)return(2);
    x=0;v[0]=5;v[1]=10;v[x++]=-(x=1);if(x!=1 | v[0]!=4 | v[1]!=10)return(3);
    x=0;v[0]=5;v[1]=10;v[x++]=*(x=1);if(x!=1 | v[0]!=5 | v[1]!=10)return(4);
    x=0;v[0]=5;v[1]=10;v[x++]=/(x=1);if(x!=1 | v[0]!=5 | v[1]!=10)return(5);
    x=0;v[0]=5;v[1]=10;v[x++]=%(x=1);if(x!=1 | v[0]!=0 | v[1]!=10)return(6);
    x=0;v[0]=5;v[1]=10;v[x++]=&(x=1);if(x!=1 | v[0]!=1 | v[1]!=10)return(7);
    x=0;v[0]=5;v[1]=10;v[x++]=|(x=1);if(x!=1 | v[0]!=5 | v[1]!=10)return(8);
    x=0;v[0]=5;v[1]=10;v[x++]=<(x=1);if(x!=1 | v[0]!=0 | v[1]!=10)return(9);
    x=0;v[0]=5;v[1]=10;v[x++]=>(x=1);if(x!=1 | v[0]!=1 | v[1]!=10)return(10);
    x=0;v[0]=5;v[1]=10;v[x++]===(x=1);if(x!=1 | v[0]!=0 | v[1]!=10)return(11);
    x=0;v[0]=5;v[1]=10;v[x++]=!=(x=1);if(x!=1 | v[0]!=1 | v[1]!=10)return(12);
    x=0;v[0]=5;v[1]=10;v[x++]=<=(x=1);if(x!=1 | v[0]!=0 | v[1]!=10)return(13);
    x=0;v[0]=5;v[1]=10;v[x++]=>=(x=1);if(x!=1 | v[0]!=1 | v[1]!=10)return(14);
    x=0;v[0]=5;v[1]=10;v[x++]=<<(x=1);if(x!=1 | v[0]!=10 | v[1]!=10)return(15);
    x=0;v[0]=5;v[1]=10;v[x++]=>>(x=1);if(x!=1 | v[0]!=2 | v[1]!=10)return(16);
    putchar('OK');putchar('*n');return(0);
}
