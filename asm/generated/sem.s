	.file	"sem.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"putchar"
.LC1:
	.string	"getchar"
.LC2:
	.string	"exit"
.LC3:
	.string	"alloc"
.LC4:
	.string	"char"
.LC5:
	.string	"lchar"
.LC6:
	.string	"getchr"
.LC7:
	.string	"putchr"
.LC8:
	.string	"getstr"
.LC9:
	.string	"putstr"
.LC10:
	.string	"flush"
.LC11:
	.string	"reread"
.LC12:
	.string	"printf"
.LC13:
	.string	"printn"
.LC14:
	.string	"putnum"
.LC15:
	.string	"open"
.LC16:
	.string	"close"
.LC17:
	.string	"read"
.LC18:
	.string	"write"
.LC19:
	.string	"creat"
.LC20:
	.string	"seek"
.LC21:
	.string	"openr"
.LC22:
	.string	"openw"
.LC23:
	.string	"fork"
.LC24:
	.string	"wait"
.LC25:
	.string	"execl"
.LC26:
	.string	"execv"
.LC27:
	.string	"chdir"
.LC28:
	.string	"chmod"
.LC29:
	.string	"chown"
.LC30:
	.string	"link"
.LC31:
	.string	"unlink"
.LC32:
	.string	"stat"
.LC33:
	.string	"fstat"
.LC34:
	.string	"time"
.LC35:
	.string	"ctime"
.LC36:
	.string	"getuid"
.LC37:
	.string	"setuid"
.LC38:
	.string	"makdir"
.LC39:
	.string	"intr"
.LC40:
	.string	"system"
.LC41:
	.string	"callf"
.LC42:
	.string	"gtty"
.LC43:
	.string	"stty"
.LC44:
	.string	"argc"
.LC45:
	.string	"argv"
	.data
	.align 32
.LC47:
	.quad	.LC0
	.quad	.LC1
	.quad	.LC2
	.quad	.LC3
	.quad	.LC4
	.quad	.LC5
	.quad	.LC6
	.quad	.LC7
	.quad	.LC8
	.quad	.LC9
	.quad	.LC10
	.quad	.LC11
	.quad	.LC12
	.quad	.LC13
	.quad	.LC14
	.quad	.LC15
	.quad	.LC16
	.quad	.LC17
	.quad	.LC18
	.quad	.LC19
	.quad	.LC20
	.quad	.LC21
	.quad	.LC22
	.quad	.LC23
	.quad	.LC24
	.quad	.LC25
	.quad	.LC26
	.quad	.LC27
	.quad	.LC28
	.quad	.LC29
	.quad	.LC30
	.quad	.LC31
	.quad	.LC32
	.quad	.LC33
	.quad	.LC34
	.quad	.LC35
	.quad	.LC36
	.quad	.LC37
	.quad	.LC38
	.quad	.LC39
	.quad	.LC40
	.quad	.LC41
	.quad	.LC42
	.quad	.LC43
	.quad	.LC44
	.quad	.LC45
	.quad	0
	.text
	.p2align 4
	.type	sem_add_builtin_functions, @function
