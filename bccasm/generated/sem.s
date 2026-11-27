	.file	"sem.c"
	.text
	.p2align 4
	.type	symbol_new, @function
symbol_new:
.LFB49:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	%edi, %r14d
	movl	$64, %edi
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movl	%edx, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movl	%ecx, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%r13, %rdi
	movl	%r14d, (%rax)
	movq	%rax, %rbx
	movups	%xmm0, 36(%rax)
	movups	%xmm0, 4(%rax)
	movups	%xmm0, 20(%rax)
	movups	%xmm0, 48(%rax)
	call	sdup@PLT
	movl	%r12d, 16(%rbx)
	movq	%rax, 8(%rbx)
	movq	%rbx, %rax
	movl	%ebp, 20(%rbx)
	movq	$0, 24(%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE49:
	.size	symbol_new, .-symbol_new
	.p2align 4
	.type	has_data_declaration.isra.0, @function
has_data_declaration.isra.0:
.LFB77:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L8
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
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L6:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	je	.L15
.L7:
	movq	(%r12,%rbx,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L6
	movq	8(%rdx), %rax
	movq	%r13, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L6
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
.L15:
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
.L8:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE77:
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
.LFB58:
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
	subq	$456, %rsp
	.cfi_def_cfa_offset 512
	movq	%fs:40, %rax
	movq	%rax, 440(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %rdi
	leaq	40(%r14), %rax
	rep movsq
	movq	%rax, 8(%rsp)
	leaq	24(%rsp), %r13
	.p2align 4,,10
	.p2align 3
.L20:
	movq	(%r14), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r15
	testq	%r12, %r12
	je	.L17
	xorl	%ebx, %ebx
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L31:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L17
.L19:
	movq	(%r15,%rbx,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L31
	movq	0(%r13), %rbp
	addq	$8, %r13
	testq	%rbp, %rbp
	jne	.L20
.L33:
	movq	440(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L32
	addq	$456, %rsp
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
.L17:
	.cfi_restore_state
	movq	%rbp, %rdi
	addq	$8, %r13
	call	sdup@PLT
	movq	8(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	%rbp, %rsi
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movl	$1, %edi
	call	symbol_new
	movl	$1, 28(%rax)
	movq	%rax, %rsi
	movq	(%r14), %rax
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	-8(%r13), %rbp
	testq	%rbp, %rbp
	jne	.L20
	jmp	.L33
.L32:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE58:
	.size	sem_add_builtin_functions, .-sem_add_builtin_functions
	.section	.rodata.str1.1
.LC53:
	.string	"duplicate label '%s' at %d:%d"
	.text
	.p2align 4
	.type	sem_collect_labels, @function
sem_collect_labels:
.LFB71:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leaq	.L39(%rip), %r13
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
.L36:
	cmpl	$13, (%rbx)
	ja	.L34
	movl	(%rbx), %eax
	movslq	0(%r13,%rax,4), %rax
	addq	%r13, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L39:
	.long	.L34-.L39
	.long	.L44-.L39
	.long	.L34-.L39
	.long	.L43-.L39
	.long	.L40-.L39
	.long	.L34-.L39
	.long	.L34-.L39
	.long	.L34-.L39
	.long	.L34-.L39
	.long	.L34-.L39
	.long	.L34-.L39
	.long	.L41-.L39
	.long	.L40-.L39
	.long	.L38-.L39
	.text
	.p2align 4,,10
	.p2align 3
.L44:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L34
.L45:
	movq	16(%rbx), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_collect_labels
	cmpq	24(%rbx), %rbp
	jb	.L45
.L34:
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
.L40:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L49:
	testq	%rbx, %rbx
	jne	.L36
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
.L41:
	.cfi_restore_state
	movq	(%r12), %rax
	movq	16(%rbx), %r14
	movq	8(%rax), %r15
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L46
	xorl	%ebp, %ebp
	jmp	.L48
	.p2align 4,,10
	.p2align 3
.L68:
	addq	$1, %rbp
	cmpq	%rbp, 8(%rsp)
	je	.L46
.L48:
	movq	(%r15,%rbp,8), %rax
	movq	%r14, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L68
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r14, %rsi
	leaq	.LC53(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L38:
	movq	40(%rbx), %rbx
	jmp	.L49
	.p2align 4,,10
	.p2align 3
.L43:
	movq	24(%rbx), %rsi
	movq	%r12, %rdi
	call	sem_collect_labels
	movq	32(%rbx), %rbx
	jmp	.L49
	.p2align 4,,10
	.p2align 3
.L46:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r14, %rsi
	movl	$2, %edi
	call	symbol_new
	movq	%rax, %rsi
	movq	(%r12), %rax
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	24(%rbx), %rbx
	jmp	.L49
	.p2align 4,,10
	.p2align 3
.L64:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE71:
	.size	sem_collect_labels, .-sem_collect_labels
	.p2align 4
	.type	mark_global_reference, @function
mark_global_reference:
.LFB66:
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
	je	.L70
	movq	32(%rdx), %rax
	movl	(%rdx), %r11d
	movq	%rax, 32(%rsi)
	testl	%r11d, %r11d
	jne	.L123
	movl	24(%rdx), %r9d
	testl	%r9d, %r9d
	je	.L77
	movl	$1, 24(%rsi)
	movq	48(%rsi), %rbp
.L78:
	movq	96(%r12), %r13
	movq	88(%r12), %r14
	testq	%r13, %r13
	je	.L89
	xorl	%ebx, %ebx
	jmp	.L90
	.p2align 4,,10
	.p2align 3
.L124:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L89
.L90:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L124
.L69:
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
.L123:
	.cfi_restore_state
	movl	24(%rsi), %r10d
	testl	%r10d, %r10d
	je	.L69
	movl	24(%rdx), %ecx
	movq	48(%rsi), %rbp
	testl	%ecx, %ecx
	jne	.L78
	movq	24(%rdi), %r13
	movq	16(%rdi), %r14
.L87:
	testq	%r13, %r13
	je	.L69
.L84:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L88:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L78
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L88
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
.L70:
	.cfi_restore_state
	movq	$0, 32(%rsi)
	movq	24(%rdi), %r13
	xorl	%r15d, %r15d
	movq	48(%rsi), %rbp
	movq	16(%rdi), %r14
	testq	%r13, %r13
	jne	.L73
	jmp	.L125
	.p2align 4,,10
	.p2align 3
.L127:
	addq	$1, %r15
	cmpq	%r15, %r13
	je	.L126
.L73:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L127
	movq	48(%r12), %rax
	movq	40(%r12), %rcx
	xorl	%r15d, %r15d
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L82
	jmp	.L95
	.p2align 4,,10
	.p2align 3
.L128:
	addq	$1, %r15
	cmpq	%r15, 8(%rsp)
	movq	(%rsp), %rcx
	je	.L95
.L82:
	movq	(%rcx,%r15,8), %rdi
	movq	%rbp, %rsi
	movq	%rcx, (%rsp)
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L128
	movl	g_strict(%rip), %edx
	movl	24(%rbx), %eax
	testl	%edx, %edx
	jne	.L121
	testl	%eax, %eax
	jne	.L84
	jmp	.L69
	.p2align 4,,10
	.p2align 3
.L77:
	movl	24(%rsi), %esi
	testl	%esi, %esi
	je	.L69
	movq	48(%rbx), %rbp
	movq	24(%rdi), %r13
	movq	16(%rdi), %r14
	jmp	.L87
	.p2align 4,,10
	.p2align 3
.L89:
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
.L126:
	.cfi_restore_state
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L121
	movl	$1, 24(%rbx)
	jmp	.L84
	.p2align 4,,10
	.p2align 3
.L121:
	movl	24(%rbx), %edi
	testl	%edi, %edi
	jne	.L84
	jmp	.L69
.L95:
	movq	112(%r12), %rax
	movq	%rbp, %rdx
	movq	8(%rax), %rsi
	movq	(%rax), %rdi
	call	has_data_declaration.isra.0
	cmpl	$1, %eax
	movl	$1, %eax
	adcl	$0, %eax
	movl	%eax, 24(%rbx)
	jmp	.L84
.L125:
	movl	g_strict(%rip), %r8d
	testl	%r8d, %r8d
	jne	.L69
	movl	$1, 24(%rsi)
	jmp	.L69
	.cfi_endproc
.LFE66:
	.size	mark_global_reference, .-mark_global_reference
	.p2align 4
	.type	scope_find_value, @function
scope_find_value:
.LFB67:
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
	je	.L176
.L130:
	movq	8(%rsp), %rax
	movq	16(%rax), %r13
	testq	%r13, %r13
	je	.L135
	movq	8(%rsp), %rax
	xorl	%r15d, %r15d
	movq	8(%rax), %r14
	jmp	.L133
	.p2align 4,,10
	.p2align 3
.L177:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L135
.L133:
	movq	(%r14,%r15,8), %rbx
	movq	%rbp, %rsi
	movq	8(%rbx), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L177
.L132:
	movl	16(%rsp), %eax
	testl	%eax, %eax
	je	.L148
	movq	24(%rsp), %rax
	movq	120(%rax), %rax
	movq	%rax, 16(%rsp)
	testq	%rax, %rax
	je	.L148
.L138:
	movq	(%r12), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L149
	movq	16(%r12), %r13
	testq	%r13, %r13
	je	.L141
	movq	8(%r12), %r14
	xorl	%r15d, %r15d
	jmp	.L139
	.p2align 4,,10
	.p2align 3
.L178:
	addq	$1, %r15
	cmpq	%r13, %r15
	je	.L141
.L139:
	movq	(%r14,%r15,8), %r12
	movq	%rbp, %rsi
	movq	8(%r12), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L178
.L129:
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
.L135:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L130
	xorl	%ebx, %ebx
	jmp	.L132
	.p2align 4,,10
	.p2align 3
.L141:
	movq	8(%rsp), %r12
	jmp	.L138
	.p2align 4,,10
	.p2align 3
.L148:
	movq	%rbx, %r12
	jmp	.L129
.L176:
	movl	16(%rsp), %edx
	testl	%edx, %edx
	je	.L129
	movq	24(%rsp), %rax
	movq	120(%rax), %rax
	movq	%rax, 16(%rsp)
	testq	%rax, %rax
	je	.L129
.L137:
	movq	24(%rsp), %rax
	movq	24(%rax), %r13
	movq	16(%rax), %r14
	testq	%r13, %r13
	je	.L142
	xorl	%ebx, %ebx
	jmp	.L143
	.p2align 4,,10
	.p2align 3
.L179:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L142
.L143:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L179
	jmp	.L129
.L142:
	movq	16(%rsp), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	movl	$0, %eax
	cmovne	%rax, %r12
	jmp	.L129
.L149:
	movq	%rbx, %r12
	jmp	.L137
	.cfi_endproc
.LFE67:
	.size	scope_find_value, .-scope_find_value
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC54:
	.string	"undefined internal name '%s' at %d:%d"
	.section	.rodata.str1.1
.LC55:
	.string	"'%s' is not callable at %d:%d"
	.text
	.p2align 4
	.type	sem_check_expr, @function
sem_check_expr:
.LFB69:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L250
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
	leaq	.L185(%rip), %r12
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
.L181:
	cmpl	$10, (%rbx)
	ja	.L180
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L185:
	.long	.L180-.L185
	.long	.L180-.L185
	.long	.L193-.L185
	.long	.L192-.L185
	.long	.L184-.L185
	.long	.L190-.L185
	.long	.L189-.L185
	.long	.L248-.L185
	.long	.L187-.L185
	.long	.L186-.L185
	.long	.L184-.L185
	.text
	.p2align 4,,10
	.p2align 3
.L192:
	movq	48(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L251
	movl	$1, 28(%rbx)
	movq	%rbp, %rdi
	call	sem_check_expr
.L209:
	cmpq	$0, 64(%rbx)
	je	.L180
	xorl	%r12d, %r12d
.L212:
	movq	56(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	64(%rbx), %r12
	jb	.L212
.L180:
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
.L184:
	.cfi_restore_state
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	56(%rbx), %rbx
.L213:
	testq	%rbx, %rbx
	jne	.L181
	jmp	.L180
	.p2align 4,,10
	.p2align 3
.L186:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
.L248:
	movq	56(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	64(%rbx), %rbx
	jmp	.L213
	.p2align 4,,10
	.p2align 3
.L187:
	movq	56(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_lvalue
	movq	64(%rbx), %rbx
	jmp	.L213
	.p2align 4,,10
	.p2align 3
.L189:
	movq	56(%rbx), %rsi
.L249:
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
.L190:
	.cfi_restore_state
	movl	48(%rbx), %eax
	movq	56(%rbx), %rbx
	leal	-36(%rax), %edx
	cmpl	$1, %edx
	jbe	.L216
	cmpl	$53, %eax
	jne	.L213
.L216:
	movq	%rbx, %rsi
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L193:
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	scope_find_value
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	movq	%rax, %r12
	movq	%rax, %rdx
	call	mark_global_reference
	testq	%r12, %r12
	je	.L194
	movl	28(%r12), %edx
	movl	(%r12), %ebp
	testl	%edx, %edx
	je	.L195
	movq	8(%r12), %rdi
	leaq	.LC50(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L252
.L195:
	movl	$0, 20(%rbx)
	cmpl	$1, %ebp
	je	.L253
.L197:
	movl	$0, 16(%rbx)
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
.L251:
	.cfi_restore_state
	movq	48(%rsi), %r13
	movq	%rbp, %rdi
	movq	%r13, %rsi
	call	scope_find_value
	testq	%rax, %rax
	je	.L254
	movl	(%rax), %eax
	cmpl	$1, %eax
	ja	.L255
.L210:
	testl	%eax, %eax
	jne	.L211
	movl	$1, 28(%rbx)
	movq	48(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	jmp	.L209
	.p2align 4,,10
	.p2align 3
.L194:
	movq	24(%rbp), %r14
	movq	$0, 16(%rbx)
	xorl	%r12d, %r12d
	movq	48(%rbx), %r13
	movq	16(%rbp), %r15
	testq	%r14, %r14
	jne	.L198
	jmp	.L199
	.p2align 4,,10
	.p2align 3
.L256:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L199
.L198:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L256
	jmp	.L180
	.p2align 4,,10
	.p2align 3
.L252:
	movl	$1, 20(%rbx)
	jmp	.L197
	.p2align 4,,10
	.p2align 3
.L211:
	movl	$0, 28(%rbx)
	jmp	.L209
	.p2align 4,,10
	.p2align 3
.L250:
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
.L253:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	$1, 16(%rbx)
	jmp	.L180
.L254:
	movq	24(%rbp), %r14
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L205
	xorl	%r12d, %r12d
	jmp	.L207
	.p2align 4,,10
	.p2align 3
.L257:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L205
.L207:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L257
.L206:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	scope_find_value
	testq	%rax, %rax
	je	.L211
	movl	(%rax), %eax
	jmp	.L210
.L199:
	movq	72(%rbp), %r14
	movq	64(%rbp), %r15
	testq	%r14, %r14
	je	.L200
	xorl	%r12d, %r12d
	jmp	.L201
	.p2align 4,,10
	.p2align 3
.L258:
	addq	$1, %r12
	cmpq	%r12, %r14
	je	.L200
.L201:
	movq	(%r15,%r12,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L258
	jmp	.L180
.L200:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L259
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
.L205:
	.cfi_restore_state
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L206
.L255:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC55(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L259:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC54(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE69:
	.size	sem_check_expr, .-sem_check_expr
	.section	.rodata.str1.8
	.align 8
.LC56:
	.string	"'%s' is not a variable at %d:%d"
	.section	.rodata.str1.1
.LC57:
	.string	"invalid lvalue at %d:%d"
	.text
	.p2align 4
	.type	sem_check_lvalue, @function
sem_check_lvalue:
.LFB68:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L309
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
	je	.L262
	cmpl	$5, %eax
	je	.L263
	cmpl	$2, %eax
	jne	.L264
	movq	48(%rsi), %rsi
	call	scope_find_value
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	movq	%rax, %r12
	movq	%rax, %rdx
	call	mark_global_reference
	testq	%r12, %r12
	je	.L313
	movl	28(%r12), %eax
	testl	%eax, %eax
	je	.L274
	movq	8(%r12), %rbp
	leaq	.LC50(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L314
	movl	(%r12), %eax
	cmpl	$1, %eax
	jne	.L278
	movq	%rbp, %rdi
	call	b_library_function@PLT
	testl	%eax, %eax
	jne	.L277
	movl	(%r12), %eax
	jmp	.L278
	.p2align 4,,10
	.p2align 3
.L263:
	cmpl	$32, 48(%rsi)
	jne	.L279
.L312:
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
.L262:
	.cfi_restore_state
	movq	48(%rsi), %rsi
	call	sem_check_expr
	jmp	.L312
	.p2align 4,,10
	.p2align 3
.L313:
	movl	g_strict(%rip), %edx
	movq	48(%rbx), %r12
	movq	16(%rbp), %r15
	movq	24(%rbp), %r13
	testl	%edx, %edx
	je	.L266
	testq	%r13, %r13
	je	.L267
	xorl	%r14d, %r14d
	jmp	.L269
	.p2align 4,,10
	.p2align 3
.L315:
	addq	$1, %r14
	cmpq	%r13, %r14
	je	.L267
.L269:
	movq	(%r15,%r14,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L315
.L280:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L271:
	movq	(%r15,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L260
	addq	$1, %rbx
	cmpq	%r13, %rbx
	jne	.L271
.L270:
	movq	72(%rbp), %r13
	movq	64(%rbp), %r14
	testq	%r13, %r13
	je	.L272
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L273:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L260
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L273
.L272:
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
.L274:
	.cfi_restore_state
	movl	(%r12), %eax
	cmpl	$1, %eax
	je	.L277
.L278:
	andl	$-3, %eax
	jne	.L316
.L260:
	addq	$8, %rsp
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
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.p2align 4,,10
	.p2align 3
.L314:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	$1, 20(%rbx)
	jmp	.L260
	.p2align 4,,10
	.p2align 3
.L266:
	testq	%r13, %r13
	jne	.L280
	jmp	.L270
	.p2align 4,,10
	.p2align 3
.L277:
	movl	$1, 16(%rbx)
	jmp	.L260
.L264:
	movl	8(%rsi), %edx
	movl	4(%rsi), %esi
	leaq	.LC57(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L279:
	movl	8(%rsi), %edx
	movl	4(%rsi), %esi
	leaq	.LC57(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L267:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r12, %rsi
	leaq	.LC54(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L316:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	leaq	.LC56(%rip), %rdi
	xorl	%eax, %eax
	movq	48(%rbx), %rsi
	call	dief@PLT
	.cfi_endproc
.LFE68:
	.size	sem_check_lvalue, .-sem_check_lvalue
	.section	.rodata.str1.8
	.align 8
.LC58:
	.string	"internal: cannot pop global scope"
	.align 8
.LC59:
	.string	"external declaration conflicts with local name '%s'"
	.text
	.p2align 4
	.type	sem_check_stmt, @function
sem_check_stmt:
.LFB70:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L398
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
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	.L322(%rip), %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
.L319:
	cmpl	$13, (%r12)
	ja	.L317
	movl	(%r12), %eax
	movslq	(%rbx,%rax,4), %rax
	addq	%rbx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L322:
	.long	.L317-.L322
	.long	.L332-.L322
	.long	.L331-.L322
	.long	.L330-.L322
	.long	.L323-.L322
	.long	.L328-.L322
	.long	.L325-.L322
	.long	.L326-.L322
	.long	.L317-.L322
	.long	.L317-.L322
	.long	.L325-.L322
	.long	.L401-.L322
	.long	.L323-.L322
	.long	.L321-.L322
	.text
	.p2align 4,,10
	.p2align 3
.L342:
	movl	8(%r12), %ecx
	movl	4(%r12), %edx
	movq	%rbx, %rsi
	xorl	%edi, %edi
	call	symbol_new
	movq	8(%rsp), %rbx
	xorl	%edx, %edx
	movq	%rax, %rsi
	movq	8(%rbx), %rax
	testq	%rax, %rax
	movq	%rax, 48(%rsi)
	movq	0(%r13), %rax
	setne	%dl
	movl	%edx, 40(%rsi)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	8(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L344
	movq	%r13, %rdi
	call	sem_check_expr
.L344:
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	24(%r12), %rax
	jb	.L334
.L317:
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
.L325:
	.cfi_restore_state
	movq	16(%r12), %rsi
.L402:
	addq	$24, %rsp
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
.L323:
	.cfi_restore_state
	movq	16(%r12), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
.L401:
	movq	24(%r12), %r12
.L345:
	testq	%r12, %r12
	jne	.L319
	jmp	.L317
.L331:
	cmpq	$0, 24(%r12)
	movq	$0, (%rsp)
	je	.L317
	.p2align 4,,10
	.p2align 3
.L334:
	movq	16(%r12), %rax
	movq	(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 8(%rsp)
	movq	(%rax), %rbx
	movq	0(%r13), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r15
	testq	%rbp, %rbp
	je	.L339
	xorl	%r14d, %r14d
	jmp	.L341
	.p2align 4,,10
	.p2align 3
.L403:
	addq	$1, %r14
	cmpq	%r14, %rbp
	je	.L339
.L341:
	movq	(%r15,%r14,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L403
.L340:
	movl	8(%r12), %edx
	movl	4(%r12), %esi
	movq	%rbx, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L330:
	movq	16(%r12), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%r12), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%r12), %r12
	jmp	.L345
.L321:
	movq	40(%r12), %r12
	jmp	.L345
.L328:
	movq	16(%r12), %rsi
	testq	%rsi, %rsi
	jne	.L402
	jmp	.L317
.L326:
	leaq	16(%r13), %rax
	cmpq	$0, 24(%r12)
	movq	$0, (%rsp)
	movq	%rax, 8(%rsp)
	je	.L317
	.p2align 4,,10
	.p2align 3
.L333:
	movq	16(%r12), %rax
	movq	(%rsp), %rdx
	movq	(%rax,%rdx,8), %rbx
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L346
	movq	0(%r13), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r15
	testq	%rbp, %rbp
	je	.L346
	xorl	%r14d, %r14d
	jmp	.L348
	.p2align 4,,10
	.p2align 3
.L404:
	addq	$1, %r14
	cmpq	%r14, %rbp
	je	.L346
.L348:
	movq	(%r15,%r14,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L404
	movq	%rbx, %rsi
	leaq	.LC59(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L332:
	movl	g_strict(%rip), %esi
	testl	%esi, %esi
	je	.L405
	cmpq	$0, 24(%r12)
	je	.L317
.L352:
	xorl	%ebx, %ebx
.L337:
	movq	16(%r12), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	sem_check_stmt
	cmpq	24(%r12), %rbx
	jb	.L337
.L336:
	movl	g_strict(%rip), %ecx
	testl	%ecx, %ecx
	jne	.L317
	movq	0(%r13), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L406
	movq	%rax, 0(%r13)
	jmp	.L317
	.p2align 4,,10
	.p2align 3
.L339:
	movl	g_strict(%rip), %edx
	testl	%edx, %edx
	je	.L342
	movq	24(%r13), %r15
	movq	16(%r13), %rbp
	testq	%r15, %r15
	je	.L342
	xorl	%r14d, %r14d
	jmp	.L343
	.p2align 4,,10
	.p2align 3
.L407:
	addq	$1, %r14
	cmpq	%r14, %r15
	je	.L342
.L343:
	movq	0(%rbp,%r14,8), %rdi
	movq	%rbx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L407
	jmp	.L340
	.p2align 4,,10
	.p2align 3
.L346:
	movq	24(%r13), %rbp
	movq	16(%r13), %r14
	testq	%rbp, %rbp
	je	.L349
	xorl	%r15d, %r15d
	jmp	.L351
	.p2align 4,,10
	.p2align 3
.L408:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L349
.L351:
	movq	(%r14,%r15,8), %rdi
	movq	%rbx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L408
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	24(%r12), %rax
	jb	.L333
.L409:
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
.L349:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	sdup@PLT
	movq	8(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	24(%r12), %rax
	jb	.L333
	jmp	.L409
.L405:
	movl	$32, %edi
	movq	0(%r13), %rbx
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 16(%rax)
	cmpq	$0, 24(%r12)
	movq	%rbx, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, 0(%r13)
	jne	.L352
	jmp	.L336
.L398:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L406:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	leaq	.LC58(%rip), %rdi
	call	dief@PLT
	.cfi_endproc
.LFE70:
	.size	sem_check_stmt, .-sem_check_stmt
	.p2align 4
	.type	sem_check_initializer, @function
sem_check_initializer:
.LFB74:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L441
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
	je	.L444
	testl	%eax, %eax
	jne	.L410
	movq	16(%rsi), %r14
	cmpl	$2, (%r14)
	je	.L445
.L416:
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
.L444:
	.cfi_restore_state
	cmpq	$0, 24(%rsi)
	je	.L410
	xorl	%r12d, %r12d
.L415:
	movq	16(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_initializer
	cmpq	24(%rbx), %r12
	jb	.L415
.L410:
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
.L441:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.p2align 4,,10
	.p2align 3
.L445:
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
	je	.L418
.L417:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L421
	movq	8(%rsp), %rax
	xorl	%ebx, %ebx
	movq	8(%rax), %r15
	.p2align 4,,10
	.p2align 3
.L419:
	movq	(%r15,%rbx,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L416
	addq	$1, %rbx
	cmpq	%r12, %rbx
	jne	.L419
.L421:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L417
.L418:
	movq	24(%rbp), %r12
	movq	16(%rbp), %r15
	testq	%r12, %r12
	je	.L422
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L423:
	movq	(%r15,%rbx,8), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L416
	addq	$1, %rbx
	cmpq	%rbx, %r12
	jne	.L423
.L422:
	movq	%r13, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L416
	.cfi_endproc
.LFE74:
	.size	sem_check_initializer, .-sem_check_initializer
	.section	.rodata.str1.8
	.align 8
.LC60:
	.string	"internal: TOP_GAUTO should be ST_AUTO"
	.align 8
.LC61:
	.string	"vector bound must be a constant expression in '%s'"
	.section	.rodata.str1.1
.LC62:
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
.LFB75:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdi, %r15
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
	movq	%rsi, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%rdi, 32(%rsp)
	movl	$128, %edi
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	call	xmalloc@PLT
	movl	$32, %edi
	movq	%rbx, 8(%rax)
	movq	%rax, %r14
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, (%rax)
	movups	%xmm0, 16(%rax)
	movups	%xmm0, 24(%r14)
	movups	%xmm0, 48(%r14)
	movups	%xmm0, 72(%r14)
	pxor	%xmm0, %xmm0
	movq	$0, 104(%r14)
	movups	%xmm0, 88(%r14)
	cmpq	$0, 8(%r15)
	movq	%rax, (%r14)
	movq	$0, 16(%r14)
	movq	$0, 40(%r14)
	movq	$0, 64(%r14)
	movq	$0, 120(%r14)
	movq	%r15, 112(%r14)
	je	.L471
	movq	$0, 24(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 40(%rsp)
	.p2align 4,,10
	.p2align 3
.L447:
	movq	32(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L450
	ja	.L451
	testl	%edx, %edx
	je	.L576
	movq	8(%rax), %r12
	movq	(%r12), %rdi
	call	sdup@PLT
	leaq	40(%r14), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	(%r14), %rax
	movq	(%r12), %rbx
	movq	16(%rax), %rbp
	movq	8(%rax), %r15
	testq	%rbp, %rbp
	je	.L462
	xorl	%r13d, %r13d
	jmp	.L464
	.p2align 4,,10
	.p2align 3
.L577:
	addq	$1, %r13
	cmpq	%r13, %rbp
	je	.L462
.L464:
	movq	(%r15,%r13,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L577
.L488:
	movq	8(%r14), %rdi
	movq	%rbx, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L451:
	cmpl	$3, %edx
	jne	.L455
	movq	8(%rax), %rax
	movq	16(%rax), %rdi
	call	sdup@PLT
	leaq	16(%r14), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
.L455:
	movq	32(%rsp), %rcx
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8(%rcx), %rax
	jb	.L447
.L471:
	xorl	%r12d, %r12d
	leaq	40(%r14), %rax
	cmpq	$0, 8+g_known_functions(%rip)
	movq	%rax, 8(%rsp)
	je	.L449
.L448:
	leaq	g_known_functions(%rip), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %rbx
	movq	(%r14), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r13
	testq	%rbp, %rbp
	je	.L474
	xorl	%r15d, %r15d
	jmp	.L476
	.p2align 4,,10
	.p2align 3
.L578:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L474
.L476:
	movq	0(%r13,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L578
	addq	$1, %r12
	cmpq	8+g_known_functions(%rip), %r12
	jb	.L448
.L449:
	xorl	%r12d, %r12d
	cmpq	$0, 8+g_known_variables(%rip)
	je	.L473
.L472:
	leaq	g_known_variables(%rip), %rax
	movq	(%rax), %rax
	movq	(%rax,%r12,8), %rbp
	movq	(%r14), %rax
	movq	16(%rax), %rbx
	movq	8(%rax), %r13
	testq	%rbx, %rbx
	je	.L479
	xorl	%r15d, %r15d
	jmp	.L481
	.p2align 4,,10
	.p2align 3
.L579:
	addq	$1, %r15
	cmpq	%r15, %rbx
	je	.L479
.L481:
	movq	0(%r13,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L579
	addq	$1, %r12
	cmpq	8+g_known_variables(%rip), %r12
	jb	.L472
.L473:
	movq	%r14, %rdi
	call	sem_add_builtin_functions
	movq	32(%rsp), %rax
	movq	$0, 16(%rsp)
	cmpq	$0, 8(%rax)
	jne	.L477
	jmp	.L478
	.p2align 4,,10
	.p2align 3
.L484:
	movq	32(%rsp), %rax
	addq	$1, 16(%rsp)
	movq	16(%rsp), %rcx
	movq	8(%rax), %rax
	cmpq	%rax, %rcx
	jnb	.L580
.L477:
	movq	32(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L484
	movq	8(%rax), %rax
	movdqu	24(%r14), %xmm4
	movl	g_strict(%rip), %edx
	movq	%rax, 8(%rsp)
	movq	16(%r14), %rax
	movaps	%xmm4, 48(%rsp)
	movq	%rax, 24(%rsp)
	movq	120(%r14), %rax
	movq	%rax, 40(%rsp)
	testl	%edx, %edx
	jne	.L581
.L485:
	movq	8(%rsp), %r15
	movl	$32, %edi
	movq	(%r14), %rbx
	movq	(%r15), %rax
	movq	%rax, 120(%r14)
	call	xmalloc@PLT
	pxor	%xmm5, %xmm5
	movups	%xmm5, 16(%rax)
	cmpq	$0, 16(%r15)
	movq	%rbx, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, (%r14)
	je	.L486
	xorl	%ebp, %ebp
	xorl	%r12d, %r12d
	.p2align 4,,10
	.p2align 3
.L490:
	movq	8(%rsp), %rcx
	movq	8(%rax), %r13
	movq	8(%rcx), %rdx
	movq	(%rdx,%r12,8), %rbx
	testq	%rbp, %rbp
	je	.L487
	xorl	%r15d, %r15d
	jmp	.L489
	.p2align 4,,10
	.p2align 3
.L582:
	addq	$1, %r15
	cmpq	%rbp, %r15
	je	.L487
.L489:
	movq	0(%r13,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L582
	jmp	.L488
.L487:
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbx, %rsi
	xorl	%edi, %edi
	call	symbol_new
	addq	$1, %r12
	movq	%r12, 32(%rax)
	movq	%rax, %rsi
	movq	(%r14), %rax
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	8(%rsp), %rax
	cmpq	16(%rax), %r12
	jnb	.L486
	movq	(%r14), %rax
	movq	16(%rax), %rbp
	jmp	.L490
.L450:
	movq	8(%rax), %rbx
	cmpl	$2, 24(%rbx)
	jne	.L465
	movq	32(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L465
	movq	40(%rsp), %rsi
	call	try_eval_const_expr@PLT
	testl	%eax, %eax
	je	.L583
	movq	64(%rsp), %rax
	testq	%rax, %rax
	js	.L584
	movq	%rax, 48(%rbx)
.L465:
	movq	(%r14), %rax
	movq	16(%rbx), %rbx
	movq	16(%rax), %rbp
	movq	8(%rax), %r13
	testq	%rbp, %rbp
	je	.L468
	xorl	%r12d, %r12d
	jmp	.L470
	.p2align 4,,10
	.p2align 3
.L585:
	addq	$1, %r12
	cmpq	%r12, %rbp
	je	.L468
.L470:
	movq	0(%r13,%r12,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L585
	movq	%rbx, %rsi
	leaq	.LC63(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L462:
	movq	%rbx, %rsi
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movl	$1, %edi
	call	symbol_new
	movdqu	8(%r12), %xmm1
	movq	%rax, %rsi
	movups	%xmm1, 40(%rax)
	movq	24(%r12), %rax
	movq	%rax, 56(%rsi)
	movq	(%r14), %rax
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L455
.L576:
	movq	8(%rax), %r12
	cmpl	$2, (%r12)
	jne	.L456
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%r12)
	je	.L455
	.p2align 4,,10
	.p2align 3
.L457:
	movq	16(%r12), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbx
	movq	(%r14), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r15
	testq	%rbp, %rbp
	je	.L458
	xorl	%r13d, %r13d
	jmp	.L460
	.p2align 4,,10
	.p2align 3
.L586:
	addq	$1, %r13
	cmpq	%r13, %rbp
	je	.L458
.L460:
	movq	(%r15,%r13,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L586
	movl	8(%r12), %edx
	movl	4(%r12), %esi
	movq	%rbx, %r8
	movl	$10, %ecx
	movq	8(%r14), %rdi
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L458:
	movl	8(%r12), %ecx
	movl	4(%r12), %edx
	xorl	%edi, %edi
	movq	%rbx, %rsi
	call	symbol_new
	xorl	%edx, %edx
	movq	%rax, %rsi
	movq	16(%rsp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	movq	%rax, 48(%rsi)
	movq	(%r14), %rax
	setne	%dl
	movl	%edx, 40(%rsi)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%r12), %rax
	jb	.L457
	jmp	.L455
.L468:
	movq	%rbx, %rsi
	xorl	%edi, %edi
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	call	symbol_new
	movq	%rax, %rsi
	movl	$1, 24(%rax)
	movq	(%r14), %rax
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	jmp	.L455
.L474:
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movl	$1, %edi
	call	symbol_new
	addq	$1, %r12
	movq	%rax, %rsi
	movq	(%r14), %rax
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	%rbx, %rdi
	call	sdup@PLT
	movq	8(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpq	8+g_known_functions(%rip), %r12
	jb	.L448
	jmp	.L449
.L479:
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	xorl	%edi, %edi
	movq	%rbp, %rsi
	call	symbol_new
	addq	$1, %r12
	movl	$1, 24(%rax)
	movq	%rax, %rsi
	movq	(%r14), %rax
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	cmpq	8+g_known_variables(%rip), %r12
	jb	.L472
	jmp	.L473
.L486:
	movq	8(%rsp), %rbx
	movq	%r14, %rdi
	movq	32(%rbx), %rsi
	call	sem_collect_labels
	movq	32(%rbx), %rsi
	movq	%r14, %rdi
	call	sem_check_stmt
	movq	(%r14), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L587
	movq	%rax, (%r14)
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	je	.L492
	movq	24(%rsp), %rax
	movdqa	48(%rsp), %xmm6
	movq	%rax, 16(%r14)
	movups	%xmm6, 24(%r14)
.L492:
	movq	40(%rsp), %rax
	movq	%rax, 120(%r14)
	jmp	.L484
.L580:
	testq	%rax, %rax
	je	.L478
	xorl	%ebx, %ebx
	jmp	.L494
.L493:
	movq	32(%rsp), %rax
	addq	$1, %rbx
	cmpq	8(%rax), %rbx
	jnb	.L478
.L494:
	movq	32(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%rbx,8), %rax
	cmpl	$2, (%rax)
	jne	.L493
	movq	8(%rax), %rax
	movq	%r14, %rdi
	addq	$1, %rbx
	movq	56(%rax), %rsi
	call	sem_check_initializer
	movq	32(%rsp), %rax
	cmpq	8(%rax), %rbx
	jb	.L494
.L478:
	xorl	%r12d, %r12d
	cmpq	$0, 72(%r14)
	je	.L483
.L482:
	movq	64(%r14), %rax
	movq	(%rax,%r12,8), %rbp
	movq	32(%rsp), %rax
	movq	8(%rax), %r13
	testq	%r13, %r13
	je	.L497
	movq	(%rax), %r15
	xorl	%ebx, %ebx
	jmp	.L500
	.p2align 4,,10
	.p2align 3
.L498:
	addq	$1, %rbx
	cmpq	%r13, %rbx
	je	.L497
.L500:
	movq	(%r15,%rbx,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L498
	movq	8(%rdx), %rax
	movq	%rbp, %rsi
	movq	16(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L498
	addq	$1, %r12
	cmpq	72(%r14), %r12
	jb	.L482
.L483:
	xorl	%r12d, %r12d
	cmpq	$0, 96(%r14)
	je	.L446
.L495:
	movq	88(%r14), %rax
	movq	(%rax,%r12,8), %rbx
	movq	32(%rsp), %rax
	movq	8(%rax), %rsi
	movq	(%rax), %rdi
	movq	%rbx, %rdx
	call	has_data_declaration.isra.0
	testl	%eax, %eax
	jne	.L501
	movl	$16, %edi
	call	xmalloc@PLT
	movl	$64, %edi
	movq	%rax, 8(%rsp)
	call	xmalloc@PLT
	pxor	%xmm2, %xmm2
	movq	%rbx, %rdi
	movups	%xmm2, (%rax)
	movq	%rax, %r15
	movups	%xmm2, 16(%rax)
	movups	%xmm2, 32(%rax)
	movups	%xmm2, 48(%rax)
	movq	%rax, 16(%rsp)
	call	sdup@PLT
	movq	8+g_known_variables(%rip), %rbp
	movq	g_known_variables(%rip), %r13
	movq	%rax, 16(%r15)
	testq	%rbp, %rbp
	je	.L512
	xorl	%r15d, %r15d
	jmp	.L503
	.p2align 4,,10
	.p2align 3
.L588:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L512
.L503:
	movq	0(%r13,%r15,8), %rdi
	movq	%rbx, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L588
.L502:
	movq	16(%rsp), %rcx
	movq	32(%rsp), %rdi
	movl	%eax, 8(%rcx)
	movq	8(%rsp), %rax
	movl	$3, (%rax)
	movq	%rax, %rsi
	movq	%rcx, 8(%rax)
	call	vec_push@PLT
.L501:
	addq	$1, %r12
	cmpq	96(%r14), %r12
	jb	.L495
.L446:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L589
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
.L497:
	.cfi_restore_state
	movl	$16, %edi
	addq	$1, %r12
	call	xmalloc@PLT
	movl	$64, %edi
	movl	$2, (%rax)
	movq	%rax, %r13
	call	xmalloc@PLT
	pxor	%xmm3, %xmm3
	movq	%rbp, %rdi
	movups	%xmm3, (%rax)
	movq	%rax, %rbx
	movl	$1, 4(%rax)
	movups	%xmm3, 16(%rax)
	movups	%xmm3, 32(%rax)
	movups	%xmm3, 48(%rax)
	call	sdup@PLT
	movl	$0, 24(%rbx)
	movq	32(%rsp), %rdi
	movq	%r13, %rsi
	movq	%rax, 16(%rbx)
	movq	$0, 56(%rbx)
	movq	%rbx, 8(%r13)
	call	vec_push@PLT
	cmpq	72(%r14), %r12
	jb	.L482
	jmp	.L483
.L512:
	movl	$1, %eax
	jmp	.L502
.L581:
	pxor	%xmm0, %xmm0
	movq	$0, 32(%r14)
	movups	%xmm0, 16(%r14)
	jmp	.L485
.L583:
	movq	16(%rbx), %rsi
	leaq	.LC61(%rip), %rdi
	call	dief@PLT
.L456:
	leaq	.LC60(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L589:
	call	__stack_chk_fail@PLT
.L587:
	leaq	.LC58(%rip), %rdi
	call	dief@PLT
.L584:
	movq	16(%rbx), %rsi
	leaq	.LC62(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE75:
	.size	sem_check_program, .-sem_check_program
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
