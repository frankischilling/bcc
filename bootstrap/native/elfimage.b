/* Fixed-address Linux x86-64 image packaging, not an instruction selector. */
obuf[256]; ibuf[256]; opos; written;

fail() {
    extrn write,exit;
    write(2,"elfimage: invalid input or I/O failure*n",39);
    exit(1);
}
flush() {
    extrn write,obuf,opos;
    if(opos) if(write(1,obuf,opos)!=opos) fail();
    opos=0;
}
byte(v) {
    extrn lchar,obuf,opos,written;
    lchar(obuf,opos++,v);written++;
    if(opos==1024) flush();
}
number(v,n) {
    while(n) {byte(v&255);v=v>>8;n--;}
}
zeros(n) {
    while(n) {byte(0);n--;}
}

/* Counts fit in a signed 32-bit B word; ELF fields are serialized explicitly. */
decimal(s) {
    extrn char;
    auto i,c,n;
    i=0;n=0;
    if(!char(s,0)) fail();
    while((c=char(s,i++))!=0) {
        if(c<'0'|c>'9') fail();
        c=c-'0';
        if(n>(16777216-c)/10) fail();
        n=n*10+c;
    }
    return(n);
}
length(fd) {
    extrn read,seek,ibuf;
    auto n,total;
    total=0;
 loop:
    n=read(fd,ibuf,1024);
    if(n<0) fail();
    if(!n) goto done;
    if(n>16777216-total) fail();
    total=total+n;
    goto loop;
 done:
    if(seek(fd,0,0)<0) fail();
    return(total);
}
copy(fd,size) {
    extrn read,ibuf,char;
    auto n,total,i;
    total=0;
 loop:
    n=read(fd,ibuf,1024);
    if(n<0) fail();
    if(!n) goto done;
    if(n>size-total) fail();
    total=total+n;i=0;
    while(i<n) byte(char(ibuf,i++));
    goto loop;
 done:
    if(total!=size) fail();
}
segment(kind,flags,off,addr,filesz,memsz,align) {
    number(kind,4);number(flags,4);number(off,8);number(addr,8);
    number(0,8);number(filesz,8);number(memsz,8);number(align,8);
}
main() {
    extrn argv,open,close,written,opos,write;
    auto cf,df,cs,ds,bss,entry,dataoff;
    if(argv[0]!=5) {
        write(2,"usage: elfimage code data bss entry > output*n",45);
        return(1);
    }
    if(16777216<1) fail();
    bss=decimal(argv[4]);entry=decimal(argv[5]);
    cf=open(argv[2],0);
    if(cf<0|cf==1) fail();
    df=open(argv[3],0);
    if(df<0|df==1) fail();
    cs=length(cf);ds=length(df);
    if(!cs|entry>=cs) fail();
    dataoff=((4096+cs+4095)/4096)*4096;
    written=0;opos=0;

    /* ELF64 header, followed by text, data and non-executable-stack headers. */
    byte(127);byte('E');byte('L');byte('F');byte(2);byte(1);byte(1);zeros(9);
    number(2,2);number(62,2);number(1,4);
    number(4198400+entry,8);number(64,8);number(0,8);number(0,4);
    number(64,2);number(56,2);number(3,2);number(0,2);number(0,2);number(0,2);
    segment(1,5,0,4194304,4096+cs,4096+cs,4096);
    segment(1,6,dataoff,4194304+dataoff,ds,ds+bss,4096);
    segment(1685382481,6,0,0,0,0,16);
    zeros(4096-written);copy(cf,cs);zeros(dataoff-written);copy(df,ds);
    if(close(cf)<0) fail();
    if(close(df)<0) fail();
    flush();
    if(close(1)<0) fail();
    return(0);
}
