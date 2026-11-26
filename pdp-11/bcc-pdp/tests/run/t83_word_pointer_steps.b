main(){
    auto v 4,p,q;
    extrn putchar;
    v[0]=11;v[1]=22;v[2]=33;v[3]=44;
    p=v+1;
    if(*p!=22 | p!= &v[1] | p-v!=1)return(1);
    q=p++;if(q!=v+1 | *p!=33)return(2);
    if(*--p!=22)return(3);
    p=+2;if(*p!=44)return(4);
    p=-3;if(*p!=11)return(5);
    if(&*p!=p | *&v[2]!=33 | 2[v]!=33)return(6);
    putchar('OK');putchar('*n');return(0);
}
