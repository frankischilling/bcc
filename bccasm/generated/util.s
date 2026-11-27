	.file	"util.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Tokens:\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"  (cannot re-read file for token dump)\n"
	.section	.rodata.str1.1
.LC3:
	.string	"  %s"
.LC4:
	.string	" '%s'"
.LC5:
	.string	" %ld"
.LC6:
	.string	" at %s:%d:%d\n"
.LC7:
	.string	"\n"
	.text
	.p2align 4
	.globl	dump_token_stream
	.type	dump_token_stream, @function
dump_token_stream:
.LFB50:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC0(%rip), %rsi
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
	movl	$2, %edi
	subq	$152, %rsp
	.cfi_def_cfa_offset 208
	movq	%fs:40, %rax
	movq	%rax, 136(%rsp)
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	32(%rbx), %rdi
	leaq	24(%rsp), %rsi
	call	read_file_all@PLT
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L18
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
	movl	80(%rsp), %r14d
	movq	88(%rsp), %r15
	testl	%r14d, %r14d
	je	.L4
	leaq	.LC3(%rip), %r13
	leaq	.LC6(%rip), %r12
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L6:
	movl	124(%rsp), %r8d
	movl	120(%rsp), %ecx
	movq	%r12, %rsi
	xorl	%eax, %eax
	movq	128(%rsp), %rdx
	movl	$2, %edi
	call	__printf_chk@PLT
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	lx_next@PLT
	movl	80(%rsp), %r14d
	movq	88(%rsp), %r15
	testl	%r14d, %r14d
	je	.L4
