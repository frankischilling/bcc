/* Source labels have mutable cells, separate from named external objects. */
xdckeys[4096]; xdcoffs[4096]; xdcells;
xdclini() {extrn xdckeys,xdcells;auto i;i=0;while(i<4096)xdckeys[i++]= -1;xdcells=0;}
xdclfind(id) {
    extrn xdckeys;auto slot,n;
    if(id<0 | id>32767)xdfail();slot=id&4095;n=0;
    while(n++<4096){if(xdckeys[slot]==id)return(slot);if(xdckeys[slot]== -1)return(-1);slot=(slot+1)&4095;}
    return(-1);
}
xdcldef(id) {
    extrn xdckeys,xdcoffs,xdcells;auto slot;
    if(xdclfind(id)>=0 | xdcells>=4096)xdfail();slot=id&4095;
    while(xdckeys[slot]!= -1)slot=(slot+1)&4095;
    xdckeys[slot]=id;xdcoffs[slot]=xdalloc(1);xdcells++;
}
xdcla(id) {
    extrn xdcoffs,xdbase;auto slot;slot=xdclfind(id);
    if(slot<0)fatal("native data: missing label cell");
    return(xdbase/8+xdcoffs[slot]);
}
