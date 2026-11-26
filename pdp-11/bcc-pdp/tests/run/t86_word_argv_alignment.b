main(count,values){
    auto i;
    extrn argv,char,lchar,putchar;
    if(argv[0]!=5 | count!=4)return(1);
    i=0;while(i<4){if(values[i]!=argv[i+2])return(2);i++;}
    if(char(argv[2],0)!='a' | char(argv[3],1)!='b')return(3);
    if(char(argv[4]+1,0)!='c' | char(argv[5]+1,1)!='d')return(4);
    if(char(argv[2],1)!=0 | char(argv[3],2)!=0 | char(argv[4],3)!=0 | char(argv[5],4)!=0)return(5);
    lchar(argv[4]+1,0,'z');if(char(values[2],2)!='z')return(6);
    putchar('OK');putchar('*n');return(0);
}
