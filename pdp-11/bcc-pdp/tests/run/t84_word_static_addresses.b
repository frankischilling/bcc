base 11,22,33;
refs[2] base,base;
str "abcdef";
main(){
    auto p;
    extrn base,refs,str,char,lchar,putchar;
    p= &base;
    if(refs[0]!=p | *(refs[1]+2)!=33)return(1);
    if(char(str+1,0)!='c' | char(str+2,0)!='e')return(2);
    p="abcd";
    if(*p!='ba' | *(p+1)!='dc')return(3);
    lchar(p+1,0,'z');if(char(p,2)!='z')return(4);
    putchar('OK');putchar('*n');return(0);
}
