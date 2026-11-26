main(){auto p,fd,b 1;extrn fork,wait,creat,write,read,open,close,unlink,exit,lchar,char,putchar;
p=fork();if(p<0)return(1);
if(p==0){fd=creat("child",016);if(fd<0)exit(2);lchar(b,0,'Y');write(fd,b,1);close(fd);exit(0);}
if(wait()!=p)return(3);fd=open("child",0);if(fd<0)return(4);
if(read(fd,b,1)!=1)return(5);close(fd);unlink("child");if(char(b,0)!='Y')return(6);
putchar('O');putchar('K');putchar('*n');return(0);}
