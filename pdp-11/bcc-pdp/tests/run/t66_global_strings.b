before() { return("before"); }
mixed 11,"ab*0c",22,"",33;
values[4] "one","two";
after() { return("after"); }
main() {
    auto p;
    extrn mixed,values,before,after,char,lchar,putchar;
    p= &mixed;
    if(p[0]!=11 | p[2]!=22 | p[4]!=33) return(1);
    if(char(p[1],0)!='a' | char(p[1],2)!=0) return(2);
    if(char(p[1],3)!='c' | char(p[1],4)!=004) return(3);
    if(char(p[3],0)!=004) return(4);
    if(char(values[0],0)!='o' | char(values[1],0)!='t') return(5);
    if(values[2]!=0 | values[3]!=0) return(6);
    lchar(p[1],0,'z');
    if(char(p[1],0)!='z') return(7);
    if(char(before(),0)!='b' | char(after(),0)!='a') return(8);
    putchar('OK'); putchar('*n');
    return(0);
}
