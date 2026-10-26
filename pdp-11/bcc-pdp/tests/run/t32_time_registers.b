/* V1 time(II): AC/MQ byte addresses are converted to B word addresses. */
main(){auto t 3,a,b; extrn time,putchar;
t[2]=77; time(t); a= *(0177302>>1); b= *(0177304>>1);
if(t[0]!=a | t[1]!=b | t[2]!=77)return(1);
putchar('O');putchar('K');putchar('*n');return(0);}
