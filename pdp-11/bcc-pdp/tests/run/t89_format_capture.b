bytes[8];
count 0;
capture(c) {
    extrn bytes, count, lchar;
    lchar(bytes,count,c);
    count=+1;
    return(c);
}
main() {
    extrn putchar, putstr, printf, capture, bytes, count, char;
    auto saved, i, want;
    saved=putchar;
    putchar=capture;
    printf("%s|A*0B","C*0D");
    putstr("|E*0F");
    putchar=saved;
    if(count!=11) return(1);
    want="C*0D|A*0B|E*0F";
    i=0;
    while(i<count) {
        if(char(bytes,i)!=char(want,i)) return(2);
        i=+1;
    }
    printf("%q%d|%%d|%d %o*n",7,8,(-32767-1),-17);
    return(0);
}
