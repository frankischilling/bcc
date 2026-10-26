/* Publish a complete file with link(), which never replaces a destination. */
outmode 0;outown 0;outpath[512];outpar[512];outtemp[512];imageout[512];
prepout(path){
    extrn outmode,outpath,outpar,imageout,folder,__sys,char,lchar;
    auto n,i,last,r;
    if(!char(path,0))fatal("empty output path");
    if(char(path,0)=='/')r=copyos(outpath,path);
    else{
        n=__sys(79,outpath<<3,4096,0,0,0,0);if(n<1)fatal("cannot read working directory");
        r=append(outpath,"/");if(!r)r=appendos(outpath,path);
    }
    if(r<0)fatal("output path too long");n=rawlen(outpath);last= -1;i=0;
    while(i<n){if(char(outpath,i)=='/')last=i;i++;}
    if(last<0 | last==n-1)fatal("invalid output path");
    copyos(outpar,outpath);lchar(outpar,last+1,0);
    if(join(imageout,folder,"/image"))fatal("scratch path too long");outmode=1;
}
outclear(){
    extrn outown,outtemp,imageout,__sys,char;
    if(outown){__sys(87,outtemp<<3,0,0,0,0,0);outown=0;}
    if(char(imageout,0))__sys(87,imageout<<3,0,0,0,0,0);
}
publish(){
    extrn outown,outpath,outpar,outtemp,imageout,__sys,close,savedmsk;
    auto in,out,pid,i,r;
    if(__sys(95,savedmsk,0,0,0,0,0)<0)fatal("cannot restore output permissions");
    in=__sys(2,imageout<<3,0,0,0,0,0);if(in<0)fatal("cannot read completed image");
    pid=__sys(39,0,0,0,0,0,0);if(pid<1){close(in);fatal("cannot read process ID");}
    i=0;
    while(i<1000){
        if(join(outtemp,outpar,".bcc-output-"))goto names;
        if(number(outtemp,pid))goto names;if(append(outtemp,"-"))goto names;
        if(number(outtemp,i++))goto names;
        /* O_WRONLY | O_CREAT | O_EXCL; mode remains subject to umask. */
        out=__sys(2,outtemp<<3,193,0700,0,0,0);
        if(out>=0){outown=1;goto opened;}if(out!=-17)goto names;
    }
 names:close(in);fatal("cannot create output temporary file");
 opened:
    r=copydata(in,out);if(!r)if(__sys(74,out,0,0,0,0,0)<0)r= -1;
    if(close(in)<0)r= -1;if(close(out)<0)r= -1;
    if(r)fatal("output write or close failed");
    r=__sys(86,outtemp<<3,outpath<<3,0,0,0,0);
    if(r==-17)fatal("output already exists");if(r<0)fatal("cannot publish output");
    if(__sys(87,outtemp<<3,0,0,0,0,0)<0)fatal("output temporary cleanup failed");
    outown=0;return(0);
}
