/* Two fixed-width emission passes resolve numeric x86-64 code labels. */
xlpos[4096]; xlseen[4096]; xlused[4096]; xlphase 0; xlsize 0;
xlfail() {extrn write,exit;write(2,"x64 labels: invalid layout*n",27);exit(1);}
xlid(id) {if(id<0|id>=4096) xlfail();}
xlblbeg(pass) {
    extrn xlpos,xlseen,xlused,xlphase;
    auto i;
    if(xtell()!=0) xlfail();
    if(pass==1) {
        if(xlphase!=0 & xlphase!=4) xlfail();
        i=0;while(i<4096) {xlpos[i]=0;xlseen[i]=0;xlused[i]=0;i++;}
        xlphase=1;return;
    }
    if(pass!=2 | xlphase!=3) xlfail();
    i=0;while(i<4096) xlseen[i++]=0;
    xlphase=2;
}
xmark(id) {
    extrn xlpos,xlseen,xlused,xlphase;
    xlid(id);
    if(xlphase!=1 & xlphase!=2) xlfail();
    if(xlseen[id]) xlfail();
    if(xlphase==1) {xlpos[id]=xtell();xlused[id]=1;}
    else {if(!xlused[id] | xlpos[id]!=xtell()) xlfail();}
    xlseen[id]=1;
}
xlref(id) {
    extrn xlpos,xlused,xlphase;
    xlid(id);
    if(xlphase==1) {xlused[id]=1;return(0);}
    if(xlphase!=2 | !xlused[id]) xlfail();
    return(xlpos[id]);
}
xbranch(kind,id) {
    extrn xlphase;
    auto d;
    d=xlref(id);if(xlphase==1) d=0;else d=d-xtell()-5;
    xrel(kind,d);
}
xcond(cond,id) {
    extrn xlphase;
    auto d;
    d=xlref(id);if(xlphase==1) d=0;else d=d-xtell()-6;
    xjcc(cond,d);
}
xlblend() {
    extrn xlphase,xlused,xlseen,xlsize;
    auto i;
    if(xlphase!=1 & xlphase!=2) xlfail();
    i=0;while(i<4096) {if(xlused[i] & !xlseen[i]) xlfail();i++;}
    if(xlphase==1) {xlsize=xtell();xlphase=3;}
    else {if(xlsize!=xtell()) xlfail();xlphase=4;}
}
