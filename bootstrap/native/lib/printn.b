/* Divide before negating so the minimum signed word remains printable. */
printn(n,b) {
    extrn putchar;
    auto a;
    if((&n)[-1]<2 | b<2 | b>16)return(-1);
    if(n<0){
        putchar('-');a= -(n/b);if(a)printn(a,b);a= -(n%b);
    }else{
        a=n/b;if(a)printn(a,b);a=n%b;
    }
    if(a<10)putchar(a+'0');else putchar(a-10+'A');
    return(0);
}
