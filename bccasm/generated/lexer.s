	.file	"lexer.c"
	.text
	.p2align 4
	.type	lx_get, @function
lx_get:
.LFB51:
	.cfi_startproc
	movq	16(%rdi), %rax
	xorl	%edx, %edx
	cmpq	8(%rdi), %rax
	jnb	.L1
	movq	(%rdi), %rdx
	movzbl	(%rdx,%rax), %edx
	testl	%edx, %edx
	je	.L1
	addq	$1, %rax
	movq	%rax, 16(%rdi)
	cmpl	$10, %edx
	je	.L9
	addl	$1, 28(%rdi)
.L1:
	movl	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	addl	$1, 24(%rdi)
	movl	%edx, %eax
	movl	$1, 28(%rdi)
	ret
	.cfi_endproc
.LFE51:
	.size	lx_get, .-lx_get
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"unterminated escape sequence"
.LC1:
	.string	"unknown escape sequence *%c"
	.text
	.p2align 4
	.type	parse_escape, @function
parse_escape:
.LFB52:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	%edx, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	movq	16(%rdi), %rdx
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpq	8(%rdi), %rdx
	jnb	.L11
	movq	(%rdi), %rax
	movzbl	(%rax,%rdx), %r9d
	movl	%r9d, %eax
	testl	%r9d, %r9d
	je	.L11
	addq	$1, %rdx
	movq	%rdx, 16(%rdi)
	cmpl	$10, %r9d
	je	.L31
	addl	$1, 28(%rdi)
	cmpb	$48, %r9b
	jg	.L14
	cmpb	$33, %r9b
	jle	.L13
	subl	$34, %eax
	cmpb	$14, %al
	ja	.L13
	leaq	.L16(%rip), %rdx
	movzbl	%al, %eax
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L16:
	.long	.L21-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L20-.L16
	.long	.L23-.L16
	.long	.L18-.L16
	.long	.L17-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L13-.L16
	.long	.L15-.L16
	.text
	.p2align 4,,10
	.p2align 3
.L14:
	cmpb	$110, %r9b
	je	.L24
	cmpb	$116, %r9b
	je	.L25
	cmpb	$101, %r9b
	jne	.L13
	movl	$4, %eax
	.p2align 4,,10
	.p2align 3
.L10:
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L32
	addq	$88, %rsp
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
	.p2align 4,,10
	.p2align 3
.L24:
	.cfi_restore_state
	movl	$10, %eax
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L20:
	movl	$39, %eax
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L21:
	movl	$34, %eax
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L17:
	movl	$42, %eax
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L15:
	xorl	%eax, %eax
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L23:
	movl	$123, %eax
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L31:
	addl	$1, 24(%rdi)
	movl	$1, 28(%rdi)
.L13:
	movq	%rsp, %r13
	movl	$64, %ecx
	movl	$2, %edx
	xorl	%eax, %eax
	leaq	.LC1(%rip), %r8
	movl	$64, %esi
	movq	%r13, %rdi
	call	__snprintf_chk@PLT
	movq	32(%rbx), %rdi
	movq	%r13, %r8
	movl	%r12d, %edx
	movl	$8, %ecx
	movl	%ebp, %esi
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L25:
	movl	$9, %eax
	jmp	.L10
.L11:
	movq	32(%rbx), %rdi
	leaq	.LC0(%rip), %r8
	movl	%r12d, %edx
	movl	%ebp, %esi
	movl	$8, %ecx
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L18:
	movl	$125, %eax
	jmp	.L10
.L32:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE52:
	.size	parse_escape, .-parse_escape
	.section	.rodata.str1.1
.LC2:
	.string	"unknown escape sequence \\%c"
	.text
	.p2align 4
	.type	parse_backslash_escape, @function
parse_backslash_escape:
.LFB53:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	testb	$4, g_extensions(%rip)
	je	.L34
	movq	16(%rdi), %rax
	movq	%rdi, %rbx
	movl	%esi, %r12d
	movl	%edx, %ebp
	cmpq	8(%rdi), %rax
	jnb	.L35
	movq	(%rdi), %rdx
	movzbl	(%rdx,%rax), %r9d
	testl	%r9d, %r9d
	je	.L35
	addq	$1, %rax
	movq	%rax, 16(%rdi)
	cmpl	$10, %r9d
	je	.L57
	addl	$1, 28(%rdi)
	cmpb	$92, %r9b
	je	.L34
	jg	.L38
	cmpb	$39, %r9b
	je	.L41
	cmpb	$48, %r9b
	je	.L42
	cmpb	$34, %r9b
	jne	.L37
	movl	$34, %eax
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L38:
	cmpb	$114, %r9b
	je	.L44
	cmpb	$116, %r9b
	je	.L45
	cmpb	$110, %r9b
	jne	.L37
	movl	$10, %eax
	.p2align 4,,10
	.p2align 3
.L33:
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L58
	addq	$88, %rsp
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
	.p2align 4,,10
	.p2align 3
.L57:
	.cfi_restore_state
	addl	$1, 24(%rdi)
	movl	$1, 28(%rdi)
.L37:
	movq	%rsp, %r13
	movl	$64, %ecx
	movl	$2, %edx
	xorl	%eax, %eax
	leaq	.LC2(%rip), %r8
	movl	$64, %esi
	movq	%r13, %rdi
	call	__snprintf_chk@PLT
	movq	32(%rbx), %rdi
	movq	%r13, %r8
	movl	%ebp, %edx
	movl	$8, %ecx
	movl	%r12d, %esi
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L44:
	movl	$13, %eax
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L41:
	movl	$39, %eax
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L45:
	movl	$9, %eax
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L34:
	movl	$92, %eax
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L42:
	xorl	%eax, %eax
	jmp	.L33
.L35:
	movq	32(%rbx), %rdi
	leaq	.LC0(%rip), %r8
	movl	%ebp, %edx
	movl	%r12d, %esi
	movl	$8, %ecx
	call	error_at_location@PLT
.L58:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE53:
	.size	parse_backslash_escape, .-parse_backslash_escape
	.section	.rodata.str1.1
.LC3:
	.string	"unterminated /* comment"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"// comments are not allowed in strict B mode (use /* */ or omit --strict)"
	.text
	.p2align 4
	.globl	lx_skip_ws_and_comments
	.type	lx_skip_ws_and_comments, @function
lx_skip_ws_and_comments:
.LFB54:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movq	8(%rdi), %r13
	movq	16(%rdi), %rax
.L60:
	cmpq	%r13, %rax
	jnb	.L59
	movq	(%rbx), %r12
	movzbl	(%r12,%rax), %ebp
	testl	%ebp, %ebp
	je	.L59
	call	__ctype_b_loc@PLT
	movq	(%rax), %rsi
	.p2align 4,,10
	.p2align 3
.L63:
	movslq	%ebp, %rax
	testb	$32, 1(%rsi,%rax,2)
	je	.L129
	movq	16(%rbx), %rax
	cmpq	%r13, %rax
	jnb	.L59
	movzbl	(%r12,%rax), %edx
	testl	%edx, %edx
	je	.L59
	leaq	1(%rax), %rcx
	movq	%rcx, 16(%rbx)
	cmpl	$10, %edx
	je	.L130
	movl	28(%rbx), %edi
	leal	1(%rdi), %edx
