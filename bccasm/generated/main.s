	.file	"main.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"output '%s' would overwrite input '%s'"
	.text
	.p2align 4
	.type	protect_input, @function
protect_input:
.LFB51:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$304, %rsp
	.cfi_def_cfa_offset 352
	movq	%fs:40, %rax
	movq	%rax, 296(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rsi
	call	stat@PLT
	testl	%eax, %eax
	jne	.L1
	xorl	%ebx, %ebx
	cmpq	$0, 8(%rbp)
	leaq	144(%rsp), %r12
	jne	.L3
	jmp	.L1
	.p2align 4,,10
	.p2align 3
.L5:
	addq	$1, %rbx
	cmpq	8(%rbp), %rbx
	jnb	.L1
.L3:
	movq	0(%rbp), %rax
	movq	%r12, %rsi
	leaq	0(,%rbx,8), %r14
	movq	(%rax,%rbx,8), %rdi
	call	stat@PLT
	testl	%eax, %eax
	jne	.L5
	movq	(%rsp), %rax
	cmpq	%rax, 144(%rsp)
	jne	.L5
	movq	8(%rsp), %rax
	cmpq	%rax, 152(%rsp)
	jne	.L5
	movq	0(%rbp), %rax
	movq	%r13, %rsi
	leaq	.LC0(%rip), %rdi
	movq	(%rax,%r14), %rdx
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L1:
	movq	296(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L12
	addq	$304, %rsp
	.cfi_remember_state
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
.L12:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE51:
	.size	protect_input, .-protect_input
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"/proc/self/exe"
.LC2:
	.string	"%s/lib"
	.text
	.p2align 4
	.type	init_libb_path, @function
init_libb_path:
.LFB52:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$4096, %rsp
	.cfi_def_cfa_offset 4120
	orq	$0, (%rsp)
	subq	$4096, %rsp
	.cfi_def_cfa_offset 8216
	orq	$0, (%rsp)
	subq	$24, %rsp
	.cfi_def_cfa_offset 8240
	movl	$4095, %edx
	movq	%fs:40, %rax
	movq	%rax, 8200(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rbp
	movq	%rdi, %rbx
	leaq	.LC1(%rip), %rdi
	movq	%rbp, %rsi
	call	readlink@PLT
	testq	%rax, %rax
	jg	.L24
	testq	%rbx, %rbx
	je	.L16
	cmpb	$0, (%rbx)
	jne	.L25
.L16:
	movl	$1768697646, g_libb_dir(%rip)
	movw	$98, 4+g_libb_dir(%rip)
.L13:
	movq	8200(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L26
	addq	$8216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L24:
	.cfi_restore_state
	movb	$0, (%rsp,%rax)
	movq	%rbp, %rdi
.L23:
	call	dirname@PLT
	movl	$4096, %ecx
	movl	$2, %edx
	leaq	.LC2(%rip), %r8
	movq	%rax, %r9
	movl	$4096, %esi
	leaq	g_libb_dir(%rip), %rdi
	xorl	%eax, %eax
	call	__snprintf_chk@PLT
	jmp	.L13
.L25:
	leaq	4096(%rsp), %rdi
	movl	$4095, %edx
	movq	%rbx, %rsi
	call	strncpy@PLT
	movb	$0, 8191(%rsp)
	movq	%rax, %rdi
	jmp	.L23
.L26:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE52:
	.size	init_libb_path, .-init_libb_path
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
.LFB53:
	.cfi_startproc
	endbr64
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
	testq	%rax, %rax
	je	.L39
	xorl	%esi, %esi
	movl	$2, %edx
	movq	%rax, %rdi
	movq	%rax, %rbx
	call	fseek@PLT
	testl	%eax, %eax
	jne	.L31
	movq	%rbx, %rdi
	call	ftell@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	js	.L40
	xorl	%edx, %edx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	fseek@PLT
	testl	%eax, %eax
	jne	.L31
	leaq	1(%rbp), %rdi
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L41
	movq	%rax, %rdi
	movq	%rbx, %rcx
	movq	%rbp, %rdx
	movl	$1, %esi
	call	fread@PLT
	movq	%rbx, %rdi
	movq	%rax, %r15
	call	fclose@PLT
	cmpq	%r15, %rbp
	jne	.L42
	movb	$0, (%r12,%rbp)
	testq	%r13, %r13
	je	.L27
	movq	%rbp, 0(%r13)
.L27:
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
.L31:
	.cfi_restore_state
	leaq	.LC5(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L39:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%r14, %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
.L42:
	movq	%r14, %rsi
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L41:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L40:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE53:
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
	.string	"\n"
.LC23:
	.string	" %s"
	.text
	.p2align 4
	.globl	run_gcc_multi
	.type	run_gcc_multi, @function
run_gcc_multi:
.LFB56:
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
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$4096, %rsp
	.cfi_def_cfa_offset 4152
	orq	$0, (%rsp)
	subq	$104, %rsp
	.cfi_def_cfa_offset 4256
	movq	.LC24(%rip), %xmm1
	movl	4272(%rsp), %r12d
	movq	4264(%rsp), %rbp
	movq	%rsi, 24(%rsp)
	movq	%rdi, %rbx
	movl	%edx, %r14d
	movl	%ecx, 36(%rsp)
	movl	%r8d, 40(%rsp)
	movl	%r9d, 44(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 4184(%rsp)
	leaq	.LC10(%rip), %rax
	testl	%edx, %edx
	sete	%r15b
	movq	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm1
	movaps	%xmm1, (%rsp)
	testl	%r12d, %r12d
	je	.L76
	testb	%r15b, %r15b
	jne	.L125
.L76:
	xorl	%r13d, %r13d
.L44:
	leaq	80(%rsp), %rax
	movl	$4099, %esi
	leaq	g_libb_dir(%rip), %r9
	movl	$4099, %ecx
	movq	%rax, 56(%rsp)
	movq	%rax, %rdi
	movl	$2, %edx
	xorl	%eax, %eax
	leaq	.LC11(%rip), %r8
	call	__snprintf_chk@PLT
	movq	8(%rbx), %rsi
	xorl	%eax, %eax
	testq	%rbp, %rbp
	je	.L45
	movq	8(%rbp), %rax
.L45:
	leaq	40(%rsi,%rax), %rdi
	movq	%rsi, 48(%rsp)
	salq	$3, %rdi
	call	malloc@PLT
	movq	48(%rsp), %rsi
	testq	%rax, %rax
	movq	%rax, %r12
	je	.L126
	movdqa	(%rsp), %xmm3
	movups	%xmm3, (%rax)
	testl	%r14d, %r14d
	je	.L127
	movl	$3, %eax
	movl	$16, %edx
	movl	$2, %r8d
.L47:
	movl	40(%rsp), %r11d
	testl	%r11d, %r11d
	je	.L48
	leaq	.LC13(%rip), %rcx
	movslq	%eax, %r8
	movq	%rcx, (%r12,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L48:
	movl	44(%rsp), %r10d
	testl	%r10d, %r10d
	je	.L49
	leaq	.LC14(%rip), %rcx
	movslq	%eax, %r8
	movq	%rcx, (%r12,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L49:
	movl	4256(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L50
	leaq	.LC15(%rip), %rcx
	movslq	%eax, %r8
	movq	%rcx, (%r12,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L50:
	movl	36(%rsp), %edi
	testl	%edi, %edi
	je	.L51
	leaq	.LC16(%rip), %rcx
	movslq	%eax, %r8
	movq	%rcx, (%r12,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L51:
	movl	4272(%rsp), %ecx
	testl	%ecx, %ecx
	je	.L52
	movq	56(%rsp), %rcx
	movslq	%eax, %r8
	movq	%rcx, (%r12,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L52:
	testl	%r14d, %r14d
	je	.L53
	leaq	.LC17(%rip), %rcx
	leal	2(%rax), %edi
	movslq	%eax, %r8
	movq	%rcx, (%r12,%rdx)
	movslq	%eax, %rdx
	leaq	.LC18(%rip), %rcx
	movq	%rcx, (%r12,%rdx,8)
	movq	24(%rsp), %rcx
	leal	1(%rax), %edx
	movslq	%edx, %rdx
	movq	%rcx, (%r12,%rdx,8)
	testq	%rsi, %rsi
	je	.L128
.L54:
	movq	(%rbx), %r9
	leaq	(%r12,%r8,8), %r8
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L57:
	movq	(%r9,%rax,8), %rdx
	movq	%rdx, 16(%r8,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %rsi
	jne	.L57
	addl	%esi, %edi
.L56:
	testq	%r13, %r13
	je	.L58
	testb	%r15b, %r15b
	je	.L58
	leal	1(%rdi), %esi
	movslq	%edi, %rdi
	movq	%r13, (%r12,%rdi,8)
	testq	%rbp, %rbp
	je	.L60
	movq	8(%rbp), %r8
	testq	%r8, %r8
	je	.L60
.L61:
	movslq	%esi, %rax
	movq	0(%rbp), %r9
	leaq	(%r12,%rax,8), %rdi
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L64:
	movq	(%r9,%rax,8), %rdx
	movq	%rdx, (%rdi,%rax,8)
	addq	$1, %rax
	cmpq	%r8, %rax
	jne	.L64
	addl	%eax, %esi
.L63:
	testl	%r14d, %r14d
	je	.L60
.L62:
	movl	4296(%rsp), %eax
	movslq	%esi, %rsi
	movq	$0, (%r12,%rsi,8)
	testl	%eax, %eax
	jne	.L129
	call	fork@PLT
	movl	%eax, %edi
	testl	%eax, %eax
	js	.L130
.L69:
	je	.L131
	leaq	76(%rsp), %rsi
	xorl	%edx, %edx
	movl	$0, 76(%rsp)
	call	waitpid@PLT
	movq	%r12, %rdi
	testl	%eax, %eax
	js	.L132
	call	free@PLT
	movl	76(%rsp), %eax
	testb	$127, %al
	je	.L133
.L70:
	movl	$1, %eax
.L43:
	movq	4184(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L134
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
.L127:
	.cfi_restore_state
	leaq	.LC12(%rip), %rax
	movl	$24, %edx
	movl	$3, %r8d
	movq	%rax, 16(%r12)
	movl	$4, %eax
	jmp	.L47
	.p2align 4,,10
	.p2align 3
.L125:
	movl	4288(%rsp), %ecx
	movl	4280(%rsp), %edx
	leaq	g_libb_dir(%rip), %rdi
	movl	4296(%rsp), %esi
	call	compile_libb@PLT
	movq	%rax, %r13
	jmp	.L44
	.p2align 4,,10
	.p2align 3
.L60:
	leaq	.LC20(%rip), %rdx
	leaq	.LC19(%rip), %rbx
	movslq	%esi, %rax
	addl	$2, %esi
	movq	%rbx, %xmm0
	movq	%rdx, %xmm4
	punpcklqdq	%xmm4, %xmm0
	movups	%xmm0, (%r12,%rax,8)
	jmp	.L62
	.p2align 4,,10
	.p2align 3
.L53:
	leaq	.LC18(%rip), %rcx
	cltq
	leal	2(%r8), %edi
	movq	%rcx, (%r12,%rdx)
	movq	24(%rsp), %rcx
	movq	%rcx, (%r12,%rax,8)
	testq	%rsi, %rsi
	jne	.L54
	jmp	.L56
	.p2align 4,,10
	.p2align 3
.L58:
	movl	%edi, %esi
	testq	%rbp, %rbp
	je	.L63
	movq	8(%rbp), %r8
	testq	%r8, %r8
	jne	.L61
	jmp	.L63
	.p2align 4,,10
	.p2align 3
.L129:
	movq	stderr(%rip), %rdi
	leaq	.LC21(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	8(%r12), %rbx
	leaq	.LC23(%rip), %rbp
	call	__fprintf_chk@PLT
	movq	(%r12), %rcx
	testq	%rcx, %rcx
	je	.L68
	.p2align 4,,10
	.p2align 3
.L67:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rdx
	xorl	%eax, %eax
	addq	$8, %rbx
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	-8(%rbx), %rcx
	testq	%rcx, %rcx
	jne	.L67
.L68:
	movq	stderr(%rip), %rdi
	leaq	.LC22(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	call	fork@PLT
	movl	%eax, %edi
	testl	%eax, %eax
	jns	.L69
.L130:
	movq	%r12, %rdi
	call	free@PLT
	jmp	.L70
	.p2align 4,,10
	.p2align 3
.L132:
	call	free@PLT
	jmp	.L70
	.p2align 4,,10
	.p2align 3
.L133:
	movzbl	%ah, %eax
	jmp	.L43
.L128:
	movl	%edi, %esi
	testq	%rbp, %rbp
	je	.L62
	movq	8(%rbp), %r8
	movl	%edi, %esi
	testq	%r8, %r8
	jne	.L61
	jmp	.L62
.L131:
	leaq	.LC9(%rip), %rdi
	movq	%r12, %rsi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
.L134:
	call	__stack_chk_fail@PLT
.L126:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE56:
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
.LFB57:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%r9d, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movl	%r8d, %r13d
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
	subq	$280, %rsp
	.cfi_def_cfa_offset 336
	movl	%esi, 8(%rsp)
	movq	352(%rsp), %r15
	movl	%edx, 12(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 264(%rsp)
	xorl	%eax, %eax
	testl	%ecx, %ecx
	jne	.L189
	leaq	104(%rsp), %rsi
	leaq	112(%rsp), %r12
	movq	$0, 104(%rsp)
	call	read_file_all
	movl	$14, %ecx
	xorl	%esi, %esi
	movq	%rbx, %r8
	leaq	128(%rsp), %rdx
	movq	%rax, %rbp
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	movq	%rbp, 112(%rsp)
	rep stosq
	movl	360(%rsp), %eax
	leaq	32(%rsp), %rdi
	movl	$1, %ecx
	movq	%rbx, 144(%rsp)
	movl	%eax, 224(%rsp)
	movq	104(%rsp), %rax
	movq	%rbp, 216(%rsp)
	movq	%rax, 120(%rsp)
	movq	.LC26(%rip), %rax
	movq	%rax, 136(%rsp)
	call	mk_tok@PLT
	movdqu	32(%rsp), %xmm1
	movdqu	48(%rsp), %xmm2
	movq	%r12, %rdi
	movdqu	64(%rsp), %xmm3
	movq	80(%rsp), %rax
	movups	%xmm1, 152(%rsp)
	movq	%rax, 200(%rsp)
	movups	%xmm2, 168(%rsp)
	movups	%xmm3, 184(%rsp)
	call	next@PLT
	testl	%r13d, %r13d
	jne	.L162
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	152(%rsp), %rdi
	movq	%rax, %r12
	call	tok_free@PLT
	testl	%r14d, %r14d
	jne	.L190
.L142:
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	sem_check_program@PLT
.L144:
	movl	344(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L145
	testq	%r15, %r15
	je	.L145
	movq	%r15, %rdi
	call	strdup@PLT
	movq	%rax, %r14
	movq	%rax, %r15
	testq	%rax, %rax
	je	.L150
	leaq	.LC31(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L191
.L147:
	subq	$8, %rsp
	.cfi_def_cfa_offset 344
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movq	%r13, %rdi
	movl	376(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 352
	movl	376(%rsp), %r9d
	movl	28(%rsp), %r8d
	movl	24(%rsp), %ecx
	call	emit_program_c_ext@PLT
	movq	%r13, %rdi
	call	ferror@PLT
	movq	%r13, %rdi
	movl	%eax, %ebx
	call	fclose@PLT
	popq	%rsi
	.cfi_def_cfa_offset 344
	popq	%rdi
	.cfi_def_cfa_offset 336
	cmpl	$-1, %eax
	je	.L166
	testl	%ebx, %ebx
	jne	.L166
	movl	336(%rsp), %ecx
	testl	%ecx, %ecx
	je	.L157
	leaq	.LC39(%rip), %rsi
	movq	%r15, %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	jne	.L158
	jmp	.L192
	.p2align 4,,10
	.p2align 3
.L159:
	movq	stdout(%rip), %rsi
	call	putc@PLT
.L158:
	movq	%rbx, %rdi
	call	fgetc@PLT
	movl	%eax, %edi
	cmpl	$-1, %eax
	jne	.L159
	movq	%rbx, %rdi
	call	ferror@PLT
	testl	%eax, %eax
	jne	.L193
	movq	%rbx, %rdi
	call	fclose@PLT
.L157:
	movq	%rbp, %rdi
	call	free@PLT
.L135:
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L194
	addq	$280, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rax
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
.L145:
	.cfi_restore_state
	movdqa	.LC41(%rip), %xmm0
	leaq	240(%rsp), %r13
	movq	%r13, %rdi
	movaps	%xmm0, 240(%rsp)
	call	mkstemp@PLT
	movl	%eax, %edi
	testl	%eax, %eax
	js	.L195
	leaq	.LC33(%rip), %rsi
	call	fdopen@PLT
	movq	%rax, 16(%rsp)
	testq	%rax, %rax
	je	.L196
	movq	%r13, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdx
	movq	%rdx, %rdi
	movq	%rdx, 24(%rsp)
	call	malloc@PLT
	movq	%rax, %r14
	movq	%rax, %r15
	testq	%rax, %rax
	je	.L150
	movq	24(%rsp), %rdx
	movq	%rax, %rdi
	movq	%r13, %r8
	movl	$2, %esi
	leaq	.LC35(%rip), %rcx
	xorl	%eax, %eax
	call	__sprintf_chk@PLT
	movq	16(%rsp), %rdi
	call	ferror@PLT
	movq	16(%rsp), %rdi
	movl	%eax, 24(%rsp)
	call	fclose@PLT
	cmpl	$-1, %eax
	je	.L165
	movl	24(%rsp), %edx
	testl	%edx, %edx
	jne	.L165
	movq	%r14, %rsi
	movq	%r13, %rdi
	call	rename@PLT
	testl	%eax, %eax
	jne	.L197
	leaq	.LC31(%rip), %rsi
	movq	%r14, %rdi
	call	fopen@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	jne	.L147
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%r14, %rsi
	leaq	.LC38(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L189:
	movq	%rdi, %rcx
	movl	$2, %esi
	leaq	112(%rsp), %r12
	movq	stderr(%rip), %rdi
	leaq	.LC25(%rip), %rdx
	call	__fprintf_chk@PLT
	leaq	104(%rsp), %rsi
	movq	%rbx, %rdi
	movq	$0, 104(%rsp)
	call	read_file_all
	movl	$14, %ecx
	xorl	%esi, %esi
	movq	%rbx, %r8
	leaq	128(%rsp), %rdx
	movq	%rax, %rbp
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	movq	%rbp, 112(%rsp)
	rep stosq
	movl	360(%rsp), %eax
	leaq	32(%rsp), %rdi
	movl	$1, %ecx
	movq	%rbx, 144(%rsp)
	movl	%eax, 224(%rsp)
	movq	104(%rsp), %rax
	movq	%rbp, 216(%rsp)
	movq	%rax, 120(%rsp)
	movq	.LC26(%rip), %rax
	movq	%rax, 136(%rsp)
	call	mk_tok@PLT
	movq	80(%rsp), %rax
	movq	%r12, %rdi
	movdqu	32(%rsp), %xmm4
	movdqu	48(%rsp), %xmm5
	movdqu	64(%rsp), %xmm6
	movq	%rax, 200(%rsp)
	movups	%xmm4, 152(%rsp)
	movups	%xmm5, 168(%rsp)
	movups	%xmm6, 184(%rsp)
	call	next@PLT
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC27(%rip), %rdx
	movl	$2, %esi
	call	__fprintf_chk@PLT
	testl	%r13d, %r13d
	jne	.L162
	movq	stderr(%rip), %rdi
	leaq	.LC28(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	152(%rsp), %rdi
	movq	%rax, %r12
	call	tok_free@PLT
	testl	%r14d, %r14d
	jne	.L198
.L140:
	movq	stderr(%rip), %rdi
	leaq	.LC29(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	sem_check_program@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC30(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	jmp	.L144
	.p2align 4,,10
	.p2align 3
.L190:
	movq	%r12, %rdi
	call	dump_ast_program@PLT
	movl	336(%rsp), %edx
	testl	%edx, %edx
	jne	.L142
	jmp	.L161
	.p2align 4,,10
	.p2align 3
.L198:
	movq	%r12, %rdi
	call	dump_ast_program@PLT
	movl	336(%rsp), %eax
	testl	%eax, %eax
	jne	.L140
.L161:
	movq	%rbp, %rdi
	call	free@PLT
.L138:
	xorl	%r15d, %r15d
	jmp	.L135
	.p2align 4,,10
	.p2align 3
.L162:
	movq	%r12, %rdi
	call	dump_token_stream@PLT
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L138
.L166:
	movq	%r15, %rsi
	leaq	.LC36(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L165:
	movq	%r13, %rsi
	leaq	.LC36(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L194:
	call	__stack_chk_fail@PLT
.L150:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L197:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC37(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
.L192:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%r15, %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
.L193:
	movq	%r15, %rsi
	leaq	.LC40(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L191:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%r14, %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
.L195:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC32(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
.L196:
	leaq	.LC34(%rip), %rdi
	call	dief@PLT
	.cfi_endproc
.LFE57:
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
	.string	"conflicting external definition '%s'"
	.align 8
.LC121:
	.string	"duplicate external function '%s'"
	.align 8
.LC122:
	.string	"duplicate external variable '%s'"
	.align 8
.LC123:
	.string	"--asm only works with a single input file"
	.section	.rodata.str1.1
.LC124:
	.string	"-S"
.LC125:
	.string	"-"
.LC126:
	.string	"Generated C: %s\n"
	.section	.rodata.str1.8
	.align 8
.LC127:
	.string	"-S and --asm only work with a single input file"
	.align 8
.LC128:
	.string	"-E only works with a single input file"
	.section	.rodata.str1.1
.LC129:
	.string	"Compiled %s -> %s\n"
.LC130:
	.string	"Linking %zu file(s)...\n"
.LC132:
	.string	"gcc failed (exit %d)\n"
.LC133:
	.string	"Generated C files:\n"
.LC134:
	.string	"  %s\n"
.LC135:
	.string	"Kept: %s\n"
	.text
	.p2align 4
	.type	run_main, @function
run_main:
.LFB58:
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
	movl	%edi, %r13d
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
	subq	$488, %rsp
	.cfi_def_cfa_offset 544
	movq	(%rsi), %rdi
	movq	%fs:40, %rax
	movq	%rax, 472(%rsp)
	xorl	%eax, %eax
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
	cmpl	$1, %r13d
	jle	.L298
	xorl	%edx, %edx
	xorl	%r8d, %r8d
	movq	$0, 32(%rsp)
	movl	$1, %r15d
	movl	$1, 64(%rsp)
	movl	$0, 28(%rsp)
	movl	$0, 68(%rsp)
	movl	$0, 60(%rsp)
	movl	$0, 56(%rsp)
	movl	$0, 52(%rsp)
	movl	$1, 44(%rsp)
	movl	$0, 92(%rsp)
	movl	$1, 88(%rsp)
	movl	$1, 84(%rsp)
	movl	$0, 80(%rsp)
	movl	$0, 48(%rsp)
	movl	$0, 40(%rsp)
	movl	$0, 24(%rsp)
	movl	$0, 12(%rsp)
	movl	$0, 8(%rsp)
	movl	$0, (%rsp)
	movl	%r8d, 16(%rsp)
	movl	%edx, 72(%rsp)
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L426:
	cmpb	$83, 1(%r14)
	jne	.L328
	cmpb	$0, 2(%r14)
	jne	.L328
	movl	$1, (%rsp)
.L202:
	addl	$1, %r15d
	cmpl	%r15d, %r13d
	jle	.L425
.L219:
	movslq	%r15d, %rax
	movq	(%r12,%rax,8), %r14
	leaq	0(,%rax,8), %rbx
	movzbl	(%r14), %ebp
	cmpl	$45, %ebp
	je	.L426
.L328:
	leaq	.LC43(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L300
	cmpl	$45, %ebp
	je	.L427
.L330:
	leaq	.LC44(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L422
	leaq	.LC45(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L304
	cmpl	$45, %ebp
	je	.L428
.L331:
	leaq	.LC13(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L306
	leaq	.LC46(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L307
	leaq	.LC14(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L308
	leaq	.LC47(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L309
	leaq	.LC15(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L310
	leaq	.LC48(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L311
	leaq	.LC49(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L312
	movl	$7, %edx
	leaq	.LC50(%rip), %rsi
	movq	%r14, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L206
	addq	$7, %r14
	leaq	.LC51(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L313
	leaq	.LC52(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L314
	leaq	.LC53(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	movl	%eax, 28(%rsp)
	testl	%eax, %eax
	je	.L202
	leaq	.LC54(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L300:
	addl	$1, %r15d
	movl	$1, 8(%rsp)
	cmpl	%r15d, %r13d
	jg	.L219
.L425:
	movl	16(%rsp), %r8d
	movl	72(%rsp), %edx
	testl	%r8d, %r8d
	je	.L200
.L220:
	movq	248(%rsp), %rax
	movl	%edx, g_verbose_errors(%rip)
	movl	$1, g_no_line(%rip)
	testq	%rax, %rax
	je	.L429
	movl	12(%rsp), %r13d
	pxor	%xmm0, %xmm0
	movq	$0, 288(%rsp)
	movaps	%xmm0, 272(%rsp)
	testl	%r13d, %r13d
	jne	.L225
	cmpq	$0, 32(%rsp)
	je	.L430
.L227:
	leaq	240(%rsp), %r12
	movq	32(%rsp), %rdi
	movq	%r12, %rsi
	call	protect_input
.L237:
	cmpq	$1, 248(%rsp)
	jbe	.L245
	cmpl	$0, 52(%rsp)
	je	.L238
.L245:
	movl	8(%rsp), %ebx
	movq	248(%rsp), %rax
	testl	%ebx, %ebx
	je	.L431
	subq	$1, %rax
	jne	.L295
	pushq	%r11
	.cfi_def_cfa_offset 552
	xorl	%r9d, %r9d
	xorl	%r8d, %r8d
	movl	$1, %edx
	pushq	$0
	.cfi_def_cfa_offset 560
	movl	44(%rsp), %r15d
	pushq	%r15
	.cfi_def_cfa_offset 568
	pushq	$0
	.cfi_def_cfa_offset 576
	pushq	$0
	.cfi_def_cfa_offset 584
	pushq	$0
	.cfi_def_cfa_offset 592
	movq	288(%rsp), %rax
	movl	116(%rsp), %r14d
	movl	92(%rsp), %r13d
	movq	(%rax), %rdi
	movl	%r14d, %ecx
	movl	%r13d, %esi
	call	compile_b_to_c
	leaq	384(%rsp), %rdi
	movl	$6, %ecx
	addq	$48, %rsp
	.cfi_def_cfa_offset 544
	movq	%rax, %rbx
	xorl	%eax, %eax
	leaq	336(%rsp), %rbp
	rep stosl
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	leaq	208(%rsp), %r12
	call	vec_push@PLT
	leaq	.LC124(%rip), %rdi
	call	sdup@PLT
	movq	%r12, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	pushq	%r14
	.cfi_def_cfa_offset 552
	xorl	%edx, %edx
	movq	%rbp, %rdi
	pushq	%r15
	.cfi_def_cfa_offset 560
	leaq	.LC125(%rip), %rsi
	pushq	%r13
	.cfi_def_cfa_offset 568
	pushq	$0
	.cfi_def_cfa_offset 576
	pushq	%r12
	.cfi_def_cfa_offset 584
	movl	132(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 592
	movl	136(%rsp), %r9d
	movl	132(%rsp), %r8d
	movl	128(%rsp), %ecx
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 544
	movl	%eax, %ebp
	movl	40(%rsp), %eax
	orl	%ebp, %eax
	je	.L262
	movq	stderr(%rip), %rdi
	movq	%rbx, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC126(%rip), %rdx
	call	__fprintf_chk@PLT
.L263:
	movq	%rbx, %rdi
	call	free@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%r10d, %r10d
	movq	%r10, g_compilation_arena(%rip)
.L199:
	movq	472(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L432
	addq	$488, %rsp
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
.L427:
	.cfi_restore_state
	cmpb	$99, 1(%r14)
	je	.L433
.L329:
	cmpl	$45, %ebp
	jne	.L330
	cmpb	$69, 1(%r14)
	jne	.L330
	cmpb	$0, 2(%r14)
	jne	.L330
	movl	$1, 24(%rsp)
	jmp	.L202
	.p2align 4,,10
	.p2align 3
.L433:
	cmpb	$0, 2(%r14)
	jne	.L329
	movl	$1, 12(%rsp)
	jmp	.L202
.L304:
	movl	$1, 48(%rsp)
.L422:
	movl	$1, 40(%rsp)
	jmp	.L202
.L298:
	xorl	%eax, %eax
	movl	$1, 64(%rsp)
	xorl	%edx, %edx
	movq	%rax, 32(%rsp)
	xorl	%eax, %eax
	movl	%eax, 28(%rsp)
	movl	%eax, 68(%rsp)
	xorl	%eax, %eax
	movl	%eax, 60(%rsp)
	movl	%eax, 56(%rsp)
	movl	%eax, 52(%rsp)
	xorl	%eax, %eax
	movl	%eax, 92(%rsp)
	xorl	%eax, %eax
	movl	$1, 44(%rsp)
	movl	$1, 88(%rsp)
	movl	$1, 84(%rsp)
	movl	%eax, 80(%rsp)
	movl	%eax, 48(%rsp)
	movl	%eax, 40(%rsp)
	movl	%eax, 24(%rsp)
	movl	%eax, 12(%rsp)
	movl	%eax, (%rsp)
	movl	%eax, 8(%rsp)
.L200:
	cmpl	$0, g_strict(%rip)
	jne	.L326
	cmpl	$16, 28(%rsp)
	jne	.L220
.L326:
	xorl	%r15d, %r15d
	movl	%r15d, 44(%rsp)
	jmp	.L220
.L225:
	subq	$1, %rax
	je	.L321
	cmpq	$0, 32(%rsp)
	jne	.L434
.L321:
	leaq	240(%rsp), %r15
	movq	32(%rsp), %r14
	xorl	%r13d, %r13d
	movq	%r15, 16(%rsp)
	.p2align 4,,10
	.p2align 3
.L228:
	testq	%r14, %r14
	je	.L229
	movq	%r14, %rdi
	call	sdup@PLT
	movq	%rax, %rbx
.L230:
	movq	280(%rsp), %r12
	testq	%r12, %r12
	je	.L234
	movq	272(%rsp), %r15
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L236:
	movq	(%r15,%rbp,8), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L435
	addq	$1, %rbp
	cmpq	%r12, %rbp
	jne	.L236
.L234:
	movq	16(%rsp), %r12
	movq	%rbx, %rdi
	addq	$1, %r13
	movq	%r12, %rsi
	call	protect_input
	leaq	272(%rsp), %rdi
	movq	%rbx, %rsi
	call	vec_push@PLT
	cmpq	248(%rsp), %r13
	jb	.L228
	cmpq	$0, 32(%rsp)
	jne	.L237
	leaq	.LC42(%rip), %rax
	movq	%rax, 32(%rsp)
	jmp	.L237
.L428:
	cmpb	$103, 1(%r14)
	jne	.L331
	cmpb	$0, 2(%r14)
	jne	.L331
	movl	$1, 80(%rsp)
	jmp	.L202
	.p2align 4,,10
	.p2align 3
.L229:
	movq	240(%rsp), %rax
	movl	$47, %esi
	movq	(%rax,%r13,8), %r12
	movq	%r12, %rdi
	call	strrchr@PLT
	movl	$46, %esi
	leaq	1(%rax), %rdx
	testq	%rax, %rax
	cmovne	%rdx, %r12
	movq	%r12, %rdi
	call	strrchr@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L232
	cmpq	%rax, %r12
	je	.L232
	subq	%r12, %rbp
.L233:
	leaq	3(%rbp), %rdi
	call	xmalloc@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movl	$28462, %r12d
	movq	%rax, %rbx
	movq	%rax, %rdi
	call	memcpy@PLT
	addq	%rbx, %rbp
	movw	%r12w, 0(%rbp)
	movb	$0, 2(%rbp)
	jmp	.L230
.L232:
	movq	%r12, %rdi
	call	strlen@PLT
	movq	%rax, %rbp
	jmp	.L233
.L431:
	cmpl	$0, (%rsp)
	movq	%rax, %rdx
	je	.L264
	cmpq	$1, %rax
	ja	.L296
	movq	240(%rsp), %rax
	xorl	%r9d, %r9d
	leaq	304(%rsp), %rsi
	leaq	144(%rsp), %r13
	leaq	336(%rsp), %r12
	movq	(%rax), %rbp
	movq	%r9, 304(%rsp)
	movq	%rbp, %rdi
	call	read_file_all
	movl	$28, %ecx
	movq	%rbp, %r8
	xorl	%esi, %esi
	movq	%rax, %rbx
	leaq	352(%rsp), %rdx
	movl	8(%rsp), %eax
	movl	28(%rsp), %r15d
	movq	%rdx, %rdi
	movl	$1, %edx
	rep stosl
	movq	304(%rsp), %rax
	movl	$1, %ecx
	movq	%r13, %rdi
	movl	%r15d, 448(%rsp)
	movq	%rax, 344(%rsp)
	movq	.LC26(%rip), %rax
	movq	%rbx, 336(%rsp)
	movq	%rax, 360(%rsp)
	movq	%rbp, 368(%rsp)
	movq	%rbx, 440(%rsp)
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
	movl	44(%rsp), %ecx
	movl	%r15d, %r9d
	movq	%rbp, %rdx
	movq	stdout(%rip), %rdi
	movl	$1, %r8d
	movq	%r12, %rsi
	call	emit_program_c@PLT
.L270:
	movq	%rbx, %rdi
	call	free@PLT
.L423:
	movq	g_compilation_arena(%rip), %rdi
	xorl	%ebp, %ebp
	call	arena_free@PLT
	xorl	%edi, %edi
	movq	%rdi, g_compilation_arena(%rip)
	jmp	.L199
.L238:
	movl	56(%rsp), %eax
	xorl	$1, %eax
	orl	60(%rsp), %eax
	je	.L242
	leaq	304(%rsp), %rax
	xorl	%r15d, %r15d
	movq	%r12, 136(%rsp)
	movq	%rax, 72(%rsp)
	leaq	336(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	352(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	376(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	%r15, 16(%rsp)
.L244:
	movq	16(%rsp), %rdx
	movq	240(%rsp), %rax
	movq	72(%rsp), %rsi
	movq	(%rax,%rdx,8), %rbx
	movq	$0, 304(%rsp)
	movq	%rbx, %rdi
	call	read_file_all
	movq	120(%rsp), %rdi
	movq	%rbx, %r8
	xorl	%esi, %esi
	movq	%rax, %rbp
	movl	$14, %ecx
	xorl	%eax, %eax
	movl	$1, %edx
	rep stosq
	movl	28(%rsp), %eax
	movq	104(%rsp), %rdi
	movl	$1, %ecx
	movq	%rbx, 368(%rsp)
	movl	%eax, 448(%rsp)
	movq	304(%rsp), %rax
	movq	%rbp, 336(%rsp)
	movq	%rax, 344(%rsp)
	movq	.LC26(%rip), %rax
	movq	%rbp, 440(%rsp)
	movq	%rax, 360(%rsp)
	call	mk_tok@PLT
	movq	112(%rsp), %rbx
	movdqu	144(%rsp), %xmm1
	movdqu	160(%rsp), %xmm2
	movq	192(%rsp), %rax
	movdqu	176(%rsp), %xmm3
	movq	%rbx, %rdi
	movups	%xmm1, 376(%rsp)
	movups	%xmm2, 392(%rsp)
	movups	%xmm3, 408(%rsp)
	movq	%rax, 424(%rsp)
	call	next@PLT
	movq	%rbx, %rdi
	xorl	%ebx, %ebx
	call	parse_program_ast@PLT
	movq	128(%rsp), %rdi
	movq	%rax, %r15
	call	tok_free@PLT
	cmpq	$0, 8(%r15)
	je	.L260
	movq	%rbp, 96(%rsp)
	movq	%r15, %rbp
	movq	%rbx, %r15
	jmp	.L243
	.p2align 4,,10
	.p2align 3
.L246:
	cmpl	$2, %eax
	je	.L436
.L253:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L437
.L243:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rcx
	movl	(%rcx), %eax
	cmpl	$1, %eax
	jne	.L246
	movq	8(%rcx), %rax
	movq	8+g_known_variables(%rip), %r13
	movq	(%rax), %r14
	leaq	g_known_variables(%rip), %rax
	movq	(%rax), %r12
	testq	%r13, %r13
	je	.L247
	xorl	%ebx, %ebx
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L438:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L247
.L249:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L438
.L255:
	movq	%r14, %rsi
	leaq	.LC120(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L262:
	movq	%rbx, %rdi
	call	unlink@PLT
	jmp	.L263
.L242:
	cmpl	$0, 8(%rsp)
	jne	.L295
	cmpl	$0, (%rsp)
	movq	248(%rsp), %rdx
	jne	.L296
.L264:
	cmpl	$0, 24(%rsp)
	je	.L267
	cmpq	$1, %rdx
	ja	.L439
	movq	240(%rsp), %rax
	xorl	%r8d, %r8d
	leaq	304(%rsp), %rsi
	leaq	144(%rsp), %r13
	leaq	336(%rsp), %r12
	movq	(%rax), %rbp
	movq	%r8, 304(%rsp)
	movq	%rbp, %rdi
	call	read_file_all
	movl	$28, %ecx
	movq	%rbp, %r8
	xorl	%esi, %esi
	leaq	352(%rsp), %rdx
	movq	%rax, %rbx
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	rep stosl
	movl	28(%rsp), %eax
	movq	%r13, %rdi
	movl	$1, %ecx
	movq	%rbx, 336(%rsp)
	movl	%eax, 448(%rsp)
	movq	304(%rsp), %rax
	movq	%rbp, 368(%rsp)
	movq	%rax, 344(%rsp)
	movq	.LC26(%rip), %rax
	movq	%rbx, 440(%rsp)
	movq	%rax, 360(%rsp)
	call	mk_tok@PLT
	movq	%r13, %rsi
	movl	$14, %ecx
	leaq	376(%rsp), %rdi
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
	movq	32(%rsp), %rdi
	leaq	.LC31(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L440
	movl	28(%rsp), %r9d
	movl	44(%rsp), %ecx
	movq	%rbp, %rdx
	movq	%rax, %rdi
	movl	$1, %r8d
	movq	%r12, %rsi
	call	emit_program_c@PLT
	movq	%r13, %rdi
	call	ferror@PLT
	movq	%r13, %rdi
	movl	%eax, %ebp
	call	fclose@PLT
	testl	%ebp, %ebp
	jne	.L327
	addl	$1, %eax
	jne	.L270
.L327:
	movq	32(%rsp), %rsi
	leaq	.LC36(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L306:
	movl	$1, 84(%rsp)
	jmp	.L202
.L267:
	movl	24(%rsp), %eax
	leaq	304(%rsp), %rdi
	movl	$6, %ecx
	xorl	%r14d, %r14d
	movq	%rdi, 72(%rsp)
	leaq	.LC35(%rip), %r15
	rep stosl
	testq	%rdx, %rdx
	je	.L279
	movq	%r12, (%rsp)
	movl	68(%rsp), %r13d
	jmp	.L272
.L442:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rbx
	movq	%rbx, %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L276
	movq	%r15, %rcx
	movq	%rbx, %rdx
	movq	%r12, %r8
	movq	%rax, %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	call	__sprintf_chk@PLT
	movq	(%rsp), %rsi
	movq	%rbp, %rdi
	call	protect_input
	movq	%r12, %rdi
	movl	$1, %edx
	pushq	%rcx
	.cfi_def_cfa_offset 552
	movl	72(%rsp), %eax
	movl	%r13d, %ecx
	pushq	%rax
	.cfi_def_cfa_offset 560
	movl	44(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 568
	pushq	%rbp
	.cfi_def_cfa_offset 576
	pushq	$1
	.cfi_def_cfa_offset 584
	movl	100(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 592
	movl	104(%rsp), %r9d
	movl	100(%rsp), %r8d
	movl	92(%rsp), %esi
	call	compile_b_to_c
	addq	$48, %rsp
	.cfi_def_cfa_offset 544
	movq	%rbp, %rdi
	movq	%rax, %rbx
	call	free@PLT
.L294:
	testq	%rbx, %rbx
	je	.L423
	movq	72(%rsp), %rdi
	movq	%rbx, %rsi
	call	vec_push@PLT
	testl	%r13d, %r13d
	jne	.L441
.L278:
	addq	$1, %r14
	cmpq	248(%rsp), %r14
	jnb	.L279
.L272:
	movq	240(%rsp), %rax
	movl	48(%rsp), %esi
	movq	(%rax,%r14,8), %r12
	testl	%esi, %esi
	jne	.L442
	pushq	%rax
	.cfi_def_cfa_offset 552
	movl	72(%rsp), %eax
	movl	%r13d, %ecx
	movl	$1, %edx
	movq	%r12, %rdi
	pushq	%rax
	.cfi_def_cfa_offset 560
	movl	44(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 568
	pushq	$0
	.cfi_def_cfa_offset 576
	pushq	$0
	.cfi_def_cfa_offset 584
	movl	100(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 592
	movl	104(%rsp), %r9d
	movl	100(%rsp), %r8d
	movl	92(%rsp), %esi
	call	compile_b_to_c
	addq	$48, %rsp
	.cfi_def_cfa_offset 544
	movq	%rax, %rbx
	jmp	.L294
	.p2align 4,,10
	.p2align 3
.L247:
	movq	8+g_known_functions(%rip), %r13
	movq	g_known_functions(%rip), %r12
	testq	%r13, %r13
	je	.L250
	xorl	%ebx, %ebx
	jmp	.L252
	.p2align 4,,10
	.p2align 3
.L443:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L250
.L252:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L443
	movq	%r14, %rsi
	leaq	.LC121(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L250:
	movq	%r14, %rdi
	addq	$1, %r15
	call	sdup@PLT
	leaq	g_known_functions(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpq	8(%rbp), %r15
	jb	.L243
.L437:
	movq	96(%rsp), %rbp
.L260:
	movq	%rbp, %rdi
	call	free@PLT
	addq	$1, 16(%rsp)
	movq	16(%rsp), %rax
	cmpq	248(%rsp), %rax
	jb	.L244
	movq	136(%rsp), %r12
	jmp	.L245
	.p2align 4,,10
	.p2align 3
.L436:
	movq	8(%rcx), %rax
	movq	8+g_known_functions(%rip), %r13
	movq	g_known_functions(%rip), %r12
	movq	16(%rax), %r14
	testq	%r13, %r13
	je	.L254
	xorl	%ebx, %ebx
	jmp	.L256
	.p2align 4,,10
	.p2align 3
.L444:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L254
.L256:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L444
	jmp	.L255
	.p2align 4,,10
	.p2align 3
.L254:
	movq	8+g_known_variables(%rip), %r13
	leaq	g_known_variables(%rip), %rax
	movq	(%rax), %r12
	testq	%r13, %r13
	je	.L257
	xorl	%ebx, %ebx
	jmp	.L259
	.p2align 4,,10
	.p2align 3
.L445:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L257
.L259:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L445
	movq	%r14, %rsi
	leaq	.LC122(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4,,10
	.p2align 3
.L257:
	movq	%r14, %rdi
	call	sdup@PLT
	leaq	g_known_variables(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L253
.L441:
	movq	stderr(%rip), %rdi
	movq	%rbx, %r8
	movq	%r12, %rcx
	xorl	%eax, %eax
	leaq	.LC129(%rip), %rdx
	movl	$2, %esi
	call	__fprintf_chk@PLT
	jmp	.L278
.L430:
	leaq	.LC42(%rip), %rax
	movq	%rax, 32(%rsp)
	jmp	.L227
.L429:
	movq	stderr(%rip), %rdi
	leaq	.LC76(%rip), %rdx
	movl	$2, %esi
	leaq	.LC22(%rip), %rbx
	movl	$2, %ebp
	call	__fprintf_chk@PLT
	movq	(%r12), %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	leaq	.LC77(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%rbx, %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC78(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	(%r12), %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	leaq	.LC79(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%rbx, %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC80(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC81(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC82(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC83(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC84(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC85(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC86(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC87(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC88(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC89(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC90(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC91(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC92(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC93(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC94(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC95(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC96(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC97(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC98(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC99(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC100(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	%rbx, %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC101(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC102(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC103(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	%rbx, %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC104(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movl	$2, %esi
	xorl	%eax, %eax
	xorl	%r14d, %r14d
	movq	stderr(%rip), %rdi
	leaq	.LC105(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC106(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC107(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC108(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC109(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC110(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC111(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC112(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	%rbx, %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC113(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC114(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC115(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC116(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC117(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	movq	%r14, g_compilation_arena(%rip)
	jmp	.L199
.L307:
	xorl	%edi, %edi
	movl	%edi, 84(%rsp)
	jmp	.L202
.L308:
	movl	$1, 88(%rsp)
	jmp	.L202
.L435:
	movq	%rbx, %rsi
	leaq	.LC119(%rip), %rdi
	call	dief@PLT
.L279:
	cmpl	$0, 68(%rsp)
	jne	.L446
.L274:
	xorl	%ebx, %ebx
	cmpl	$0, 12(%rsp)
	jne	.L424
	jmp	.L417
.L284:
	movq	304(%rsp), %rax
	movups	%xmm0, 344(%rsp)
	movl	$1, %edx
	leaq	336(%rsp), %rdi
	leaq	(%rax,%rbx,8), %rax
	movq	%rax, 336(%rsp)
	movq	272(%rsp), %rax
	movq	(%rax,%rbx,8), %rsi
	movl	68(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 552
	movl	36(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 560
	movl	60(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 568
	movl	88(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 576
	leaq	240(%rsp), %rax
	pushq	%rax
	.cfi_def_cfa_offset 584
	movl	132(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 592
	movl	136(%rsp), %r9d
	movl	132(%rsp), %r8d
	movl	128(%rsp), %ecx
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 544
	testl	%eax, %eax
	jne	.L283
	addq	$1, %rbx
.L424:
	movdqa	.LC131(%rip), %xmm0
	cmpq	312(%rsp), %rbx
	jb	.L284
.L285:
	xorl	%ebx, %ebx
	leaq	.LC135(%rip), %r12
	jmp	.L292
.L290:
	cmpl	$0, 68(%rsp)
	jne	.L447
.L291:
	movq	%rbp, %rdi
	addq	$1, %rbx
	call	free@PLT
.L292:
	cmpq	312(%rsp), %rbx
	jnb	.L423
	movq	304(%rsp), %rax
	cmpl	$0, 40(%rsp)
	movq	(%rax,%rbx,8), %rbp
	jne	.L290
	movq	%rbp, %rdi
	call	unlink@PLT
	jmp	.L291
.L447:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rcx
	movq	%r12, %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	jmp	.L291
.L309:
	xorl	%esi, %esi
	movl	%esi, 88(%rsp)
	jmp	.L202
.L310:
	movl	$1, 92(%rsp)
	jmp	.L202
.L446:
	movq	312(%rsp), %rcx
	movq	stderr(%rip), %rdi
	leaq	.LC130(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	jmp	.L274
.L417:
	movl	68(%rsp), %eax
	xorl	%edx, %edx
	pushq	%rax
	.cfi_def_cfa_offset 552
	movl	36(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 560
	movl	60(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 568
	movl	88(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 576
	leaq	240(%rsp), %rax
	pushq	%rax
	.cfi_def_cfa_offset 584
	movl	132(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 592
	movl	136(%rsp), %r9d
	movl	132(%rsp), %r8d
	movl	128(%rsp), %ecx
	movq	80(%rsp), %rsi
	movq	120(%rsp), %rdi
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 544
	testl	%eax, %eax
	je	.L285
.L283:
	movq	stderr(%rip), %rdi
	movl	%eax, %ecx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC132(%rip), %rdx
	call	__fprintf_chk@PLT
	cmpl	$0, 40(%rsp)
	je	.L286
.L289:
	movq	g_compilation_arena(%rip), %rdi
	movl	$1, %ebp
	call	arena_free@PLT
	xorl	%edx, %edx
	movq	%rdx, g_compilation_arena(%rip)
	jmp	.L199
.L312:
	xorl	%ecx, %ecx
	movl	$1, 16(%rsp)
	movl	%ecx, 44(%rsp)
	jmp	.L202
.L311:
	movl	$1, 16(%rsp)
	movl	$1, 44(%rsp)
	jmp	.L202
.L314:
	movl	$32, 28(%rsp)
	jmp	.L202
.L313:
	movl	$16, 28(%rsp)
	jmp	.L202
.L206:
	leaq	.LC55(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L207
	movl	$1, g_strict(%rip)
	xorl	%r8d, %r8d
	movl	%r8d, g_extensions(%rip)
	jmp	.L202
.L432:
	call	__stack_chk_fail@PLT
.L440:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	32(%rsp), %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
.L439:
	leaq	.LC128(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L276:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L286:
	movq	stderr(%rip), %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	xorl	%ebx, %ebx
	leaq	.LC133(%rip), %rdx
	leaq	.LC134(%rip), %rbp
	call	__fprintf_chk@PLT
	jmp	.L287
.L288:
	movq	304(%rsp), %rax
	movq	stderr(%rip), %rdi
	movq	%rbp, %rdx
	movl	$2, %esi
	movq	(%rax,%rbx,8), %rcx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	__fprintf_chk@PLT
.L287:
	cmpq	312(%rsp), %rbx
	jb	.L288
	jmp	.L289
.L295:
	leaq	.LC123(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L296:
	leaq	.LC127(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L434:
	leaq	.LC118(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L207:
	leaq	.LC56(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L208
	movl	$1, g_pedantic(%rip)
	jmp	.L202
.L208:
	leaq	.LC57(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L315
	leaq	.LC58(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L316
	leaq	.LC59(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L317
	leaq	.LC60(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L202
	leaq	.LC61(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L318
	leaq	.LC62(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L319
	leaq	.LC63(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L320
	leaq	.LC18(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L209
	addl	$1, %r15d
	cmpl	%r13d, %r15d
	jge	.L448
	movq	8(%r12,%rbx), %rax
	movq	%rax, 32(%rsp)
	jmp	.L202
.L315:
	movl	$1, 52(%rsp)
	jmp	.L202
.L448:
	leaq	.LC64(%rip), %rdi
	call	dief@PLT
.L209:
	leaq	.LC65(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L211
	addl	$1, %r15d
	cmpl	%r13d, %r15d
	jge	.L449
	movq	8(%r12,%rbx), %rbx
	leaq	.LC67(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L213
	leaq	.LC68(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L213
	leaq	.LC69(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L213
	leaq	.LC70(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L213
	leaq	.LC71(%rip), %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L214
.L213:
	movl	$1, g_use_curses(%rip)
.L214:
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rsi
	movq	%rsi, %rdi
	movq	%rsi, 96(%rsp)
	call	malloc@PLT
	movq	96(%rsp), %rsi
	testq	%rax, %rax
	movq	%rax, %r14
	je	.L276
	movq	%rsi, %rcx
	movq	%rax, %rdi
	movq	%rbx, %r9
	movl	$2, %edx
	leaq	.LC72(%rip), %r8
	xorl	%eax, %eax
	call	__snprintf_chk@PLT
	leaq	208(%rsp), %rax
	movq	%r14, %rsi
	movq	%rax, %rdi
	call	vec_push@PLT
	jmp	.L202
.L449:
	leaq	.LC66(%rip), %rdi
	call	dief@PLT
.L320:
	xorl	%edx, %edx
	movl	%edx, 64(%rsp)
	jmp	.L202
.L211:
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L216
	addl	$1, %r15d
	cmpl	%r13d, %r15d
	jge	.L450
	movq	8(%r12,%rbx), %rdi
	call	sdup@PLT
	leaq	208(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L202
.L319:
	movl	$1, 68(%rsp)
	jmp	.L202
.L318:
	movl	$1, 72(%rsp)
	jmp	.L202
.L317:
	movl	$1, 60(%rsp)
	jmp	.L202
.L316:
	movl	$1, 56(%rsp)
	jmp	.L202
.L450:
	leaq	.LC74(%rip), %rdi
	call	dief@PLT
.L216:
	cmpb	$45, (%r14)
	je	.L451
	leaq	240(%rsp), %rdi
	movq	%r14, %rsi
	call	vec_push@PLT
	jmp	.L202
.L451:
	movq	%r14, %rsi
	leaq	.LC75(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE58:
	.size	run_main, .-run_main
	.section	.rodata.str1.1
.LC137:
	.string	"cannot write standard output"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB59:
	.cfi_startproc
	endbr64
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
	movl	%eax, %ebp
	call	ferror@PLT
	movq	stdout(%rip), %rdi
	movl	%eax, %ebx
	call	fflush@PLT
	testl	%ebx, %ebx
	jne	.L455
	cmpl	$-1, %eax
	je	.L455
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	%ebp, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L455:
	.cfi_restore_state
	leaq	.LC137(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE59:
	.size	main, .-main
	.local	g_libb_dir
	.comm	g_libb_dir,4096,32
	.section	.data.rel.ro.local,"aw"
	.align 8
.LC24:
	.quad	.LC9
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
	.align 16
.LC131:
	.quad	1
	.quad	1
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
