adepth 0;
atom(){
    extrn adepth;
    auto value;
    if(adepth>=16)fatal("expression nesting exceeds 16");
    adepth++;value=atom1();adepth--;return(value);
}
atom1(){
    extrn tok,tval,tname,etype,svalue,skind,phase,origin,pc,tdir;
    auto value,s,sign;
    if(tok==257){value=tval;etype=2;next();return(value);}
    if(tok==259){value=localref(tval,tdir);next();return(value);}
    if(tok==256){
        if(nameeq(tname,".")){value=pc;etype=3;}
        else if(nameeq(tname,"..")){value=origin;etype=2;}
        else{s=findsym(tname);etype=skind[s];value=svalue[s];if(etype==1&phase==2)fatal("undefined symbol");}
        next();return(value);
    }
    if(tok=='['){next();value=expr();if(tok!=']')fatal("missing bracket");next();return(value);}
    if(tok=='+'|tok=='-'|tok=='!'){
        sign=tok;next();value=atom();
        if(sign!='+'&etype==3)fatal("invalid relocation arithmetic");
        if(sign=='-')value=norm16(-value);if(sign=='!')value=norm16(-1-value);
        return(value);
    }
    fatal("expected expression");
}
isop(op){return(op=='+'|op=='-'|op=='**'|op=='/'|op=='%'|op=='&'|op=='|'|op=='!'|op=='^'|op==261|op==262);}
expr(){
    extrn tok,etype;
    auto left,right,kind,rkind,op;
    left=atom();kind=etype;
    while(isop(tok)){
        op=tok;next();right=atom();rkind=etype;
        if(op=='+')left=left+right;
        if(op=='-')left=left-right;
        if(op=='**')left=left*right;
        if(op=='/'){if(!right)fatal("division by zero");left=left/right;}
        if(op=='%'){if(!right)fatal("division by zero");left=left%right;}
        if(op=='&')left=left&right;
        if(op=='|')left=left|right;
        if(op=='!')left=left+(-1-right);
        if(op==261){if(right<0|right>15)left=0;else left=left<<right;}
        if(op==262){if(right<0|right>15)left=0;else left=(left&65535)>>right;}
        if(op=='^')kind=rkind;
        else if(kind==1|rkind==1)kind=1;
        else if(op=='-'&kind==3&rkind==3)kind=2;
        else if(op=='+'&(kind==3|rkind==3)){
            if(kind==3&rkind==3)fatal("invalid relocation addition");kind=3;
        }
        else if(op=='-'&kind==3)kind=3;
        else if(kind==3|rkind==3)fatal("invalid relocation arithmetic");
        else if(rkind>kind)kind=rkind;
        left=norm16(left);
    }
    etype=kind;return(left);
}
