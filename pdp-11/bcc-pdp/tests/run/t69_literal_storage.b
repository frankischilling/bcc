text(){return("same");}
other(){return("same");}
main(){
    auto p;
    extrn text,other,char,lchar,putchar;
    p=text(); lchar(p,0,122);
    if(char(text(),0)!=122 | char(other(),0)!=115)return(1);
    putchar('OK'); putchar('*n'); return(0);
}
