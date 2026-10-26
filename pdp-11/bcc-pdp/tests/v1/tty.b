/* Requires a real V1 terminal; apout's tty traps are stubs. */
main(){auto t 4;extrn gtty,stty,putchar;
t[0]=12345;t[1]=12345;t[2]=12345;t[3]=77;
if(gtty(0,t)<0)return(1);
if(t[0]==12345 | t[1]==12345 | t[2]==12345 | t[3]!=77)return(2);
if(stty(0,t)<0)return(3);if(gtty(-1,t)>=0)return(4);
putchar('O');putchar('K');putchar('*n');return(0);}
