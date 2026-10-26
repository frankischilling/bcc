/* Experimental Linux driver: one frozen input, private scratch, ELF on stdout. */
owned 0;savedmsk 0; folder[512]; tools[512]; original[512]; input[512];
rawfile[512]; resolved[512]; codefile[512]; datafile[512]; program[512]; spare[512];
libnames[] "execv","printf","printn","putchar","getchar","getstr","putstr","__path","chdir","link","getuid";
libcount 11;libused[11];libdefs[11];libadded[11];

rawlen(s){extrn char;auto n;n=0;while(char(s,n))n++;return(n);}
slen(s){extrn char;auto n,c;n=0;while((c=char(s,n))!=0 & c!=4)n++;return(n);}
append(to,from){
    extrn char,lchar;auto n,i,c;n=rawlen(to);i=0;
    while((c=char(from,i++))!=0 & c!=4){if(n>=4095)return(-1);lchar(to,n++,c);}
    lchar(to,n,0);return(0);
}
copystr(to,from){extrn lchar;lchar(to,0,0);return(append(to,from));}
appendos(to,from){
    extrn char,lchar;auto n,i,c;n=rawlen(to);i=0;
    while(c=char(from,i++)){if(n>=4095)return(-1);lchar(to,n++,c);}
    lchar(to,n,0);return(0);
}
copyos(to,from){extrn lchar;lchar(to,0,0);return(appendos(to,from));}
join(to,a,b){if(copyos(to,a)<0)return(-1);return(append(to,b));}
number(to,n){
    extrn lchar,char;auto digits 16,i,j;i=0;
    while(1){lchar(digits,i++,n%10+'0');n=n/10;if(!n)goto ready;}
 ready:j=rawlen(to);if(j+i>4095)return(-1);
    while(i)lchar(to,j++,char(digits,--i));lchar(to,j,0);return(0);
}
message(s){extrn write;write(2,s,slen(s));}
clean(){
    extrn owned,folder,input,rawfile,resolved,codefile,datafile,spare,unlink,__sys;
    if(!owned)return;outclear();
    unlink(input);unlink(rawfile);unlink(resolved);unlink(codefile);unlink(datafile);
    if(join(spare,folder,"/imports")==0)unlink(spare);
    if(join(spare,folder,"/layout")==0)unlink(spare);
    __sys(84,folder<<3,0,0,0,0,0);owned=0;
}
fatal(s){extrn exit;message("bcc-native: ");message(s);message("*n");clean();exit(1);}
setup(){
    extrn owned,folder,tools,original,input,rawfile,resolved,codefile,datafile,argv,__sys,char,lchar,savedmsk;
    auto n,i,last,pid,r;
    savedmsk=__sys(95,077,0,0,0,0,0);
    if(savedmsk<0)fatal("cannot set private file permissions");
    n=__sys(89,"/proc/self/exe*0"<<3,tools<<3,4095,0,0,0);
    if(n<1 | n>=4095)fatal("cannot find sibling tools");lchar(tools,n,0);
    i=0;last= -1;while(i<n){if(char(tools,i)=='/')last=i;i++;}
    if(last<0)fatal("invalid tool path");lchar(tools,last+1,0);
    if(char(argv[2],0)=='/')r=copyos(original,argv[2]);
    else{
        n=__sys(79,original<<3,4096,0,0,0,0);if(n<1)fatal("cannot read working directory");
        r=append(original,"/");if(!r)r=appendos(original,argv[2]);
    }
    if(r<0)fatal("input path too long");pid=__sys(39,0,0,0,0,0,0);if(pid<1)fatal("cannot read process ID");i=0;
    while(i<1000){
        copystr(folder,"/tmp/bcc-native-");number(folder,pid);append(folder,"-");number(folder,i++);
        r=__sys(83,folder<<3,0700,0,0,0,0);
        if(!r){owned=1;goto made;}if(r!=-17)fatal("cannot create scratch directory");
    }
    fatal("scratch names exhausted");
 made:
    if(join(input,folder,"/input.b") | join(rawfile,folder,"/raw.ic") |
       join(resolved,folder,"/resolved.ic") | join(codefile,folder,"/code") |
       join(datafile,folder,"/data"))fatal("scratch path too long");
}
copydata(in,out){
    extrn __sys;auto buffer 512,n,done,r;
    while(1){
        n=__sys(0,in,buffer<<3,4096,0,0,0);
        if(n==-4)goto again;if(n<0)return(-1);if(!n)return(0);
        done=0;while(done<n){
            r=__sys(1,out,(buffer<<3)+done,n-done,0,0,0);
            if(r==-4)goto retry;if(r<=0)return(-1);done=+r;
 retry:;
        }
 again:;
    }
}
copyfile(from,to,extend){
    extrn close,seek,__sys;auto in,out,r;
    in=__sys(2,from<<3,0,0,0,0,0);if(in<0)return(-1);
    if(extend)out=__sys(2,to<<3,1,0,0,0,0);else out=__sys(85,to<<3,0600,0,0,0,0);
    if(out<0){close(in);return(-1);}
    if(extend){
        if(seek(out,0,2)<0)goto bad;
        if(__sys(1,out,"*n"<<3,1,0,0,0)!=1)goto bad;
    }
    r=copydata(in,out);if(close(in)<0)r= -1;if(close(out)<0)r= -1;return(r);
 bad:close(in);close(out);return(-1);
}

