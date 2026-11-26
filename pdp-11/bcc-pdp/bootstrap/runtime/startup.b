/* PDP-11 startup instruction templates for the B image writer. */
startup(){
    emit("/ Startup for word-addressed B programs. Kernel argv strings may be odd-aligned.*nexit = 1.*nwrite = 4.*n.. = 40014*n.globl start*n.globl _main*n.globl _argv*n.globl .bend*n*nstart:*n*tmov*tsp, r0*n*tmov*t(r0)+, r1*n");
    emit("*tbic*t$1, sp*t*t/ keep copies and B frames word-aligned*n*t/ Reserve the complete count-prefixed vector before copying strings.*n*tcmp*tr1, $8190.*n*tbhi*t.argerr*n*tmov*tr1, r2*n*tinc*tr2*n*tasl*tr2*n*tmov*tsp, r5*n*tsub*tr2,");
    emit(" r5*n*tbcs*t.argerr*n*tcmp*tr5, $.bend+8*n*tblos*t.argerr*n*tmov*tr5, sp*n*tmov*tr5, r2*n*tmov*tr5, _argv*n*tasr*t_argv*n*tmov*tr1, (r2)+*n.arglp:*n*ttst*tr1*n*tbeq*t.argdn*n*tmov*t(r0)+, r3*n*tmov*tr3, r4*n.argln:*n*ttstb*t(r4)+*n*tbne*t.argln");
    emit("*n*tsub*tr3, r4*n*tinc*tr4*n*tbeq*t.argerr*n*tbic*t$1, r4*n*tmov*tsp, r5*n*tsub*tr4, r5*n*tbcs*t.argerr*n*tcmp*tr5, $.bend+8*n*tblos*t.argerr*n*tmov*tr5, sp*n*tmov*tsp, r4*n.argcp:*n*tmovb*t(r3)+, (r4)+*n*tbne*t.argcp*n*tmov*tsp, r4*n*tasr*tr4*n*tm");
    emit("ov*tr4, (r2)+*n*tdec*tr1*n*tbr*t.arglp*n.argdn:*n*t/ Optional main parameters exclude the program name.*n*tclr*tr5*n*tmov*t_argv, r0*n*tadd*t$2, r0*n*tmov*tr0, -(sp)*n*tmov*t_argv, r0*n*tasl*tr0*n*tmov*t(r0), r0*n*tdec*tr0*n*tbge*t1f*n*tcl");
    emit("r*tr0*n1:*n*tmov*tr0, -(sp)*n*tjsr*tpc, **_main*n*tadd*t$4, sp*n*tsys*texit*n.argerr:*n*tmov*t$1, r0*n*tsys*twrite; .argmsg; 22.*n*tmov*t$1, r0*n*tsys*texit*n.argmsg: <bcc: argument storage\n>*n.even*n*n/ Writable pointer cell; star");
    emit("tup allocates its vector on the process stack.*n_argv:*n*t0*n");
}
