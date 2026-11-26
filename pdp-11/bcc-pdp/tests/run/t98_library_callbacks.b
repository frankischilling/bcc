putchar;
one;two;input;value;base;
first(c){extrn one;one++;return(c);}
second(c){extrn two;two++;return(c);}
printn(n,b){extrn value,base;value=n;base=b;return(0);}
getchar(){extrn input;if(input++==0)return('A');return(10);}
main(){
    extrn putchar,first,second,printf,getstr,char,write;
    extrn one,two,input,value,base;
    auto buf 4;
    putchar=first;
    printf("%d",-12);
    if(one!=1 | value!=12 | base!=10)return(1);
    putchar=second;
    printf("ab");
    if(one!=1 | two!=2)return(2);
    if(getstr(buf)!=1 | input!=2)return(3);
    if(char(buf,0)!='A' | char(buf,1)!=4)return(4);
    write(1,"OK*n",3);
    return(0);
}
