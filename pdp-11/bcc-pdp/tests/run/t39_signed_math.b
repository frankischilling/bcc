main(){auto x;extrn putchar;
if(-6/2!=-3 | 6/-2!=-3 | -6/-2!=3)return(1);
if(-7/2!=-3 | 7/-2!=-3)return(2);
if(-7%2!=-1 | 7%-2!=1 | -6%2!=0)return(3);
if(-32768/1!=-32768 | -32768/-1!=-32768)return(4);
if(1/-32768!=0 | 1%-32768!=1)return(5);
x= -6;x=/2;if(x!=-3)return(6);
x= -7;x=%2;if(x!=-1)return(7);
putchar('O');putchar('K');putchar('*n');return(0);}
