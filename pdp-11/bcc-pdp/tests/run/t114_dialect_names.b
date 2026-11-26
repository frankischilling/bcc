/* These are identifiers in B72, not compatibility-mode control words. */
break 7;
continue(n){return(n+2);}
args(break,continue){return(break+continue);}
labels(){goto break;return(1);break:goto continue;continue:return(0);}
main(){
    extrn break,continue,args,labels,putchar;
    auto default;
    default=3;
    if(break!=7 | continue(default)!=5 | args(3,4)!=7 | labels()!=0) return(1);
    putchar('OK');putchar('*n');return(0);
}
