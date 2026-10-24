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
	.string	"mkdir"
.LC40:
	.string	"intr"
.LC41:
	.string	"system"
.LC42:
	.string	"callf"
.LC43:
	.string	"gtty"
.LC44:
	.string	"stty"
.LC45:
	.string	"argc"
.LC46:
	.string	"argv"
	.data
	.align 32
.LC48:
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
	leaq	.LC48(%rip), %rsi
	movl	$48, %ecx
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
	movdqa	.LC49(%rip), %xmm1
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
.LC52:
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
	leaq	.LC52(%rip), %rdi
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
.LC53:
	.string	"undefined internal name '%s' at %d:%d"
	.align 8
.LC54:
	.string	"'%s' is not a variable at %d:%d"
	.section	.rodata.str1.1
.LC55:
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
	je	.L163
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
.L166:
	addq	$1, %rbp
	cmpq	%rbp, %r12
	je	.L123
.L120:
	movq	0(%r13,%rbp,8), %r15
	movq	%r14, %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L166
	movq	(%rsp), %rdi
	movq	%r15, %rdx
	movq	%rbx, %rsi
	call	mark_global_reference
	movl	28(%r15), %eax
	testl	%eax, %eax
	je	.L133
	movq	8(%r15), %rdi
	leaq	.LC46(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L133
	movl	$1, 16(%rbx)
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
.L115:
	.cfi_restore_state
	cmpl	$32, 40(%rsi)
	je	.L167
.L116:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	leaq	.LC55(%rip), %rdi
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
.L114:
	.cfi_restore_state
	movq	(%rsp), %r14
	movq	40(%rsi), %rsi
	movq	%r14, %rdi
	call	sem_check_lvalue
	movq	48(%rbx), %rsi
	movq	%r14, %rdi
.L165:
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
.L167:
	.cfi_restore_state
	movq	48(%rsi), %rsi
	movq	(%rsp), %rdi
	jmp	.L165
	.p2align 4,,10
	.p2align 3
.L133:
	testl	$-3, (%r15)
	je	.L111
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	leaq	.LC54(%rip), %rdi
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
.L123:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L117
.L163:
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
	jne	.L168
.L124:
	testq	%r13, %r13
	je	.L128
.L126:
	xorl	%ebx, %ebx
	jmp	.L130
	.p2align 4,,10
	.p2align 3
.L169:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L128
.L130:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L169
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
.L170:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L131
.L132:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L170
	jmp	.L111
.L168:
	testq	%r13, %r13
	je	.L125
	xorl	%r15d, %r15d
	jmp	.L127
	.p2align 4,,10
	.p2align 3
.L171:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L125
.L127:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L171
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
	leaq	.LC53(%rip), %rdi
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
.LC56:
	.string	"'%s' is not callable at %d:%d"
	.text
	.p2align 4
	.type	sem_check_expr, @function
sem_check_expr:
.LFB33:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L257
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
	leaq	.L177(%rip), %r12
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
.L173:
	cmpl	$10, (%rbx)
	ja	.L172
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L177:
	.long	.L172-.L177
	.long	.L172-.L177
	.long	.L185-.L177
	.long	.L184-.L177
	.long	.L176-.L177
	.long	.L182-.L177
	.long	.L181-.L177
	.long	.L255-.L177
	.long	.L179-.L177
	.long	.L178-.L177
	.long	.L176-.L177
	.text
	.p2align 4,,10
	.p2align 3
.L184:
	movq	40(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L258
	movl	$1, 24(%rbx)
	movq	%rbp, %rdi
	call	sem_check_expr
.L211:
	xorl	%r12d, %r12d
	cmpq	$0, 56(%rbx)
	je	.L172
.L213:
	movq	48(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	56(%rbx), %r12
	jb	.L213
.L172:
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
.L176:
	.cfi_restore_state
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	48(%rbx), %rbx
.L214:
	testq	%rbx, %rbx
	jne	.L173
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L178:
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
.L255:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	56(%rbx), %rbx
	jmp	.L214
	.p2align 4,,10
	.p2align 3
.L179:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_lvalue
	movq	56(%rbx), %rbx
	jmp	.L214
	.p2align 4,,10
	.p2align 3
.L181:
	movq	48(%rbx), %rsi
.L256:
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
.L182:
	.cfi_restore_state
	movl	40(%rbx), %eax
	movq	48(%rbx), %rbx
	subl	$36, %eax
	cmpl	$1, %eax
	ja	.L214
	movq	%rbx, %rsi
	jmp	.L256
	.p2align 4,,10
	.p2align 3
.L185:
	movq	40(%rbx), %rax
	movq	%rax, (%rsp)
	movq	0(%rbp), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L190
.L186:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L192
	movq	8(%rsp), %rax
	xorl	%r14d, %r14d
	movq	8(%rax), %r13
	jmp	.L189
	.p2align 4,,10
	.p2align 3
.L259:
	addq	$1, %r14
	cmpq	%r14, %r12
	je	.L192
.L189:
	movq	0(%r13,%r14,8), %r15
	movq	(%rsp), %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L259
	movq	%r15, %rdx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	mark_global_reference
	movl	28(%r15), %eax
	testl	%eax, %eax
	je	.L194
	movq	8(%r15), %rdi
	leaq	.LC46(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
.L194:
	cmpl	$1, (%r15)
	movl	%eax, 16(%rbx)
	je	.L197
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
.L192:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L186
.L190:
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	mark_global_reference
	movq	24(%rbp), %r14
	movq	40(%rbx), %r13
	movq	$0, 12(%rbx)
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L195
	xorl	%r12d, %r12d
	jmp	.L196
	.p2align 4,,10
	.p2align 3
.L260:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L195
.L196:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L260
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L258:
	movq	0(%rbp), %rax
	movq	40(%rsi), %r12
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L203
.L202:
	movq	8(%rsp), %rax
	movq	16(%rax), %r13
	testq	%r13, %r13
	je	.L207
	movq	8(%rsp), %rax
	xorl	%r14d, %r14d
	movq	8(%rax), %rax
	movq	%rax, (%rsp)
	jmp	.L205
	.p2align 4,,10
	.p2align 3
.L261:
	addq	$1, %r14
	cmpq	%r13, %r14
	je	.L207
.L205:
	movq	(%rsp), %rax
	movq	%r12, %rsi
	movq	(%rax,%r14,8), %r15
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L261
	movl	(%r15), %eax
	cmpl	$1, %eax
	ja	.L262
.L217:
	testl	%eax, %eax
	jne	.L209
	movl	$1, 24(%rbx)
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	jmp	.L211
	.p2align 4,,10
	.p2align 3
.L207:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L202
.L203:
	movq	24(%rbp), %r14
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L208
	xorl	%r13d, %r13d
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L263:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L208
.L210:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L263
	.p2align 4
	.p2align 3
.L209:
	movl	$0, 24(%rbx)
	jmp	.L211
	.p2align 4,,10
	.p2align 3
.L197:
	xorl	$1, %eax
	movl	%eax, 12(%rbx)
	jmp	.L172
.L262:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	xorl	%eax, %eax
	movq	%r12, %rsi
	leaq	.LC56(%rip), %rdi
	call	dief@PLT
	movl	(%r15), %eax
	jmp	.L217
.L257:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L195:
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
	je	.L198
	xorl	%r12d, %r12d
	jmp	.L199
	.p2align 4,,10
	.p2align 3
.L264:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L198
.L199:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L264
	jmp	.L172
.L198:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L265
.L200:
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
.L208:
	.cfi_restore_state
	movq	%r12, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	$0, 24(%rbx)
	jmp	.L211
.L265:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC53(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	40(%rbx), %r13
	jmp	.L200
	.cfi_endproc
.LFE33:
	.size	sem_check_expr, .-sem_check_expr
	.p2align 4
	.type	sem_check_initializer, @function
sem_check_initializer:
.LFB39:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L297
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
	je	.L300
	testl	%eax, %eax
	jne	.L266
	movq	16(%rsi), %r14
	cmpl	$2, (%r14)
	je	.L301
.L272:
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
.L300:
	.cfi_restore_state
	cmpq	$0, 24(%rsi)
	je	.L266
	xorl	%r12d, %r12d
.L271:
	movq	16(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_initializer
	cmpq	24(%rbx), %r12
	jb	.L271
.L266:
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
.L297:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.p2align 4,,10
	.p2align 3
.L301:
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
	je	.L274
.L273:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L277
	movq	8(%rsp), %rax
	xorl	%ebx, %ebx
	movq	8(%rax), %r15
	.p2align 4
	.p2align 3
.L275:
	movq	(%r15,%rbx,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L272
	addq	$1, %rbx
	cmpq	%r12, %rbx
	jne	.L275
.L277:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L273
.L274:
	movq	24(%rbp), %r12
	movq	16(%rbp), %r15
	testq	%r12, %r12
	je	.L278
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L279:
	movq	(%r15,%rbx,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L272
	addq	$1, %rbx
	cmpq	%rbx, %r12
	jne	.L279
.L278:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L272
	.cfi_endproc
.LFE39:
	.size	sem_check_initializer, .-sem_check_initializer
	.section	.rodata.str1.8
	.align 8
.LC57:
	.string	"internal: cannot pop global scope"
	.align 8
.LC58:
	.string	"bcc: warning: case label falls through to another case label at %d:%d\n"
	.text
	.p2align 4
	.type	sem_check_stmt, @function
sem_check_stmt:
.LFB34:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L378
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
	leaq	.L307(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
.L304:
	cmpl	$12, (%rbx)
	ja	.L302
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L307:
	.long	.L302-.L307
	.long	.L316-.L307
	.long	.L315-.L307
	.long	.L314-.L307
	.long	.L313-.L307
	.long	.L312-.L307
	.long	.L309-.L307
	.long	.L310-.L307
	.long	.L302-.L307
	.long	.L302-.L307
	.long	.L309-.L307
	.long	.L381-.L307
	.long	.L306-.L307
	.text
	.p2align 4,,10
	.p2align 3
.L315:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L302
	.p2align 4
	.p2align 3
.L318:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbp
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L325
	xorl	%r15d, %r15d
	jmp	.L327
	.p2align 4,,10
	.p2align 3
.L383:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L325
.L327:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L383
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	movq	%rbp, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rbp
.L325:
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
	je	.L328
	movq	%r13, %rdi
	call	sem_check_expr
.L328:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L318
.L302:
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
.L309:
	.cfi_restore_state
	movq	16(%rbx), %rsi
.L382:
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
.L381:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L329:
	testq	%rbx, %rbx
	jne	.L304
	jmp	.L302
	.p2align 4,,10
	.p2align 3
.L310:
	leaq	16(%r13), %rax
	cmpq	$0, 24(%rbx)
	movq	$0, 8(%rsp)
	movq	%rax, 16(%rsp)
	je	.L302
	.p2align 4
	.p2align 3
.L317:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	24(%r13), %rbp
	movq	16(%r13), %r14
	movq	(%rax,%rcx,8), %r12
	testq	%rbp, %rbp
	je	.L330
	xorl	%r15d, %r15d
	jmp	.L332
	.p2align 4,,10
	.p2align 3
.L384:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L330
.L332:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L384
.L331:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L317
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
.L314:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%rbx), %rbx
	jmp	.L329
	.p2align 4,,10
	.p2align 3
.L313:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rbx
	jmp	.L329
	.p2align 4,,10
	.p2align 3
.L312:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L382
	jmp	.L302
	.p2align 4,,10
	.p2align 3
.L306:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %r14
	testq	%r14, %r14
	je	.L302
	cmpl	$1, (%r14)
	jne	.L341
	cmpq	$0, 24(%r14)
	je	.L341
	xorl	%ecx, %ecx
	xorl	%r12d, %r12d
	leaq	.LC58(%rip), %r15
	jmp	.L337
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L334:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	andl	%eax, %ecx
.L336:
	addq	$1, %r12
	cmpq	24(%r14), %r12
	jnb	.L381
.L337:
	movq	16(%r14), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	cmpl	$13, %eax
	jne	.L334
	testl	%ecx, %ecx
	jne	.L385
.L335:
	movl	$1, %ecx
	jmp	.L336
	.p2align 4,,10
	.p2align 3
.L316:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	je	.L386
	cmpq	$0, 24(%rbx)
	je	.L302
.L320:
	xorl	%ebp, %ebp
.L322:
	movq	16(%rbx), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_check_stmt
	cmpq	24(%rbx), %rbp
	jb	.L322
.L323:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L302
	movq	0(%r13), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L387
.L324:
	movq	%rax, 0(%r13)
	jmp	.L302
.L341:
	movq	%r14, %rbx
	jmp	.L304
	.p2align 4,,10
	.p2align 3
.L330:
	movq	%r12, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L331
.L385:
	movl	8(%rdx), %ecx
	movq	stderr(%rip), %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	movl	4(%rdx), %edx
	call	fprintf@PLT
	jmp	.L335
.L386:
	movl	$32, %edi
	movq	0(%r13), %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 16(%rax)
	cmpq	$0, 24(%rbx)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, 0(%r13)
	jne	.L320
	jmp	.L323
.L378:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L387:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	leaq	.LC57(%rip), %rdi
	call	dief@PLT
	movq	0(%r13), %rax
	movq	(%rax), %rax
	jmp	.L324
	.cfi_endproc
.LFE34:
	.size	sem_check_stmt, .-sem_check_stmt
	.section	.rodata.str1.8
	.align 8
.LC59:
	.string	"internal: TOP_GAUTO should be ST_AUTO"
	.align 8
.LC60:
	.string	"vector bound must be a constant expression in '%s'"
	.section	.rodata.str1.1
.LC61:
	.string	"negative vector bound in '%s'"
	.section	.rodata.str1.8
	.align 8
.LC63:
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
	je	.L413
	.p2align 4
	.p2align 3
.L389:
	movq	0(%r13), %rax
	movq	24(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L392
	ja	.L393
	testl	%edx, %edx
	je	.L516
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
	je	.L404
	xorl	%r15d, %r15d
	jmp	.L406
	.p2align 4,,10
	.p2align 3
.L517:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L404
.L406:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L517
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rbp
.L404:
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
.L397:
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8(%r13), %rax
	jb	.L389
.L413:
	cmpq	$0, 8+g_known_functions(%rip)
	movq	$0, 8(%rsp)
	je	.L391
	.p2align 4
	.p2align 3
.L390:
	leaq	g_known_functions(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L416
	xorl	%r15d, %r15d
	jmp	.L418
	.p2align 4,,10
	.p2align 3
.L518:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L416
.L418:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L518
.L417:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L390
.L391:
	cmpq	$0, 8+g_known_variables(%rip)
	movq	$0, 8(%rsp)
	je	.L415
	.p2align 4
	.p2align 3
.L414:
	leaq	g_known_variables(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %r12
	movq	(%rbx), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L421
	xorl	%r15d, %r15d
	jmp	.L423
	.p2align 4,,10
	.p2align 3
.L519:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L421
.L423:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L519
.L422:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_variables(%rip), %rax
	jb	.L414
.L415:
	movq	%rbx, %rdi
	call	sem_add_builtin_functions
	cmpq	$0, 8(%r13)
	movq	$0, 16(%rsp)
	jne	.L419
	jmp	.L420
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L426:
	addq	$1, 16(%rsp)
	movq	8(%r13), %rax
	movq	16(%rsp), %rcx
	cmpq	%rax, %rcx
	jnb	.L520
.L419:
	movq	0(%r13), %rax
	movq	16(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L426
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
	je	.L427
	movq	$0, 8(%rsp)
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L431:
	movq	24(%rsp), %rcx
	movq	8(%rax), %r14
	movq	8(%rcx), %rdx
	movq	8(%rsp), %rcx
	movq	(%rdx,%rcx,8), %rbp
	testq	%r12, %r12
	je	.L428
	xorl	%r15d, %r15d
	jmp	.L430
	.p2align 4,,10
	.p2align 3
.L521:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L428
.L430:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L521
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
.L428:
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
	jnb	.L427
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	jmp	.L431
	.p2align 4,,10
	.p2align 3
.L416:
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
	jmp	.L417
	.p2align 4,,10
	.p2align 3
.L421:
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
	movdqa	.LC62(%rip), %xmm6
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%rbx), %rax
	movups	%xmm6, 16(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L422
	.p2align 4,,10
	.p2align 3
.L393:
	cmpl	$3, %edx
	jne	.L397
	movq	8(%rax), %rax
	movq	16(%rax), %rdi
	call	sdup@PLT
	leaq	16(%rbx), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L397
	.p2align 4,,10
	.p2align 3
.L427:
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
	je	.L522
.L432:
	movq	%rax, (%rbx)
	jmp	.L426
	.p2align 4,,10
	.p2align 3
.L392:
	movq	8(%rax), %rax
	cmpl	$2, 24(%rax)
	movq	%rax, 8(%rsp)
	je	.L523
.L407:
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L410
	xorl	%r15d, %r15d
	jmp	.L412
	.p2align 4,,10
	.p2align 3
.L524:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L410
.L412:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L524
	movq	%rbp, %rsi
	xorl	%eax, %eax
	leaq	.LC63(%rip), %rdi
	call	dief@PLT
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
.L410:
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
	movdqa	.LC62(%rip), %xmm7
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	(%rbx), %rax
	movups	%xmm7, 16(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L397
	.p2align 4,,10
	.p2align 3
.L516:
	movq	8(%rax), %rax
	cmpl	$2, (%rax)
	movq	%rax, 16(%rsp)
	je	.L398
	leaq	.LC59(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L398:
	movq	$0, 8(%rsp)
	movq	16(%rsp), %rax
	cmpq	$0, 24(%rax)
	je	.L397
	.p2align 4
	.p2align 3
.L399:
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
	je	.L400
	xorl	%r15d, %r15d
	jmp	.L402
	.p2align 4,,10
	.p2align 3
.L525:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L400
.L402:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L525
	movq	16(%rsp), %rax
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	movl	8(%rax), %edx
	movl	4(%rax), %esi
	call	error_at_location@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rbp
.L400:
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
	jb	.L399
	jmp	.L397
.L420:
	movq	$0, 8(%rsp)
	cmpq	$0, 72(%rbx)
	je	.L425
	.p2align 4
	.p2align 3
.L424:
	movq	64(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %r15
	movq	(%rax,%rcx,8), %r12
	testq	%r15, %r15
	je	.L437
	movq	0(%r13), %r14
	xorl	%ebp, %ebp
	jmp	.L440
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L438:
	addq	$1, %rbp
	cmpq	%r15, %rbp
	je	.L437
.L440:
	movq	(%r14,%rbp,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L438
	movq	8(%rdx), %rax
	movq	%r12, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L438
.L439:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	72(%rbx), %rax
	jb	.L424
.L425:
	movq	$0, 8(%rsp)
	cmpq	$0, 96(%rbx)
	je	.L388
	.p2align 4
	.p2align 3
.L435:
	movq	88(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %rsi
	movq	0(%r13), %rdi
	movq	(%rax,%rcx,8), %rbp
	movq	%rbp, %rdx
	call	has_data_declaration.isra.0
	testl	%eax, %eax
	jne	.L441
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
	je	.L451
	xorl	%r15d, %r15d
	jmp	.L443
	.p2align 4,,10
	.p2align 3
.L526:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L451
.L443:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L526
.L442:
	movq	24(%rsp), %rcx
	movq	%r13, %rdi
	movl	%eax, 8(%rcx)
	movq	16(%rsp), %rax
	movl	$3, (%rax)
	movq	%rax, %rsi
	movq	%rcx, 8(%rax)
	call	vec_push@PLT
.L441:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	96(%rbx), %rax
	jb	.L435
.L388:
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
.L437:
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
	jmp	.L439
	.p2align 4,,10
	.p2align 3
.L451:
	movl	$1, %eax
	jmp	.L442
.L520:
	testq	%rax, %rax
	je	.L420
	xorl	%ebp, %ebp
	jmp	.L434
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L433:
	addq	$1, %rbp
	cmpq	8(%r13), %rbp
	jnb	.L420
.L434:
	movq	0(%r13), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L433
	movq	8(%rax), %rax
	movq	%rbx, %rdi
	movq	56(%rax), %rsi
	call	sem_check_initializer
	jmp	.L433
.L523:
	movq	32(%rax), %rdi
	testq	%rdi, %rdi
	je	.L407
	leaq	56(%rsp), %rsi
	call	try_eval_const_expr@PLT
	testl	%eax, %eax
	je	.L527
.L408:
	movq	56(%rsp), %rax
	testq	%rax, %rax
	js	.L528
.L409:
	movq	8(%rsp), %rcx
	movq	%rax, 48(%rcx)
	jmp	.L407
.L522:
	leaq	.LC57(%rip), %rdi
	call	dief@PLT
	movq	(%rbx), %rax
	movq	(%rax), %rax
	jmp	.L432
.L527:
	movq	8(%rsp), %rax
	leaq	.LC60(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L408
.L528:
	movq	8(%rsp), %rax
	leaq	.LC61(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	movq	56(%rsp), %rax
	jmp	.L409
	.cfi_endproc
.LFE40:
	.size	sem_check_program, .-sem_check_program
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC49:
	.long	0
	.long	0
	.long	0
	.long	1
	.align 16
.LC62:
	.long	0
	.long	0
	.long	1
	.long	0
	.section	.note.GNU-stack,"",@progbits
