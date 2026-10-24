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
	je	.L31
	movq	32(%rdx), %rax
	movl	(%rdx), %r10d
	movq	%rax, 32(%rsi)
	testl	%r10d, %r10d
	jne	.L71
	movl	24(%rdx), %edi
	testl	%edi, %edi
	je	.L42
	movl	$1, 20(%rsi)
	movq	48(%rsi), %rbp
.L43:
	movq	96(%r12), %r13
	movq	88(%r12), %r14
	testq	%r13, %r13
	je	.L50
	xorl	%ebx, %ebx
	jmp	.L51
	.p2align 4,,10
	.p2align 3
.L72:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L50
.L51:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L72
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
.L71:
	.cfi_restore_state
	movl	20(%rsi), %r9d
	testl	%r9d, %r9d
	je	.L30
	movl	24(%rdx), %edx
	movq	48(%rsi), %rbp
	testl	%edx, %edx
	jne	.L43
	movq	24(%rdi), %r13
	movq	16(%rdi), %r14
.L48:
	testq	%r13, %r13
	je	.L30
.L39:
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L49:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L43
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
.L42:
	.cfi_restore_state
	movl	20(%rsi), %ecx
	testl	%ecx, %ecx
	je	.L30
	movq	48(%rsi), %rbp
	movq	24(%r12), %r13
	movq	16(%r12), %r14
	jmp	.L48
	.p2align 4,,10
	.p2align 3
.L31:
	movq	48(%rsi), %rbp
	movq	16(%rdi), %r14
	movq	$0, 32(%rsi)
	movq	24(%rdi), %r13
	testq	%r13, %r13
	je	.L35
	xorl	%r15d, %r15d
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L74:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L73
.L37:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L74
	movq	48(%r12), %rax
	movq	40(%r12), %rcx
	xorl	%r15d, %r15d
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L40
	jmp	.L41
	.p2align 4,,10
	.p2align 3
.L75:
	addq	$1, %r15
	cmpq	%r15, 8(%rsp)
	movq	(%rsp), %rcx
	je	.L41