.L66:
	movl	%edx, 28(%rbx)
	cmpq	%r13, %rcx
	jnb	.L59
	movzbl	1(%r12,%rax), %ebp
	testl	%ebp, %ebp
	jne	.L63
.L59:
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
	.p2align 4,,10
	.p2align 3
.L130:
	.cfi_restore_state
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L66
	.p2align 4,,10
	.p2align 3
.L129:
	cmpl	$47, %ebp
	jne	.L59
	movq	16(%rbx), %rax
	leaq	1(%rax), %rdx
	cmpq	%r13, %rdx
	jnb	.L59
	leaq	(%r12,%rdx), %rsi
	movzbl	(%rsi), %ecx
	cmpb	$42, %cl
	je	.L131
	cmpb	$47, %cl
	jne	.L59
	testb	$2, g_extensions(%rip)
	jne	.L89
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	je	.L59
	movl	28(%rbx), %edx
	movl	24(%rbx), %esi
	leaq	.LC4(%rip), %r8
	movl	$8, %ecx
	movq	32(%rbx), %rdi
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L131:
	cmpq	%r13, %rax
	jnb	.L128
	movzbl	(%r12,%rax), %ecx
	testl	%ecx, %ecx
	je	.L101
	movq	%rdx, 16(%rbx)
	cmpl	$10, %ecx
	je	.L132
	addl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
.L75:
	testl	%ecx, %ecx
	je	.L133
	addq	$2, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	je	.L134
	movl	28(%rbx), %edi
	leal	1(%rdi), %edx
.L79:
	movl	%edx, 28(%rbx)
	cmpq	%r13, %rax
	jnb	.L77
	leaq	1(%rax), %rdx
.L101:
	addq	%r12, %rdx
.L78:
	movzbl	-1(%rdx), %esi
	testl	%esi, %esi
	je	.L128
	leaq	1(%rax), %rcx
	cmpl	$42, %esi
	je	.L135
	movq	%rcx, 16(%rbx)
	cmpl	$10, %esi
	jne	.L87
	addl	$1, 24(%rbx)
	movl	$1, %eax
	jmp	.L88
	.p2align 4,,10
	.p2align 3
.L89:
	cmpq	%r13, %rax
	jnb	.L59
	movzbl	(%r12,%rax), %ecx
	testl	%ecx, %ecx
	je	.L96
	movq	%rdx, 16(%rbx)
	cmpl	$10, %ecx
	je	.L136
	addl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
.L92:
	testl	%ecx, %ecx
	je	.L137
	addq	$2, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %ecx
	je	.L138
	movl	28(%rbx), %edi
	leal	1(%rdi), %edx
.L95:
	movl	%edx, 28(%rbx)
	cmpq	%r13, %rax
	jnb	.L59
.L96:
	movzbl	(%r12,%rax), %edx
	testl	%edx, %edx
	je	.L106
	cmpl	$10, %edx
	je	.L106
	addq	$1, %rax
	addl	$1, 28(%rbx)
	movq	%rax, 16(%rbx)
	cmpq	%rax, %r13
	jne	.L96
	jmp	.L60
	.p2align 4,,10
	.p2align 3
.L135:
	cmpq	%r13, %rcx
	jnb	.L82
	cmpb	$47, (%rdx)
	movq	%rcx, 16(%rbx)
	je	.L139
.L87:
	movl	28(%rbx), %eax
	addl	$1, %eax
.L88:
	movl	%eax, 28(%rbx)
	addq	$1, %rdx
	cmpq	%rcx, %r13
	je	.L72
	movq	%rcx, %rax
	jmp	.L78
.L128:
	movl	28(%rbx), %eax
.L72:
	movl	24(%rbx), %esi
	movq	32(%rbx), %rdi
	leaq	.LC3(%rip), %r8
	movl	%eax, %edx
	movl	$2, %ecx
	call	error_at_location@PLT
.L132:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
	jmp	.L75
.L136:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	movzbl	(%rsi), %ecx
	jmp	.L92
.L82:
	movq	%rcx, 16(%rbx)
	jmp	.L87
.L134:
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L79
.L138:
	addl	$1, 24(%rbx)
	movl	$1, %edx
	jmp	.L95
.L106:
	movq	16(%rbx), %rax
	jmp	.L60
.L139:
	movl	28(%rbx), %esi
	leal	1(%rsi), %edi
	movl	%edi, 28(%rbx)
	movzbl	(%rdx), %edi
	testl	%edi, %edi
	je	.L102
	addq	$2, %rax
	leal	2(%rsi), %edx
	movq	%rax, 16(%rbx)
	cmpl	$10, %edi
	jne	.L86
	addl	$1, 24(%rbx)
	movl	$1, %edx
.L86:
	movl	%edx, 28(%rbx)
	jmp	.L60
.L133:
	movq	%rdx, %rax
	addq	$1, %rdx
	jmp	.L101
.L137:
	movq	%rdx, %rax
	jmp	.L96
.L102:
	movq	%rcx, %rax
	jmp	.L60
.L77:
	movl	%edx, %eax
	jmp	.L72
	.cfi_endproc
.LFE54:
	.size	lx_skip_ws_and_comments, .-lx_skip_ws_and_comments
	.p2align 4
	.globl	mk_tok
	.type	mk_tok, @function
mk_tok:
.LFB55:
	.cfi_startproc
	endbr64
	movl	%esi, (%rdi)
	movq	%rdi, %rax
	movq	$0, 8(%rdi)
	movq	$0, 16(%rdi)
	movl	$0, 24(%rdi)
	movq	$0, 32(%rdi)
	movl	%edx, 40(%rdi)
	movl	%ecx, 44(%rdi)
	movq	%r8, 48(%rdi)
	ret
	.cfi_endproc
.LFE55:
	.size	mk_tok, .-mk_tok
	.section	.rodata.str1.1
.LC5:
	.string	"NUL byte outside a literal"
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"B72 names cannot exceed 8 characters"
	.align 8
.LC7:
	.string	"dots are not allowed in B72 names"
	.section	.rodata.str1.1
.LC8:
	.string	"out of memory"
.LC9:
	.string	"auto"
.LC10:
	.string	"else"
.LC11:
	.string	"while"
.LC12:
	.string	"return"
.LC13:
	.string	"extrn"
.LC14:
	.string	"break"
.LC15:
	.string	"continue"
.LC16:
	.string	"goto"
.LC17:
	.string	"switch"
.LC18:
	.string	"case"
.LC19:
	.string	"default"
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"hexadecimal literals are not allowed in strict B mode (use octal or omit --strict)"
	.align 8
.LC21:
	.string	"expected hexadecimal digit after prefix"
	.section	.rodata.str1.1
.LC22:
	.string	"bad octal digit '%c'"
.LC23:
	.string	"bad number"
.LC24:
	.string	"unterminated string"
	.section	.rodata.str1.8
	.align 8
.LC25:
	.string	"character constants longer than 2 bytes are not allowed in strict B72 mode"
	.section	.rodata.str1.1
.LC26:
	.string	"character constant too long"
	.section	.rodata.str1.8
	.align 8
.LC27:
	.string	"unterminated character constant"
	.section	.rodata.str1.1
