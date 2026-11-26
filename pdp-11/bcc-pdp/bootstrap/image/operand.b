xhas 0; xrel 0; xval 0;
regval(){extrn etype;auto r;r=expr();if(etype!=21|r<0|r>7)fatal("expected register");return(r);}
need(c){extrn tok;if(tok!=c)fatal("missing operand punctuation");next();}
operand(){
    extrn tok,etype,xhas,xrel,xval;
    auto indirect,r,v,kind;
    indirect=0;xhas=0;xrel=0;xval=0;
    if(tok=='**'){indirect=1;next();}
    if(tok=='$'){next();v=expr();xhas=1;xval=address(v,etype);return(027+indirect*010);}
    if(tok=='-')if(peek()=='('){next();next();r=regval();need(')');return(040+r+indirect*010);}
    if(tok=='('){
        next();r=regval();need(')');
        if(tok=='+'){next();return(020+r+indirect*010);}
        if(indirect){xhas=1;return(070+r);}
        return(010+r);
    }
    v=expr();kind=etype;
    if(tok=='('){next();r=regval();need(')');xhas=1;xval=address(v,kind);return(060+r+indirect*010);}
    if(kind==21){if(v<0|v>7)fatal("bad register number");return(v+indirect*010);}
    xhas=1;xrel=1;xval=address(v,kind);return(067+indirect*010);
}
extra(has,relative,value){extrn origin,pc;if(has){if(relative)value=norm16(value-origin-pc-2);eword(value);}}
instr(kind,opcode){
    extrn tok,etype,origin,pc,xhas,xrel,xval;
    auto s,d,h,rel,value,r,delta;
    if(kind==12){
        s=operand();h=xhas;rel=xrel;value=xval;need(',');d=operand();
        eword(opcode+(s<<6)+d);extra(h,rel,value);extra(xhas,xrel,xval);return;
    }
    if(kind==14){d=operand();eword(opcode+d);extra(xhas,xrel,xval);return;}
    if(kind==8){r=regval();need(',');d=operand();eword(opcode+(r<<6)+d);extra(xhas,xrel,xval);return;}
    if(kind==9){r=regval();eword(opcode+r);return;}
    if(kind==10){r=expr();if(r<0|r>255)fatal("bad syscall number");eword(opcode+r);return;}
    if(kind==7){
        value=expr();delta=norm16(address(value,etype)-origin-pc-2);
        /* Forward targets are known during the output pass. */
        r=0;
        if(checkbr()){if((delta&1)|delta< -256|delta>254)fatal("branch out of range");r=(delta/2)&255;}
        eword(opcode+r);return;
    }
    fatal("unsupported instruction class");
}
checkbr(){extrn phase;return(phase==2);}
