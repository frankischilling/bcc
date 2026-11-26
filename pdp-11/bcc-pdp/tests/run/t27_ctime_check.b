/* Validate binary date bytes internally; print only an ASCII verdict. */
cktime(t,s){auto d 9,i; extrn ctime,char,lchar; lchar(d,16,88);lchar(d,17,89);ctime(t,d);i=0;while(i<15){if(char(d,i)!=char(s,i))return(1);i++;}return(char(d,15)!=0 | char(d,16)!=88 | char(d,17)!=89);}
main(){auto t 2; extrn cktime,putchar;
t[0]=0;t[1]=0;if(cktime(t,"Jan  1 00:00:00"))return(1);
t[0]=0;t[1]=59;if(cktime(t,"Jan  1 00:00:00"))return(1);
t[0]=0;t[1]=60;if(cktime(t,"Jan  1 00:00:01"))return(1);
t[0]=0;t[1]=65535;if(cktime(t,"Jan  1 00:18:12"))return(1);
t[0]=1;t[1]=0;if(cktime(t,"Jan  1 00:18:12"))return(1);
t[0]=79;t[1]=6655;if(cktime(t,"Jan  1 23:59:59"))return(1);
t[0]=79;t[1]=6656;if(cktime(t,"Jan  2 00:00:00"))return(1);
t[0]=4666;t[1]=65024;if(cktime(t,"Mar  1 00:00:00"))return(1);
t[0]=28872;t[1]=4548;if(cktime(t,"Dec 31 23:59:59"))return(1);
t[0]=33540;t[1]=62016;if(cktime(t,"Feb 29 00:34:17"))return(1);
t[0]=57823;t[1]=15872;if(cktime(t,"Jan  1 00:00:00"))return(1);
t[0]=65535;t[1]=65535;if(cktime(t,"Apr  8 12:06:28"))return(1);
putchar('O');putchar('K');putchar('*n');return(0);}
