main(){extrn putchar;auto i;i=0;again:if(i==30000)goto done;switch 1 {case 1:i=+1;goto again;}return(1);done:putchar('OK');putchar('*n');return(0);}
