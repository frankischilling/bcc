/* bcc-example {"stdout":"-17 -21 AB hello\n%42\n","native":true,"bootstrap":true} */
/* B72 printf differs from C printf for octal and repeated percent signs. */
main() {
    extrn printf;
    printf("%d %o %c %s*n",-17,-17,'AB',"hello");
    printf("%%d*n",42);
    return(0);
}
