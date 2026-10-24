	.file	"util.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Tokens:"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"  (cannot re-read file for token dump)"
	.section	.rodata.str1.1
.LC3:
	.string	"  %s"
.LC4:
	.string	" '%s'"
.LC5:
	.string	" %ld"
.LC6:
	.string	" at %s:%d:%d\n"
	.text
	.p2align 4
	.globl	dump_token_stream
	.type	dump_token_stream, @function
dump_token_stream:
.LFB15:
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
	movq	%rdi, %rbx
	leaq	.LC0(%rip), %rdi
	subq	$152, %rsp
	.cfi_def_cfa_offset 208
	call	puts@PLT
	movq	32(%rbx), %rdi
	leaq	24(%rsp), %rsi
	call	read_file_all@PLT
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L17
	movq	8(%rsp), %rax
	leaq	32(%rsp), %rbp
	movq	$0, 48(%rsp)
	movq	%rbp, %rsi
	movq	%rax, 32(%rsp)
	movq	24(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	.LC2(%rip), %rax
	movq	%rax, 56(%rsp)
	movq	32(%rbx), %rax
	leaq	80(%rsp), %rbx
	movq	%rbx, %rdi
	movq	%rax, 64(%rsp)
	call	lx_next@PLT
	movl	80(%rsp), %r15d
	movq	88(%rsp), %r14
	testl	%r15d, %r15d
	je	.L4
	leaq	.LC3(%rip), %r13
	leaq	.LC6(%rip), %r12
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L6:
	movl	124(%rsp), %ecx
	movl	120(%rsp), %edx
	movq	%r12, %rdi
	xorl	%eax, %eax
	movq	128(%rsp), %rsi
	call	printf@PLT
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	lx_next@PLT
	movl	80(%rsp), %r15d
	movq	88(%rsp), %r14
	testl	%r15d, %r15d
	je	.L4
.L7:
	movl	%r15d, %edi
	call	tk_name@PLT
	movq	%r13, %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	printf@PLT
	testq	%r14, %r14
	je	.L5
	movq	%r14, %rsi
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
.L5:
	cmpl	$2, %r15d
	jne	.L6
	movq	112(%rsp), %rsi
	leaq	.LC5(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L4:
	movl	$10, %edi
	call	putchar@PLT
	movq	8(%rsp), %rdi
	call	free@PLT
.L1:
	addq	$152, %rsp
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
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	jmp	.L1
	.cfi_endproc
.LFE15:
	.size	dump_token_stream, .-dump_token_stream
	.section	.rodata.str1.1
.LC7:
	.string	"(null)"
.LC8:
	.string	"NUM %ld\n"
.LC9:
	.string	"STR \"%s\"\n"
.LC10:
	.string	"VAR %s\n"
.LC11:
	.string	"UNARY %s\n"
.LC12:
	.string	"BINARY %s\n"
.LC13:
	.string	"ASSIGN %s\n"
.LC14:
	.string	"INDEX"
.LC15:
	.string	"POST %s\n"
.LC16:
	.string	"EXPR kind %d\n"
	.text
	.p2align 4
	.globl	dump_expr
	.type	dump_expr, @function
dump_expr:
.LFB17:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leal	2(%rsi), %r14d
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	.L25(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
.L19:
	testl	%ebp, %ebp
	jle	.L20
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L21:
	movl	$32, %edi
	addl	$1, %ebx
	call	putchar@PLT
	cmpl	%ebp, %ebx
	jne	.L21
.L20:
	testq	%r12, %r12
	je	.L38
	movl	(%r12), %esi
	cmpl	$8, %esi
	ja	.L23
	movl	%esi, %eax
	movslq	0(%r13,%rax,4), %rax
	addq	%r13, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L25:
	.long	.L32-.L25
	.long	.L31-.L25
	.long	.L30-.L25
	.long	.L23-.L25
	.long	.L29-.L25
	.long	.L28-.L25
	.long	.L27-.L25
	.long	.L26-.L25
	.long	.L24-.L25
	.text
	.p2align 4,,10
	.p2align 3
.L24:
	movl	48(%r12), %edi
	call	tk_name@PLT
	leaq	.LC13(%rip), %rdi
	movq	%rax, %rsi
.L36:
	xorl	%eax, %eax
	call	printf@PLT
	movq	56(%r12), %rdi
	movl	%r14d, %esi
	call	dump_expr
	movq	64(%r12), %r12
.L33:
	addl	$2, %ebp
	addl	$2, %r14d
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L26:
	movl	48(%r12), %edi
	call	tk_name@PLT
	leaq	.LC12(%rip), %rdi
	movq	%rax, %rsi
	jmp	.L36
	.p2align 4,,10
	.p2align 3
.L27:
	movl	48(%r12), %edi
	call	tk_name@PLT
	leaq	.LC15(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	printf@PLT
	movq	56(%r12), %r12
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L28:
	movl	48(%r12), %edi
	call	tk_name@PLT
	leaq	.LC11(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	printf@PLT
	movq	56(%r12), %r12
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L29:
	leaq	.LC14(%rip), %rdi
	call	puts@PLT
	movq	48(%r12), %rdi
	movl	%r14d, %esi
	call	dump_expr
	movq	56(%r12), %r12
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L30:
	movq	48(%r12), %rsi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	printf@PLT
	.p2align 4,,10
	.p2align 3
.L31:
	.cfi_restore_state
	movq	48(%r12), %rsi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leaq	.LC9(%rip), %rdi
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	printf@PLT
	.p2align 4,,10
	.p2align 3
.L32:
	.cfi_restore_state
	movq	48(%r12), %rsi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	printf@PLT
	.p2align 4,,10
	.p2align 3
.L23:
	.cfi_restore_state
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leaq	.LC16(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	printf@PLT
.L38:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 40
	leaq	.LC7(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	puts@PLT
	.cfi_endproc
.LFE17:
	.size	dump_expr, .-dump_expr
	.section	.rodata.str1.1
.LC17:
	.string	"EMPTY"
.LC18:
	.string	"BLOCK"
.LC19:
	.string	"AUTO"
.LC20:
	.string	"IF"
.LC21:
	.string	"ELSE"
.LC22:
	.string	"WHILE"
.LC23:
	.string	"RETURN"
.LC24:
	.string	"EXPR"
.LC25:
	.string	"STMT kind %d\n"
	.text
	.p2align 4
	.globl	dump_stmt
	.type	dump_stmt, @function
dump_stmt:
.LFB18:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	.L47(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
.L40:
	xorl	%ebx, %ebx
	testl	%ebp, %ebp
	jle	.L44
	.p2align 4
	.p2align 3
.L41:
	movl	$32, %edi
	addl	$1, %ebx
	call	putchar@PLT
	cmpl	%ebx, %ebp
	jne	.L41
.L44:
	testq	%r12, %r12
	je	.L76
	movl	(%r12), %esi
	cmpl	$6, %esi
	ja	.L45
	movslq	0(%r13,%rsi,4), %rax
	addq	%r13, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L47:
	.long	.L53-.L47
	.long	.L52-.L47
	.long	.L51-.L47
	.long	.L50-.L47
	.long	.L49-.L47
	.long	.L48-.L47
	.long	.L46-.L47
	.text
	.p2align 4,,10
	.p2align 3
.L48:
	leaq	.LC23(%rip), %rdi
	call	puts@PLT
	movq	16(%r12), %rdi
	leal	2(%rbp), %esi
	testq	%rdi, %rdi
	je	.L39
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	dump_expr
	.p2align 4,,10
	.p2align 3
.L46:
	.cfi_restore_state
	leaq	.LC24(%rip), %rdi
	call	puts@PLT
	movq	16(%r12), %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leal	2(%rbp), %esi
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	dump_expr
	.p2align 4,,10
	.p2align 3
.L52:
	.cfi_restore_state
	leaq	.LC18(%rip), %rdi
	addl	$2, %ebp
	xorl	%ebx, %ebx
	call	puts@PLT
	cmpq	$0, 24(%r12)
	je	.L39
.L56:
	movq	16(%r12), %rax
	movl	%ebp, %esi
	movq	(%rax,%rbx,8), %rdi
	addq	$1, %rbx
	call	dump_stmt
	cmpq	24(%r12), %rbx
	jb	.L56
.L39:
	popq	%rbx
	.cfi_remember_state
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
	.p2align 4,,10
	.p2align 3
.L51:
	.cfi_restore_state
	leaq	.LC19(%rip), %rdi
.L74:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	puts@PLT
	.p2align 4,,10
	.p2align 3
.L50:
	.cfi_restore_state
	leaq	.LC20(%rip), %rdi
	leal	2(%rbp), %r14d
	call	puts@PLT
	movq	16(%r12), %rdi
	movl	%r14d, %esi
	call	dump_expr
	movq	24(%r12), %rdi
	movl	%r14d, %esi
	call	dump_stmt
	cmpq	$0, 32(%r12)
	je	.L39
	xorl	%ebx, %ebx
	cmpl	$-1, %ebp
	jl	.L60
	.p2align 4
	.p2align 3
.L58:
	movl	$32, %edi
	call	putchar@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jge	.L58
.L60:
	leaq	.LC21(%rip), %rdi
	call	puts@PLT
	movq	32(%r12), %r12
	jmp	.L59
	.p2align 4,,10
	.p2align 3
.L49:
	leaq	.LC22(%rip), %rdi
	leal	2(%rbp), %r14d
	call	puts@PLT
	movq	16(%r12), %rdi
	movl	%r14d, %esi
	call	dump_expr
	movq	24(%r12), %r12
.L59:
	movl	%r14d, %ebp
	jmp	.L40
	.p2align 4,,10
	.p2align 3
.L53:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leaq	.LC17(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	puts@PLT
.L45:
	.cfi_restore_state
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leaq	.LC25(%rip), %rdi
	popq	%rbp
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	printf@PLT
.L76:
	.cfi_restore_state
	leaq	.LC7(%rip), %rdi
	jmp	.L74
	.cfi_endproc
.LFE18:
	.size	dump_stmt, .-dump_stmt
	.section	.rodata.str1.1
.LC26:
	.string	"AST:"
.LC27:
	.string	"Top level %zu:\n"
.LC28:
	.string	"  GAUTO"
.LC29:
	.string	"  FUNC %s\n"
.LC30:
	.string	"  EXTERN_DEF"
.LC31:
	.string	"  EXTERN_DECL"
	.text
	.p2align 4
	.globl	dump_ast_program
	.type	dump_ast_program, @function
dump_ast_program:
.LFB16:
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
	movq	%rdi, %rbx
	leaq	.LC26(%rip), %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	call	puts@PLT
	cmpq	$0, 8(%rbx)
	je	.L78
	xorl	%r12d, %r12d
	leaq	.LC27(%rip), %rbp
	leaq	.LC30(%rip), %r15
	leaq	.LC31(%rip), %r14
	jmp	.L85
	.p2align 4,,10
	.p2align 3
.L90:
	testl	%eax, %eax
	je	.L89
	movq	8(%r13), %rax
	leaq	.LC29(%rip), %rdi
	movq	(%rax), %rsi
	xorl	%eax, %eax
	call	printf@PLT
	movq	8(%r13), %rax
	movl	$2, %esi
	movq	32(%rax), %rdi
	call	dump_stmt
.L84:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L78
.L85:
	movq	(%rbx), %rax
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movq	(%rax,%r12,8), %r13
	xorl	%eax, %eax
	call	printf@PLT
	movl	0(%r13), %eax
	cmpl	$2, %eax
	je	.L79
	jbe	.L90
	cmpl	$3, %eax
	jne	.L84
	movq	%r14, %rdi
	addq	$1, %r12
	call	puts@PLT
	cmpq	8(%rbx), %r12
	jb	.L85
.L78:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	$10, %edi
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
	jmp	putchar@PLT
	.p2align 4,,10
	.p2align 3
.L79:
	.cfi_restore_state
	movq	%r15, %rdi
	call	puts@PLT
	jmp	.L84
	.p2align 4,,10
	.p2align 3
.L89:
	leaq	.LC28(%rip), %rdi
	call	puts@PLT
	jmp	.L84
	.cfi_endproc
.LFE16:
	.size	dump_ast_program, .-dump_ast_program
	.section	.rodata.str1.1
.LC32:
	.string	"bcc: "
	.text
	.p2align 4
	.globl	dief
	.type	dief, @function
dief:
.LFB19:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	subq	$208, %rsp
	.cfi_def_cfa_offset 224
	movq	%rsi, 40(%rsp)
	movq	%rdx, 48(%rsp)
	movq	%rcx, 56(%rsp)
	movq	%r8, 64(%rsp)
	movq	%r9, 72(%rsp)
	testb	%al, %al
	je	.L93
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm1, 96(%rsp)
	movaps	%xmm2, 112(%rsp)
	movaps	%xmm3, 128(%rsp)
	movaps	%xmm4, 144(%rsp)
	movaps	%xmm5, 160(%rsp)
	movaps	%xmm6, 176(%rsp)
	movaps	%xmm7, 192(%rsp)
.L93:
	movq	stderr(%rip), %rcx
	movl	$5, %edx
	leaq	224(%rsp), %rax
	movl	$1, %esi
	movq	%rax, 16(%rsp)
	leaq	.LC32(%rip), %rdi
	leaq	32(%rsp), %rax
	movl	$8, 8(%rsp)
	movl	$48, 12(%rsp)
	movq	%rax, 24(%rsp)
	call	fwrite@PLT
	movq	stderr(%rip), %rdi
	leaq	8(%rsp), %rdx
	movq	%rbx, %rsi
	call	vfprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE19:
	.size	dief, .-dief
	.section	.rodata.str1.1
.LC33:
	.string	"%s:%d:%d: "
.LC34:
	.string	"sx %s:%d\n"
.LC35:
	.string	"    "
.LC36:
	.string	"^\n"
	.text
	.p2align 4
	.globl	error_at
	.type	error_at, @function
error_at:
.LFB20:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	subq	$216, %rsp
	.cfi_def_cfa_offset 256
	movq	%rcx, 56(%rsp)
	movq	%r8, 64(%rsp)
	movq	%r9, 72(%rsp)
	testb	%al, %al
	je	.L112
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm1, 96(%rsp)
	movaps	%xmm2, 112(%rsp)
	movaps	%xmm3, 128(%rsp)
	movaps	%xmm4, 144(%rsp)
	movaps	%xmm5, 160(%rsp)
	movaps	%xmm6, 176(%rsp)
	movaps	%xmm7, 192(%rsp)
.L112:
	leaq	256(%rsp), %rax
	movl	40(%r12), %ecx
	movq	48(%r12), %rdx
	movl	$24, 8(%rsp)
	movq	%rax, 16(%rsp)
	leaq	32(%rsp), %rax
	movq	stderr(%rip), %rdi
	movq	%rax, 24(%rsp)
	movl	g_verbose_errors(%rip), %eax
	movl	$48, 12(%rsp)
	testl	%eax, %eax
	je	.L97
	movl	44(%r12), %r8d
	leaq	.LC33(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	stderr(%rip), %rdi
	movq	%rbp, %rsi
	leaq	8(%rsp), %rdx
	call	vfprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
.L98:
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	1(%rbx), %rdx
	movl	$1, %ecx
	addq	%rdx, %rax
	jmp	.L99
	.p2align 4,,10
	.p2align 3
.L129:
	cmpl	%ecx, 40(%r12)
	jle	.L101
	cmpb	$10, -1(%rdx)
	jne	.L100
	addl	$1, %ecx
	movq	%rdx, %rbx
.L100:
	addq	$1, %rdx
.L99:
	cmpq	%rdx, %rax
	jne	.L129
.L101:
	movzbl	(%rbx), %eax
	movq	stderr(%rip), %rcx
	testb	%al, %al
	je	.L103
	cmpb	$10, %al
	je	.L103
	movq	%rbx, %rbp
	.p2align 4
	.p2align 4
	.p2align 3
.L104:
	movzbl	1(%rbp), %eax
	addq	$1, %rbp
	testb	%al, %al
	je	.L113
	cmpb	$10, %al
	jne	.L104
.L113:
	leaq	.LC35(%rip), %r13
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	cmpq	%rbp, %rbx
	jnb	.L107
	.p2align 4
	.p2align 3
.L106:
	movsbl	(%rbx), %edi
	movq	stderr(%rip), %rsi
	addq	$1, %rbx
	call	fputc@PLT
	cmpq	%rbp, %rbx
	jne	.L106
.L107:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	movl	$1, %ebx
	call	fputc@PLT
	movq	stderr(%rip), %rcx
	movl	$4, %edx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	cmpl	$1, 44(%r12)
	jle	.L110
	.p2align 4
	.p2align 3
.L109:
	movq	stderr(%rip), %rsi
	movl	$32, %edi
	addl	$1, %ebx
	call	fputc@PLT
	cmpl	%ebx, 44(%r12)
	jg	.L109
.L110:
	movq	stderr(%rip), %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L97:
	leaq	.LC34(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L98
.L103:
	leaq	.LC35(%rip), %r13
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	jmp	.L107
	.cfi_endproc
.LFE20:
	.size	error_at, .-error_at
	.section	.rodata.str1.1
.LC37:
	.string	"out of memory"
	.text
	.p2align 4
	.globl	xstrdup_range
	.type	xstrdup_range, @function
xstrdup_range:
.LFB23:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdx, %r12
	xorl	%eax, %eax
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	movq	g_compilation_arena(%rip), %rdi
	subq	%rsi, %r12
	cmpq	%rdx, %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rsi, %rbx
	cmovnb	%rax, %r12
	testq	%rdi, %rdi
	je	.L132
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rbp, %rsi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	arena_xstrdup_range@PLT
	.p2align 4,,10
	.p2align 3
.L132:
	.cfi_restore_state
	leaq	1(%r12), %rdi
	call	malloc@PLT
	testq	%rax, %rax
	je	.L136
	leaq	0(%rbp,%rbx), %rsi
	movq	%r12, %rdx
	movq	%rax, %rdi
	call	memcpy@PLT
	movb	$0, (%rax,%r12)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L136:
	.cfi_restore_state
	leaq	.LC37(%rip), %rdi
	xorl	%eax, %eax
	call	dief
	.cfi_endproc
.LFE23:
	.size	xstrdup_range, .-xstrdup_range
	.p2align 4
	.globl	sdup
	.type	sdup, @function
sdup:
.LFB24:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L141
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	g_compilation_arena(%rip), %rdi
	testq	%rdi, %rdi
	je	.L139
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbx, %rsi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	jmp	arena_sdup@PLT
	.p2align 4,,10
	.p2align 3
.L139:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	1(%rax), %rbp
	movq	%rbp, %rdi
	call	malloc@PLT
	testq	%rax, %rax
	je	.L146
	movq	%rbp, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L141:
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
.L146:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	leaq	.LC37(%rip), %rdi
	xorl	%eax, %eax
	call	dief
	.cfi_endproc
.LFE24:
	.size	sdup, .-sdup
	.section	.rodata.str1.1
.LC38:
	.string	"%s/%s"
	.text
	.p2align 4
	.globl	resolve_include_path
	.type	resolve_include_path, @function
resolve_include_path:
.LFB14:
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
	xorl	%esi, %esi
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	call	access@PLT
	testl	%eax, %eax
	je	.L168
	testq	%rbx, %rbx
	je	.L149
	movl	$47, %esi
	movq	%rbx, %rdi
	call	strrchr@PLT
	testq	%rax, %rax
	je	.L149
	subq	%rbx, %rax
	movq	%r12, %rdi
	movq	%rax, %rbp
	leaq	1(%rax), %r14
	call	strlen@PLT
	leaq	2(%rbp,%rax), %rdi
	movq	%rax, %r13
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L154
	movq	%r14, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	leaq	0(%rbp,%r14), %rdi
	leaq	1(%r13), %rdx
	movq	%r12, %rsi
	call	memcpy@PLT
	movq	%rbp, %rdi
	xorl	%esi, %esi
	call	access@PLT
	movq	%rbp, %rdi
	testl	%eax, %eax
	je	.L169
	call	free@PLT
.L149:
	cmpq	$0, 8+g_include_paths(%rip)
	je	.L153
	xorl	%ebp, %ebp
	leaq	g_include_paths(%rip), %r14
	leaq	.LC38(%rip), %r13
	jmp	.L156
	.p2align 4,,10
	.p2align 3
.L155:
	call	free@PLT
	addq	$1, %rbp
	cmpq	8+g_include_paths(%rip), %rbp
	jnb	.L153
.L156:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %r15
	movq	%r15, %rdi
	call	strlen@PLT
	movq	%r12, %rdi
	movq	%rax, %rbx
	call	strlen@PLT
	leaq	2(%rbx,%rax), %rdi
	call	malloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L154
	movq	%rax, %rdi
	movq	%r12, %rcx
	movq	%r15, %rdx
	movq	%r13, %rsi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	%rbx, %rdi
	xorl	%esi, %esi
	call	access@PLT
	movq	%rbx, %rdi
	testl	%eax, %eax
	jne	.L155
	call	sdup
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	free@PLT
.L147:
	addq	$8, %rsp
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
.L153:
	.cfi_restore_state
	xorl	%r12d, %r12d
	jmp	.L147
	.p2align 4,,10
	.p2align 3
.L168:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rdi
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
	jmp	sdup
	.p2align 4,,10
	.p2align 3
.L169:
	.cfi_restore_state
	call	sdup
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	free@PLT
	jmp	.L147
.L154:
	leaq	.LC37(%rip), %rdi
	xorl	%eax, %eax
	call	dief
	.cfi_endproc
.LFE14:
	.size	resolve_include_path, .-resolve_include_path
	.section	.rodata.str1.1
.LC39:
	.string	"fmt: vsnprintf failed"
	.text
	.p2align 4
	.globl	fmt
	.type	fmt, @function
fmt:
.LFB25:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$224, %rsp
	.cfi_def_cfa_offset 256
	movq	%rsi, 56(%rsp)
	movq	%rdx, 64(%rsp)
	movq	%rcx, 72(%rsp)
	movq	%r8, 80(%rsp)
	movq	%r9, 88(%rsp)
	testb	%al, %al
	je	.L176
	movaps	%xmm0, 96(%rsp)
	movaps	%xmm1, 112(%rsp)
	movaps	%xmm2, 128(%rsp)
	movaps	%xmm3, 144(%rsp)
	movaps	%xmm4, 160(%rsp)
	movaps	%xmm5, 176(%rsp)
	movaps	%xmm6, 192(%rsp)
	movaps	%xmm7, 208(%rsp)
.L176:
	leaq	256(%rsp), %rax
	xorl	%esi, %esi
	xorl	%edi, %edi
	movq	%rsp, %rcx
	movq	%rax, 8(%rsp)
	movq	%r12, %rdx
	leaq	48(%rsp), %rax
	movl	$8, (%rsp)
	movl	$48, 4(%rsp)
	movdqu	(%rsp), %xmm0
	movq	%rax, 16(%rsp)
	movq	%rax, 40(%rsp)
	movups	%xmm0, 24(%rsp)
	call	vsnprintf@PLT
	testl	%eax, %eax
	js	.L178
	movq	g_compilation_arena(%rip), %rdi
	cltq
	leaq	1(%rax), %rbx
	testq	%rdi, %rdi
	je	.L173
	movq	%rbx, %rsi
	call	arena_alloc@PLT
	movq	%rax, %rbp
.L174:
	testq	%rbp, %rbp
	je	.L179
	leaq	24(%rsp), %rcx
	movq	%r12, %rdx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	vsnprintf@PLT
	addq	$224, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L173:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	jmp	.L174
.L178:
	leaq	.LC39(%rip), %rdi
	xorl	%eax, %eax
	call	dief
.L179:
	leaq	.LC37(%rip), %rdi
	xorl	%eax, %eax
	call	dief
	.cfi_endproc
.LFE25:
	.size	fmt, .-fmt
	.p2align 4
	.globl	vec_new
	.type	vec_new, @function
vec_new:
.LFB26:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	g_compilation_arena(%rip), %rdi
	movl	$24, %esi
	testq	%rdi, %rdi
	je	.L181
	call	arena_alloc@PLT
	pxor	%xmm0, %xmm0
	movq	$0, 16(%rax)
	movups	%xmm0, (%rax)
.L180:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L181:
	.cfi_restore_state
	movl	$1, %edi
	call	calloc@PLT
	testq	%rax, %rax
	jne	.L180
	leaq	.LC37(%rip), %rdi
	call	dief
	.cfi_endproc
.LFE26:
	.size	vec_new, .-vec_new
	.p2align 4
	.globl	vec_push
	.type	vec_push, @function
vec_push:
.LFB27:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	8(%rdi), %rsi
	cmpq	16(%rdi), %rsi
	je	.L185
	movq	(%rdi), %rcx
.L186:
	leaq	1(%rsi), %rax
	movq	%rax, 8(%rbx)
	movq	%rbp, (%rcx,%rsi,8)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L185:
	.cfi_restore_state
	testq	%rsi, %rsi
	jne	.L196
	movq	g_compilation_arena(%rip), %rdi
	movl	$64, %esi
	movl	$8, %r12d
	testq	%rdi, %rdi
	je	.L188
.L197:
	call	arena_alloc@PLT
	movq	(%rbx), %rsi
	movq	%rax, %rcx
	testq	%rsi, %rsi
	je	.L190
	movq	8(%rbx), %rax
	movq	%rcx, %rdi
	leaq	0(,%rax,8), %rdx
	call	memcpy@PLT
	movq	%rax, %rcx
.L190:
	movq	%rcx, (%rbx)
	movq	8(%rbx), %rsi
	movq	%r12, 16(%rbx)
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L196:
	movq	g_compilation_arena(%rip), %rdi
	leaq	(%rsi,%rsi), %r12
	salq	$4, %rsi
	testq	%rdi, %rdi
	jne	.L197
.L188:
	movq	(%rbx), %rdi
	call	realloc@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	jne	.L190
	leaq	.LC37(%rip), %rdi
	xorl	%eax, %eax
	call	dief
	.cfi_endproc
.LFE27:
	.size	vec_push, .-vec_push
	.p2align 4
	.globl	xmalloc
	.type	xmalloc, @function
xmalloc:
.LFB28:
	.cfi_startproc
	movq	g_compilation_arena(%rip), %rax
	testq	%rax, %rax
	je	.L199
	movq	%rdi, %rsi
	movq	%rax, %rdi
	jmp	arena_alloc@PLT
	.p2align 4,,10
	.p2align 3
.L199:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	malloc@PLT
	testq	%rax, %rax
	je	.L203
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L203:
	.cfi_restore_state
	leaq	.LC37(%rip), %rdi
	call	dief
	.cfi_endproc
.LFE28:
	.size	xmalloc, .-xmalloc
	.section	.rodata.str1.1
.LC40:
	.string	"$)"
.LC41:
	.string	"()"
.LC42:
	.string	"*/"
.LC43:
	.string	"[]"
.LC44:
	.string	">c"
.LC45:
	.string	">e"
.LC46:
	.string	">i"
.LC47:
	.string	">s"
.LC48:
	.string	"ex"
.LC49:
	.string	"lv"
.LC50:
	.string	"rd"
.LC51:
	.string	"sx"
.LC52:
	.string	"un"
.LC53:
	.string	"xx"
.LC54:
	.string	"??"
	.text
	.p2align 4
	.globl	get_error_code
	.type	get_error_code, @function
get_error_code:
.LFB29:
	.cfi_startproc
	cmpl	$13, %edi
	ja	.L205
	leaq	.L207(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L207:
	.long	.L220-.L207
	.long	.L221-.L207
	.long	.L218-.L207
	.long	.L217-.L207
	.long	.L216-.L207
	.long	.L215-.L207
	.long	.L214-.L207
	.long	.L213-.L207
	.long	.L212-.L207
	.long	.L211-.L207
	.long	.L210-.L207
	.long	.L209-.L207
	.long	.L208-.L207
	.long	.L206-.L207
	.text
	.p2align 4,,10
	.p2align 3
.L221:
	leaq	.LC41(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L220:
	leaq	.LC40(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L206:
	leaq	.LC53(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L217:
	leaq	.LC43(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L216:
	leaq	.LC44(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L215:
	leaq	.LC45(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L214:
	leaq	.LC46(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L218:
	leaq	.LC42(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L209:
	leaq	.LC51(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L208:
	leaq	.LC52(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L213:
	leaq	.LC47(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L212:
	leaq	.LC48(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L211:
	leaq	.LC49(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L210:
	leaq	.LC50(%rip), %rax
	ret
.L205:
	leaq	.LC54(%rip), %rax
	ret
	.cfi_endproc
.LFE29:
	.size	get_error_code, .-get_error_code
	.section	.rodata.str1.1
.LC55:
	.string	"{} imbalance"
.LC56:
	.string	"() imbalance"
.LC57:
	.string	"/* */ imbalance"
.LC58:
	.string	"[] imbalance"
.LC59:
	.string	"case table overflow (fatal)"
	.section	.rodata.str1.8
	.align 8
.LC60:
	.string	"expression stack overflow (fatal)"
	.section	.rodata.str1.1
.LC61:
	.string	"label table overflow (fatal)"
.LC62:
	.string	"symbol table overflow (fatal)"
.LC63:
	.string	"expression syntax"
.LC64:
	.string	"rvalue where lvalue expected"
.LC65:
	.string	"name redeclaration"
.LC66:
	.string	"statement syntax"
.LC67:
	.string	"undefined name"
.LC68:
	.string	"external syntax"
.LC69:
	.string	"unknown error"
	.text
	.p2align 4
	.globl	get_error_message
	.type	get_error_message, @function
get_error_message:
.LFB30:
	.cfi_startproc
	cmpl	$13, %edi
	ja	.L223
	leaq	.L225(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L225:
	.long	.L238-.L225
	.long	.L239-.L225
	.long	.L236-.L225
	.long	.L235-.L225
	.long	.L234-.L225
	.long	.L233-.L225
	.long	.L232-.L225
	.long	.L231-.L225
	.long	.L230-.L225
	.long	.L229-.L225
	.long	.L228-.L225
	.long	.L227-.L225
	.long	.L226-.L225
	.long	.L224-.L225
	.text
	.p2align 4,,10
	.p2align 3
.L239:
	leaq	.LC56(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L238:
	leaq	.LC55(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L224:
	leaq	.LC68(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L235:
	leaq	.LC58(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L234:
	leaq	.LC59(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L233:
	leaq	.LC60(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L232:
	leaq	.LC61(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L236:
	leaq	.LC57(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L227:
	leaq	.LC66(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L226:
	leaq	.LC67(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L231:
	leaq	.LC62(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L230:
	leaq	.LC63(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L229:
	leaq	.LC64(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L228:
	leaq	.LC65(%rip), %rax
	ret
.L223:
	leaq	.LC69(%rip), %rax
	ret
	.cfi_endproc
.LFE30:
	.size	get_error_message, .-get_error_message
	.section	.rodata.str1.1
.LC70:
	.string	"%s:%d:%d: error: %s"
.LC71:
	.string	"%s %s:%d\n"
	.text
	.p2align 4
	.globl	error_at_code
	.type	error_at_code, @function
error_at_code:
.LFB21:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	movl	%edx, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rcx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movl	g_verbose_errors(%rip), %eax
	movl	40(%r12), %ecx
	movq	48(%r12), %rsi
	movq	stderr(%rip), %r10
	testl	%eax, %eax
	je	.L241
	call	get_error_message
	movl	44(%r12), %r8d
	movq	%rsi, %rdx
	movq	%r10, %rdi
	movq	%rax, %r9
	leaq	.LC70(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	testq	%rbp, %rbp
	je	.L242
	cmpb	$0, 0(%rbp)
	jne	.L276
.L242:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
.L243:
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	1(%rbx), %rdx
	movl	$1, %ecx
	addq	%rdx, %rax
	jmp	.L244
	.p2align 4,,10
	.p2align 3
.L277:
	cmpl	%ecx, 40(%r12)
	jle	.L246
	cmpb	$10, -1(%rdx)
	jne	.L245
	addl	$1, %ecx
	movq	%rdx, %rbx
.L245:
	addq	$1, %rdx
.L244:
	cmpq	%rdx, %rax
	jne	.L277
.L246:
	movzbl	(%rbx), %eax
	movq	stderr(%rip), %rcx
	testb	%al, %al
	je	.L248
	cmpb	$10, %al
	je	.L248
	movq	%rbx, %rbp
	.p2align 4
	.p2align 4
	.p2align 3
.L249:
	movzbl	1(%rbp), %eax
	addq	$1, %rbp
	testb	%al, %al
	je	.L257
	cmpb	$10, %al
	jne	.L249
.L257:
	leaq	.LC35(%rip), %r13
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	cmpq	%rbp, %rbx
	jnb	.L252
	.p2align 4
	.p2align 3
.L251:
	movsbl	(%rbx), %edi
	movq	stderr(%rip), %rsi
	addq	$1, %rbx
	call	fputc@PLT
	cmpq	%rbp, %rbx
	jne	.L251
.L252:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	movl	$1, %ebx
	call	fputc@PLT
	movq	stderr(%rip), %rcx
	movl	$4, %edx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	cmpl	$1, 44(%r12)
	jle	.L255
	.p2align 4
	.p2align 3
.L254:
	movq	stderr(%rip), %rsi
	movl	$32, %edi
	addl	$1, %ebx
	call	fputc@PLT
	cmpl	%ebx, 44(%r12)
	jg	.L254
.L255:
	movq	stderr(%rip), %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L241:
	call	get_error_code
	movl	%ecx, %r8d
	movq	%r10, %rdi
	movq	%rsi, %rcx
	movq	%rax, %rdx
	leaq	.LC71(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L243
.L276:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rdx
	leaq	.LC4(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L242
.L248:
	leaq	.LC35(%rip), %r13
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	jmp	.L252
	.cfi_endproc
.LFE21:
	.size	error_at_code, .-error_at_code
	.p2align 4
	.globl	error_at_location
	.type	error_at_location, @function
error_at_location:
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %r10
	movl	%ecx, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movl	g_verbose_errors(%rip), %eax
	movq	stderr(%rip), %rbp
	testl	%eax, %eax
	je	.L279
	movl	%edx, %r11d
	movq	%r8, %rbx
	movl	%esi, %ecx
	call	get_error_message
	movl	%r11d, %r8d
	movq	%r10, %rdx
	movq	%rbp, %rdi
	movq	%rax, %r9
	leaq	.LC70(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	testq	%rbx, %rbx
	je	.L280
	cmpb	$0, (%rbx)
	jne	.L286
.L280:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
.L281:
	movl	$1, %edi
	call	exit@PLT
.L279:
	call	get_error_code
	movl	%esi, %r8d
	movq	%r10, %rcx
	movq	%rbp, %rdi
	movq	%rax, %rdx
	leaq	.LC71(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L281
.L286:
	movq	stderr(%rip), %rdi
	movq	%rbx, %rdx
	leaq	.LC4(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L280
	.cfi_endproc
.LFE22:
	.size	error_at_location, .-error_at_location
	.globl	g_pedantic
	.bss
	.align 4
	.type	g_pedantic, @object
	.size	g_pedantic, 4
g_pedantic:
	.zero	4
	.globl	g_extensions
	.data
	.align 4
	.type	g_extensions, @object
	.size	g_extensions, 4
g_extensions:
	.long	65535
	.globl	g_strict
	.bss
	.align 4
	.type	g_strict, @object
	.size	g_strict, 4
g_strict:
	.zero	4
	.globl	g_use_curses
	.align 4
	.type	g_use_curses, @object
	.size	g_use_curses, 4
g_use_curses:
	.zero	4
	.globl	g_verbose_errors
	.align 4
	.type	g_verbose_errors, @object
	.size	g_verbose_errors, 4
g_verbose_errors:
	.zero	4
	.globl	g_no_line
	.align 4
	.type	g_no_line, @object
	.size	g_no_line, 4
g_no_line:
	.zero	4
	.globl	g_known_variables
	.align 16
	.type	g_known_variables, @object
	.size	g_known_variables, 24
g_known_variables:
	.zero	24
	.globl	g_known_functions
	.align 16
	.type	g_known_functions, @object
	.size	g_known_functions, 24
g_known_functions:
	.zero	24
	.globl	g_parsing_files
	.align 16
	.type	g_parsing_files, @object
	.size	g_parsing_files, 24
g_parsing_files:
	.zero	24
	.globl	g_included_files
	.align 16
	.type	g_included_files, @object
	.size	g_included_files, 24
g_included_files:
	.zero	24
	.globl	g_include_paths
	.align 16
	.type	g_include_paths, @object
	.size	g_include_paths, 24
g_include_paths:
	.zero	24
	.globl	g_compilation_arena
	.align 8
	.type	g_compilation_arena, @object
	.size	g_compilation_arena, 8
g_compilation_arena:
	.zero	8
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	1
	.long	1
	.section	.note.GNU-stack,"",@progbits
