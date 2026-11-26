getuid() {
    extrn __sys;
    return(__sys(102,0,0,0,0,0,0));
}
