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
	movdqa	.LC48(%rip), %xmm1
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
.LC51:
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
	leaq	.LC51(%rip), %rdi
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
	je	.L160
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
.L163:
	addq	$1, %rbp
	cmpq	%rbp, %r12
	je	.L123
.L120:
	movq	0(%r13,%rbp,8), %r15
	movq	%r14, %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L163
	movq	(%rsp), %rdi
	movq	%r15, %rdx
	movq	%rbx, %rsi
	call	mark_global_reference
	movl	28(%r15), %eax
	testl	%eax, %eax
	je	.L133
	movq	8(%r15), %rdi
	leaq	.LC45(%rip), %rsi
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
	je	.L164
.L116:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	addq	$24, %rsp
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
.L114:
	.cfi_restore_state
	movq	(%rsp), %r14
	movq	40(%rsi), %rsi
	movq	%r14, %rdi
	call	sem_check_lvalue
	movq	48(%rbx), %rsi
	movq	%r14, %rdi
.L162:
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
.L164:
	.cfi_restore_state
	movq	48(%rsi), %rsi
	movq	(%rsp), %rdi
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L133:
	movl	(%r15), %edx
	testl	%edx, %edx
	je	.L111
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	leaq	.LC53(%rip), %rdi
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
.L160:
	movq	(%rsp), %rdi
	xorl	%edx, %edx
	movq	%rbx, %rsi
	call	mark_global_reference
	movq	(%rsp), %rax
	movl	g_strict(%rip), %ecx
	movq	40(%rbx), %r12
	movq	16(%rax), %r14
	movq	24(%rax), %r13
	testl	%ecx, %ecx
	jne	.L165
.L124:
	testq	%r13, %r13
	je	.L128
.L126:
	xorl	%ebx, %ebx
	jmp	.L130
	.p2align 4,,10
	.p2align 3
.L166:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L128
.L130:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L166
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
.L167:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L131
.L132:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L167
	jmp	.L111
.L165:
	testq	%r13, %r13
	je	.L125
	xorl	%r15d, %r15d
	jmp	.L127
	.p2align 4,,10
	.p2align 3
.L168:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L125
.L127:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L168
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
	leaq	.LC52(%rip), %rdi
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
.LC55:
	.string	"'%s' is not callable at %d:%d"
	.text
	.p2align 4
	.type	sem_check_expr, @function
sem_check_expr:
.LFB33:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L254
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
	leaq	.L174(%rip), %r12
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
.L170:
	cmpl	$10, (%rbx)
	ja	.L169
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L174:
	.long	.L169-.L174
	.long	.L169-.L174
	.long	.L182-.L174
	.long	.L181-.L174
	.long	.L173-.L174
	.long	.L179-.L174
	.long	.L178-.L174
	.long	.L252-.L174
	.long	.L176-.L174
	.long	.L175-.L174
	.long	.L173-.L174
	.text
	.p2align 4,,10
	.p2align 3
