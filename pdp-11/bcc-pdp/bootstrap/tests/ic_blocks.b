/* Records cross input blocks; reopening must discard unread buffered bytes. */
main() {
    extrn creat,write,close,open,lchar,char;
    auto data 128,buf 128,fd,i;
    i=0;while(i<255) lchar(data,i++,'x');
    lchar(data,255,'*n');
    fd=creat("block.ic",016);if(fd<0)return(1);
    if(write(fd,data,256)!=256)return(2);
    if(write(fd,"tail*nunused*n",12)!=12)return(3);
    if(close(fd)<0)return(4);
    fd=open("block.ic",0);if(fd<0)return(5);
    icini(fd);if(!getln(buf,256))return(6);
    i=0;while(i<255) if(char(buf,i++)!='x')return(7);
    if(char(buf,255)!=0)return(8);
    if(!getln(buf,256))return(9);
    if(!tageq(buf,"tail"))return(10);
    if(close(fd)<0)return(11);
    fd=creat("short.ic",016);if(fd<0)return(12);
    if(write(fd,"last",4)!=4)return(13);
    if(close(fd)<0)return(14);
    fd=open("short.ic",0);if(fd<0)return(15);
    icini(fd);if(!getln(buf,256))return(16);
    if(!tageq(buf,"last"))return(17);
    if(getln(buf,256))return(18);
    if(close(fd)<0)return(19);
    bouts("records ok*n");return(0);
}
