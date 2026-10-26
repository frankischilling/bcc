	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"/proc/self/exe"
.LC1:
	.string	"%s/lib"
	.text
	.p2align 4
	.type	init_libb_path, @function
init_libb_path:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$4095, %edx
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	leaq	.LC0(%rip), %rdi
	subq	$8200, %rsp
	.cfi_def_cfa_offset 8224
	movq	%rsp, %rsi
	call	readlink@PLT
	testq	%rax, %rax
	jg	.L12
	testq	%rbx, %rbx
	je	.L4
	cmpb	$0, (%rbx)
	jne	.L13
.L4:
	movl	$1768697646, g_libb_dir(%rip)
	movw	$98, 4+g_libb_dir(%rip)
.L1:
	addq	$8200, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L12:
	.cfi_restore_state
	movb	$0, (%rsp,%rax)
	movq	%rsp, %rdi
.L10:
	call	dirname@PLT
	leaq	.LC1(%rip), %rdx
	movl	$4096, %esi
	leaq	g_libb_dir(%rip), %rdi
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	snprintf@PLT
	jmp	.L1
.L13:
	leaq	4096(%rsp), %rdi
	movl	$4095, %edx
	movq	%rbx, %rsi
	call	strncpy@PLT
	movb	$0, 8191(%rsp)
	movq	%rax, %rdi
	jmp	.L10
	.cfi_endproc
.LFE17:
	.size	init_libb_path, .-init_libb_path
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"output '%s' would overwrite input '%s'"
	.text
	.p2align 4
	.type	protect_input, @function
protect_input:
.LFB16:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$296, %rsp
	.cfi_def_cfa_offset 336
	movq	%rsp, %rsi
	call	stat@PLT
	testl	%eax, %eax
	jne	.L14
	xorl	%ebx, %ebx
	cmpq	$0, 8(%rbp)
	leaq	144(%rsp), %r12
	jne	.L16
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L18:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L14
.L16:
	movq	0(%rbp), %rax
	movq	%r12, %rsi
	movq	(%rax,%rbx,8), %rdi
	call	stat@PLT
	testl	%eax, %eax
	jne	.L18
	movq	(%rsp), %rax
	cmpq	%rax, 144(%rsp)
	jne	.L18
	movq	8(%rsp), %rax
	cmpq	%rax, 152(%rsp)
	jne	.L18
	movq	0(%rbp), %rax
	movq	%r13, %rsi
	leaq	.LC2(%rip), %rdi
	movq	(%rax,%rbx,8), %rdx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	dief@PLT
	cmpq	8(%rbp), %rbx
	jb	.L16
.L14:
	addq	$296, %rsp
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
	.cfi_endproc
.LFE16:
	.size	protect_input, .-protect_input
	.section	.rodata.str1.1
.LC3:
	.string	"rb"
.LC4:
	.string	"cannot open '%s': %s"
.LC5:
	.string	"fseek failed"
.LC6:
	.string	"ftell failed"
.LC7:
	.string	"out of memory"
.LC8:
	.string	"read failed for '%s'"
	.text
	.p2align 4
	.globl	read_file_all
	.type	read_file_all, @function
read_file_all:
.LFB18:
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
	movq	%rsi, %r13
	leaq	.LC3(%rip), %rsi
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L41
.L24:
	xorl	%esi, %esi
	movl	$2, %edx
	movq	%rbx, %rdi
	call	fseek@PLT
	testl	%eax, %eax
	jne	.L42
	movq	%rbx, %rdi
	call	ftell@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	js	.L43
.L26:
	xorl	%edx, %edx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	fseek@PLT
	testl	%eax, %eax
	jne	.L44
.L27:
	leaq	1(%rbp), %rdi
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L45
.L28:
	movq	%r12, %rdi
	movq	%rbx, %rcx
	movq	%rbp, %rdx
	movl	$1, %esi
	call	fread@PLT
	movq	%rbx, %rdi
	movq	%rax, %r15
	call	fclose@PLT
	cmpq	%r15, %rbp
	je	.L29
	movq	%r14, %rsi
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L29:
	movb	$0, (%r12,%rbp)
	testq	%r13, %r13
	je	.L23
	movq	%rbp, 0(%r13)
