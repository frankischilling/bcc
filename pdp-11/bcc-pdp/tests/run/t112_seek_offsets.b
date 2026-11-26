/* Exercise all absolute offset bits without allocating a large file. */
main() {
    extrn creat,open,write,read,close,seek,char,unlink,putchar;
    auto fd,b 2;
    fd=creat("seek.tmp",016);if(fd<0)return(1);
    if(write(fd,"ABC",3)!=3)return(2);
    if(close(fd)<0)return(3);
    fd=open("seek.tmp",0);if(fd<0)return(4);
    if(seek(fd,32768,0)!=0)return(5);
    if(seek(fd,-32768,1)!=0)return(6);
    if(read(fd,b,1)!=1 | char(b,0)!='A')return(7);
    if(seek(fd,65535,0)!=0)return(8);
    if(seek(fd,-32767,1)!=0)return(9);
    if(seek(fd,-32768,1)!=0)return(10);
    if(read(fd,b,1)!=1 | char(b,0)!='A')return(11);
    if(seek(fd,-1,0)!=0)return(12);
    if(seek(fd,-32767,1)!=0)return(13);
    if(seek(fd,-32768,1)!=0)return(14);
    if(read(fd,b,1)!=1 | char(b,0)!='A')return(15);
    if(seek(fd,-1,2)!=0)return(16);
    if(read(fd,b,1)!=1 | char(b,0)!='C')return(17);
    if(close(fd)<0)return(18);unlink("seek.tmp");
    putchar('OK');putchar('*n');return(0);
}
