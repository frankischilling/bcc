/* Exercise native syscall arguments and B-to-Unix filename conversion. */
main(){
    extrn creat,open,close,read,write,seek,stat,fstat,link,unlink,chmod,chdir,lchar,char,putchar;
    auto fd,b 2,st 21,ft 21,i;
    fd=creat("plain",016); if(fd<0)return(1);
    lchar(b,0,'A');lchar(b,1,0);lchar(b,2,'B');
    if(write(fd,b,3)!=3)return(2);close(fd);
    if(chmod("plain",016)<0)return(3);
    fd=open("plain",0);if(fd<0)return(4);
    /* Kernels differ in how much of the reserved status buffer they fill. */
    i=0;while(i<21){st[i]=0;ft[i]=0;i++;}
    st[20]=77;ft[20]=88;
    if(stat("plain",st)<0)return(5);if(fstat(fd,ft)<0)return(6);
    if(st[20]!=77 | ft[20]!=88)return(7);
    i=0;while(i<17){if(st[i]!=ft[i])return(8);i++;}
    if(seek(fd,1,0)<0)return(9);
    if(read(fd,b,2)!=2)return(10);
    if(char(b,0)!=0 | char(b,1)!='B')return(11);
    close(fd);
    if(link("plain","alias")<0)return(12);
    if(unlink("alias")<0)return(13);
    if(open("alias",0)>=0)return(14);
    if(chdir(".")<0)return(15);
    if(seek(-1,0,0)>=0)return(16);
    putchar('O');putchar('K');putchar('*n');return(0);
}
