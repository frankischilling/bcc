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
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	movq	%rbx, 128(%rsp)
	.cfi_offset 3, -32
	movq	%fs:40, %rbx
	movq	%rbx, 120(%rsp)
	movq	%rdi, %rbx
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	leaq	8(%rsp), %rsi
	movq	32(%rbx), %rdi
	call	read_file_all@PLT
	testq	%rax, %rax
	je	.L18
	movq	%rax, 16(%rsp)
	leaq	16(%rsp), %rsi
	leaq	64(%rsp), %rdi
	movq	%r12, 144(%rsp)
	.cfi_offset 12, -16
	movq	%rax, %r12
	movq	8(%rsp), %rax
	movq	$0, 32(%rsp)
	movq	%rax, 24(%rsp)
	movabsq	$4294967297, %rax
	movq	%rax, 40(%rsp)
	movq	32(%rbx), %rax
	movq	%rax, 48(%rsp)
	call	lx_next@PLT
	movl	64(%rsp), %ebx
	testl	%ebx, %ebx
	je	.L4
	movq	%rbp, 136(%rsp)
	.cfi_offset 6, -24
	movq	72(%rsp), %rbp
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L6:
	movl	100(%rsp), %ecx
	movl	96(%rsp), %edx
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	movq	104(%rsp), %rsi
	call	printf@PLT
	leaq	16(%rsp), %rsi
	leaq	64(%rsp), %rdi
	call	lx_next@PLT
	movl	64(%rsp), %ebx
	movq	72(%rsp), %rbp
	testl	%ebx, %ebx
	je	.L19