.L7:
	movl	%r14d, %edi
	call	tk_name@PLT
	movq	%r13, %rsi
	movl	$2, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	testq	%r15, %r15
	je	.L5
	movq	%r15, %rdx
	leaq	.LC4(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L5:
	cmpl	$2, %r14d
	jne	.L6
	movq	112(%rsp), %rdx
	leaq	.LC5(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L4:
	movl	$2, %edi
	leaq	.LC7(%rip), %rsi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	8(%rsp), %rdi
	call	free@PLT
.L1:
	movq	136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L19
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
.L18:
	.cfi_restore_state
	leaq	.LC1(%rip), %rsi
	movl	$2, %edi
	call	__printf_chk@PLT
	jmp	.L1
.L19:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE50:
	.size	dump_token_stream, .-dump_token_stream
	.section	.rodata.str1.1
.LC8:
	.string	" "
.LC9:
	.string	"(null)\n"
.LC10:
	.string	"NUM %ld\n"
.LC11:
	.string	"STR \"%s\"\n"
.LC12:
	.string	"VAR %s\n"
.LC13:
	.string	"UNARY %s\n"
.LC14:
	.string	"BINARY %s\n"
.LC15:
	.string	"ASSIGN %s\n"
.LC16:
	.string	"INDEX\n"
.LC17:
	.string	"POST %s\n"
.LC18:
	.string	"EXPR kind %d\n"
	.text
	.p2align 4
	.globl	dump_expr
	.type	dump_expr, @function
dump_expr:
.LFB52:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leal	2(%rsi), %r15d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.L27(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leaq	.LC8(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
.L21:
	testl	%ebp, %ebp
	jle	.L22
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L23:
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addl	$1, %ebx
	call	__printf_chk@PLT
	cmpl	%ebp, %ebx
	jne	.L23
.L22:
	testq	%r13, %r13
	je	.L40
	movl	0(%r13), %edx
	cmpl	$8, %edx
	ja	.L25
	movl	%edx, %eax
	movslq	(%r14,%rax,4), %rax
	addq	%r14, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L27:
	.long	.L34-.L27
	.long	.L33-.L27
	.long	.L32-.L27
	.long	.L25-.L27
	.long	.L31-.L27
	.long	.L30-.L27
	.long	.L29-.L27
	.long	.L28-.L27
	.long	.L26-.L27
	.text
	.p2align 4,,10
	.p2align 3
.L26:
	movl	48(%r13), %edi
	call	tk_name@PLT
	leaq	.LC15(%rip), %rsi
	movq	%rax, %rdx
.L38:
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	56(%r13), %rdi
	movl	%r15d, %esi
	call	dump_expr
	movq	64(%r13), %r13
.L35:
	addl	$2, %ebp
	addl	$2, %r15d
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L28:
	movl	48(%r13), %edi
	call	tk_name@PLT
	leaq	.LC14(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L29:
	movl	48(%r13), %edi
	call	tk_name@PLT
	leaq	.LC17(%rip), %rsi
	movl	$2, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	56(%r13), %r13
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L30:
	movl	48(%r13), %edi
	call	tk_name@PLT
	leaq	.LC13(%rip), %rsi
	movl	$2, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	56(%r13), %r13
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L31:
	leaq	.LC16(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	48(%r13), %rdi
	movl	%r15d, %esi
	call	dump_expr
	movq	56(%r13), %r13
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L32:
	movq	48(%r13), %rdx
	leaq	.LC12(%rip), %rsi
.L39:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	$2, %edi
	xorl	%eax, %eax
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
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L33:
	.cfi_restore_state
	movq	48(%r13), %rdx
	leaq	.LC11(%rip), %rsi
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L34:
	movq	48(%r13), %rdx
	leaq	.LC10(%rip), %rsi
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L25:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC18(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
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
	jmp	__printf_chk@PLT
.L40:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	leaq	.LC9(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
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
	jmp	__printf_chk@PLT
	.cfi_endproc
.LFE52:
	.size	dump_expr, .-dump_expr
	.section	.rodata.str1.1
.LC19:
	.string	"EMPTY\n"
.LC20:
	.string	"BLOCK\n"
.LC21:
	.string	"AUTO\n"
.LC22:
	.string	"IF\n"
.LC23:
	.string	"ELSE\n"
.LC24:
	.string	"WHILE\n"
.LC25:
	.string	"RETURN\n"
.LC26:
	.string	"EXPR\n"
.LC27:
	.string	"STMT kind %d\n"
	.text
	.p2align 4
	.globl	dump_stmt
	.type	dump_stmt, @function
dump_stmt:
.LFB53:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.L49(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leaq	.LC8(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
.L42:
	xorl	%ebx, %ebx
	testl	%ebp, %ebp
	jle	.L46
	.p2align 4,,10
	.p2align 3
.L43:
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addl	$1, %ebx
	call	__printf_chk@PLT
	cmpl	%ebx, %ebp
	jne	.L43
.L46:
	testq	%r13, %r13
	je	.L78
	movl	0(%r13), %edx
	cmpl	$6, %edx
	ja	.L47
	movslq	(%r14,%rdx,4), %rax
	addq	%r14, %rax
	notrack jmp	*%rax
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
	leaq	.LC25(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	16(%r13), %rdi
	leal	2(%rbp), %esi
	testq	%rdi, %rdi
	je	.L41
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
	jmp	dump_expr
	.p2align 4,,10
	.p2align 3
.L48:
	.cfi_restore_state
	leaq	.LC26(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	16(%r13), %rdi
	leal	2(%rbp), %esi
	jmp	.L77
	.p2align 4,,10
	.p2align 3
.L54:
	xorl	%eax, %eax
	leaq	.LC20(%rip), %rsi
	movl	$2, %edi
	xorl	%ebx, %ebx
	call	__printf_chk@PLT
	addl	$2, %ebp
	cmpq	$0, 24(%r13)
	je	.L41
.L58:
	movq	16(%r13), %rax
	movl	%ebp, %esi
	movq	(%rax,%rbx,8), %rdi
	addq	$1, %rbx
	call	dump_stmt
	cmpq	24(%r13), %rbx
	jb	.L58
.L41:
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
.L53:
	.cfi_restore_state
	leaq	.LC21(%rip), %rsi
.L76:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	$2, %edi
	xorl	%eax, %eax
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
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L52:
	.cfi_restore_state
	leaq	.LC22(%rip), %rsi
	movl	$2, %edi
	leal	2(%rbp), %ebx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	16(%r13), %rdi
	movl	%ebx, %esi
	movl	%ebx, 12(%rsp)
	call	dump_expr
	movq	24(%r13), %rdi
	movl	%ebx, %esi
	call	dump_stmt
	cmpq	$0, 32(%r13)
	je	.L41
	xorl	%r15d, %r15d
	leaq	.LC8(%rip), %rbx
	cmpl	$-1, %ebp
	jl	.L62
	.p2align 4,,10
	.p2align 3
.L60:
	movq	%rbx, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	%r15d, %eax
	addl	$1, %r15d
	cmpl	%eax, %ebp
	jge	.L60
.L62:
	leaq	.LC23(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	32(%r13), %r13
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L51:
	leaq	.LC24(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leal	2(%rbp), %eax
	movq	16(%r13), %rdi
	movl	%eax, %esi
	movl	%eax, 12(%rsp)
	call	dump_expr
	movq	24(%r13), %r13
.L61:
	movl	12(%rsp), %ebp
	jmp	.L42
	.p2align 4,,10
	.p2align 3
.L55:
	leaq	.LC19(%rip), %rsi
	jmp	.L76
.L47:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC27(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
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
	jmp	__printf_chk@PLT
.L78:
	.cfi_restore_state
	leaq	.LC9(%rip), %rsi
	jmp	.L76
	.cfi_endproc
.LFE53:
	.size	dump_stmt, .-dump_stmt
	.section	.rodata.str1.1
.LC28:
	.string	"AST:\n"
.LC29:
	.string	"Top level %zu:\n"
.LC30:
	.string	"  GAUTO\n"
.LC31:
	.string	"  FUNC %s\n"
.LC32:
	.string	"  EXTERN_DEF\n"
.LC33:
	.string	"  EXTERN_DECL\n"
	.text
	.p2align 4
	.globl	dump_ast_program
	.type	dump_ast_program, @function
dump_ast_program:
.LFB51:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xorl	%eax, %eax
	leaq	.LC28(%rip), %rsi
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
	movl	$2, %edi
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	call	__printf_chk@PLT
	cmpq	$0, 8(%rbx)
	je	.L80
	xorl	%r12d, %r12d
	leaq	.LC29(%rip), %rbp
	leaq	.LC32(%rip), %r15
	leaq	.LC33(%rip), %r14
	jmp	.L87
	.p2align 4,,10
	.p2align 3
.L92:
	testl	%eax, %eax
	je	.L91
	movq	8(%r13), %rax
	leaq	.LC31(%rip), %rsi
	movl	$2, %edi
	movq	(%rax), %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	8(%r13), %rax
	movl	$2, %esi
	movq	32(%rax), %rdi
	call	dump_stmt
.L86:
	addq	$1, %r12
	cmpq	8(%rbx), %r12
	jnb	.L80
.L87:
	movq	(%rbx), %rax
	movq	%r12, %rdx
	movq	%rbp, %rsi
	movl	$2, %edi
	movq	(%rax,%r12,8), %r13
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	0(%r13), %eax
	cmpl	$2, %eax
	je	.L81
	jbe	.L92
	cmpl	$3, %eax
	jne	.L86
	movq	%r14, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addq	$1, %r12
	call	__printf_chk@PLT
	cmpq	8(%rbx), %r12
	jb	.L87
.L80:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC7(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
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
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L81:
	.cfi_restore_state
	movq	%r15, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L86
	.p2align 4,,10
	.p2align 3
.L91:
	leaq	.LC30(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L86
	.cfi_endproc
.LFE51:
	.size	dump_ast_program, .-dump_ast_program
	.section	.rodata.str1.1
.LC34:
	.string	"bcc: "
	.text
	.p2align 4
	.globl	dief
	.type	dief, @function
dief:
.LFB54:
	.cfi_startproc
	endbr64
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
	je	.L94
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm1, 96(%rsp)
	movaps	%xmm2, 112(%rsp)
	movaps	%xmm3, 128(%rsp)
	movaps	%xmm4, 144(%rsp)
	movaps	%xmm5, 160(%rsp)
	movaps	%xmm6, 176(%rsp)
	movaps	%xmm7, 192(%rsp)
.L94:
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	leaq	224(%rsp), %rax
	movl	$2, %esi
	movq	stderr(%rip), %rdi
	movq	%rax, 8(%rsp)
	leaq	32(%rsp), %rax
	leaq	.LC34(%rip), %rdx
	movq	%rax, 16(%rsp)
	xorl	%eax, %eax
	movl	$8, (%rsp)
	movl	$48, 4(%rsp)
	call	__fprintf_chk@PLT
	movq	%rsp, %rcx
	movq	%rbx, %rdx
	movl	$2, %esi
	movq	stderr(%rip), %rdi
	call	__vfprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC7(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE54:
	.size	dief, .-dief
	.section	.rodata.str1.1
.LC35:
	.string	"%s:%d:%d: "
.LC36:
	.string	"sx %s:%d\n"
.LC37:
	.string	"    "
.LC38:
	.string	"^\n"
	.text
	.p2align 4
	.globl	error_at
	.type	error_at, @function
error_at:
.LFB55:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
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
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rsi, %rbx
	subq	$208, %rsp
	.cfi_def_cfa_offset 256
	movq	%rcx, 56(%rsp)
	movq	%r8, 64(%rsp)
	movq	%r9, 72(%rsp)
	testb	%al, %al
	je	.L98
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm1, 96(%rsp)
	movaps	%xmm2, 112(%rsp)
	movaps	%xmm3, 128(%rsp)
	movaps	%xmm4, 144(%rsp)
	movaps	%xmm5, 160(%rsp)
	movaps	%xmm6, 176(%rsp)
	movaps	%xmm7, 192(%rsp)
.L98:
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	leaq	256(%rsp), %rax
	movq	48(%r12), %rcx
	movl	$24, (%rsp)
	movq	%rax, 8(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 16(%rsp)
	movl	g_verbose_errors(%rip), %eax
	movl	$48, 4(%rsp)
	testl	%eax, %eax
	je	.L99
	movl	44(%r12), %r9d
	movl	40(%r12), %r8d
	xorl	%eax, %eax
	leaq	.LC35(%rip), %rdx
	movq	stderr(%rip), %rdi
	movl	$2, %esi
	leaq	.LC7(%rip), %r13
	call	__fprintf_chk@PLT
	movq	%rbp, %rdx
	movl	$2, %esi
	movq	%rsp, %rcx
	movq	stderr(%rip), %rdi
	call	__vfprintf_chk@PLT
	movq	%r13, %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
.L100:
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	1(%rbx), %rdx
	movl	$1, %ecx
	addq	%rdx, %rax
	jmp	.L101
	.p2align 4,,10
	.p2align 3
.L103:
	cmpl	%ecx, 40(%r12)
	jle	.L108
	cmpb	$10, -1(%rdx)
	jne	.L102
	addl	$1, %ecx
	movq	%rdx, %rbx
.L102:
	addq	$1, %rdx
.L101:
	cmpq	%rdx, %rax
	jne	.L103
.L108:
	movzbl	(%rbx), %eax
	movq	stderr(%rip), %rdi
	testb	%al, %al
	je	.L106
	movq	%rbx, %rbp
	cmpb	$10, %al
	je	.L106
	.p2align 4,,10
	.p2align 3
.L104:
	movzbl	1(%rbp), %eax
	addq	$1, %rbp
	testb	%al, %al
	je	.L118
	cmpb	$10, %al
	jne	.L104
.L118:
	leaq	.LC37(%rip), %r14
	xorl	%eax, %eax
	movl	$2, %esi
	movq	%r14, %rdx
	call	__fprintf_chk@PLT
	cmpq	%rbp, %rbx
	jnb	.L111
	.p2align 4,,10
	.p2align 3
.L110:
	movsbl	(%rbx), %edi
	movq	stderr(%rip), %rsi
	addq	$1, %rbx
	call	fputc@PLT
	cmpq	%rbp, %rbx
	jne	.L110
.L111:
	movq	%r13, %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movl	$1, %ebx
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
	movq	%r14, %rdx
	movl	$2, %esi
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
	cmpl	$1, 44(%r12)
	jle	.L114
	.p2align 4,,10
	.p2align 3
.L113:
	movq	stderr(%rip), %rsi
	movl	$32, %edi
	addl	$1, %ebx
	call	fputc@PLT
	cmpl	%ebx, 44(%r12)
	jg	.L113
.L114:
	movq	stderr(%rip), %rdi
	leaq	.LC38(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movl	$1, %edi
	call	exit@PLT
.L99:
	movl	40(%r12), %r8d
	movq	stderr(%rip), %rdi
	leaq	.LC36(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	leaq	.LC7(%rip), %r13
	call	__fprintf_chk@PLT
	jmp	.L100
.L106:
	leaq	.LC37(%rip), %r14
	movl	$2, %esi
	xorl	%eax, %eax
	movq	%r14, %rdx
	call	__fprintf_chk@PLT
	jmp	.L111
	.cfi_endproc
.LFE55:
	.size	error_at, .-error_at
	.section	.rodata.str1.1
.LC39:
	.string	"out of memory"
	.text
	.p2align 4
	.globl	xstrdup_range
	.type	xstrdup_range, @function
xstrdup_range:
.LFB58:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	xorl	%eax, %eax
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	subq	%rsi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movq	g_compilation_arena(%rip), %rdi
	cmpq	%rdx, %rsi
	cmovnb	%rax, %r12
	testq	%rdi, %rdi
	je	.L134
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rbp, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	arena_xstrdup_range@PLT
	.p2align 4,,10
	.p2align 3
.L134:
	.cfi_restore_state
	leaq	1(%r12), %r13
	movq	%r13, %rdi
	call	malloc@PLT
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L138
	leaq	0(%rbp,%rbx), %rsi
	movq	%r13, %rcx
	movq	%r12, %rdx
	call	__memcpy_chk@PLT
	movb	$0, (%rax,%r12)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L138:
	.cfi_restore_state
	leaq	.LC39(%rip), %rdi
	xorl	%eax, %eax
	call	dief
	.cfi_endproc
.LFE58:
	.size	xstrdup_range, .-xstrdup_range
	.p2align 4
	.globl	sdup
	.type	sdup, @function
sdup:
.LFB59:
	.cfi_startproc
	endbr64
	testq	%rdi, %rdi
	je	.L143
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
	je	.L141
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
.L141:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	1(%rax), %rbp
	movq	%rbp, %rdi
	call	malloc@PLT
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L148
	movq	%rbp, %rcx
	movq	%rbp, %rdx
	movq	%rbx, %rsi
	call	__memcpy_chk@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L143:
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
.L148:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	leaq	.LC39(%rip), %rdi
	xorl	%eax, %eax
	call	dief
	.cfi_endproc
.LFE59:
	.size	sdup, .-sdup
	.section	.rodata.str1.1
.LC40:
	.string	"%s/%s"
	.text
	.p2align 4
	.globl	resolve_include_path
	.type	resolve_include_path, @function
resolve_include_path:
.LFB49:
	.cfi_startproc
	endbr64
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
	je	.L170
	testq	%rbx, %rbx
	je	.L151
	movl	$47, %esi
	movq	%rbx, %rdi
	call	strrchr@PLT
	testq	%rax, %rax
	je	.L151
	subq	%rbx, %rax
	movq	%r12, %rdi
	movq	%rax, %rbp
	leaq	1(%rax), %r15
	call	strlen@PLT
	leaq	2(%rbp,%rax), %rbp
	movq	%rax, %r13
	movq	%rbp, %rdi
	call	malloc@PLT
	movq	%rax, %r14
	testq	%rax, %rax
	je	.L156
	movq	%rbp, %rcx
	movq	%r15, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	__memcpy_chk@PLT
	cmpq	%r15, %rbp
	movq	%rbp, %rcx
	leaq	1(%r13), %rdx
	cmovb	%r15, %rcx
	leaq	(%r14,%r15), %rdi
	movq	%r12, %rsi
	subq	%r15, %rcx
	call	__memcpy_chk@PLT
	movq	%r14, %rdi
	xorl	%esi, %esi
	call	access@PLT
	movq	%r14, %rdi
	testl	%eax, %eax
	je	.L171
	call	free@PLT
.L151:
	cmpq	$0, 8+g_include_paths(%rip)
	je	.L155
	xorl	%ebp, %ebp
	leaq	g_include_paths(%rip), %r14
	jmp	.L158
	.p2align 4,,10
	.p2align 3
.L157:
	call	free@PLT
	addq	$1, %rbp
	cmpq	8+g_include_paths(%rip), %rbp
	jnb	.L155
.L158:
	movq	(%r14), %rax
	movq	(%rax,%rbp,8), %r13
	movq	%r13, %rdi
	call	strlen@PLT
	movq	%r12, %rdi
	movq	%rax, %rbx
	call	strlen@PLT
	leaq	2(%rbx,%rax), %r15
	movq	%r15, %rdi
	call	malloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L156
	movq	%rax, %rdi
	movq	%r12, %r9
	movq	%r13, %r8
	movq	%r15, %rdx
	leaq	.LC40(%rip), %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__sprintf_chk@PLT
	movq	%rbx, %rdi
	xorl	%esi, %esi
	call	access@PLT
	movq	%rbx, %rdi
	testl	%eax, %eax
	jne	.L157
	call	sdup
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	free@PLT
.L149:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rax
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
.L155:
	.cfi_restore_state
	xorl	%ebp, %ebp
	jmp	.L149
	.p2align 4,,10
	.p2align 3
.L170:
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
.L171:
	.cfi_restore_state
	call	sdup
	movq	%r14, %rdi
	movq	%rax, %rbp
	call	free@PLT
	jmp	.L149
.L156:
	leaq	.LC39(%rip), %rdi
	xorl	%eax, %eax
	call	dief
	.cfi_endproc
.LFE49:
	.size	resolve_include_path, .-resolve_include_path
	.section	.rodata.str1.1
.LC41:
	.string	"fmt: vsnprintf failed"
	.text
	.p2align 4
	.globl	fmt
	.type	fmt, @function
fmt:
.LFB60:
	.cfi_startproc
	endbr64
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
	subq	$240, %rsp
	.cfi_def_cfa_offset 272
	movq	%rsi, 72(%rsp)
	movq	%rdx, 80(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%r8, 96(%rsp)
	movq	%r9, 104(%rsp)
	testb	%al, %al
	je	.L173
	movaps	%xmm0, 112(%rsp)
	movaps	%xmm1, 128(%rsp)
	movaps	%xmm2, 144(%rsp)
	movaps	%xmm3, 160(%rsp)
	movaps	%xmm4, 176(%rsp)
	movaps	%xmm5, 192(%rsp)
	movaps	%xmm6, 208(%rsp)
	movaps	%xmm7, 224(%rsp)
.L173:
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	272(%rsp), %rax
	xorl	%esi, %esi
	xorl	%edi, %edi
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %r9
	leaq	64(%rsp), %rax
	movq	%r12, %r8
	movl	$8, 8(%rsp)
	movq	$-1, %rcx
	movl	$2, %edx
	movl	$48, 12(%rsp)
	movdqu	8(%rsp), %xmm0
	movq	%rax, 24(%rsp)
	movq	%rax, 48(%rsp)
	movups	%xmm0, 32(%rsp)
	call	__vsnprintf_chk@PLT
	testl	%eax, %eax
	js	.L180
	movq	g_compilation_arena(%rip), %rdi
	cltq
	leaq	1(%rax), %rbx
	testq	%rdi, %rdi
	je	.L175
	movq	%rbx, %rsi
	call	arena_alloc@PLT
	movq	%rax, %rbp
.L176:
	testq	%rbp, %rbp
	je	.L181
	leaq	32(%rsp), %r9
	movq	%r12, %r8
	movl	$2, %edx
	movq	%rbx, %rsi
	movq	$-1, %rcx
	movq	%rbp, %rdi
	call	__vsnprintf_chk@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L182
	addq	$240, %rsp
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
.L175:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	jmp	.L176
.L180:
	leaq	.LC41(%rip), %rdi
	xorl	%eax, %eax
	call	dief
.L182:
	call	__stack_chk_fail@PLT
.L181:
	leaq	.LC39(%rip), %rdi
	xorl	%eax, %eax
	call	dief
	.cfi_endproc
.LFE60:
	.size	fmt, .-fmt
	.p2align 4
	.globl	vec_new
	.type	vec_new, @function
vec_new:
.LFB61:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	g_compilation_arena(%rip), %rdi
	movl	$24, %esi
	testq	%rdi, %rdi
	je	.L184
	call	arena_alloc@PLT
	pxor	%xmm0, %xmm0
	movq	$0, 16(%rax)
	movups	%xmm0, (%rax)
.L183:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L184:
	.cfi_restore_state
	movl	$1, %edi
	call	calloc@PLT
	testq	%rax, %rax
	jne	.L183
	leaq	.LC39(%rip), %rdi
	call	dief
	.cfi_endproc
.LFE61:
	.size	vec_new, .-vec_new
	.p2align 4
	.globl	vec_push
	.type	vec_push, @function
vec_push:
.LFB62:
	.cfi_startproc
	endbr64
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
	je	.L188
	movq	(%rdi), %rcx
.L189:
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
.L188:
	.cfi_restore_state
	testq	%rsi, %rsi
	jne	.L199
	movq	g_compilation_arena(%rip), %rdi
	movl	$64, %esi
	movl	$8, %r12d
	testq	%rdi, %rdi
	je	.L191
.L200:
	call	arena_alloc@PLT
	movq	(%rbx), %rsi
	movq	%rax, %rcx
	testq	%rsi, %rsi
	je	.L193
	movq	8(%rbx), %rax
	movq	%rcx, %rdi
	leaq	0(,%rax,8), %rdx
	call	memcpy@PLT
	movq	%rax, %rcx
.L193:
	movq	%rcx, (%rbx)
	movq	8(%rbx), %rsi
	movq	%r12, 16(%rbx)
	jmp	.L189
	.p2align 4,,10
	.p2align 3
.L199:
	movq	g_compilation_arena(%rip), %rdi
	leaq	(%rsi,%rsi), %r12
	salq	$4, %rsi
	testq	%rdi, %rdi
	jne	.L200
.L191:
	movq	(%rbx), %rdi
	call	realloc@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	jne	.L193
	leaq	.LC39(%rip), %rdi
	xorl	%eax, %eax
	call	dief
	.cfi_endproc
.LFE62:
	.size	vec_push, .-vec_push
	.p2align 4
	.globl	xmalloc
	.type	xmalloc, @function
xmalloc:
.LFB63:
	.cfi_startproc
	endbr64
	movq	g_compilation_arena(%rip), %rax
	testq	%rax, %rax
	je	.L202
	movq	%rdi, %rsi
	movq	%rax, %rdi
	jmp	arena_alloc@PLT
	.p2align 4,,10
	.p2align 3
.L202:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	malloc@PLT
	testq	%rax, %rax
	je	.L206
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L206:
	.cfi_restore_state
	leaq	.LC39(%rip), %rdi
	call	dief
	.cfi_endproc
.LFE63:
	.size	xmalloc, .-xmalloc
	.section	.rodata.str1.1
.LC42:
	.string	"$)"
.LC43:
	.string	"()"
.LC44:
	.string	"*/"
.LC45:
	.string	"[]"
.LC46:
	.string	">c"
.LC47:
	.string	">e"
.LC48:
	.string	">i"
.LC49:
	.string	">s"
.LC50:
	.string	"ex"
.LC51:
	.string	"lv"
.LC52:
	.string	"rd"
.LC53:
	.string	"sx"
.LC54:
	.string	"un"
.LC55:
	.string	"xx"
.LC56:
	.string	"??"
	.text
	.p2align 4
	.globl	get_error_code
	.type	get_error_code, @function
get_error_code:
.LFB64:
	.cfi_startproc
	endbr64
	cmpl	$13, %edi
	ja	.L208
	leaq	.L210(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L210:
	.long	.L223-.L210
	.long	.L224-.L210
	.long	.L221-.L210
	.long	.L220-.L210
	.long	.L219-.L210
	.long	.L218-.L210
	.long	.L217-.L210
	.long	.L216-.L210
	.long	.L215-.L210
	.long	.L214-.L210
	.long	.L213-.L210
	.long	.L212-.L210
	.long	.L211-.L210
	.long	.L209-.L210
	.text
	.p2align 4,,10
	.p2align 3
.L224:
	leaq	.LC43(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L223:
	leaq	.LC42(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L209:
	leaq	.LC55(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L220:
	leaq	.LC45(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L219:
	leaq	.LC46(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L218:
	leaq	.LC47(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L217:
	leaq	.LC48(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L221:
	leaq	.LC44(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L212:
	leaq	.LC53(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L211:
	leaq	.LC54(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L216:
	leaq	.LC49(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L215:
	leaq	.LC50(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L214:
	leaq	.LC51(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L213:
	leaq	.LC52(%rip), %rax
	ret
.L208:
	leaq	.LC56(%rip), %rax
	ret
	.cfi_endproc
.LFE64:
	.size	get_error_code, .-get_error_code
	.section	.rodata.str1.1
.LC57:
	.string	"{} imbalance"
.LC58:
	.string	"() imbalance"
.LC59:
	.string	"/* */ imbalance"
.LC60:
	.string	"[] imbalance"
.LC61:
	.string	"case table overflow (fatal)"
	.section	.rodata.str1.8
	.align 8
.LC62:
	.string	"expression stack overflow (fatal)"
	.section	.rodata.str1.1
.LC63:
	.string	"label table overflow (fatal)"
.LC64:
	.string	"symbol table overflow (fatal)"
.LC65:
	.string	"expression syntax"
.LC66:
	.string	"rvalue where lvalue expected"
.LC67:
	.string	"name redeclaration"
.LC68:
	.string	"statement syntax"
.LC69:
	.string	"undefined name"
.LC70:
	.string	"external syntax"
.LC71:
	.string	"unknown error"
	.text
	.p2align 4
	.globl	get_error_message
	.type	get_error_message, @function
get_error_message:
.LFB65:
	.cfi_startproc
	endbr64
	cmpl	$13, %edi
	ja	.L226
	leaq	.L228(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L228:
	.long	.L241-.L228
	.long	.L242-.L228
	.long	.L239-.L228
	.long	.L238-.L228
	.long	.L237-.L228
	.long	.L236-.L228
	.long	.L235-.L228
	.long	.L234-.L228
	.long	.L233-.L228
	.long	.L232-.L228
	.long	.L231-.L228
	.long	.L230-.L228
	.long	.L229-.L228
	.long	.L227-.L228
	.text
	.p2align 4,,10
	.p2align 3
.L242:
	leaq	.LC58(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L241:
	leaq	.LC57(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L227:
	leaq	.LC70(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L238:
	leaq	.LC60(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L237:
	leaq	.LC61(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L236:
	leaq	.LC62(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L235:
	leaq	.LC63(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L239:
	leaq	.LC59(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L230:
	leaq	.LC68(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L229:
	leaq	.LC69(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L234:
	leaq	.LC64(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L233:
	leaq	.LC65(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L232:
	leaq	.LC66(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L231:
	leaq	.LC67(%rip), %rax
	ret
.L226:
	leaq	.LC71(%rip), %rax
	ret
	.cfi_endproc
.LFE65:
	.size	get_error_message, .-get_error_message
	.section	.rodata.str1.1
.LC72:
	.string	"%s:%d:%d: error: %s"
.LC73:
	.string	"%s %s:%d\n"
	.text
	.p2align 4
	.globl	error_at_code
	.type	error_at_code, @function
error_at_code:
.LFB56:
	.cfi_startproc
	endbr64
	movl	g_verbose_errors(%rip), %r9d
	movq	stderr(%rip), %r10
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12
	movl	%edx, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movl	40(%r12), %r8d
	movq	%rcx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	48(%r12), %rcx
	movq	%rsi, %rbx
	testl	%r9d, %r9d
	je	.L244
	call	get_error_message
	movl	44(%r12), %r9d
	movl	$2, %esi
	movq	%r10, %rdi
	pushq	%rdx
	.cfi_def_cfa_offset 56
	leaq	.LC72(%rip), %rdx
	pushq	%rax
	.cfi_def_cfa_offset 64
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	popq	%rcx
	.cfi_def_cfa_offset 56
	popq	%rsi
	.cfi_def_cfa_offset 48
	testq	%rbp, %rbp
	je	.L245
	cmpb	$0, 0(%rbp)
	jne	.L280
.L245:
	leaq	.LC7(%rip), %r13
	movq	stderr(%rip), %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	movq	%r13, %rdx
	call	__fprintf_chk@PLT
.L246:
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	1(%rbx), %rdx
	movl	$1, %ecx
	addq	%rdx, %rax
	jmp	.L247
	.p2align 4,,10
	.p2align 3
.L249:
	cmpl	%ecx, 40(%r12)
	jle	.L254
	cmpb	$10, -1(%rdx)
	jne	.L248
	addl	$1, %ecx
	movq	%rdx, %rbx
.L248:
	addq	$1, %rdx
.L247:
	cmpq	%rdx, %rax
	jne	.L249
.L254:
	movzbl	(%rbx), %eax
	movq	stderr(%rip), %rdi
	testb	%al, %al
	je	.L252
	movq	%rbx, %rbp
	cmpb	$10, %al
	je	.L252
	.p2align 4,,10
	.p2align 3
.L250:
	movzbl	1(%rbp), %eax
	addq	$1, %rbp
	testb	%al, %al
	je	.L263
	cmpb	$10, %al
	jne	.L250
.L263:
	leaq	.LC37(%rip), %r14
	xorl	%eax, %eax
	movl	$2, %esi
	movq	%r14, %rdx
	call	__fprintf_chk@PLT
	cmpq	%rbp, %rbx
	jnb	.L257
	.p2align 4,,10
	.p2align 3
.L256:
	movsbl	(%rbx), %edi
	movq	stderr(%rip), %rsi
	addq	$1, %rbx
	call	fputc@PLT
	cmpq	%rbp, %rbx
	jne	.L256
.L257:
	movq	%r13, %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movl	$1, %ebx
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
	movq	%r14, %rdx
	movl	$2, %esi
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
	cmpl	$1, 44(%r12)
	jle	.L260
	.p2align 4,,10
	.p2align 3
.L259:
	movq	stderr(%rip), %rsi
	movl	$32, %edi
	addl	$1, %ebx
	call	fputc@PLT
	cmpl	%ebx, 44(%r12)
	jg	.L259
.L260:
	movq	stderr(%rip), %rdi
	leaq	.LC38(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movl	$1, %edi
	call	exit@PLT
.L244:
	call	get_error_code
	movl	%r8d, %r9d
	movq	%r10, %rdi
	movq	%rcx, %r8
	leaq	.LC73(%rip), %rdx
	movq	%rax, %rcx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	leaq	.LC7(%rip), %r13
	jmp	.L246
.L280:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rdx
	call	__fprintf_chk@PLT
	jmp	.L245
.L252:
	leaq	.LC37(%rip), %r14
	movl	$2, %esi
	xorl	%eax, %eax
	movq	%r14, %rdx
	call	__fprintf_chk@PLT
	jmp	.L257
	.cfi_endproc
.LFE56:
	.size	error_at_code, .-error_at_code
	.p2align 4
	.globl	error_at_location
	.type	error_at_location, @function
error_at_location:
.LFB57:
	.cfi_startproc
	endbr64
	movl	g_verbose_errors(%rip), %r9d
	movq	%rdi, %r10
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%ecx, %edi
	movq	stderr(%rip), %r11
	testl	%r9d, %r9d
	je	.L282
	movl	%edx, %r9d
	movq	%r10, %rcx
	movq	%r8, %rbx
	movl	%esi, %r8d
	call	get_error_message
	movl	$2, %esi
	movq	%r11, %rdi
	pushq	%rdx
	.cfi_def_cfa_offset 24
	leaq	.LC72(%rip), %rdx
	pushq	%rax
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	popq	%rcx
	.cfi_def_cfa_offset 24
	popq	%rsi
	.cfi_def_cfa_offset 16
	testq	%rbx, %rbx
	je	.L283
	cmpb	$0, (%rbx)
	jne	.L289
.L283:
	movq	stderr(%rip), %rdi
	leaq	.LC7(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
.L284:
	movl	$1, %edi
	call	exit@PLT
.L282:
	call	get_error_code
	movl	%esi, %r9d
	movq	%r10, %r8
	movl	$2, %esi
	movq	%rax, %rcx
	leaq	.LC73(%rip), %rdx
	movq	%r11, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L284
.L289:
	movq	stderr(%rip), %rdi
	movq	%rbx, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rdx
	call	__fprintf_chk@PLT
	jmp	.L283
	.cfi_endproc
.LFE57:
	.size	error_at_location, .-error_at_location
	.section	.rodata.str1.1
.LC74:
	.string	"char"
	.text
	.p2align 4
	.globl	b_library_function
	.type	b_library_function, @function
b_library_function:
.LFB66:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.LC74(%rip), %rsi
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	leaq	8+names.0(%rip), %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	jmp	.L292
	.p2align 4,,10
	.p2align 3
.L297:
	movq	(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L296
.L292:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L297
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L296:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE66:
	.size	b_library_function, .-b_library_function
	.section	.rodata.str1.1
.LC75:
	.string	"lchar"
.LC76:
	.string	"getchar"
.LC77:
	.string	"getchr"
.LC78:
	.string	"putchr"
.LC79:
	.string	"getstr"
.LC80:
	.string	"putstr"
.LC81:
	.string	"flush"
.LC82:
	.string	"reread"
.LC83:
	.string	"printf"
.LC84:
	.string	"printn"
.LC85:
	.string	"putnum"
.LC86:
	.string	"print"
.LC87:
	.string	"putchar"
.LC88:
	.string	"exit"
.LC89:
	.string	"abort"
.LC90:
	.string	"free"
.LC91:
	.string	"alloc"
.LC92:
	.string	"open"
.LC93:
	.string	"close"
.LC94:
	.string	"read"
.LC95:
	.string	"write"
.LC96:
	.string	"creat"
.LC97:
	.string	"seek"
.LC98:
	.string	"openr"
.LC99:
	.string	"openw"
.LC100:
	.string	"fork"
.LC101:
	.string	"wait"
.LC102:
	.string	"execl"
.LC103:
	.string	"execv"
.LC104:
	.string	"chdir"
.LC105:
	.string	"chmod"
.LC106:
	.string	"chown"
.LC107:
	.string	"link"
.LC108:
	.string	"unlink"
.LC109:
	.string	"stat"
.LC110:
	.string	"fstat"
.LC111:
	.string	"time"
.LC112:
	.string	"ctime"
.LC113:
	.string	"getuid"
.LC114:
	.string	"setuid"
.LC115:
	.string	"makdir"
.LC116:
	.string	"mkdir"
.LC117:
	.string	"intr"
.LC118:
	.string	"gtty"
.LC119:
	.string	"stty"
.LC120:
	.string	"system"
.LC121:
	.string	"usleep"
.LC122:
	.string	"callf"
.LC123:
	.string	"argc"
.LC124:
	.string	"argv"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	names.0, @object
	.size	names.0, 416
names.0:
	.quad	.LC74
	.quad	.LC75
	.quad	.LC76
	.quad	.LC77
	.quad	.LC78
	.quad	.LC79
	.quad	.LC80
	.quad	.LC81
	.quad	.LC82
	.quad	.LC83
	.quad	.LC84
	.quad	.LC85
	.quad	.LC86
	.quad	.LC87
	.quad	.LC88
	.quad	.LC89
	.quad	.LC90
	.quad	.LC91
	.quad	.LC92
	.quad	.LC93
	.quad	.LC94
	.quad	.LC95
	.quad	.LC96
	.quad	.LC97
	.quad	.LC98
	.quad	.LC99
	.quad	.LC100
	.quad	.LC101
	.quad	.LC102
	.quad	.LC103
	.quad	.LC104
	.quad	.LC105
	.quad	.LC106
	.quad	.LC107
	.quad	.LC108
	.quad	.LC109
	.quad	.LC110
	.quad	.LC111
	.quad	.LC112
	.quad	.LC113
	.quad	.LC114
	.quad	.LC115
	.quad	.LC116
	.quad	.LC117
	.quad	.LC118
	.quad	.LC119
	.quad	.LC120
	.quad	.LC121
	.quad	.LC122
	.quad	.LC123
	.quad	.LC124
	.quad	0
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
