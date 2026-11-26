choose(n) if(n) return(7); else return(9);
labeled() done:return(37);
main() {
    extrn choose, labeled, putchar;
    if (choose(1)!=7 | choose(0)!=9 | labeled()!=37) return(1);
    putchar('OK'); putchar('*n');
    return(0);
}
