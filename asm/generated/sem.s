	.file	"sem.c"
	.text
	.p2align 4
	.type	has_data_declaration.isra.0, @function
has_data_declaration.isra.0:
.LFB41:
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
.LFE41:
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
	je	.L60
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leaq	.L35(%rip), %r13
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
	cmpl	$13, (%rbx)
	ja	.L30
	movl	(%rbx), %eax
	movslq	0(%r13,%rax,4), %rax
	addq	%r13, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L35:
	.long	.L30-.L35
	.long	.L40-.L35
	.long	.L30-.L35
	.long	.L39-.L35
	.long	.L36-.L35
	.long	.L30-.L35
	.long	.L30-.L35
	.long	.L30-.L35
	.long	.L30-.L35
	.long	.L30-.L35
	.long	.L30-.L35
	.long	.L37-.L35
	.long	.L36-.L35
	.long	.L34-.L35
	.text
	.p2align 4,,10
	.p2align 3
.L40:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L30
.L41:
	movq	16(%rbx), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_collect_labels
	cmpq	24(%rbx), %rbp
	jb	.L41
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
.L36:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L45:
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
.L37:
	.cfi_restore_state
	movq	(%r12), %rax
	movq	16(%rbx), %r14
	movq	8(%rax), %r15
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L42
	xorl	%ebp, %ebp
	jmp	.L44
	.p2align 4,,10
	.p2align 3
.L64:
	addq	$1, %rbp
	cmpq	%rbp, 8(%rsp)
	je	.L42
