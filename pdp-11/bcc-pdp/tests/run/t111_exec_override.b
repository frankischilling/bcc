/* Retained execl must call a source-defined execv cell. */
execv(path, args, count) {
    extrn char;
    if(char(path,0)!='x' | count!=1)return(2);
    if(char(args[0],0)!='y')return(3);
    return(37);
}
main() {
    extrn execl,putchar;
    if(execl("x","y",0)!=37)return(1);
    putchar('OK');putchar('*n');return(0);
}
