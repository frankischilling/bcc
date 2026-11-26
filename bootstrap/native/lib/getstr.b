getstr(s) {
    extrn getchar,lchar;
    auto i,c;
    if((&s)[-1]<1 | !s)return(-1);
    i=0;
    while(1){
        c=getchar();if(c==4 | c=='*n')goto done;
        lchar(s,i++,c);
    }
 done:lchar(s,i,4);return(i);
}
