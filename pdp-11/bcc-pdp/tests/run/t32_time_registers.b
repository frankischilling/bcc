/* V1 time(II): high/low words come from AC/MQ, not R0/R1. */
main(){auto t 3,a,b; extrn time,putchar;
t[2]=77; time(t); a= *0177302; b= *0177304;
if(t[0]!=a | t[1]!=b | t[2]!=77)return(1);
putchar('O');putchar('K');putchar('*n');return(0);}