invoke(path,args,count,output){
    extrn folder,fork,execraw,exit,creat,close,__sys;auto pid,fd,r,status;
    pid=fork();if(pid<0)return(125);
    if(!pid){
        if(output){
            fd=creat(output,016);if(fd<0)exit(126);
            r=__sys(33,fd,1,0,0,0,0);if(fd!=1)close(fd);if(r<0)exit(126);
        }
        if(__sys(80,folder<<3,0,0,0,0,0)<0)exit(126);
        execraw(path,args,count);exit(127);
    }
    status=0;
 retry:r=__sys(61,pid,(&status)<<3,0,0,0,0);if(r==-4)goto retry;
    if(r!=pid)return(125);if(status&127)return(128+(status&127));
    return((status>>8)&255);
}
front(){
    extrn program,tools,input,rawfile;auto a 2;
    if(join(program,tools,"front"))fatal("tool path too long");a[0]=program;a[1]=input;
    if(invoke(program,a,2,rawfile))fatal("frontend failed");
}
resolve(){
    extrn program,tools,rawfile,resolved;auto a 3;
    if(join(program,tools,"resolve"))fatal("tool path too long");a[0]=program;a[1]="-i*0";a[2]=rawfile;
    if(invoke(program,a,3,resolved))fatal("resolver failed");
}
libfind(name){extrn libnames,libcount;auto i;i=0;while(i<libcount){if(tageq(name,libnames[i]))return(i);i++;}return(-1);}
needlibs(){
    extrn resolved,input,tools,spare,libnames,libused,libdefs,libadded,libcount,open,close;
    auto fd,b 520,tag 5,name 5,i,used;
    fd=open(resolved,0);if(fd<0)fatal("cannot inspect imports");
    i=0;while(i<libcount){libused[i]=0;libdefs[i]=0;i++;}icini(fd);
    while(getln(b,1040)){
        icrst();nxtnam(b,tag);
        if(tageq(tag,"pr") | tageq(tag,"gvb") | tageq(tag,"gvp")){
            nxtnam(b,name);i=libfind(name);if(i>=0)libdefs[i]=1;
        }
        if(tageq(tag,"ex") | tageq(tag,"gvn")){
            nxtnam(b,name);i=libfind(name);if(i>=0)libused[i]=1;
        }
    }
    if(close(fd)<0)fatal("import close failed");used=0;i=0;
    while(i<libcount){
        if(libused[i] & !libdefs[i]){
            if(libadded[i])fatal("runtime source did not define its provider");
            if(join(spare,tools,"sources/"))fatal("library path too long");
            if(append(spare,libnames[i]))fatal("library path too long");
            if(append(spare,".b"))fatal("library path too long");
            if(copyfile(spare,input,1))fatal("runtime library copy failed");
            libadded[i]=1;used++;
        }
        i++;
    }
    return(used);
}

main(){
    extrn argv,original,input,program,tools,rawfile,resolved,codefile,datafile,spare,__sys,outmode,imageout,libcount;
    auto a 5,r,rounds;
    if(argv[0]!=2 & argv[0]!=4){message("usage: driver input.b [-o new-output]*n");return(2);}
    if(argv[0]==4)if(!tageq(argv[3],"-o")){message("usage: driver input.b [-o new-output]*n");return(2);}
    setup();if(argv[0]==4)prepout(argv[4]);if(copyfile(original,input,0))fatal("input copy failed");front();resolve();
    rounds=0;
    while(needlibs()){
        rounds++;if(rounds>libcount)fatal("runtime dependency cycle");front();resolve();
    }
    if(join(program,tools,"construct"))fatal("tool path too long");
    a[0]=program;a[1]=rawfile;a[2]=resolved;a[3]=datafile;a[4]="run*0";
    if(invoke(program,a,5,codefile))fatal("construction failed");
    if(join(program,tools,"image"))fatal("tool path too long");
    a[0]=program;a[1]=codefile;a[2]=datafile;a[3]="0*0";a[4]="0*0";
    if(outmode){r=invoke(program,a,5,imageout);if(!r)publish();}
    else r=invoke(program,a,5,0);
    if(r)message("bcc-native: image generation failed*n");clean();return(r);
}
