/* Compact-code paging experiment, not a complete B execution engine. */
cache[256]; cells[3072]; pc 0; page -1; nbyte 0; codefd 0;
fetch() {
    extrn cache,pc,page,nbyte,codefd,seek,read,char,exit;
    auto p,i,w,hi;
    if(pc<0 | pc>=16384) exit(11);
    p=pc/256;
    if(p!=page) {
        if(seek(codefd,p*512,0)<0) exit(12);
        nbyte=read(codefd,cache,512);
        if(nbyte<0) exit(13);
        page=p;
    }
    i=(pc%256)*2;
    if(i+1>=nbyte) exit(14);
    w=char(cache,i);hi=char(cache,i+1);
    if(hi>=128) hi=hi-256;
    pc++;return(w+hi*256);
}
run(fd) {
    extrn codefd,pc,page,cells,exit;
    auto a,op,at,n;
    codefd=fd;pc=0;page= -1;a=0;n=0;
 next:
    if(++n==30000) exit(15);
    op=fetch();
    switch op {
    case 0:return(a);
    case 1:a=fetch();goto next;
    case 2:at=fetch();if(at<0 | at>=3072)exit(16);a=cells[at];goto next;
    case 3:at=fetch();if(at<0 | at>=3072)exit(16);cells[at]=a;goto next;
    case 4:a=a+fetch();goto next;
    case 5:a=a<fetch();goto next;
    case 6:at=fetch();pc=at;goto next;
    case 7:at=fetch();if(a==0)pc=at;goto next;
    }
    exit(17);
}
/* Count to 1000; the exit branch fetches an instruction across a page. */
code[16] 1,0,3,0,2,0,4,1,3,0,5,1000,7,255,6,4;
main() {
    extrn cache,cells,code,lchar,creat,write,close,open,putchar;
    auto fd,i,n;
    cells[3071]=12345;
    fd=creat("code.vm",016);if(fd<0)return(1);
    i=0;while(i<512){lchar(cache,i,0);i++;}
    i=0;while(i<16){n=code[i];lchar(cache,i*2,n);lchar(cache,i*2+1,n>>8);i++;}
    lchar(cache,510,2);
    if(write(fd,cache,512)!=512)return(2);
    i=0;while(i<512){lchar(cache,i,0);i++;}
    if(write(fd,cache,512)!=512)return(3);
    if(close(fd)<0)return(4);
    fd=open("code.vm",0);if(fd<0)return(5);
    n=run(fd);if(close(fd)<0)return(6);
    if(n!=1000 | cells[3071]!=12345)return(7);
    putchar('OK');putchar('*n');return(0);
}
