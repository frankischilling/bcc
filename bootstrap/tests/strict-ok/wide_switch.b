/* Switch compares whole B words, not the host C int width. */
pick(value) {
    switch value {
    case 0: return(1);
    case 4294967296: return(2);
    case 4294967297: return(3);
    case 9223372036854775807: return(4);
    case 9223372036854775808: return(5);
    }
    return(6);
}
main() {
    if(pick(0)!=1) return(1);
    if(pick(4294967296)!=2) return(2);
    if(pick(4294967297)!=3) return(3);
    if(pick(9223372036854775807)!=4) return(4);
    if(pick(9223372036854775808)!=5) return(5);
    if(pick(8589934592)!=6) return(6);
    return(0);
}
