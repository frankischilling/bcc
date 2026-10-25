/* In B, '*' introduces escapes. Backslash remains an ordinary byte. */
main() {
    extrn char, putchar;
    auto p;
    p="\n";
    if(char(p,0)!=92 | char(p,1)!='n' | char(p,2)!=4) return(1);
    if('\'!=92 | '\n'!=23662) return(2);
    p="\";
    if(char(p,0)!=92 | char(p,1)!=4) return(3);
    putchar('O');putchar('K');putchar('*n');
    return(0);
}
