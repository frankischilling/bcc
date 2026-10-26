#define _GNU_SOURCE
#include <dlfcn.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
int close(int fd) {
    int (*real_close)(int) = dlsym(RTLD_NEXT,"close");
    char link[64],path[4096];
    const char *target=getenv("BCC_CLOSE_TARGET");
    snprintf(link,sizeof link,"/proc/self/fd/%d",fd);
    ssize_t n=readlink(link,path,sizeof path-1);
    int match=0;
    if(n>=0){path[n]=0;const char *base=strrchr(path,'/');
        match=target && !strcmp(base?base+1:path,target) && (fcntl(fd,F_GETFL)&O_ACCMODE)!=O_RDONLY;}
    int result=real_close(fd);
    if(match && result==0){
        const char *seen=getenv("BCC_CLOSE_SEEN");
        if(seen){int out=open(seen,O_WRONLY|O_CREAT|O_TRUNC,0600);if(out>=0){write(out,"x",1);real_close(out);}}
        errno=EIO;return -1;
    }
    return result;
}
