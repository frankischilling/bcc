/* B72 ctime: zero, boundaries, leap day, and unsigned words. */
main(){auto t 2, date 9, i; extrn ctime,lchar,putchar,char;
t[0]=0; t[1]=0;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=0; t[1]=59;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=0; t[1]=60;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=0; t[1]=65535;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=1; t[1]=0;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=79; t[1]=6655;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=79; t[1]=6656;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=4666; t[1]=65024;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=28872; t[1]=4548;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=33540; t[1]=62016;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=57823; t[1]=15872;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
t[0]=65535; t[1]=65535;
lchar(date,16,'X'); lchar(date,17,'Y'); ctime(t,date);
i=0; while(i<18){putchar(char(date,i)); i=i+1;}
return(0);}
