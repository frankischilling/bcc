layout() {
    extrn dbuf,dtag,dnm,gname,scls,soff,ssize,scode,nsy,snam;
    extrn litaddr,nlits,lcell,ownargv,char,lchar,close,firstch;
    auto fd,gkind,gcount,ginit,s,n,i,current;
    fd=reopen();gkind=0;current= -1;
    while(nextrec()) {
        if(firstch!='g' & firstch!='p' & firstch!='e' & firstch!='S' & firstch!='G' & firstch!='l') goto next;
        if(firstch=='p') if(!tageq(dtag,"pr")) goto next;
        if(firstch=='l') if(!tageq(dtag,"lv")) goto next;
        if(tageq(dtag,"ex")) {nxtnam(dbuf,dnm);refsym(dnm);goto next;}
        if(tageq(dtag,"gvb") | tageq(dtag,"gvp")) {
            if(gkind) fatal("nested global");
            nxtnam(dbuf,gname);gcount=nxti(dbuf);ginit=0;
            if(gcount<0) fatal("negative global size");
            gkind=1;if(tageq(dtag,"gvp")) gkind=2;
            goto next;
        }
        if(tageq(dtag,"gvc") | tageq(dtag,"gvn") | tageq(dtag,"gvl")) {
            if(!gkind) fatal("initializer outside global");
            if(tageq(dtag,"gvn")) {nxtnam(dbuf,dnm);refsym(dnm);}
            ginit++;goto next;
        }
        if(tageq(dtag,"gve")) {
            if(!gkind) fatal("global end without definition");
            n=gcount;if(ginit>n) n=ginit;
            s=defsym(gname,gkind,n+(gkind==2));
            if(tageq(gname,"argv")) ownargv=1;
            gkind=0;goto next;
        }
        if(tageq(dtag,"pr")) {
            nxtnam(dbuf,dnm);current=defsym(dnm,3,1);
            if(tageq(dnm,"argv")) ownargv=1;
            goto next;
        }
        if(tageq(dtag,"ep")) {
            if(current<0) fatal("epilogue outside function");
            ssize[current]=nxti(dbuf);current= -1;goto next;
        }
        if(tageq(dtag,"Slit") | tageq(dtag,"Glit")) {
            n=nxti(dbuf);if(n<0 | n>256) fatal("invalid literal size");
            if(nlits>=512) fatal("too many literals");
            litaddr[nlits++]=alloc((n+1)/2);goto next;
        }
        if(tageq(dtag,"lv")) {
            i=findlab(nxti(dbuf));
            if(lcell[i]) fatal("duplicate label cell");
            lcell[i]=alloc(1);goto next;
        }
     next:;
    }
    if(close(fd)<0) fatal("input close failed");
    if(gkind) fatal("unfinished global");
    if(current>=0) fatal("unfinished function");
    i=0;
    while(i<nsy) {
        if(scls[i]==0) {
            n=0;while(n<9) {lchar(dnm,n,char(snam,i*9+n));n++;}
            n=prim(dnm);
            if(n==0) if(!tageq(dnm,"argv")) fatal("unresolved external");
            scls[i]=4;if(n==0) scls[i]=5;
            soff[i]=alloc(1);ssize[i]=1;scode[i]=n;
        }
        i++;
    }
    if(symlit("main")<0) fatal("missing main");
}
