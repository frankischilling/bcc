sum(n,x) {
    auto p,total,i;
    p= &x;total=0;i=0;
    while(i<n){total=+p[i];i++;}
    return(total);
}
first(x){return(1);}
second(x){return(2);}
replace(){extrn first,second;first=second;return(0);}
main(){
    extrn sum,first,replace,putchar;
    auto f;
    f=sum;
    if(sum(4,10,20,30,40)!=100)return(1);
    if(f(3,10,20,30)!=60)return(2);
    if(sum(3,sum(2,1,2),sum(2,3,4),5)!=15)return(3);
    if(first(replace())!=1)return(4);
    putchar('OK');putchar('*n');return(0);
}