.L40:
	movq	(%rcx,%r15,8), %rdi
	movq	%rbp, %rsi
	movq	%rcx, (%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L75
.L44:
	movl	20(%rbx), %eax
	testl	%eax, %eax
	jne	.L39
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
.L73:
	.cfi_restore_state
	movl	g_strict(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L44
	movl	$1, 20(%rbx)
	jmp	.L39
.L41:
	movq	112(%r12), %rax
	movq	%rbp, %rdx
	movq	8(%rax), %rsi
	movq	(%rax), %rdi
	call	has_data_declaration.isra.0
	movl	%eax, %edx
	movl	$2, %eax
	subl	%edx, %eax
	movl	%eax, 20(%rbx)
	jmp	.L39
.L35:
	movl	g_strict(%rip), %esi
	testl	%esi, %esi
	jne	.L30
	movl	$1, 20(%rbx)
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
	je	.L105
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.L81(%rip), %r14
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
.L78:
	cmpl	$12, (%rbx)
	ja	.L76
	movl	(%rbx), %eax
	movslq	(%r14,%rax,4), %rax
	addq	%r14, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L81:
	.long	.L76-.L81
	.long	.L85-.L81
	.long	.L76-.L81
	.long	.L84-.L81
	.long	.L80-.L81
	.long	.L76-.L81
	.long	.L76-.L81
	.long	.L76-.L81
	.long	.L76-.L81
	.long	.L76-.L81
	.long	.L76-.L81
	.long	.L82-.L81
	.long	.L80-.L81
	.text
	.p2align 4,,10
	.p2align 3
.L85:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L76
.L86:
	movq	16(%rbx), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_collect_labels
	cmpq	24(%rbx), %rbp
	jb	.L86
.L76:
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
.L80:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L90:
	testq	%rbx, %rbx
	jne	.L78
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
.L82:
	.cfi_restore_state
	movq	(%r12), %rax
	movq	16(%rbx), %r13
	movq	8(%rax), %r15
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L87
	xorl	%ebp, %ebp
	jmp	.L89
	.p2align 4,,10
	.p2align 3
.L109:
	addq	$1, %rbp
	cmpq	%rbp, 8(%rsp)
	je	.L87
.L89:
	movq	(%r15,%rbp,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L109
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC56(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r13
.L87:
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
	jmp	.L90
	.p2align 4,,10
	.p2align 3
.L84:
	movq	24(%rbx), %rsi
	movq	%r12, %rdi
	call	sem_collect_labels
	movq	32(%rbx), %rbx
	jmp	.L90
	.p2align 4,,10
	.p2align 3
.L105:
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
	je	.L110
	movl	(%rsi), %eax
	movq	%rsi, %rbx
	cmpl	$4, %eax
	je	.L113
	cmpl	$5, %eax
	je	.L114
	cmpl	$2, %eax
	jne	.L115
	movq	(%rdi), %rax
	movq	48(%rsi), %r14
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L169
.L116:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L122
	movq	8(%rsp), %rax
	xorl	%ebp, %ebp
	movq	8(%rax), %r13
	jmp	.L119
	.p2align 4,,10
	.p2align 3
.L173:
	addq	$1, %rbp
	cmpq	%r12, %rbp
	je	.L122
.L119:
	movq	0(%r13,%rbp,8), %r15
	movq	%r14, %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L173
	movq	(%rsp), %rdi
	movq	%r15, %rdx
	movq	%rbx, %rsi
	call	mark_global_reference
	movl	28(%r15), %eax
	testl	%eax, %eax
	je	.L174
	movq	8(%r15), %rdi
	leaq	.LC50(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L175
	movl	(%r15), %eax
	cmpl	$1, %eax
	jne	.L134
.L135:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	leaq	.LC58(%rip), %rdi
	xorl	%eax, %eax
	movq	48(%rbx), %rsi
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
.L114:
	.cfi_restore_state
	cmpl	$32, 48(%rsi)
	je	.L176
.L115:
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
.L174:
	.cfi_restore_state
	movl	(%r15), %eax
	cmpl	$1, %eax
	je	.L177
.L134:
	andl	$-3, %eax
	jne	.L135
.L110:
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
	movq	(%rsp), %r14
	movq	48(%rsi), %rsi
	movq	%r14, %rdi
	call	sem_check_expr
	movq	56(%rbx), %rsi
	movq	%r14, %rdi
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
	jmp	sem_check_expr
	.p2align 4,,10
	.p2align 3
.L176:
	.cfi_restore_state
	movq	56(%rsi), %rsi
	movq	(%rsp), %rdi
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L122:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L116
.L169:
	movq	(%rsp), %rdi
	xorl	%edx, %edx
	movq	%rbx, %rsi
	call	mark_global_reference
	movq	(%rsp), %rax
	movl	g_strict(%rip), %edx
	movq	48(%rbx), %r12
	movq	16(%rax), %r14
	movq	24(%rax), %r13
	testl	%edx, %edx
	jne	.L178
.L123:
	testq	%r13, %r13
	je	.L127
.L125:
	xorl	%ebx, %ebx
	jmp	.L129
	.p2align 4,,10
	.p2align 3
.L179:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L127
.L129:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L179
	jmp	.L110
	.p2align 4,,10
	.p2align 3
.L175:
	movl	$1, 16(%rbx)
	jmp	.L110
.L177:
	movl	$1, 12(%rbx)
	jmp	.L110
.L127:
	movq	(%rsp), %rax
	movq	72(%rax), %r13
	movq	64(%rax), %r14
	testq	%r13, %r13
	je	.L130
	xorl	%ebx, %ebx
	jmp	.L131
	.p2align 4,,10
	.p2align 3
.L180:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L130
.L131:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L180
	jmp	.L110
.L178:
	testq	%r13, %r13
	je	.L124
	xorl	%r15d, %r15d
	jmp	.L126
	.p2align 4,,10
	.p2align 3
.L181:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L124
.L126:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L181
	jmp	.L125
.L130:
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
.L124:
	.cfi_restore_state
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r12, %rsi
	xorl	%eax, %eax
	leaq	.LC57(%rip), %rdi
	call	dief@PLT
	movq	(%rsp), %rax
	movq	48(%rbx), %r12
	movq	16(%rax), %r14
	movq	24(%rax), %r13
	jmp	.L123
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
	je	.L272
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
	leaq	.L187(%rip), %r12
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
.L183:
	cmpl	$10, (%rbx)
	ja	.L182
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L187:
	.long	.L182-.L187
	.long	.L182-.L187
	.long	.L195-.L187
	.long	.L194-.L187
	.long	.L186-.L187
	.long	.L192-.L187
	.long	.L191-.L187
	.long	.L270-.L187
	.long	.L189-.L187
	.long	.L188-.L187
	.long	.L186-.L187
	.text
	.p2align 4,,10
	.p2align 3
.L194:
	movq	48(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L273
	movl	$1, 24(%rbx)
	movq	%rbp, %rdi
	call	sem_check_expr
.L221:
	xorl	%r12d, %r12d
	cmpq	$0, 64(%rbx)
	je	.L182
.L223:
	movq	56(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	64(%rbx), %r12
	jb	.L223
.L182:
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
.L186:
	.cfi_restore_state
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	56(%rbx), %rbx
.L224:
	testq	%rbx, %rbx
	jne	.L183
	jmp	.L182
	.p2align 4,,10
	.p2align 3
.L188:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
.L270:
	movq	56(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	64(%rbx), %rbx
	jmp	.L224
	.p2align 4,,10
	.p2align 3
.L189:
	movq	56(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_lvalue
	movq	64(%rbx), %rbx
	jmp	.L224
	.p2align 4,,10
	.p2align 3
.L191:
	movq	56(%rbx), %rsi
.L271:
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
.L192:
	.cfi_restore_state
	movl	48(%rbx), %eax
	movq	56(%rbx), %rbx
	leal	-36(%rax), %edx
	cmpl	$1, %edx
	jbe	.L230
	cmpl	$53, %eax
	jne	.L224
.L230:
	movq	%rbx, %rsi
	jmp	.L271
	.p2align 4,,10
	.p2align 3
.L195:
	movq	48(%rbx), %rax
	movq	%rax, (%rsp)
	movq	0(%rbp), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L200
.L196:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L202
	movq	8(%rsp), %rax
	xorl	%r14d, %r14d
	movq	8(%rax), %r13
	jmp	.L199
	.p2align 4,,10
	.p2align 3
.L274:
	addq	$1, %r14
	cmpq	%r14, %r12
	je	.L202
.L199:
	movq	0(%r13,%r14,8), %r15
	movq	(%rsp), %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L274
	movq	%r15, %rdx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	mark_global_reference
	movl	28(%r15), %eax
	testl	%eax, %eax
	je	.L204
	movq	8(%r15), %rdi
	leaq	.LC50(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
.L204:
	cmpl	$1, (%r15)
	movl	%eax, 16(%rbx)
	je	.L207
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
.L202:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L196
.L200:
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	mark_global_reference
	movq	24(%rbp), %r14
	movq	48(%rbx), %r13
	movq	$0, 12(%rbx)
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L205
	xorl	%r12d, %r12d
	jmp	.L206
	.p2align 4,,10
	.p2align 3
.L275:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L205
.L206:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L275
	jmp	.L182
	.p2align 4,,10
	.p2align 3
.L273:
	movq	0(%rbp), %rax
	movq	48(%rsi), %r12
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L213
.L212:
	movq	8(%rsp), %rax
	movq	16(%rax), %r13
	testq	%r13, %r13
	je	.L217
	movq	8(%rsp), %rax
	xorl	%r14d, %r14d
	movq	8(%rax), %rax
	movq	%rax, (%rsp)
	jmp	.L215
	.p2align 4,,10
	.p2align 3
.L276:
	addq	$1, %r14
	cmpq	%r13, %r14
	je	.L217
.L215:
	movq	(%rsp), %rax
	movq	%r12, %rsi
	movq	(%rax,%r14,8), %r15
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L276
	movl	(%r15), %eax
	cmpl	$1, %eax
	ja	.L277
.L228:
	testl	%eax, %eax
	jne	.L219
	movl	$1, 24(%rbx)
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	jmp	.L221
	.p2align 4,,10
	.p2align 3
.L217:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L212
.L213:
	movq	24(%rbp), %r14
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L218
	xorl	%r13d, %r13d
	jmp	.L220
	.p2align 4,,10
	.p2align 3
.L278:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L218
.L220:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L278
	.p2align 4
	.p2align 3
.L219:
	movl	$0, 24(%rbx)
	jmp	.L221
	.p2align 4,,10
	.p2align 3
.L207:
	xorl	$1, %eax
	movl	%eax, 12(%rbx)
	jmp	.L182
.L277:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	xorl	%eax, %eax
	movq	%r12, %rsi
	leaq	.LC60(%rip), %rdi
	call	dief@PLT
	movl	(%r15), %eax
	jmp	.L228
.L272:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L205:
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
	je	.L208
	xorl	%r12d, %r12d
	jmp	.L209
	.p2align 4,,10
	.p2align 3
.L279:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L208
.L209:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L279
	jmp	.L182
.L208:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L280
.L210:
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
.L218:
	.cfi_restore_state
	movq	%r12, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movl	$0, 24(%rbx)
	jmp	.L221
.L280:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC57(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	48(%rbx), %r13
	jmp	.L210
	.cfi_endproc
.LFE33:
	.size	sem_check_expr, .-sem_check_expr
	.p2align 4
	.type	sem_check_initializer, @function
sem_check_initializer:
.LFB39:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L312
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
	je	.L315
	testl	%eax, %eax
	jne	.L281
	movq	16(%rsi), %r14
	cmpl	$2, (%r14)
	je	.L316
.L287:
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
.L315:
	.cfi_restore_state
	cmpq	$0, 24(%rsi)
	je	.L281
	xorl	%r12d, %r12d
.L286:
	movq	16(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_initializer
	cmpq	24(%rbx), %r12
	jb	.L286
.L281:
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
.L312:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.p2align 4,,10
	.p2align 3
.L316:
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
	je	.L289
.L288:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L292
	movq	8(%rsp), %rax
	xorl	%ebx, %ebx
	movq	8(%rax), %r15
	.p2align 4
	.p2align 3
.L290:
	movq	(%r15,%rbx,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L287
	addq	$1, %rbx
	cmpq	%r12, %rbx
	jne	.L290
.L292:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L288
.L289:
	movq	24(%rbp), %r12
	movq	16(%rbp), %r15
	testq	%r12, %r12
	je	.L293
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L294:
	movq	(%r15,%rbx,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L287
	addq	$1, %rbx
	cmpq	%rbx, %r12
	jne	.L294
.L293:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L287
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
	je	.L393
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
	leaq	.L322(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
.L319:
	cmpl	$12, (%rbx)
	ja	.L317
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L322:
	.long	.L317-.L322
	.long	.L331-.L322
	.long	.L330-.L322
	.long	.L329-.L322
	.long	.L328-.L322
	.long	.L327-.L322
	.long	.L324-.L322
	.long	.L325-.L322
	.long	.L317-.L322
	.long	.L317-.L322
	.long	.L324-.L322
	.long	.L396-.L322
	.long	.L321-.L322
	.text
	.p2align 4,,10
	.p2align 3
.L330:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L317
	.p2align 4
	.p2align 3
.L333:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbp
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L340
	xorl	%r15d, %r15d
	jmp	.L342
	.p2align 4,,10
	.p2align 3
.L398:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L340
.L342:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L398
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	movq	%rbp, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rbp
.L340:
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
	je	.L343
	movq	%r13, %rdi
	call	sem_check_expr
.L343:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L333
.L317:
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
.L324:
	.cfi_restore_state
	movq	16(%rbx), %rsi
.L397:
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
.L396:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L344:
	testq	%rbx, %rbx
	jne	.L319
	jmp	.L317
	.p2align 4,,10
	.p2align 3
.L325:
	leaq	16(%r13), %rax
	cmpq	$0, 24(%rbx)
	movq	$0, 8(%rsp)
	movq	%rax, 16(%rsp)
	je	.L317
	.p2align 4
	.p2align 3
.L332:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	24(%r13), %rbp
	movq	16(%r13), %r14
	movq	(%rax,%rcx,8), %r12
	testq	%rbp, %rbp
	je	.L345
	xorl	%r15d, %r15d
	jmp	.L347
	.p2align 4,,10
	.p2align 3
.L399:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L345
.L347:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L399
.L346:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L332
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
.L329:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%rbx), %rbx
	jmp	.L344
	.p2align 4,,10
	.p2align 3
.L328:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rbx
	jmp	.L344
	.p2align 4,,10
	.p2align 3
.L327:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L397
	jmp	.L317
	.p2align 4,,10
	.p2align 3
.L321:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %r14
	testq	%r14, %r14
	je	.L317
	cmpl	$1, (%r14)
	jne	.L356
	cmpq	$0, 24(%r14)
	je	.L356
	xorl	%ecx, %ecx
	xorl	%r12d, %r12d
	leaq	.LC62(%rip), %r15
	jmp	.L352
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L349:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	andl	%eax, %ecx
.L351:
	addq	$1, %r12
	cmpq	24(%r14), %r12
	jnb	.L396
.L352:
	movq	16(%r14), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	cmpl	$13, %eax
	jne	.L349
	testl	%ecx, %ecx
	jne	.L400
.L350:
	movl	$1, %ecx
	jmp	.L351
	.p2align 4,,10
	.p2align 3
.L331:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	je	.L401
	cmpq	$0, 24(%rbx)
	je	.L317
.L335:
	xorl	%ebp, %ebp
.L337:
	movq	16(%rbx), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_check_stmt
	cmpq	24(%rbx), %rbp
	jb	.L337
.L338:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L317
	movq	0(%r13), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L402
.L339:
	movq	%rax, 0(%r13)
	jmp	.L317
.L356:
	movq	%r14, %rbx
	jmp	.L319
	.p2align 4,,10
	.p2align 3
.L345:
	movq	%r12, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L346
.L400:
	movl	8(%rdx), %ecx
	movq	stderr(%rip), %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	movl	4(%rdx), %edx
	call	fprintf@PLT
	jmp	.L350
.L401:
	movl	$32, %edi
	movq	0(%r13), %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 16(%rax)
	cmpq	$0, 24(%rbx)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, 0(%r13)
	jne	.L335
	jmp	.L338
.L393:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L402:
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
	jmp	.L339
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
	je	.L428
	.p2align 4
	.p2align 3
.L404:
	movq	0(%r13), %rax
	movq	24(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L407
	ja	.L408
	testl	%edx, %edx
	je	.L531
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
	je	.L419
	xorl	%r15d, %r15d
	jmp	.L421
	.p2align 4,,10
	.p2align 3
.L532:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L419
.L421:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L532
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rbp
.L419:
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
.L412:
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8(%r13), %rax
	jb	.L404
.L428:
	cmpq	$0, 8+g_known_functions(%rip)
	movq	$0, 8(%rsp)
	je	.L406
	.p2align 4
	.p2align 3
.L405:
	leaq	g_known_functions(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L431
	xorl	%r15d, %r15d
	jmp	.L433
	.p2align 4,,10
	.p2align 3
.L533:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L431
.L433:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L533
.L432:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_functions(%rip), %rax
	jb	.L405
.L406:
	cmpq	$0, 8+g_known_variables(%rip)
	movq	$0, 8(%rsp)
	je	.L430
	.p2align 4
	.p2align 3
.L429:
	leaq	g_known_variables(%rip), %rax
	movq	8(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %r12
	movq	(%rbx), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L436
	xorl	%r15d, %r15d
	jmp	.L438
	.p2align 4,,10
	.p2align 3
.L534:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L436
.L438:
	movq	(%r14,%r15,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L534
.L437:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	8+g_known_variables(%rip), %rax
	jb	.L429
.L430:
	movq	%rbx, %rdi
	call	sem_add_builtin_functions
	cmpq	$0, 8(%r13)
	movq	$0, 16(%rsp)
	jne	.L434
	jmp	.L435
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L441:
	addq	$1, 16(%rsp)
	movq	8(%r13), %rax
	movq	16(%rsp), %rcx
	cmpq	%rax, %rcx
	jnb	.L535
.L434:
	movq	0(%r13), %rax
	movq	16(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L441
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
	je	.L442
	movq	$0, 8(%rsp)
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L446:
	movq	24(%rsp), %rcx
	movq	8(%rax), %r14
	movq	8(%rcx), %rdx
	movq	8(%rsp), %rcx
	movq	(%rdx,%rcx,8), %rbp
	testq	%r12, %r12
	je	.L443
	xorl	%r15d, %r15d
	jmp	.L445
	.p2align 4,,10
	.p2align 3
.L536:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L443
.L445:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L536
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
.L443:
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
	jnb	.L442
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	jmp	.L446
	.p2align 4,,10
	.p2align 3
.L431:
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
	jmp	.L432
	.p2align 4,,10
	.p2align 3
.L436:
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
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L408:
	cmpl	$3, %edx
	jne	.L412
	movq	8(%rax), %rax
	movq	16(%rax), %rdi
	call	sdup@PLT
	leaq	16(%rbx), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L412
	.p2align 4,,10
	.p2align 3
.L442:
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
	je	.L537
.L447:
	movq	%rax, (%rbx)
	jmp	.L441
	.p2align 4,,10
	.p2align 3
.L407:
	movq	8(%rax), %rax
	cmpl	$2, 24(%rax)
	movq	%rax, 8(%rsp)
	je	.L538
.L422:
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
	movq	(%rbx), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L425
	xorl	%r15d, %r15d
	jmp	.L427
	.p2align 4,,10
	.p2align 3
.L539:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L425
.L427:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L539
	movq	%rbp, %rsi
	xorl	%eax, %eax
	leaq	.LC67(%rip), %rdi
	call	dief@PLT
	movq	8(%rsp), %rax
	movq	16(%rax), %rbp
.L425:
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
	jmp	.L412
	.p2align 4,,10
	.p2align 3
.L531:
	movq	8(%rax), %rax
	cmpl	$2, (%rax)
	movq	%rax, 16(%rsp)
	je	.L413
	leaq	.LC63(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L413:
	movq	$0, 8(%rsp)
	movq	16(%rsp), %rax
	cmpq	$0, 24(%rax)
	je	.L412
	.p2align 4
	.p2align 3
.L414:
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
	je	.L415
	xorl	%r15d, %r15d
	jmp	.L417
	.p2align 4,,10
	.p2align 3
.L540:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L415
.L417:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L540
	movq	16(%rsp), %rax
	movq	8(%rbx), %rdi
	movq	%rbp, %r8
	movl	$10, %ecx
	movl	8(%rax), %edx
	movl	4(%rax), %esi
	call	error_at_location@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rbp
.L415:
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
	jb	.L414
	jmp	.L412
.L435:
	movq	$0, 8(%rsp)
	cmpq	$0, 72(%rbx)
	je	.L440
	.p2align 4
	.p2align 3
.L439:
	movq	64(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %r15
	movq	(%rax,%rcx,8), %r12
	testq	%r15, %r15
	je	.L452
	movq	0(%r13), %r14
	xorl	%ebp, %ebp
	jmp	.L455
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L453:
	addq	$1, %rbp
	cmpq	%r15, %rbp
	je	.L452
.L455:
	movq	(%r14,%rbp,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L453
	movq	8(%rdx), %rax
	movq	%r12, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L453
.L454:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	72(%rbx), %rax
	jb	.L439
.L440:
	movq	$0, 8(%rsp)
	cmpq	$0, 96(%rbx)
	je	.L403
	.p2align 4
	.p2align 3
.L450:
	movq	88(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	8(%r13), %rsi
	movq	0(%r13), %rdi
	movq	(%rax,%rcx,8), %rbp
	movq	%rbp, %rdx
	call	has_data_declaration.isra.0
	testl	%eax, %eax
	jne	.L456
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
	je	.L466
	xorl	%r15d, %r15d
	jmp	.L458
	.p2align 4,,10
	.p2align 3
.L541:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L466
.L458:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L541
.L457:
	movq	24(%rsp), %rcx
	movq	%r13, %rdi
	movl	%eax, 8(%rcx)
	movq	16(%rsp), %rax
	movl	$3, (%rax)
	movq	%rax, %rsi
	movq	%rcx, 8(%rax)
	call	vec_push@PLT
.L456:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	96(%rbx), %rax
	jb	.L450
.L403:
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
.L452:
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
	jmp	.L454
	.p2align 4,,10
	.p2align 3
.L466:
	movl	$1, %eax
	jmp	.L457
.L535:
	testq	%rax, %rax
	je	.L435
	xorl	%ebp, %ebp
	jmp	.L449
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L448:
	addq	$1, %rbp
	cmpq	8(%r13), %rbp
	jnb	.L435
.L449:
	movq	0(%r13), %rax
	movq	(%rax,%rbp,8), %rax
	cmpl	$2, (%rax)
	jne	.L448
	movq	8(%rax), %rax
	movq	%rbx, %rdi
	movq	56(%rax), %rsi
	call	sem_check_initializer
	jmp	.L448
.L538:
	movq	32(%rax), %rdi
	testq	%rdi, %rdi
	je	.L422
	leaq	56(%rsp), %rsi
	call	try_eval_const_expr@PLT
	testl	%eax, %eax
	je	.L542
.L423:
	movq	56(%rsp), %rax
	testq	%rax, %rax
	js	.L543
.L424:
	movq	8(%rsp), %rcx
	movq	%rax, 48(%rcx)
	jmp	.L422
.L537:
	leaq	.LC61(%rip), %rdi
	call	dief@PLT
	movq	(%rbx), %rax
	movq	(%rax), %rax
	jmp	.L447
.L542:
	movq	8(%rsp), %rax
	leaq	.LC64(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L423
.L543:
	movq	8(%rsp), %rax
	leaq	.LC65(%rip), %rdi
	movq	16(%rax), %rsi
	xorl	%eax, %eax
	call	dief@PLT
	movq	56(%rsp), %rax
	jmp	.L424
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
