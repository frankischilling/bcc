/* Maximum literal length and initializer count are separate limits. */
longstr "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
refs[128] "","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","";
main(){
    auto i;
    extrn longstr,refs,char,lchar,putchar;
    if(char(longstr,254)!='x' | char(longstr,255)!=004) return(1);
    i=0; while(i<128){if(char(refs[i],0)!=004)return(2); i++;}
    lchar(refs[0],0,'z');
    if(char(refs[127],0)!=004) return(3);
    putchar('OK'); putchar('*n'); return(0);
}
