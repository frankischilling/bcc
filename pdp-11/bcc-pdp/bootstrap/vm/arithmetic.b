/* PDP-11 word arithmetic for the experimental instruction set. */
binary(x,y,op) {
    extrn exit;
    auto v,t;
    switch op {
    case '+':return((x+y));
    case '-':return((x-y));
    case '**':return((x*y));
    case '/':if(y==0)exit(22);return((x/y));
    case '%':if(y==0)exit(22);return((x%y));
    case '&':return(x&y);
    case '|':return(x|y);
    case '^':v=x|y;t=x&y;t= -1-t;return((v&t));
    case '<':return(x<y);
    case '>':return(x>y);
    case 100:return(x==y);
    case 101:return(x!=y);
    case 102:return(x<=y);
    case 103:return(x>=y);
    case 104:if(y<0 | y>=16)return(0);return(x<<y);
    case 105:if(y<0 | y>=16)return(0);return(x>>y);
    }
    exit(23);
}
