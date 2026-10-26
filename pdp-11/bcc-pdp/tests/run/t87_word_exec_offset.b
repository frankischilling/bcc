main(){auto v 3;extrn execv;
v[0]="ignored";v[1]="chosen";v[2]="works";
execv("xx/bin/echo"+1,v+1,2);return(99);}
