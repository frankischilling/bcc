/* Work in the negative domain so the minimum signed word is printable. */
outd(n) {
    extrn char,lchar;
    auto buf 4,i;
    if(n==0) {outc('0');return;}
    if(n<0) outc('-');else n= -n;
    i=0;
    while(n) {lchar(buf,i++,'0'-n%10);n=n/10;}
    while(i) outc(char(buf,--i));
}
