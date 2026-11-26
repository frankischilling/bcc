/* Keep the native resolver within the PDP-11 storage budget. */
snam[900]; scls[200]; soff[200]; symlimit 200;
ghbuf[1024]; ghlimit 2047;
resinit() {return(0);}
