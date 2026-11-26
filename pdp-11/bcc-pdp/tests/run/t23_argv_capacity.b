main() {
    extrn argv, char;
    if (argv[0] != 41) return(1);
    /* The program name takes the first slot; all forty user arguments remain. */
    if (char(argv[41],0)!='a' | char(argv[41],1)!='3') return(2);
    if (char(argv[41],2)!='9' | char(argv[41],3)!=0) return(3);
    return(0);
}
