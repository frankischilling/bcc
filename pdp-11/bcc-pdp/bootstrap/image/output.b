obuf[128]; opos 0; binfd 0;
bflush(){extrn opos,obuf,binfd,write;if(opos)if(write(binfd,obuf,opos)!=opos)fatal("output write failed");opos=0;}
bput(v){extrn opos,obuf,lchar;lchar(obuf,opos++,v&255);if(opos==256)bflush();}
header(v){bput(v);bput(v>>8);}
ebyte(v){extrn pc,phase;if(pc>=16372)fatal("native image exceeds 16 KB");if(phase==2)bput(v);pc++;}
eword(v){extrn pc;if(pc&1)fatal("unaligned word");ebyte(v);ebyte(v>>8);}
address(v,kind){extrn origin;if(kind==3)return(norm16(v+origin));return(v);}