.LC28:
	.string	"empty character constant"
	.section	.rodata.str1.8
	.align 8
.LC29:
	.string	"C-style compound assignments (op=) are not allowed in strict B mode (use =op)"
	.align 8
.LC30:
	.string	"|| is not part of Thompson B72 (use | or a conditional expression)"
	.section	.rodata.str1.1
.LC31:
	.string	"unexpected character '%c'"
	.text
	.p2align 4
	.globl	lx_next
	.type	lx_next, @function
lx_next:
.LFB57:
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
	movq	%rdi, %r13
	movq	%rsi, %rdi
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
	subq	$152, %rsp
	.cfi_def_cfa_offset 208
	movq	%fs:40, %rax
	movq	%rax, 136(%rsp)
	xorl	%eax, %eax
	call	lx_skip_ws_and_comments
	movq	24(%rbx), %rax
	movq	16(%rbx), %r12
	movq	8(%rbx), %r14
	movq	%rax, 8(%rsp)
	cmpq	%r14, %r12
	jnb	.L142
	movq	(%rbx), %r15
	movq	%rax, %xmm1
	movl	%eax, 40(%rsp)
	pshufd	$0xe5, %xmm1, %xmm2
	movd	%xmm2, 16(%rsp)
	leaq	(%r15,%r12), %r11
	movzbl	(%r11), %ebp
	testl	%ebp, %ebp
	jne	.L143
	movq	32(%rbx), %rdi
	movl	$8, %ecx
	movd	%xmm2, %edx
	movl	%eax, %esi
	leaq	.LC5(%rip), %r8
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L142:
	movq	32(%rbx), %rax
	movq	8(%rsp), %rcx
	movl	$0, 0(%r13)
	movq	$0, 8(%r13)
	movq	$0, 16(%r13)
	movl	$0, 24(%r13)
	movq	$0, 32(%r13)
	movq	%rcx, 40(%r13)
	movq	%rax, 48(%r13)
.L141:
	movq	136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L477
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r13, %rax
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
.L143:
	.cfi_restore_state
	movq	%r11, 32(%rsp)
	movb	%bpl, 47(%rsp)
	movq	%r14, 24(%rsp)
	call	__ctype_b_loc@PLT
	movq	24(%rsp), %rsi
	movq	32(%rsp), %r11
	movq	(%rax), %rdx
	movzbl	47(%rsp), %eax
	movq	%rax, %rcx
	movzwl	(%rdx,%rax,2), %eax
	testb	$4, %ah
	je	.L145
.L347:
	movq	%r12, %rbp
.L153:
	cmpq	%r14, %rbp
	jnb	.L478
.L152:
	movzbl	(%r15,%rbp), %eax
	movzbl	%al, %ecx
	testb	$8, (%rdx,%rcx,2)
	jne	.L155
	cmpb	$95, %al
	je	.L157
	cmpb	$46, %al
	je	.L157
	cmpb	$8, %al
	jne	.L154
.L157:
	addq	$1, %rbp
	movq	%rbp, 16(%rbx)
.L150:
	movl	28(%rbx), %eax
	addl	$1, %eax
.L151:
	movl	%eax, 28(%rbx)
	cmpq	%r14, %rbp
	jb	.L152
.L478:
	testb	$8, (%rdx)
	jne	.L153
.L154:
	movl	g_strict(%rip), %r14d
	testl	%r14d, %r14d
	je	.L158
	movq	%rbp, %rdx
	subq	%r12, %rdx
	cmpq	$8, %rdx
	ja	.L479
	movq	%r11, %rdi
	movl	$46, %esi
	movq	%r11, 24(%rsp)
	call	memchr@PLT
	movq	24(%rsp), %r11
	testq	%rax, %rax
	jne	.L480
.L158:
	movq	g_compilation_arena(%rip), %rdi
	testq	%rdi, %rdi
	jne	.L481
	cmpq	%rbp, %r12
	jnb	.L348
	subq	%r12, %rbp
	leaq	1(%rbp), %r14
.L162:
	movq	%r14, %rdi
	movq	%r11, 16(%rsp)
	call	malloc@PLT
	movq	16(%rsp), %r11
	testq	%rax, %rax
	movq	%rax, %r12
	je	.L199
	movq	%rbp, %rdx
	movq	%r14, %rcx
	movq	%r11, %rsi
	movq	%rax, %rdi
	call	__memcpy_chk@PLT
	movb	$0, (%r12,%rbp)
	movl	$1, %ebp
