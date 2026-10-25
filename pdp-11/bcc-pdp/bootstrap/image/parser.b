symset(name,kind,value){
    extrn phase,skind,svalue;
    auto s;
    s=findsym(name);
    if(kind==3){
        if(phase==1){if(skind[s]!=1)fatal("duplicate label");}
        else if(skind[s]!=3|svalue[s]!=value)fatal("label phase mismatch");
    }
    skind[s]=kind;svalue[s]=value;
}
locdef(n){
    extrn ncount,pc;
    auto raw 4;
    if(n<0|n>9)fatal("bad numeric label");
    if(ncount[n]==32767)fatal("local label overflow");
    ncount[n]++;locname(n,ncount[n],raw);symset(raw,3,pc);
}
finish(){extrn tok;if(tok!=0&tok!=10&tok!=';')fatal("extra statement text");}
string(){
    auto c;
    while(1){c=getch();if(c<0)fatal("unfinished string");if(c=='>')goto done;
        if(c==92){unget(c);c=quoted();}ebyte(c);}
 done:next();finish();
}
stmt(){
    extrn tok,tval,tname,pc,phase,origin,etype,skind,svalue;
    auto raw 4,i,s,kind,opcode,value;
    if(tok==256|tok==257)if(peek()==':'){
        if(tok==257)locdef(tval);
        else{
            if(nameeq(tname,".")|nameeq(tname,".."))fatal("location counter is not a label");
            symset(tname,3,pc);
        }
        next();next();return;
    }
    if(tok==256)if(peek()=='='){
        i=0;while(i<8){lchar(raw,i,char(tname,i));i++;}
        next();next();value=expr();kind=etype;
        if(nameeq(raw,".")){
            if(kind==1)fatal("unresolved location assignment");
            if(value<pc|value>16372)fatal("invalid location assignment");
            while(pc<value)ebyte(0);
        }
        else if(nameeq(raw,"..")){
            if(kind!=2|value!=16396)fatal("native image needs origin 40014");origin=value;
        }
        else symset(raw,kind,value);
        finish();return;
    }
    if(tok=='<'){string();return;}
    if(tok==256){
        if(nameeq(tname,".text")){next();finish();return;}
        if(nameeq(tname,".even")){next();if(pc&1)ebyte(0);finish();return;}
        if(nameeq(tname,".globl")){
            next();
         global:if(tok!=256)fatal("expected global name");next();
            if(tok==','){next();goto global;}
            finish();return;
        }
        if(nameeq(tname,".byte")){
            next();
         bytes:value=expr();if(etype==3)fatal("relocatable byte");
            if(phase==2)if(value< -128|value>255)fatal("byte out of range");
            ebyte(value);if(tok==','){next();goto bytes;}finish();return;
        }
        s=findsym(tname);kind=skind[s];opcode=svalue[s];
        if(kind==7|kind==8|kind==9|kind==10|kind==12|kind==14){next();instr(kind,opcode);finish();return;}
    }
    value=expr();eword(address(value,etype));finish();
}
