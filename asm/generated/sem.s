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
	.type	sem_add_builtin_functions.constprop.0, @function
sem_add_builtin_functions.constprop.0:
.LFB37:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leaq	.LC47(%rip), %rsi
	movl	$47, %ecx
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	leaq	40(%r12), %r13
	leaq	.LC0(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$384, %rsp
	.cfi_def_cfa_offset 432
	movq	%rsp, %rdi
	leaq	8(%rsp), %r14
	rep movsq
	.p2align 4
	.p2align 3
.L2:
	movq	%rbp, %rdi
	addq	$8, %r14
	call	sdup@PLT
	movq	%r13, %rdi
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
	movq	(%r12), %rax
	movl	$0, 24(%rbx)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	-8(%r14), %rbp
	testq	%rbp, %rbp
	jne	.L2
	addq	$384, %rsp
	.cfi_def_cfa_offset 48
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
.LFE37:
	.size	sem_add_builtin_functions.constprop.0, .-sem_add_builtin_functions.constprop.0
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
	je	.L35
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.L11(%rip), %r14
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
.L8:
	cmpl	$12, (%rbx)
	ja	.L6
	movl	(%rbx), %eax
	movslq	(%r14,%rax,4), %rax
	addq	%r14, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L11:
	.long	.L6-.L11
	.long	.L15-.L11
	.long	.L6-.L11
	.long	.L14-.L11
	.long	.L10-.L11
	.long	.L6-.L11
	.long	.L6-.L11
	.long	.L6-.L11
	.long	.L6-.L11
	.long	.L6-.L11
	.long	.L6-.L11
	.long	.L12-.L11
	.long	.L10-.L11
	.text
	.p2align 4,,10
	.p2align 3
.L15:
	xorl	%ebp, %ebp
	cmpq	$0, 24(%rbx)
	je	.L6
.L16:
	movq	16(%rbx), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_collect_labels
	cmpq	24(%rbx), %rbp
	jb	.L16
.L6:
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
.L10:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L20:
	testq	%rbx, %rbx
	jne	.L8
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
.L12:
	.cfi_restore_state
	movq	(%r12), %rax
	movq	16(%rbx), %r13
	movq	8(%rax), %r15
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L17
	xorl	%ebp, %ebp
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L39:
	addq	$1, %rbp
	cmpq	%rbp, 8(%rsp)
	je	.L17
.L19:
	movq	(%r15,%rbp,8), %rax
	movq	%r13, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L39
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r13, %rsi
	leaq	.LC48(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r13
.L17:
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
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L14:
	movq	24(%rbx), %rsi
	movq	%r12, %rdi
	call	sem_collect_labels
	movq	32(%rbx), %rbx
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L35:
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
	je	.L40
	movl	(%rsi), %eax
	movq	%rsi, %rbx
	cmpl	$4, %eax
	je	.L43
	cmpl	$5, %eax
	je	.L44
	cmpl	$2, %eax
	jne	.L45
	movq	(%rdi), %rax
	movq	32(%rsi), %rbp
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L47
.L46:
	movq	8(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L51
	movq	8(%rsp), %rax
	xorl	%r15d, %r15d
	movq	8(%rax), %r14
	jmp	.L49
	.p2align 4,,10
	.p2align 3
.L91:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L51
.L49:
	movq	(%r14,%r15,8), %r13
	movq	%rbp, %rsi
	movq	8(%r13), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L91
	movl	0(%r13), %eax
	testl	%eax, %eax
	jne	.L62
.L40:
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
.L44:
	.cfi_restore_state
	cmpl	$32, 32(%rsi)
	je	.L92
.L45:
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
.L43:
	.cfi_restore_state
	movq	(%rsp), %r14
	movq	32(%rsi), %rsi
	movq	%r14, %rdi
	call	sem_check_lvalue
	movq	40(%rbx), %rsi
	movq	%r14, %rdi
.L90:
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
.L92:
	.cfi_restore_state
	movq	40(%rsi), %rsi
	movq	(%rsp), %rdi
	jmp	.L90
	.p2align 4,,10
	.p2align 3
.L51:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L46
.L47:
	movq	(%rsp), %rax
	movl	g_strict(%rip), %edx
	movq	16(%rax), %r14
	movq	24(%rax), %r12
	testl	%edx, %edx
	jne	.L93
.L52:
	testq	%r12, %r12
	je	.L56
.L54:
	xorl	%ebx, %ebx
	jmp	.L58
	.p2align 4,,10
	.p2align 3
.L94:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L56
.L58:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L94
	jmp	.L40
	.p2align 4,,10
	.p2align 3
.L62:
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
.L93:
	.cfi_restore_state
	testq	%r12, %r12
	je	.L53
	xorl	%r15d, %r15d
	jmp	.L55
	.p2align 4,,10
	.p2align 3
.L95:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L53
.L55:
	movq	(%r14,%r15,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L95
	jmp	.L54
.L56:
	movq	(%rsp), %rax
	movq	72(%rax), %r12
	movq	64(%rax), %r14
	testq	%r12, %r12
	je	.L59
	xorl	%ebx, %ebx
	jmp	.L60
	.p2align 4,,10
	.p2align 3
.L96:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L59
.L60:
	movq	(%r14,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L96
	jmp	.L40
.L53:
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
	jmp	.L52
.L59:
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
	je	.L184
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
	leaq	.L102(%rip), %r12
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
.L98:
	cmpl	$10, (%rbx)
	ja	.L97
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L102:
	.long	.L97-.L102
	.long	.L97-.L102
	.long	.L110-.L102
	.long	.L109-.L102
	.long	.L101-.L102
	.long	.L107-.L102
	.long	.L106-.L102
	.long	.L182-.L102
	.long	.L104-.L102
	.long	.L103-.L102
	.long	.L101-.L102
	.text
	.p2align 4,,10
	.p2align 3
.L110:
	movq	0(%rbp), %rax
	movq	32(%rbx), %r12
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L112
.L111:
	movq	8(%rsp), %rax
	movq	16(%rax), %rax
	movq	%rax, (%rsp)
	testq	%rax, %rax
	je	.L116
	movq	8(%rsp), %rax
	xorl	%r13d, %r13d
	movq	8(%rax), %r14
	jmp	.L114
	.p2align 4,,10
	.p2align 3
.L185:
	addq	$1, %r13
	cmpq	%r13, (%rsp)
	je	.L116
.L114:
	movq	(%r14,%r13,8), %r15
	movq	%r12, %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L185
	xorl	%eax, %eax
	cmpl	$1, (%r15)
	sete	%al
	movl	%eax, 12(%rbx)
.L97:
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
.L101:
	.cfi_restore_state
	movq	32(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	40(%rbx), %rbx
.L135:
	testq	%rbx, %rbx
	jne	.L98
	jmp	.L97
	.p2align 4,,10
	.p2align 3
.L103:
	movq	32(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
.L182:
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	48(%rbx), %rbx
	jmp	.L135
	.p2align 4,,10
	.p2align 3
.L104:
	movq	40(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_lvalue
	movq	48(%rbx), %rbx
	jmp	.L135
	.p2align 4,,10
	.p2align 3
.L106:
	movq	40(%rbx), %rsi
.L183:
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
.L107:
	.cfi_restore_state
	movl	32(%rbx), %eax
	movq	40(%rbx), %rbx
	subl	$36, %eax
	cmpl	$1, %eax
	ja	.L135
	movq	%rbx, %rsi
	jmp	.L183
	.p2align 4,,10
	.p2align 3
.L109:
	movq	32(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L186
	movl	$1, 16(%rbx)
	movq	%rbp, %rdi
	call	sem_check_expr
.L133:
	xorl	%r12d, %r12d
	cmpq	$0, 48(%rbx)
	je	.L97
.L134:
	movq	40(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	48(%rbx), %r12
	jb	.L134
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
.L116:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L111
.L112:
	movq	24(%rbp), %r14
	movq	16(%rbp), %r15
	movl	$0, 12(%rbx)
	testq	%r14, %r14
	je	.L117
	xorl	%r13d, %r13d
	jmp	.L118
	.p2align 4,,10
	.p2align 3
.L187:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L117
.L118:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L187
	jmp	.L97
	.p2align 4,,10
	.p2align 3
.L186:
	movq	0(%rbp), %rax
	movq	32(%rsi), %r12
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
.L188:
	addq	$1, %r13
	cmpq	%r13, (%rsp)
	je	.L128
.L126:
	movq	(%r14,%r13,8), %r15
	movq	%r12, %rsi
	movq	8(%r15), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L188
	movl	(%r15), %eax
	cmpl	$1, %eax
	ja	.L189
.L139:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
.L132:
	movl	%eax, 16(%rbx)
	jmp	.L133
	.p2align 4,,10
	.p2align 3
.L128:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L123
.L124:
	movq	24(%rbp), %r14
	movq	16(%rbp), %r15
	testq	%r14, %r14
	je	.L129
	xorl	%r13d, %r13d
	jmp	.L131
	.p2align 4,,10
	.p2align 3
.L190:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L129
.L131:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L190
	xorl	%eax, %eax
	jmp	.L132
	.p2align 4,,10
	.p2align 3
.L189:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	xorl	%eax, %eax
	movq	%r12, %rsi
	leaq	.LC52(%rip), %rdi
	call	dief@PLT
	movl	(%r15), %eax
	jmp	.L139
.L184:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
.L117:
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
	je	.L119
	xorl	%r13d, %r13d
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L191:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L119
.L120:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L191
	jmp	.L97
.L119:
	movl	g_strict(%rip), %eax
	testl	%eax, %eax
	jne	.L192
.L121:
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
.L129:
	.cfi_restore_state
	movq	%r12, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	xorl	%eax, %eax
	jmp	.L132
.L192:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r12, %rsi
	leaq	.LC49(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	32(%rbx), %r12
	jmp	.L121
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
	je	.L266
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
	leaq	.L198(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
.L195:
	cmpl	$12, (%rbx)
	ja	.L193
	movl	(%rbx), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L198:
	.long	.L193-.L198
	.long	.L207-.L198
	.long	.L206-.L198
	.long	.L205-.L198
	.long	.L204-.L198
	.long	.L203-.L198
	.long	.L200-.L198
	.long	.L201-.L198
	.long	.L193-.L198
	.long	.L193-.L198
	.long	.L200-.L198
	.long	.L269-.L198
	.long	.L197-.L198
	.text
	.p2align 4,,10
	.p2align 3
.L207:
	movl	$32, %edi
	movq	0(%r13), %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movups	%xmm0, 16(%rax)
	cmpq	$0, 24(%rbx)
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movq	%rax, 0(%r13)
	je	.L210
	xorl	%ebp, %ebp
.L211:
	movq	16(%rbx), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_check_stmt
	cmpq	24(%rbx), %rbp
	jb	.L211
	movq	0(%r13), %rax
	movq	(%rax), %rbp
.L210:
	testq	%rbp, %rbp
	je	.L271
.L212:
	movq	%rbp, 0(%r13)
.L193:
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
.L200:
	.cfi_restore_state
	movq	16(%rbx), %rsi
.L270:
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
.L269:
	.cfi_restore_state
	movq	24(%rbx), %rbx
.L217:
	testq	%rbx, %rbx
	jne	.L195
	jmp	.L193
	.p2align 4,,10
	.p2align 3
.L201:
	leaq	16(%r13), %rax
	cmpq	$0, 24(%rbx)
	movq	$0, 8(%rsp)
	movq	%rax, 16(%rsp)
	je	.L193
	.p2align 4
	.p2align 3
.L208:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	24(%r13), %rbp
	movq	16(%r13), %r14
	movq	(%rax,%rcx,8), %r12
	testq	%rbp, %rbp
	je	.L218
	xorl	%r15d, %r15d
	jmp	.L220
	.p2align 4,,10
	.p2align 3
.L272:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L218
.L220:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L272
.L219:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L208
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
.L205:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%rbx), %rbx
	jmp	.L217
	.p2align 4,,10
	.p2align 3
.L204:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rbx
	jmp	.L217
	.p2align 4,,10
	.p2align 3
.L203:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L270
	jmp	.L193
	.p2align 4,,10
	.p2align 3
.L197:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %r14
	testq	%r14, %r14
	je	.L193
	cmpl	$1, (%r14)
	jne	.L229
	cmpq	$0, 24(%r14)
	je	.L229
	xorl	%ecx, %ecx
	xorl	%r12d, %r12d
	leaq	.LC54(%rip), %r15
	jmp	.L225
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L222:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	andl	%eax, %ecx
.L224:
	addq	$1, %r12
	cmpq	24(%r14), %r12
	jnb	.L269
.L225:
	movq	16(%r14), %rax
	movq	(%rax,%r12,8), %rdx
	movl	(%rdx), %eax
	cmpl	$13, %eax
	jne	.L222
	testl	%ecx, %ecx
	jne	.L273
.L223:
	movl	$1, %ecx
	jmp	.L224
	.p2align 4,,10
	.p2align 3
.L206:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L193
	.p2align 4
	.p2align 3
.L209:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbp
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	movq	8(%rax), %r14
	testq	%r12, %r12
	je	.L213
	xorl	%r15d, %r15d
	jmp	.L215
	.p2align 4,,10
	.p2align 3
.L274:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L213
.L215:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L274
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	movq	%rbp, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rbp
.L213:
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
	je	.L216
	movq	%r13, %rdi
	call	sem_check_expr
.L216:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L209
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
.L229:
	.cfi_restore_state
	movq	%r14, %rbx
	jmp	.L195
	.p2align 4,,10
	.p2align 3
.L218:
	movq	%r12, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L219
.L273:
	movl	8(%rdx), %ecx
	movq	stderr(%rip), %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	movl	4(%rdx), %edx
	call	fprintf@PLT
	jmp	.L223
.L271:
	xorl	%eax, %eax
	leaq	.LC53(%rip), %rdi
	call	dief@PLT
	movq	0(%r13), %rax
	movq	(%rax), %rbp
	jmp	.L212
.L266:
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
	movq	%r12, %rdi
	movups	%xmm0, (%rax)
	movups	%xmm0, 16(%rax)
	movq	%rax, (%r12)
	movq	$0, 16(%r12)
	movq	$0, 40(%r12)
	movq	$0, 64(%r12)
	movups	%xmm0, 24(%r12)
	movups	%xmm0, 48(%r12)
	movups	%xmm0, 72(%r12)
	call	sem_add_builtin_functions.constprop.0
	leaq	16(%r12), %rax
	cmpq	$0, 8(%r14)
	movq	$0, 16(%rsp)
	movq	%rax, 40(%rsp)
	je	.L297
	.p2align 4
	.p2align 3
.L276:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L279
	ja	.L280
	testl	%edx, %edx
	je	.L348
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
	je	.L291
	xorl	%r15d, %r15d
	jmp	.L293
	.p2align 4,,10
	.p2align 3
.L349:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L291
.L293:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L349
	movq	8(%r12), %rdi
	movq	%rbx, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	movq	0(%r13), %rbx
.L291:
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
.L284:
	movq	8(%rsp), %rax
	addq	$1, 16(%rsp)
	movq	16(%rsp), %rcx
	movq	8(%rax), %rax
	cmpq	%rax, %rcx
	jb	.L276
	testq	%rax, %rax
	je	.L297
	movq	$0, 16(%rsp)
	jmp	.L305
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L298:
	movq	8(%rsp), %rcx
	addq	$1, 16(%rsp)
	movq	16(%rsp), %rax
	cmpq	8(%rcx), %rax
	jnb	.L297
.L305:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L298
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
	je	.L299
	movq	$0, (%rsp)
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L303:
	movq	8(%r13), %rdx
	movq	(%rsp), %rcx
	movq	8(%rax), %r14
	movq	(%rdx,%rcx,8), %rbx
	testq	%rbp, %rbp
	je	.L300
	xorl	%r15d, %r15d
	jmp	.L302
	.p2align 4,,10
	.p2align 3
.L350:
	addq	$1, %r15
	cmpq	%rbp, %r15
	je	.L300
.L302:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L350
	movq	8(%r12), %rdi
	movq	%rbx, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
.L300:
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
	jnb	.L299
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	jmp	.L303
	.p2align 4,,10
	.p2align 3
.L280:
	cmpl	$3, %edx
	jne	.L284
	movq	8(%rax), %rax
	movq	8(%rax), %rdi
	call	sdup@PLT
	movq	40(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L284
	.p2align 4,,10
	.p2align 3
.L299:
	movq	32(%r13), %rsi
	movq	%r12, %rdi
	call	sem_collect_labels
	movq	32(%r13), %rsi
	movq	%r12, %rdi
	call	sem_check_stmt
	movq	(%r12), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L351
.L304:
	movq	%rax, (%r12)
	jmp	.L298
	.p2align 4,,10
	.p2align 3
.L348:
	movq	8(%rax), %r14
	cmpl	$2, (%r14)
	je	.L285
	leaq	.LC55(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L285:
	cmpq	$0, 24(%r14)
	movq	$0, (%rsp)
	je	.L284
	.p2align 4
	.p2align 3
.L286:
	movq	16(%r14), %rax
	movq	(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 24(%rsp)
	movq	(%rax), %rbx
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	movq	8(%rax), %r13
	testq	%rbp, %rbp
	je	.L287
	xorl	%r15d, %r15d
	jmp	.L289
	.p2align 4,,10
	.p2align 3
.L352:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L287
.L289:
	movq	0(%r13,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L352
	movl	8(%r14), %edx
	movl	4(%r14), %esi
	movq	%rbx, %r8
	movl	$10, %ecx
	movq	8(%r12), %rdi
	call	error_at_location@PLT
	movq	24(%rsp), %rax
	movq	(%rax), %rbx
.L287:
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
	jb	.L286
	jmp	.L284
	.p2align 4,,10
	.p2align 3
.L279:
	movq	8(%rax), %r13
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	movq	8(%r13), %rbx
	movq	8(%rax), %r14
	testq	%rbp, %rbp
	je	.L294
	xorl	%r15d, %r15d
	jmp	.L296
	.p2align 4,,10
	.p2align 3
.L353:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L294
.L296:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L353
	movq	%rbx, %rsi
	leaq	.LC56(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	8(%r13), %rbx
.L294:
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
	jmp	.L284
.L297:
	xorl	%r13d, %r13d
	cmpq	$0, 72(%r12)
	je	.L275
	.p2align 4
	.p2align 3
.L277:
	movq	64(%r12), %rax
	movq	(%rax,%r13,8), %rbp
	movq	8(%rsp), %rax
	movq	8(%rax), %r15
	testq	%r15, %r15
	je	.L306
	movq	(%rax), %r14
	xorl	%ebx, %ebx
	jmp	.L309
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L307:
	addq	$1, %rbx
	cmpq	%rbx, %r15
	je	.L306
.L309:
	movq	(%r14,%rbx,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L307
	movq	8(%rdx), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L307
	addq	$1, %r13
	cmpq	72(%r12), %r13
	jb	.L277
.L275:
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
.L306:
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
	jb	.L277
	jmp	.L275
.L351:
	leaq	.LC53(%rip), %rdi
	call	dief@PLT
	movq	(%r12), %rax
	movq	(%rax), %rax
	jmp	.L304
	.cfi_endproc
.LFE36:
	.size	sem_check_program, .-sem_check_program
	.section	.note.GNU-stack,"",@progbits
