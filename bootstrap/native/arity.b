/* Read formal counts from unresolved records before resolution drops Aarg. */
arbuf[520];
aralpha(c) {
    if(c>='a') if(c<='z') return(1);
    if(c>='A') if(c<='Z') return(1);
    return(c=='_' | c==8);
}
arname(p) {
    extrn char;
    auto i,c;
    if(!aralpha(char(p,0))) return(0);
    i=0;
    while(c=char(p,i)) {
        if(i>=8) return(0);
        if(!aralpha(c)) if(c<'0' | c>'9') return(0);
        i++;
    }
    return(1);
}
arscan(fd,visit) {
    extrn arbuf,bcur,char;
    auto tag 5,fn 5,arg 5,active,nargs,total,idx;
    active=0;nargs=0;total=0;icini(fd);
    while(getln(arbuf,1040)) {
        icrst();nxtnam(arbuf,tag);
        if(tageq(tag,"Adef")) {
            if(active) fatal("nested function record");
            nxtnam(arbuf,fn);
            if(!arname(fn) | skpws(arbuf)!=0) fatal("invalid function record");
            active=1;nargs=0;goto next;
        }
        if(tageq(tag,"Aarg")) {
            if(!active) fatal("parameter outside function");
            nxtnam(arbuf,arg);
            if(!arname(arg) | char(arbuf,bcur)!=' ') fatal("invalid parameter record");
            idx=nxti(arbuf);
            if(skpws(arbuf)!=0 | idx!=nargs) fatal("invalid parameter index");
            if(nargs>=32767) fatal("too many parameters");
            nargs++;goto next;
        }
        if(tageq(tag,"Aend")) {
            if(!active) fatal("function end without definition");
            if(skpws(arbuf)!=0) fatal("invalid function end");
            if(total>=32767) fatal("too many function records");
            if(visit(fn,nargs)) fatal("parameter callback failed");
            total++;active=0;
        }
     next:;
    }
    if(active) fatal("unfinished function records");
    return(total);
}
