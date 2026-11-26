/* Literal values for the native PDP-11 frontend. */
wordval(v) {
    v=v&65535;
    if (v&32768) v=v|(-32768);
    return(v);
}
frontini() {return(0);}
