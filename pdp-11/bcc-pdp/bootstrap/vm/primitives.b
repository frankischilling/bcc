/* Translate virtual B pointers at the primitive I/O boundary. */
vstr(s) {
    extrn ibuf,lchar;
    auto b,c,i;
    if(s==0) return(0);
    valid(s);
    b=s*2;
    i=0;
    while(i<256) {
        c=hbyte(b+i);
        lchar(ibuf,i,c);
        if(c==0 | c==4) return(ibuf);
        i++;
    }
    return(0);
}
vread(fd,byte,count) {
    extrn read,ibuf,char;
    auto n,i,c;
    n=read(fd,ibuf,count);
    i=0;
    while(i<n) {
        c=char(ibuf,i);
        hput(byte+i,c);
        i++;
    }
    return(n);
}
vwrite(fd,byte,count) {
    extrn write,ibuf,lchar;
    auto i,c;
    i=0;
    while(i<count) {
        c=hbyte(byte+i);
        lchar(ibuf,i,c);
        i++;
    }
    return(write(fd,ibuf,count));
}
vargch(x,y) {
    extrn argv,char;
    auto p,i;
    if(x<0 | x>=argv[0]-1 | y<0) return(-1);
    p=argv[x+2];i=0;
    while(i<y) {if(char(p,i)==0) return(0);i++;}
    return(char(p,y));
}
sysfun[12] read,write,open,creat,close,char,lchar,exit,unlink,seek,putchar,getchar;
vcall(op,args,n) {
    extrn sysfun,ibuf,read,write,char,lchar,exit,argv,sp,floor;
    auto x,y,z,p;
    x=hget(args);y=0;z=0;
    if(n>1) y=hget(args+1);
    if(n>2) z=hget(args+2);
    switch op {
    case 1:case 2:
        if(n<3) exit(27);
        if(y<0 | y>=8192 | z<0) return(-1);
        if(z>(8192-y)*2) return(-1);
        if(y==0) if(z!=0) return(-1);
        if(z>256) z=256;
        y=y*2;
        if(op==1) return(vread(x,y,z));
        return(vwrite(x,y,z));
    case 3:case 4:
        if(n<2) exit(27);
        x=vstr(x);
        goto call;
    case 5:case 11:case 12:goto call;
    case 6:case 7:
        if(n<2) exit(27);
        valid(x);p=x*2+y;
        if(op==6) return(hbyte(p));
        if(n<3) exit(27);
        return(hput(p,z));
    case 8:hflush(0);hflush(1);goto call;
    case 9:x=vstr(x);goto call;
    case 10:
        if(n<3) exit(27);
        if(z<0 | z>2) return(-1);
        goto call;
    case 13:return(argv[0]-1);
    case 14:
        if(n<2) exit(27);
        return(vargch(x,y));
    case 15:
        if(x<0 | x>sp-floor) return(0);
        p=floor;floor=floor+x;return(p);
    }
    exit(28);
 call:
    p=sysfun[op-1];p= *p;
    return(p(x,y,z));
}
