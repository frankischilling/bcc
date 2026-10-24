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
	.p2align 4
	.type	mark_global_reference, @function
mark_global_reference:
.LFB31:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rsi, %r15
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	testq	%rdx, %rdx
	je	.L31
	movl	(%rdx), %r10d
	testl	%r10d, %r10d
	jne	.L72
	movl	24(%rdx), %r8d
	testl	%r8d, %r8d
	je	.L35
	movl	$1, 20(%rsi)
	movq	40(%rsi), %rbp
.L36:
	movq	96(%r12), %r13
	movq	88(%r12), %r14
	testq	%r13, %r13
	je	.L50
	xorl	%ebx, %ebx
	jmp	.L51
	.p2align 4,,10
	.p2align 3
.L73:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L50
.L51:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L73
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
.L72:
	.cfi_restore_state
	movl	20(%rsi), %r9d
	testl	%r9d, %r9d
	je	.L30
	movl	24(%rdx), %edx
	movq	40(%rsi), %rbp
	testl	%edx, %edx
	jne	.L36
	movq	16(%rdi), %r14
	movq	24(%rdi), %r13
.L48:
	testq	%r13, %r13
	je	.L30
.L41:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L49:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L36
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L49
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
.L35:
	.cfi_restore_state
	movl	20(%rsi), %ecx
	testl	%ecx, %ecx
	je	.L30
	movq	40(%rsi), %rbp
	movq	16(%rdi), %r14
	movq	24(%rdi), %r13
	jmp	.L48
	.p2align 4,,10
	.p2align 3
.L31:
	movq	24(%rdi), %r13
	movq	40(%rsi), %rbp
	movq	16(%rdi), %r14
	testq	%r13, %r13
	je	.L37
	xorl	%ebx, %ebx
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L75:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L74
.L39:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L75
	movq	48(%r12), %rax
	movq	40(%r12), %rcx
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L42
	xorl	%ebx, %ebx
	jmp	.L44
	.p2align 4,,10
	.p2align 3
.L76:
	addq	$1, %rbx
	cmpq	%rbx, 8(%rsp)
	movq	(%rsp), %rcx
	je	.L42
