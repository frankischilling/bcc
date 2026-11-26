/* Strict B strings end with EOT; embedded NUL bytes are ordinary characters. */
putstr(s) {
    extrn char,putchar;
    auto i,c;
    if((&s)[-1]<1 | !s)return(-1);
    i=0;while((c=char(s,i++))!=4)putchar(c);
    return(s);
}
