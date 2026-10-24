main(){
    auto fd,b 3,c 3,i;
    extrn creat,open,close,write,read,char,lchar,putchar;
    i=0;while(i<6){lchar(b,i,'A'+i);lchar(c,i,'Z');i++;}
    fd=creat("xxwordfile"+1,016);if(fd<0)return(1);
    if(write(fd,b+1,2)!=2)return(2);close(fd);
    fd=open("xxwordfile"+1,0);if(fd<0)return(3);
    if(read(fd,c+1,2)!=2)return(4);close(fd);
    if(char(c,0)!='Z' | char(c,1)!='Z' | char(c,2)!='C' | char(c,3)!='D' | char(c,4)!='Z')return(5);
    putchar('OK');putchar('*n');return(0);
}