.L161:
	leaq	.LC9(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$5, %eax
	testl	%edx, %edx
	je	.L164
	cmpb	$105, (%r12)
	jne	.L367
	cmpb	$102, 1(%r12)
	je	.L482
.L367:
	leaq	.LC10(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$7, %eax
	testl	%edx, %edx
	je	.L164
	leaq	.LC11(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$8, %eax
	testl	%edx, %edx
	je	.L164
	leaq	.LC12(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$9, %eax
	testl	%edx, %edx
	je	.L164
	leaq	.LC13(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$12, %eax
	testl	%edx, %edx
	je	.L164
	movl	g_extensions(%rip), %r14d
	andl	$64, %r14d
	jne	.L483
.L166:
	leaq	.LC16(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$58, %eax
	testl	%edx, %edx
	je	.L164
	leaq	.LC17(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$59, %eax
	testl	%edx, %edx
	je	.L164
	leaq	.LC18(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$60, %eax
	testl	%edx, %edx
	je	.L164
	movl	$1, %eax
	testl	%r14d, %r14d
	je	.L164
	leaq	.LC19(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	cmpl	$1, %eax
	sbbl	%eax, %eax
	andl	$60, %eax
	addl	$1, %eax
	.p2align 4,,10
	.p2align 3
.L164:
	movl	%eax, 0(%r13)
	movq	32(%rbx), %rdx
	movq	8(%rsp), %rax
	movq	%r12, 8(%r13)
	movq	$0, 16(%r13)
	movl	%ebp, 24(%r13)
	movq	$0, 32(%r13)
	movq	%rax, 40(%r13)
	movq	%rdx, 48(%r13)
	jmp	.L141
	.p2align 4,,10
	.p2align 3
.L155:
	testl	%eax, %eax
	je	.L153
	addq	$1, %rbp
	movq	%rbp, 16(%rbx)
	cmpl	$10, %eax
	jne	.L150
	addl	$1, 24(%rbx)
	movl	$1, %eax
	jmp	.L151
	.p2align 4,,10
	.p2align 3
.L145:
	cmpl	$95, %ebp
	je	.L347
	cmpl	$8, %ebp
	je	.L347
	testb	$8, %ah
	jne	.L484
	leaq	1(%r12), %rdx
	cmpl	$34, %ebp
	je	.L485
	cmpl	$39, %ebp
	je	.L486
	cmpl	$43, %ebp
	je	.L487
	cmpl	$45, %ebp
	jne	.L488
	cmpq	%r14, %rdx
	jnb	.L489
	movzbl	1(%r15,%r12), %eax
	cmpb	$45, %al
	je	.L490
	testb	$8, g_extensions(%rip)
	je	.L470
	cmpb	$61, %al
	je	.L296
.L252:
	movq	%rdx, 16(%rbx)
	cmpl	$10, %ebp
	je	.L325
.L327:
	movl	16(%rsp), %eax
	subl	$33, %ecx
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	cmpb	$92, %cl
	ja	.L328
	leaq	.L330(%rip), %rdx
	movzbl	%cl, %ecx
	movslq	(%rdx,%rcx,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L330:
	.long	.L319-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L266-.L330
	.long	.L270-.L330
	.long	.L328-.L330
	.long	.L341-.L330
	.long	.L340-.L330
	.long	.L258-.L330
	.long	.L339-.L330
	.long	.L338-.L330
	.long	.L337-.L330
	.long	.L328-.L330
	.long	.L262-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L336-.L330
	.long	.L335-.L330
	.long	.L321-.L330
	.long	.L316-.L330
	.long	.L324-.L330
	.long	.L334-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L333-.L330
	.long	.L328-.L330
	.long	.L332-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L328-.L330
	.long	.L331-.L330
	.long	.L326-.L330
	.long	.L329-.L330
	.text
	.p2align 4,,10
	.p2align 3
.L481:
	movq	%rbp, %rcx
	movq	%r12, %rdx
	movq	%r15, %rsi
	xorl	%ebp, %ebp
	call	arena_xstrdup_range@PLT
	movq	%rax, %r12
	jmp	.L161
	.p2align 4,,10
	.p2align 3
.L348:
	movl	$1, %r14d
	xorl	%ebp, %ebp
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L482:
	cmpb	$0, 2(%r12)
	movl	$6, %eax
	je	.L164
	jmp	.L367
	.p2align 4,,10
	.p2align 3
.L484:
	movq	%r12, %rax
	cmpl	$48, %ebp
	je	.L491
	.p2align 4,,10
	.p2align 3
.L197:
	cmpq	%r14, %rax
	jnb	.L195
.L493:
	movzbl	(%r15,%rax), %esi
	testb	$8, 1(%rdx,%rsi,2)
	je	.L463
	testl	%esi, %esi
	je	.L197
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %esi
	je	.L492
	movl	28(%rbx), %edi
	leal	1(%rdi), %ecx
.L194:
	movl	%ecx, 28(%rbx)
	cmpq	%r14, %rax
	jb	.L493
.L195:
	testw	$2048, (%rdx)
	jne	.L197
.L463:
	movl	$0, 32(%rsp)
	movl	$10, %r14d
.L183:
	cmpq	%rax, %r12
	jnb	.L364
	subq	%r12, %rax
	movq	%rax, %rbp
	leaq	1(%rax), %r12
.L198:
	movq	%r12, %rdi
	movq	%r11, 24(%rsp)
	call	malloc@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	je	.L199
	movq	24(%rsp), %rsi
	movq	%r12, %rcx
	movq	%rbp, %rdx
	movq	%rax, %rdi
	call	__memcpy_chk@PLT
	movb	$0, (%r15,%rbp)
	call	__errno_location@PLT
	movl	$0, (%rax)
	movq	%rax, %r12
	cmpl	$8, %r14d
	jne	.L200
	movl	32(%rsp), %r9d
	testl	%r9d, %r9d
	jne	.L200
	testq	%rbp, %rbp
	je	.L365
	movq	%r15, %rdx
	addq	%r15, %rbp
	xorl	%esi, %esi
	.p2align 4,,10
	.p2align 3
.L203:
	movsbl	(%rdx), %r9d
	movl	%r9d, %eax
	subl	$48, %eax
	cmpb	$9, %al
	ja	.L494
	subl	$48, %r9d
	addq	$1, %rdx
	movslq	%r9d, %r9
	leaq	(%r9,%rsi,8), %rsi
	cmpq	%rbp, %rdx
	jne	.L203
.L205:
	movq	%rsi, %rbp
.L204:
	movq	%r15, %rdi
	call	free@PLT
	movl	(%r12), %r8d
	testl	%r8d, %r8d
	jne	.L473
	movq	32(%rbx), %rax
	movq	8(%rsp), %rdi
	movl	$2, 0(%r13)
	movq	$0, 8(%r13)
	movq	$0, 16(%r13)
	movl	$0, 24(%r13)
	movq	%rbp, 32(%r13)
	movq	%rdi, 40(%r13)
	movq	%rax, 48(%r13)
	jmp	.L141
	.p2align 4,,10
	.p2align 3
.L483:
	leaq	.LC14(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$10, %eax
	testl	%edx, %edx
	je	.L164
	leaq	.LC15(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	movl	%eax, %edx
	movl	$11, %eax
	testl	%edx, %edx
	jne	.L166
	jmp	.L164
.L522:
	testb	$16, %al
	jne	.L495
	cmpl	$0, g_pedantic(%rip)
	jne	.L496
	movq	%rdx, 16(%rbx)
	cmpl	$10, %ebp
	jne	.L471
.L325:
	movl	40(%rsp), %eax
	movl	$1, 28(%rbx)
	addl	$1, %eax
	movl	%eax, 24(%rbx)
.L328:
	leaq	64(%rsp), %r14
	movl	$64, %ecx
	movl	%ebp, %r9d
	xorl	%eax, %eax
	leaq	.LC31(%rip), %r8
	movl	$2, %edx
	movl	$64, %esi
	movq	%r14, %rdi
	call	__snprintf_chk@PLT
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	movq	%r14, %r8
	movl	40(%rsp), %esi
	movl	$8, %ecx
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L492:
	addl	$1, 24(%rbx)
	movl	$1, %ecx
	jmp	.L194
	.p2align 4,,10
	.p2align 3
.L364:
	movl	$1, %r12d
	xorl	%ebp, %ebp
	jmp	.L198
.L491:
	leaq	1(%r12), %rax
	cmpq	%r14, %rax
	jnb	.L169
	leaq	(%r15,%rax), %rsi
	movzbl	(%rsi), %ecx
	andl	$-33, %ecx
	cmpb	$88, %cl
	je	.L497
.L169:
	movl	16(%rsp), %edi
	movq	%rax, 16(%rbx)
	addl	$1, %edi
	.p2align 4,,10
	.p2align 3
.L185:
	movl	%edi, 28(%rbx)
.L191:
	cmpq	%r14, %rax
	jnb	.L189
	movzbl	(%r15,%rax), %esi
	testb	$8, 1(%rdx,%rsi,2)
	je	.L464
	testl	%esi, %esi
	je	.L191
	addq	$1, %rax
	addl	$1, %edi
	movq	%rax, 16(%rbx)
	cmpl	$10, %esi
	jne	.L185
	addl	$1, 24(%rbx)
	movl	$1, %edi
	jmp	.L185
	.p2align 4,,10
	.p2align 3
.L189:
	testw	$2048, (%rdx)
	jne	.L191
.L464:
	movl	$0, 32(%rsp)
	movl	$8, %r14d
	jmp	.L183
.L200:
	xorl	%esi, %esi
	movl	%r14d, %edx
	movq	%r15, %rdi
	call	strtoull@PLT
	cmpl	$34, (%r12)
	movq	%rax, %rsi
	jne	.L205
.L473:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	leaq	.LC23(%rip), %r8
	movl	$8, %ecx
	movl	40(%rsp), %esi
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L487:
	cmpq	%r14, %rdx
	jnb	.L498
	cmpb	$43, 1(%r15,%r12)
	je	.L499
	testb	$8, g_extensions(%rip)
	je	.L242
	cmpb	$61, 1(%r15,%r12)
	jne	.L252
.L476:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$38, 0(%r13)
	movq	32(%rbx), %rax
	.p2align 4,,10
	.p2align 3
.L472:
	movq	8(%rsp), %rdi
	movq	$0, 8(%r13)
	movq	$0, 16(%r13)
	movl	$0, 24(%r13)
	movq	$0, 32(%r13)
	movq	%rdi, 40(%r13)
	movq	%rax, 48(%r13)
	jmp	.L141
.L485:
	movl	16(%rsp), %eax
	movq	%rdx, 16(%rbx)
	movl	$1, %edi
	movq	%rsi, 32(%rsp)
	addl	$1, %eax
	movq	%rdx, 24(%rsp)
	movl	%eax, 28(%rbx)
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L199
	movq	24(%rsp), %rdx
	movq	32(%rsp), %rsi
	cmpq	%rsi, %rdx
	jnb	.L208
	xorl	%r14d, %r14d
	movl	$1, %ebp
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L505:
	movq	(%rbx), %r15
	addq	$1, %r14
.L219:
	movzbl	(%r15,%rdx), %r10d
	testl	%r10d, %r10d
	je	.L208
	addq	$1, %rdx
	movq	%rdx, 16(%rbx)
	cmpl	$10, %r10d
	je	.L500
	addl	$1, 28(%rbx)
	cmpl	$34, %r10d
	je	.L501
	cmpl	$42, %r10d
	je	.L502
	cmpl	$92, %r10d
	je	.L503
.L210:
	leaq	2(%r14), %rax
	cmpq	%rax, %rbp
	jb	.L504
.L218:
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rsi
	movb	%r10b, (%r12,%r14)
	cmpq	%rsi, %rdx
	jb	.L505
.L208:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	leaq	.LC24(%rip), %r8
	movl	$8, %ecx
	movl	40(%rsp), %esi
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L502:
	cmpq	%rsi, %rdx
	jnb	.L210
	movzbl	(%r15,%rdx), %eax
	cmpb	$48, %al
	jg	.L214
	cmpb	$33, %al
	jle	.L210
	movabsq	$289738493788160, %rdi
	btq	%rax, %rdi
	jnc	.L210
.L216:
	movl	16(%rsp), %edx
	movl	40(%rsp), %esi
	movq	%rbx, %rdi
	call	parse_escape
	movl	%eax, %r10d
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L504:
	leaq	8(%rbp,%rbp), %rbp
	movq	%r12, %rdi
	movl	%r10d, 24(%rsp)
	movq	%rbp, %rsi
	call	realloc@PLT
	movl	24(%rsp), %r10d
	testq	%rax, %rax
	movq	%rax, %r12
	jne	.L218
.L199:
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L500:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L503:
	movl	16(%rsp), %edx
	movl	40(%rsp), %esi
	movq	%rbx, %rdi
	call	parse_backslash_escape
	movl	%eax, %r10d
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L214:
	subl	$101, %eax
	cmpb	$15, %al
	ja	.L210
	movl	$33281, %edx
	btq	%rax, %rdx
	jc	.L216
	jmp	.L210
.L501:
	movq	g_compilation_arena(%rip), %rdi
	movb	$0, (%r12,%r14)
	movl	$1, %eax
	testq	%rdi, %rdi
	je	.L220
	leaq	1(%r14), %r15
	movq	%r15, %rsi
	call	arena_alloc@PLT
	movq	%r12, %rsi
	movq	%r15, %rdx
	movq	%rax, %rdi
	movq	%rax, %rbp
	call	memcpy@PLT
	movq	%r12, %rdi
	movq	%rbp, %r12
	call	free@PLT
	xorl	%eax, %eax
.L220:
	movl	%eax, 24(%r13)
	movq	32(%rbx), %rdx
	movq	8(%rsp), %rax
	movl	$3, 0(%r13)
	movq	%r12, 8(%r13)
	movq	%r14, 16(%r13)
	movq	$0, 32(%r13)
	movq	%rax, 40(%r13)
	movq	%rdx, 48(%r13)
	jmp	.L141
.L488:
	movl	g_extensions(%rip), %eax
	testb	$8, %al
	jne	.L245
	movl	g_pedantic(%rip), %esi
	testl	%esi, %esi
	je	.L280
	cmpb	$47, %cl
	jg	.L281
	cmpb	$36, %cl
	jg	.L506
.L248:
	cmpl	$33, %ebp
	jne	.L252
	cmpq	%r14, %rdx
	jnb	.L320
	cmpb	$61, 1(%r15,%r12)
	je	.L507
.L320:
	movl	16(%rsp), %r12d
	movq	%rdx, 16(%rbx)
	addl	$1, %r12d
	movl	%r12d, 28(%rbx)
.L319:
	movl	$35, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
	.p2align 4,,10
	.p2align 3
.L486:
	movl	16(%rsp), %eax
	pxor	%xmm0, %xmm0
	movq	%rdx, 16(%rbx)
	movaps	%xmm0, 48(%rsp)
	addl	$1, %eax
	movl	%eax, 28(%rbx)
	cmpq	%r14, %rdx
	jnb	.L222
	xorl	%ebp, %ebp
	jmp	.L236
	.p2align 4,,10
	.p2align 3
.L231:
	cmpl	$92, %eax
	je	.L508
.L224:
	movl	%eax, 48(%rsp,%rbp,4)
	cmpq	%r14, %rcx
	jnb	.L222
	movq	(%rbx), %r15
	addq	$1, %rbp
	movq	%rcx, %rdx
.L236:
	movzbl	(%r15,%rdx), %eax
	testl	%eax, %eax
	je	.L222
	leaq	1(%rdx), %rcx
	movq	%rcx, 16(%rbx)
	cmpl	$10, %eax
	je	.L509
	addl	$1, 28(%rbx)
	cmpl	$39, %eax
	je	.L510
	cmpq	$1, %rbp
	jbe	.L228
	testb	$32, g_extensions(%rip)
	je	.L229
	cmpq	$4, %rbp
	je	.L230
.L228:
	cmpl	$42, %eax
	jne	.L231
	cmpq	%r14, %rcx
	jnb	.L224
	movzbl	(%r15,%rcx), %esi
	cmpb	$39, %sil
	je	.L232
	jle	.L511
	cmpb	$116, %sil
	jg	.L224
	cmpb	$100, %sil
	jg	.L235
	cmpb	$42, %sil
	jle	.L234
	cmpb	$48, %sil
	jne	.L224
.L234:
	movl	16(%rsp), %edx
	movl	40(%rsp), %esi
	movq	%rbx, %rdi
	call	parse_escape
	movq	16(%rbx), %rcx
	movq	8(%rbx), %r14
	movzbl	%al, %eax
	jmp	.L224
	.p2align 4,,10
	.p2align 3
.L222:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	leaq	.LC27(%rip), %r8
	movl	$8, %ecx
	movl	40(%rsp), %esi
	call	error_at_location@PLT
.L509:
	addl	$1, 24(%rbx)
	movl	$1, 28(%rbx)
	cmpq	$1, %rbp
	jbe	.L224
	testb	$32, g_extensions(%rip)
	je	.L229
	cmpq	$4, %rbp
	jne	.L224
.L230:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	leaq	.LC26(%rip), %r8
	movl	$8, %ecx
	movl	40(%rsp), %esi
	call	error_at_location@PLT
.L280:
	cmpl	$61, %ebp
	jne	.L286
.L343:
	cmpq	%r14, %rdx
	jnb	.L317
	movzbl	1(%r15,%r12), %ecx
	movl	%ecx, %eax
	cmpb	$43, %cl
	je	.L476
	cmpb	$60, %cl
	jg	.L290
	cmpb	$36, %cl
	jle	.L291
	subl	$37, %eax
	cmpb	$23, %al
	ja	.L292
	leaq	.L294(%rip), %rsi
	movzbl	%al, %eax
	movslq	(%rsi,%rax,4), %rax
	addq	%rsi, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L294:
	.long	.L299-.L294
	.long	.L298-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L297-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L296-.L294
	.long	.L292-.L294
	.long	.L295-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L292-.L294
	.long	.L293-.L294
	.text
.L292:
	cmpl	$61, %ecx
	jne	.L306
	cmpb	$61, 2(%r15,%r12)
	je	.L512
.L306:
	cmpq	%r14, %rdx
	jnb	.L317
	cmpb	$61, 1(%r15,%r12)
	je	.L513
.L317:
	movl	16(%rsp), %r12d
	movq	%rdx, 16(%rbx)
	addl	$1, %r12d
	movl	%r12d, 28(%rbx)
.L316:
	movl	$21, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L296:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$39, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L245:
	cmpl	$42, %ebp
	je	.L514
	cmpl	$47, %ebp
	jne	.L259
	cmpq	%r14, %rdx
	jnb	.L260
	cmpb	$61, 1(%r15,%r12)
	jne	.L252
.L295:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$41, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L514:
	cmpq	%r14, %rdx
	jnb	.L256
	cmpb	$61, 1(%r15,%r12)
	jne	.L252
.L297:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$40, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L298:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$45, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L299:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$42, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L293:
	movzbl	2(%r15,%r12), %eax
	movq	%rbx, %rdi
	cmpb	$60, %al
	je	.L475
	cmpb	$61, %al
	je	.L515
	call	lx_get
	call	lx_get
	movl	$47, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
	.p2align 4,,10
	.p2align 3
.L497:
	testb	$1, g_extensions(%rip)
	jne	.L170
	movl	g_pedantic(%rip), %r10d
	movq	32(%rbx), %rdi
	testl	%r10d, %r10d
	jne	.L516
	movl	16(%rsp), %r12d
	movq	%rax, 16(%rbx)
	movq	8(%rsp), %rax
	movl	$2, 0(%r13)
	addl	$1, %r12d
	movq	$0, 8(%r13)
	movl	%r12d, 28(%rbx)
	movq	$0, 16(%r13)
	movl	$0, 24(%r13)
	movq	$0, 32(%r13)
	movq	%rax, 40(%r13)
	movq	%rdi, 48(%r13)
	jmp	.L141
.L508:
	movl	16(%rsp), %edx
	movl	40(%rsp), %esi
	movq	%rbx, %rdi
	call	parse_backslash_escape
	movq	16(%rbx), %rcx
	movq	8(%rbx), %r14
	movzbl	%al, %eax
	jmp	.L224
.L498:
	testb	$8, g_extensions(%rip)
	jne	.L252
.L242:
	movl	g_pedantic(%rip), %eax
	testl	%eax, %eax
	je	.L252
	cmpq	%r14, %rdx
	jnb	.L252
.L466:
	cmpb	$61, 1(%r15,%r12)
	je	.L282
.L268:
	movq	%rdx, 16(%rbx)
	jmp	.L327
.L489:
	testb	$8, g_extensions(%rip)
	jne	.L252
.L470:
	movl	g_pedantic(%rip), %edi
	testl	%edi, %edi
	je	.L252
	cmpq	%r14, %rdx
	jnb	.L252
	cmpb	$61, 1(%r15,%r12)
	jne	.L252
.L282:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	leaq	.LC29(%rip), %r8
	movl	$8, %ecx
	movl	40(%rsp), %esi
	call	error_at_location@PLT
	.p2align 4,,10
	.p2align 3
.L232:
	leaq	2(%rdx), %rsi
	cmpq	%r14, %rsi
	jnb	.L224
	cmpb	$39, 2(%r15,%rdx)
	jne	.L224
	jmp	.L234
.L286:
	cmpl	$60, %ebp
	jne	.L309
	cmpq	%r14, %rdx
	jnb	.L322
.L468:
	cmpb	$60, 1(%r15,%r12)
	je	.L517
	cmpb	$61, 1(%r15,%r12)
	je	.L518
.L322:
	movl	16(%rsp), %r12d
	movq	%rdx, 16(%rbx)
	addl	$1, %r12d
	movl	%r12d, 28(%rbx)
.L321:
	movl	$24, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L259:
	cmpl	$37, %ebp
	jne	.L263
	cmpq	%r14, %rdx
	jnb	.L264
	cmpb	$61, 1(%r15,%r12)
	je	.L299
.L264:
	movl	16(%rsp), %r12d
	movq	%rdx, 16(%rbx)
	addl	$1, %r12d
	movl	%r12d, 28(%rbx)
.L266:
	movl	$34, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L511:
	cmpb	$34, %sil
	jne	.L224
	jmp	.L234
.L170:
	movl	16(%rsp), %edi
	movq	%rax, 16(%rbx)
	leal	1(%rdi), %ecx
	movl	%ecx, 28(%rbx)
	movzbl	(%rsi), %esi
	testl	%esi, %esi
	je	.L172
	leaq	2(%r12), %rax
	leal	2(%rdi), %ecx
	movq	%rax, 16(%rbx)
	cmpl	$10, %esi
	jne	.L174
	movl	40(%rsp), %edi
	leal	1(%rdi), %ecx
	movl	%ecx, 24(%rbx)
	movl	$1, %ecx
.L174:
	movl	%ecx, 28(%rbx)
	xorl	%ecx, %ecx
	cmpq	%r14, %rax
	jnb	.L175
.L172:
	movzbl	(%r15,%rax), %ecx
.L175:
	testb	$16, 1(%rdx,%rcx,2)
	je	.L176
	movq	16(%rbx), %rax
.L184:
	cmpq	%r14, %rax
	jnb	.L181
.L520:
	movzbl	(%r15,%rax), %esi
	testb	$16, 1(%rdx,%rsi,2)
	je	.L462
	testl	%esi, %esi
	je	.L184
	addq	$1, %rax
	movq	%rax, 16(%rbx)
	cmpl	$10, %esi
	je	.L519
	movl	28(%rbx), %edi
	leal	1(%rdi), %ecx
.L180:
	movl	%ecx, 28(%rbx)
	cmpq	%r14, %rax
	jb	.L520
.L181:
	testw	$4096, (%rdx)
	jne	.L184
.L462:
	movl	$1, 32(%rsp)
	movl	$16, %r14d
	jmp	.L183
.L519:
	addl	$1, 24(%rbx)
	movl	$1, %ecx
	jmp	.L180
.L235:
	subl	$101, %esi
	movl	$33281, %edx
	btq	%rsi, %rdx
	jc	.L234
	jmp	.L224
.L510:
	movq	32(%rbx), %rdi
	testl	%ebp, %ebp
	je	.L521
	leaq	48(%rsp), %rdx
	movslq	%ebp, %rbp
	xorl	%eax, %eax
	leaq	(%rdx,%rbp,4), %rsi
.L238:
	movl	(%rdx), %ecx
	salq	$8, %rax
	addq	$4, %rdx
	orq	%rcx, %rax
	cmpq	%rdx, %rsi
	jne	.L238
	movq	%rax, 32(%r13)
	movq	8(%rsp), %rax
	movl	$4, 0(%r13)
	movq	$0, 8(%r13)
	movq	$0, 16(%r13)
	movl	$0, 24(%r13)
	movq	%rax, 40(%r13)
	movq	%rdi, 48(%r13)
	jmp	.L141
.L365:
	xorl	%ebp, %ebp
	jmp	.L204
.L281:
	cmpb	$124, %cl
	jne	.L280
	cmpq	%r14, %rdx
	jnb	.L271
	cmpb	$61, 1(%r15,%r12)
	je	.L282
.L272:
	cmpb	$124, 1(%r15,%r12)
	je	.L522
.L271:
	movq	%rdx, 16(%rbx)
.L471:
	movl	16(%rsp), %r12d
	addl	$1, %r12d
	movl	%r12d, 28(%rbx)
.L326:
	movl	$54, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L256:
	movl	16(%rsp), %r12d
	movq	%rdx, 16(%rbx)
	addl	$1, %r12d
	movl	%r12d, 28(%rbx)
.L258:
	movl	$32, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L340:
	movl	$14, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L341:
	movl	$13, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L263:
	cmpl	$38, %ebp
	jne	.L267
	cmpq	%r14, %rdx
	jnb	.L268
	cmpb	$61, 1(%r15,%r12)
	je	.L298
	movl	16(%rsp), %r12d
	movq	%rdx, 16(%rbx)
	addl	$1, %r12d
	movl	%r12d, 28(%rbx)
.L270:
	movl	$53, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L329:
	movl	$16, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L332:
	movl	$20, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L333:
	movl	$19, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L334:
	movl	$56, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L309:
	cmpl	$62, %ebp
	jne	.L310
	cmpq	%r14, %rdx
	jnb	.L323
.L278:
	cmpb	$62, 1(%r15,%r12)
	je	.L279
	cmpb	$61, 1(%r15,%r12)
	je	.L523
.L323:
	movl	16(%rsp), %r12d
	movq	%rdx, 16(%rbx)
	addl	$1, %r12d
	movl	%r12d, 28(%rbx)
.L324:
	movl	$26, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L331:
	movl	$15, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L499:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$36, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L290:
	cmpb	$124, %cl
	jne	.L524
.L300:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$46, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L490:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$37, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L335:
	movl	$18, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L336:
	movl	$57, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L260:
	movl	16(%rsp), %r12d
	movq	%rdx, 16(%rbx)
	addl	$1, %r12d
	movl	%r12d, 28(%rbx)
.L262:
	movl	$33, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L337:
	movl	$31, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L338:
	movl	$17, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L339:
	movl	$30, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L517:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$28, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L513:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$22, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L518:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$25, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L477:
	call	__stack_chk_fail@PLT
.L507:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$23, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L495:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$55, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L494:
	leaq	64(%rsp), %rbp
	leaq	.LC22(%rip), %r8
	movl	$64, %ecx
	xorl	%eax, %eax
	movl	$2, %edx
	movl	$64, %esi
	movq	%rbp, %rdi
	call	__snprintf_chk@PLT
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	movq	%rbp, %r8
	movl	40(%rsp), %esi
	movl	$8, %ecx
	call	error_at_location@PLT
.L241:
	cmpl	$60, %ebp
	jne	.L273
	cmpq	%r14, %rdx
	jnb	.L322
	cmpb	$60, 1(%r15,%r12)
	jne	.L468
	leaq	2(%r12), %rax
	cmpq	%r14, %rax
	jnb	.L468
	cmpb	$61, 2(%r15,%r12)
	movq	%rbx, %rdi
	jne	.L468
.L475:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$43, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L515:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$48, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L480:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	leaq	.LC7(%rip), %r8
	movl	$8, %ecx
	movl	40(%rsp), %esi
	call	error_at_location@PLT
.L479:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	leaq	.LC6(%rip), %r8
	movl	$8, %ecx
	movl	40(%rsp), %esi
	call	error_at_location@PLT
.L496:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	leaq	.LC30(%rip), %r8
	movl	$8, %ecx
	movl	40(%rsp), %esi
	call	error_at_location@PLT
.L523:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$27, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L279:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	movl	$29, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L310:
	cmpl	$124, %ebp
	jne	.L248
	cmpq	%r14, %rdx
	jb	.L272
	jmp	.L271
.L506:
	movl	$1379, %eax
	salq	$37, %rax
	btq	%rcx, %rax
	jnc	.L252
	cmpq	%r14, %rdx
	jb	.L466
	jmp	.L248
.L521:
	movl	16(%rsp), %edx
	movl	40(%rsp), %esi
	movl	$8, %ecx
	leaq	.LC28(%rip), %r8
	call	error_at_location@PLT
.L524:
	cmpl	$62, %ecx
	jne	.L292
	movzbl	2(%r15,%r12), %eax
	movq	%rbx, %rdi
	cmpb	$62, %al
	je	.L474
	cmpb	$61, %al
	je	.L525
	call	lx_get
	call	lx_get
	movl	$49, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
	.p2align 4,,10
	.p2align 3
.L273:
	cmpl	$62, %ebp
	jne	.L276
	cmpq	%r14, %rdx
	jnb	.L323
	cmpb	$62, 1(%r15,%r12)
	jne	.L278
	leaq	2(%r12), %rax
	cmpq	%r14, %rax
	jnb	.L279
	cmpb	$61, 2(%r15,%r12)
	movq	%rbx, %rdi
	jne	.L278
.L474:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$44, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L525:
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$50, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
	.p2align 4,,10
	.p2align 3
.L267:
	cmpl	$124, %ebp
	jne	.L241
	cmpq	%r14, %rdx
	jnb	.L271
	cmpb	$61, 1(%r15,%r12)
	jne	.L272
	jmp	.L300
.L516:
	movl	16(%rsp), %edx
	movl	40(%rsp), %esi
	movl	$8, %ecx
	leaq	.LC20(%rip), %r8
	call	error_at_location@PLT
.L276:
	cmpl	$61, %ebp
	je	.L343
	jmp	.L248
.L176:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	leaq	.LC21(%rip), %r8
	movl	$8, %ecx
	movl	40(%rsp), %esi
	call	error_at_location@PLT
.L229:
	movq	32(%rbx), %rdi
	movl	16(%rsp), %edx
	leaq	.LC25(%rip), %r8
	movl	$8, %ecx
	movl	40(%rsp), %esi
	call	error_at_location@PLT
.L291:
	cmpl	$33, %ecx
	jne	.L306
	cmpb	$61, 2(%r15,%r12)
	jne	.L306
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$52, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
.L512:
	movq	%rbx, %rdi
	call	lx_get
	call	lx_get
	call	lx_get
	movl	$51, 0(%r13)
	movq	32(%rbx), %rax
	jmp	.L472
	.cfi_endproc
.LFE57:
	.size	lx_next, .-lx_next
	.p2align 4
	.globl	tok_free
	.type	tok_free, @function
tok_free:
.LFB58:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	movq	8(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L527
	movl	24(%rbx), %eax
	testl	%eax, %eax
	jne	.L532
.L527:
	movq	$0, 8(%rbx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L532:
	.cfi_restore_state
	call	free@PLT
	movq	$0, 8(%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE58:
	.size	tok_free, .-tok_free
	.section	.rodata.str1.1
.LC32:
	.string	"EOF"
.LC33:
	.string	"identifier"
.LC34:
	.string	"number"
.LC35:
	.string	"string"
.LC36:
	.string	"character"
.LC37:
	.string	"if"
.LC38:
	.string	"("
.LC39:
	.string	")"
.LC40:
	.string	"{"
.LC41:
	.string	"}"
.LC42:
	.string	","
.LC43:
	.string	";"
.LC44:
	.string	"="
.LC45:
	.string	"=="
.LC46:
	.string	"!="
.LC47:
	.string	"<"
.LC48:
	.string	"<="
.LC49:
	.string	">"
.LC50:
	.string	">="
.LC51:
	.string	"<<"
.LC52:
	.string	">>"
.LC53:
	.string	"+"
.LC54:
	.string	"-"
.LC55:
	.string	"*"
.LC56:
	.string	"/"
.LC57:
	.string	"%"
.LC58:
	.string	"!"
.LC59:
	.string	"?"
.LC60:
	.string	"["
.LC61:
	.string	"]"
.LC62:
	.string	"++"
.LC63:
	.string	"--"
.LC64:
	.string	"=+"
.LC65:
	.string	"=-"
.LC66:
	.string	"=*"
.LC67:
	.string	"=/"
.LC68:
	.string	"=%"
.LC69:
	.string	"=<<"
.LC70:
	.string	"=>>"
.LC71:
	.string	"=&"
.LC72:
	.string	"=|"
.LC73:
	.string	"=<"
.LC74:
	.string	"=<="
.LC75:
	.string	"=>"
.LC76:
	.string	"=>="
.LC77:
	.string	"==="
.LC78:
	.string	"=!="
.LC79:
	.string	"&"
.LC80:
	.string	"|"
.LC81:
	.string	"||"
.LC82:
	.string	":"
.LC83:
	.string	"<unknown token>"
	.text
	.p2align 4
	.globl	tk_name
	.type	tk_name, @function
tk_name:
.LFB59:
	.cfi_startproc
	endbr64
	cmpl	$61, %edi
	ja	.L534
	leaq	.L536(%rip), %rdx
	movl	%edi, %edi
	movslq	(%rdx,%rdi,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L536:
	.long	.L597-.L536
	.long	.L598-.L536
	.long	.L595-.L536
	.long	.L594-.L536
	.long	.L593-.L536
	.long	.L592-.L536
	.long	.L591-.L536
	.long	.L590-.L536
	.long	.L589-.L536
	.long	.L588-.L536
	.long	.L587-.L536
	.long	.L586-.L536
	.long	.L585-.L536
	.long	.L584-.L536
	.long	.L583-.L536
	.long	.L582-.L536
	.long	.L581-.L536
	.long	.L580-.L536
	.long	.L579-.L536
	.long	.L578-.L536
	.long	.L577-.L536
	.long	.L576-.L536
	.long	.L575-.L536
	.long	.L574-.L536
	.long	.L573-.L536
	.long	.L572-.L536
	.long	.L571-.L536
	.long	.L570-.L536
	.long	.L569-.L536
	.long	.L568-.L536
	.long	.L567-.L536
	.long	.L566-.L536
	.long	.L565-.L536
	.long	.L564-.L536
	.long	.L563-.L536
	.long	.L562-.L536
	.long	.L561-.L536
	.long	.L560-.L536
	.long	.L559-.L536
	.long	.L558-.L536
	.long	.L557-.L536
	.long	.L556-.L536
	.long	.L555-.L536
	.long	.L554-.L536
	.long	.L553-.L536
	.long	.L552-.L536
	.long	.L551-.L536
	.long	.L550-.L536
	.long	.L549-.L536
	.long	.L548-.L536
	.long	.L547-.L536
	.long	.L546-.L536
	.long	.L545-.L536
	.long	.L544-.L536
	.long	.L543-.L536
	.long	.L542-.L536
	.long	.L541-.L536
	.long	.L540-.L536
	.long	.L539-.L536
	.long	.L538-.L536
	.long	.L537-.L536
	.long	.L535-.L536
	.text
	.p2align 4,,10
	.p2align 3
.L598:
	leaq	.LC33(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L597:
	leaq	.LC32(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L535:
	leaq	.LC19(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L552:
	leaq	.LC71(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L553:
	leaq	.LC70(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L554:
	leaq	.LC69(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L555:
	leaq	.LC68(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L556:
	leaq	.LC67(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L557:
	leaq	.LC66(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L558:
	leaq	.LC65(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L559:
	leaq	.LC64(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L560:
	leaq	.LC63(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L561:
	leaq	.LC62(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L562:
	leaq	.LC58(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L563:
	leaq	.LC57(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L564:
	leaq	.LC56(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L565:
	leaq	.LC55(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L566:
	leaq	.LC54(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L543:
	leaq	.LC80(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L544:
	leaq	.LC79(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L545:
	leaq	.LC78(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L546:
	leaq	.LC77(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L547:
	leaq	.LC76(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L548:
	leaq	.LC75(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L549:
	leaq	.LC74(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L550:
	leaq	.LC73(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L539:
	leaq	.LC16(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L540:
	leaq	.LC82(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L541:
	leaq	.LC59(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L542:
	leaq	.LC81(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L537:
	leaq	.LC18(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L551:
	leaq	.LC72(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L593:
	leaq	.LC36(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L594:
	leaq	.LC35(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L589:
	leaq	.LC11(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L590:
	leaq	.LC10(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L591:
	leaq	.LC37(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L592:
	leaq	.LC9(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L581:
	leaq	.LC41(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L582:
	leaq	.LC40(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L583:
	leaq	.LC39(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L584:
	leaq	.LC38(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L585:
	leaq	.LC13(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L586:
	leaq	.LC15(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L587:
	leaq	.LC14(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L588:
	leaq	.LC12(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L538:
	leaq	.LC17(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L595:
	leaq	.LC34(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L567:
	leaq	.LC53(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L568:
	leaq	.LC52(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L569:
	leaq	.LC51(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L570:
	leaq	.LC50(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L571:
	leaq	.LC49(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L572:
	leaq	.LC48(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L573:
	leaq	.LC47(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L574:
	leaq	.LC46(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L575:
	leaq	.LC45(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L576:
	leaq	.LC44(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L577:
	leaq	.LC61(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L578:
	leaq	.LC60(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L579:
	leaq	.LC43(%rip), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L580:
	leaq	.LC42(%rip), %rax
	ret
.L534:
	leaq	.LC83(%rip), %rax
	ret
	.cfi_endproc
.LFE59:
	.size	tk_name, .-tk_name
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
