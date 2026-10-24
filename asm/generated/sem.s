	.file	"sem.c"
	.text
	.p2align 4
	.type	has_data_declaration.isra.0, @function
has_data_declaration.isra.0:
.LFB42:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L5
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	jmp	.L4
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L3:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	je	.L13
.L4:
	movq	(%r12,%rbx,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L3
	movq	8(%rdx), %rax
	movq	%r13, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L3
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L13:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE42:
	.size	has_data_declaration.isra.0, .-has_data_declaration.isra.0
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
	.string	"free"
.LC5:
	.string	"abort"
.LC6:
	.string	"print"
.LC7:
	.string	"usleep"
.LC8:
	.string	"char"
.LC9:
	.string	"lchar"
.LC10:
	.string	"getchr"
.LC11:
	.string	"putchr"
.LC12:
	.string	"getstr"
.LC13:
	.string	"putstr"
.LC14:
	.string	"flush"
.LC15:
	.string	"reread"
.LC16:
	.string	"printf"
.LC17:
	.string	"printn"
.LC18:
	.string	"putnum"
.LC19:
	.string	"open"
.LC20:
	.string	"close"
.LC21:
	.string	"read"
.LC22:
	.string	"write"
.LC23:
	.string	"creat"
.LC24:
	.string	"seek"
.LC25:
	.string	"openr"
.LC26:
	.string	"openw"
.LC27:
	.string	"fork"
.LC28:
	.string	"wait"
.LC29:
	.string	"execl"
.LC30:
	.string	"execv"
.LC31:
	.string	"chdir"
.LC32:
	.string	"chmod"
.LC33:
	.string	"chown"
.LC34:
	.string	"link"
.LC35:
	.string	"unlink"
.LC36:
	.string	"stat"
.LC37:
	.string	"fstat"
.LC38:
	.string	"time"
.LC39:
	.string	"ctime"
.LC40:
	.string	"getuid"
.LC41:
	.string	"setuid"
.LC42:
	.string	"makdir"
.LC43:
	.string	"mkdir"
.LC44:
	.string	"intr"
.LC45:
	.string	"system"
.LC46:
	.string	"callf"
.LC47:
	.string	"gtty"
.LC48:
	.string	"stty"
.LC49:
	.string	"argc"
.LC50:
	.string	"argv"
	.data
	.align 32
.LC52:
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
	.quad	.LC46
	.quad	.LC47
	.quad	.LC48
	.quad	.LC49
	.quad	.LC50
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
	leaq	.LC52(%rip), %rsi
	movl	$52, %ecx
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
	subq	$424, %rsp
	.cfi_def_cfa_offset 480
	movq	%rsp, %rdi
	leaq	8(%rsp), %r13
	rep movsq
	.p2align 4
	.p2align 3
.L18:
	movq	(%r14), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r15
	testq	%r12, %r12
	je	.L15
	xorl	%ebx, %ebx
	jmp	.L17
	.p2align 4,,10
	.p2align 3
.L28:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L15
.L17:
	movq	(%r15,%rbx,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L28
	movq	0(%r13), %rbp
	addq	$8, %r13
	testq	%rbp, %rbp
	jne	.L18
.L29:
	addq	$424, %rsp
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
.L15:
	.cfi_restore_state
	movq	%rbp, %rdi
	addq	$8, %r13
	call	sdup@PLT
	leaq	40(%r14), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, %rdi
	movl	$1, (%rax)
	movq	%rax, %rbx
	movups	%xmm0, 36(%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 48(%rax)
	call	sdup@PLT
	movdqa	.LC53(%rip), %xmm1
	movq	%rbx, %rsi
	movq	%rax, 8(%rbx)
	movq	(%r14), %rax
	movups	%xmm1, 16(%rbx)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	-8(%r13), %rbp
	testq	%rbp, %rbp
	jne	.L18
	jmp	.L29
	.cfi_endproc
.LFE23:
	.size	sem_add_builtin_functions, .-sem_add_builtin_functions
	.section	.rodata.str1.1
.LC56:
	.string	"duplicate label '%s' at %d:%d"
	.text
	.p2align 4
	.type	sem_collect_labels, @function
sem_collect_labels:
.LFB36:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L59
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.L35(%rip), %r14
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
.L32:
	cmpl	$12, (%rbx)
	ja	.L30
	movl	(%rbx), %eax
	movslq	(%r14,%rax,4), %rax
	addq	%r14, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L35:
	.long	.L30-.L35
	.long	.L39-.L35
	.long	.L30-.L35
	.long	.L38-.L35
	.long	.L34-.L35
	.long	.L30-.L35
	.long	.L30-.L35
	.long	.L30-.L35
	.long	.L30-.L35
	.long	.L30-.L35
	.long	.L30-.L35
	.long	.L36-.L35
	.long	.L34-.L35
	.text
	.p2align 4,,10
	.p2align 3
.L39:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L30
.L40:
	movq	16(%rbx), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_collect_labels
	cmpq	24(%rbx), %rbp
	jb	.L40
.L30:
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
.L34:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L44:
	testq	%rbx, %rbx
	jne	.L32
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
.L36:
	.cfi_restore_state
	movq	(%r12), %rax
	movq	16(%rbx), %r13
	movq	8(%rax), %r15
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L41
	xorl	%ebp, %ebp
	jmp	.L43
	.p2align 4,,10
	.p2align 3
.L63:
	addq	$1, %rbp
	cmpq	%rbp, 8(%rsp)
	je	.L41
.L43:
	movq	(%r15,%rbp,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L63
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC56(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r13
.L41:
	movl	$64, %edi
	movq	4(%rbx), %r15
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r13, %rdi
	movl	$2, (%rax)
	movq	%rax, %rbp
	movups	%xmm0, 36(%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 48(%rax)
	call	sdup@PLT
	movq	%r15, 16(%rbp)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%r12), %rax
	movq	$0, 24(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	24(%rbx), %rbx
	jmp	.L44
	.p2align 4,,10
	.p2align 3
.L38:
	movq	24(%rbx), %rsi
	movq	%r12, %rdi
	call	sem_collect_labels
	movq	32(%rbx), %rbx
	jmp	.L44
	.p2align 4,,10
	.p2align 3
.L59:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE36:
	.size	sem_collect_labels, .-sem_collect_labels
	.p2align 4
	.type	mark_global_reference, @function
mark_global_reference:
.LFB31:
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
	testq	%rdx, %rdx
	je	.L65
	movq	32(%rdx), %rax
	movl	(%rdx), %r10d
	movq	%rax, 32(%rsi)
	testl	%r10d, %r10d
	jne	.L105
	movl	24(%rdx), %edi
	testl	%edi, %edi
	je	.L76
	movl	$1, 20(%rsi)
	movq	48(%rsi), %rbp
.L77:
	movq	96(%r12), %r13
	movq	88(%r12), %r14
	testq	%r13, %r13
	je	.L84
	xorl	%ebx, %ebx
	jmp	.L85
	.p2align 4,,10
	.p2align 3
.L106:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L84
.L85:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L106
.L64:
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
.L105:
	.cfi_restore_state
	movl	20(%rsi), %r9d
	testl	%r9d, %r9d
	je	.L64
	movl	24(%rdx), %edx
	movq	48(%rsi), %rbp
	testl	%edx, %edx
	jne	.L77
	movq	24(%rdi), %r13
	movq	16(%rdi), %r14
.L82:
	testq	%r13, %r13
	je	.L64
.L73:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L83:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L77
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L83
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
.L76:
	.cfi_restore_state
	movl	20(%rsi), %ecx
	testl	%ecx, %ecx
	je	.L64
	movq	48(%rsi), %rbp
	movq	24(%r12), %r13
	movq	16(%r12), %r14
	jmp	.L82
	.p2align 4,,10
	.p2align 3
.L65:
	movq	48(%rsi), %rbp
	movq	16(%rdi), %r14
	movq	$0, 32(%rsi)
	movq	24(%rdi), %r13
	testq	%r13, %r13
	je	.L69
	xorl	%r15d, %r15d
	jmp	.L71
	.p2align 4,,10
	.p2align 3
.L108:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L107
.L71:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L108
	movq	48(%r12), %rax
	movq	40(%r12), %rcx
	xorl	%r15d, %r15d
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L74
	jmp	.L75
	.p2align 4,,10
	.p2align 3
.L109:
	addq	$1, %r15
	cmpq	%r15, 8(%rsp)
	movq	(%rsp), %rcx
	je	.L75
.L74:
	movq	(%rcx,%r15,8), %rdi
	movq	%rbp, %rsi
	movq	%rcx, (%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L109
.L78:
	movl	20(%rbx), %eax
	testl	%eax, %eax
	jne	.L73
	jmp	.L64
	.p2align 4,,10
	.p2align 3
.L84:
	movq	%rbp, %rdi
	call	sdup@PLT
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	88(%r12), %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	movq	%rax, %rsi
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
	jmp	vec_push@PLT
	.p2align 4,,10
	.p2align 3
.L107:
	.cfi_restore_state
	movl	g_strict(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L78
	movl	$1, 20(%rbx)
	jmp	.L73
.L75:
	movq	112(%r12), %rax
	movq	%rbp, %rdx
	movq	8(%rax), %rsi
	movq	(%rax), %rdi
	call	has_data_declaration.isra.0
	movl	%eax, %edx
	movl	$2, %eax
	subl	%edx, %eax
	movl	%eax, 20(%rbx)
	jmp	.L73
.L69:
	movl	g_strict(%rip), %esi
	testl	%esi, %esi
	jne	.L64
	movl	$1, 20(%rbx)
	jmp	.L64
	.cfi_endproc
.LFE31:
	.size	mark_global_reference, .-mark_global_reference
	.p2align 4
	.type	scope_find_value, @function
scope_find_value:
.LFB32:
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
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	(%rdi), %r12
	movl	g_strict(%rip), %eax
	movq	%rdi, 24(%rsp)
	movl	%eax, 16(%rsp)
	movq	%r12, 8(%rsp)
	testq	%r12, %r12
	je	.L157
.L111:
	movq	8(%rsp), %rax
	movq	16(%rax), %r13
	testq	%r13, %r13
	je	.L116
	movq	8(%rsp), %rax
	xorl	%r15d, %r15d
	movq	8(%rax), %r14
	jmp	.L114
	.p2align 4,,10
	.p2align 3
.L158:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L116
.L114:
	movq	(%r14,%r15,8), %rbx
	movq	%rbp, %rsi
	movq	8(%rbx), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L158
.L113:
	movl	16(%rsp), %eax
	testl	%eax, %eax
	je	.L129
	movq	24(%rsp), %rax
	movq	120(%rax), %rax
	movq	%rax, 16(%rsp)
	testq	%rax, %rax
	je	.L129
.L119:
	movq	(%r12), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L130
	movq	16(%r12), %r13
	testq	%r13, %r13
	je	.L122
	movq	8(%r12), %r14
	xorl	%r15d, %r15d
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L159:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L122
.L120:
	movq	(%r14,%r15,8), %r12
	movq	%rbp, %rsi
	movq	8(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L159
.L110:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
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
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L111
	xorl	%ebx, %ebx
	jmp	.L113
	.p2align 4,,10
	.p2align 3
.L122:
	movq	8(%rsp), %r12
	jmp	.L119
	.p2align 4,,10
	.p2align 3
.L129:
	movq	%rbx, %r12
	jmp	.L110
.L157:
	movl	16(%rsp), %edx
	testl	%edx, %edx
	je	.L110
	movq	24(%rsp), %rax
	movq	120(%rax), %rax
	movq	%rax, 16(%rsp)
	testq	%rax, %rax
	je	.L110
.L118:
	movq	24(%rsp), %rax
	movq	24(%rax), %r13
	movq	16(%rax), %r14
	testq	%r13, %r13
	je	.L123
	xorl	%ebx, %ebx
	jmp	.L124
	.p2align 4,,10
	.p2align 3
.L160:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L123
.L124:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L160
	jmp	.L110
.L123:
	movq	16(%rsp), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$0, %eax
	cmovne	%rax, %r12
	jmp	.L110
.L130:
	movq	%rbx, %r12
	jmp	.L118
	.cfi_endproc
.LFE32:
	.size	scope_find_value, .-scope_find_value
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC57:
	.string	"undefined internal name '%s' at %d:%d"
	.align 8
.LC58:
	.string	"'%s' is not a variable at %d:%d"
	.section	.rodata.str1.1
.LC59:
	.string	"invalid lvalue at %d:%d"
	.text
	.p2align 4
	.type	sem_check_lvalue, @function
sem_check_lvalue:
.LFB33:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L210
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
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movl	(%rsi), %eax
	cmpl	$4, %eax
	je	.L164
	cmpl	$5, %eax
	je	.L165
	cmpl	$2, %eax
	jne	.L166
	movq	48(%rsi), %rsi
	call	scope_find_value
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	movq	%rax, %r12
	movq	%rax, %rdx
	call	mark_global_reference
	testq	%r12, %r12
	je	.L214
	movl	28(%r12), %eax
	testl	%eax, %eax
	je	.L177
	movq	8(%r12), %rbp
	leaq	.LC50(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L215
	movl	(%r12), %eax
	cmpl	$1, %eax
	jne	.L180
	movq	%rbp, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	jne	.L179
	movl	(%r12), %eax
	.p2align 4
	.p2align 3
.L180:
	andl	$-3, %eax
	jne	.L216
.L161:
	addq	$8, %rsp
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
.L165:
	.cfi_restore_state
	cmpl	$32, 48(%rsi)
	je	.L213
.L166:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	leaq	.LC59(%rip), %rdi
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
	jmp	dief@PLT
	.p2align 4,,10
	.p2align 3
.L164:
	.cfi_restore_state
	movq	48(%rsi), %rsi
	call	sem_check_expr
.L213:
	movq	56(%rbx), %rsi
	addq	$8, %rsp
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
	jmp	sem_check_expr
	.p2align 4,,10
	.p2align 3
.L214:
	.cfi_restore_state
	movl	g_strict(%rip), %edx
	movq	48(%rbx), %r12
	movq	16(%rbp), %r14
	movq	24(%rbp), %r13
	testl	%edx, %edx
	jne	.L217
.L168:
	testq	%r13, %r13
	je	.L172
.L170:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L174:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L161
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L174
.L172:
	movq	72(%rbp), %r13
	movq	64(%rbp), %r14
	testq	%r13, %r13
	je	.L175
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L176:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L161
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L176
.L175:
	movq	%r12, %rdi
	call	sdup@PLT
	addq	$8, %rsp
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
	.p2align 4,,10
	.p2align 3
.L177:
	.cfi_restore_state
	movl	(%r12), %eax
	cmpl	$1, %eax
	jne	.L180
.L179:
	movl	$1, 12(%rbx)
	jmp	.L161
	.p2align 4,,10
	.p2align 3
.L210:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.p2align 4,,10
	.p2align 3
.L215:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	$1, 16(%rbx)
	jmp	.L161
	.p2align 4,,10
	.p2align 3
.L217:
	testq	%r13, %r13
	je	.L169
	xorl	%r15d, %r15d
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L218:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L169
.L171:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L218
	jmp	.L170
	.p2align 4,,10
	.p2align 3
.L216:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	leaq	.LC58(%rip), %rdi
	xorl	%eax, %eax
	movq	48(%rbx), %rsi
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
	jmp	dief@PLT
	.p2align 4,,10
	.p2align 3
.L169:
	.cfi_restore_state
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r12, %rsi
	leaq	.LC57(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	48(%rbx), %r12
	movq	16(%rbp), %r14
	movq	24(%rbp), %r13
	jmp	.L168
	.cfi_endproc
.LFE33:
	.size	sem_check_lvalue, .-sem_check_lvalue
	.section	.rodata.str1.1
.LC60:
	.string	"'%s' is not callable at %d:%d"
	.text
	.p2align 4
	.type	sem_check_expr, @function
sem_check_expr:
.LFB34:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L294
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
	leaq	.L224(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
.L220:
	cmpl	$10, (%rbx)
	ja	.L219
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L224:
	.long	.L219-.L224
	.long	.L219-.L224
	.long	.L232-.L224
	.long	.L231-.L224
	.long	.L223-.L224
	.long	.L229-.L224
	.long	.L228-.L224
	.long	.L292-.L224
	.long	.L226-.L224
	.long	.L225-.L224
	.long	.L223-.L224
	.text
	.p2align 4,,10
	.p2align 3
.L231:
	movq	48(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L295
	movl	$1, 24(%rbx)
	movq	%rbp, %rdi
	call	sem_check_expr
.L249:
	xorl	%r12d, %r12d
	cmpq	$0, 64(%rbx)
	je	.L219
.L250:
	movq	56(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	64(%rbx), %r12
	jb	.L250
.L219:
	addq	$8, %rsp
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
.L223:
	.cfi_restore_state
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	56(%rbx), %rbx
.L251:
	testq	%rbx, %rbx
	jne	.L220
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L225:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
.L292:
	movq	56(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	64(%rbx), %rbx
	jmp	.L251
	.p2align 4,,10
	.p2align 3
.L226:
	movq	56(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_lvalue
	movq	64(%rbx), %rbx
	jmp	.L251
	.p2align 4,,10
	.p2align 3
.L228:
	movq	56(%rbx), %rsi
.L293:
	addq	$8, %rsp
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
.L229:
	.cfi_restore_state
	movl	48(%rbx), %eax
	movq	56(%rbx), %rbx
	leal	-36(%rax), %edx
	cmpl	$1, %edx
	jbe	.L254
	cmpl	$53, %eax
	jne	.L251
.L254:
	movq	%rbx, %rsi
	jmp	.L293
	.p2align 4,,10
	.p2align 3
.L232:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	scope_find_value
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	movq	%rax, %r12
	movq	%rax, %rdx
	call	mark_global_reference
	testq	%r12, %r12
	je	.L233
	movl	28(%r12), %eax
	testl	%eax, %eax
	je	.L234
	movq	8(%r12), %rdi
	leaq	.LC50(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
.L234:
	cmpl	$1, (%r12)
	movl	%eax, 16(%rbx)
	je	.L237
	movl	$0, 12(%rbx)
	addq	$8, %rsp
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
.L295:
	.cfi_restore_state
	movq	48(%rsi), %r13
	movq	%rbp, %rdi
	movq	%r13, %rsi
	call	scope_find_value
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L296
	movl	(%rax), %eax
	cmpl	$1, %eax
	ja	.L297
.L247:
	testl	%eax, %eax
	jne	.L246
	movl	$1, 24(%rbx)
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L237:
	xorl	$1, %eax
	movl	%eax, 12(%rbx)
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L233:
	movq	24(%rbp), %r14
	movq	48(%rbx), %r13
	movq	$0, 12(%rbx)
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L235
	xorl	%r12d, %r12d
	jmp	.L236
	.p2align 4,,10
	.p2align 3
.L298:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L235
.L236:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L298
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L246:
	movl	$0, 24(%rbx)
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L297:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	xorl	%eax, %eax
	movq	%r13, %rsi
	leaq	.LC60(%rip), %rdi
	call	dief@PLT
	movl	(%r12), %eax
	jmp	.L247
	.p2align 4,,10
	.p2align 3
.L294:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L296:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	24(%rbp), %r14
	movq	16(%rbp), %r15
	testq	%r14, %r14
	jne	.L245
	jmp	.L243
	.p2align 4,,10
	.p2align 3
.L299:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L243
.L245:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L299
.L244:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	scope_find_value
	testq	%rax, %rax
	je	.L246
	movl	(%rax), %eax
	jmp	.L247
.L235:
	movq	72(%rbp), %r14
	movq	64(%rbp), %r15
	testq	%r14, %r14
	je	.L238
	xorl	%r12d, %r12d
	jmp	.L239
	.p2align 4,,10
	.p2align 3
.L300:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L238
.L239:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L300
	jmp	.L219
.L238:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L301
.L240:
	movq	%r13, %rdi
	call	sdup@PLT
	addq	$8, %rsp
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
.L243:
	.cfi_restore_state
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L244
.L301:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC57(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	48(%rbx), %r13
	jmp	.L240
	.cfi_endproc
.LFE34:
	.size	sem_check_expr, .-sem_check_expr
	.p2align 4
	.type	sem_check_initializer, @function
sem_check_initializer:
.LFB40:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L333
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
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	(%rsi), %eax
	cmpl	$1, %eax
	je	.L336
	testl	%eax, %eax
	jne	.L302
	movq	16(%rsi), %r14
	cmpl	$2, (%r14)
	je	.L337
.L308:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rsi
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
	jmp	sem_check_expr
	.p2align 4,,10
	.p2align 3
.L336:
	.cfi_restore_state
	cmpq	$0, 24(%rsi)
	je	.L302
	xorl	%r12d, %r12d
.L307:
	movq	16(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_initializer
	cmpq	24(%rbx), %r12
	jb	.L307
.L302:
	addq	$24, %rsp
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
.L333:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.p2align 4,,10
	.p2align 3
.L337:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	(%rdi), %rax
	movq	48(%r14), %r13
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L310
.L309:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L313
	movq	8(%rsp), %rax
	xorl	%ebx, %ebx
	movq	8(%rax), %r15
	.p2align 4
	.p2align 3
.L311:
	movq	(%r15,%rbx,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L308
	addq	$1, %rbx
	cmpq	%r12, %rbx
	jne	.L311
.L313:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L309
.L310:
	movq	24(%rbp), %r12
	movq	16(%rbp), %r15
	testq	%r12, %r12
	je	.L314
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L315:
	movq	(%r15,%rbx,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L308
	addq	$1, %rbx
	cmpq	%rbx, %r12
	jne	.L315
.L314:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L308
	.cfi_endproc
.LFE40:
	.size	sem_check_initializer, .-sem_check_initializer
	.section	.rodata.str1.8
	.align 8
.LC61:
	.string	"internal: cannot pop global scope"
	.align 8
.LC62:
	.string	"bcc: warning: case label falls through to another case label at %d:%d\n"
	.align 8
.LC63:
	.string	"external declaration conflicts with local name '%s'"
	.text
	.p2align 4
	.type	sem_check_stmt, @function
sem_check_stmt:
.LFB35:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L433
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
	leaq	.L343(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
.L340:
	cmpl	$12, (%rbx)
	ja	.L338
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L343:
	.long	.L338-.L343
	.long	.L352-.L343
	.long	.L351-.L343
	.long	.L350-.L343
	.long	.L349-.L343
	.long	.L348-.L343
	.long	.L345-.L343
	.long	.L346-.L343
	.long	.L338-.L343
	.long	.L338-.L343
	.long	.L345-.L343
	.long	.L436-.L343
	.long	.L342-.L343
	.text
	.p2align 4,,10
	.p2align 3
.L351:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L338
	.p2align 4
	.p2align 3
.L354:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbp
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L361
	xorl	%r15d, %r15d
	jmp	.L363
	.p2align 4,,10
	.p2align 3
.L438:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L361
.L363:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L438
.L362:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	movq	%rbp, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rbp
.L364:
	movq	4(%rbx), %rdx
	movl	$64, %edi
	movq	%rdx, 24(%rsp)
	call	xmalloc@PLT
	pxor	%xmm1, %xmm1
	movq	%rbp, %rdi
	movl	$0, (%rax)
	movq	%rax, %r12
	movups	%xmm1, 36(%rax)
	movups	%xmm1, 4(%rax)
	movups	%xmm1, 20(%rax)
	movups	%xmm1, 48(%rax)
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
	movq	%rax, 48(%r12)
	movq	0(%r13), %rax
	setne	%dl
	movl	%edx, 40(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	8(%r14), %rsi
	testq	%rsi, %rsi
	je	.L366
	movq	%r13, %rdi
	call	sem_check_expr
.L366:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L354
.L338:
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
.L345:
	.cfi_restore_state
	movq	16(%rbx), %rsi
.L437:
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
.L436:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L367:
	testq	%rbx, %rbx
	jne	.L340
	jmp	.L338
	.p2align 4,,10
	.p2align 3
.L346:
	leaq	16(%r13), %rax
	cmpq	$0, 24(%rbx)
	movq	$0, 8(%rsp)
	movq	%rax, 16(%rsp)
	je	.L338
	.p2align 4
	.p2align 3
.L353:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rbp
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L439
.L368:
	movq	24(%r13), %r12
	movq	16(%r13), %r14
	testq	%r12, %r12
	je	.L371
	xorl	%r15d, %r15d
	jmp	.L373
	.p2align 4,,10
	.p2align 3
.L440:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L371
.L373:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L440
.L372:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L353
	jmp	.L338
	.p2align 4,,10
	.p2align 3
.L350:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%rbx), %rbx
	jmp	.L367
	.p2align 4,,10
	.p2align 3
.L349:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rbx
	jmp	.L367
	.p2align 4,,10
	.p2align 3
.L348:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L437
	jmp	.L338
	.p2align 4,,10
	.p2align 3
.L342:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %r14
	testq	%r14, %r14
	je	.L338
	cmpl	$1, (%r14)
	jne	.L382
	cmpq	$0, 24(%r14)
	je	.L382
	xorl	%ecx, %ecx
	xorl	%r12d, %r12d
	leaq	.LC62(%rip), %r15
	jmp	.L378
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L375:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	andl	%eax, %ecx
.L377:
	addq	$1, %r12
	cmpq	24(%r14), %r12
	jnb	.L436
.L378:
	movq	16(%r14), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	cmpl	$13, %eax
	jne	.L375
	testl	%ecx, %ecx
	jne	.L441
.L376:
	movl	$1, %ecx
	jmp	.L377
	.p2align 4,,10
	.p2align 3
.L352:
	movl	g_strict(%rip), %esi
	testl	%esi, %esi
	je	.L442
	cmpq	$0, 24(%rbx)
	je	.L338
.L356:
	xorl	%ebp, %ebp
.L358:
	movq	16(%rbx), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_check_stmt
	cmpq	24(%rbx), %rbp
	jb	.L358
.L359:
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L338
	movq	0(%r13), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L443
.L360:
	movq	%rax, 0(%r13)
	jmp	.L338
.L382:
	movq	%r14, %rbx
	jmp	.L340
	.p2align 4,,10
	.p2align 3
.L361:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	je	.L364
	movq	24(%r13), %r14
	movq	16(%r13), %r15
	testq	%r14, %r14
	je	.L364
	xorl	%r12d, %r12d
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L444:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L364
.L365:
	movq	(%r15,%r12,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L444
	jmp	.L362
	.p2align 4,,10
	.p2align 3
.L371:
	movq	%rbp, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L372
	.p2align 4,,10
	.p2align 3
.L439:
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r15
	testq	%r12, %r12
	je	.L368
	xorl	%r14d, %r14d
	jmp	.L370
	.p2align 4,,10
	.p2align 3
.L445:
	addq	$1, %r14
	cmpq	%r14, %r12
	je	.L368
.L370:
	movq	(%r15,%r14,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L445
	movq	%rbp, %rsi
	leaq	.LC63(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L368
.L441:
	movl	8(%rdx), %ecx
	movq	stderr(%rip), %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	movl	4(%rdx), %edx
	call	fprintf@PLT
	jmp	.L376
.L442:
	movl	$32, %edi
	movq	0(%r13), %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 16(%rax)
	cmpq	$0, 24(%rbx)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, 0(%r13)
	jne	.L356
	jmp	.L359
.L433:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L443:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	leaq	.LC61(%rip), %rdi
	call	dief@PLT
	movq	0(%r13), %rax
	movq	(%rax), %rax
	jmp	.L360
	.cfi_endproc
.LFE35:
	.size	sem_check_stmt, .-sem_check_stmt
	.section	.rodata.str1.8
	.align 8
.LC64:
	.string	"internal: TOP_GAUTO should be ST_AUTO"
	.align 8
.LC65:
	.string	"vector bound must be a constant expression in '%s'"
	.section	.rodata.str1.1
.LC66:
	.string	"negative vector bound in '%s'"
	.section	.rodata.str1.8
	.align 8
.LC68:
	.string	"duplicate extern definition '%s'"
	.text
	.p2align 4
	.globl	sem_check_program
	.type	sem_check_program, @function
sem_check_program:
.LFB41:
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
	movq	%rdi, %r13
	movl	$128, %edi
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	call	xmalloc@PLT
	movl	$32, %edi
	movq	%rbp, 8(%rax)
	movq	%rax, %rbx
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	$0, 24(%rsp)
	movups	%xmm0, (%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 24(%rbx)
	movups	%xmm0, 48(%rbx)
	movups	%xmm0, 72(%rbx)
	pxor	%xmm0, %xmm0
	movq	$0, 104(%rbx)
	movups	%xmm0, 88(%rbx)
	cmpq	$0, 8(%r13)
	movq	%rax, (%rbx)
	movq	$0, 16(%rbx)
	movq	$0, 40(%rbx)
	movq	$0, 64(%rbx)
	movq	$0, 120(%rbx)
	movq	%r13, 112(%rbx)
	je	.L471
	.p2align 4
	.p2align 3
.L447:
	movq	0(%r13), %rax
	movq	24(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L450
	ja	.L451
	testl	%edx, %edx
	je	.L576
	movq	8(%rax), %r14
	movq	(%r14), %rdi
	movq	%r14, 8(%rsp)
	call	sdup@PLT
	leaq	40(%rbx), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	(%rbx), %rax
	movq	(%r14), %rbp
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L462
	xorl	%r15d, %r15d
	jmp	.L464
	.p2align 4,,10
	.p2align 3
.L577:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L462
.L464:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L577
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rbp
.L462:
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, %rdi
	movl	$1, (%rax)
	movq	%rax, %r12
	movups	%xmm0, 36(%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 48(%rax)
	call	sdup@PLT
	pxor	%xmm0, %xmm0
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	8(%rsp), %rax
	movups	%xmm0, 16(%r12)
	movdqu	8(%rax), %xmm0
	movq	24(%rax), %rax
	movq	%rax, 56(%r12)
	movq	(%rbx), %rax
	movups	%xmm0, 40(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
.L455:
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8(%r13), %rax
	jb	.L447
.L471:
	cmpq	$0, 8+g_known_functions(%rip)
	movq	$0, 8(%rsp)
	je	.L449
	.p2align 4
	.p2align 3
.L448:
	leaq	g_known_functions(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L474
	xorl	%r15d, %r15d
	jmp	.L476
	.p2align 4,,10
	.p2align 3
.L578:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L474
.L476:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L578
.L475:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L448
.L449:
	cmpq	$0, 8+g_known_variables(%rip)
	movq	$0, 8(%rsp)
	je	.L473
	.p2align 4
	.p2align 3
.L472:
	leaq	g_known_variables(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %r12
	movq	(%rbx), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L479
	xorl	%r15d, %r15d
	jmp	.L481
	.p2align 4,,10
	.p2align 3
.L579:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L479
.L481:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L579
.L480:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_variables(%rip), %rax
	jb	.L472
.L473:
	movq	%rbx, %rdi
	call	sem_add_builtin_functions
	cmpq	$0, 8(%r13)
	movq	$0, 16(%rsp)
	jne	.L477
	jmp	.L478
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L484:
	addq	$1, 16(%rsp)
	movq	8(%r13), %rax
	movq	16(%rsp), %rcx
	cmpq	%rax, %rcx
	jnb	.L580
.L477:
	movq	0(%r13), %rax
	movq	16(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L484
	movq	8(%rax), %rax
	movdqu	24(%rbx), %xmm7
	movl	g_strict(%rip), %edx
	movq	%rax, 24(%rsp)
	movq	16(%rbx), %rax
	movaps	%xmm7, 48(%rsp)
	movq	%rax, 40(%rsp)
	movq	120(%rbx), %rax
	movq	%rax, 32(%rsp)
	testl	%edx, %edx
	jne	.L581
.L485:
	movq	24(%rsp), %r14
	movl	$32, %edi
	movq	(%rbx), %rbp
	movq	(%r14), %rax
	movq	%rax, 120(%rbx)
	call	xmalloc@PLT
	pxor	%xmm7, %xmm7
	movups	%xmm7, 16(%rax)
	cmpq	$0, 16(%r14)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, (%rbx)
	je	.L486
	movq	$0, 8(%rsp)
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L490:
	movq	24(%rsp), %rcx
	movq	8(%rax), %r14
	movq	8(%rcx), %rdx
	movq	8(%rsp), %rcx
	movq	(%rdx,%rcx,8), %rbp
	testq	%r12, %r12
	je	.L487
	xorl	%r15d, %r15d
	jmp	.L489
	.p2align 4,,10
	.p2align 3
.L582:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L487
.L489:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L582
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
.L487:
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm1, %xmm1
	movq	%rbp, %rdi
	movl	$0, (%rax)
	movq	%rax, %r12
	movups	%xmm1, 36(%rax)
	movups	%xmm1, 4(%rax)
	movups	%xmm1, 20(%rax)
	movups	%xmm1, 48(%rax)
	call	sdup@PLT
	addq	$1, 8(%rsp)
	movq	8(%rsp), %r14
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	(%rbx), %rax
	pxor	%xmm0, %xmm0
	movq	%r14, 32(%r12)
	leaq	8(%rax), %rdi
	movups	%xmm0, 16(%r12)
	call	vec_push@PLT
	movq	24(%rsp), %rax
	cmpq	16(%rax), %r14
	jnb	.L486
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	jmp	.L490
	.p2align 4,,10
	.p2align 3
.L474:
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm3, %xmm3
	movq	%rbp, %rdi
	movl	$1, (%rax)
	movq	%rax, %r12
	movups	%xmm3, 36(%rax)
	movups	%xmm3, 4(%rax)
	movups	%xmm3, 20(%rax)
	movups	%xmm3, 48(%rax)
	call	sdup@PLT
	pxor	%xmm0, %xmm0
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	(%rbx), %rax
	movups	%xmm0, 16(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	%rbp, %rdi
	call	sdup@PLT
	leaq	40(%rbx), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L475
	.p2align 4,,10
	.p2align 3
.L479:
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r12, %rdi
	movl	$0, (%rax)
	movq	%rax, %rbp
	movups	%xmm0, 36(%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 48(%rax)
	call	sdup@PLT
	movdqa	.LC67(%rip), %xmm6
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%rbx), %rax
	movups	%xmm6, 16(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L480
	.p2align 4,,10
	.p2align 3
.L451:
	cmpl	$3, %edx
	jne	.L455
	movq	8(%rax), %rax
	movq	16(%rax), %rdi
	call	sdup@PLT
	leaq	16(%rbx), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L455
	.p2align 4,,10
	.p2align 3
.L486:
	movq	24(%rsp), %r14
	movq	%rbx, %rdi
	movq	32(%r14), %rsi
	call	sem_collect_labels
	movq	32(%r14), %rsi
	movq	%rbx, %rdi
	call	sem_check_stmt
	movq	(%rbx), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L583
.L491:
	movq	%rax, (%rbx)
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L492
	movq	40(%rsp), %rax
	movdqa	48(%rsp), %xmm6
	movq	%rax, 16(%rbx)
	movups	%xmm6, 24(%rbx)
.L492:
	movq	32(%rsp), %rax
	movq	%rax, 120(%rbx)
	jmp	.L484
	.p2align 4,,10
	.p2align 3
.L450:
	movq	8(%rax), %rax
	cmpl	$2, 24(%rax)
	movq	%rax, 8(%rsp)
	je	.L584
.L465:
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L468
	xorl	%r15d, %r15d
	jmp	.L470
	.p2align 4,,10
	.p2align 3
.L585:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L468
.L470:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L585
	movq	%rbp, %rsi
	xorl	%eax, %eax
	leaq	.LC68(%rip), %rdi
	call	dief@PLT
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
.L468:
	movl	$64, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, %rdi
	movl	$0, (%rax)
	movq	%rax, %r12
	movups	%xmm0, 36(%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 48(%rax)
	call	sdup@PLT
	movdqa	.LC67(%rip), %xmm7
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	(%rbx), %rax
	movups	%xmm7, 16(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L455
	.p2align 4,,10
	.p2align 3
.L576:
	movq	8(%rax), %rax
	cmpl	$2, (%rax)
	movq	%rax, 16(%rsp)
	je	.L456
	leaq	.LC64(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L456:
	movq	$0, 8(%rsp)
	movq	16(%rsp), %rax
	cmpq	$0, 24(%rax)
	je	.L455
	.p2align 4
	.p2align 3
.L457:
	movq	16(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	16(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 32(%rsp)
	movq	(%rax), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L458
	xorl	%r15d, %r15d
	jmp	.L460
	.p2align 4,,10
	.p2align 3
.L586:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L458
.L460:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L586
	movq	16(%rsp), %rax
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	movl	8(%rax), %edx
	movl	4(%rax), %esi
	call	error_at_location@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rbp
.L458:
	movq	16(%rsp), %r14
	movl	$64, %edi
	movq	4(%r14), %rdx
	movq	%rdx, 40(%rsp)
	call	xmalloc@PLT
	pxor	%xmm2, %xmm2
	movq	%rbp, %rdi
	movl	$0, (%rax)
	movq	%rax, %r12
	movups	%xmm2, 36(%rax)
	movups	%xmm2, 4(%rax)
	movups	%xmm2, 20(%rax)
	movups	%xmm2, 48(%rax)
	call	sdup@PLT
	movq	40(%rsp), %rdx
	movq	%r12, %rsi
	movq	$0, 24(%r12)
	movq	%rax, 8(%r12)
	movq	32(%rsp), %rax
	movq	%rdx, 16(%r12)
	xorl	%edx, %edx
	movq	8(%rax), %rax
	testq	%rax, %rax
	movq	%rax, 48(%r12)
	movq	(%rbx), %rax
	setne	%dl
	movl	%edx, 40(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%r14), %rax
	jb	.L457
	jmp	.L455
.L478:
	movq	$0, 8(%rsp)
	cmpq	$0, 72(%rbx)
	je	.L483
	.p2align 4
	.p2align 3
.L482:
	movq	64(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %r15
	movq	(%rax,%rcx,8), %r12
	testq	%r15, %r15
	je	.L497
	movq	0(%r13), %r14
	xorl	%ebp, %ebp
	jmp	.L500
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L498:
	addq	$1, %rbp
	cmpq	%r15, %rbp
	je	.L497
.L500:
	movq	(%r14,%rbp,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L498
	movq	8(%rdx), %rax
	movq	%r12, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L498
.L499:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	72(%rbx), %rax
	jb	.L482
.L483:
	movq	$0, 8(%rsp)
	cmpq	$0, 96(%rbx)
	je	.L446
	.p2align 4
	.p2align 3
.L495:
	movq	88(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %rsi
	movq	0(%r13), %rdi
	movq	(%rax,%rcx,8), %rbp
	movq	%rbp, %rdx
	call	has_data_declaration.isra.0
	testl	%eax, %eax
	jne	.L501
	movl	$16, %edi
	call	xmalloc@PLT
	movl	$64, %edi
	movq	%rax, 16(%rsp)
	call	xmalloc@PLT
	pxor	%xmm4, %xmm4
	movq	%rbp, %rdi
	movups	%xmm4, (%rax)
	movq	%rax, %r14
	movups	%xmm4, 16(%rax)
	movups	%xmm4, 32(%rax)
	movups	%xmm4, 48(%rax)
	movq	%rax, 24(%rsp)
	call	sdup@PLT
	movq	8+g_known_variables(%rip), %r12
	movq	%rax, 16(%r14)
	movq	g_known_variables(%rip), %r14
	testq	%r12, %r12
	je	.L511
	xorl	%r15d, %r15d
	jmp	.L503
	.p2align 4,,10
	.p2align 3
.L587:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L511
.L503:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L587
.L502:
	movq	24(%rsp), %rcx
	movq	%r13, %rdi
	movl	%eax, 8(%rcx)
	movq	16(%rsp), %rax
	movl	$3, (%rax)
	movq	%rax, %rsi
	movq	%rcx, 8(%rax)
	call	vec_push@PLT
.L501:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	96(%rbx), %rax
	jb	.L495
.L446:
	addq	$88, %rsp
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
.L497:
	.cfi_restore_state
	movl	$16, %edi
	call	xmalloc@PLT
	movl	$64, %edi
	movl	$2, (%rax)
	movq	%rax, %r15
	call	xmalloc@PLT
	pxor	%xmm5, %xmm5
	movq	%r12, %rdi
	movups	%xmm5, (%rax)
	movq	%rax, %rbp
	movl	$1, 4(%rax)
	movups	%xmm5, 16(%rax)
	movups	%xmm5, 32(%rax)
	movups	%xmm5, 48(%rax)
	call	sdup@PLT
	movl	$0, 24(%rbp)
	movq	%r15, %rsi
	movq	%r13, %rdi
	movq	%rax, 16(%rbp)
	movq	$0, 56(%rbp)
	movq	%rbp, 8(%r15)
	call	vec_push@PLT
	jmp	.L499
	.p2align 4,,10
	.p2align 3
.L511:
	movl	$1, %eax
	jmp	.L502
.L580:
	testq	%rax, %rax
	je	.L478
	xorl	%ebp, %ebp
	jmp	.L494
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L493:
	addq	$1, %rbp
	cmpq	8(%r13), %rbp
	jnb	.L478
.L494:
	movq	0(%r13), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L493
	movq	8(%rax), %rax
	movq	%rbx, %rdi
	movq	56(%rax), %rsi
	call	sem_check_initializer
	jmp	.L493
.L584:
	movq	32(%rax), %rdi
	testq	%rdi, %rdi
	je	.L465
	leaq	72(%rsp), %rsi
	call	try_eval_const_expr@PLT
	testl	%eax, %eax
	je	.L588
.L466:
	movq	72(%rsp), %rax
	testq	%rax, %rax
	js	.L589
.L467:
	movq	8(%rsp), %rcx
	movq	%rax, 48(%rcx)
	jmp	.L465
.L581:
	pxor	%xmm0, %xmm0
	movq	$0, 32(%rbx)
	movups	%xmm0, 16(%rbx)
	jmp	.L485
.L583:
	leaq	.LC61(%rip), %rdi
	call	dief@PLT
	movq	(%rbx), %rax
	movq	(%rax), %rax
	jmp	.L491
.L588:
	movq	8(%rsp), %rax
	leaq	.LC65(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L466
.L589:
	movq	8(%rsp), %rax
	leaq	.LC66(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	movq	72(%rsp), %rax
	jmp	.L467
	.cfi_endproc
.LFE41:
	.size	sem_check_program, .-sem_check_program
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC53:
	.long	0
	.long	0
	.long	0
	.long	1
	.align 16
.LC67:
	.long	0
	.long	0
	.long	1
	.long	0
	.section	.note.GNU-stack,"",@progbits
