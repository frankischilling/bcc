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
.LFB36:
	.cfi_startproc
	subq	$424, %rsp
	.cfi_def_cfa_offset 432
	movl	$376, %edx
	leaq	.LC47(%rip), %rsi
	movq	%rbp, 392(%rsp)
	.cfi_offset 6, -40
	leaq	.LC0(%rip), %rbp
	movq	%r12, 400(%rsp)
	.cfi_offset 12, -32
	movq	%rsp, %r12
	movq	%rbx, 384(%rsp)
	movq	%r13, 408(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 13, -24
	movq	%fs:40, %r13
	movq	%r13, 376(%rsp)
	movq	%rdi, %r13
	movq	%rsp, %rdi
	call	memcpy@PLT
	.p2align 4
	.p2align 3
.L2:
	movq	%rbp, %rdi
	addq	$8, %r12
	call	sdup@PLT
	leaq	40(%r13), %rdi
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
	movq	0(%r13), %rax
	movl	$0, 24(%rbx)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	(%r12), %rbp
	testq	%rbp, %rbp
	jne	.L2
	movq	376(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L7
	movq	384(%rsp), %rbx
	movq	392(%rsp), %rbp
	movq	400(%rsp), %r12
	movq	408(%rsp), %r13
	addq	$424, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L7:
	.cfi_restore_state
	movq	%r14, 416(%rsp)
	.cfi_offset 14, -16
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE36:
	.size	sem_add_builtin_functions.constprop.0, .-sem_add_builtin_functions.constprop.0
	.section	.rodata.str1.1
.LC48:
	.string	"'%s' is not callable at %d:%d"
	.text
	.p2align 4
	.type	sem_check_expr, @function
sem_check_expr:
.LFB30:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L85
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%rbx, 24(%rsp)
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	movq	%r12, 40(%rsp)
	.cfi_offset 12, -40
	leaq	.L12(%rip), %r12
.L10:
	cmpl	$10, (%rbx)
	ja	.L8
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L12:
	.long	.L16-.L12
	.long	.L16-.L12
	.long	.L20-.L12
	.long	.L19-.L12
	.long	.L11-.L12
	.long	.L17-.L12
	.long	.L16-.L12
	.long	.L95-.L12
	.long	.L14-.L12
	.long	.L13-.L12
	.long	.L11-.L12
	.text
	.p2align 4,,10
	.p2align 3
.L20:
	movq	%r14, 56(%rsp)
	.cfi_offset 14, -24
	movq	0(%rbp), %r14
	movq	%r13, 48(%rsp)
	movq	16(%rbx), %r12
	testq	%r14, %r14
	.cfi_offset 13, -32
	je	.L22
	movq	%r15, 64(%rsp)
	.cfi_offset 15, -16
.L21:
	movq	16(%r14), %r13
	testq	%r13, %r13
	je	.L25
	movq	8(%r14), %r15
	xorl	%ebx, %ebx
	jmp	.L23
	.p2align 4,,10
	.p2align 3
.L97:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L25
.L23:
	movq	(%r15,%rbx,8), %rax
	movq	%r12, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L97
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	64(%rsp), %r15
	.cfi_restore 15
.L8:
	movq	24(%rsp), %rbx
	movq	32(%rsp), %rbp
	movq	40(%rsp), %r12
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L16:
	.cfi_restore_state
	movq	24(%rbx), %rsi
.L96:
	movq	24(%rsp), %rbx
	movq	40(%rsp), %r12
	movq	%rbp, %rdi
	movq	32(%rsp), %rbp
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_def_cfa_offset 8
	jmp	sem_check_lvalue
	.p2align 4,,10
	.p2align 3
.L11:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rbx
.L41:
	testq	%rbx, %rbx
	jne	.L10
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L13:
	movq	16(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
.L95:
	movq	24(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_expr
	movq	32(%rbx), %rbx
	jmp	.L41
	.p2align 4,,10
	.p2align 3
.L14:
	movq	24(%rbx), %rsi
	movq	%rbp, %rdi
	call	sem_check_lvalue
	movq	32(%rbx), %rbx
	jmp	.L41
	.p2align 4,,10
	.p2align 3
.L17:
	movl	16(%rbx), %eax
	movq	24(%rbx), %rbx
	subl	$36, %eax
	cmpl	$1, %eax
	ja	.L41
	movq	%rbx, %rsi
	jmp	.L96
	.p2align 4,,10
	.p2align 3
.L19:
	movq	16(%rbx), %rsi
	cmpl	$2, (%rsi)
	je	.L98
	movq	%rbp, %rdi
	call	sem_check_expr
.L38:
	cmpq	$0, 32(%rbx)
	je	.L8
	xorl	%r12d, %r12d
.L40:
	movq	24(%rbx), %rax
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %rsi
	addq	$1, %r12
	call	sem_check_expr
	cmpq	32(%rbx), %r12
	jb	.L40
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L25:
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	(%r14), %r14
	testq	%r14, %r14
	jne	.L21
	movq	64(%rsp), %r15
	.cfi_restore 15
.L22:
	movq	24(%rbp), %r13
	testq	%r13, %r13
	je	.L26
	movq	16(%rbp), %r14
	xorl	%ebx, %ebx
	jmp	.L27
	.p2align 4,,10
	.p2align 3
.L99:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L26
.L27:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L99
.L92:
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	56(%rsp), %r14
	.cfi_restore 14
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L98:
	movq	0(%rbp), %rax
	movq	16(%rsi), %r12
	movq	%r13, 48(%rsp)
	movq	%r14, 56(%rsp)
	movq	%r15, 64(%rsp)
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L32
.L31:
	movq	8(%rsp), %rax
	movq	16(%rax), %rax
	movq	%rax, (%rsp)
	testq	%rax, %rax
	je	.L36
	movq	8(%rsp), %rax
	xorl	%r15d, %r15d
	movq	8(%rax), %r14
	jmp	.L34
	.p2align 4,,10
	.p2align 3
.L100:
	addq	$1, %r15
	cmpq	%r15, (%rsp)
	je	.L36
.L34:
	movq	(%r14,%r15,8), %r13
	movq	%r12, %rsi
	movq	8(%r13), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L100
	cmpl	$1, 0(%r13)
	ja	.L101
.L94:
	movq	48(%rsp), %r13
	.cfi_remember_state
	.cfi_restore 13
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	64(%rsp), %r15
	.cfi_restore 15
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L36:
	.cfi_restore_state
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	jne	.L31
.L32:
	movq	24(%rbp), %r14
	testq	%r14, %r14
	je	.L37
	movq	16(%rbp), %r15
	xorl	%r13d, %r13d
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L102:
	addq	$1, %r13
	cmpq	%r13, %r14
	je	.L37
.L39:
	movq	(%r15,%r13,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L102
	jmp	.L94
.L101:
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r12, %rsi
	leaq	.LC48(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	64(%rsp), %r15
	.cfi_restore 15
	jmp	.L38
.L85:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret
.L26:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	movq	72(%rbp), %r13
	testq	%r13, %r13
	je	.L28
	movq	64(%rbp), %r14
	xorl	%ebx, %ebx
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L103:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L28
.L29:
	movq	(%r14,%rbx,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L103
	jmp	.L92
.L37:
	.cfi_offset 15, -16
	movq	%r12, %rdi
	call	sdup@PLT
	leaq	16(%rbp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	64(%rsp), %r15
	.cfi_restore 15
	jmp	.L38
.L28:
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	movq	%r12, %rdi
	call	sdup@PLT
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	56(%rsp), %r14
	.cfi_restore 14
	leaq	64(%rbp), %rdi
	movq	24(%rsp), %rbx
	movq	32(%rsp), %rbp
	movq	%rax, %rsi
	movq	40(%rsp), %r12
	addq	$72, %rsp
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_def_cfa_offset 8
	jmp	vec_push@PLT
	.cfi_endproc
.LFE30:
	.size	sem_check_expr, .-sem_check_expr
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC49:
	.string	"'%s' is not a variable at %d:%d"
	.section	.rodata.str1.1
.LC50:
	.string	"invalid lvalue at %d:%d"
	.text
	.p2align 4
	.type	sem_check_lvalue, @function
sem_check_lvalue:
.LFB29:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L144
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movl	(%rsi), %eax
	movq	%rbx, 24(%rsp)
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	movq	%rdi, 8(%rsp)
	cmpl	$4, %eax
	je	.L106
	cmpl	$5, %eax
	je	.L107
	cmpl	$2, %eax
	jne	.L108
	movq	(%rdi), %rax
	movq	%rbp, 32(%rsp)
	movq	%r12, 40(%rsp)
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	movq	16(%rsi), %rbp
	movq	%r13, 48(%rsp)
	movq	%rax, (%rsp)
	testq	%rax, %rax
	.cfi_offset 13, -32
	je	.L110
	movq	%r14, 56(%rsp)
	movq	%r15, 64(%rsp)
	.cfi_offset 14, -24
	.cfi_offset 15, -16
.L109:
	movq	(%rsp), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L114
	movq	(%rsp), %rax
	xorl	%r15d, %r15d
	movq	8(%rax), %r13
	jmp	.L112
	.p2align 4,,10
	.p2align 3
.L149:
	addq	$1, %r15
	cmpq	%r12, %r15
	je	.L114
.L112:
	movq	0(%r13,%r15,8), %r14
	movq	%rbp, %rsi
	movq	8(%r14), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L149
	movl	(%r14), %eax
	testl	%eax, %eax
	jne	.L120
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	64(%rsp), %r15
	.cfi_restore 15
.L104:
	movq	32(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %r12
	.cfi_restore 12
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	24(%rsp), %rbx
	addq	$72, %rsp
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L107:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	cmpl	$32, 16(%rsi)
	je	.L150
.L108:
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	leaq	.LC50(%rip), %rdi
	xorl	%eax, %eax
	movq	24(%rsp), %rbx
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	jmp	dief@PLT
	.p2align 4,,10
	.p2align 3
.L106:
	.cfi_restore_state
	movq	%r14, 56(%rsp)
	.cfi_offset 14, -24
	movq	8(%rsp), %r14
	movq	16(%rsi), %rsi
	movq	%r14, %rdi
	call	sem_check_lvalue
	movq	24(%rbx), %rsi
	movq	%r14, %rdi
	movq	24(%rsp), %rbx
	movq	56(%rsp), %r14
	.cfi_restore 14
	addq	$72, %rsp
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	jmp	sem_check_expr
	.p2align 4,,10
	.p2align 3
.L150:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	movq	24(%rsi), %rsi
	movq	8(%rsp), %rdi
	movq	24(%rsp), %rbx
	addq	$72, %rsp
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	jmp	sem_check_expr
	.p2align 4,,10
	.p2align 3
.L114:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, (%rsp)
	testq	%rax, %rax
	jne	.L109
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	64(%rsp), %r15
	.cfi_restore 15
.L110:
	movq	8(%rsp), %rax
	movq	24(%rax), %r12
	testq	%r12, %r12
	je	.L115
	movq	16(%rax), %r13
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L116:
	movq	0(%r13,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L104
	addq	$1, %rbx
	cmpq	%rbx, %r12
	jne	.L116
.L115:
	movq	8(%rsp), %rax
	movq	72(%rax), %r12
	testq	%r12, %r12
	je	.L117
	movq	64(%rax), %r13
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L118:
	movq	0(%r13,%rbx,8), %rdi
	movq	%rbp, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L104
	addq	$1, %rbx
	cmpq	%rbx, %r12
	jne	.L118
.L117:
	movq	%rbp, %rdi
	call	sdup@PLT
	movq	8(%rsp), %rdi
	movq	32(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %r12
	.cfi_restore 12
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	%rax, %rsi
	movq	24(%rsp), %rbx
	addq	$64, %rdi
	addq	$72, %rsp
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	jmp	vec_push@PLT
	.p2align 4,,10
	.p2align 3
.L144:
	ret
	.p2align 4,,10
	.p2align 3
.L120:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%rbp, %rsi
	leaq	.LC49(%rip), %rdi
	movq	32(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %r12
	.cfi_restore 12
	xorl	%eax, %eax
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	64(%rsp), %r15
	.cfi_restore 15
	movq	24(%rsp), %rbx
	addq	$72, %rsp
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	jmp	dief@PLT
	.cfi_endproc
.LFE29:
	.size	sem_check_lvalue, .-sem_check_lvalue
	.section	.rodata.str1.8
	.align 8
.LC51:
	.string	"internal: cannot pop global scope"
	.align 8
.LC52:
	.string	"bcc: warning: case label falls through to another case label at %d:%d\n"
	.section	.rodata.str1.1
.LC53:
	.string	"duplicate label '%s' at %d:%d"
	.text
	.p2align 4
	.type	sem_check_stmt, @function
sem_check_stmt:
.LFB31:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L224
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	movq	%rbx, 40(%rsp)
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	movq	%r12, 56(%rsp)
	.cfi_offset 12, -40
	leaq	.L155(%rip), %r12
	movq	%r13, 64(%rsp)
	.cfi_offset 13, -32
	movq	%rdi, %r13
.L153:
	cmpl	$12, (%rbx)
	ja	.L151
	movl	(%rbx), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L155:
	.long	.L151-.L155
	.long	.L163-.L155
	.long	.L162-.L155
	.long	.L161-.L155
	.long	.L160-.L155
	.long	.L159-.L155
	.long	.L158-.L155
	.long	.L157-.L155
	.long	.L151-.L155
	.long	.L151-.L155
	.long	.L151-.L155
	.long	.L156-.L155
	.long	.L154-.L155
	.text
	.p2align 4,,10
	.p2align 3
.L162:
	movq	$0, 8(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L151
	movq	%rbp, 48(%rsp)
	movq	%r14, 72(%rsp)
	movq	%r15, 80(%rsp)
	.cfi_offset 6, -48
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	.p2align 4
	.p2align 3
.L165:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 16(%rsp)
	movq	(%rax), %rbp
	movq	0(%r13), %rax
	movq	16(%rax), %r12
	testq	%r12, %r12
	je	.L170
	movq	8(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L232:
	addq	$1, %r15
	cmpq	%r15, %r12
	je	.L170
.L172:
	movq	(%r14,%r15,8), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L232
	movl	8(%rbx), %edx
	movl	4(%rbx), %esi
	movq	%rbp, %r8
	movl	$10, %ecx
	movq	8(%r13), %rdi
	call	error_at_location@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rbp
.L170:
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
	je	.L174
	movq	%r13, %rdi
	call	sem_check_expr
.L174:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L165
.L230:
	movq	48(%rsp), %rbp
	.cfi_restore 6
	movq	72(%rsp), %r14
	.cfi_restore 14
	movq	80(%rsp), %r15
	.cfi_restore 15
.L151:
	movq	40(%rsp), %rbx
	movq	56(%rsp), %r12
	movq	64(%rsp), %r13
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_restore 3
	.cfi_restore 12
	.cfi_restore 13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L154:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	movq	%r14, 72(%rsp)
	.cfi_offset 14, -24
	call	sem_check_expr
	movq	24(%rbx), %r14
	testq	%r14, %r14
	je	.L229
	cmpl	$1, (%r14)
	jne	.L186
	cmpq	$0, 24(%r14)
	je	.L186
	movq	%rbp, 48(%rsp)
	.cfi_offset 6, -48
	xorl	%ebp, %ebp
	movq	%r15, 80(%rsp)
	.cfi_offset 15, -16
	xorl	%r15d, %r15d
	jmp	.L189
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L187:
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	andl	%eax, %r15d
.L188:
	addq	$1, %rbp
	cmpq	24(%r14), %rbp
	jnb	.L233
.L189:
	movq	16(%r14), %rax
	movq	(%rax,%rbp,8), %rdx
	movl	(%rdx), %eax
	cmpl	$13, %eax
	jne	.L187
	testl	%r15d, %r15d
	jne	.L234
	movl	$1, %r15d
	jmp	.L188
	.p2align 4,,10
	.p2align 3
.L163:
	.cfi_restore 6
	.cfi_restore 14
	.cfi_restore 15
	movq	%rbp, 48(%rsp)
	movl	$32, %edi
	.cfi_offset 6, -48
	movq	0(%r13), %rbp
	call	xmalloc@PLT
	pxor	%xmm0, %xmm0
	movq	%rbp, (%rax)
	movq	$0, 8(%rax)
	movups	%xmm0, 16(%rax)
	movq	%rax, 0(%r13)
	cmpq	$0, 24(%rbx)
	je	.L166
	xorl	%ebp, %ebp
.L167:
	movq	16(%rbx), %rax
	movq	%r13, %rdi
	movq	(%rax,%rbp,8), %rsi
	addq	$1, %rbp
	call	sem_check_stmt
	cmpq	24(%rbx), %rbp
	jb	.L167
	movq	0(%r13), %rax
	movq	(%rax), %rbp
.L166:
	testq	%rbp, %rbp
	je	.L235
.L168:
	movq	%rbp, 0(%r13)
	movq	48(%rsp), %rbp
	.cfi_restore 6
	jmp	.L151
	.p2align 4,,10
	.p2align 3
.L159:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L151
.L231:
	movq	40(%rsp), %rbx
	movq	56(%rsp), %r12
	movq	%r13, %rdi
	movq	64(%rsp), %r13
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_restore 3
	.cfi_restore 12
	.cfi_restore 13
	.cfi_def_cfa_offset 8
	jmp	sem_check_expr
	.p2align 4,,10
	.p2align 3
.L158:
	.cfi_restore_state
	movq	16(%rbx), %rsi
	jmp	.L231
	.p2align 4,,10
	.p2align 3
.L161:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_stmt
	movq	32(%rbx), %rbx
.L175:
	testq	%rbx, %rbx
	jne	.L153
	jmp	.L151
	.p2align 4,,10
	.p2align 3
.L160:
	movq	16(%rbx), %rsi
	movq	%r13, %rdi
	call	sem_check_expr
	movq	24(%rbx), %rbx
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L157:
	movq	$0, 8(%rsp)
	leaq	16(%r13), %rax
	movq	%rax, 16(%rsp)
	cmpq	$0, 24(%rbx)
	je	.L151
	movq	%rbp, 48(%rsp)
	movq	%r14, 72(%rsp)
	movq	%r15, 80(%rsp)
	.cfi_offset 6, -48
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	.p2align 4
	.p2align 3
.L164:
	movq	16(%rbx), %rax
	movq	8(%rsp), %rcx
	movq	24(%r13), %rbp
	movq	(%rax,%rcx,8), %r12
	testq	%rbp, %rbp
	je	.L176
	movq	16(%r13), %r14
	xorl	%r15d, %r15d
	jmp	.L178
	.p2align 4,,10
	.p2align 3
.L236:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L176
.L178:
	movq	(%r14,%r15,8), %rdi
	movq	%r12, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L236
.L177:
	addq	$1, 8(%rsp)
	movq	8(%rsp), %rax
	cmpq	24(%rbx), %rax
	jb	.L164
	jmp	.L230
	.p2align 4,,10
	.p2align 3
.L156:
	.cfi_restore 6
	.cfi_restore 14
	.cfi_restore 15
	movq	0(%r13), %rax
	movq	%r14, 72(%rsp)
	movq	%rbp, 48(%rsp)
	.cfi_offset 14, -24
	.cfi_offset 6, -48
	movq	16(%rbx), %r14
	movq	16(%rax), %rcx
	movq	%r15, 80(%rsp)
	.cfi_offset 15, -16
	movq	%rcx, 8(%rsp)
	testq	%rcx, %rcx
	je	.L180
	movq	8(%rax), %r15
	xorl	%ebp, %ebp
	jmp	.L182
	.p2align 4,,10
	.p2align 3
.L237:
	addq	$1, %rbp
	cmpq	%rbp, 8(%rsp)
	je	.L180
.L182:
	movq	(%r15,%rbp,8), %rax
	movq	%r14, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L237
	movl	8(%rbx), %ecx
	movl	4(%rbx), %edx
	movq	%r14, %rsi
	leaq	.LC53(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	16(%rbx), %r14
.L180:
	movl	$56, %edi
	movq	4(%rbx), %r15
	call	xmalloc@PLT
	movq	%r14, %rdi
	movl	$2, (%rax)
	movq	%rax, %rbp
	call	sdup@PLT
	movq	%r15, 16(%rbp)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbp)
	movq	0(%r13), %rax
	movl	$0, 24(%rbp)
	leaq	8(%rax), %rdi
	call	vec_push@PLT
	movq	24(%rbx), %rbx
	movq	48(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	movq	72(%rsp), %r14
	.cfi_restore 14
	movq	80(%rsp), %r15
	.cfi_restore 15
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L176:
	.cfi_restore_state
	movq	%r12, %rdi
	call	sdup@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L177
.L186:
	.cfi_restore 6
	.cfi_restore 15
	movq	%r14, %rbx
	movq	72(%rsp), %r14
	.cfi_restore 14
	jmp	.L153
.L234:
	.cfi_offset 6, -48
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	8(%rdx), %ecx
	movl	4(%rdx), %edx
	leaq	.LC52(%rip), %rsi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	call	fprintf@PLT
	jmp	.L188
.L233:
	movq	24(%rbx), %rbx
	movq	48(%rsp), %rbp
	.cfi_restore 6
	movq	72(%rsp), %r14
	.cfi_restore 14
	movq	80(%rsp), %r15
	.cfi_restore 15
	jmp	.L175
.L229:
	.cfi_offset 14, -24
	movq	72(%rsp), %r14
	.cfi_restore 14
	jmp	.L151
.L235:
	.cfi_offset 6, -48
	xorl	%eax, %eax
	leaq	.LC51(%rip), %rdi
	call	dief@PLT
	movq	0(%r13), %rax
	movq	(%rax), %rbp
	jmp	.L168
.L224:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE31:
	.size	sem_check_stmt, .-sem_check_stmt
	.section	.rodata.str1.8
	.align 8
.LC54:
	.string	"internal: TOP_GAUTO should be ST_AUTO"
	.align 8
.LC55:
	.string	"duplicate extern definition '%s'"
	.text
	.p2align 4
	.globl	sem_check_program
	.type	sem_check_program, @function
sem_check_program:
.LFB35:
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%rdi, 16(%rsp)
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
	cmpq	$0, 8(%r14)
	je	.L239
	movq	$0, 24(%rsp)
	leaq	16(%r12), %rax
	movq	%rax, 56(%rsp)
	.p2align 4
	.p2align 3
.L263:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	movl	(%rax), %edx
	cmpl	$2, %edx
	je	.L240
	ja	.L241
	testl	%edx, %edx
	je	.L301
	movq	8(%rax), %r13
	movq	0(%r13), %rdi
	call	sdup@PLT
	leaq	40(%r12), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	movq	(%r12), %rax
	movq	0(%r13), %rbx
	movq	16(%rax), %rbp
	testq	%rbp, %rbp
	je	.L254
	movq	8(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L256
	.p2align 4,,10
	.p2align 3
.L302:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L254
.L256:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L302
	movq	8(%r12), %rdi
	movq	%rbx, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
	movq	0(%r13), %rbx
.L254:
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
.L245:
	movq	16(%rsp), %rax
	addq	$1, 24(%rsp)
	movq	8(%rax), %rax
	cmpq	%rax, 24(%rsp)
	jb	.L263
	testq	%rax, %rax
	je	.L239
	movq	$0, 24(%rsp)
	pxor	%xmm3, %xmm3
	movaps	%xmm3, 32(%rsp)
	jmp	.L271
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L264:
	movq	16(%rsp), %rcx
	addq	$1, 24(%rsp)
	movq	24(%rsp), %rax
	cmpq	8(%rcx), %rax
	jnb	.L239
.L271:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	cmpl	$1, (%rax)
	jne	.L264
	movl	$32, %edi
	movq	(%r12), %rbx
	movq	8(%rax), %r13
	call	xmalloc@PLT
	movdqa	32(%rsp), %xmm2
	movq	%rbx, (%rax)
	movq	$0, 8(%rax)
	movups	%xmm2, 16(%rax)
	movq	%rax, (%r12)
	cmpq	$0, 16(%r13)
	je	.L265
	movq	$0, (%rsp)
	xorl	%ebp, %ebp
	.p2align 4
	.p2align 3
.L269:
	movq	8(%r13), %rdx
	movq	(%rsp), %rcx
	movq	(%rdx,%rcx,8), %rbx
	testq	%rbp, %rbp
	je	.L266
	movq	8(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L268
	.p2align 4,,10
	.p2align 3
.L303:
	addq	$1, %r15
	cmpq	%rbp, %r15
	je	.L266
.L268:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L303
	movq	8(%r12), %rdi
	movq	%rbx, %r8
	movl	$10, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	error_at_location@PLT
.L266:
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
	jnb	.L265
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	jmp	.L269
	.p2align 4,,10
	.p2align 3
.L241:
	cmpl	$3, %edx
	jne	.L245
	movq	8(%rax), %rax
	movq	8(%rax), %rdi
	call	sdup@PLT
	movq	56(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L245
	.p2align 4,,10
	.p2align 3
.L265:
	movq	32(%r13), %rsi
	movq	%r12, %rdi
	call	sem_check_stmt
	movq	(%r12), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L304
.L270:
	movq	%rax, (%r12)
	jmp	.L264
	.p2align 4,,10
	.p2align 3
.L301:
	movq	8(%rax), %r14
	cmpl	$2, (%r14)
	je	.L246
	leaq	.LC54(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L246:
	cmpq	$0, 24(%r14)
	je	.L245
	movq	$0, (%rsp)
	.p2align 4
	.p2align 3
.L252:
	movq	16(%r14), %rax
	movq	(%rsp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 32(%rsp)
	movq	(%rax), %rbx
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	testq	%rbp, %rbp
	je	.L248
	movq	8(%rax), %r13
	xorl	%r15d, %r15d
	jmp	.L250
	.p2align 4,,10
	.p2align 3
.L305:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L248
.L250:
	movq	0(%r13,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L305
	movl	8(%r14), %edx
	movl	4(%r14), %esi
	movq	%rbx, %r8
	movl	$10, %ecx
	movq	8(%r12), %rdi
	call	error_at_location@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rbx
.L248:
	movq	4(%r14), %rdx
	movl	$56, %edi
	movq	%rdx, 48(%rsp)
	call	xmalloc@PLT
	movq	%rbx, %rdi
	movl	$0, (%rax)
	movq	%rax, %rbp
	call	sdup@PLT
	movq	48(%rsp), %rdx
	movl	$0, 24(%rbp)
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
	addq	$1, (%rsp)
	movq	(%rsp), %rax
	cmpq	24(%r14), %rax
	jb	.L252
	jmp	.L245
	.p2align 4,,10
	.p2align 3
.L240:
	movq	8(%rax), %r13
	movq	(%r12), %rax
	movq	16(%rax), %rbp
	movq	8(%r13), %rbx
	testq	%rbp, %rbp
	je	.L259
	movq	8(%rax), %r14
	xorl	%r15d, %r15d
	jmp	.L261
	.p2align 4,,10
	.p2align 3
.L306:
	addq	$1, %r15
	cmpq	%r15, %rbp
	je	.L259
.L261:
	movq	(%r14,%r15,8), %rax
	movq	%rbx, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L306
	movq	%rbx, %rsi
	leaq	.LC55(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	8(%r13), %rbx
.L259:
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
	jmp	.L245
.L239:
	cmpq	$0, 72(%r12)
	je	.L238
	pxor	%xmm4, %xmm4
	xorl	%r13d, %r13d
	movaps	%xmm4, (%rsp)
	.p2align 4
	.p2align 3
.L277:
	movq	64(%r12), %rax
	movq	(%rax,%r13,8), %rbp
	movq	16(%rsp), %rax
	movq	8(%rax), %r15
	testq	%r15, %r15
	je	.L273
	movq	(%rax), %r14
	xorl	%ebx, %ebx
	jmp	.L276
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L274:
	addq	$1, %rbx
	cmpq	%r15, %rbx
	je	.L273
.L276:
	movq	(%r14,%rbx,8), %rdx
	movl	(%rdx), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L274
	movq	8(%rdx), %rax
	movq	%rbp, %rsi
	movq	8(%rax), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L274
	addq	$1, %r13
	cmpq	72(%r12), %r13
	jb	.L277
.L238:
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
.L273:
	.cfi_restore_state
	movl	$16, %edi
	addq	$1, %r13
	call	xmalloc@PLT
	movl	$56, %edi
	movl	$2, (%rax)
	movq	%rax, %r15
	call	xmalloc@PLT
	movdqa	(%rsp), %xmm1
	movq	%rbp, %rdi
	movq	$0, 48(%rax)
	movq	%rax, %rbx
	movups	%xmm1, (%rax)
	movl	$1, 4(%rax)
	movups	%xmm1, 16(%rax)
	movups	%xmm1, 32(%rax)
	call	sdup@PLT
	movl	$0, 16(%rbx)
	movq	16(%rsp), %rdi
	movq	%r15, %rsi
	movq	%rax, 8(%rbx)
	movq	$0, 48(%rbx)
	movq	%rbx, 8(%r15)
	call	vec_push@PLT
	cmpq	72(%r12), %r13
	jb	.L277
	jmp	.L238
.L304:
	leaq	.LC51(%rip), %rdi
	call	dief@PLT
	movq	(%r12), %rax
	movq	(%rax), %rax
	jmp	.L270
	.cfi_endproc
.LFE35:
	.size	sem_check_program, .-sem_check_program
	.ident	"GCC: (GNU) 16.1.1 20260430"
	.section	.note.GNU-stack,"",@progbits
