infd 0; inbuf[128]; inpos 0; inlen 0; saved -1;
tok 0; tval 0; tname[4]; tdir 0; cline 1;
lexinit(fd){extrn infd,inpos,inlen,saved,lineno,cline,haspeek;infd=fd;inpos=0;inlen=0;saved= -1;lineno=1;cline=1;haspeek=0;}
getch(){
    extrn infd,inbuf,inpos,inlen,saved,cline,read,char;
    auto c;
    if(saved>=0){c=saved;saved= -1;goto done;}
    if(inpos>=inlen){inlen=read(infd,inbuf,256);inpos=0;if(inlen<0)fatal("input read failed");}
    if(!inlen)return(-1);
    c=char(inbuf,inpos++);
 done:if(c==10)cline++;return(c);
}
unget(c){extrn saved,cline;saved=c;if(c==10)cline--;}
digit(c){return(c>='0'&c<='9');}
letter(c){return((c>='a'&c<='z')|(c>='A'&c<='Z')|c=='_'|c=='.');}
quoted(){
    auto c;c=getch();if(c<0)fatal("unfinished quoted character");
    if(c!=92)return(c);
    c=getch();if(c<0)fatal("unfinished escape");
    if(c=='n')return(10);if(c=='t')return(9);if(c=='0')return(0);if(c=='e')return(4);
    return(c);
}
scan(){
    extrn tok,tval,tname,tdir,lchar,lineno,cline;
    auto c,i,v,d,n;
 again:c=getch();lineno=cline;if(c==10)lineno--;
    if(c<0){tok=0;return;}
    if(c==' '|c==9|c==13)goto again;
    if(c=='/'){while(c!=10&c>=0)c=getch();if(c<0)tok=0;else tok=10;return;}
    if(c==92){c=getch();tok=c;
        if(c=='<')tok=261;if(c=='>')tok=262;if(c=='%')tok='|';
        if(c=='/'|c=='<'|c=='>'|c=='%')return;fatal("unsupported token escape");}
    if(c==39){tval=quoted();tok=257;return;}
    if(c==34){v=quoted();c=quoted();tval=norm16(v|(c<<8));tok=257;return;}
    if(digit(c)){
        v=0;d=0;n=0;
        while(digit(c)){v=norm16(v*8+c-'0');d=norm16(d*10+c-'0');n++;c=getch();}
        tok=257;tval=v;
        if(c=='.'){tval=d;return;}
        if(n==1)if(c=='f'|c=='b'){tok=259;tval=d;tdir=c;return;}
        unget(c);return;
    }
    if(letter(c)){
        i=0;
        while(letter(c)|digit(c)){
            if(c>='A'&c<='Z')c=c+32;
            if(i<7)lchar(tname,i++,c);
            c=getch();
        }
        while(i<8)lchar(tname,i++,0);
        unget(c);tok=256;return;
    }
    if(!c)fatal("NUL in assembly source");tok=c;
}

haspeek 0; ptok 0; pval 0; pdir 0; pline 0; pname[4];
next(){
    extrn haspeek,ptok,pval,pdir,pline,pname,tok,tval,tdir,lineno,tname,char,lchar;
    auto i;
    if(!haspeek){scan();return;}
    haspeek=0;tok=ptok;tval=pval;tdir=pdir;lineno=pline;
    i=0;while(i<8){lchar(tname,i,char(pname,i));i++;}
}
peek(){
    extrn haspeek,ptok,pval,pdir,pline,pname,tok,tval,tdir,lineno,tname,char,lchar;
    auto t,v,d,line,raw 4,i;
    if(haspeek)return(ptok);
    t=tok;v=tval;d=tdir;line=lineno;i=0;
    while(i<8){lchar(raw,i,char(tname,i));i++;}
    scan();ptok=tok;pval=tval;pdir=tdir;pline=lineno;i=0;
    while(i<8){lchar(pname,i,char(tname,i));lchar(tname,i,char(raw,i));i++;}
    tok=t;tval=v;tdir=d;lineno=line;haspeek=1;return(ptok);
}