.L44:
	movq	(%rcx,%rbx,8), %rdi
	movq	%rbp, %rsi
	movq	%rcx, (%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L76
.L43:
	movl	20(%r15), %eax
	testl	%eax, %eax
	jne	.L41
	jmp	.L30
	.p2align 4,,10
	.p2align 3
.L50:
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
.L74:
	.cfi_restore_state
	movl	g_strict(%rip), %edi
	testl	%edi, %edi
	jne	.L43
	movl	$1, 20(%r15)
	jmp	.L41
.L42:
	movq	112(%r12), %rax
	movq	%rbp, %rdx
	movq	8(%rax), %rsi
	movq	(%rax), %rdi
	call	has_data_declaration.isra.0
	movl	%eax, %edx
	movl	$2, %eax
	subl	%edx, %eax
	movl	%eax, 20(%r15)
	jmp	.L41
.L37:
	movl	g_strict(%rip), %esi
	testl	%esi, %esi
	jne	.L30
	movl	$1, 20(%r15)
	jmp	.L30
	.cfi_endproc
.LFE31:
	.size	mark_global_reference, .-mark_global_reference
	.section	.rodata.str1.1
.LC56:
	.string	"duplicate label '%s' at %d:%d"
	.text
	.p2align 4
	.type	sem_collect_labels, @function
sem_collect_labels:
.LFB35:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L106
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.L82(%rip), %r14
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
.L79:
	cmpl	$12, (%rbx)
	ja	.L77
	movl	(%rbx), %eax
	movslq	(%r14,%rax,4), %rax
	addq	%r14, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L82:
	.long	.L77-.L82
	.long	.L86-.L82
	.long	.L77-.L82
	.long	.L85-.L82
	.long	.L81-.L82
	.long	.L77-.L82
	.long	.L77-.L82
	.long	.L77-.L82
	.long	.L77-.L82
	.long	.L77-.L82
	.long	.L77-.L82
	.long	.L83-.L82
	.long	.L81-.L82
	.text
	.p2align 4,,10
	.p2align 3
.L86:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L77
.L87:
	movq	16(%rbx), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_collect_labels
	cmpq	24(%rbx), %rbp
	jb	.L87
.L77:
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
.L81:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L91:
	testq	%rbx, %rbx
	jne	.L79
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
.L83:
	.cfi_restore_state
	movq	(%r12), %rax
	movq	16(%rbx), %r13
	movq	8(%rax), %r15
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L88
	xorl	%ebp, %ebp
	jmp	.L90
	.p2align 4,,10
	.p2align 3
.L110:
	addq	$1, %rbp
	cmpq	%rbp, 8(%rsp)
	je	.L88
.L90:
	movq	(%r15,%rbp,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L110
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC56(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r13
.L88:
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
	jmp	.L91
	.p2align 4,,10
	.p2align 3
.L85:
	movq	24(%rbx), %rsi
	movq	%r12, %rdi
	call	sem_collect_labels
	movq	32(%rbx), %rbx
	jmp	.L91
	.p2align 4,,10
	.p2align 3
.L106:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE35:
	.size	sem_collect_labels, .-sem_collect_labels
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
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	%rdi, (%rsp)
	testq	%rsi, %rsi
	je	.L111
	movl	(%rsi), %eax
	movq	%rsi, %rbx
	cmpl	$4, %eax
	je	.L114
	cmpl	$5, %eax
	je	.L115
	cmpl	$2, %eax
	jne	.L116
	movq	(%rdi), %rax
	movq	40(%rsi), %r14
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L170
.L117:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L123
	movq	8(%rsp), %rax
	xorl	%ebp, %ebp
	movq	8(%rax), %r13
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L174:
	addq	$1, %rbp
	cmpq	%r12, %rbp
	je	.L123
.L120:
	movq	0(%r13,%rbp,8), %r15
	movq	%r14, %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L174
	movq	(%rsp), %rdi
	movq	%r15, %rdx
	movq	%rbx, %rsi
	call	mark_global_reference
	movl	28(%r15), %eax
	testl	%eax, %eax
	je	.L175
	movq	8(%r15), %rdi
	leaq	.LC50(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L176
	movl	(%r15), %eax
	cmpl	$1, %eax
	jne	.L135
.L136:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	leaq	.LC58(%rip), %rdi
	xorl	%eax, %eax
	movq	40(%rbx), %rsi
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
	jmp	dief@PLT
	.p2align 4,,10
	.p2align 3
.L115:
	.cfi_restore_state
	cmpl	$32, 40(%rsi)
	je	.L177
.L116:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC59(%rip), %rdi
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
.L175:
	.cfi_restore_state
	movl	(%r15), %eax
	cmpl	$1, %eax
	je	.L178
.L135:
	andl	$-3, %eax
	jne	.L136
.L111:
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
.L114:
	.cfi_restore_state
	movq	(%rsp), %r14
	movq	40(%rsi), %rsi
	movq	%r14, %rdi
	call	sem_check_expr
	movq	48(%rbx), %rsi
	movq	%r14, %rdi
.L173:
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
.L177:
	.cfi_restore_state
	movq	48(%rsi), %rsi
	movq	(%rsp), %rdi
	jmp	.L173
	.p2align 4,,10
	.p2align 3
.L123:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L117
.L170:
	movq	(%rsp), %rdi
	xorl	%edx, %edx
	movq	%rbx, %rsi
	call	mark_global_reference
	movq	(%rsp), %rax
	movl	g_strict(%rip), %edx
	movq	40(%rbx), %r12
	movq	16(%rax), %r14
	movq	24(%rax), %r13
	testl	%edx, %edx
	jne	.L179
.L124:
	testq	%r13, %r13
	je	.L128
.L126:
	xorl	%ebx, %ebx
	jmp	.L130
	.p2align 4,,10
	.p2align 3
.L180:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L128
.L130:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L180
	jmp	.L111
	.p2align 4,,10
	.p2align 3
.L176:
	movl	$1, 16(%rbx)
	jmp	.L111
.L178:
	movl	$1, 12(%rbx)
	jmp	.L111
.L128:
	movq	(%rsp), %rax
	movq	72(%rax), %r13
	movq	64(%rax), %r14
	testq	%r13, %r13
	je	.L131
	xorl	%ebx, %ebx
	jmp	.L132
	.p2align 4,,10
	.p2align 3
.L181:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L131
.L132:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L181
	jmp	.L111
.L179:
	testq	%r13, %r13
	je	.L125
	xorl	%r15d, %r15d
	jmp	.L127
	.p2align 4,,10
	.p2align 3
.L182:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L125
.L127:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L182
	jmp	.L126
.L131:
	movq	%r12, %rdi
	call	sdup@PLT
	movq	(%rsp), %rdi
	addq	$24, %rsp
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
.L125:
	.cfi_restore_state
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r12, %rsi
	xorl	%eax, %eax
	leaq	.LC57(%rip), %rdi
	call	dief@PLT
	movq	(%rsp), %rax
	movq	40(%rbx), %r12
	movq	16(%rax), %r14
	movq	24(%rax), %r13
	jmp	.L124
	.cfi_endproc
.LFE32:
	.size	sem_check_lvalue, .-sem_check_lvalue
	.section	.rodata.str1.1
.LC60:
	.string	"'%s' is not callable at %d:%d"
	.text
	.p2align 4
	.type	sem_check_expr, @function
sem_check_expr:
.LFB33:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L273
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
	leaq	.L188(%rip), %r12
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
.L184:
	cmpl	$10, (%rbx)
	ja	.L183
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L188:
	.long	.L183-.L188
	.long	.L183-.L188
	.long	.L196-.L188
	.long	.L195-.L188
	.long	.L187-.L188
	.long	.L193-.L188
	.long	.L192-.L188
	.long	.L271-.L188
	.long	.L190-.L188
	.long	.L189-.L188
	.long	.L187-.L188
	.text
	.p2align 4,,10
	.p2align 3
.L195:
	movq	40(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L274
	movl	$1, 24(%rbx)
	movq	%rbp, %rdi
	call	sem_check_expr
.L222:
	xorl	%r12d, %r12d
	cmpq	$0, 56(%rbx)
	je	.L183
.L224:
	movq	48(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	56(%rbx), %r12
	jb	.L224
.L183:
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
.L187:
	.cfi_restore_state
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	48(%rbx), %rbx
.L225:
	testq	%rbx, %rbx
	jne	.L184
	jmp	.L183
	.p2align 4,,10
	.p2align 3
.L189:
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
.L271:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	56(%rbx), %rbx
	jmp	.L225
	.p2align 4,,10
	.p2align 3
.L190:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_lvalue
	movq	56(%rbx), %rbx
	jmp	.L225
	.p2align 4,,10
	.p2align 3
.L192:
	movq	48(%rbx), %rsi
.L272:
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
.L193:
	.cfi_restore_state
	movl	40(%rbx), %eax
	movq	48(%rbx), %rbx
	leal	-36(%rax), %edx
	cmpl	$1, %edx
	jbe	.L231
	cmpl	$53, %eax
	jne	.L225
.L231:
	movq	%rbx, %rsi
	jmp	.L272
	.p2align 4,,10
	.p2align 3
.L196:
	movq	40(%rbx), %rax
	movq	%rax, (%rsp)
	movq	0(%rbp), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L201
.L197:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L203
	movq	8(%rsp), %rax
	xorl	%r14d, %r14d
	movq	8(%rax), %r13
	jmp	.L200
	.p2align 4,,10
	.p2align 3
.L275:
	addq	$1, %r14
	cmpq	%r14, %r12
	je	.L203
.L200:
	movq	0(%r13,%r14,8), %r15
	movq	(%rsp), %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L275
	movq	%r15, %rdx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	mark_global_reference
	movl	28(%r15), %eax
	testl	%eax, %eax
	je	.L205
	movq	8(%r15), %rdi
	leaq	.LC50(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
.L205:
	cmpl	$1, (%r15)
	movl	%eax, 16(%rbx)
	je	.L208
	movl	$0, 12(%rbx)
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
.L203:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L197
.L201:
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	mark_global_reference
	movq	24(%rbp), %r14
	movq	40(%rbx), %r13
	movq	$0, 12(%rbx)
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L206
	xorl	%r12d, %r12d
	jmp	.L207
	.p2align 4,,10
	.p2align 3
.L276:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L206
.L207:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L276
	jmp	.L183
	.p2align 4,,10
	.p2align 3
.L274:
	movq	0(%rbp), %rax
	movq	40(%rsi), %r12
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L214
.L213:
	movq	8(%rsp), %rax
	movq	16(%rax), %r13
	testq	%r13, %r13
	je	.L218
	movq	8(%rsp), %rax
	xorl	%r14d, %r14d
	movq	8(%rax), %rax
	movq	%rax, (%rsp)
	jmp	.L216
	.p2align 4,,10
	.p2align 3
.L277:
	addq	$1, %r14
	cmpq	%r13, %r14
	je	.L218
.L216:
	movq	(%rsp), %rax
	movq	%r12, %rsi
	movq	(%rax,%r14,8), %r15
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L277
	movl	(%r15), %eax
	cmpl	$1, %eax
	ja	.L278
.L229:
	testl	%eax, %eax
	jne	.L220
	movl	$1, 24(%rbx)
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	jmp	.L222
	.p2align 4,,10
	.p2align 3
.L218:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L213
.L214:
	movq	24(%rbp), %r14
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L219
	xorl	%r13d, %r13d
	jmp	.L221
	.p2align 4,,10
	.p2align 3
.L279:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L219
.L221:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L279
	.p2align 4
	.p2align 3
.L220:
	movl	$0, 24(%rbx)
	jmp	.L222
	.p2align 4,,10
	.p2align 3
.L208:
	xorl	$1, %eax
	movl	%eax, 12(%rbx)
	jmp	.L183
.L278:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	xorl	%eax, %eax
	movq	%r12, %rsi
	leaq	.LC60(%rip), %rdi
	call	dief@PLT
	movl	(%r15), %eax
	jmp	.L229
.L273:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L206:
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
	je	.L209
	xorl	%r12d, %r12d
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L280:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L209
.L210:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L280
	jmp	.L183
.L209:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L281
.L211:
	movq	%r13, %rdi
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
.L219:
	.cfi_restore_state
	movq	%r12, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	$0, 24(%rbx)
	jmp	.L222
.L281:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC57(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	40(%rbx), %r13
	jmp	.L211
	.cfi_endproc
.LFE33:
	.size	sem_check_expr, .-sem_check_expr
	.p2align 4
	.type	sem_check_initializer, @function
sem_check_initializer:
.LFB39:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L313
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
	je	.L316
	testl	%eax, %eax
	jne	.L282
	movq	16(%rsi), %r14
	cmpl	$2, (%r14)
	je	.L317
.L288:
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
.L316:
	.cfi_restore_state
	cmpq	$0, 24(%rsi)
	je	.L282
	xorl	%r12d, %r12d
.L287:
	movq	16(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_initializer
	cmpq	24(%rbx), %r12
	jb	.L287
.L282:
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
.L313:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.p2align 4,,10
	.p2align 3
.L317:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	(%rdi), %rax
	movq	40(%r14), %r13
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L290
.L289:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L293
	movq	8(%rsp), %rax
	xorl	%ebx, %ebx
	movq	8(%rax), %r15
	.p2align 4
	.p2align 3
.L291:
	movq	(%r15,%rbx,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L288
	addq	$1, %rbx
	cmpq	%r12, %rbx
	jne	.L291
.L293:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L289
.L290:
	movq	24(%rbp), %r12
	movq	16(%rbp), %r15
	testq	%r12, %r12
	je	.L294
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L295:
	movq	(%r15,%rbx,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L288
	addq	$1, %rbx
	cmpq	%rbx, %r12
	jne	.L295
.L294:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L288
	.cfi_endproc
.LFE39:
	.size	sem_check_initializer, .-sem_check_initializer
	.section	.rodata.str1.8
	.align 8
.LC61:
	.string	"internal: cannot pop global scope"
	.align 8
.LC62:
	.string	"bcc: warning: case label falls through to another case label at %d:%d\n"
	.text
	.p2align 4
	.type	sem_check_stmt, @function
sem_check_stmt:
.LFB34:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L394
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
	leaq	.L323(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
.L320:
	cmpl	$12, (%rbx)
	ja	.L318
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L323:
	.long	.L318-.L323
	.long	.L332-.L323
	.long	.L331-.L323
	.long	.L330-.L323
	.long	.L329-.L323
	.long	.L328-.L323
	.long	.L325-.L323
	.long	.L326-.L323
	.long	.L318-.L323
	.long	.L318-.L323
	.long	.L325-.L323
	.long	.L397-.L323
	.long	.L322-.L323
	.text
	.p2align 4,,10
	.p2align 3
.L331:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L318
	.p2align 4
	.p2align 3
.L334:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbp
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L341
	xorl	%r15d, %r15d
	jmp	.L343
	.p2align 4,,10
	.p2align 3
.L399:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L341
.L343:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L399
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	movq	%rbp, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rbp
.L341:
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
	je	.L344
	movq	%r13, %rdi
	call	sem_check_expr
.L344:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L334
.L318:
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
.L325:
	.cfi_restore_state
	movq	16(%rbx), %rsi
.L398:
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
.L397:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L345:
	testq	%rbx, %rbx
	jne	.L320
	jmp	.L318
	.p2align 4,,10
	.p2align 3
.L326:
	leaq	16(%r13), %rax
	cmpq	$0, 24(%rbx)
	movq	$0, 8(%rsp)
	movq	%rax, 16(%rsp)
	je	.L318
	.p2align 4
	.p2align 3
.L333:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	24(%r13), %rbp
	movq	16(%r13), %r14
	movq	(%rax,%rcx,8), %r12
	testq	%rbp, %rbp
	je	.L346
	xorl	%r15d, %r15d
	jmp	.L348
	.p2align 4,,10
	.p2align 3
.L400:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L346
.L348:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L400
.L347:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L333
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
.L330:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%rbx), %rbx
	jmp	.L345
	.p2align 4,,10
	.p2align 3
.L329:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rbx
	jmp	.L345
	.p2align 4,,10
	.p2align 3
.L328:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L398
	jmp	.L318
	.p2align 4,,10
	.p2align 3
.L322:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %r14
	testq	%r14, %r14
	je	.L318
	cmpl	$1, (%r14)
	jne	.L357
	cmpq	$0, 24(%r14)
	je	.L357
	xorl	%ecx, %ecx
	xorl	%r12d, %r12d
	leaq	.LC62(%rip), %r15
	jmp	.L353
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L350:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	andl	%eax, %ecx
.L352:
	addq	$1, %r12
	cmpq	24(%r14), %r12
	jnb	.L397
.L353:
	movq	16(%r14), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	cmpl	$13, %eax
	jne	.L350
	testl	%ecx, %ecx
	jne	.L401
.L351:
	movl	$1, %ecx
	jmp	.L352
	.p2align 4,,10
	.p2align 3
.L332:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	je	.L402
	cmpq	$0, 24(%rbx)
	je	.L318
.L336:
	xorl	%ebp, %ebp
.L338:
	movq	16(%rbx), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_check_stmt
	cmpq	24(%rbx), %rbp
	jb	.L338
.L339:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L318
	movq	0(%r13), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L403
.L340:
	movq	%rax, 0(%r13)
	jmp	.L318
.L357:
	movq	%r14, %rbx
	jmp	.L320
	.p2align 4,,10
	.p2align 3
.L346:
	movq	%r12, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L347
.L401:
	movl	8(%rdx), %ecx
	movq	stderr(%rip), %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	movl	4(%rdx), %edx
	call	fprintf@PLT
	jmp	.L351
.L402:
	movl	$32, %edi
	movq	0(%r13), %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 16(%rax)
	cmpq	$0, 24(%rbx)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, 0(%r13)
	jne	.L336
	jmp	.L339
.L394:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L403:
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
	jmp	.L340
	.cfi_endproc
.LFE34:
	.size	sem_check_stmt, .-sem_check_stmt
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
	movl	$120, %edi
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
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
	movq	%r13, 112(%rbx)
	je	.L429
	.p2align 4
	.p2align 3
.L405:
	movq	0(%r13), %rax
	movq	24(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L408
	ja	.L409
	testl	%edx, %edx
	je	.L532
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
	je	.L420
	xorl	%r15d, %r15d
	jmp	.L422
	.p2align 4,,10
	.p2align 3
.L533:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L420
.L422:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L533
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rbp
.L420:
	movl	$56, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %r12
	movl	$1, (%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 36(%rax)
	call	sdup@PLT
	pxor	%xmm0, %xmm0
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	8(%rsp), %rax
	movups	%xmm0, 16(%r12)
	movdqu	8(%rax), %xmm0
	movq	24(%rax), %rax
	movq	%rax, 48(%r12)
	movq	(%rbx), %rax
	movups	%xmm0, 32(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
.L413:
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8(%r13), %rax
	jb	.L405
.L429:
	cmpq	$0, 8+g_known_functions(%rip)
	movq	$0, 8(%rsp)
	je	.L407
	.p2align 4
	.p2align 3
.L406:
	leaq	g_known_functions(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L432
	xorl	%r15d, %r15d
	jmp	.L434
	.p2align 4,,10
	.p2align 3
.L534:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L432
.L434:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L534
.L433:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L406
.L407:
	cmpq	$0, 8+g_known_variables(%rip)
	movq	$0, 8(%rsp)
	je	.L431
	.p2align 4
	.p2align 3
.L430:
	leaq	g_known_variables(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %r12
	movq	(%rbx), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L437
	xorl	%r15d, %r15d
	jmp	.L439
	.p2align 4,,10
	.p2align 3
.L535:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L437
.L439:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L535
.L438:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_variables(%rip), %rax
	jb	.L430
.L431:
	movq	%rbx, %rdi
	call	sem_add_builtin_functions
	cmpq	$0, 8(%r13)
	movq	$0, 16(%rsp)
	jne	.L435
	jmp	.L436
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L442:
	addq	$1, 16(%rsp)
	movq	8(%r13), %rax
	movq	16(%rsp), %rcx
	cmpq	%rax, %rcx
	jnb	.L536
.L435:
	movq	0(%r13), %rax
	movq	16(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L442
	movq	8(%rax), %r14
	movl	$32, %edi
	movq	(%rbx), %rbp
	movq	%r14, 24(%rsp)
	call	xmalloc@PLT
	pxor	%xmm7, %xmm7
	movups	%xmm7, 16(%rax)
	cmpq	$0, 16(%r14)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, (%rbx)
	je	.L443
	movq	$0, 8(%rsp)
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L447:
	movq	24(%rsp), %rcx
	movq	8(%rax), %r14
	movq	8(%rcx), %rdx
	movq	8(%rsp), %rcx
	movq	(%rdx,%rcx,8), %rbp
	testq	%r12, %r12
	je	.L444
	xorl	%r15d, %r15d
	jmp	.L446
	.p2align 4,,10
	.p2align 3
.L537:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L444
.L446:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L537
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
.L444:
	movl	$56, %edi
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
	pxor	%xmm0, %xmm0
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	(%rbx), %rax
	movups	%xmm0, 16(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	24(%rsp), %rcx
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	16(%rcx), %rax
	jnb	.L443
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	jmp	.L447
	.p2align 4,,10
	.p2align 3
.L432:
	movl	$56, %edi
	call	xmalloc@PLT
	pxor	%xmm4, %xmm4
	movq	%rbp, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %r12
	movl	$1, (%rax)
	movups	%xmm4, 4(%rax)
	movups	%xmm4, 20(%rax)
	movups	%xmm4, 36(%rax)
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
	jmp	.L433
	.p2align 4,,10
	.p2align 3
.L437:
	movl	$56, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r12, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %rbp
	movl	$0, (%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 36(%rax)
	call	sdup@PLT
	movdqa	.LC66(%rip), %xmm6
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%rbx), %rax
	movups	%xmm6, 16(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L438
	.p2align 4,,10
	.p2align 3
.L409:
	cmpl	$3, %edx
	jne	.L413
	movq	8(%rax), %rax
	movq	16(%rax), %rdi
	call	sdup@PLT
	leaq	16(%rbx), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L413
	.p2align 4,,10
	.p2align 3
.L443:
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
	je	.L538
.L448:
	movq	%rax, (%rbx)
	jmp	.L442
	.p2align 4,,10
	.p2align 3
.L408:
	movq	8(%rax), %rax
	cmpl	$2, 24(%rax)
	movq	%rax, 8(%rsp)
	je	.L539
.L423:
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L426
	xorl	%r15d, %r15d
	jmp	.L428
	.p2align 4,,10
	.p2align 3
.L540:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L426
.L428:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L540
	movq	%rbp, %rsi
	xorl	%eax, %eax
	leaq	.LC67(%rip), %rdi
	call	dief@PLT
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
.L426:
	movl	$56, %edi
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %r12
	movl	$0, (%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 36(%rax)
	call	sdup@PLT
	movdqa	.LC66(%rip), %xmm7
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	(%rbx), %rax
	movups	%xmm7, 16(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L413
	.p2align 4,,10
	.p2align 3
.L532:
	movq	8(%rax), %rax
	cmpl	$2, (%rax)
	movq	%rax, 16(%rsp)
	je	.L414
	leaq	.LC63(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L414:
	movq	$0, 8(%rsp)
	movq	16(%rsp), %rax
	cmpq	$0, 24(%rax)
	je	.L413
	.p2align 4
	.p2align 3
.L415:
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
	je	.L416
	xorl	%r15d, %r15d
	jmp	.L418
	.p2align 4,,10
	.p2align 3
.L541:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L416
.L418:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L541
	movq	16(%rsp), %rax
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	movl	8(%rax), %edx
	movl	4(%rax), %esi
	call	error_at_location@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rbp
.L416:
	movq	16(%rsp), %r14
	movl	$56, %edi
	movq	4(%r14), %rdx
	movq	%rdx, 40(%rsp)
	call	xmalloc@PLT
	pxor	%xmm2, %xmm2
	movq	%rbp, %rdi
	movl	$0, 52(%rax)
	movq	%rax, %r12
	movl	$0, (%rax)
	movups	%xmm2, 4(%rax)
	movups	%xmm2, 20(%rax)
	movups	%xmm2, 36(%rax)
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
	movq	%rax, 40(%r12)
	movq	(%rbx), %rax
	setne	%dl
	movl	%edx, 32(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%r14), %rax
	jb	.L415
	jmp	.L413
.L436:
	movq	$0, 8(%rsp)
	cmpq	$0, 72(%rbx)
	je	.L441
	.p2align 4
	.p2align 3
.L440:
	movq	64(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %r15
	movq	(%rax,%rcx,8), %r12
	testq	%r15, %r15
	je	.L453
	movq	0(%r13), %r14
	xorl	%ebp, %ebp
	jmp	.L456
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L454:
	addq	$1, %rbp
	cmpq	%r15, %rbp
	je	.L453
.L456:
	movq	(%r14,%rbp,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L454
	movq	8(%rdx), %rax
	movq	%r12, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L454
.L455:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	72(%rbx), %rax
	jb	.L440
.L441:
	movq	$0, 8(%rsp)
	cmpq	$0, 96(%rbx)
	je	.L404
	.p2align 4
	.p2align 3
.L451:
	movq	88(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %rsi
	movq	0(%r13), %rdi
	movq	(%rax,%rcx,8), %rbp
	movq	%rbp, %rdx
	call	has_data_declaration.isra.0
	testl	%eax, %eax
	jne	.L457
	movl	$16, %edi
	call	xmalloc@PLT
	movl	$64, %edi
	movq	%rax, 16(%rsp)
	call	xmalloc@PLT
	pxor	%xmm3, %xmm3
	movq	%rbp, %rdi
	movups	%xmm3, (%rax)
	movq	%rax, %r14
	movups	%xmm3, 16(%rax)
	movups	%xmm3, 32(%rax)
	movups	%xmm3, 48(%rax)
	movq	%rax, 24(%rsp)
	call	sdup@PLT
	movq	8+g_known_variables(%rip), %r12
	movq	%rax, 16(%r14)
	movq	g_known_variables(%rip), %r14
	testq	%r12, %r12
	je	.L467
	xorl	%r15d, %r15d
	jmp	.L459
	.p2align 4,,10
	.p2align 3
.L542:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L467
.L459:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L542
.L458:
	movq	24(%rsp), %rcx
	movq	%r13, %rdi
	movl	%eax, 8(%rcx)
	movq	16(%rsp), %rax
	movl	$3, (%rax)
	movq	%rax, %rsi
	movq	%rcx, 8(%rax)
	call	vec_push@PLT
.L457:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	96(%rbx), %rax
	jb	.L451
.L404:
	addq	$72, %rsp
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
.L453:
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
	jmp	.L455
	.p2align 4,,10
	.p2align 3
.L467:
	movl	$1, %eax
	jmp	.L458
.L536:
	testq	%rax, %rax
	je	.L436
	xorl	%ebp, %ebp
	jmp	.L450
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L449:
	addq	$1, %rbp
	cmpq	8(%r13), %rbp
	jnb	.L436
.L450:
	movq	0(%r13), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L449
	movq	8(%rax), %rax
	movq	%rbx, %rdi
	movq	56(%rax), %rsi
	call	sem_check_initializer
	jmp	.L449
.L539:
	movq	32(%rax), %rdi
	testq	%rdi, %rdi
	je	.L423
	leaq	56(%rsp), %rsi
	call	try_eval_const_expr@PLT
	testl	%eax, %eax
	je	.L543
.L424:
	movq	56(%rsp), %rax
	testq	%rax, %rax
	js	.L544
.L425:
	movq	8(%rsp), %rcx
	movq	%rax, 48(%rcx)
	jmp	.L423
.L538:
	leaq	.LC61(%rip), %rdi
	call	dief@PLT
	movq	(%rbx), %rax
	movq	(%rax), %rax
	jmp	.L448
.L543:
	movq	8(%rsp), %rax
	leaq	.LC64(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L424
.L544:
	movq	8(%rsp), %rax
	leaq	.LC65(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	movq	56(%rsp), %rax
	jmp	.L425
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
