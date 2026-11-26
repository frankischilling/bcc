/* Driver paths and arguments are OS strings: only NUL terminates them. */
execraw(path,args,count) {
    extrn __sys,__env;
    auto pointers 256,i;
    if(!path | count<0 | count>255)return(-1);
    if(count)if(!args)return(-1);
    i=0;while(i<count){if(!args[i])return(-1);pointers[i]=args[i]<<3;i++;}
    pointers[count]=0;
    __sys(59,path<<3,pointers<<3,__env,0,0,0);
    return(-1);
}