.L7:
	movl	%ebx, %edi
	call	tk_name@PLT
	leaq	.LC3(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	printf@PLT
	testq	%rbp, %rbp
	je	.L5
	movq	%rbp, %rsi
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
.L5:
	cmpl	$2, %ebx
	jne	.L6
	movq	88(%rsp), %rsi
	leaq	.LC5(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L19:
	movq	136(%rsp), %rbp
	.cfi_restore 6
.L4:
	movl	$10, %edi
	call	putchar@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	144(%rsp), %r12
	.cfi_restore 12
.L1:
	movq	120(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L20
	movq	128(%rsp), %rbx
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L18:
	.cfi_restore_state
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	jmp	.L1
.L20:
	movq	%rbp, 136(%rsp)
	movq	%r12, 144(%rsp)
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	call	__stack_chk_fail@PLT
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
	leaq	.L28(%rip), %r13
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
.L22:
	testl	%ebp, %ebp
	jle	.L23
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L24:
	movl	$32, %edi
	addl	$1, %ebx
	call	putchar@PLT
	cmpl	%ebp, %ebx
	jne	.L24
.L23:
	testq	%r12, %r12
	je	.L41
	movl	(%r12), %esi
	cmpl	$8, %esi
	ja	.L26
	movl	%esi, %eax
	movslq	0(%r13,%rax,4), %rax
	addq	%r13, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L28:
	.long	.L35-.L28
	.long	.L34-.L28
	.long	.L33-.L28
	.long	.L26-.L28
	.long	.L32-.L28
	.long	.L31-.L28
	.long	.L30-.L28
	.long	.L29-.L28
	.long	.L27-.L28
	.text
	.p2align 4,,10
	.p2align 3
.L27:
	movl	16(%r12), %edi
	call	tk_name@PLT
	leaq	.LC13(%rip), %rdi
	movq	%rax, %rsi
.L39:
	xorl	%eax, %eax
	call	printf@PLT
	movq	24(%r12), %rdi
	movl	%r14d, %esi
	call	dump_expr
	movq	32(%r12), %r12
.L36:
	addl	$2, %ebp
	addl	$2, %r14d
	jmp	.L22
	.p2align 4,,10
	.p2align 3
.L29:
	movl	16(%r12), %edi
	call	tk_name@PLT
	leaq	.LC12(%rip), %rdi
	movq	%rax, %rsi
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L30:
	movl	16(%r12), %edi
	call	tk_name@PLT
	leaq	.LC15(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	printf@PLT
	movq	24(%r12), %r12
	jmp	.L36
	.p2align 4,,10
	.p2align 3
.L31:
	movl	16(%r12), %edi
	call	tk_name@PLT
	leaq	.LC11(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	printf@PLT
	movq	24(%r12), %r12
	jmp	.L36
	.p2align 4,,10
	.p2align 3
.L32:
	leaq	.LC14(%rip), %rdi
	call	puts@PLT
	movq	16(%r12), %rdi
	movl	%r14d, %esi
	call	dump_expr
	movq	24(%r12), %r12
	jmp	.L36
	.p2align 4,,10
	.p2align 3
.L33:
	movq	16(%r12), %rsi
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
.L34:
	.cfi_restore_state
	movq	16(%r12), %rsi
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
.L35:
	.cfi_restore_state
	movq	16(%r12), %rsi
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
.L26:
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
.L41:
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, (%rsp)
	movq	%rbp, 8(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	movl	%esi, %ebp
	movq	%r12, 16(%rsp)
	.cfi_offset 12, -32
	movq	%rdi, %r12
	movq	%r13, 24(%rsp)
	.cfi_offset 13, -24
	leaq	.L49(%rip), %r13
.L43:
	testl	%ebp, %ebp
	jle	.L44
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L45:
	movl	$32, %edi
	addl	$1, %ebx
	call	putchar@PLT
	cmpl	%ebx, %ebp
	jne	.L45
.L44:
	testq	%r12, %r12
	je	.L71
	movl	(%r12), %esi
	cmpl	$6, %esi
	ja	.L47
	movslq	0(%r13,%rsi,4), %rax
	addq	%r13, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L49:
	.long	.L55-.L49
	.long	.L54-.L49
	.long	.L53-.L49
	.long	.L52-.L49
	.long	.L51-.L49
	.long	.L50-.L49
	.long	.L48-.L49
	.text
	.p2align 4,,10
	.p2align 3
.L50:
	leaq	.LC23(%rip), %rdi
	call	puts@PLT
	movq	16(%r12), %rdi
	leal	2(%rbp), %esi
	testq	%rdi, %rdi
	je	.L42
.L70:
	movq	(%rsp), %rbx
	movq	8(%rsp), %rbp
	movq	16(%rsp), %r12
	movq	24(%rsp), %r13
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	dump_expr
	.p2align 4,,10
	.p2align 3
.L48:
	.cfi_restore_state
	leaq	.LC24(%rip), %rdi
	call	puts@PLT
	movq	16(%r12), %rdi
	leal	2(%rbp), %esi
	jmp	.L70
	.p2align 4,,10
	.p2align 3
.L54:
	leaq	.LC18(%rip), %rdi
	call	puts@PLT
	cmpq	$0, 24(%r12)
	je	.L42
	addl	$2, %ebp
	xorl	%ebx, %ebx
.L57:
	movq	16(%r12), %rax
	movl	%ebp, %esi
	movq	(%rax,%rbx,8), %rdi
	addq	$1, %rbx
	call	dump_stmt
	cmpq	24(%r12), %rbx
	jb	.L57
.L42:
	movq	(%rsp), %rbx
	movq	8(%rsp), %rbp
	movq	16(%rsp), %r12
	movq	24(%rsp), %r13
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L53:
	.cfi_restore_state
	leaq	.LC19(%rip), %rdi
.L69:
	movq	(%rsp), %rbx
	movq	8(%rsp), %rbp
	movq	16(%rsp), %r12
	movq	24(%rsp), %r13
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	puts@PLT
	.p2align 4,,10
	.p2align 3
.L52:
	.cfi_restore_state
	leaq	.LC20(%rip), %rdi
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	leal	2(%rbp), %r14d
	call	puts@PLT
	movq	16(%r12), %rdi
	leal	2(%rbp), %esi
	call	dump_expr
	movq	24(%r12), %rdi
	leal	2(%rbp), %esi
	call	dump_stmt
	cmpq	$0, 32(%r12)
	je	.L68
	cmpl	$-1, %ebp
	jl	.L58
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L59:
	movl	$32, %edi
	call	putchar@PLT
	movl	%ebx, %eax
	addl	$1, %ebx
	cmpl	%eax, %ebp
	jge	.L59
.L58:
	leaq	.LC21(%rip), %rdi
	call	puts@PLT
	movq	32(%r12), %r12
	jmp	.L60
	.p2align 4,,10
	.p2align 3
.L51:
	.cfi_restore 14
	leaq	.LC22(%rip), %rdi
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	leal	2(%rbp), %r14d
	call	puts@PLT
	movq	16(%r12), %rdi
	leal	2(%rbp), %esi
	call	dump_expr
	movq	24(%r12), %r12
.L60:
	movl	%r14d, %ebp
	movq	32(%rsp), %r14
	.cfi_restore 14
	jmp	.L43
	.p2align 4,,10
	.p2align 3
.L55:
	leaq	.LC17(%rip), %rdi
	jmp	.L69
.L47:
	movq	(%rsp), %rbx
	movq	8(%rsp), %rbp
	xorl	%eax, %eax
	leaq	.LC25(%rip), %rdi
	movq	16(%rsp), %r12
	movq	24(%rsp), %r13
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	printf@PLT
.L71:
	.cfi_restore_state
	leaq	.LC7(%rip), %rdi
	jmp	.L69
.L68:
	.cfi_offset 14, -16
	movq	32(%rsp), %r14
	.cfi_restore 14
	jmp	.L42
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%r12, 16(%rsp)
	.cfi_offset 12, -16
	movq	%rdi, %r12
	leaq	.LC26(%rip), %rdi
	call	puts@PLT
	cmpq	$0, 8(%r12)
	je	.L73
	movq	%rbx, (%rsp)
	.cfi_offset 3, -32
	xorl	%ebx, %ebx
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -24
	jmp	.L80
	.p2align 4,,10
	.p2align 3
.L86:
	testl	%eax, %eax
	je	.L84
	movq	8(%rbp), %rax
	leaq	.LC29(%rip), %rdi
	movq	(%rax), %rsi
	xorl	%eax, %eax
	call	printf@PLT
	movq	8(%rbp), %rax
	movl	$2, %esi
	movq	32(%rax), %rdi
	call	dump_stmt
.L79:
	addq	$1, %rbx
	cmpq	8(%r12), %rbx
	jnb	.L85
.L80:
	movq	(%r12), %rax
	movq	%rbx, %rsi
	leaq	.LC27(%rip), %rdi
	movq	(%rax,%rbx,8), %rbp
	xorl	%eax, %eax
	call	printf@PLT
	movl	0(%rbp), %eax
	cmpl	$2, %eax
	je	.L74
	jbe	.L86
	cmpl	$3, %eax
	jne	.L79
	leaq	.LC31(%rip), %rdi
	addq	$1, %rbx
	call	puts@PLT
	cmpq	8(%r12), %rbx
	jb	.L80
	.p2align 4
	.p2align 3
.L85:
	movq	(%rsp), %rbx
	.cfi_restore 3
	movq	8(%rsp), %rbp
	.cfi_restore 6
.L73:
	movq	16(%rsp), %r12
	movl	$10, %edi
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	jmp	putchar@PLT
	.p2align 4,,10
	.p2align 3
.L74:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	leaq	.LC30(%rip), %rdi
	call	puts@PLT
	jmp	.L79
	.p2align 4,,10
	.p2align 3
.L84:
	leaq	.LC28(%rip), %rdi
	call	puts@PLT
	jmp	.L79
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
	je	.L88
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm1, 96(%rsp)
	movaps	%xmm2, 112(%rsp)
	movaps	%xmm3, 128(%rsp)
	movaps	%xmm4, 144(%rsp)
	movaps	%xmm5, 160(%rsp)
	movaps	%xmm6, 176(%rsp)
	movaps	%xmm7, 192(%rsp)
.L88:
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movl	$5, %edx
	movl	$1, %esi
	movq	stderr(%rip), %rcx
	leaq	224(%rsp), %rax
	leaq	.LC32(%rip), %rdi
	movl	$8, (%rsp)
	movq	%rax, 8(%rsp)
	leaq	32(%rsp), %rax
	movl	$48, 4(%rsp)
	movq	%rax, 16(%rsp)
	call	fwrite@PLT
	movq	stderr(%rip), %rdi
	movq	%rsp, %rdx
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
	je	.L92
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm1, 96(%rsp)
	movaps	%xmm2, 112(%rsp)
	movaps	%xmm3, 128(%rsp)
	movaps	%xmm4, 144(%rsp)
	movaps	%xmm5, 160(%rsp)
	movaps	%xmm6, 176(%rsp)
	movaps	%xmm7, 192(%rsp)
.L92:
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	leaq	256(%rsp), %rax
	movl	$24, (%rsp)
	movl	32(%r12), %ecx
	movq	%rax, 8(%rsp)
	leaq	32(%rsp), %rax
	movq	40(%r12), %rdx
	movq	%rax, 16(%rsp)
	movl	g_verbose_errors(%rip), %eax
	movl	$48, 4(%rsp)
	movq	stderr(%rip), %rdi
	testl	%eax, %eax
	je	.L93
	movl	36(%r12), %r8d
	leaq	.LC33(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	stderr(%rip), %rdi
	movq	%rbp, %rsi
	movq	%rsp, %rdx
	call	vfprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
.L94:
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	1(%rbx), %rdx
	movl	$1, %ecx
	addq	%rdx, %rax
	jmp	.L95
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L97:
	cmpl	%ecx, 32(%r12)
	jle	.L102
	cmpb	$10, -1(%rdx)
	leal	1(%rcx), %esi
	cmove	%esi, %ecx
	cmove	%rdx, %rbx
	addq	$1, %rdx
.L95:
	cmpq	%rdx, %rax
	jne	.L97
.L102:
	movzbl	(%rbx), %eax
	movq	stderr(%rip), %rcx
	testb	%al, %al
	je	.L100
	movq	%rbx, %rbp
	cmpb	$10, %al
	je	.L100
	.p2align 4
	.p2align 4
	.p2align 3
.L98:
	movzbl	1(%rbp), %eax
	addq	$1, %rbp
	testb	%al, %al
	je	.L110
	cmpb	$10, %al
	jne	.L98
.L110:
	leaq	.LC35(%rip), %r13
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	cmpq	%rbp, %rbx
	jnb	.L104
	.p2align 4
	.p2align 3
.L105:
	movsbl	(%rbx), %edi
	movq	stderr(%rip), %rsi
	addq	$1, %rbx
	call	fputc@PLT
	cmpq	%rbp, %rbx
	jne	.L105
.L104:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	stderr(%rip), %rcx
	movl	$4, %edx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	cmpl	$1, 36(%r12)
	jle	.L106
	movl	$1, %ebx
	.p2align 4
	.p2align 3
.L107:
	movq	stderr(%rip), %rsi
	movl	$32, %edi
	addl	$1, %ebx
	call	fputc@PLT
	cmpl	%ebx, 36(%r12)
	jg	.L107
.L106:
	movq	stderr(%rip), %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L93:
	leaq	.LC34(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L94
.L100:
	leaq	.LC35(%rip), %r13
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	jmp	.L104
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	$0, %eax
	movq	%rbx, (%rsp)
	.cfi_offset 3, -32
	movq	%rdx, %rbx
	subq	%rsi, %rbx
	cmovc	%rax, %rbx
	movq	g_compilation_arena(%rip), %rax
	testq	%rax, %rax
	je	.L123
	movq	(%rsp), %rbx
	movq	%rdx, %rcx
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	%rax, %rdi
	jmp	arena_xstrdup_range@PLT
	.p2align 4,,10
	.p2align 3
.L123:
	.cfi_restore_state
	movq	%r14, 8(%rsp)
	.cfi_offset 14, -24
	movq	%rdi, %r14
	leaq	1(%rbx), %rdi
	movq	%r15, 16(%rsp)
	.cfi_offset 15, -16
	movq	%rsi, %r15
	call	malloc@PLT
	testq	%rax, %rax
	je	.L126
	leaq	(%r14,%r15), %rsi
	movq	%rbx, %rdx
	movq	%rax, %rdi
	call	memcpy@PLT
	movb	$0, (%rax,%rbx)
	movq	8(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	movq	16(%rsp), %r15
	.cfi_restore 15
	movq	(%rsp), %rbx
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
.L126:
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
	je	.L128
	movq	g_compilation_arena(%rip), %rax
	testq	%rax, %rax
	je	.L129
	movq	%rdi, %rsi
	movq	%rax, %rdi
	jmp	arena_sdup@PLT
	.p2align 4,,10
	.p2align 3
.L129:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, 8(%rsp)
	call	strlen@PLT
	leaq	1(%rax), %rdx
	movq	%rdx, %rdi
	movq	%rdx, (%rsp)
	call	malloc@PLT
	movq	(%rsp), %rdx
	movq	8(%rsp), %rsi
	testq	%rax, %rax
	je	.L133
	movq	%rax, %rdi
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	jmp	memcpy@PLT
	.p2align 4,,10
	.p2align 3
.L128:
	xorl	%eax, %eax
	ret
.L133:
	.cfi_def_cfa_offset 32
	leaq	.LC37(%rip), %rdi
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -40
	movq	%rsi, %rbp
	xorl	%esi, %esi
	movq	%r13, 24(%rsp)
	.cfi_offset 13, -24
	movq	%rdi, %r13
	call	access@PLT
	testl	%eax, %eax
	je	.L157
	movq	%rbx, (%rsp)
	movq	%r12, 16(%rsp)
	movq	%r14, 32(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 12, -32
	.cfi_offset 14, -16
	testq	%rbp, %rbp
	je	.L136
	movl	$47, %esi
	movq	%rbp, %rdi
	call	strrchr@PLT
	testq	%rax, %rax
	je	.L136
	subq	%rbp, %rax
	movq	%r13, %rdi
	movq	%rax, %rbx
	call	strlen@PLT
	leaq	2(%rbx,%rax), %rdi
	movq	%rax, %r14
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L141
	leaq	1(%rbx), %rdx
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	leaq	1(%r12,%rbx), %rdi
	leaq	1(%r14), %rdx
	movq	%r13, %rsi
	call	memcpy@PLT
	movq	%r12, %rdi
	xorl	%esi, %esi
	call	access@PLT
	movq	%r12, %rdi
	testl	%eax, %eax
	je	.L158
	call	free@PLT
.L136:
	xorl	%ebp, %ebp
	cmpq	$0, 8+g_include_paths(%rip)
	leaq	g_include_paths(%rip), %r14
	jne	.L140
	jmp	.L143
	.p2align 4,,10
	.p2align 3
.L142:
	call	free@PLT
	addq	$1, %rbp
	cmpq	8(%r14), %rbp
	jnb	.L143
.L140:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %r12
	movq	%r12, %rdi
	call	strlen@PLT
	movq	%r13, %rdi
	movq	%rax, %rbx
	call	strlen@PLT
	leaq	2(%rbx,%rax), %rdi
	call	malloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L141
	movq	%rax, %rdi
	movq	%r13, %rcx
	movq	%r12, %rdx
	xorl	%eax, %eax
	leaq	.LC38(%rip), %rsi
	call	sprintf@PLT
	movq	%rbx, %rdi
	xorl	%esi, %esi
	call	access@PLT
	movq	%rbx, %rdi
	testl	%eax, %eax
	jne	.L142
	call	sdup
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	free@PLT
.L134:
	movq	%rbp, %rax
	movq	(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	movq	16(%rsp), %r12
	.cfi_restore 12
	movq	32(%rsp), %r14
	.cfi_restore 14
	movq	8(%rsp), %rbp
	movq	24(%rsp), %r13
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L143:
	.cfi_restore_state
	xorl	%ebp, %ebp
	jmp	.L134
	.p2align 4,,10
	.p2align 3
.L157:
	.cfi_restore 3
	.cfi_restore 12
	.cfi_restore 14
	movq	8(%rsp), %rbp
	movq	%r13, %rdi
	movq	24(%rsp), %r13
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	jmp	sdup
	.p2align 4,,10
	.p2align 3
.L158:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	.cfi_offset 12, -32
	.cfi_offset 14, -16
	call	sdup
	movq	%r12, %rdi
	movq	%rax, %rbp
	call	free@PLT
	jmp	.L134
.L141:
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
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	subq	$256, %rsp
	.cfi_def_cfa_offset 272
	movq	%rsi, 88(%rsp)
	movq	%rdx, 96(%rsp)
	movq	%rcx, 104(%rsp)
	movq	%r8, 112(%rsp)
	movq	%r9, 120(%rsp)
	testb	%al, %al
	je	.L160
	movaps	%xmm0, 128(%rsp)
	movaps	%xmm1, 144(%rsp)
	movaps	%xmm2, 160(%rsp)
	movaps	%xmm3, 176(%rsp)
	movaps	%xmm4, 192(%rsp)
	movaps	%xmm5, 208(%rsp)
	movaps	%xmm6, 224(%rsp)
	movaps	%xmm7, 240(%rsp)
.L160:
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	leaq	272(%rsp), %rax
	xorl	%esi, %esi
	xorl	%edi, %edi
	movq	%rax, 32(%rsp)
	leaq	24(%rsp), %rcx
	leaq	80(%rsp), %rax
	movq	%rbx, %rdx
	movl	$8, 24(%rsp)
	movl	$48, 28(%rsp)
	movdqu	24(%rsp), %xmm0
	movq	%rax, 40(%rsp)
	movq	%rax, 64(%rsp)
	movups	%xmm0, 48(%rsp)
	call	vsnprintf@PLT
	testl	%eax, %eax
	js	.L167
	cmpq	$0, g_compilation_arena(%rip)
	je	.L162
	leaq	272(%rsp), %rax
	movq	g_compilation_arena(%rip), %rdi
	leaq	24(%rsp), %rdx
	movq	%rbx, %rsi
	movq	%rax, 32(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	movl	$8, 24(%rsp)
	movl	$48, 28(%rsp)
	call	arena_fmt@PLT
	movq	%rax, %rdi
.L159:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L168
	addq	$256, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	movq	%rdi, %rax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L162:
	.cfi_restore_state
	movl	%eax, %eax
	leaq	1(%rax), %rsi
	movq	%rsi, %rdi
	movq	%rsi, 8(%rsp)
	call	malloc@PLT
	movq	8(%rsp), %rsi
	testq	%rax, %rax
	movq	%rax, %rdi
	je	.L169
	leaq	48(%rsp), %rcx
	movq	%rbx, %rdx
	movq	%rax, 8(%rsp)
	call	vsnprintf@PLT
	movq	8(%rsp), %rdi
	jmp	.L159
.L167:
	leaq	.LC39(%rip), %rdi
	xorl	%eax, %eax
	call	dief
.L168:
	call	__stack_chk_fail@PLT
.L169:
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
	je	.L171
	call	arena_alloc@PLT
	pxor	%xmm0, %xmm0
	movq	$0, 16(%rax)
	movups	%xmm0, (%rax)
.L170:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L171:
	.cfi_restore_state
	movl	$1, %edi
	call	calloc@PLT
	testq	%rax, %rax
	jne	.L170
	leaq	.LC37(%rip), %rdi
	xorl	%eax, %eax
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
	movq	%rsi, %r8
	movq	%rdi, %rcx
	movq	8(%rdi), %rsi
	cmpq	16(%rdi), %rsi
	je	.L175
	movq	(%rdi), %rdi
	leaq	1(%rsi), %rax
	movq	%rax, 8(%rcx)
	movq	%r8, (%rdi,%rsi,8)
	ret
	.p2align 4,,10
	.p2align 3
.L175:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	testq	%rsi, %rsi
	jne	.L188
	movl	$64, %esi
	movl	$8, %ebx
.L177:
	movq	g_compilation_arena(%rip), %rdi
	movq	%r8, 8(%rsp)
	testq	%rdi, %rdi
	je	.L178
	movq	%rcx, (%rsp)
	call	arena_alloc@PLT
	movq	(%rsp), %rcx
	movq	8(%rsp), %r8
	movq	%rax, %rdi
	movq	(%rcx), %rsi
	testq	%rsi, %rsi
	je	.L180
	movq	8(%rcx), %rax
	leaq	0(,%rax,8), %rdx
	call	memcpy@PLT
	movq	(%rsp), %rcx
	movq	8(%rsp), %r8
	movq	%rax, %rdi
.L180:
	movq	8(%rcx), %rsi
	movq	%rdi, (%rcx)
	movq	%rbx, 16(%rcx)
	leaq	1(%rsi), %rax
	movq	%rax, 8(%rcx)
	movq	%r8, (%rdi,%rsi,8)
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L188:
	.cfi_restore_state
	leaq	(%rsi,%rsi), %rbx
	salq	$4, %rsi
	jmp	.L177
	.p2align 4,,10
	.p2align 3
.L178:
	movq	(%rcx), %rdi
	movq	%rcx, (%rsp)
	call	realloc@PLT
	movq	(%rsp), %rcx
	movq	8(%rsp), %r8
	testq	%rax, %rax
	movq	%rax, %rdi
	jne	.L180
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
	je	.L190
	movq	%rdi, %rsi
	movq	%rax, %rdi
	jmp	arena_alloc@PLT
	.p2align 4,,10
	.p2align 3
.L190:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	malloc@PLT
	testq	%rax, %rax
	je	.L194
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L194:
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
	ja	.L196
	leaq	.L198(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L198:
	.long	.L211-.L198
	.long	.L212-.L198
	.long	.L209-.L198
	.long	.L208-.L198
	.long	.L207-.L198
	.long	.L206-.L198
	.long	.L205-.L198
	.long	.L204-.L198
	.long	.L203-.L198
	.long	.L202-.L198
	.long	.L201-.L198
	.long	.L200-.L198
	.long	.L199-.L198
	.long	.L197-.L198
	.text
	.p2align 4,,10
	.p2align 3
.L212:
	leaq	.LC41(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L211:
	leaq	.LC40(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L209:
	leaq	.LC42(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L208:
	leaq	.LC43(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L207:
	leaq	.LC44(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L206:
	leaq	.LC45(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L205:
	leaq	.LC46(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L204:
	leaq	.LC47(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L203:
	leaq	.LC48(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L202:
	leaq	.LC49(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L201:
	leaq	.LC50(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L200:
	leaq	.LC51(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L199:
	leaq	.LC52(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L197:
	leaq	.LC53(%rip), %rax
	ret
.L196:
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
	ja	.L214
	leaq	.L216(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L216:
	.long	.L229-.L216
	.long	.L230-.L216
	.long	.L227-.L216
	.long	.L226-.L216
	.long	.L225-.L216
	.long	.L224-.L216
	.long	.L223-.L216
	.long	.L222-.L216
	.long	.L221-.L216
	.long	.L220-.L216
	.long	.L219-.L216
	.long	.L218-.L216
	.long	.L217-.L216
	.long	.L215-.L216
	.text
	.p2align 4,,10
	.p2align 3
.L230:
	leaq	.LC56(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L229:
	leaq	.LC55(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L227:
	leaq	.LC57(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L226:
	leaq	.LC58(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L225:
	leaq	.LC59(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L224:
	leaq	.LC60(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L223:
	leaq	.LC61(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L222:
	leaq	.LC62(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L221:
	leaq	.LC63(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L220:
	leaq	.LC64(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L219:
	leaq	.LC65(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L218:
	leaq	.LC66(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L217:
	leaq	.LC67(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L215:
	leaq	.LC68(%rip), %rax
	ret
.L214:
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
	movl	32(%rdi), %ecx
	movq	40(%rdi), %rsi
	movq	stderr(%rip), %r10
	movl	%edx, %edi
	testl	%eax, %eax
	je	.L232
	call	get_error_message
	movl	36(%r12), %r8d
	movq	%rsi, %rdx
	movq	%r10, %rdi
	movq	%rax, %r9
	leaq	.LC70(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	testq	%rbp, %rbp
	je	.L233
	cmpb	$0, 0(%rbp)
	jne	.L264
.L233:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
.L234:
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	1(%rbx), %rdx
	movl	$1, %ecx
	addq	%rdx, %rax
	jmp	.L235
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L237:
	cmpl	%ecx, 32(%r12)
	jle	.L242
	cmpb	$10, -1(%rdx)
	leal	1(%rcx), %esi
	cmove	%esi, %ecx
	cmove	%rdx, %rbx
	addq	$1, %rdx
.L235:
	cmpq	%rdx, %rax
	jne	.L237
.L242:
	movzbl	(%rbx), %eax
	movq	stderr(%rip), %rcx
	testb	%al, %al
	je	.L240
	movq	%rbx, %rbp
	cmpb	$10, %al
	je	.L240
	.p2align 4
	.p2align 4
	.p2align 3
.L238:
	movzbl	1(%rbp), %eax
	addq	$1, %rbp
	testb	%al, %al
	je	.L249
	cmpb	$10, %al
	jne	.L238
.L249:
	leaq	.LC35(%rip), %r13
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	cmpq	%rbp, %rbx
	jnb	.L244
	.p2align 4
	.p2align 3
.L245:
	movsbl	(%rbx), %edi
	movq	stderr(%rip), %rsi
	addq	$1, %rbx
	call	fputc@PLT
	cmpq	%rbp, %rbx
	jne	.L245
.L244:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movq	stderr(%rip), %rcx
	movl	$4, %edx
	movq	%r13, %rdi
	movl	$1, %esi
	call	fwrite@PLT
	cmpl	$1, 36(%r12)
	jle	.L246
	movl	$1, %ebx
	.p2align 4
	.p2align 3
.L247:
	movq	stderr(%rip), %rsi
	movl	$32, %edi
	addl	$1, %ebx
	call	fputc@PLT
	cmpl	%ebx, 36(%r12)
	jg	.L247
.L246:
	movq	stderr(%rip), %rcx
	movl	$2, %edx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L232:
	call	get_error_code
	movl	%ecx, %r8d
	movq	%r10, %rdi
	movq	%rsi, %rcx
	movq	%rax, %rdx
	leaq	.LC71(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L234
.L264:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rdx
	leaq	.LC4(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L233
.L240:
	leaq	.LC35(%rip), %r13
	movl	$4, %edx
	movl	$1, %esi
	movq	%r13, %rdi
	call	fwrite@PLT
	jmp	.L244
	.cfi_endproc
.LFE21:
	.size	error_at_code, .-error_at_code
	.p2align 4
	.globl	error_at_location
	.type	error_at_location, @function
error_at_location:
.LFB22:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %r11
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movl	g_verbose_errors(%rip), %eax
	movq	stderr(%rip), %r10
	testl	%eax, %eax
	je	.L266
	movl	%ecx, %edi
	movl	%edx, 12(%rsp)
	movq	%r8, %rbx
	movl	%esi, %ecx
	call	get_error_message
	movl	12(%rsp), %r8d
	movq	%r11, %rdx
	movq	%r10, %rdi
	movq	%rax, %r9
	leaq	.LC70(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	testq	%rbx, %rbx
	je	.L267
	cmpb	$0, (%rbx)
	jne	.L273
.L267:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
.L268:
	movl	$1, %edi
	call	exit@PLT
.L266:
	movl	%ecx, %edi
	movl	%esi, %r8d
	leaq	.LC71(%rip), %rsi
	movq	%r11, %rcx
	call	get_error_code
	movq	%r10, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L268
.L273:
	movq	stderr(%rip), %rdi
	movq	%rbx, %rdx
	leaq	.LC4(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L267
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
	.ident	"GCC: (GNU) 16.1.1 20260430"
	.section	.note.GNU-stack,"",@progbits
