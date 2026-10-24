main() {
    extrn argv, char;
    if (argv[0] != 31) return(1);
    /* The program name takes the first slot, so the last user arg is a29. */
    if (char(argv[31],0)!='a' | char(argv[31],1)!='2') return(2);
    if (char(argv[31],2)!='9' | char(argv[31],3)!=0) return(3);
    return(0);
}
