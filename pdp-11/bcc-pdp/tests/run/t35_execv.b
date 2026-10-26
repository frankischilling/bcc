main(){auto v 3;extrn execv;v[0]="chosen";v[1]="works";v[2]="ignored";
execv("/bin/echo",v,2);return(99);}