sem_add_builtin_functions:
.LFB23:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC47(%rip), %rsi
	movl	$47, %ecx
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leaq	40(%r14), %rax
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leaq	.LC0(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$408, %rsp
	.cfi_def_cfa_offset 464
	leaq	16(%rsp), %rdi
	movq	%rax, 8(%rsp)
	leaq	24(%rsp), %r13
	rep movsq
	.p2align 4
	.p2align 3
.L5:
	movq	(%r14), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r15
	testq	%r12, %r12
	je	.L2
	xorl	%ebx, %ebx
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L16:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L2
.L4:
	movq	(%r15,%rbx,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L16
	movq	0(%r13), %rbp
	addq	$8, %r13
	testq	%rbp, %rbp
	jne	.L5
.L17:
	addq	$408, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L2:
	.cfi_restore_state
	movq	%rbp, %rdi
	addq	$8, %r13
	call	sdup@PLT
	movq	8(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	$56, %edi
	call	xmalloc@PLT
	movq	%rbp, %rdi
	movl	$1, (%rax)
	movq	%rax, %rbx
	call	sdup@PLT
	movq	$0, 16(%rbx)
	movq	%rbx, %rsi
	movq	%rax, 8(%rbx)
	movq	(%r14), %rax
	movl	$0, 24(%rbx)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	-8(%r13), %rbp
	testq	%rbp, %rbp
	jne	.L5
	jmp	.L17
	.cfi_endproc
.LFE23:
	.size	sem_add_builtin_functions, .-sem_add_builtin_functions
	.section	.rodata.str1.1
.LC48:
	.string	"duplicate label '%s' at %d:%d"
	.text
	.p2align 4
	.type	sem_collect_labels, @function
sem_collect_labels:
.LFB32:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L47
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.L23(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
.L20:
	cmpl	$12, (%rbx)
	ja	.L18
	movl	(%rbx), %eax
	movslq	(%r14,%rax,4), %rax
	addq	%r14, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L23:
	.long	.L18-.L23
	.long	.L27-.L23
	.long	.L18-.L23
	.long	.L26-.L23
	.long	.L22-.L23
	.long	.L18-.L23
	.long	.L18-.L23
	.long	.L18-.L23
	.long	.L18-.L23
	.long	.L18-.L23
	.long	.L18-.L23
	.long	.L24-.L23
	.long	.L22-.L23
	.text
	.p2align 4,,10
	.p2align 3
.L27:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L18
.L28:
	movq	16(%rbx), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_collect_labels
	cmpq	24(%rbx), %rbp
	jb	.L28
.L18:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L22:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L32:
	testq	%rbx, %rbx
	jne	.L20
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L24:
	.cfi_restore_state
	movq	(%r12), %rax
	movq	16(%rbx), %r13
	movq	8(%rax), %r15
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L29
	xorl	%ebp, %ebp
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L51:
	addq	$1, %rbp
	cmpq	%rbp, 8(%rsp)
	je	.L29
.L31:
	movq	(%r15,%rbp,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L51
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC48(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r13
.L29:
	movl	$56, %edi
	movq	4(%rbx), %r15
	call	xmalloc@PLT
	movq	%r13, %rdi
	movl	$2, (%rax)
	movq	%rax, %rbp
	call	sdup@PLT
	movq	%r15, 16(%rbp)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%r12), %rax
	movl	$0, 24(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	24(%rbx), %rbx
	jmp	.L32
	.p2align 4,,10
	.p2align 3
.L26:
	movq	24(%rbx), %rsi
	movq	%r12, %rdi
	call	sem_collect_labels
	movq	32(%rbx), %rbx
	jmp	.L32
	.p2align 4,,10
	.p2align 3
.L47:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE32:
	.size	sem_collect_labels, .-sem_collect_labels
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC49:
	.string	"undefined internal name '%s' at %d:%d"
	.align 8
.LC50:
	.string	"'%s' is not a variable at %d:%d"
	.section	.rodata.str1.1
.LC51:
	.string	"invalid lvalue at %d:%d"
	.text
	.p2align 4
	.type	sem_check_lvalue, @function
sem_check_lvalue:
.LFB29:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	%rdi, (%rsp)
	testq	%rsi, %rsi
	je	.L52
	movl	(%rsi), %eax
	movq	%rsi, %rbx
	cmpl	$4, %eax
	je	.L55
	cmpl	$5, %eax
	je	.L56
	cmpl	$2, %eax
	jne	.L57
	movq	(%rdi), %rax
	movq	32(%rsi), %rbp
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L59
.L58:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L63
	movq	8(%rsp), %rax
	xorl	%r15d, %r15d
	movq	8(%rax), %r14
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L103:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L63
.L61:
	movq	(%r14,%r15,8), %r13
	movq	%rbp, %rsi
	movq	8(%r13), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L103
	movl	0(%r13), %eax
	testl	%eax, %eax
	jne	.L74
.L52:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L56:
	.cfi_restore_state
	cmpl	$32, 32(%rsi)
	je	.L104
.L57:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC51(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	dief@PLT
	.p2align 4,,10
	.p2align 3
.L55:
	.cfi_restore_state
	movq	(%rsp), %r14
	movq	32(%rsi), %rsi
	movq	%r14, %rdi
	call	sem_check_lvalue
	movq	40(%rbx), %rsi
	movq	%r14, %rdi
.L102:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	sem_check_expr
	.p2align 4,,10
	.p2align 3
.L104:
	.cfi_restore_state
	movq	40(%rsi), %rsi
	movq	(%rsp), %rdi
	jmp	.L102
	.p2align 4,,10
	.p2align 3
.L63:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L58
.L59:
	movq	(%rsp), %rax
	movl	g_strict(%rip), %edx
	movq	16(%rax), %r14
	movq	24(%rax), %r12
	testl	%edx, %edx
	jne	.L105
.L64:
	testq	%r12, %r12
	je	.L68
.L66:
	xorl	%ebx, %ebx
	jmp	.L70
	.p2align 4,,10
	.p2align 3
.L106:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L68
.L70:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L106
	jmp	.L52
	.p2align 4,,10
	.p2align 3
.L74:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC50(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	dief@PLT
.L105:
	.cfi_restore_state
	testq	%r12, %r12
	je	.L65
	xorl	%r15d, %r15d
	jmp	.L67
	.p2align 4,,10
	.p2align 3
.L107:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L65
.L67:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L107
	jmp	.L66
.L68:
	movq	(%rsp), %rax
	movq	72(%rax), %r12
	movq	64(%rax), %r14
	testq	%r12, %r12
	je	.L71
	xorl	%ebx, %ebx
	jmp	.L72
	.p2align 4,,10
	.p2align 3
.L108:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L71
.L72:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L108
	jmp	.L52
.L65:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%rbp, %rsi
	xorl	%eax, %eax
	leaq	.LC49(%rip), %rdi
	call	dief@PLT
	movq	(%rsp), %rax
	movq	32(%rbx), %rbp
	movq	16(%rax), %r14
	movq	24(%rax), %r12
	jmp	.L64
.L71:
	movq	%rbp, %rdi
	call	sdup@PLT
	movq	(%rsp), %rdi
	addq	$24, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	movq	%rax, %rsi
	popq	%rbp
	.cfi_def_cfa_offset 40
	addq	$64, %rdi
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	vec_push@PLT
	.cfi_endproc
.LFE29:
	.size	sem_check_lvalue, .-sem_check_lvalue
	.section	.rodata.str1.1
.LC52:
	.string	"'%s' is not callable at %d:%d"
	.text
	.p2align 4
	.type	sem_check_expr, @function
sem_check_expr:
.LFB30:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L196
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leaq	.L114(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
.L110:
	cmpl	$10, (%rbx)
	ja	.L109
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L114:
	.long	.L109-.L114
	.long	.L109-.L114
	.long	.L122-.L114
	.long	.L121-.L114
	.long	.L113-.L114
	.long	.L119-.L114
	.long	.L118-.L114
	.long	.L194-.L114
	.long	.L116-.L114
	.long	.L115-.L114
	.long	.L113-.L114
	.text
	.p2align 4,,10
	.p2align 3
.L122:
	movq	0(%rbp), %rax
	movq	32(%rbx), %r12
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L124
.L123:
	movq	8(%rsp), %rax
	movq	16(%rax), %rax
	movq	%rax, (%rsp)
	testq	%rax, %rax
	je	.L128
	movq	8(%rsp), %rax
	xorl	%r13d, %r13d
	movq	8(%rax), %r14
	jmp	.L126
	.p2align 4,,10
	.p2align 3
.L197:
	addq	$1, %r13
	cmpq	%r13, (%rsp)
	je	.L128
.L126:
	movq	(%r14,%r13,8), %r15
	movq	%r12, %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L197
	xorl	%eax, %eax
	cmpl	$1, (%r15)
	sete	%al
	movl	%eax, 12(%rbx)
.L109:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L113:
	.cfi_restore_state
	movq	32(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	40(%rbx), %rbx
.L147:
	testq	%rbx, %rbx
	jne	.L110
	jmp	.L109
	.p2align 4,,10
	.p2align 3
.L115:
	movq	32(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
.L194:
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	48(%rbx), %rbx
	jmp	.L147
	.p2align 4,,10
	.p2align 3
.L116:
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_lvalue
	movq	48(%rbx), %rbx
	jmp	.L147
	.p2align 4,,10
	.p2align 3
.L118:
	movq	40(%rbx), %rsi
.L195:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	jmp	sem_check_lvalue
	.p2align 4,,10
	.p2align 3
.L119:
	.cfi_restore_state
	movl	32(%rbx), %eax
	movq	40(%rbx), %rbx
	subl	$36, %eax
	cmpl	$1, %eax
	ja	.L147
	movq	%rbx, %rsi
	jmp	.L195
	.p2align 4,,10
	.p2align 3
.L121:
	movq	32(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L198
	movl	$1, 16(%rbx)
	movq	%rbp, %rdi
	call	sem_check_expr
.L145:
	xorl	%r12d, %r12d
	cmpq	$0, 48(%rbx)
	je	.L109
.L146:
	movq	40(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	48(%rbx), %r12
	jb	.L146
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L128:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L123
.L124:
	movq	24(%rbp), %r14
	movq	16(%rbp), %r15
	movl	$0, 12(%rbx)
	testq	%r14, %r14
	je	.L129
	xorl	%r13d, %r13d
	jmp	.L130
	.p2align 4,,10
	.p2align 3
.L199:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L129
.L130:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L199
	jmp	.L109
	.p2align 4,,10
	.p2align 3
.L198:
	movq	0(%rbp), %rax
	movq	32(%rsi), %r12
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L136
.L135:
	movq	8(%rsp), %rax
	movq	16(%rax), %rax
	movq	%rax, (%rsp)
	testq	%rax, %rax
	je	.L140
	movq	8(%rsp), %rax
	xorl	%r13d, %r13d
	movq	8(%rax), %r14
	jmp	.L138
	.p2align 4,,10
	.p2align 3
.L200:
	addq	$1, %r13
	cmpq	%r13, (%rsp)
	je	.L140
.L138:
	movq	(%r14,%r13,8), %r15
	movq	%r12, %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L200
	movl	(%r15), %eax
	cmpl	$1, %eax
	ja	.L201
.L151:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
.L144:
	movl	%eax, 16(%rbx)
	jmp	.L145
	.p2align 4,,10
	.p2align 3
.L140:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L135
.L136:
	movq	24(%rbp), %r14
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L141
	xorl	%r13d, %r13d
	jmp	.L143
	.p2align 4,,10
	.p2align 3
.L202:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L141
.L143:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L202
	xorl	%eax, %eax
	jmp	.L144
	.p2align 4,,10
	.p2align 3
.L201:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	xorl	%eax, %eax
	movq	%r12, %rsi
	leaq	.LC52(%rip), %rdi
	call	dief@PLT
	movl	(%r15), %eax
	jmp	.L151
.L196:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L129:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	72(%rbp), %r14
	movq	64(%rbp), %r15
	testq	%r14, %r14
	je	.L131
	xorl	%r13d, %r13d
	jmp	.L132
	.p2align 4,,10
	.p2align 3
.L203:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L131
.L132:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L203
	jmp	.L109
.L131:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L204
.L133:
	movq	%r12, %rdi
	call	sdup@PLT
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	64(%rbp), %rdi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	movq	%rax, %rsi
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	jmp	vec_push@PLT
.L141:
	.cfi_restore_state
	movq	%r12, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	xorl	%eax, %eax
	jmp	.L144
.L204:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r12, %rsi
	leaq	.LC49(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	32(%rbx), %r12
	jmp	.L133
	.cfi_endproc
.LFE30:
	.size	sem_check_expr, .-sem_check_expr
	.section	.rodata.str1.8
	.align 8
.LC53:
	.string	"internal: cannot pop global scope"
	.align 8
.LC54:
	.string	"bcc: warning: case label falls through to another case label at %d:%d\n"
	.text
	.p2align 4
	.type	sem_check_stmt, @function
sem_check_stmt:
.LFB31:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L278
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leaq	.L210(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
.L207:
	cmpl	$12, (%rbx)
	ja	.L205
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L210:
	.long	.L205-.L210
	.long	.L219-.L210
	.long	.L218-.L210
	.long	.L217-.L210
	.long	.L216-.L210
	.long	.L215-.L210
	.long	.L212-.L210
	.long	.L213-.L210
	.long	.L205-.L210
	.long	.L205-.L210
	.long	.L212-.L210
	.long	.L281-.L210
	.long	.L209-.L210
	.text
	.p2align 4,,10
	.p2align 3
.L219:
	movl	$32, %edi
	movq	0(%r13), %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 16(%rax)
	cmpq	$0, 24(%rbx)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, 0(%r13)
	je	.L222
	xorl	%ebp, %ebp
.L223:
	movq	16(%rbx), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_check_stmt
	cmpq	24(%rbx), %rbp
	jb	.L223
	movq	0(%r13), %rax
	movq	(%rax), %rbp
.L222:
	testq	%rbp, %rbp
	je	.L283
.L224:
	movq	%rbp, 0(%r13)
.L205:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L212:
	.cfi_restore_state
	movq	16(%rbx), %rsi
.L282:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r13, %rdi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	jmp	sem_check_expr
	.p2align 4,,10
	.p2align 3
.L281:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L229:
	testq	%rbx, %rbx
	jne	.L207
	jmp	.L205
	.p2align 4,,10
	.p2align 3
.L213:
	leaq	16(%r13), %rax
	cmpq	$0, 24(%rbx)
	movq	$0, 8(%rsp)
	movq	%rax, 16(%rsp)
	je	.L205
	.p2align 4
	.p2align 3
.L220:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	24(%r13), %rbp
	movq	16(%r13), %r14
	movq	(%rax,%rcx,8), %r12
	testq	%rbp, %rbp
	je	.L230
	xorl	%r15d, %r15d
	jmp	.L232
	.p2align 4,,10
	.p2align 3
.L284:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L230
.L232:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L284
.L231:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L220
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L217:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%rbx), %rbx
	jmp	.L229
	.p2align 4,,10
	.p2align 3
.L216:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rbx
	jmp	.L229
	.p2align 4,,10
	.p2align 3
.L215:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L282
	jmp	.L205
	.p2align 4,,10
	.p2align 3
.L209:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %r14
	testq	%r14, %r14
	je	.L205
	cmpl	$1, (%r14)
	jne	.L241
	cmpq	$0, 24(%r14)
	je	.L241
	xorl	%ecx, %ecx
	xorl	%r12d, %r12d
	leaq	.LC54(%rip), %r15
	jmp	.L237
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L234:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	andl	%eax, %ecx
.L236:
	addq	$1, %r12
	cmpq	24(%r14), %r12
	jnb	.L281
.L237:
	movq	16(%r14), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	cmpl	$13, %eax
	jne	.L234
	testl	%ecx, %ecx
	jne	.L285
.L235:
	movl	$1, %ecx
	jmp	.L236
	.p2align 4,,10
	.p2align 3
.L218:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L205
	.p2align 4
	.p2align 3
.L221:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbp
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L225
	xorl	%r15d, %r15d
	jmp	.L227
	.p2align 4,,10
	.p2align 3
.L286:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L225
.L227:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L286
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	movq	%rbp, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rbp
.L225:
	movq	4(%rbx), %rdx
	movl	$56, %edi
	movq	%rdx, 24(%rsp)
	call	xmalloc@PLT
	movq	%rbp, %rdi
	movl	$0, (%rax)
	movq	%rax, %r12
	call	sdup@PLT
	movq	16(%rsp), %r14
	movq	24(%rsp), %rdx
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	8(%r14), %rax
	movq	%rdx, 16(%r12)
	xorl	%edx, %edx
	movl	$0, 24(%r12)
	testq	%rax, %rax
	movq	%rax, 40(%r12)
	movq	0(%r13), %rax
	setne	%dl
	movl	%edx, 32(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	8(%r14), %rsi
	testq	%rsi, %rsi
	je	.L228
	movq	%r13, %rdi
	call	sem_check_expr
.L228:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L221
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L241:
	.cfi_restore_state
	movq	%r14, %rbx
	jmp	.L207
	.p2align 4,,10
	.p2align 3
.L230:
	movq	%r12, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L231
.L285:
	movl	8(%rdx), %ecx
	movq	stderr(%rip), %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	movl	4(%rdx), %edx
	call	fprintf@PLT
	jmp	.L235
.L283:
	xorl	%eax, %eax
	leaq	.LC53(%rip), %rdi
	call	dief@PLT
	movq	0(%r13), %rax
	movq	(%rax), %rbp
	jmp	.L224
.L278:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE31:
	.size	sem_check_stmt, .-sem_check_stmt
	.section	.rodata.str1.8
	.align 8
.LC55:
	.string	"internal: TOP_GAUTO should be ST_AUTO"
	.align 8
.LC56:
	.string	"duplicate extern definition '%s'"
	.text
	.p2align 4
	.globl	sem_check_program
	.type	sem_check_program, @function
sem_check_program:
.LFB36:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%rdi, 8(%rsp)
	movl	$88, %edi
	call	xmalloc@PLT
	movl	$32, %edi
	movq	%rbx, 8(%rax)
	movq	%rax, %r12
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	$0, 16(%rsp)
	movups	%xmm0, (%rax)
	movups	%xmm0, 16(%rax)
	movq	%rax, (%r12)
	leaq	16(%r12), %rax
	movups	%xmm0, 24(%r12)
	movups	%xmm0, 48(%r12)
	movups	%xmm0, 72(%r12)
	cmpq	$0, 8(%r14)
	movq	$0, 16(%r12)
	movq	$0, 40(%r12)
	movq	$0, 64(%r12)
	movq	%rax, 40(%rsp)
	je	.L309
	.p2align 4
	.p2align 3
.L288:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L291
	ja	.L292
	testl	%edx, %edx
	je	.L360
	movq	8(%rax), %r13
	movq	0(%r13), %rdi
	call	sdup@PLT
	leaq	40(%r12), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	(%r12), %rax
	movq	0(%r13), %rbx
	movq	16(%rax), %rbp
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L303
	xorl	%r15d, %r15d
	jmp	.L305
	.p2align 4,,10
	.p2align 3
.L361:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L303
.L305:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L361
	movq	8(%r12), %rdi
	movq	%rbx, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	movq	0(%r13), %rbx
.L303:
	movl	$56, %edi
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movl	$1, (%rax)
	movq	%rax, %rbp
	call	sdup@PLT
	movdqu	8(%r13), %xmm0
	movq	$0, 16(%rbp)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	24(%r13), %rax
	movl	$0, 24(%rbp)
	movq	%rax, 48(%rbp)
	movq	(%r12), %rax
	movups	%xmm0, 32(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
.L296:
	movq	8(%rsp), %rcx
	addq	$1, 16(%rsp)
	movq	16(%rsp), %rax
	cmpq	8(%rcx), %rax
	jb	.L288
.L309:
	movq	%r12, %rdi
	call	sem_add_builtin_functions
	movq	8(%rsp), %rax
	movq	$0, 16(%rsp)
	cmpq	$0, 8(%rax)
	jne	.L289
	jmp	.L290
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L312:
	movq	8(%rsp), %rcx
	addq	$1, 16(%rsp)
	movq	16(%rsp), %rax
	cmpq	8(%rcx), %rax
	jnb	.L290
.L289:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L312
	movq	8(%rax), %r13
	movl	$32, %edi
	movq	(%r12), %rbx
	call	xmalloc@PLT
	pxor	%xmm2, %xmm2
	movups	%xmm2, 16(%rax)
	cmpq	$0, 16(%r13)
	movq	%rbx, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, (%r12)
	je	.L313
	movq	$0, (%rsp)
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L317:
	movq	8(%r13), %rdx
	movq	(%rsp), %rcx
	movq	8(%rax), %r14
	movq	(%rdx,%rcx,8), %rbx
	testq	%rbp, %rbp
	je	.L314
	xorl	%r15d, %r15d
	jmp	.L316
	.p2align 4,,10
	.p2align 3
.L362:
	addq	$1, %r15
	cmpq	%rbp, %r15
	je	.L314
.L316:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L362
	movq	8(%r12), %rdi
	movq	%rbx, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
.L314:
	movl	$56, %edi
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movl	$0, (%rax)
	movq	%rax, %rbp
	call	sdup@PLT
	movq	$0, 16(%rbp)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%r12), %rax
	movl	$0, 24(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	16(%r13), %rax
	jnb	.L313
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	jmp	.L317
	.p2align 4,,10
	.p2align 3
.L292:
	cmpl	$3, %edx
	jne	.L296
	movq	8(%rax), %rax
	movq	8(%rax), %rdi
	call	sdup@PLT
	movq	40(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L296
	.p2align 4,,10
	.p2align 3
.L313:
	movq	32(%r13), %rsi
	movq	%r12, %rdi
	call	sem_collect_labels
	movq	32(%r13), %rsi
	movq	%r12, %rdi
	call	sem_check_stmt
	movq	(%r12), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L363
.L318:
	movq	%rax, (%r12)
	jmp	.L312
	.p2align 4,,10
	.p2align 3
.L291:
	movq	8(%rax), %r13
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	movq	8(%r13), %rbx
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L306
	xorl	%r15d, %r15d
	jmp	.L308
	.p2align 4,,10
	.p2align 3
.L364:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L306
.L308:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L364
	movq	%rbx, %rsi
	leaq	.LC56(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	8(%r13), %rbx
.L306:
	movl	$56, %edi
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movl	$0, (%rax)
	movq	%rax, %rbp
	call	sdup@PLT
	movq	$0, 16(%rbp)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%r12), %rax
	movl	$1, 24(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L296
	.p2align 4,,10
	.p2align 3
.L360:
	movq	8(%rax), %r14
	cmpl	$2, (%r14)
	je	.L297
	leaq	.LC55(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L297:
	cmpq	$0, 24(%r14)
	movq	$0, (%rsp)
	je	.L296
	.p2align 4
	.p2align 3
.L298:
	movq	16(%r14), %rax
	movq	(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 24(%rsp)
	movq	(%rax), %rbx
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r13
	testq	%rbp, %rbp
	je	.L299
	xorl	%r15d, %r15d
	jmp	.L301
	.p2align 4,,10
	.p2align 3
.L365:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L299
.L301:
	movq	0(%r13,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L365
	movl	8(%r14), %edx
	movl	4(%r14), %esi
	movq	%rbx, %r8
	movl	$10, %ecx
	movq	8(%r12), %rdi
	call	error_at_location@PLT
	movq	24(%rsp), %rax
	movq	(%rax), %rbx
.L299:
	movq	4(%r14), %rdx
	movl	$56, %edi
	movq	%rdx, 32(%rsp)
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movl	$0, (%rax)
	movq	%rax, %rbp
	call	sdup@PLT
	movq	32(%rsp), %rdx
	movl	$0, 24(%rbp)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	24(%rsp), %rax
	movq	%rdx, 16(%rbp)
	xorl	%edx, %edx
	movq	8(%rax), %rax
	testq	%rax, %rax
	movq	%rax, 40(%rbp)
	movq	(%r12), %rax
	setne	%dl
	movl	%edx, 32(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	24(%r14), %rax
	jb	.L298
	jmp	.L296
.L290:
	xorl	%r13d, %r13d
	cmpq	$0, 72(%r12)
	je	.L287
	.p2align 4
	.p2align 3
.L310:
	movq	64(%r12), %rax
	movq	(%rax,%r13,8), %rbp
	movq	8(%rsp), %rax
	movq	8(%rax), %r15
	testq	%r15, %r15
	je	.L319
	movq	(%rax), %r14
	xorl	%ebx, %ebx
	jmp	.L322
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L320:
	addq	$1, %rbx
	cmpq	%rbx, %r15
	je	.L319
.L322:
	movq	(%r14,%rbx,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L320
	movq	8(%rdx), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L320
	addq	$1, %r13
	cmpq	72(%r12), %r13
	jb	.L310
.L287:
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L319:
	.cfi_restore_state
	movl	$16, %edi
	addq	$1, %r13
	call	xmalloc@PLT
	movl	$56, %edi
	movl	$2, (%rax)
	movq	%rax, %r15
	call	xmalloc@PLT
	pxor	%xmm1, %xmm1
	movq	%rbp, %rdi
	movups	%xmm1, (%rax)
	movq	%rax, %rbx
	movq	$0, 48(%rax)
	movl	$1, 4(%rax)
	movups	%xmm1, 16(%rax)
	movups	%xmm1, 32(%rax)
	call	sdup@PLT
	movl	$0, 16(%rbx)
	movq	8(%rsp), %rdi
	movq	%r15, %rsi
	movq	%rax, 8(%rbx)
	movq	$0, 48(%rbx)
	movq	%rbx, 8(%r15)
	call	vec_push@PLT
	cmpq	72(%r12), %r13
	jb	.L310
	jmp	.L287
.L363:
	leaq	.LC53(%rip), %rdi
	call	dief@PLT
	movq	(%r12), %rax
	movq	(%rax), %rax
	jmp	.L318
	.cfi_endproc
.LFE36:
	.size	sem_check_program, .-sem_check_program
	.section	.note.GNU-stack,"",@progbits
