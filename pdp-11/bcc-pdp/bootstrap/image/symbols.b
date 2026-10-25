snames[4096]; svalue[1024]; skind[1024]; nsy 0;
phase 2; origin 16396; pc 0; etype 2;
nameeq(a,b) {
    extrn char;
    auto i,x,y;
    i=0;
    while(1){x=char(a,i);y=char(b,i);if(y==4)y=0;
        if(x!=y)return(0);if(!x)return(1);i++;}
}
findsym(name) {
    extrn snames,svalue,skind,nsy,char,lchar;
    auto h,i,c,first,same;
    h=0;i=0;
    while(c=char(name,i++))h=(h*33+c)&1023;
    first=h;
    while(skind[h]) {
        i=0;same=1;
        while(i<8){if(char(snames,h*8+i)!=char(name,i))same=0;i++;}
        if(same)return(h);
        h=(h+1)&1023;if(h==first)fatal("symbol table full");
    }
    if(nsy>=1024)fatal("symbol table full");
    i=0;while(i<8){lchar(snames,h*8+i,char(name,i));i++;}
    skind[h]=1;svalue[h]=0;nsy++;return(h);
}
addsym(name,kind,value) {
    extrn skind,svalue,char,lchar;
    auto raw 4,i,c,s;
    i=0;
    while(i<7){c=char(name,i);if(c==4|c==0)goto pad;
        if(c>='A'&c<='Z')c=c+32;lchar(raw,i++,c);}
 pad:while(i<8)lchar(raw,i++,0);
    s=findsym(raw);skind[s]=kind;svalue[s]=value;return(s);
}
norm16(v){v=v&65535;if(v&32768)v=v|(-32768);return(v);}
ncount[10];
locname(n,count,buf){
    extrn lchar;
    auto i;
    lchar(buf,0,1);lchar(buf,1,n+'0');lchar(buf,7,0);
    i=6;while(i>=2){lchar(buf,i--,count%10+'0');count=count/10;}
}
localref(n,dir){
    extrn ncount,etype,skind,svalue,phase;
    auto count,raw 4,s;
    count=ncount[n];if(dir=='f'){if(count==32767)fatal("local label overflow");count++;}
    locname(n,count,raw);s=findsym(raw);etype=skind[s];
    if(etype==1&phase==2)fatal("undefined local label");return(svalue[s]);
}
