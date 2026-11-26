/* Uses only the initial native runtime, without formatted I/O. */
main() {
    extrn write;
    return(write(1,"hello from native B*n",20)!=20);
}
