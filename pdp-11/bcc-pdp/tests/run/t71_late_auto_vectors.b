main() {
    auto i,total;
    extrn putchar;
    i=0;total=0;
    while(i<20) auto v 3; {
        v[0]=i;v[1]=i+1;v[2]=i+2;
        total=total+v[0]+v[1]+v[2];i++;
    }
    if(total!=630)return(1);
    auto late 2;
    late[0]=37;late[1]=41;
    if(late[0]+late[1]!=78)return(2);
    putchar('OK');putchar('*n');return(0);
}
