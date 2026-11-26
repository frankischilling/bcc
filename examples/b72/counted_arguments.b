/* bcc-example {"stdout":"100\n","native":true,"bootstrap":true} */
/* A count tells the function how many argument cells it may read. */
sum(n,x) {
    auto p,total,i;
    p= &x;
    total=0;
    i=0;
    while(i<n) {
        total=+p[i];
        i++;
    }
    return(total);
}
main() {
    extrn sum,printf;
    printf("%d*n",sum(4,10,20,30,40));
    return(0);
}
