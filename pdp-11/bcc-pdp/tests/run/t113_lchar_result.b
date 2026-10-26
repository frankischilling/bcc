/* lchar stores a byte and returns the original character argument. */
copy(to,from) {
    extrn char,lchar;
    auto i;
    i=0;
    while(lchar(to,i,char(from,i))!=004)i++;
}
main() {
    extrn char,lchar,putchar;
    auto s 2;
    if(lchar(s,0,'A')!='A')return(1);
    if(char(s,0)!='A')return(2);
    if(lchar(s,1,'*e')!='*e')return(3);
    if(char(s,1)!='*e')return(4);
    if(lchar(s,1,-1)!=-1)return(5);
    if(char(s,1)!=255)return(6);
    if(lchar(s,1,256)!=256)return(7);
    if(char(s,1)!=0)return(8);
    if(lchar(s,1,4660)!=4660)return(9);
    if(char(s,1)!=52 | char(s,0)!='A')return(10);
    copy(s,"OK");
    if(char(s,0)!='O' | char(s,1)!='K' | char(s,2)!=004)return(11);
    putchar('OK');putchar('*n');return(0);
}
