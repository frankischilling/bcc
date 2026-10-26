/* bcc-example {"stdout":"60\n","native":true,"bootstrap":true} */
/* Declared parameters occupy consecutive words in declaration order. */
sum(a,b,c) {
    auto p;
    p= &a;
    return(p[0]+p[1]+p[2]);
}
main() {
    extrn sum, printf;
    printf("%d*n",sum(10,20,30));
    return(0);
}
