/* bcc-example {"stdout":"42\n","native":true,"bootstrap":true} */
main() {
    extrn printf;
    auto result;
    result=0;
    switch 1 {
    case 1:
        switch 2 {
        case 2:
            result=42;
            goto finished;
        }
    }
 finished:
    printf("%d*n",result);
    return(result!=42);
}
