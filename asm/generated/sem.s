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
	subq	$392, %rsp
	.cfi_def_cfa_offset 448
	movq	%rsp, %rdi
	leaq	8(%rsp), %r13
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
	addq	$392, %rsp
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
	leaq	40(%r14), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	$56, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %rbx
	movl	$1, (%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 36(%rax)
	call	sdup@PLT
	movdqa	.LC48(%rip), %xmm1
	movq	%rbx, %rsi
	movq	%rax, 8(%rbx)
	movq	(%r14), %rax
	movups	%xmm1, 16(%rbx)
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
.LC51:
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
	leaq	.LC51(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r13
.L29:
	movl	$56, %edi
	movq	4(%rbx), %r15
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r13, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %rbp
	movl	$2, (%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 36(%rax)
	call	sdup@PLT
	movq	%r15, 16(%rbp)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%r12), %rax
	movq	$0, 24(%rbp)
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
.LC52:
	.string	"undefined internal name '%s' at %d:%d"
	.align 8
.LC53:
	.string	"'%s' is not a variable at %d:%d"
	.section	.rodata.str1.1
.LC54:
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	%rdi, 16(%rsp)
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
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L59
.L58:
	movq	24(%rsp), %rax
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L63
	movq	24(%rsp), %rax
	xorl	%r12d, %r12d
	movq	8(%rax), %r14
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L104:
	addq	$1, %r12
	cmpq	%r12, 8(%rsp)
	je	.L63
.L61:
	movq	(%r14,%r12,8), %r13
	movq	%rbp, %rsi
	movq	8(%r13), %r15
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L104
	movl	28(%r13), %eax
	testl	%eax, %eax
	je	.L73
	leaq	.LC45(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L73
	movl	$1, 16(%rbx)
.L52:
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
.L56:
	.cfi_restore_state
	cmpl	$32, 32(%rsi)
	je	.L105
.L57:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC54(%rip), %rdi
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
	movq	16(%rsp), %r14
	movq	32(%rsi), %rsi
	movq	%r14, %rdi
	call	sem_check_lvalue
	movq	40(%rbx), %rsi
	movq	%r14, %rdi
.L103:
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
	jmp	sem_check_expr
	.p2align 4,,10
	.p2align 3
.L105:
	.cfi_restore_state
	movq	40(%rsi), %rsi
	movq	16(%rsp), %rdi
	jmp	.L103
	.p2align 4,,10
	.p2align 3
.L73:
	movl	0(%r13), %edx
	testl	%edx, %edx
	je	.L52
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC53(%rip), %rdi
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
	.p2align 4,,10
	.p2align 3
.L63:
	.cfi_restore_state
	movq	24(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L58
.L59:
	movq	16(%rsp), %rax
	movl	g_strict(%rip), %ecx
	movq	16(%rax), %r14
	movq	24(%rax), %r12
	testl	%ecx, %ecx
	jne	.L106
.L64:
	testq	%r12, %r12
	je	.L68
.L66:
	xorl	%ebx, %ebx
	jmp	.L70
	.p2align 4,,10
	.p2align 3
.L107:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L68
.L70:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L107
	jmp	.L52
.L106:
	testq	%r12, %r12
	je	.L65
	xorl	%r15d, %r15d
	jmp	.L67
	.p2align 4,,10
	.p2align 3
.L108:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L65
.L67:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L108
	jmp	.L66
.L68:
	movq	16(%rsp), %rax
	movq	72(%rax), %r12
	movq	64(%rax), %r14
	testq	%r12, %r12
	je	.L71
	xorl	%ebx, %ebx
	jmp	.L72
	.p2align 4,,10
	.p2align 3
.L109:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L71
.L72:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L109
	jmp	.L52
.L65:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%rbp, %rsi
	xorl	%eax, %eax
	leaq	.LC52(%rip), %rdi
	call	dief@PLT
	movq	16(%rsp), %rax
	movq	32(%rbx), %rbp
	movq	16(%rax), %r14
	movq	24(%rax), %r12
	jmp	.L64
.L71:
	movq	%rbp, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	addq	$40, %rsp
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
.LC55:
	.string	"'%s' is not callable at %d:%d"
	.text
	.p2align 4
	.type	sem_check_expr, @function
sem_check_expr:
.LFB30:
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
	leaq	.L115(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	%rdi, 16(%rsp)
	testq	%rsi, %rsi
	je	.L110
.L111:
	cmpl	$10, (%rbx)
	ja	.L110
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L115:
	.long	.L110-.L115
	.long	.L110-.L115
	.long	.L123-.L115
	.long	.L122-.L115
	.long	.L114-.L115
	.long	.L120-.L115
	.long	.L119-.L115
	.long	.L118-.L115
	.long	.L117-.L115
	.long	.L116-.L115
	.long	.L114-.L115
	.text
	.p2align 4,,10
	.p2align 3
.L122:
	movq	32(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L195
	movl	$1, 20(%rbx)
	movq	16(%rsp), %rdi
	call	sem_check_expr
.L148:
	xorl	%r12d, %r12d
	cmpq	$0, 48(%rbx)
	je	.L110
.L149:
	movq	40(%rbx), %rax
	movq	16(%rsp), %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	48(%rbx), %r12
	jb	.L149
.L110:
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
.L114:
	.cfi_restore_state
	movq	32(%rbx), %rsi
	movq	16(%rsp), %rdi
	call	sem_check_expr
	movq	40(%rbx), %rbx
.L150:
	testq	%rbx, %rbx
	jne	.L111
	jmp	.L110
	.p2align 4,,10
	.p2align 3
.L123:
	movq	16(%rsp), %rax
	movq	32(%rbx), %r12
	movq	(%rax), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.L125
.L124:
	movq	24(%rsp), %rax
	movq	16(%rax), %r13
	testq	%r13, %r13
	je	.L129
	movq	24(%rsp), %rax
	xorl	%r14d, %r14d
	movq	8(%rax), %rax
	movq	%rax, 8(%rsp)
	jmp	.L127
	.p2align 4,,10
	.p2align 3
.L196:
	addq	$1, %r14
	cmpq	%r13, %r14
	je	.L129
.L127:
	movq	8(%rsp), %rax
	movq	%r12, %rsi
	movq	(%rax,%r14,8), %r15
	movq	8(%r15), %rbp
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L196
	movl	28(%r15), %eax
	testl	%eax, %eax
	je	.L130
	leaq	.LC45(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
.L130:
	cmpl	$1, (%r15)
	movl	%eax, 16(%rbx)
	je	.L133
	movl	$0, 12(%rbx)
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
.L116:
	.cfi_restore_state
	movq	16(%rsp), %r15
	movq	32(%rbx), %rsi
	movq	%r15, %rdi
	call	sem_check_expr
	movq	40(%rbx), %rsi
	movq	%r15, %rdi
	call	sem_check_expr
	movq	48(%rbx), %rbx
	jmp	.L150
	.p2align 4,,10
	.p2align 3
.L117:
	movq	40(%rbx), %rsi
	movq	16(%rsp), %rdi
	call	sem_check_lvalue
	movq	48(%rbx), %rbx
	jmp	.L150
	.p2align 4,,10
	.p2align 3
.L118:
	movq	40(%rbx), %rsi
	movq	16(%rsp), %rdi
	call	sem_check_expr
	movq	48(%rbx), %rbx
	jmp	.L150
	.p2align 4,,10
	.p2align 3
.L119:
	movq	40(%rbx), %rsi
.L194:
	movq	16(%rsp), %rdi
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
	jmp	sem_check_lvalue
	.p2align 4,,10
	.p2align 3
.L120:
	.cfi_restore_state
	movl	32(%rbx), %eax
	movq	40(%rbx), %rbx
	subl	$36, %eax
	cmpl	$1, %eax
	ja	.L150
	movq	%rbx, %rsi
	jmp	.L194
	.p2align 4,,10
	.p2align 3
.L129:
	movq	24(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.L124
.L125:
	movq	16(%rsp), %rax
	movq	$0, 12(%rbx)
	movq	24(%rax), %r14
	movq	16(%rax), %r15
	testq	%r14, %r14
	je	.L131
	xorl	%r13d, %r13d
	jmp	.L132
	.p2align 4,,10
	.p2align 3
.L197:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L131
.L132:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L197
	jmp	.L110
	.p2align 4,,10
	.p2align 3
.L195:
	movq	16(%rsp), %rax
	movq	32(%rsi), %r12
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L139
.L138:
	movq	8(%rsp), %rax
	movq	16(%rax), %r13
	testq	%r13, %r13
	je	.L143
	movq	8(%rsp), %rax
	xorl	%ebp, %ebp
	movq	8(%rax), %r14
	jmp	.L141
	.p2align 4,,10
	.p2align 3
.L198:
	addq	$1, %rbp
	cmpq	%rbp, %r13
	je	.L143
.L141:
	movq	(%r14,%rbp,8), %r15
	movq	%r12, %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L198
	movl	(%r15), %eax
	cmpl	$1, %eax
	ja	.L199
.L153:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
.L147:
	movl	%eax, 20(%rbx)
	jmp	.L148
	.p2align 4,,10
	.p2align 3
.L143:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L138
.L139:
	movq	16(%rsp), %rax
	movq	24(%rax), %r14
	movq	16(%rax), %r15
	testq	%r14, %r14
	je	.L144
	xorl	%r13d, %r13d
	jmp	.L146
	.p2align 4,,10
	.p2align 3
.L200:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L144
.L146:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L200
	xorl	%eax, %eax
	jmp	.L147
	.p2align 4,,10
	.p2align 3
.L133:
	xorl	$1, %eax
	movl	%eax, 12(%rbx)
	jmp	.L110
.L199:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	xorl	%eax, %eax
	movq	%r12, %rsi
	leaq	.LC55(%rip), %rdi
	call	dief@PLT
	movl	(%r15), %eax
	jmp	.L153
.L131:
	movq	16(%rsp), %rax
	movq	72(%rax), %r14
	movq	64(%rax), %r15
	testq	%r14, %r14
	je	.L134
	xorl	%r13d, %r13d
	jmp	.L135
	.p2align 4,,10
	.p2align 3
.L201:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L134
.L135:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L201
	jmp	.L110
.L134:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L202
.L136:
	movq	%r12, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	addq	$40, %rsp
	.cfi_remember_state
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
.L144:
	.cfi_restore_state
	movq	%r12, %rdi
	call	sdup@PLT
	movq	%rax, %rsi
	movq	16(%rsp), %rax
	leaq	16(%rax), %rdi
	call	vec_push@PLT
	xorl	%eax, %eax
	jmp	.L147
.L202:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r12, %rsi
	leaq	.LC52(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	32(%rbx), %r12
	jmp	.L136
	.cfi_endproc
.LFE30:
	.size	sem_check_expr, .-sem_check_expr
	.section	.rodata.str1.8
	.align 8
.LC56:
	.string	"internal: cannot pop global scope"
	.align 8
.LC57:
	.string	"bcc: warning: case label falls through to another case label at %d:%d\n"
	.text
	.p2align 4
	.type	sem_check_stmt, @function
sem_check_stmt:
.LFB31:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L276
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
	leaq	.L208(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
.L205:
	cmpl	$12, (%rbx)
	ja	.L203
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L208:
	.long	.L203-.L208
	.long	.L217-.L208
	.long	.L216-.L208
	.long	.L215-.L208
	.long	.L214-.L208
	.long	.L213-.L208
	.long	.L210-.L208
	.long	.L211-.L208
	.long	.L203-.L208
	.long	.L203-.L208
	.long	.L210-.L208
	.long	.L279-.L208
	.long	.L207-.L208
	.text
	.p2align 4,,10
	.p2align 3
.L217:
	movl	$32, %edi
	movq	0(%r13), %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 16(%rax)
	cmpq	$0, 24(%rbx)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, 0(%r13)
	je	.L220
	xorl	%ebp, %ebp
.L221:
	movq	16(%rbx), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_check_stmt
	cmpq	24(%rbx), %rbp
	jb	.L221
	movq	0(%r13), %rax
	movq	(%rax), %rbp
.L220:
	testq	%rbp, %rbp
	je	.L281
.L222:
	movq	%rbp, 0(%r13)
.L203:
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
.L210:
	.cfi_restore_state
	movq	16(%rbx), %rsi
.L280:
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
.L279:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L227:
	testq	%rbx, %rbx
	jne	.L205
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L211:
	leaq	16(%r13), %rax
	cmpq	$0, 24(%rbx)
	movq	$0, 8(%rsp)
	movq	%rax, 16(%rsp)
	je	.L203
	.p2align 4
	.p2align 3
.L218:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	24(%r13), %rbp
	movq	16(%r13), %r14
	movq	(%rax,%rcx,8), %r12
	testq	%rbp, %rbp
	je	.L228
	xorl	%r15d, %r15d
	jmp	.L230
	.p2align 4,,10
	.p2align 3
.L282:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L228
.L230:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L282
.L229:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L218
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
.L215:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%rbx), %rbx
	jmp	.L227
	.p2align 4,,10
	.p2align 3
.L214:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rbx
	jmp	.L227
	.p2align 4,,10
	.p2align 3
.L213:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L280
	jmp	.L203
	.p2align 4,,10
	.p2align 3
.L207:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %r14
	testq	%r14, %r14
	je	.L203
	cmpl	$1, (%r14)
	jne	.L239
	cmpq	$0, 24(%r14)
	je	.L239
	xorl	%ecx, %ecx
	xorl	%r12d, %r12d
	leaq	.LC57(%rip), %r15
	jmp	.L235
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L232:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	andl	%eax, %ecx
.L234:
	addq	$1, %r12
	cmpq	24(%r14), %r12
	jnb	.L279
.L235:
	movq	16(%r14), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	cmpl	$13, %eax
	jne	.L232
	testl	%ecx, %ecx
	jne	.L283
.L233:
	movl	$1, %ecx
	jmp	.L234
	.p2align 4,,10
	.p2align 3
.L216:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L203
	.p2align 4
	.p2align 3
.L219:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbp
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L223
	xorl	%r15d, %r15d
	jmp	.L225
	.p2align 4,,10
	.p2align 3
.L284:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L223
.L225:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L284
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	movq	%rbp, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rbp
.L223:
	movq	4(%rbx), %rdx
	movl	$56, %edi
	movq	%rdx, 24(%rsp)
	call	xmalloc@PLT
	pxor	%xmm1, %xmm1
	movq	%rbp, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %r12
	movl	$0, (%rax)
	movups	%xmm1, 4(%rax)
	movups	%xmm1, 20(%rax)
	movups	%xmm1, 36(%rax)
	call	sdup@PLT
	movq	16(%rsp), %r14
	movq	24(%rsp), %rdx
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	8(%r14), %rax
	movq	%rdx, 16(%r12)
	xorl	%edx, %edx
	movq	$0, 24(%r12)
	testq	%rax, %rax
	movq	%rax, 40(%r12)
	movq	0(%r13), %rax
	setne	%dl
	movl	%edx, 32(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	8(%r14), %rsi
	testq	%rsi, %rsi
	je	.L226
	movq	%r13, %rdi
	call	sem_check_expr
.L226:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L219
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
.L239:
	.cfi_restore_state
	movq	%r14, %rbx
	jmp	.L205
	.p2align 4,,10
	.p2align 3
.L228:
	movq	%r12, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L229
.L283:
	movl	8(%rdx), %ecx
	movq	stderr(%rip), %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	movl	4(%rdx), %edx
	call	fprintf@PLT
	jmp	.L233
.L281:
	xorl	%eax, %eax
	leaq	.LC56(%rip), %rdi
	call	dief@PLT
	movq	0(%r13), %rax
	movq	(%rax), %rbp
	jmp	.L222
.L276:
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
.LC58:
	.string	"internal: TOP_GAUTO should be ST_AUTO"
	.align 8
.LC60:
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
	movq	%rdi, 16(%rsp)
	movl	$88, %edi
	call	xmalloc@PLT
	movl	$32, %edi
	movq	%rbx, 8(%rax)
	movq	%rax, %r12
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	$0, 24(%rsp)
	movups	%xmm0, (%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 24(%r12)
	movups	%xmm0, 48(%r12)
	movups	%xmm0, 72(%r12)
	cmpq	$0, 8(%r14)
	movq	%rax, (%r12)
	movq	$0, 16(%r12)
	movq	$0, 40(%r12)
	movq	$0, 64(%r12)
	je	.L307
	.p2align 4
	.p2align 3
.L286:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L289
	ja	.L290
	testl	%edx, %edx
	je	.L373
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
	je	.L301
	xorl	%r15d, %r15d
	jmp	.L303
	.p2align 4,,10
	.p2align 3
.L374:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L301
.L303:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L374
	movq	8(%r12), %rdi
	movq	%rbx, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	movq	0(%r13), %rbx
.L301:
	movl	$56, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbx, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %rbp
	movl	$1, (%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 36(%rax)
	call	sdup@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	24(%r13), %rax
	movups	%xmm0, 16(%rbp)
	movdqu	8(%r13), %xmm0
	movq	%rax, 48(%rbp)
	movq	(%r12), %rax
	movups	%xmm0, 32(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
.L294:
	movq	16(%rsp), %rcx
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8(%rcx), %rax
	jb	.L286
.L307:
	cmpq	$0, 8+g_known_functions(%rip)
	leaq	g_known_functions(%rip), %r13
	movq	$0, 8(%rsp)
	je	.L288
	.p2align 4
	.p2align 3
.L287:
	movq	0(%r13), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rbx
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L310
	xorl	%r15d, %r15d
	jmp	.L312
	.p2align 4,,10
	.p2align 3
.L375:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L310
.L312:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L375
.L311:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L287
.L288:
	movq	%r12, %rdi
	call	sem_add_builtin_functions
	movq	16(%rsp), %rax
	movq	$0, 24(%rsp)
	cmpq	$0, 8(%rax)
	jne	.L308
	jmp	.L309
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L315:
	movq	16(%rsp), %rcx
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8(%rcx), %rax
	jnb	.L309
.L308:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L315
	movq	8(%rax), %r13
	movl	$32, %edi
	movq	(%r12), %rbx
	call	xmalloc@PLT
	pxor	%xmm6, %xmm6
	movups	%xmm6, 16(%rax)
	cmpq	$0, 16(%r13)
	movq	%rbx, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, (%r12)
	je	.L316
	movq	$0, 8(%rsp)
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L320:
	movq	8(%r13), %rdx
	movq	8(%rsp), %rcx
	movq	8(%rax), %r14
	movq	(%rdx,%rcx,8), %rbx
	testq	%rbp, %rbp
	je	.L317
	xorl	%r15d, %r15d
	jmp	.L319
	.p2align 4,,10
	.p2align 3
.L376:
	addq	$1, %r15
	cmpq	%rbp, %r15
	je	.L317
.L319:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L376
	movq	8(%r12), %rdi
	movq	%rbx, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
.L317:
	movl	$56, %edi
	call	xmalloc@PLT
	pxor	%xmm1, %xmm1
	movq	%rbx, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %rbp
	movl	$0, (%rax)
	movups	%xmm1, 4(%rax)
	movups	%xmm1, 20(%rax)
	movups	%xmm1, 36(%rax)
	call	sdup@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%r12), %rax
	movups	%xmm0, 16(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	16(%r13), %rax
	jnb	.L316
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	jmp	.L320
	.p2align 4,,10
	.p2align 3
.L310:
	movl	$56, %edi
	call	xmalloc@PLT
	pxor	%xmm3, %xmm3
	movq	%rbx, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %rbp
	movl	$1, (%rax)
	movups	%xmm3, 4(%rax)
	movups	%xmm3, 20(%rax)
	movups	%xmm3, 36(%rax)
	call	sdup@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%r12), %rax
	movups	%xmm0, 16(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	%rbx, %rdi
	call	sdup@PLT
	leaq	40(%r12), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L311
	.p2align 4,,10
	.p2align 3
.L290:
	cmpl	$3, %edx
	jne	.L294
	movq	8(%rax), %rax
	movq	8(%rax), %rdi
	call	sdup@PLT
	leaq	16(%r12), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L294
	.p2align 4,,10
	.p2align 3
.L316:
	movq	32(%r13), %rsi
	movq	%r12, %rdi
	call	sem_collect_labels
	movq	32(%r13), %rsi
	movq	%r12, %rdi
	call	sem_check_stmt
	movq	(%r12), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L377
.L321:
	movq	%rax, (%r12)
	jmp	.L315
	.p2align 4,,10
	.p2align 3
.L289:
	movq	8(%rax), %r13
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	movq	8(%r13), %rbx
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L304
	xorl	%r15d, %r15d
	jmp	.L306
	.p2align 4,,10
	.p2align 3
.L378:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L304
.L306:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L378
	movq	%rbx, %rsi
	leaq	.LC60(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	8(%r13), %rbx
.L304:
	movl	$56, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbx, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %rbp
	movl	$0, (%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 36(%rax)
	call	sdup@PLT
	movdqa	.LC59(%rip), %xmm5
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%r12), %rax
	movups	%xmm5, 16(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L294
	.p2align 4,,10
	.p2align 3
.L373:
	movq	8(%rax), %r14
	cmpl	$2, (%r14)
	je	.L295
	leaq	.LC58(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L295:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%r14)
	je	.L294
	.p2align 4
	.p2align 3
.L296:
	movq	16(%r14), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 32(%rsp)
	movq	(%rax), %rbx
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r13
	testq	%rbp, %rbp
	je	.L297
	xorl	%r15d, %r15d
	jmp	.L299
	.p2align 4,,10
	.p2align 3
.L379:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L297
.L299:
	movq	0(%r13,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L379
	movl	8(%r14), %edx
	movl	4(%r14), %esi
	movq	%rbx, %r8
	movl	$10, %ecx
	movq	8(%r12), %rdi
	call	error_at_location@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rbx
.L297:
	movq	4(%r14), %rdx
	movl	$56, %edi
	movq	%rdx, 40(%rsp)
	call	xmalloc@PLT
	pxor	%xmm2, %xmm2
	movq	%rbx, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %rbp
	movl	$0, (%rax)
	movups	%xmm2, 4(%rax)
	movups	%xmm2, 20(%rax)
	movups	%xmm2, 36(%rax)
	call	sdup@PLT
	movq	40(%rsp), %rdx
	movq	$0, 24(%rbp)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	32(%rsp), %rax
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
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%r14), %rax
	jb	.L296
	jmp	.L294
.L309:
	xorl	%r13d, %r13d
	cmpq	$0, 72(%r12)
	je	.L285
	.p2align 4
	.p2align 3
.L313:
	movq	64(%r12), %rax
	movq	(%rax,%r13,8), %rbp
	movq	16(%rsp), %rax
	movq	8(%rax), %r15
	testq	%r15, %r15
	je	.L322
	movq	(%rax), %r14
	xorl	%ebx, %ebx
	jmp	.L325
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L323:
	addq	$1, %rbx
	cmpq	%r15, %rbx
	je	.L322
.L325:
	movq	(%r14,%rbx,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L323
	movq	8(%rdx), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L323
	addq	$1, %r13
	cmpq	72(%r12), %r13
	jb	.L313
.L285:
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
.L322:
	.cfi_restore_state
	movl	$16, %edi
	addq	$1, %r13
	call	xmalloc@PLT
	movl	$56, %edi
	movl	$2, (%rax)
	movq	%rax, %r15
	call	xmalloc@PLT
	pxor	%xmm4, %xmm4
	movq	%rbp, %rdi
	movups	%xmm4, (%rax)
	movq	%rax, %rbx
	movq	$0, 48(%rax)
	movl	$1, 4(%rax)
	movups	%xmm4, 16(%rax)
	movups	%xmm4, 32(%rax)
	call	sdup@PLT
	movl	$0, 16(%rbx)
	movq	16(%rsp), %rdi
	movq	%r15, %rsi
	movq	%rax, 8(%rbx)
	movq	$0, 48(%rbx)
	movq	%rbx, 8(%r15)
	call	vec_push@PLT
	cmpq	72(%r12), %r13
	jb	.L313
	jmp	.L285
.L377:
	leaq	.LC56(%rip), %rdi
	call	dief@PLT
	movq	(%r12), %rax
	movq	(%rax), %rax
	jmp	.L321
	.cfi_endproc
.LFE36:
	.size	sem_check_program, .-sem_check_program
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC48:
	.long	0
	.long	0
	.long	0
	.long	1
	.align 16
.LC59:
	.long	0
	.long	0
	.long	1
	.long	0
	.section	.note.GNU-stack,"",@progbits
