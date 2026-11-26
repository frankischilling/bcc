data[2];
fetch() { extrn data; return(data); }
main() {
    extrn data, fetch, putchar;
    auto p;
    fetch()[1]=42;
    p= &fetch()[1];
    if(*p!=42 | p!= &data[1]) return(1);
    putchar('OK'); putchar('*n');
    return(0);
}
