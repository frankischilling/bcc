main() {
 extrn printf, printn, putstr, putchar;
 printf("%q%d|%%d|",7,8);
 printf("%d %o|",-17,-17);
 printf("%d|",(-32767-1));
 printn((-32767-1),10);
 printf("|%s|A*0B","C*0D");
 putstr("|E*0F");
 putchar('*n');
 return(0);
}
