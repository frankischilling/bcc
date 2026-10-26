main(){auto v 1;extrn execv,execl,putchar;v[0]="arg0";
if(execv("missing",v,1)!=-1)return(1);if(execl("missing","arg0",0)!=-1)return(2);
if(execv("/bin/echo",0,-1)!=-1)return(3);
putchar('O');putchar('K');putchar('*n');return(0);}
