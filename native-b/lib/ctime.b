__ctmon[] "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec";
__ctlen[] 31,28,31,30,31,30,31,31,30,31,30,31;

/* Write exactly sixteen bytes, independent of writable character helpers. */
ctime(tv,date) {
    extrn __ctmon,__ctlen;
    auto ticks,days,seconds,year,month,n,day,hour,minute,second,p,a,b;
    if((&tv)[-1]<2)return(-1);
    if(!tv | !date)return(-1);
    ticks=((tv[0]&65535)<<16)|(tv[1]&65535);
    days=ticks/5184000;seconds=ticks/60%86400;year=1971;month=0;
    while(1){
        n=year%4==0?366:365;
        if(days<n)goto monthday;
        days=days-n;year++;
    }
 monthday:
    while(1){
        n=__ctlen[month];if(month==1 & year%4==0)n++;
        if(days<n)goto format;
        days=days-n;month++;
    }
 format:
    day=days+1;hour=seconds/3600;minute=seconds/60%60;second=seconds%60;
    p=__ctmon[month];a=p[0]&16777215;
    a=a|(32<<24)|((day<10?32:day/10+48)<<32)|((day%10+48)<<40);
    a=a|(32<<48)|((hour/10+48)<<56);
    b=(hour%10+48)|(58<<8)|((minute/10+48)<<16)|((minute%10+48)<<24);
    b=b|(58<<32)|((second/10+48)<<40)|((second%10+48)<<48);
    date[0]=a;date[1]=b;return(0);
}