.L181:
	movq	40(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L255
	movl	$1, 24(%rbx)
	movq	%rbp, %rdi
	call	sem_check_expr
.L208:
	xorl	%r12d, %r12d
	cmpq	$0, 56(%rbx)
	je	.L169
.L210:
	movq	48(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	56(%rbx), %r12
	jb	.L210
.L169:
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
.L173:
	.cfi_restore_state
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	48(%rbx), %rbx
.L211:
	testq	%rbx, %rbx
	jne	.L170
	jmp	.L169
	.p2align 4,,10
	.p2align 3
.L175:
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
.L252:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	56(%rbx), %rbx
	jmp	.L211
	.p2align 4,,10
	.p2align 3
.L176:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_lvalue
	movq	56(%rbx), %rbx
	jmp	.L211
	.p2align 4,,10
	.p2align 3
.L178:
	movq	48(%rbx), %rsi
.L253:
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
.L179:
	.cfi_restore_state
	movl	40(%rbx), %eax
	movq	48(%rbx), %rbx
	subl	$36, %eax
	cmpl	$1, %eax
	ja	.L211
	movq	%rbx, %rsi
	jmp	.L253
	.p2align 4,,10
	.p2align 3
.L182:
	movq	40(%rbx), %rax
	movq	%rax, (%rsp)
	movq	0(%rbp), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L187
.L183:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L189
	movq	8(%rsp), %rax
	xorl	%r14d, %r14d
	movq	8(%rax), %r13
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L256:
	addq	$1, %r14
	cmpq	%r14, %r12
	je	.L189
.L186:
	movq	0(%r13,%r14,8), %r15
	movq	(%rsp), %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L256
	movq	%r15, %rdx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	mark_global_reference
	movl	28(%r15), %eax
	testl	%eax, %eax
	je	.L191
	movq	8(%r15), %rdi
	leaq	.LC45(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
.L191:
	cmpl	$1, (%r15)
	movl	%eax, 16(%rbx)
	je	.L194
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
.L189:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L183
.L187:
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	mark_global_reference
	movq	24(%rbp), %r14
	movq	40(%rbx), %r13
	movq	$0, 12(%rbx)
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L192
	xorl	%r12d, %r12d
	jmp	.L193
	.p2align 4,,10
	.p2align 3
.L257:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L192
.L193:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L257
	jmp	.L169
	.p2align 4,,10
	.p2align 3
.L255:
	movq	0(%rbp), %rax
	movq	40(%rsi), %r12
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L200
.L199:
	movq	8(%rsp), %rax
	movq	16(%rax), %r13
	testq	%r13, %r13
	je	.L204
	movq	8(%rsp), %rax
	xorl	%r14d, %r14d
	movq	8(%rax), %rax
	movq	%rax, (%rsp)
	jmp	.L202
	.p2align 4,,10
	.p2align 3
.L258:
	addq	$1, %r14
	cmpq	%r13, %r14
	je	.L204
.L202:
	movq	(%rsp), %rax
	movq	%r12, %rsi
	movq	(%rax,%r14,8), %r15
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L258
	movl	(%r15), %eax
	cmpl	$1, %eax
	ja	.L259
.L214:
	testl	%eax, %eax
	jne	.L206
	movl	$1, 24(%rbx)
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	jmp	.L208
	.p2align 4,,10
	.p2align 3
.L204:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L199
.L200:
	movq	24(%rbp), %r14
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L205
	xorl	%r13d, %r13d
	jmp	.L207
	.p2align 4,,10
	.p2align 3
.L260:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L205
.L207:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L260
	.p2align 4
	.p2align 3
.L206:
	movl	$0, 24(%rbx)
	jmp	.L208
	.p2align 4,,10
	.p2align 3
.L194:
	xorl	$1, %eax
	movl	%eax, 12(%rbx)
	jmp	.L169
.L259:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	xorl	%eax, %eax
	movq	%r12, %rsi
	leaq	.LC55(%rip), %rdi
	call	dief@PLT
	movl	(%r15), %eax
	jmp	.L214
.L254:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L192:
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
	je	.L195
	xorl	%r12d, %r12d
	jmp	.L196
	.p2align 4,,10
	.p2align 3
.L261:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L195
.L196:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L261
	jmp	.L169
.L195:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L262
.L197:
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
.L205:
	.cfi_restore_state
	movq	%r12, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	$0, 24(%rbx)
	jmp	.L208
.L262:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC52(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	40(%rbx), %r13
	jmp	.L197
	.cfi_endproc
.LFE33:
	.size	sem_check_expr, .-sem_check_expr
	.p2align 4
	.type	sem_check_initializer, @function
sem_check_initializer:
.LFB39:
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
	je	.L297
	testl	%eax, %eax
	jne	.L263
	movq	16(%rsi), %r14
	cmpl	$2, (%r14)
	je	.L298
.L269:
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
.L297:
	.cfi_restore_state
	cmpq	$0, 24(%rsi)
	je	.L263
	xorl	%r12d, %r12d
.L268:
	movq	16(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_initializer
	cmpq	24(%rbx), %r12
	jb	.L268
.L263:
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
.L294:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.p2align 4,,10
	.p2align 3
.L298:
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
	je	.L271
.L270:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L274
	movq	8(%rsp), %rax
	xorl	%ebx, %ebx
	movq	8(%rax), %r15
	.p2align 4
	.p2align 3
.L272:
	movq	(%r15,%rbx,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L269
	addq	$1, %rbx
	cmpq	%r12, %rbx
	jne	.L272
.L274:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L270
.L271:
	movq	24(%rbp), %r12
	movq	16(%rbp), %r15
	testq	%r12, %r12
	je	.L275
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L276:
	movq	(%r15,%rbx,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L269
	addq	$1, %rbx
	cmpq	%rbx, %r12
	jne	.L276
.L275:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L269
	.cfi_endproc
.LFE39:
	.size	sem_check_initializer, .-sem_check_initializer
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
.LFB34:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L375
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
	leaq	.L304(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
.L301:
	cmpl	$12, (%rbx)
	ja	.L299
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L304:
	.long	.L299-.L304
	.long	.L313-.L304
	.long	.L312-.L304
	.long	.L311-.L304
	.long	.L310-.L304
	.long	.L309-.L304
	.long	.L306-.L304
	.long	.L307-.L304
	.long	.L299-.L304
	.long	.L299-.L304
	.long	.L306-.L304
	.long	.L378-.L304
	.long	.L303-.L304
	.text
	.p2align 4,,10
	.p2align 3
.L312:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L299
	.p2align 4
	.p2align 3
.L315:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbp
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L322
	xorl	%r15d, %r15d
	jmp	.L324
	.p2align 4,,10
	.p2align 3
.L380:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L322
.L324:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L380
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	movq	%rbp, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rbp
.L322:
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
	je	.L325
	movq	%r13, %rdi
	call	sem_check_expr
.L325:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L315
.L299:
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
.L306:
	.cfi_restore_state
	movq	16(%rbx), %rsi
.L379:
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
.L378:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L326:
	testq	%rbx, %rbx
	jne	.L301
	jmp	.L299
	.p2align 4,,10
	.p2align 3
.L307:
	leaq	16(%r13), %rax
	cmpq	$0, 24(%rbx)
	movq	$0, 8(%rsp)
	movq	%rax, 16(%rsp)
	je	.L299
	.p2align 4
	.p2align 3
.L314:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	24(%r13), %rbp
	movq	16(%r13), %r14
	movq	(%rax,%rcx,8), %r12
	testq	%rbp, %rbp
	je	.L327
	xorl	%r15d, %r15d
	jmp	.L329
	.p2align 4,,10
	.p2align 3
.L381:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L327
.L329:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L381
.L328:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L314
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
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%rbx), %rbx
	jmp	.L326
	.p2align 4,,10
	.p2align 3
.L310:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rbx
	jmp	.L326
	.p2align 4,,10
	.p2align 3
.L309:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L379
	jmp	.L299
	.p2align 4,,10
	.p2align 3
.L303:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %r14
	testq	%r14, %r14
	je	.L299
	cmpl	$1, (%r14)
	jne	.L338
	cmpq	$0, 24(%r14)
	je	.L338
	xorl	%ecx, %ecx
	xorl	%r12d, %r12d
	leaq	.LC57(%rip), %r15
	jmp	.L334
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L331:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	andl	%eax, %ecx
.L333:
	addq	$1, %r12
	cmpq	24(%r14), %r12
	jnb	.L378
.L334:
	movq	16(%r14), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	cmpl	$13, %eax
	jne	.L331
	testl	%ecx, %ecx
	jne	.L382
.L332:
	movl	$1, %ecx
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L313:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	je	.L383
	cmpq	$0, 24(%rbx)
	je	.L299
.L317:
	xorl	%ebp, %ebp
.L319:
	movq	16(%rbx), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_check_stmt
	cmpq	24(%rbx), %rbp
	jb	.L319
.L320:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L299
	movq	0(%r13), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L384
.L321:
	movq	%rax, 0(%r13)
	jmp	.L299
.L338:
	movq	%r14, %rbx
	jmp	.L301
	.p2align 4,,10
	.p2align 3
.L327:
	movq	%r12, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L328
.L382:
	movl	8(%rdx), %ecx
	movq	stderr(%rip), %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	movl	4(%rdx), %edx
	call	fprintf@PLT
	jmp	.L332
.L383:
	movl	$32, %edi
	movq	0(%r13), %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 16(%rax)
	cmpq	$0, 24(%rbx)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, 0(%r13)
	jne	.L317
	jmp	.L320
.L375:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L384:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	leaq	.LC56(%rip), %rdi
	call	dief@PLT
	movq	0(%r13), %rax
	movq	(%rax), %rax
	jmp	.L321
	.cfi_endproc
.LFE34:
	.size	sem_check_stmt, .-sem_check_stmt
	.section	.rodata.str1.8
	.align 8
.LC58:
	.string	"internal: TOP_GAUTO should be ST_AUTO"
	.align 8
.LC59:
	.string	"vector bound must be a constant expression in '%s'"
	.section	.rodata.str1.1
.LC60:
	.string	"negative vector bound in '%s'"
	.section	.rodata.str1.8
	.align 8
.LC62:
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
	je	.L410
	.p2align 4
	.p2align 3
.L386:
	movq	0(%r13), %rax
	movq	24(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L389
	ja	.L390
	testl	%edx, %edx
	je	.L513
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
	je	.L401
	xorl	%r15d, %r15d
	jmp	.L403
	.p2align 4,,10
	.p2align 3
.L514:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L401
.L403:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L514
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rbp
.L401:
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
.L394:
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8(%r13), %rax
	jb	.L386
.L410:
	cmpq	$0, 8+g_known_functions(%rip)
	movq	$0, 8(%rsp)
	je	.L388
	.p2align 4
	.p2align 3
.L387:
	leaq	g_known_functions(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L413
	xorl	%r15d, %r15d
	jmp	.L415
	.p2align 4,,10
	.p2align 3
.L515:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L413
.L415:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L515
.L414:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L387
.L388:
	cmpq	$0, 8+g_known_variables(%rip)
	movq	$0, 8(%rsp)
	je	.L412
	.p2align 4
	.p2align 3
.L411:
	leaq	g_known_variables(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %r12
	movq	(%rbx), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L418
	xorl	%r15d, %r15d
	jmp	.L420
	.p2align 4,,10
	.p2align 3
.L516:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L418
.L420:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L516
.L419:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_variables(%rip), %rax
	jb	.L411
.L412:
	movq	%rbx, %rdi
	call	sem_add_builtin_functions
	cmpq	$0, 8(%r13)
	movq	$0, 16(%rsp)
	jne	.L416
	jmp	.L417
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L423:
	addq	$1, 16(%rsp)
	movq	8(%r13), %rax
	movq	16(%rsp), %rcx
	cmpq	%rax, %rcx
	jnb	.L517
.L416:
	movq	0(%r13), %rax
	movq	16(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L423
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
	je	.L424
	movq	$0, 8(%rsp)
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L428:
	movq	24(%rsp), %rcx
	movq	8(%rax), %r14
	movq	8(%rcx), %rdx
	movq	8(%rsp), %rcx
	movq	(%rdx,%rcx,8), %rbp
	testq	%r12, %r12
	je	.L425
	xorl	%r15d, %r15d
	jmp	.L427
	.p2align 4,,10
	.p2align 3
.L518:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L425
.L427:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L518
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
.L425:
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
	jnb	.L424
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	jmp	.L428
	.p2align 4,,10
	.p2align 3
.L413:
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
	jmp	.L414
	.p2align 4,,10
	.p2align 3
.L418:
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
	movdqa	.LC61(%rip), %xmm6
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	(%rbx), %rax
	movups	%xmm6, 16(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L419
	.p2align 4,,10
	.p2align 3
.L390:
	cmpl	$3, %edx
	jne	.L394
	movq	8(%rax), %rax
	movq	16(%rax), %rdi
	call	sdup@PLT
	leaq	16(%rbx), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L394
	.p2align 4,,10
	.p2align 3
.L424:
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
	je	.L519
.L429:
	movq	%rax, (%rbx)
	jmp	.L423
	.p2align 4,,10
	.p2align 3
.L389:
	movq	8(%rax), %rax
	cmpl	$2, 24(%rax)
	movq	%rax, 8(%rsp)
	je	.L520
.L404:
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L407
	xorl	%r15d, %r15d
	jmp	.L409
	.p2align 4,,10
	.p2align 3
.L521:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L407
.L409:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L521
	movq	%rbp, %rsi
	xorl	%eax, %eax
	leaq	.LC62(%rip), %rdi
	call	dief@PLT
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
.L407:
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
	movdqa	.LC61(%rip), %xmm7
	movq	%r12, %rsi
	movq	%rax, 8(%r12)
	movq	(%rbx), %rax
	movups	%xmm7, 16(%r12)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L394
	.p2align 4,,10
	.p2align 3
.L513:
	movq	8(%rax), %rax
	cmpl	$2, (%rax)
	movq	%rax, 16(%rsp)
	je	.L395
	leaq	.LC58(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L395:
	movq	$0, 8(%rsp)
	movq	16(%rsp), %rax
	cmpq	$0, 24(%rax)
	je	.L394
	.p2align 4
	.p2align 3
.L396:
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
	je	.L397
	xorl	%r15d, %r15d
	jmp	.L399
	.p2align 4,,10
	.p2align 3
.L522:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L397
.L399:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L522
	movq	16(%rsp), %rax
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	movl	8(%rax), %edx
	movl	4(%rax), %esi
	call	error_at_location@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rbp
.L397:
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
	jb	.L396
	jmp	.L394
.L417:
	movq	$0, 8(%rsp)
	cmpq	$0, 72(%rbx)
	je	.L422
	.p2align 4
	.p2align 3
.L421:
	movq	64(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %r15
	movq	(%rax,%rcx,8), %r12
	testq	%r15, %r15
	je	.L434
	movq	0(%r13), %r14
	xorl	%ebp, %ebp
	jmp	.L437
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L435:
	addq	$1, %rbp
	cmpq	%r15, %rbp
	je	.L434
.L437:
	movq	(%r14,%rbp,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L435
	movq	8(%rdx), %rax
	movq	%r12, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L435
.L436:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	72(%rbx), %rax
	jb	.L421
.L422:
	movq	$0, 8(%rsp)
	cmpq	$0, 96(%rbx)
	je	.L385
	.p2align 4
	.p2align 3
.L432:
	movq	88(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %rsi
	movq	0(%r13), %rdi
	movq	(%rax,%rcx,8), %rbp
	movq	%rbp, %rdx
	call	has_data_declaration.isra.0
	testl	%eax, %eax
	jne	.L438
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
	je	.L448
	xorl	%r15d, %r15d
	jmp	.L440
	.p2align 4,,10
	.p2align 3
.L523:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L448
.L440:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L523
.L439:
	movq	24(%rsp), %rcx
	movq	%r13, %rdi
	movl	%eax, 8(%rcx)
	movq	16(%rsp), %rax
	movl	$3, (%rax)
	movq	%rax, %rsi
	movq	%rcx, 8(%rax)
	call	vec_push@PLT
.L438:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	96(%rbx), %rax
	jb	.L432
.L385:
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
.L434:
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
	jmp	.L436
	.p2align 4,,10
	.p2align 3
.L448:
	movl	$1, %eax
	jmp	.L439
.L517:
	testq	%rax, %rax
	je	.L417
	xorl	%ebp, %ebp
	jmp	.L431
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L430:
	addq	$1, %rbp
	cmpq	8(%r13), %rbp
	jnb	.L417
.L431:
	movq	0(%r13), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L430
	movq	8(%rax), %rax
	movq	%rbx, %rdi
	movq	56(%rax), %rsi
	call	sem_check_initializer
	jmp	.L430
.L520:
	movq	32(%rax), %rdi
	testq	%rdi, %rdi
	je	.L404
	leaq	56(%rsp), %rsi
	call	try_eval_const_expr@PLT
	testl	%eax, %eax
	je	.L524
.L405:
	movq	56(%rsp), %rax
	testq	%rax, %rax
	js	.L525
.L406:
	movq	8(%rsp), %rcx
	movq	%rax, 48(%rcx)
	jmp	.L404
.L519:
	leaq	.LC56(%rip), %rdi
	call	dief@PLT
	movq	(%rbx), %rax
	movq	(%rax), %rax
	jmp	.L429
.L524:
	movq	8(%rsp), %rax
	leaq	.LC59(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L405
.L525:
	movq	8(%rsp), %rax
	leaq	.LC60(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	movq	56(%rsp), %rax
	jmp	.L406
	.cfi_endproc
.LFE40:
	.size	sem_check_program, .-sem_check_program
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC48:
	.long	0
	.long	0
	.long	0
	.long	1
	.align 16
.LC61:
	.long	0
	.long	0
	.long	1
	.long	0
	.section	.note.GNU-stack,"",@progbits
