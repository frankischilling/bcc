/* Statement branches keep an empty operand stack; ternary arms merge values. */
xcbuf[520];xckeys[4096];xcids[4096];xckinds[4096];
xcfalse[4096];xcends[4096];xccount;xcret -1;
xcfmap(label,kind,create) {
    extrn xckeys,xcids,xckinds,xccount;auto slot,tries;
    if(label<0 | label>32767 | kind<1 | kind>3) xrfail();
    slot=label&4095;tries=0;
    while(tries<4096) {
        if(xckeys[slot]==label) {
            if(xckinds[slot]!=kind) xrfail();return(xcids[slot]);
        }
        if(xckeys[slot]== -1) {
            if(!create | xccount>=4093) xrfail();
            xckeys[slot]=label;xckinds[slot]=kind;xcids[slot]=xccount++;
            return(xcids[slot]);
        }
        slot=(slot+1)&4095;tries++;
    }
    xrfail();
}
xcfscan(fd) {
    extrn xcbuf,xckeys,xccount,xcret;auto i,tag 5,a,b;
    if(xcret!= -1)xrfail();
    i=0;while(i<4096)xckeys[i++]= -1;xccount=0;icini(fd);
    while(getln(xcbuf,1040)) {
        icrst();nxtnam(xcbuf,tag);
        if(tageq(tag,"lb") | tageq(tag,"jm") | tageq(tag,"bf")) {
            a=nxti(xcbuf);xrend(xcbuf);xcfmap(a,1,1);goto next;
        }
        if(tageq(tag,"tq")) {a=nxti(xcbuf);xrend(xcbuf);xcfmap(a,2,1);goto next;}
        if(tageq(tag,"te")) {a=nxti(xcbuf);xrend(xcbuf);xcfmap(a,3,1);goto next;}
        if(tageq(tag,"tc")) {
            a=nxti(xcbuf);b=nxti(xcbuf);xrend(xcbuf);
            xcfmap(a,2,1);xcfmap(b,3,1);goto next;
        }
        if(tageq(tag,"rt")) xrend(xcbuf);
     next:;
    }
    return(xccount);
}
xcfbeg(ret) {
    extrn xccount,xcfalse,xcends,xcret,xrnext,xrlimit,xrfault;auto i;
    if(xcret!= -1)xrfail();
    if(ret<xccount | ret>4095 | xrnext<xccount) xrfail();
    if(ret>=xrnext & ret<xrlimit) xrfail();if(ret==xrfault) xrfail();
    xcret=ret;i=0;while(i<xccount){xcfalse[i]= -1;xcends[i]= -1;i++;}
}
xcfline(buf) {
    extrn xrdepth,xrvalid,xcfalse,xcends,xcret;auto tag 5,a,b;
    if(xcret<0)xrfail();
    icrst();nxtnam(buf,tag);
    if(tageq(tag,"rt")) {
        xrend(buf);if(xrdepth) xrfail();xbranch(1,xcret);xrvalid=0;return(1);
    }
    if(tageq(tag,"lb") | tageq(tag,"jm") | tageq(tag,"bf")) {
        a=nxti(buf);xrend(buf);a=xcfmap(a,1,0);if(xrdepth) xrfail();
        if(tageq(tag,"lb")) xmark(a);
        else if(tageq(tag,"jm")) xbranch(1,a);
        else {if(!xrvalid)xrfail();xbin(6,0,0);xcond(4,a);}
        xrvalid=0;return(1);
    }
    if(tageq(tag,"tq")) {
        a=nxti(buf);xrend(buf);a=xcfmap(a,2,0);
        if(!xrvalid | xcfalse[a]!= -1) xrfail();xcfalse[a]=xrdepth;
        xbin(6,0,0);xcond(4,a);xrvalid=0;return(1);
    }
    if(tageq(tag,"tc")) {
        a=nxti(buf);b=nxti(buf);xrend(buf);a=xcfmap(a,2,0);b=xcfmap(b,3,0);
        if(!xrvalid | xcfalse[a]<0 | xrdepth!=xcfalse[a] | xcends[b]!= -1) xrfail();
        xcends[b]=xrdepth;xcfalse[a]= -2;
        xbranch(1,b);xmark(a);xrvalid=0;return(1);
    }
    if(tageq(tag,"te")) {
        a=nxti(buf);xrend(buf);a=xcfmap(a,3,0);
        if(!xrvalid | xcends[a]<0 | xrdepth!=xcends[a]) xrfail();
        xcends[a]= -2;xmark(a);return(1);
    }
    return(0);
}
xcfend() {
    extrn xrdepth,xrvalid,xcfalse,xcends,xccount,xcret;auto i;
    if(xcret<0 | xrdepth)xrfail();i=0;
    while(i<xccount){if(xcfalse[i]>=0 | xcends[i]>=0)xrfail();i++;}
    xmovim(0,0);xmark(xcret);xrvalid=1;xcret= -1;
}