.L23:
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
.L44:
	.cfi_restore_state
	leaq	.LC5(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L27
	.p2align 4,,10
	.p2align 3
.L42:
	leaq	.LC5(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	%rbx, %rdi
	call	ftell@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jns	.L26
.L43:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L26
.L41:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%r14, %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L24
.L45:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L28
	.cfi_endproc
.LFE18:
	.size	read_file_all, .-read_file_all
	.section	.rodata.str1.1
.LC9:
	.string	"gcc"
.LC10:
	.string	"-std=c99"
.LC11:
	.string	"-I%s"
.LC12:
	.string	"-O2"
.LC13:
	.string	"-Wall"
.LC14:
	.string	"-Wextra"
.LC15:
	.string	"-Werror"
.LC16:
	.string	"-g"
.LC17:
	.string	"-c"
.LC18:
	.string	"-o"
.LC19:
	.string	"-ldl"
.LC20:
	.string	"-lm"
.LC21:
	.string	"Running:"
.LC22:
	.string	" %s"
	.text
	.p2align 4
	.globl	run_gcc_multi
	.type	run_gcc_multi, @function
run_gcc_multi:
.LFB21:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC10(%rip), %rax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rax, %xmm2
	movl	%edx, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leaq	g_libb_dir(%rip), %r13
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
	subq	$4200, %rsp
	.cfi_def_cfa_offset 4256
	movq	.LC23(%rip), %xmm1
	movl	4272(%rsp), %ebx
	movq	%rsi, 24(%rsp)
	punpcklqdq	%xmm2, %xmm1
	movl	%ecx, 36(%rsp)
	movq	4264(%rsp), %rbp
	testl	%ebx, %ebx
	movl	%r8d, 40(%rsp)
	setne	%bl
	testl	%edx, %edx
	movl	%r9d, 44(%rsp)
	sete	%al
	movaps	%xmm1, (%rsp)
	movq	$0, 56(%rsp)
	andb	%al, %bl
	jne	.L116
.L47:
	leaq	80(%rsp), %r15
	movq	%r13, %rcx
	movl	$4099, %esi
	xorl	%eax, %eax
	leaq	.LC11(%rip), %rdx
	movq	%r15, %rdi
	call	snprintf@PLT
	movq	8(%r12), %rcx
	xorl	%eax, %eax
	testq	%rbp, %rbp
	je	.L48
	movq	8(%rbp), %rax
.L48:
	leaq	40(%rcx,%rax), %rdi
	movq	%rcx, 48(%rsp)
	salq	$3, %rdi
	call	malloc@PLT
	movq	48(%rsp), %rcx
	testq	%rax, %rax
	movq	%rax, %r13
	je	.L117
.L49:
	movdqa	(%rsp), %xmm3
	movups	%xmm3, 0(%r13)
	testl	%r14d, %r14d
	jne	.L76
	leaq	.LC12(%rip), %rax
	movl	$24, %edx
	movl	$3, %edi
	movq	%rax, 16(%r13)
	movl	$4, %eax
.L50:
	movl	40(%rsp), %r11d
	testl	%r11d, %r11d
	je	.L51
	leaq	.LC13(%rip), %rsi
	movslq	%eax, %rdi
	movq	%rsi, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L51:
	movl	44(%rsp), %r10d
	testl	%r10d, %r10d
	je	.L52
	leaq	.LC14(%rip), %rsi
	movslq	%eax, %rdi
	movq	%rsi, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L52:
	movl	4256(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L53
	leaq	.LC15(%rip), %rsi
	movslq	%eax, %rdi
	movq	%rsi, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L53:
	movl	36(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L54
	leaq	.LC16(%rip), %rsi
	movslq	%eax, %rdi
	movq	%rsi, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L54:
	movl	4272(%rsp), %esi
	testl	%esi, %esi
	je	.L55
	movq	%r15, 0(%r13,%rdx)
	movslq	%eax, %rdx
	movslq	%eax, %rdi
	addl	$1, %eax
	salq	$3, %rdx
.L55:
	testl	%r14d, %r14d
	je	.L56
	leaq	.LC17(%rip), %rsi
	movslq	%eax, %rdi
	movq	%rsi, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L56:
	leaq	.LC18(%rip), %rsi
	cltq
	movq	%rsi, 0(%r13,%rdx)
	movq	24(%rsp), %rdx
	leal	2(%rdi), %esi
	movq	%rdx, 0(%r13,%rax,8)
	testq	%rcx, %rcx
	je	.L57
	movq	(%r12), %r9
	leaq	0(%r13,%rdi,8), %rdi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L58:
	movq	(%r9,%rax,8), %rdx
	movq	%rdx, 16(%rdi,%rax,8)
	addq	$1, %rax
	cmpq	%rcx, %rax
	jne	.L58
	addl	%eax, %esi
.L57:
	testb	%bl, %bl
	je	.L59
	movq	56(%rsp), %rbx
	movslq	%esi, %rax
	addl	$1, %esi
	movq	%rbx, 0(%r13,%rax,8)
	testq	%rbp, %rbp
	je	.L61
.L60:
	movq	8(%rbp), %rcx
	testq	%rcx, %rcx
	je	.L62
	movslq	%esi, %rax
	movq	0(%rbp), %r9
	leaq	0(%r13,%rax,8), %rdi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L63:
	movq	(%r9,%rax,8), %rdx
	movq	%rdx, (%rdi,%rax,8)
	addq	$1, %rax
	cmpq	%rcx, %rax
	jne	.L63
	addl	%eax, %esi
.L62:
	testl	%r14d, %r14d
	je	.L61
.L64:
	movl	4296(%rsp), %eax
	movslq	%esi, %rsi
	movq	$0, 0(%r13,%rsi,8)
	testl	%eax, %eax
	jne	.L118
	call	fork@PLT
	movl	%eax, %edi
	testl	%eax, %eax
	js	.L119
.L69:
	je	.L120
	leaq	76(%rsp), %rsi
	xorl	%edx, %edx
	movl	$0, 76(%rsp)
	call	waitpid@PLT
	movq	%r13, %rdi
	testl	%eax, %eax
	js	.L121
	call	free@PLT
	movl	76(%rsp), %eax
	testb	$127, %al
	je	.L122
.L70:
	movl	$1, %eax
.L46:
	addq	$4200, %rsp
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
.L61:
	.cfi_restore_state
	movq	.LC24(%rip), %xmm0
	leaq	.LC20(%rip), %rdx
	movslq	%esi, %rax
	addl	$2, %esi
	movq	%rdx, %xmm4
	punpcklqdq	%xmm4, %xmm0
	movups	%xmm0, 0(%r13,%rax,8)
	jmp	.L64
	.p2align 4,,10
	.p2align 3
.L59:
	testq	%rbp, %rbp
	jne	.L60
	jmp	.L62
	.p2align 4,,10
	.p2align 3
.L76:
	movl	$3, %eax
	movl	$16, %edx
	movl	$2, %edi
	jmp	.L50
	.p2align 4,,10
	.p2align 3
.L122:
	movzbl	%ah, %eax
	jmp	.L46
	.p2align 4,,10
	.p2align 3
.L118:
	movq	stderr(%rip), %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC21(%rip), %rdi
	leaq	8(%r13), %rbx
	leaq	.LC22(%rip), %rbp
	call	fwrite@PLT
	movq	0(%r13), %rdx
	testq	%rdx, %rdx
	je	.L68
	.p2align 4
	.p2align 3
.L67:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rsi
	xorl	%eax, %eax
	addq	$8, %rbx
	call	fprintf@PLT
	movq	-8(%rbx), %rdx
	testq	%rdx, %rdx
	jne	.L67
.L68:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	call	fork@PLT
	movl	%eax, %edi
	testl	%eax, %eax
	jns	.L69
.L119:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L70
	.p2align 4,,10
	.p2align 3
.L116:
	movl	4288(%rsp), %ecx
	movl	4280(%rsp), %edx
	movq	%r13, %rdi
	movl	4296(%rsp), %esi
	call	compile_libb@PLT
	testq	%rax, %rax
	movq	%rax, 56(%rsp)
	setne	%bl
	jmp	.L47
	.p2align 4,,10
	.p2align 3
.L121:
	call	free@PLT
	jmp	.L70
.L117:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	8(%r12), %rcx
	jmp	.L49
.L120:
	leaq	.LC9(%rip), %rdi
	movq	%r13, %rsi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
	.cfi_endproc
.LFE21:
	.size	run_gcc_multi, .-run_gcc_multi
	.section	.rodata.str1.1
.LC25:
	.string	"Reading %s...\n"
.LC27:
	.string	"Lexing...\n"
.LC28:
	.string	"Parsing...\n"
.LC29:
	.string	"Semantic analysis...\n"
.LC30:
	.string	"Code generation...\n"
.LC31:
	.string	"w"
.LC32:
	.string	"mkstemp failed: %s"
.LC33:
	.string	"wb"
.LC34:
	.string	"fdopen failed"
.LC35:
	.string	"%s.c"
.LC36:
	.string	"cannot write '%s'"
.LC37:
	.string	"rename temp failed: %s"
.LC38:
	.string	"cannot reopen '%s': %s"
.LC39:
	.string	"r"
.LC40:
	.string	"cannot read '%s'"
	.text
	.p2align 4
	.globl	compile_b_to_c
	.type	compile_b_to_c, @function
compile_b_to_c:
.LFB22:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%edx, %r15d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%r8d, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%r9d, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$248, %rsp
	.cfi_def_cfa_offset 304
	movl	%esi, 8(%rsp)
	testl	%ecx, %ecx
	jne	.L185
	leaq	88(%rsp), %rsi
	leaq	112(%rsp), %r12
	movq	$0, 88(%rsp)
	call	read_file_all
	movl	$13, %ecx
	xorl	%esi, %esi
	movq	%rbx, %r8
	leaq	128(%rsp), %rdx
	movq	%rax, %r13
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	movq	%r13, 112(%rsp)
	rep stosq
	movl	328(%rsp), %eax
	leaq	16(%rsp), %rdi
	movl	$1, %ecx
	movq	%rbx, 144(%rsp)
	movl	%eax, 216(%rsp)
	movq	88(%rsp), %rax
	movq	%r13, 208(%rsp)
	movq	%rax, 120(%rsp)
	movq	.LC26(%rip), %rax
	movq	%rax, 136(%rsp)
	call	mk_tok@PLT
	movdqu	16(%rsp), %xmm0
	movq	64(%rsp), %rax
	movq	%r12, %rdi
	movups	%xmm0, 152(%rsp)
	movdqu	32(%rsp), %xmm0
	movq	%rax, 200(%rsp)
	movups	%xmm0, 168(%rsp)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 184(%rsp)
	call	next@PLT
	testl	%r14d, %r14d
	jne	.L152
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	152(%rsp), %rdi
	movq	%rax, %r14
	call	tok_free@PLT
	testl	%ebp, %ebp
	jne	.L186
.L130:
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	sem_check_program@PLT
.L132:
	movl	312(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L133
	cmpq	$0, 320(%rsp)
	je	.L133
	movq	320(%rsp), %rdi
	call	strdup@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L187
.L134:
	leaq	.LC31(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L188
.L136:
	subq	$8, %rsp
	.cfi_def_cfa_offset 312
	movq	%rbx, %rdx
	movq	%r14, %rsi
	movl	%r15d, %r8d
	movl	344(%rsp), %eax
	movq	%r12, %rdi
	pushq	%rax
	.cfi_def_cfa_offset 320
	movl	344(%rsp), %r9d
	movl	24(%rsp), %ecx
	call	emit_program_c_ext@PLT
	movq	%r12, %rdi
	call	ferror@PLT
	movq	%r12, %rdi
	movl	%eax, %ebx
	call	fclose@PLT
	popq	%rsi
	.cfi_def_cfa_offset 312
	popq	%rdi
	.cfi_def_cfa_offset 304
	cmpl	$-1, %eax
	je	.L155
	testl	%ebx, %ebx
	jne	.L155
	movl	304(%rsp), %ecx
	testl	%ecx, %ecx
	jne	.L189
.L146:
	movq	%r13, %rdi
	call	free@PLT
.L123:
	addq	$248, %rsp
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
.L133:
	.cfi_restore_state
	movdqa	.LC41(%rip), %xmm0
	leaq	96(%rsp), %r12
	movq	%r12, %rdi
	movaps	%xmm0, 96(%rsp)
	call	mkstemp@PLT
	movl	%eax, %ebp
	testl	%eax, %eax
	js	.L190
.L137:
	leaq	.LC33(%rip), %rsi
	movl	%ebp, %edi
	call	fdopen@PLT
	movq	%rax, (%rsp)
	testq	%rax, %rax
	je	.L191
.L138:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L192
.L139:
	movq	%r12, %rdx
	leaq	.LC35(%rip), %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	(%rsp), %rdi
	call	ferror@PLT
	movq	(%rsp), %rdi
	movl	%eax, 12(%rsp)
	call	fclose@PLT
	movl	12(%rsp), %edx
	testl	%edx, %edx
	jne	.L154
	cmpl	$-1, %eax
	je	.L154
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	rename@PLT
	testl	%eax, %eax
	jne	.L193
.L142:
	leaq	.LC31(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	jne	.L136
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rsi
	leaq	.LC38(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L136
	.p2align 4,,10
	.p2align 3
.L186:
	movq	%r14, %rdi
	call	dump_ast_program@PLT
	movl	304(%rsp), %edx
	testl	%edx, %edx
	jne	.L130
.L151:
	movq	%r13, %rdi
	xorl	%ebp, %ebp
	call	free@PLT
	jmp	.L123
	.p2align 4,,10
	.p2align 3
.L154:
	movq	%r12, %rsi
	leaq	.LC36(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	rename@PLT
	testl	%eax, %eax
	je	.L142
.L193:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC37(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L142
	.p2align 4,,10
	.p2align 3
.L155:
	movq	%rbp, %rsi
	leaq	.LC36(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movl	304(%rsp), %ecx
	testl	%ecx, %ecx
	je	.L146
.L189:
	leaq	.LC39(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	jne	.L148
	jmp	.L194
	.p2align 4,,10
	.p2align 3
.L149:
	movq	stdout(%rip), %rsi
	call	putc@PLT
.L148:
	movq	%rbx, %rdi
	call	fgetc@PLT
	movl	%eax, %edi
	cmpl	$-1, %eax
	jne	.L149
	movq	%rbx, %rdi
	call	ferror@PLT
	testl	%eax, %eax
	jne	.L195
.L150:
	movq	%rbx, %rdi
	call	fclose@PLT
	jmp	.L146
	.p2align 4,,10
	.p2align 3
.L185:
	movq	%rdi, %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC25(%rip), %rsi
	leaq	112(%rsp), %r12
	call	fprintf@PLT
	leaq	88(%rsp), %rsi
	movq	%rbx, %rdi
	movq	$0, 88(%rsp)
	call	read_file_all
	movl	$13, %ecx
	xorl	%esi, %esi
	movq	%rbx, %r8
	leaq	128(%rsp), %rdx
	movq	%rax, %r13
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	movq	%r13, 112(%rsp)
	rep stosq
	movl	328(%rsp), %eax
	movl	$1, %ecx
	leaq	16(%rsp), %rdi
	movq	%rbx, 144(%rsp)
	movl	%eax, 216(%rsp)
	movq	88(%rsp), %rax
	movq	%r13, 208(%rsp)
	movq	%rax, 120(%rsp)
	movq	.LC26(%rip), %rax
	movq	%rax, 136(%rsp)
	call	mk_tok@PLT
	movdqu	16(%rsp), %xmm0
	movq	64(%rsp), %rax
	movq	%r12, %rdi
	movups	%xmm0, 152(%rsp)
	movdqu	32(%rsp), %xmm0
	movq	%rax, 200(%rsp)
	movups	%xmm0, 168(%rsp)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 184(%rsp)
	call	next@PLT
	movl	$10, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC27(%rip), %rdi
	call	fwrite@PLT
	testl	%r14d, %r14d
	jne	.L152
	movq	stderr(%rip), %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	152(%rsp), %rdi
	movq	%rax, %r14
	call	tok_free@PLT
	testl	%ebp, %ebp
	jne	.L196
.L128:
	movq	stderr(%rip), %rcx
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC29(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	sem_check_program@PLT
	movl	$19, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC30(%rip), %rdi
	call	fwrite@PLT
	jmp	.L132
	.p2align 4,,10
	.p2align 3
.L195:
	movq	%rbp, %rsi
	leaq	.LC40(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L150
	.p2align 4,,10
	.p2align 3
.L190:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC32(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L196:
	movq	%r14, %rdi
	call	dump_ast_program@PLT
	movl	304(%rsp), %eax
	testl	%eax, %eax
	jne	.L128
	jmp	.L151
	.p2align 4,,10
	.p2align 3
.L152:
	movq	%r12, %rdi
	xorl	%ebp, %ebp
	call	dump_token_stream@PLT
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L123
.L187:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L134
.L191:
	leaq	.LC34(%rip), %rdi
	call	dief@PLT
	jmp	.L138
.L192:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L139
.L188:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L136
.L194:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L148
	.cfi_endproc
.LFE22:
	.size	compile_b_to_c, .-compile_b_to_c
	.section	.rodata.str1.1
.LC42:
	.string	"a.out"
.LC43:
	.string	"--asm"
.LC44:
	.string	"--keep-c"
.LC45:
	.string	"--emit-c"
.LC46:
	.string	"-Wno-all"
.LC47:
	.string	"-Wno-extra"
.LC48:
	.string	"--byteptr"
.LC49:
	.string	"--wordptr"
.LC50:
	.string	"--word="
.LC51:
	.string	"16"
.LC52:
	.string	"32"
.LC53:
	.string	"host"
	.section	.rodata.str1.8
	.align 8
.LC54:
	.string	"--word must be 16, 32, or host"
	.section	.rodata.str1.1
.LC55:
	.string	"--strict"
.LC56:
	.string	"--pedantic"
.LC57:
	.string	"--dump-tokens"
.LC58:
	.string	"--dump-ast"
.LC59:
	.string	"--dump-c"
.LC60:
	.string	"--no-line"
.LC61:
	.string	"--verbose-errors"
.LC62:
	.string	"-v"
.LC63:
	.string	"--inline-runtime"
.LC64:
	.string	"missing value after -o"
.LC65:
	.string	"-l"
.LC66:
	.string	"missing value after -l"
.LC67:
	.string	"ncurses"
.LC68:
	.string	"ncursesw"
.LC69:
	.string	"curses"
.LC70:
	.string	"panel"
.LC71:
	.string	"panelw"
.LC72:
	.string	"-l%s"
.LC73:
	.string	"-X"
.LC74:
	.string	"missing value after -X"
.LC75:
	.string	"unknown option: %s"
.LC76:
	.string	"usage:\n"
	.section	.rodata.str1.8
	.align 8
.LC77:
	.string	"  %s [options] input.b ... [-o out]\n"
	.section	.rodata.str1.1
.LC78:
	.string	"Multi-file compilation:\n"
	.section	.rodata.str1.8
	.align 8
.LC79:
	.string	"  %s a.b b.b c.b -o prog    compile and link multiple .b files\n"
	.section	.rodata.str1.1
.LC80:
	.string	"options:\n"
	.section	.rodata.str1.8
	.align 8
.LC81:
	.string	"  -S          emit C code to stdout (single file only)\n"
	.align 8
.LC82:
	.string	"  --asm       emit assembly code to stdout (single file only)\n"
	.align 8
.LC83:
	.string	"  -c          compile to object file(s), don't link\n"
	.align 8
.LC84:
	.string	"  -E          emit C code to file (single file only)\n"
	.align 8
.LC85:
	.string	"  --keep-c    keep generated C files\n"
	.align 8
.LC86:
	.string	"  --emit-c    use a.b -> a.b.c naming for C files (implies --keep-c)\n"
	.align 8
.LC87:
	.string	"  -g          include debug information\n"
	.align 8
.LC88:
	.string	"  -l LIB      pass library to linker (can be repeated)\n"
	.align 8
.LC89:
	.string	"  -X FLAG     pass FLAG directly to gcc (can be repeated)\n"
	.align 8
.LC90:
	.string	"  -Wall       enable all warnings (default)\n"
	.align 8
.LC91:
	.string	"  -Wno-all    disable all warnings\n"
	.align 8
.LC92:
	.string	"  -Wextra     enable extra warnings (default)\n"
	.align 8
.LC93:
	.string	"  -Wno-extra  disable extra warnings\n"
	.align 8
.LC94:
	.string	"  -Werror     treat warnings as errors\n"
	.align 8
.LC95:
	.string	"  --byteptr   use byte-addressed pointers\n"
	.align 8
.LC96:
	.string	"  --wordptr   use word-addressed pointers (strict/16-bit default)\n"
	.align 8
.LC97:
	.string	"  --word=N    word size: 16, 32, or host (default: host)\n"
	.align 8
.LC98:
	.string	"              16-bit mode uses translated B addresses and packed words\n"
	.align 8
.LC99:
	.string	"  -v          verbose compilation output\n"
	.align 8
.LC100:
	.string	"  --inline-runtime  embed runtime in each C file (old behavior)\n"
	.section	.rodata.str1.1
.LC101:
	.string	"Strictness:\n"
	.section	.rodata.str1.8
	.align 8
.LC102:
	.string	"  --strict        select the Thompson PDP-11 B72 dialect checks\n"
	.align 8
.LC103:
	.string	"  --pedantic      error on any non-standard syntax (use with --strict)\n"
	.align 8
.LC104:
	.string	"Extensions disabled by --strict:\n"
	.align 8
.LC105:
	.string	"  - Hex literals (0x...)       use octal instead\n"
	.align 8
.LC106:
	.string	"  - Line comments (//)         use /* */ instead\n"
	.align 8
.LC107:
	.string	"  - Backslash escapes (\\n)     use *n instead\n"
	.align 8
.LC108:
	.string	"  - C-style compound (+=)      use =+ instead\n"
	.align 8
.LC109:
	.string	"  - Bracketed auto vectors      use auto v 3; instead\n"
	.align 8
.LC110:
	.string	"  - break/continue/default      ordinary identifiers in B72\n"
	.align 8
.LC111:
	.string	"  - Logical OR (||)            use | or ?: instead\n"
	.align 8
.LC112:
	.string	"  - Long char constants        use one or two chars\n"
	.align 8
.LC113:
	.string	"  --dump-tokens  show tokenized input\n"
	.align 8
.LC114:
	.string	"  --dump-ast     show parsed AST\n"
	.align 8
.LC115:
	.string	"  --dump-c       emit generated C even when compiling\n"
	.align 8
.LC116:
	.string	"  --no-line      disable #line directives\n"
	.align 8
.LC117:
	.string	"  --verbose-errors use verbose error messages instead of 2-letter codes\n"
	.align 8
.LC118:
	.string	"-c with -o requires exactly one input"
	.align 8
.LC119:
	.string	"inputs produce the same object path '%s'; compile them separately with -o"
	.align 8
.LC120:
	.string	"--asm only works with a single input file"
	.section	.rodata.str1.1
.LC121:
	.string	"-S"
.LC122:
	.string	"-"
.LC123:
	.string	"Generated C: %s\n"
	.section	.rodata.str1.8
	.align 8
.LC124:
	.string	"-S and --asm only work with a single input file"
	.align 8
.LC125:
	.string	"-E only works with a single input file"
	.section	.rodata.str1.1
.LC126:
	.string	"Compiled %s -> %s\n"
.LC127:
	.string	"Linking %zu file(s)...\n"
.LC129:
	.string	"gcc failed (exit %d)\n"
.LC130:
	.string	"Generated C files:\n"
.LC131:
	.string	"  %s\n"
.LC132:
	.string	"Kept: %s\n"
	.section	.rodata.str1.8
	.align 8
.LC133:
	.string	"duplicate external function '%s'"
	.align 8
.LC134:
	.string	"conflicting external definition '%s'"
	.align 8
.LC135:
	.string	"duplicate external variable '%s'"
	.text
	.p2align 4
	.type	run_main, @function
run_main:
.LFB23:
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
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$472, %rsp
	.cfi_def_cfa_offset 528
	movq	(%rsi), %rdi
	call	init_libb_path
	leaq	g_libb_dir(%rip), %rax
	movq	%rax, g_libb_path(%rip)
	call	arena_new@PLT
	pxor	%xmm0, %xmm0
	movq	$0, 224(%rsp)
	movq	%rax, g_compilation_arena(%rip)
	movq	$0, 256(%rsp)
	movq	$0, 16+g_known_functions(%rip)
	movq	$0, 16+g_known_variables(%rip)
	movaps	%xmm0, 208(%rsp)
	movaps	%xmm0, 240(%rsp)
	movups	%xmm0, g_known_functions(%rip)
	movups	%xmm0, g_known_variables(%rip)
	cmpl	$1, %ebp
	jle	.L296
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	movq	$0, 40(%rsp)
	movl	$1, %r14d
	movl	$1, 52(%rsp)
	movl	$0, 32(%rsp)
	movl	$0, 88(%rsp)
	movl	$0, 68(%rsp)
	movl	$0, 64(%rsp)
	movl	$0, 56(%rsp)
	movl	$1, 36(%rsp)
	movl	$0, 96(%rsp)
	movl	$1, 84(%rsp)
	movl	$1, 80(%rsp)
	movl	$0, 76(%rsp)
	movl	$0, 100(%rsp)
	movl	$0, 92(%rsp)
	movl	$0, 72(%rsp)
	movl	$0, 60(%rsp)
	movl	$0, 48(%rsp)
	movl	$0, 8(%rsp)
	movl	%ecx, 16(%rsp)
	movl	%edx, 24(%rsp)
	jmp	.L220
	.p2align 4,,10
	.p2align 3
.L419:
	cmpb	$83, 1(%r15)
	jne	.L327
	cmpb	$0, 2(%r15)
	jne	.L327
	movl	$1, 8(%rsp)
.L200:
	addl	$1, %r14d
	cmpl	%r14d, %ebp
	jle	.L418
.L220:
	movslq	%r14d, %rax
	movq	(%rbx,%rax,8), %r15
	leaq	0(,%rax,8), %r12
	movzbl	(%r15), %r13d
	cmpl	$45, %r13d
	je	.L419
.L327:
	leaq	.LC43(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L298
	cmpl	$45, %r13d
	je	.L420
.L329:
	leaq	.LC44(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L421
.L417:
	movl	$1, 92(%rsp)
	jmp	.L200
	.p2align 4,,10
	.p2align 3
.L298:
	addl	$1, %r14d
	movl	$1, 48(%rsp)
	cmpl	%r14d, %ebp
	jg	.L220
.L418:
	movl	16(%rsp), %ecx
	movl	24(%rsp), %edx
	testl	%ecx, %ecx
	je	.L198
.L221:
	movq	248(%rsp), %rax
	movl	%edx, g_verbose_errors(%rip)
	movl	$1, g_no_line(%rip)
	testq	%rax, %rax
	je	.L422
	movl	60(%rsp), %r15d
	pxor	%xmm0, %xmm0
	movq	$0, 288(%rsp)
	movaps	%xmm0, 272(%rsp)
	testl	%r15d, %r15d
	jne	.L224
	cmpq	$0, 40(%rsp)
	je	.L423
.L226:
	movq	40(%rsp), %rdi
	leaq	240(%rsp), %rsi
	call	protect_input
.L239:
	movq	248(%rsp), %rdx
	cmpq	$1, %rdx
	jbe	.L240
	cmpl	$0, 56(%rsp)
	je	.L424
.L240:
	movl	48(%rsp), %r11d
	testl	%r11d, %r11d
	jne	.L425
	cmpl	$0, 8(%rsp)
	jne	.L426
.L263:
	cmpl	$0, 72(%rsp)
	je	.L266
	cmpq	$1, %rdx
	jbe	.L267
	leaq	.LC125(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L267:
	movq	240(%rsp), %rax
	xorl	%esi, %esi
	leaq	144(%rsp), %r13
	leaq	336(%rsp), %rbx
	movq	(%rax), %r12
	movq	%rsi, 304(%rsp)
	leaq	304(%rsp), %rsi
	movq	%r12, %rdi
	call	read_file_all
	movl	$26, %ecx
	movq	%r12, %r8
	xorl	%esi, %esi
	leaq	352(%rsp), %rdx
	movq	%rax, %rbp
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	rep stosl
	movl	32(%rsp), %eax
	movq	%r13, %rdi
	movl	$1, %ecx
	movq	%rbp, 336(%rsp)
	movl	%eax, 440(%rsp)
	movq	304(%rsp), %rax
	movq	%r12, 368(%rsp)
	movq	%rax, 344(%rsp)
	movq	.LC26(%rip), %rax
	movq	%rbp, 432(%rsp)
	movq	%rax, 360(%rsp)
	call	mk_tok@PLT
	movq	%r13, %rsi
	movl	$14, %ecx
	leaq	376(%rsp), %rdi
	rep movsl
	movq	%rbx, %rdi
	call	next@PLT
	movq	%rbx, %rdi
	call	parse_program_ast@PLT
	leaq	376(%rsp), %rdi
	movq	%rax, %r13
	call	tok_free@PLT
	movq	%r12, %rsi
	movq	%r13, %rdi
	call	sem_check_program@PLT
	movq	40(%rsp), %rdi
	leaq	.LC31(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L427
.L268:
	movl	32(%rsp), %r9d
	movl	36(%rsp), %ecx
	movq	%r12, %rdx
	movq	%r13, %rsi
	movl	$1, %r8d
	movq	%rbx, %rdi
	call	emit_program_c@PLT
	movq	%rbx, %rdi
	call	ferror@PLT
	movq	%rbx, %rdi
	movl	%eax, %r12d
	call	fclose@PLT
	addl	$1, %eax
	je	.L326
	testl	%r12d, %r12d
	jne	.L326
.L269:
	movq	%rbp, %rdi
	call	free@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%ecx, %ecx
	movq	%rcx, g_compilation_arena(%rip)
.L265:
	xorl	%ebp, %ebp
.L197:
	addq	$472, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebp, %eax
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
.L420:
	.cfi_restore_state
	cmpb	$99, 1(%r15)
	je	.L428
.L328:
	cmpl	$45, %r13d
	jne	.L329
	cmpb	$69, 1(%r15)
	jne	.L329
	cmpb	$0, 2(%r15)
	jne	.L329
	movl	$1, 72(%rsp)
	jmp	.L200
.L296:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movl	$1, 52(%rsp)
	xorl	%edx, %edx
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	movl	%eax, 32(%rsp)
	movl	%eax, 88(%rsp)
	xorl	%eax, %eax
	movl	%eax, 68(%rsp)
	movl	%eax, 64(%rsp)
	movl	%eax, 56(%rsp)
	xorl	%eax, %eax
	movl	$1, 36(%rsp)
	movl	%eax, 96(%rsp)
	movl	$1, 84(%rsp)
	movl	$1, 80(%rsp)
	movl	%ecx, 76(%rsp)
	movl	%ecx, 100(%rsp)
	movl	%ecx, 92(%rsp)
	movl	%ecx, 72(%rsp)
	movl	%ecx, 60(%rsp)
	movl	%ecx, 48(%rsp)
	movl	%ecx, 8(%rsp)
.L198:
	cmpl	$0, g_strict(%rip)
	setne	%al
	cmpl	$16, 32(%rsp)
	sete	%cl
	orl	%ecx, %eax
	xorl	$1, %eax
	andl	%eax, 36(%rsp)
	jmp	.L221
.L428:
	cmpb	$0, 2(%r15)
	jne	.L328
	movl	$1, 60(%rsp)
	jmp	.L200
.L224:
	cmpq	$0, 40(%rsp)
	je	.L227
	subq	$1, %rax
	je	.L227
	xorl	%eax, %eax
	leaq	.LC118(%rip), %rdi
	call	dief@PLT
	cmpq	$0, 248(%rsp)
	je	.L228
.L227:
	leaq	272(%rsp), %rax
	leaq	240(%rsp), %r15
	xorl	%r12d, %r12d
	movq	%rax, 16(%rsp)
	leaq	.LC119(%rip), %r13
	movq	%r15, 24(%rsp)
	movq	40(%rsp), %r15
	.p2align 4
	.p2align 3
.L235:
	testq	%r15, %r15
	je	.L229
	movq	%r15, %rdi
	call	sdup@PLT
	movq	%rax, %rbx
.L230:
	xorl	%ebp, %ebp
	cmpq	$0, 280(%rsp)
	jne	.L234
	jmp	.L238
	.p2align 4,,10
	.p2align 3
.L237:
	addq	$1, %rbp
	cmpq	280(%rsp), %rbp
	jnb	.L238
.L234:
	movq	272(%rsp), %rax
	movq	%rbx, %rdi
	movq	(%rax,%rbp,8), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L237
	movq	%rbx, %rsi
	movq	%r13, %rdi
	addq	$1, %rbp
	call	dief@PLT
	cmpq	280(%rsp), %rbp
	jb	.L234
.L238:
	movq	24(%rsp), %rsi
	movq	%rbx, %rdi
	addq	$1, %r12
	call	protect_input
	movq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	vec_push@PLT
	cmpq	248(%rsp), %r12
	jb	.L235
	cmpq	$0, 40(%rsp)
	jne	.L239
	leaq	.LC42(%rip), %rax
	movq	%rax, 40(%rsp)
	jmp	.L239
.L421:
	leaq	.LC45(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L302
	leaq	.LC16(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L303
	leaq	.LC13(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L304
	leaq	.LC46(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L305
	leaq	.LC14(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L306
	leaq	.LC47(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L307
	leaq	.LC15(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L308
	leaq	.LC48(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L309
	leaq	.LC49(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L310
	movl	$7, %edx
	leaq	.LC50(%rip), %rsi
	movq	%r15, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L203
	addq	$7, %r15
	leaq	.LC51(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L311
	leaq	.LC52(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L312
	leaq	.LC53(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L429
	xorl	%edi, %edi
	movl	%edi, 32(%rsp)
	jmp	.L200
	.p2align 4,,10
	.p2align 3
.L229:
	movq	240(%rsp), %rax
	movl	$47, %esi
	movq	(%rax,%r12,8), %r14
	movq	%r14, %rdi
	call	strrchr@PLT
	movl	$46, %esi
	leaq	1(%rax), %rdx
	testq	%rax, %rax
	cmovne	%rdx, %r14
	movq	%r14, %rdi
	call	strrchr@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L232
	cmpq	%rax, %r14
	je	.L232
	subq	%r14, %rbp
.L233:
	leaq	3(%rbp), %rdi
	call	xmalloc@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movl	$28462, %r14d
	movq	%rax, %rbx
	movq	%rax, %rdi
	call	memcpy@PLT
	addq	%rbx, %rbp
	movw	%r14w, 0(%rbp)
	movb	$0, 2(%rbp)
	jmp	.L230
.L232:
	movq	%r14, %rdi
	call	strlen@PLT
	movq	%rax, %rbp
	jmp	.L233
.L424:
	movl	64(%rsp), %eax
	xorl	$1, %eax
	orl	68(%rsp), %eax
	je	.L241
	leaq	336(%rsp), %rax
	leaq	304(%rsp), %r14
	xorl	%r13d, %r13d
	movq	%rax, 112(%rsp)
	leaq	352(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	376(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	%r14, 136(%rsp)
	.p2align 4
	.p2align 3
.L243:
	movq	240(%rsp), %rax
	movq	136(%rsp), %rsi
	xorl	%r14d, %r14d
	movq	(%rax,%r13,8), %rbx
	movq	$0, 304(%rsp)
	movq	%rbx, %rdi
	call	read_file_all
	movq	120(%rsp), %rdi
	movq	%rbx, %r8
	xorl	%esi, %esi
	movq	%rax, %rbp
	movl	$13, %ecx
	xorl	%eax, %eax
	movl	$1, %edx
	rep stosq
	movl	32(%rsp), %eax
	movq	104(%rsp), %rdi
	movl	$1, %ecx
	movq	%rbx, 368(%rsp)
	movl	%eax, 440(%rsp)
	movq	304(%rsp), %rax
	movq	%rbp, 336(%rsp)
	movq	%rax, 344(%rsp)
	movq	.LC26(%rip), %rax
	movq	%rbp, 432(%rsp)
	movq	%rax, 360(%rsp)
	call	mk_tok@PLT
	movq	112(%rsp), %rbx
	movdqu	144(%rsp), %xmm0
	movq	192(%rsp), %rax
	movups	%xmm0, 376(%rsp)
	movq	%rbx, %rdi
	movdqu	160(%rsp), %xmm0
	movq	%rax, 424(%rsp)
	movups	%xmm0, 392(%rsp)
	movdqu	176(%rsp), %xmm0
	movups	%xmm0, 408(%rsp)
	call	next@PLT
	movq	%rbx, %rdi
	call	parse_program_ast@PLT
	movq	128(%rsp), %rdi
	movq	%rax, %r15
	call	tok_free@PLT
	cmpq	$0, 8(%r15)
	je	.L258
	movq	%rbp, 24(%rsp)
	movq	%r15, %rbp
	movq	%r14, %r15
	movq	%r13, 16(%rsp)
	jmp	.L242
	.p2align 4,,10
	.p2align 3
.L244:
	cmpl	$2, %eax
	je	.L430
.L251:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L431
.L242:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rcx
	movl	(%rcx), %eax
	cmpl	$1, %eax
	jne	.L244
	movq	8(%rcx), %rax
	movq	8+g_known_variables(%rip), %r13
	movq	(%rax), %r14
	leaq	g_known_variables(%rip), %rax
	movq	(%rax), %r12
	testq	%r13, %r13
	je	.L245
	xorl	%ebx, %ebx
	jmp	.L247
	.p2align 4,,10
	.p2align 3
.L432:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L245
.L247:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L432
	movq	%r14, %rsi
	leaq	.LC134(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L245:
	movq	8+g_known_functions(%rip), %r13
	movq	g_known_functions(%rip), %r12
	testq	%r13, %r13
	je	.L248
	xorl	%ebx, %ebx
	jmp	.L250
	.p2align 4,,10
	.p2align 3
.L433:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L248
.L250:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L433
	movq	%r14, %rsi
	leaq	.LC133(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L248:
	movq	%r14, %rdi
	addq	$1, %r15
	call	sdup@PLT
	leaq	g_known_functions(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpq	8(%rbp), %r15
	jb	.L242
.L431:
	movq	16(%rsp), %r13
	movq	24(%rsp), %rbp
.L258:
	movq	%rbp, %rdi
	addq	$1, %r13
	call	free@PLT
	movq	248(%rsp), %rdx
	cmpq	%rdx, %r13
	jb	.L243
	jmp	.L240
.L425:
	subq	$1, %rdx
	jne	.L294
.L260:
	pushq	%r10
	.cfi_def_cfa_offset 536
	xorl	%r9d, %r9d
	xorl	%r8d, %r8d
	movl	$1, %edx
	pushq	$0
	.cfi_def_cfa_offset 544
	movl	48(%rsp), %r15d
	pushq	%r15
	.cfi_def_cfa_offset 552
	pushq	$0
	.cfi_def_cfa_offset 560
	pushq	$0
	.cfi_def_cfa_offset 568
	pushq	$0
	.cfi_def_cfa_offset 576
	movq	288(%rsp), %rax
	movl	136(%rsp), %r14d
	movl	84(%rsp), %r13d
	movq	(%rax), %rdi
	movl	%r14d, %ecx
	movl	%r13d, %esi
	call	compile_b_to_c
	leaq	384(%rsp), %rdi
	movl	$6, %ecx
	addq	$48, %rsp
	.cfi_def_cfa_offset 528
	movq	%rax, %rbx
	xorl	%eax, %eax
	leaq	336(%rsp), %rbp
	rep stosl
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	leaq	208(%rsp), %r12
	call	vec_push@PLT
	leaq	.LC121(%rip), %rdi
	call	sdup@PLT
	movq	%r12, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	pushq	%r14
	.cfi_def_cfa_offset 536
	xorl	%edx, %edx
	movq	%rbp, %rdi
	pushq	%r15
	.cfi_def_cfa_offset 544
	leaq	.LC122(%rip), %rsi
	pushq	%r13
	.cfi_def_cfa_offset 552
	pushq	$0
	.cfi_def_cfa_offset 560
	pushq	%r12
	.cfi_def_cfa_offset 568
	movl	136(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 576
	movl	132(%rsp), %r9d
	movl	128(%rsp), %r8d
	movl	124(%rsp), %ecx
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 528
	movl	%eax, %ebp
	movl	92(%rsp), %eax
	orl	%ebp, %eax
	jne	.L434
	movq	%rbx, %rdi
	call	unlink@PLT
.L262:
	movq	%rbx, %rdi
	call	free@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%r9d, %r9d
	movq	%r9, g_compilation_arena(%rip)
	jmp	.L197
.L266:
	movl	72(%rsp), %eax
	leaq	304(%rsp), %r14
	movl	$6, %ecx
	xorl	%ebx, %ebx
	movq	%r14, %rdi
	leaq	240(%rsp), %r13
	rep stosl
	testq	%rdx, %rdx
	je	.L278
	movq	%r13, 16(%rsp)
	movl	100(%rsp), %r15d
	movq	%r14, 8(%rsp)
	movl	88(%rsp), %r13d
	jmp	.L271
	.p2align 4,,10
	.p2align 3
.L274:
	subq	$8, %rsp
	.cfi_def_cfa_offset 536
	movl	%r13d, %ecx
	movl	$1, %edx
	movq	%r12, %rdi
	movl	60(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 544
	movl	48(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 552
	pushq	$0
	.cfi_def_cfa_offset 560
	pushq	$0
	.cfi_def_cfa_offset 568
	movl	108(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 576
	movl	112(%rsp), %r9d
	movl	104(%rsp), %r8d
	movl	84(%rsp), %esi
	call	compile_b_to_c
	addq	$48, %rsp
	.cfi_def_cfa_offset 528
	movq	%rax, %r14
.L293:
	testq	%r14, %r14
	je	.L292
	movq	8(%rsp), %rdi
	movq	%r14, %rsi
	call	vec_push@PLT
	testl	%r13d, %r13d
	jne	.L435
.L277:
	addq	$1, %rbx
	cmpq	248(%rsp), %rbx
	jnb	.L436
.L271:
	movq	240(%rsp), %rax
	movq	(%rax,%rbx,8), %r12
	testl	%r15d, %r15d
	je	.L274
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L437
.L275:
	movq	%r12, %rdx
	movq	%rbp, %rdi
	leaq	.LC35(%rip), %rsi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	16(%rsp), %rsi
	movq	%rbp, %rdi
	call	protect_input
	subq	$8, %rsp
	.cfi_def_cfa_offset 536
	movq	%r12, %rdi
	movl	%r13d, %ecx
	movl	60(%rsp), %eax
	movl	$1, %edx
	pushq	%rax
	.cfi_def_cfa_offset 544
	movl	48(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 552
	pushq	%rbp
	.cfi_def_cfa_offset 560
	pushq	$1
	.cfi_def_cfa_offset 568
	movl	108(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 576
	movl	112(%rsp), %r9d
	movl	104(%rsp), %r8d
	movl	84(%rsp), %esi
	call	compile_b_to_c
	addq	$48, %rsp
	.cfi_def_cfa_offset 528
	movq	%rbp, %rdi
	movq	%rax, %r14
	call	free@PLT
	jmp	.L293
.L434:
	movq	stderr(%rip), %rdi
	movq	%rbx, %rdx
	leaq	.LC123(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L262
.L241:
	cmpl	$0, 48(%rsp)
	jne	.L294
	cmpl	$0, 8(%rsp)
	je	.L263
.L295:
	leaq	.LC124(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L264:
	movq	240(%rsp), %rax
	xorl	%edi, %edi
	leaq	304(%rsp), %rsi
	leaq	144(%rsp), %r13
	leaq	336(%rsp), %r12
	movq	(%rax), %rbp
	movq	%rdi, 304(%rsp)
	movq	%rbp, %rdi
	call	read_file_all
	movl	$26, %ecx
	movq	%rbp, %r8
	xorl	%esi, %esi
	leaq	352(%rsp), %rdx
	movq	%rax, %rbx
	xorl	%eax, %eax
	movl	32(%rsp), %r15d
	movq	%rdx, %rdi
	movl	$1, %edx
	rep stosl
	movq	304(%rsp), %rax
	movl	$1, %ecx
	movq	%r13, %rdi
	movl	%r15d, 440(%rsp)
	movq	%rax, 344(%rsp)
	movq	.LC26(%rip), %rax
	movq	%rbx, 336(%rsp)
	movq	%rax, 360(%rsp)
	movq	%rbp, 368(%rsp)
	movq	%rbx, 432(%rsp)
	call	mk_tok@PLT
	leaq	376(%rsp), %rdi
	movl	$14, %ecx
	movq	%r13, %rsi
	rep movsl
	movq	%r12, %rdi
	call	next@PLT
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	376(%rsp), %rdi
	movq	%rax, %r12
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	sem_check_program@PLT
	movl	36(%rsp), %ecx
	movl	%r15d, %r9d
	movq	%rbp, %rdx
	movq	stdout(%rip), %rdi
	movl	$1, %r8d
	movq	%r12, %rsi
	call	emit_program_c@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%r8d, %r8d
	movq	%r8, g_compilation_arena(%rip)
	jmp	.L265
.L302:
	movl	$1, 100(%rsp)
	jmp	.L417
.L294:
	leaq	.LC120(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L260
	.p2align 4,,10
	.p2align 3
.L430:
	movq	8(%rcx), %rax
	movq	8+g_known_functions(%rip), %r13
	movq	g_known_functions(%rip), %r12
	movq	16(%rax), %r14
	testq	%r13, %r13
	je	.L252
	xorl	%ebx, %ebx
	jmp	.L254
	.p2align 4,,10
	.p2align 3
.L438:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L252
.L254:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L438
	movq	%r14, %rsi
	leaq	.LC134(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L252:
	movq	8+g_known_variables(%rip), %r13
	leaq	g_known_variables(%rip), %rax
	movq	(%rax), %r12
	testq	%r13, %r13
	je	.L255
	xorl	%ebx, %ebx
	jmp	.L257
	.p2align 4,,10
	.p2align 3
.L439:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L255
.L257:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L439
	movq	%r14, %rsi
	leaq	.LC135(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L255:
	movq	%r14, %rdi
	call	sdup@PLT
	leaq	g_known_variables(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L251
.L435:
	movq	stderr(%rip), %rdi
	movq	%r14, %rcx
	movq	%r12, %rdx
	xorl	%eax, %eax
	leaq	.LC126(%rip), %rsi
	call	fprintf@PLT
	jmp	.L277
.L292:
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%edx, %edx
	movq	%rdx, g_compilation_arena(%rip)
	jmp	.L265
.L426:
	cmpq	$1, %rdx
	jbe	.L264
	jmp	.L295
.L423:
	leaq	.LC42(%rip), %rax
	movq	%rax, 40(%rsp)
	jmp	.L226
.L422:
	movl	$7, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC76(%rip), %rdi
	movl	$2, %ebp
	call	fwrite@PLT
	movq	(%rbx), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC77(%rip), %rsi
	call	fprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$24, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC78(%rip), %rdi
	call	fwrite@PLT
	movq	(%rbx), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC79(%rip), %rsi
	call	fprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$9, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC80(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC81(%rip), %rdi
	call	fwrite@PLT
	movl	$62, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC82(%rip), %rdi
	call	fwrite@PLT
	movl	$52, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
	movl	$53, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	movl	$37, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	movl	$69, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
	movl	$40, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	call	fwrite@PLT
	movl	$58, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	call	fwrite@PLT
	movl	$44, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	call	fwrite@PLT
	movl	$35, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
	movl	$37, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	call	fwrite@PLT
	movl	$39, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
	call	fwrite@PLT
	movl	$42, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
	call	fwrite@PLT
	movl	$66, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
	call	fwrite@PLT
	movl	$57, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC97(%rip), %rdi
	call	fwrite@PLT
	movl	$71, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
	call	fwrite@PLT
	movl	$41, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movl	$64, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC100(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$12, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC101(%rip), %rdi
	call	fwrite@PLT
	movl	$64, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC102(%rip), %rdi
	call	fwrite@PLT
	movl	$71, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$33, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC104(%rip), %rdi
	call	fwrite@PLT
	movl	$49, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movl	$49, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC106(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC108(%rip), %rdi
	call	fwrite@PLT
	movl	$54, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC109(%rip), %rdi
	call	fwrite@PLT
	movl	$60, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC110(%rip), %rdi
	call	fwrite@PLT
	movl	$51, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movl	$52, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC112(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$38, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	movl	$33, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC114(%rip), %rdi
	call	fwrite@PLT
	movl	$54, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movl	$42, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
	movl	$72, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%eax, %eax
	movq	%rax, g_compilation_arena(%rip)
	jmp	.L197
.L326:
	movq	40(%rsp), %rsi
	leaq	.LC36(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L269
.L436:
	movq	8(%rsp), %r14
.L278:
	cmpl	$0, 88(%rsp)
	jne	.L440
.L273:
	xorl	%ebp, %ebp
	cmpl	$0, 60(%rsp)
	movl	$1, %ebx
	je	.L441
	movl	96(%rsp), %r12d
	movl	36(%rsp), %r13d
	movl	88(%rsp), %r14d
	movl	32(%rsp), %r15d
	jmp	.L279
.L283:
	movq	304(%rsp), %rax
	movq	%rbx, %xmm0
	movl	$1, %edx
	leaq	336(%rsp), %rdi
	punpcklqdq	%xmm0, %xmm0
	leaq	(%rax,%rbp,8), %rax
	movups	%xmm0, 344(%rsp)
	movq	%rax, 336(%rsp)
	movq	272(%rsp), %rax
	movq	(%rax,%rbp,8), %rsi
	pushq	%r14
	.cfi_def_cfa_offset 536
	pushq	%r15
	.cfi_def_cfa_offset 544
	pushq	%r13
	.cfi_def_cfa_offset 552
	movl	76(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 560
	leaq	240(%rsp), %rax
	pushq	%rax
	.cfi_def_cfa_offset 568
	pushq	%r12
	.cfi_def_cfa_offset 576
	movl	132(%rsp), %r9d
	movl	128(%rsp), %r8d
	movl	124(%rsp), %ecx
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 528
	testl	%eax, %eax
	jne	.L282
	addq	$1, %rbp
.L279:
	cmpq	312(%rsp), %rbp
	jb	.L283
.L284:
	xorl	%ebx, %ebx
	leaq	.LC132(%rip), %r12
	cmpq	$0, 312(%rsp)
	je	.L292
	movl	92(%rsp), %r13d
	movl	88(%rsp), %r14d
	jmp	.L285
.L290:
	testl	%r14d, %r14d
	jne	.L442
.L291:
	movq	%rbp, %rdi
	addq	$1, %rbx
	call	free@PLT
	cmpq	312(%rsp), %rbx
	jnb	.L292
.L285:
	movq	304(%rsp), %rax
	movq	(%rax,%rbx,8), %rbp
	testl	%r13d, %r13d
	jne	.L290
	movq	%rbp, %rdi
	call	unlink@PLT
	jmp	.L291
.L442:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rdx
	movq	%r12, %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L291
.L303:
	movl	$1, 76(%rsp)
	jmp	.L200
.L228:
	xorl	%edx, %edx
	jmp	.L240
.L304:
	movl	$1, 80(%rsp)
	jmp	.L200
.L441:
	movl	88(%rsp), %eax
	xorl	%edx, %edx
	movq	%r14, %rdi
	pushq	%rax
	.cfi_def_cfa_offset 536
	movl	40(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 544
	movl	52(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 552
	movl	76(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 560
	leaq	240(%rsp), %rax
	pushq	%rax
	.cfi_def_cfa_offset 568
	movl	136(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 576
	movl	132(%rsp), %r9d
	movl	128(%rsp), %r8d
	movl	124(%rsp), %ecx
	movq	88(%rsp), %rsi
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 528
	testl	%eax, %eax
	je	.L284
.L282:
	movq	stderr(%rip), %rdi
	movl	%eax, %edx
	leaq	.LC129(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpl	$0, 92(%rsp)
	je	.L286
.L289:
	movq	g_compilation_arena(%rip), %rdi
	movl	$1, %ebp
	call	arena_free@PLT
	xorl	%eax, %eax
	movq	%rax, g_compilation_arena(%rip)
	jmp	.L197
.L440:
	movq	stderr(%rip), %rdi
	movq	312(%rsp), %rdx
	leaq	.LC127(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L273
.L305:
	xorl	%r10d, %r10d
	movl	%r10d, 80(%rsp)
	jmp	.L200
.L286:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC130(%rip), %rdi
	leaq	.LC131(%rip), %rbp
	call	fwrite@PLT
	jmp	.L287
.L288:
	movq	304(%rsp), %rax
	movq	stderr(%rip), %rdi
	movq	%rbp, %rsi
	movq	(%rax,%rbx,8), %rdx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
.L287:
	cmpq	312(%rsp), %rbx
	jb	.L288
	jmp	.L289
.L306:
	movl	$1, 84(%rsp)
	jmp	.L200
.L308:
	movl	$1, 96(%rsp)
	jmp	.L200
.L307:
	xorl	%r9d, %r9d
	movl	%r9d, 84(%rsp)
	jmp	.L200
.L429:
	leaq	.LC54(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L200
.L312:
	movl	$32, 32(%rsp)
	jmp	.L200
.L437:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L275
.L427:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	40(%rsp), %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L268
.L311:
	movl	$16, 32(%rsp)
	jmp	.L200
.L203:
	leaq	.LC55(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L205
	movl	$1, g_strict(%rip)
	xorl	%r11d, %r11d
	movl	%r11d, g_extensions(%rip)
	jmp	.L200
.L310:
	xorl	%r8d, %r8d
	movl	$1, 16(%rsp)
	movl	%r8d, 36(%rsp)
	jmp	.L200
.L309:
	movl	$1, 16(%rsp)
	movl	$1, 36(%rsp)
	jmp	.L200
.L205:
	leaq	.LC56(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L207
	movl	$1, g_pedantic(%rip)
	jmp	.L200
.L207:
	leaq	.LC57(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L314
	leaq	.LC58(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L315
	leaq	.LC59(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L316
	leaq	.LC60(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L200
	leaq	.LC61(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L317
	leaq	.LC62(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L318
	leaq	.LC63(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L319
	leaq	.LC18(%rip), %rsi
	movq	%r15, %rdi
	leal	1(%r14), %r13d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L208
	cmpl	%r13d, %ebp
	jg	.L209
	leaq	.LC64(%rip), %rdi
	call	dief@PLT
.L209:
	movq	8(%rbx,%r12), %rax
	movl	%r13d, %r14d
	movq	%rax, 40(%rsp)
	jmp	.L200
.L208:
	leaq	.LC65(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L210
	cmpl	%r13d, %ebp
	jle	.L443
.L211:
	movq	8(%rbx,%r12), %r12
	leaq	.LC67(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L212
	leaq	.LC68(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L212
	leaq	.LC69(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L212
	leaq	.LC70(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L212
	leaq	.LC71(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L213
.L212:
	movl	$1, g_use_curses(%rip)
.L213:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %r15
	movq	%r15, %rdi
	call	malloc@PLT
	movq	%rax, %r14
	testq	%rax, %rax
	je	.L444
.L214:
	movq	%r15, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	xorl	%eax, %eax
	leaq	.LC72(%rip), %rdx
	call	snprintf@PLT
	leaq	208(%rsp), %rdi
	movq	%r14, %rsi
	call	vec_push@PLT
.L217:
	movl	%r13d, %r14d
	jmp	.L200
.L443:
	leaq	.LC66(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L211
.L444:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L214
.L210:
	leaq	.LC73(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L215
	cmpl	%r13d, %ebp
	jg	.L216
	leaq	.LC74(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L216:
	movq	8(%rbx,%r12), %rdi
	call	sdup@PLT
	leaq	208(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L217
.L215:
	cmpb	$45, (%r15)
	je	.L445
	leaq	240(%rsp), %rax
	movq	%r15, %rsi
	movq	%rax, %rdi
	call	vec_push@PLT
	jmp	.L200
.L319:
	xorl	%esi, %esi
	movl	%esi, 52(%rsp)
	jmp	.L200
.L318:
	movl	$1, 88(%rsp)
	jmp	.L200
.L445:
	movq	%r15, %rsi
	leaq	.LC75(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L200
.L317:
	movl	$1, 24(%rsp)
	jmp	.L200
.L316:
	movl	$1, 68(%rsp)
	jmp	.L200
.L315:
	movl	$1, 64(%rsp)
	jmp	.L200
.L314:
	movl	$1, 56(%rsp)
	jmp	.L200
	.cfi_endproc
.LFE23:
	.size	run_main, .-run_main
	.section	.rodata.str1.1
.LC137:
	.string	"cannot write standard output"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	run_main
	movq	stdout(%rip), %rdi
	movl	%eax, %ebx
	call	ferror@PLT
	movq	stdout(%rip), %rdi
	movl	%eax, %ebp
	call	fflush@PLT
	testl	%ebp, %ebp
	jne	.L449
	cmpl	$-1, %eax
	je	.L449
.L446:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	%ebx, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L449:
	.cfi_restore_state
	leaq	.LC137(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L446
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.local	g_libb_dir
	.comm	g_libb_dir,4096,32
	.section	.data.rel.ro.local,"aw"
	.align 8
.LC23:
	.quad	.LC9
	.align 8
.LC24:
	.quad	.LC19
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC26:
	.long	1
	.long	1
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC41:
	.quad	7161675788338426927
	.quad	24866934413088863
	.section	.note.GNU-stack,"",@progbits
