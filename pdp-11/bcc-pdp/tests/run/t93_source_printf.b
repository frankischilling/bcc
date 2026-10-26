printf(s,n) { extrn write; write(1,"custom*n",7); return(n+1); }
main() { extrn printf; return(printf("unused",41)!=42); }