.L44:
	movq	(%r15,%rbp,8), %rax
	movq	%r14, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L64
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r14, %rsi
	leaq	.LC56(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r14
.L42:
	movl	$64, %edi
	movq	4(%rbx), %r15
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r14, %rdi
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
	jmp	.L45
	.p2align 4,,10
	.p2align 3
.L34:
	movq	40(%rbx), %rbx
	jmp	.L45
	.p2align 4,,10
	.p2align 3
.L39:
	movq	24(%rbx), %rsi
	movq	%r12, %rdi
	call	sem_collect_labels
	movq	32(%rbx), %rbx
	jmp	.L45
	.p2align 4,,10
	.p2align 3
.L60:
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
	je	.L66
	movq	32(%rdx), %rax
	movl	(%rdx), %r10d
	movq	%rax, 32(%rsi)
	testl	%r10d, %r10d
	jne	.L106
	movl	24(%rdx), %edi
	testl	%edi, %edi
	je	.L77
	movl	$1, 20(%rsi)
	movq	48(%rsi), %rbp
.L78:
	movq	96(%r12), %r13
	movq	88(%r12), %r14
	testq	%r13, %r13
	je	.L85
	xorl	%ebx, %ebx
	jmp	.L86
	.p2align 4,,10
	.p2align 3
.L107:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L85
.L86:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L107
.L65:
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
.L106:
	.cfi_restore_state
	movl	20(%rsi), %r9d
	testl	%r9d, %r9d
	je	.L65
	movl	24(%rdx), %edx
	movq	48(%rsi), %rbp
	testl	%edx, %edx
	jne	.L78
	movq	24(%rdi), %r13
	movq	16(%rdi), %r14
.L83:
	testq	%r13, %r13
	je	.L65
.L74:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L84:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L78
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L84
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
.L77:
	.cfi_restore_state
	movl	20(%rsi), %ecx
	testl	%ecx, %ecx
	je	.L65
	movq	48(%rsi), %rbp
	movq	24(%r12), %r13
	movq	16(%r12), %r14
	jmp	.L83
	.p2align 4,,10
	.p2align 3
.L66:
	movq	48(%rsi), %rbp
	movq	16(%rdi), %r14
	movq	$0, 32(%rsi)
	movq	24(%rdi), %r13
	testq	%r13, %r13
	je	.L70
	xorl	%r15d, %r15d
	jmp	.L72
	.p2align 4,,10
	.p2align 3
.L109:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L108
.L72:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L109
	movq	48(%r12), %rax
	movq	40(%r12), %rcx
	xorl	%r15d, %r15d
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L75
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L110:
	addq	$1, %r15
	cmpq	%r15, 8(%rsp)
	movq	(%rsp), %rcx
	je	.L76
.L75:
	movq	(%rcx,%r15,8), %rdi
	movq	%rbp, %rsi
	movq	%rcx, (%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L110
.L79:
	movl	20(%rbx), %eax
	testl	%eax, %eax
	jne	.L74
	jmp	.L65
	.p2align 4,,10
	.p2align 3
.L85:
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
.L108:
	.cfi_restore_state
	movl	g_strict(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L79
	movl	$1, 20(%rbx)
	jmp	.L74
.L76:
	movq	112(%r12), %rax
	movq	%rbp, %rdx
	movq	8(%rax), %rsi
	movq	(%rax), %rdi
	call	has_data_declaration.isra.0
	movl	%eax, %edx
	movl	$2, %eax
	subl	%edx, %eax
	movl	%eax, 20(%rbx)
	jmp	.L74
.L70:
	movl	g_strict(%rip), %esi
	testl	%esi, %esi
	jne	.L65
	movl	$1, 20(%rbx)
	jmp	.L65
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
	je	.L158
.L112:
	movq	8(%rsp), %rax
	movq	16(%rax), %r13
	testq	%r13, %r13
	je	.L117
	movq	8(%rsp), %rax
	xorl	%r15d, %r15d
	movq	8(%rax), %r14
	jmp	.L115
	.p2align 4,,10
	.p2align 3
.L159:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L117
.L115:
	movq	(%r14,%r15,8), %rbx
	movq	%rbp, %rsi
	movq	8(%rbx), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L159
.L114:
	movl	16(%rsp), %eax
	testl	%eax, %eax
	je	.L130
	movq	24(%rsp), %rax
	movq	120(%rax), %rax
	movq	%rax, 16(%rsp)
	testq	%rax, %rax
	je	.L130
.L120:
	movq	(%r12), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L131
	movq	16(%r12), %r13
	testq	%r13, %r13
	je	.L123
	movq	8(%r12), %r14
	xorl	%r15d, %r15d
	jmp	.L121
	.p2align 4,,10
	.p2align 3
.L160:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L123
.L121:
	movq	(%r14,%r15,8), %r12
	movq	%rbp, %rsi
	movq	8(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L160
.L111:
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
.L117:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L112
	xorl	%ebx, %ebx
	jmp	.L114
	.p2align 4,,10
	.p2align 3
.L123:
	movq	8(%rsp), %r12
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L130:
	movq	%rbx, %r12
	jmp	.L111
.L158:
	movl	16(%rsp), %edx
	testl	%edx, %edx
	je	.L111
	movq	24(%rsp), %rax
	movq	120(%rax), %rax
	movq	%rax, 16(%rsp)
	testq	%rax, %rax
	je	.L111
.L119:
	movq	24(%rsp), %rax
	movq	24(%rax), %r13
	movq	16(%rax), %r14
	testq	%r13, %r13
	je	.L124
	xorl	%ebx, %ebx
	jmp	.L125
	.p2align 4,,10
	.p2align 3
.L161:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L124
.L125:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L161
	jmp	.L111
.L124:
	movq	16(%rsp), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$0, %eax
	cmovne	%rax, %r12
	jmp	.L111
.L131:
	movq	%rbx, %r12
	jmp	.L119
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
	je	.L211
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
	je	.L165
	cmpl	$5, %eax
	je	.L166
	cmpl	$2, %eax
	jne	.L167
	movq	48(%rsi), %rsi
	call	scope_find_value
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	movq	%rax, %r12
	movq	%rax, %rdx
	call	mark_global_reference
	testq	%r12, %r12
	je	.L215
	movl	28(%r12), %eax
	testl	%eax, %eax
	je	.L178
	movq	8(%r12), %rbp
	leaq	.LC50(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L216
	movl	(%r12), %eax
	cmpl	$1, %eax
	jne	.L181
	movq	%rbp, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	jne	.L180
	movl	(%r12), %eax
	.p2align 4
	.p2align 3
.L181:
	andl	$-3, %eax
	jne	.L217
.L162:
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
.L166:
	.cfi_restore_state
	cmpl	$32, 48(%rsi)
	je	.L214
.L167:
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
.L165:
	.cfi_restore_state
	movq	48(%rsi), %rsi
	call	sem_check_expr
.L214:
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
.L215:
	.cfi_restore_state
	movl	g_strict(%rip), %edx
	movq	48(%rbx), %r12
	movq	16(%rbp), %r14
	movq	24(%rbp), %r13
	testl	%edx, %edx
	jne	.L218
.L169:
	testq	%r13, %r13
	je	.L173
.L171:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L175:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L162
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L175
.L173:
	movq	72(%rbp), %r13
	movq	64(%rbp), %r14
	testq	%r13, %r13
	je	.L176
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L177:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L162
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L177
.L176:
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
.L178:
	.cfi_restore_state
	movl	(%r12), %eax
	cmpl	$1, %eax
	jne	.L181
.L180:
	movl	$1, 12(%rbx)
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L211:
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
.L216:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	$1, 16(%rbx)
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L218:
	testq	%r13, %r13
	je	.L170
	xorl	%r15d, %r15d
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L219:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L170
.L172:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L219
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L217:
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
.L170:
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
	jmp	.L169
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
	je	.L295
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
	leaq	.L225(%rip), %r12
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
.L221:
	cmpl	$10, (%rbx)
	ja	.L220
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L225:
	.long	.L220-.L225
	.long	.L220-.L225
	.long	.L233-.L225
	.long	.L232-.L225
	.long	.L224-.L225
	.long	.L230-.L225
	.long	.L229-.L225
	.long	.L293-.L225
	.long	.L227-.L225
	.long	.L226-.L225
	.long	.L224-.L225
	.text
	.p2align 4,,10
	.p2align 3
.L232:
	movq	48(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L296
	movl	$1, 24(%rbx)
	movq	%rbp, %rdi
	call	sem_check_expr
.L250:
	xorl	%r12d, %r12d
	cmpq	$0, 64(%rbx)
	je	.L220
.L251:
	movq	56(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	64(%rbx), %r12
	jb	.L251
.L220:
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
.L224:
	.cfi_restore_state
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	56(%rbx), %rbx
.L252:
	testq	%rbx, %rbx
	jne	.L221
	jmp	.L220
	.p2align 4,,10
	.p2align 3
.L226:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
.L293:
	movq	56(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	64(%rbx), %rbx
	jmp	.L252
	.p2align 4,,10
	.p2align 3
.L227:
	movq	56(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_lvalue
	movq	64(%rbx), %rbx
	jmp	.L252
	.p2align 4,,10
	.p2align 3
.L229:
	movq	56(%rbx), %rsi
.L294:
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
.L230:
	.cfi_restore_state
	movl	48(%rbx), %eax
	movq	56(%rbx), %rbx
	leal	-36(%rax), %edx
	cmpl	$1, %edx
	jbe	.L255
	cmpl	$53, %eax
	jne	.L252
.L255:
	movq	%rbx, %rsi
	jmp	.L294
	.p2align 4,,10
	.p2align 3
.L233:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	scope_find_value
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	movq	%rax, %r12
	movq	%rax, %rdx
	call	mark_global_reference
	testq	%r12, %r12
	je	.L234
	movl	28(%r12), %eax
	testl	%eax, %eax
	je	.L235
	movq	8(%r12), %rdi
	leaq	.LC50(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
.L235:
	cmpl	$1, (%r12)
	movl	%eax, 16(%rbx)
	je	.L238
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
.L296:
	.cfi_restore_state
	movq	48(%rsi), %r13
	movq	%rbp, %rdi
	movq	%r13, %rsi
	call	scope_find_value
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L297
	movl	(%rax), %eax
	cmpl	$1, %eax
	ja	.L298
.L248:
	testl	%eax, %eax
	jne	.L247
	movl	$1, 24(%rbx)
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	jmp	.L250
	.p2align 4,,10
	.p2align 3
.L238:
	xorl	$1, %eax
	movl	%eax, 12(%rbx)
	jmp	.L220
	.p2align 4,,10
	.p2align 3
.L234:
	movq	24(%rbp), %r14
	movq	48(%rbx), %r13
	movq	$0, 12(%rbx)
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L236
	xorl	%r12d, %r12d
	jmp	.L237
	.p2align 4,,10
	.p2align 3
.L299:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L236
.L237:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L299
	jmp	.L220
	.p2align 4,,10
	.p2align 3
.L247:
	movl	$0, 24(%rbx)
	jmp	.L250
	.p2align 4,,10
	.p2align 3
.L298:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	xorl	%eax, %eax
	movq	%r13, %rsi
	leaq	.LC60(%rip), %rdi
	call	dief@PLT
	movl	(%r12), %eax
	jmp	.L248
	.p2align 4,,10
	.p2align 3
.L295:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L297:
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
	jne	.L246
	jmp	.L244
	.p2align 4,,10
	.p2align 3
.L300:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L244
.L246:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L300
.L245:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	scope_find_value
	testq	%rax, %rax
	je	.L247
	movl	(%rax), %eax
	jmp	.L248
.L236:
	movq	72(%rbp), %r14
	movq	64(%rbp), %r15
	testq	%r14, %r14
	je	.L239
	xorl	%r12d, %r12d
	jmp	.L240
	.p2align 4,,10
	.p2align 3
.L301:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L239
.L240:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L301
	jmp	.L220
.L239:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L302
.L241:
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
.L244:
	.cfi_restore_state
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L245
.L302:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC57(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	48(%rbx), %r13
	jmp	.L241
	.cfi_endproc
.LFE34:
	.size	sem_check_expr, .-sem_check_expr
	.section	.rodata.str1.8
	.align 8
.LC61:
	.string	"internal: cannot pop global scope"
	.align 8
.LC62:
	.string	"external declaration conflicts with local name '%s'"
	.text
	.p2align 4
	.type	sem_check_stmt, @function
sem_check_stmt:
.LFB35:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L385
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
	leaq	.L308(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
.L305:
	cmpl	$13, (%rbx)
	ja	.L303
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L308:
	.long	.L303-.L308
	.long	.L318-.L308
	.long	.L317-.L308
	.long	.L316-.L308
	.long	.L309-.L308
	.long	.L314-.L308
	.long	.L311-.L308
	.long	.L312-.L308
	.long	.L303-.L308
	.long	.L303-.L308
	.long	.L311-.L308
	.long	.L388-.L308
	.long	.L309-.L308
	.long	.L307-.L308
	.text
	.p2align 4,,10
	.p2align 3
.L317:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L303
	.p2align 4
	.p2align 3
.L320:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbp
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L327
	xorl	%r15d, %r15d
	jmp	.L329
	.p2align 4,,10
	.p2align 3
.L390:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L327
.L329:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L390
.L328:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	movq	%rbp, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rbp
.L330:
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
	je	.L332
	movq	%r13, %rdi
	call	sem_check_expr
.L332:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L320
.L303:
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
.L311:
	.cfi_restore_state
	movq	16(%rbx), %rsi
.L389:
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
.L309:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
.L388:
	movq	24(%rbx), %rbx
.L333:
	testq	%rbx, %rbx
	jne	.L305
	jmp	.L303
	.p2align 4,,10
	.p2align 3
.L316:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%rbx), %rbx
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L307:
	movq	40(%rbx), %rbx
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L314:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L389
	jmp	.L303
	.p2align 4,,10
	.p2align 3
.L312:
	leaq	16(%r13), %rax
	cmpq	$0, 24(%rbx)
	movq	$0, 8(%rsp)
	movq	%rax, 16(%rsp)
	je	.L303
	.p2align 4
	.p2align 3
.L319:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rbp
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L391
.L334:
	movq	24(%r13), %r12
	movq	16(%r13), %r14
	testq	%r12, %r12
	je	.L337
	xorl	%r15d, %r15d
	jmp	.L339
	.p2align 4,,10
	.p2align 3
.L392:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L337
.L339:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L392
.L338:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L319
	jmp	.L303
	.p2align 4,,10
	.p2align 3
.L318:
	movl	g_strict(%rip), %esi
	testl	%esi, %esi
	je	.L393
	cmpq	$0, 24(%rbx)
	je	.L303
.L322:
	xorl	%ebp, %ebp
.L324:
	movq	16(%rbx), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_check_stmt
	cmpq	24(%rbx), %rbp
	jb	.L324
.L325:
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L303
	movq	0(%r13), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L394
.L326:
	movq	%rax, 0(%r13)
	jmp	.L303
	.p2align 4,,10
	.p2align 3
.L327:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	je	.L330
	movq	24(%r13), %r14
	movq	16(%r13), %r15
	testq	%r14, %r14
	je	.L330
	xorl	%r12d, %r12d
	jmp	.L331
	.p2align 4,,10
	.p2align 3
.L395:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L330
.L331:
	movq	(%r15,%r12,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L395
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L337:
	movq	%rbp, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L338
	.p2align 4,,10
	.p2align 3
.L391:
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r15
	testq	%r12, %r12
	je	.L334
	xorl	%r14d, %r14d
	jmp	.L336
	.p2align 4,,10
	.p2align 3
.L396:
	addq	$1, %r14
	cmpq	%r14, %r12
	je	.L334
.L336:
	movq	(%r15,%r14,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L396
	movq	%rbp, %rsi
	leaq	.LC62(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L334
.L393:
	movl	$32, %edi
	movq	0(%r13), %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 16(%rax)
	cmpq	$0, 24(%rbx)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, 0(%r13)
	jne	.L322
	jmp	.L325
.L385:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L394:
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
	jmp	.L326
	.cfi_endproc
.LFE35:
	.size	sem_check_stmt, .-sem_check_stmt
	.p2align 4
	.type	sem_check_initializer, @function
sem_check_initializer:
.LFB39:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L428
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
	je	.L431
	testl	%eax, %eax
	jne	.L397
	movq	16(%rsi), %r14
	cmpl	$2, (%r14)
	je	.L432
.L403:
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
.L431:
	.cfi_restore_state
	cmpq	$0, 24(%rsi)
	je	.L397
	xorl	%r12d, %r12d
.L402:
	movq	16(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_initializer
	cmpq	24(%rbx), %r12
	jb	.L402
.L397:
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
.L428:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.p2align 4,,10
	.p2align 3
.L432:
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
	je	.L405
.L404:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L408
	movq	8(%rsp), %rax
	xorl	%ebx, %ebx
	movq	8(%rax), %r15
	.p2align 4
	.p2align 3
.L406:
	movq	(%r15,%rbx,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L403
	addq	$1, %rbx
	cmpq	%r12, %rbx
	jne	.L406
.L408:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L404
.L405:
	movq	24(%rbp), %r12
	movq	16(%rbp), %r15
	testq	%r12, %r12
	je	.L409
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L410:
	movq	(%r15,%rbx,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L403
	addq	$1, %rbx
	cmpq	%rbx, %r12
	jne	.L410
.L409:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L403
	.cfi_endproc
.LFE39:
	.size	sem_check_initializer, .-sem_check_initializer
	.section	.rodata.str1.8
	.align 8
.LC63:
	.string	"internal: TOP_GAUTO should be ST_AUTO"
	.align 8
.LC64:
	.string	"vector bound must be a constant expression in '%s'"
	.section	.rodata.str1.1
.LC65:
	.string	"negative vector bound in '%s'"
	.section	.rodata.str1.8
	.align 8
.LC67:
	.string	"duplicate extern definition '%s'"
	.text
	.p2align 4
	.globl	sem_check_program
	.type	sem_check_program, @function
sem_check_program:
.LFB40:
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
	je	.L458
	.p2align 4
	.p2align 3
.L434:
	movq	0(%r13), %rax
	movq	24(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L437
	ja	.L438
	testl	%edx, %edx
	je	.L563
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
	je	.L449
	xorl	%r15d, %r15d
	jmp	.L451
	.p2align 4,,10
	.p2align 3
.L564:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L449
.L451:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L564
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rbp
.L449:
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
.L442:
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8(%r13), %rax
	jb	.L434
.L458:
	cmpq	$0, 8+g_known_functions(%rip)
	movq	$0, 8(%rsp)
	je	.L436
	.p2align 4
	.p2align 3
.L435:
	leaq	g_known_functions(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L461
	xorl	%r15d, %r15d
	jmp	.L463
	.p2align 4,,10
	.p2align 3
.L565:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L461
.L463:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L565
.L462:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L435
.L436:
	cmpq	$0, 8+g_known_variables(%rip)
	movq	$0, 8(%rsp)
	je	.L460
	.p2align 4
	.p2align 3
.L459:
	leaq	g_known_variables(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %r12
	movq	(%rbx), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L466
	xorl	%r15d, %r15d
	jmp	.L468
	.p2align 4,,10
	.p2align 3
.L566:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L466
.L468:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L566
.L467:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_variables(%rip), %rax
	jb	.L459
.L460:
	movq	%rbx, %rdi
	call	sem_add_builtin_functions
	cmpq	$0, 8(%r13)
	movq	$0, 16(%rsp)
	jne	.L464
	jmp	.L465
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L471:
	addq	$1, 16(%rsp)
	movq	8(%r13), %rax
	movq	16(%rsp), %rcx
	cmpq	%rax, %rcx
	jnb	.L567
.L464:
	movq	0(%r13), %rax
	movq	16(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L471
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
	jne	.L568
.L472:
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
	je	.L473
	movq	$0, 8(%rsp)
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L477:
	movq	24(%rsp), %rcx
	movq	8(%rax), %r14
	movq	8(%rcx), %rdx
	movq	8(%rsp), %rcx
	movq	(%rdx,%rcx,8), %rbp
	testq	%r12, %r12
	je	.L474
	xorl	%r15d, %r15d
	jmp	.L476
	.p2align 4,,10
	.p2align 3
.L569:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L474
.L476:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L569
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
.L474:
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
	jnb	.L473
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	jmp	.L477
	.p2align 4,,10
	.p2align 3
.L461:
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
	jmp	.L462
	.p2align 4,,10
	.p2align 3
.L466:
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
	movdqa	.LC66(%rip), %xmm6
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%rbx), %rax
	movups	%xmm6, 16(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L467
	.p2align 4,,10
	.p2align 3
.L438:
	cmpl	$3, %edx
	jne	.L442
	movq	8(%rax), %rax
	movq	16(%rax), %rdi
	call	sdup@PLT
	leaq	16(%rbx), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L442
	.p2align 4,,10
	.p2align 3
.L473:
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
	je	.L570
.L478:
	movq	%rax, (%rbx)
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L479
	movq	40(%rsp), %rax
	movdqa	48(%rsp), %xmm6
	movq	%rax, 16(%rbx)
	movups	%xmm6, 24(%rbx)
.L479:
	movq	32(%rsp), %rax
	movq	%rax, 120(%rbx)
	jmp	.L471
	.p2align 4,,10
	.p2align 3
.L437:
	movq	8(%rax), %rax
	cmpl	$2, 24(%rax)
	movq	%rax, 8(%rsp)
	je	.L571
.L452:
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L455
	xorl	%r15d, %r15d
	jmp	.L457
	.p2align 4,,10
	.p2align 3
.L572:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L455
.L457:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L572
	movq	%rbp, %rsi
	xorl	%eax, %eax
	leaq	.LC67(%rip), %rdi
	call	dief@PLT
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
.L455:
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
	movdqa	.LC66(%rip), %xmm7
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	(%rbx), %rax
	movups	%xmm7, 16(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L442
	.p2align 4,,10
	.p2align 3
.L563:
	movq	8(%rax), %rax
	cmpl	$2, (%rax)
	movq	%rax, 16(%rsp)
	je	.L443
	leaq	.LC63(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L443:
	movq	$0, 8(%rsp)
	movq	16(%rsp), %rax
	cmpq	$0, 24(%rax)
	je	.L442
	.p2align 4
	.p2align 3
.L444:
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
	je	.L445
	xorl	%r15d, %r15d
	jmp	.L447
	.p2align 4,,10
	.p2align 3
.L573:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L445
.L447:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L573
	movq	16(%rsp), %rax
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	movl	8(%rax), %edx
	movl	4(%rax), %esi
	call	error_at_location@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rbp
.L445:
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
	jb	.L444
	jmp	.L442
.L465:
	movq	$0, 8(%rsp)
	cmpq	$0, 72(%rbx)
	je	.L470
	.p2align 4
	.p2align 3
.L469:
	movq	64(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %r15
	movq	(%rax,%rcx,8), %r12
	testq	%r15, %r15
	je	.L484
	movq	0(%r13), %r14
	xorl	%ebp, %ebp
	jmp	.L487
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L485:
	addq	$1, %rbp
	cmpq	%r15, %rbp
	je	.L484
.L487:
	movq	(%r14,%rbp,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L485
	movq	8(%rdx), %rax
	movq	%r12, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L485
.L486:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	72(%rbx), %rax
	jb	.L469
.L470:
	movq	$0, 8(%rsp)
	cmpq	$0, 96(%rbx)
	je	.L433
	.p2align 4
	.p2align 3
.L482:
	movq	88(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %rsi
	movq	0(%r13), %rdi
	movq	(%rax,%rcx,8), %rbp
	movq	%rbp, %rdx
	call	has_data_declaration.isra.0
	testl	%eax, %eax
	jne	.L488
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
	je	.L498
	xorl	%r15d, %r15d
	jmp	.L490
	.p2align 4,,10
	.p2align 3
.L574:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L498
.L490:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L574
.L489:
	movq	24(%rsp), %rcx
	movq	%r13, %rdi
	movl	%eax, 8(%rcx)
	movq	16(%rsp), %rax
	movl	$3, (%rax)
	movq	%rax, %rsi
	movq	%rcx, 8(%rax)
	call	vec_push@PLT
.L488:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	96(%rbx), %rax
	jb	.L482
.L433:
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
.L484:
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
	jmp	.L486
	.p2align 4,,10
	.p2align 3
.L498:
	movl	$1, %eax
	jmp	.L489
.L567:
	testq	%rax, %rax
	je	.L465
	xorl	%ebp, %ebp
	jmp	.L481
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L480:
	addq	$1, %rbp
	cmpq	8(%r13), %rbp
	jnb	.L465
.L481:
	movq	0(%r13), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L480
	movq	8(%rax), %rax
	movq	%rbx, %rdi
	movq	56(%rax), %rsi
	call	sem_check_initializer
	jmp	.L480
.L571:
	movq	32(%rax), %rdi
	testq	%rdi, %rdi
	je	.L452
	leaq	72(%rsp), %rsi
	call	try_eval_const_expr@PLT
	testl	%eax, %eax
	je	.L575
.L453:
	movq	72(%rsp), %rax
	testq	%rax, %rax
	js	.L576
.L454:
	movq	8(%rsp), %rcx
	movq	%rax, 48(%rcx)
	jmp	.L452
.L568:
	pxor	%xmm0, %xmm0
	movq	$0, 32(%rbx)
	movups	%xmm0, 16(%rbx)
	jmp	.L472
.L570:
	leaq	.LC61(%rip), %rdi
	call	dief@PLT
	movq	(%rbx), %rax
	movq	(%rax), %rax
	jmp	.L478
.L575:
	movq	8(%rsp), %rax
	leaq	.LC64(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L453
.L576:
	movq	8(%rsp), %rax
	leaq	.LC65(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	movq	72(%rsp), %rax
	jmp	.L454
	.cfi_endproc
.LFE40:
	.size	sem_check_program, .-sem_check_program
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC53:
	.long	0
	.long	0
	.long	0
	.long	1
	.align 16
.LC66:
	.long	0
	.long	0
	.long	1
	.long	0
	.section	.note.GNU-stack,"",@progbits
