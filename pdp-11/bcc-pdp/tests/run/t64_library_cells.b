count;
replace(c) { extrn count; count++; return(c); }
main() {
    auto original;
    extrn count,replace,putchar,printn,putstr;
    original=putchar;
    putchar=replace;
    if(putchar('x')!='x') return(1);
    printn(123,10);
    putstr("ab");
    if(count!=6) return(2);
    original('OK'); original('*n');
    putchar=original;
    return(0);
}
