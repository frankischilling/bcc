/* B72 conversions, with counted-frame checks before fetching an argument. */
printf(fmt,x1) {
    extrn char,putchar,printn,__sys;
    auto count,used,adx,x,c,kind,i,j;
    count=(&fmt)[-1];if(count<1 | !fmt)return(-1);
    used=0;adx= &x1;i=0;
 loop:
    c=char(fmt,i++);if(c==4)return(0);
    if(c!='%'){putchar(c);goto loop;}
    kind=char(fmt,i++);if(kind==4){putchar('%');return(0);}
    if(kind!='d' & kind!='o' & kind!='c' & kind!='s'){
        putchar('%');i--;goto loop;
    }
    if(used>=count-1){
        __sys(1,2,"bcc: printf argument list is too short*n"<<3,39,0,0,0);
        return(-1);
    }
    x= *adx++;used++;
    if(kind=='d' | kind=='o'){
        /* Replacement printn functions receive the representable magnitude. */
        if(x<0)if(-x>=0){putchar('-');x= -x;}
        printn(x,kind=='d'?10:8);goto loop;
    }
    if(kind=='c'){putchar(x);goto loop;}
    j=0;while((c=char(x,j++))!=4)putchar(c);goto loop;
}
