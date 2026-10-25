/* Execute experimental bytecode with frames in the paged heap. */
vmrun(fd,hr,hw) {
    extrn codefd,pc,page,exit,sp,fp,floor;
    extrn hread,hwrite,htag,hdirty,hnext;
    auto a,op,at,v,i,t,r;
    hread=hr;hwrite=hw;htag[0]= -1;htag[1]= -1;
    hdirty[0]=0;hdirty[1]=0;hnext=0;
    codefd=fd;pc=0;page= -1;a=0;sp=8192;fp=0;floor=128;
 next:
    op=fetch();
    switch op {
    case 0:hflush(0);hflush(1);return(a);
    case 1:a=fetch();goto next;
    case 2:at=fetch();a=hget(at);goto next;
    case 3:at=fetch();hset(at,a);goto next;
    case 4:a=a+fetch();goto next;
    case 5:a=a<fetch();goto next;
    case 6:at=fetch();pc=at;goto next;
    case 7:at=fetch();if(a==0) pc=at;goto next;
    case 8:push(a);goto next;
    case 9:at=fetch();r=pop();a=binary(r,a,at);goto next;
    case 10:
        v=fetch();
        if(v<0 | v>=8192-sp) exit(24);
        if(v==0) {push(0);v=1;}
        t=hget(sp+v);if(t<1) exit(24);
        i=0;
        while(i<v/2) {
            at=hget(sp+i);r=hget(sp+v-1-i);
            hset(sp+i,r);hset(sp+v-1-i,at);i++;
        }
        if(t>32700) {a=vcall(t-32700,sp,v);sp=sp+v+1;goto next;}
        push(v+1);push(pc);push(fp);fp=sp;pc=t;goto next;
    case 11:v=fetch();if(v<0 | sp-v<floor) exit(18);sp=sp-v;goto next;
    case 12:
        if(fp<floor | fp>8189) exit(25);
        sp=fp;fp=pop();pc=pop();v=pop();
        if(v<0 | v>8192-sp) exit(25);
        sp=sp+v;goto next;
    case 13:at=fetch();a=valid(fp-1-at);goto next;
    case 14:at=fetch();a=valid(fp+3+at);goto next;
    case 15:a=hget(a);goto next;
    case 16:at=pop();hset(at,a);goto next;
    case 17:pc=a;goto next;
    case 18:
        at=fetch();
        if(at=='-') {a= -a;goto next;}
        if(at=='!') {a= !a;goto next;}
        if(at==126) {a= -1-a;goto next;}
        exit(26);
    case 19:at=a;v=fetch();a=hget(at);hset(at,a+v);goto next;
    case 20:at=a;v=fetch();a=hget(at)+v;hset(at,a);goto next;
    case 21:at=fetch();v=pop();r=hget(v);a=binary(r,a,at);hset(v,a);goto next;
    case 22:at=fetch();at=valid(fp-1-at);v=fetch();v=valid(fp-1-v);hset(at,v);goto next;
    case 23:if(sp>=8192) exit(19);a=hget(sp);goto next;
    case 24:pop();goto next;
    case 26:
        floor=fetch();
        if(floor<16 | floor>=8192) exit(18);
        goto next;
    case 28:
        at=fetch();v=fetch();
        if(at<1 | at>=8192 | v<0) exit(16);
        if(v>8192-at) exit(16);
        i=0;
        while(i<v) {r=fetch();hset(at+i,r);i++;}
        goto next;
    }
    exit(17);
}
