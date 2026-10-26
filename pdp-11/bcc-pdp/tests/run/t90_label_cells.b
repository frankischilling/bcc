/* Internal label cells are writable and shared by invocations. */
choose(n) {
    auto p;
    if(n==0) { p = &first; *p=second; return(0); }
    if(n==1) goto first;
    if(n==2) goto(first);
    return(&first==&second);
 first: return(1);
 second: return(2);
}
main() {
    extrn choose, putchar;
    auto saved, p;
    if(choose(0)!=0 | choose(1)!=2 | choose(2)!=2 | choose(3)!=0) return(1);
    saved=wrong;
    p = &wrong;
    *p=right;
    if(*p!=right) return(2);
    goto wrong;
 wrong: return(3);
 right:
    wrong=saved;
    if(wrong==right) return(4);
    putchar('OK');putchar('*n');
    return(0);
}
