/* bcc-example {"stdout":"1 2 2\n","native":true,"bootstrap":true} */
/* A label's internal cell retains a replacement across calls. */
choose(change) {
    if(change) first=second;
    goto first;
 first: return(1);
 second: return(2);
}
main() {
    extrn choose, printf;
    printf("%d ",choose(0));
    printf("%d ",choose(1));
    printf("%d*n",choose(0));
    return(0);
}
