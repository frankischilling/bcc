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
.LFB14:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$4095, %edx
	subq	$8208, %rsp
	.cfi_def_cfa_offset 8224
	movq	%fs:40, %rbx
	movq	%rbx, 8200(%rsp)
	movq	%rdi, %rbx
	movq	%rsp, %rsi
	leaq	.LC0(%rip), %rdi
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
	movq	8200(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L14
	addq	$8208, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
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
	leaq	4096(%rsp), %rdi
	jmp	.L10
.L14:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE14:
	.size	init_libb_path, .-init_libb_path
	.section	.rodata.str1.1
.LC2:
	.string	"rb"
.LC3:
	.string	"cannot open '%s': %s"
.LC4:
	.string	"fseek failed"
.LC5:
	.string	"ftell failed"
.LC6:
	.string	"out of memory"
.LC7:
	.string	"read failed for '%s'"
	.text
	.p2align 4
	.globl	read_file_all
	.type	read_file_all, @function
read_file_all:
.LFB15:
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
	leaq	.LC2(%rip), %rsi
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
	je	.L33
.L16:
	xorl	%esi, %esi
	movl	$2, %edx
	movq	%rbx, %rdi
	call	fseek@PLT
	testl	%eax, %eax
	jne	.L34
	movq	%rbx, %rdi
	call	ftell@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	js	.L35
.L18:
	xorl	%edx, %edx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	fseek@PLT
	testl	%eax, %eax
	jne	.L36
.L19:
	leaq	1(%rbp), %rdi
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L37
.L20:
	movq	%r12, %rdi
	movq	%rbx, %rcx
	movq	%rbp, %rdx
	movl	$1, %esi
	call	fread@PLT
	movq	%rbx, %rdi
	movq	%rax, %r15
	call	fclose@PLT
	cmpq	%r15, %rbp
	je	.L21
	movq	%r14, %rsi
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L21:
	movb	$0, (%r12,%rbp)
	testq	%r13, %r13
	je	.L15
	movq	%rbp, 0(%r13)
.L15:
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
.L36:
	.cfi_restore_state
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L34:
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	%rbx, %rdi
	call	ftell@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jns	.L18
.L35:
	leaq	.LC5(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L18
.L33:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%r14, %rsi
	leaq	.LC3(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L16
.L37:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L20
	.cfi_endproc
.LFE15:
	.size	read_file_all, .-read_file_all
	.section	.rodata.str1.1
.LC8:
	.string	"gcc"
.LC9:
	.string	"-std=c99"
.LC10:
	.string	"%s/runtime.o"
.LC11:
	.string	"%s/runtime.o"
.LC12:
	.string	"libb.c not found at %s"
.LC13:
	.string	"-O2"
.LC14:
	.string	"-c"
.LC15:
	.string	"-o"
.LC16:
	.string	"Compiling runtime library...\n"
.LC17:
	.string	"-I%s"
.LC18:
	.string	"-DB_BYTEPTR=%d"
.LC19:
	.string	"-DWORD_BITS=%d"
.LC20:
	.string	"fork failed"
.LC21:
	.string	"Failed to compile libb.c"
.LC22:
	.string	"-Wall"
.LC23:
	.string	"-Wextra"
.LC24:
	.string	"-Werror"
.LC25:
	.string	"-g"
.LC26:
	.string	"-ldl"
.LC27:
	.string	"-lm"
.LC28:
	.string	"Running:"
.LC29:
	.string	" %s"
	.text
	.p2align 4
	.globl	run_gcc_multi
	.type	run_gcc_multi, @function
run_gcc_multi:
.LFB19:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC9(%rip), %rax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rax, %xmm2
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
	movl	%edx, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8840, %rsp
	.cfi_def_cfa_offset 8896
	movq	.LC30(%rip), %xmm1
	movl	8912(%rsp), %eax
	movq	%rsi, 40(%rsp)
	movl	%ecx, 24(%rsp)
	punpcklqdq	%xmm2, %xmm1
	testl	%eax, %eax
	movl	%r8d, 28(%rsp)
	setne	%dl
	movl	%r9d, 32(%rsp)
	testl	%ebp, %ebp
	sete	%al
	andb	%al, %dl
	movq	%fs:40, %rbx
	movq	%rbx, 8824(%rsp)
	movq	8904(%rsp), %rbx
	movb	%dl, 39(%rsp)
	movaps	%xmm1, (%rsp)
	jne	.L129
	movq	$0, 48(%rsp)
	leaq	g_libb_dir(%rip), %r13
	leaq	4720(%rsp), %r14
	leaq	.LC17(%rip), %r15
.L39:
	movq	%r15, %rdx
	movq	%r13, %rcx
	movl	$4096, %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	8(%r12), %r15
	xorl	%eax, %eax
	testq	%rbx, %rbx
	je	.L48
	movq	8(%rbx), %rax
.L48:
	leaq	40(%r15,%rax), %rdi
	salq	$3, %rdi
	call	malloc@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L130
.L49:
	movdqa	(%rsp), %xmm3
	movups	%xmm3, 0(%r13)
	testl	%ebp, %ebp
	jne	.L80
	leaq	.LC13(%rip), %rax
	movl	$4, %edx
	movl	$3, %edi
	movq	%rax, 16(%r13)
	movl	$24, %eax
.L50:
	movl	28(%rsp), %r10d
	testl	%r10d, %r10d
	je	.L51
	leaq	.LC22(%rip), %rsi
	leal	2(%rdi), %ecx
	movl	%edx, %edi
	movq	%rsi, 0(%r13,%rax)
	movl	%edx, %eax
	movl	%ecx, %edx
	salq	$3, %rax
.L51:
	movl	32(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L52
	leaq	.LC23(%rip), %rsi
	leal	2(%rdi), %ecx
	movl	%edx, %edi
	movq	%rsi, 0(%r13,%rax)
	movl	%edx, %eax
	movl	%ecx, %edx
	salq	$3, %rax
.L52:
	movl	8896(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L53
	leaq	.LC24(%rip), %rsi
	leal	2(%rdi), %ecx
	movl	%edx, %edi
	movq	%rsi, 0(%r13,%rax)
	movl	%edx, %eax
	movl	%ecx, %edx
	salq	$3, %rax
.L53:
	movl	24(%rsp), %esi
	testl	%esi, %esi
	je	.L54
	leaq	.LC25(%rip), %rsi
	leal	2(%rdi), %ecx
	movl	%edx, %edi
	movq	%rsi, 0(%r13,%rax)
	movl	%edx, %eax
	movl	%ecx, %edx
	salq	$3, %rax
.L54:
	movl	8912(%rsp), %ecx
	testl	%ecx, %ecx
	je	.L55
	leal	2(%rdi), %ecx
	movq	%r14, 0(%r13,%rax)
	movl	%edx, %eax
	movl	%edx, %edi
	salq	$3, %rax
	movl	%ecx, %edx
.L55:
	addq	%r13, %rax
	testl	%ebp, %ebp
	je	.L56
	leaq	.LC14(%rip), %rsi
	movq	%rsi, (%rax)
	testq	%r15, %r15
	je	.L131
.L57:
	movl	%edx, %eax
	movq	(%r12), %r8
	leaq	0(%r13,%rax,8), %rdi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L64:
	movq	(%r8,%rax,8), %rcx
	movq	%rcx, (%rdi,%rax,8)
	addq	$1, %rax
	cmpq	%r15, %rax
	jne	.L64
	addl	%eax, %edx
	cmpb	$0, 39(%rsp)
	je	.L65
.L58:
	movq	48(%rsp), %rsi
	movl	%edx, %eax
	addl	$1, %edx
	movq	%rsi, 0(%r13,%rax,8)
	testq	%rbx, %rbx
	je	.L63
.L66:
	movq	8(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L67
.L60:
	movl	%edx, %eax
	movq	(%rbx), %r8
	leaq	0(%r13,%rax,8), %rdi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L68:
	movq	(%r8,%rax,8), %rcx
	movq	%rcx, (%rdi,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %rsi
	jne	.L68
	addl	%esi, %edx
.L67:
	testl	%ebp, %ebp
	je	.L63
.L61:
	movq	$0, 0(%r13,%rdx,8)
	movl	8936(%rsp), %eax
	testl	%eax, %eax
	jne	.L132
	call	fork@PLT
	testl	%eax, %eax
	js	.L133
.L72:
	je	.L134
	movl	%eax, %edi
	leaq	108(%rsp), %rsi
	xorl	%edx, %edx
	movl	$0, 108(%rsp)
	call	waitpid@PLT
	movq	%r13, %rdi
	testl	%eax, %eax
	js	.L135
	call	free@PLT
	movl	108(%rsp), %eax
	testb	$127, %al
	je	.L136
.L73:
	movl	$1, %eax
.L38:
	movq	8824(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L137
	addq	$8840, %rsp
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
.L56:
	.cfi_restore_state
	leaq	.LC15(%rip), %rsi
	movl	%edx, %ecx
	leal	2(%rdi), %edx
	movq	%rsi, (%rax)
	movq	40(%rsp), %rax
	movq	%rax, 0(%r13,%rcx,8)
	testq	%r15, %r15
	jne	.L57
	cmpb	$0, 39(%rsp)
	jne	.L58
	testq	%rbx, %rbx
	je	.L63
	movq	8(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L60
	.p2align 4
	.p2align 3
.L63:
	movq	.LC34(%rip), %xmm0
	leaq	.LC27(%rip), %rcx
	movl	%edx, %eax
	addl	$2, %edx
	movq	%rcx, %xmm7
	punpcklqdq	%xmm7, %xmm0
	movups	%xmm0, 0(%r13,%rax,8)
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L80:
	movl	$3, %edx
	movl	$16, %eax
	movl	$2, %edi
	jmp	.L50
	.p2align 4,,10
	.p2align 3
.L65:
	testq	%rbx, %rbx
	jne	.L66
	jmp	.L67
	.p2align 4,,10
	.p2align 3
.L136:
	movzbl	%ah, %eax
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L129:
	leaq	g_libb_dir(%rip), %r13
	movl	$4096, %esi
	xorl	%eax, %eax
	movq	%r13, %rcx
	leaq	.LC10(%rip), %rdx
	leaq	624(%rsp), %rdi
	call	snprintf@PLT
	xorl	%eax, %eax
	movq	%r13, %rcx
	movl	$4096, %esi
	leaq	libb_o_path.0(%rip), %rdi
	leaq	.LC11(%rip), %rdx
	call	snprintf@PLT
	movl	$4, %esi
	leaq	624(%rsp), %rdi
	call	access@PLT
	testl	%eax, %eax
	jne	.L138
.L40:
	leaq	208(%rsp), %rsi
	leaq	624(%rsp), %rdi
	call	stat@PLT
	testl	%eax, %eax
	je	.L139
.L41:
	leaq	496(%rsp), %rax
	movl	8936(%rsp), %r15d
	leaq	4720(%rsp), %r14
	movq	.LC31(%rip), %xmm6
	movq	%rax, 48(%rsp)
	leaq	560(%rsp), %rax
	movq	%r14, %xmm4
	movhps	.LC32(%rip), %xmm6
	movq	%rax, %xmm5
	movhps	48(%rsp), %xmm4
	movaps	%xmm6, 80(%rsp)
	leaq	624(%rsp), %rax
	movq	%rax, 64(%rsp)
	movhps	64(%rsp), %xmm5
	movaps	%xmm4, 48(%rsp)
	movaps	%xmm5, 64(%rsp)
	testl	%r15d, %r15d
	jne	.L140
.L43:
	leaq	.LC17(%rip), %r15
	movq	%r13, %rcx
	movq	%r14, %rdi
	xorl	%eax, %eax
	movq	%r15, %rdx
	movl	$4096, %esi
	call	snprintf@PLT
	movl	8920(%rsp), %r11d
	xorl	%ecx, %ecx
	leaq	.LC18(%rip), %rdx
	movl	$64, %esi
	leaq	496(%rsp), %rdi
	testl	%r11d, %r11d
	setne	%cl
	xorl	%eax, %eax
	call	snprintf@PLT
	movl	8928(%rsp), %ecx
	xorl	%eax, %eax
	leaq	.LC19(%rip), %rdx
	movl	$64, %esi
	leaq	560(%rsp), %rdi
	call	snprintf@PLT
	movdqa	(%rsp), %xmm7
	movq	.LC33(%rip), %xmm0
	leaq	.LC14(%rip), %rax
	movdqa	48(%rsp), %xmm5
	movdqa	64(%rsp), %xmm6
	movq	%rax, %xmm4
	movq	$0, 192(%rsp)
	movaps	%xmm7, 112(%rsp)
	movdqa	80(%rsp), %xmm7
	punpcklqdq	%xmm4, %xmm0
	movaps	%xmm0, 128(%rsp)
	movaps	%xmm5, 144(%rsp)
	movaps	%xmm6, 160(%rsp)
	movaps	%xmm7, 176(%rsp)
	call	fork@PLT
	movl	%eax, %ecx
	testl	%eax, %eax
	js	.L141
	je	.L142
.L45:
	xorl	%edx, %edx
	leaq	108(%rsp), %rsi
	movl	%ecx, %edi
	movl	$0, 108(%rsp)
	call	waitpid@PLT
	testl	%eax, %eax
	js	.L46
	testw	$-129, 108(%rsp)
	je	.L42
.L46:
	leaq	.LC21(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L42:
	leaq	libb_o_path.0(%rip), %rax
	movq	%rax, 48(%rsp)
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L132:
	movq	stderr(%rip), %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC28(%rip), %rdi
	call	fwrite@PLT
	movq	0(%r13), %rdx
	testq	%rdx, %rdx
	je	.L70
	leaq	8(%r13), %rbx
	.p2align 4
	.p2align 3
.L71:
	movq	stderr(%rip), %rdi
	leaq	.LC29(%rip), %rsi
	xorl	%eax, %eax
	addq	$8, %rbx
	call	fprintf@PLT
	movq	-8(%rbx), %rdx
	testq	%rdx, %rdx
	jne	.L71
.L70:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	call	fork@PLT
	testl	%eax, %eax
	jns	.L72
.L133:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L73
	.p2align 4,,10
	.p2align 3
.L135:
	call	free@PLT
	jmp	.L73
.L131:
	cmpb	$0, 39(%rsp)
	jne	.L58
	testq	%rbx, %rbx
	je	.L61
	movq	8(%rbx), %rsi
	testq	%rsi, %rsi
	jne	.L60
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L138:
	leaq	624(%rsp), %rsi
	leaq	.LC12(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L40
	.p2align 4,,10
	.p2align 3
.L139:
	leaq	352(%rsp), %rsi
	leaq	libb_o_path.0(%rip), %rdi
	call	stat@PLT
	testl	%eax, %eax
	jne	.L41
	movq	296(%rsp), %rax
	cmpq	%rax, 440(%rsp)
	jl	.L41
	leaq	4720(%rsp), %r14
	leaq	.LC17(%rip), %r15
	jmp	.L42
	.p2align 4,,10
	.p2align 3
.L140:
	movq	stderr(%rip), %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC16(%rip), %rdi
	call	fwrite@PLT
	jmp	.L43
.L141:
	movl	%eax, 48(%rsp)
	leaq	.LC20(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movl	48(%rsp), %ecx
	jmp	.L45
.L137:
	call	__stack_chk_fail@PLT
.L130:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	8(%r12), %r15
	jmp	.L49
.L142:
	leaq	.LC8(%rip), %rdi
	leaq	112(%rsp), %rsi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
.L134:
	leaq	.LC8(%rip), %rdi
	movq	%r13, %rsi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
	.cfi_endproc
.LFE19:
	.size	run_gcc_multi, .-run_gcc_multi
	.section	.rodata.str1.1
.LC35:
	.string	"Reading %s...\n"
.LC37:
	.string	"Lexing...\n"
.LC38:
	.string	"Parsing...\n"
.LC39:
	.string	"Semantic analysis...\n"
.LC40:
	.string	"Code generation...\n"
.LC41:
	.string	"w"
.LC42:
	.string	"mkstemp failed: %s"
.LC43:
	.string	"wb"
.LC44:
	.string	"fdopen failed"
.LC45:
	.string	"%s.c"
.LC46:
	.string	"rename temp failed: %s"
.LC47:
	.string	"cannot reopen '%s': %s"
.LC48:
	.string	"r"
	.text
	.p2align 4
	.globl	compile_b_to_c
	.type	compile_b_to_c, @function
compile_b_to_c:
.LFB20:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%r9d, %r15d
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
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$232, %rsp
	.cfi_def_cfa_offset 288
	movl	%esi, 8(%rsp)
	movq	304(%rsp), %r13
	movl	%edx, 12(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 216(%rsp)
	xorl	%eax, %eax
	testl	%ecx, %ecx
	jne	.L190
	leaq	72(%rsp), %rsi
	leaq	80(%rsp), %r12
	movq	$0, 72(%rsp)
	call	read_file_all
	pxor	%xmm0, %xmm0
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	movq	%rax, 80(%rsp)
	movq	%rax, %rbp
	movq	72(%rsp), %rax
	movq	%rbx, %r8
	movl	$1, %ecx
	movl	$1, %edx
	movaps	%xmm0, 96(%rsp)
	movq	%rax, 88(%rsp)
	movabsq	$4294967297, %rax
	movaps	%xmm0, 112(%rsp)
	movaps	%xmm0, 160(%rsp)
	movaps	%xmm0, 128(%rsp)
	movaps	%xmm0, 144(%rsp)
	movq	$0, 176(%rsp)
	movq	%rax, 104(%rsp)
	movq	%rbx, 112(%rsp)
	movq	%rbp, 168(%rsp)
	call	mk_tok@PLT
	movdqu	16(%rsp), %xmm0
	movq	%r12, %rdi
	movups	%xmm0, 120(%rsp)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 136(%rsp)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 152(%rsp)
	call	next@PLT
	testl	%r14d, %r14d
	jne	.L166
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	120(%rsp), %rdi
	movq	%rax, %r12
	call	tok_free@PLT
	testl	%r15d, %r15d
	jne	.L191
.L150:
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	sem_check_program@PLT
.L152:
	movl	296(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L153
	testq	%r13, %r13
	je	.L153
	movq	%r13, %rdi
	call	strdup@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L192
.L154:
	leaq	.LC41(%rip), %rsi
	movq	%r13, %rdi
	call	fopen@PLT
	movq	%rax, %r14
	testq	%rax, %rax
	je	.L193
.L156:
	subq	$8, %rsp
	.cfi_def_cfa_offset 296
	movq	%r12, %rsi
	movq	%rbx, %rdx
	movq	%r14, %rdi
	movl	328(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 304
	movl	328(%rsp), %r9d
	movl	28(%rsp), %r8d
	movl	24(%rsp), %ecx
	call	emit_program_c_ext@PLT
	movq	%r14, %rdi
	call	fclose@PLT
	popq	%rcx
	.cfi_def_cfa_offset 296
	popq	%rsi
	.cfi_def_cfa_offset 288
	movl	288(%rsp), %edi
	testl	%edi, %edi
	jne	.L194
.L162:
	movq	%rbp, %rdi
	call	free@PLT
.L143:
	movq	216(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L195
	addq	$232, %rsp
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
.L153:
	.cfi_restore_state
	movdqa	.LC50(%rip), %xmm0
	leaq	192(%rsp), %rdi
	movaps	%xmm0, 192(%rsp)
	call	mkstemp@PLT
	movl	%eax, %r13d
	testl	%eax, %eax
	js	.L196
.L157:
	leaq	.LC43(%rip), %rsi
	movl	%r13d, %edi
	call	fdopen@PLT
	movq	%rax, %r14
	testq	%rax, %rax
	je	.L197
.L158:
	leaq	192(%rsp), %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	malloc@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L198
.L159:
	leaq	.LC45(%rip), %rsi
	leaq	192(%rsp), %rdx
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	%r14, %rdi
	call	fclose@PLT
	movq	%r13, %rsi
	leaq	192(%rsp), %rdi
	call	rename@PLT
	testl	%eax, %eax
	jne	.L199
.L160:
	leaq	.LC41(%rip), %rsi
	movq	%r13, %rdi
	call	fopen@PLT
	movq	%rax, %r14
	testq	%rax, %rax
	jne	.L156
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%r13, %rsi
	leaq	.LC47(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L156
	.p2align 4,,10
	.p2align 3
.L191:
	movq	%r12, %rdi
	call	dump_ast_program@PLT
	movl	288(%rsp), %edx
	testl	%edx, %edx
	jne	.L150
.L165:
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L146
	.p2align 4,,10
	.p2align 3
.L190:
	movq	%rdi, %rdx
	movq	stderr(%rip), %rdi
	leaq	.LC35(%rip), %rsi
	leaq	80(%rsp), %r12
	call	fprintf@PLT
	leaq	72(%rsp), %rsi
	movq	%rbx, %rdi
	movq	$0, 72(%rsp)
	call	read_file_all
	pxor	%xmm0, %xmm0
	xorl	%esi, %esi
	movl	$1, %ecx
	movq	%rax, 80(%rsp)
	movq	%rax, %rbp
	movq	72(%rsp), %rax
	movq	%rbx, %r8
	movl	$1, %edx
	leaq	16(%rsp), %rdi
	movaps	%xmm0, 96(%rsp)
	movq	%rax, 88(%rsp)
	movabsq	$4294967297, %rax
	movaps	%xmm0, 112(%rsp)
	movaps	%xmm0, 160(%rsp)
	movq	%rax, 104(%rsp)
	movaps	%xmm0, 128(%rsp)
	movaps	%xmm0, 144(%rsp)
	movq	$0, 176(%rsp)
	movq	%rbx, 112(%rsp)
	movq	%rbp, 168(%rsp)
	call	mk_tok@PLT
	movdqu	16(%rsp), %xmm0
	movq	%r12, %rdi
	movups	%xmm0, 120(%rsp)
	movdqu	32(%rsp), %xmm0
	movups	%xmm0, 136(%rsp)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 152(%rsp)
	call	next@PLT
	movl	$10, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC37(%rip), %rdi
	call	fwrite@PLT
	testl	%r14d, %r14d
	jne	.L166
	movq	stderr(%rip), %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC38(%rip), %rdi
	call	fwrite@PLT
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	120(%rsp), %rdi
	movq	%rax, %r12
	call	tok_free@PLT
	testl	%r15d, %r15d
	jne	.L200
.L148:
	movq	stderr(%rip), %rcx
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC39(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	sem_check_program@PLT
	movl	$19, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC40(%rip), %rdi
	call	fwrite@PLT
	jmp	.L152
	.p2align 4,,10
	.p2align 3
.L194:
	leaq	.LC48(%rip), %rsi
	movq	%r13, %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	jne	.L163
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L164:
	movq	stdout(%rip), %rsi
	movl	%eax, %edi
	call	putc@PLT
.L163:
	movq	%rbx, %rdi
	call	fgetc@PLT
	cmpl	$-1, %eax
	jne	.L164
	movq	%rbx, %rdi
	call	fclose@PLT
	jmp	.L162
	.p2align 4,,10
	.p2align 3
.L199:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC46(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L160
	.p2align 4,,10
	.p2align 3
.L196:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC42(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L157
	.p2align 4,,10
	.p2align 3
.L200:
	movq	%r12, %rdi
	call	dump_ast_program@PLT
	movl	288(%rsp), %eax
	testl	%eax, %eax
	jne	.L148
	jmp	.L165
	.p2align 4,,10
	.p2align 3
.L166:
	movq	%r12, %rdi
	call	dump_token_stream@PLT
	movq	%rbp, %rdi
	call	free@PLT
.L146:
	xorl	%r13d, %r13d
	jmp	.L143
.L195:
	call	__stack_chk_fail@PLT
.L192:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L154
.L193:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%r13, %rsi
	leaq	.LC3(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L156
.L197:
	leaq	.LC44(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L158
.L198:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L159
	.cfi_endproc
.LFE20:
	.size	compile_b_to_c, .-compile_b_to_c
	.section	.rodata.str1.1
.LC51:
	.string	"a.out"
.LC52:
	.string	"--asm"
.LC53:
	.string	"--keep-c"
.LC54:
	.string	"--emit-c"
.LC55:
	.string	"-Wno-all"
.LC56:
	.string	"-Wno-extra"
.LC57:
	.string	"--byteptr"
.LC58:
	.string	"--word="
.LC59:
	.string	"16"
.LC60:
	.string	"32"
.LC61:
	.string	"host"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC62:
	.string	"--word must be 16, 32, or host"
	.section	.rodata.str1.1
.LC63:
	.string	"--strict"
.LC64:
	.string	"--pedantic"
.LC65:
	.string	"--dump-tokens"
.LC66:
	.string	"--dump-ast"
.LC67:
	.string	"--dump-c"
.LC68:
	.string	"--no-line"
.LC69:
	.string	"--verbose-errors"
.LC70:
	.string	"-v"
.LC71:
	.string	"--inline-runtime"
.LC72:
	.string	"missing value after -o"
.LC73:
	.string	"-l"
.LC74:
	.string	"missing value after -l"
.LC75:
	.string	"-l%s"
.LC76:
	.string	"-X"
.LC77:
	.string	"missing value after -X"
.LC78:
	.string	"unknown option: %s"
.LC79:
	.string	"usage:\n"
	.section	.rodata.str1.8
	.align 8
.LC80:
	.string	"  %s [options] input.b ... [-o out]\n"
	.section	.rodata.str1.1
.LC81:
	.string	"Multi-file compilation:\n"
	.section	.rodata.str1.8
	.align 8
.LC82:
	.string	"  %s a.b b.b c.b -o prog    compile and link multiple .b files\n"
	.section	.rodata.str1.1
.LC83:
	.string	"options:\n"
	.section	.rodata.str1.8
	.align 8
.LC84:
	.string	"  -S          emit C code to stdout (single file only)\n"
	.align 8
.LC85:
	.string	"  --asm       emit assembly code to stdout (single file only)\n"
	.align 8
.LC86:
	.string	"  -c          compile to object file(s), don't link\n"
	.align 8
.LC87:
	.string	"  -E          emit C code to file (single file only)\n"
	.align 8
.LC88:
	.string	"  --keep-c    keep generated C files\n"
	.align 8
.LC89:
	.string	"  --emit-c    use a.b -> a.b.c naming for C files (implies --keep-c)\n"
	.align 8
.LC90:
	.string	"  -g          include debug information\n"
	.align 8
.LC91:
	.string	"  -l LIB      pass library to linker (can be repeated)\n"
	.align 8
.LC92:
	.string	"  -X FLAG     pass FLAG directly to gcc (can be repeated)\n"
	.align 8
.LC93:
	.string	"  -Wall       enable all warnings (default)\n"
	.align 8
.LC94:
	.string	"  -Wno-all    disable all warnings\n"
	.align 8
.LC95:
	.string	"  -Wextra     enable extra warnings (default)\n"
	.align 8
.LC96:
	.string	"  -Wno-extra  disable extra warnings\n"
	.align 8
.LC97:
	.string	"  -Werror     treat warnings as errors\n"
	.align 8
.LC98:
	.string	"  --byteptr   use byte-addressed pointers\n"
	.align 8
.LC99:
	.string	"  --word=N    word size: 16, 32, or host (default: host)\n"
	.align 8
.LC100:
	.string	"              16-bit mode wraps arithmetic like PDP-11\n"
	.align 8
.LC101:
	.string	"  -v          verbose compilation output\n"
	.align 8
.LC102:
	.string	"  --inline-runtime  embed runtime in each C file (old behavior)\n"
	.section	.rodata.str1.1
.LC103:
	.string	"Strictness:\n"
	.section	.rodata.str1.8
	.align 8
.LC104:
	.string	"  --strict        strict B72 mode: disable all modern extensions\n"
	.align 8
.LC105:
	.string	"  --pedantic      error on any non-standard syntax (use with --strict)\n"
	.align 8
.LC106:
	.string	"Extensions disabled by --strict:\n"
	.align 8
.LC107:
	.string	"  - Hex literals (0x...)       use octal instead\n"
	.align 8
.LC108:
	.string	"  - Line comments (//)         use /* */ instead\n"
	.align 8
.LC109:
	.string	"  - Backslash escapes (\\n)     use *n instead\n"
	.align 8
.LC110:
	.string	"  - C-style compound (+=)      use =+ instead\n"
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
	.string	"-S and --asm only work with a single input file"
	.align 8
.LC119:
	.string	"-E only works with a single input file"
	.section	.rodata.str1.1
.LC120:
	.string	"Compiled %s -> %s\n"
.LC121:
	.string	"Linking %zu file(s)...\n"
.LC122:
	.string	"gcc failed (exit %d)\n"
.LC123:
	.string	"Generated C files:\n"
.LC124:
	.string	"  %s\n"
.LC125:
	.string	"Kept: %s\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB21:
	.cfi_startproc
	subq	$408, %rsp
	.cfi_def_cfa_offset 416
	movq	%rbp, 368(%rsp)
	.cfi_offset 6, -48
	movl	%edi, %ebp
	movq	(%rsi), %rdi
	movq	%rbx, 360(%rsp)
	.cfi_offset 3, -56
	movq	%fs:40, %rbx
	movq	%rbx, 344(%rsp)
	movq	%rsi, %rbx
	call	init_libb_path
	call	arena_new@PLT
	pxor	%xmm0, %xmm0
	movq	$0, 192(%rsp)
	movq	%rax, g_compilation_arena(%rip)
	movq	$0, 224(%rsp)
	movq	$0, 16+g_known_functions(%rip)
	movaps	%xmm0, 176(%rsp)
	movaps	%xmm0, 208(%rsp)
	movups	%xmm0, g_known_functions(%rip)
	cmpl	$1, %ebp
	jle	.L202
	movq	%r15, 400(%rsp)
	.cfi_offset 15, -16
	movl	$1, %r15d
	movq	%r12, 376(%rsp)
	movq	%r13, 384(%rsp)
	movq	%r14, 392(%rsp)
	movq	$0, 48(%rsp)
	movl	$1, 64(%rsp)
	movl	$0, 28(%rsp)
	movl	$0, 80(%rsp)
	movl	$0, 44(%rsp)
	movl	$0, 40(%rsp)
	movl	$0, 32(%rsp)
	movl	$0, 104(%rsp)
	movl	$1, 100(%rsp)
	movl	$1, 96(%rsp)
	movl	$0, 92(%rsp)
	movl	$0, 88(%rsp)
	movl	$0, 84(%rsp)
	movl	$0, 68(%rsp)
	movl	$0, 36(%rsp)
	movl	$0, 8(%rsp)
	movl	$0, 56(%rsp)
	movl	$0, 16(%rsp)
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	jmp	.L220
	.p2align 4,,10
	.p2align 3
.L334:
	cmpb	$83, 1(%r13)
	jne	.L282
	cmpb	$0, 2(%r13)
	jne	.L282
	movl	$1, 8(%rsp)
.L204:
	addl	$1, %r15d
	cmpl	%r15d, %ebp
	jle	.L333
.L220:
	movslq	%r15d, %r12
	movq	(%rbx,%r12,8), %r13
	movzbl	0(%r13), %r14d
	cmpl	$45, %r14d
	je	.L334
.L282:
	leaq	.LC52(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L261
	cmpl	$45, %r14d
	je	.L335
.L284:
	leaq	.LC53(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L336
.L331:
	movl	$1, 84(%rsp)
	jmp	.L204
	.p2align 4,,10
	.p2align 3
.L261:
	addl	$1, %r15d
	movl	$1, 36(%rsp)
	cmpl	%r15d, %ebp
	jg	.L220
.L333:
	movl	56(%rsp), %r8d
	movq	216(%rsp), %rdx
	movl	$1, g_no_line(%rip)
	movl	16(%rsp), %r9d
	movl	%r8d, g_verbose_errors(%rip)
	testq	%rdx, %rdx
	je	.L337
	movq	48(%rsp), %rax
	leaq	.LC51(%rip), %rcx
	leaq	240(%rsp), %rbp
	testq	%rax, %rax
	cmovne	%rax, %rcx
	movq	%rcx, 48(%rsp)
	cmpq	$1, %rdx
	je	.L226
	cmpl	$0, 32(%rsp)
	je	.L338
.L226:
	movl	36(%rsp), %eax
	orl	8(%rsp), %eax
	jne	.L339
.L234:
	testl	%r9d, %r9d
	je	.L239
	cmpq	$1, %rdx
	ja	.L340
.L240:
	movq	208(%rsp), %rax
	xorl	%esi, %esi
	movq	%rsi, 168(%rsp)
	leaq	168(%rsp), %rsi
	movq	(%rax), %rbx
	movq	%rbx, %rdi
	call	read_file_all
	movl	$22, %ecx
	movq	%rbx, %r8
	xorl	%esi, %esi
	movq	%rax, %r12
	leaq	256(%rsp), %rdi
	xorl	%eax, %eax
	movl	$1, %edx
	rep stosl
	movq	168(%rsp), %rax
	movl	$1, %ecx
	leaq	112(%rsp), %rdi
	movq	%r12, 240(%rsp)
	movq	%rax, 248(%rsp)
	movabsq	$4294967297, %rax
	movq	%rax, 264(%rsp)
	movq	%rbx, 272(%rsp)
	movq	%r12, 328(%rsp)
	call	mk_tok@PLT
	movl	$12, %ecx
	leaq	112(%rsp), %rsi
	leaq	280(%rsp), %rdi
	rep movsl
	movq	%rbp, %rdi
	call	next@PLT
	movq	%rbp, %rdi
	call	parse_program_ast@PLT
	leaq	280(%rsp), %rdi
	movq	%rax, %r13
	call	tok_free@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	sem_check_program@PLT
	movq	48(%rsp), %rdi
	leaq	.LC41(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L341
.L241:
	movl	28(%rsp), %r9d
	movq	%rbp, %rdi
	movl	$1, %ecx
	movq	%rbx, %rdx
	movl	$1, %r8d
	movq	%r13, %rsi
	call	emit_program_c@PLT
	movq	%rbp, %rdi
	call	fclose@PLT
.L332:
	movq	%r12, %rdi
	call	free@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%ecx, %ecx
	xorl	%r9d, %r9d
	movq	376(%rsp), %r12
	.cfi_restore 12
	movq	%rcx, g_compilation_arena(%rip)
	movq	384(%rsp), %r13
	.cfi_restore 13
	movq	392(%rsp), %r14
	.cfi_restore 14
	movq	400(%rsp), %r15
	.cfi_restore 15
.L201:
	movq	344(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L342
	movq	360(%rsp), %rbx
	movq	368(%rsp), %rbp
	movl	%r9d, %eax
	addq	$408, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L335:
	.cfi_def_cfa_offset 416
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	cmpb	$99, 1(%r13)
	je	.L343
.L283:
	cmpl	$45, %r14d
	jne	.L284
	cmpb	$69, 1(%r13)
	jne	.L284
	cmpb	$0, 2(%r13)
	jne	.L284
	movl	$1, 16(%rsp)
	jmp	.L204
.L343:
	cmpb	$0, 2(%r13)
	jne	.L283
	movl	$1, 68(%rsp)
	jmp	.L204
.L338:
	movl	40(%rsp), %ecx
	xorl	$1, %ecx
	orl	44(%rsp), %ecx
	je	.L227
	xorl	%r8d, %r8d
	movl	%r9d, 108(%rsp)
	movq	%r8, 16(%rsp)
	movq	%rbp, 72(%rsp)
	.p2align 4
	.p2align 3
.L233:
	movq	16(%rsp), %rcx
	movq	208(%rsp), %rax
	leaq	168(%rsp), %rsi
	movq	$0, 168(%rsp)
	movq	(%rax,%rcx,8), %r12
	movq	%r12, %rdi
	call	read_file_all
	pxor	%xmm0, %xmm0
	xorl	%esi, %esi
	movq	%r12, %r8
	movq	%rax, 240(%rsp)
	movq	%rax, %rbx
	movl	$1, %ecx
	movq	168(%rsp), %rax
	movl	$1, %edx
	leaq	112(%rsp), %rdi
	movaps	%xmm0, 256(%rsp)
	movq	%rax, 248(%rsp)
	movabsq	$4294967297, %rax
	movq	%rax, 264(%rsp)
	movaps	%xmm0, 272(%rsp)
	movaps	%xmm0, 320(%rsp)
	movaps	%xmm0, 288(%rsp)
	movaps	%xmm0, 304(%rsp)
	movq	$0, 336(%rsp)
	movq	%r12, 272(%rsp)
	movq	%rbx, 328(%rsp)
	call	mk_tok@PLT
	movdqu	112(%rsp), %xmm0
	movq	72(%rsp), %r14
	movups	%xmm0, 280(%rsp)
	movq	%r14, %rdi
	movdqu	128(%rsp), %xmm0
	movups	%xmm0, 296(%rsp)
	movdqu	144(%rsp), %xmm0
	movups	%xmm0, 312(%rsp)
	call	next@PLT
	movq	%r14, %rdi
	call	parse_program_ast@PLT
	leaq	280(%rsp), %rdi
	movq	%rax, %r14
	call	tok_free@PLT
	cmpq	$0, 8(%r14)
	je	.L228
	movq	%rbx, 56(%rsp)
	xorl	%r15d, %r15d
	movq	%r14, %rbx
	jmp	.L232
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L229:
	addq	$1, %r15
	cmpq	8(%rbx), %r15
	jnb	.L344
.L232:
	movq	(%rbx), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L229
	movq	8(%rax), %rax
	movq	(%rax), %r14
	leaq	g_known_functions(%rip), %rax
	movq	8(%rax), %r13
	testq	%r13, %r13
	je	.L230
	movq	(%rax), %rbp
	xorl	%r12d, %r12d
	.p2align 4
	.p2align 3
.L231:
	movq	0(%rbp,%r12,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L229
	addq	$1, %r12
	cmpq	%r12, %r13
	jne	.L231
.L230:
	movq	%r14, %rdi
	call	sdup@PLT
	leaq	g_known_functions(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L229
.L239:
	movl	$6, %ecx
	movq	%rbp, %rdi
	movl	%r9d, %eax
	rep stosl
	testq	%rdx, %rdx
	je	.L242
	movl	%r9d, 16(%rsp)
	movl	88(%rsp), %r15d
	xorl	%ebx, %ebx
	movq	%rbp, 8(%rsp)
	movl	80(%rsp), %r14d
	jmp	.L247
	.p2align 4,,10
	.p2align 3
.L243:
	subq	$8, %rsp
	.cfi_def_cfa_offset 424
	movl	%r14d, %ecx
	movl	$1, %edx
	movq	%r12, %rdi
	movl	72(%rsp), %eax
	movl	$1, %esi
	pushq	%rax
	.cfi_def_cfa_offset 432
	movl	44(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 440
	pushq	$0
	.cfi_def_cfa_offset 448
	pushq	$0
	.cfi_def_cfa_offset 456
	movl	84(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 464
	movl	88(%rsp), %r9d
	movl	80(%rsp), %r8d
	call	compile_b_to_c
	addq	$48, %rsp
	.cfi_def_cfa_offset 416
	movq	%rax, %rbp
	testq	%rbp, %rbp
	je	.L345
.L245:
	movq	8(%rsp), %rdi
	movq	%rbp, %rsi
	call	vec_push@PLT
	testl	%r14d, %r14d
	jne	.L346
	addq	$1, %rbx
	cmpq	216(%rsp), %rbx
	jnb	.L347
.L247:
	movq	208(%rsp), %rax
	movq	(%rax,%rbx,8), %r12
	testl	%r15d, %r15d
	je	.L243
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	malloc@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L348
.L244:
	movq	%r12, %rdx
	leaq	.LC45(%rip), %rsi
	movq	%r13, %rdi
	xorl	%eax, %eax
	call	sprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 424
	movq	%r12, %rdi
	movl	%r14d, %ecx
	movl	72(%rsp), %eax
	movl	$1, %edx
	movl	$1, %esi
	pushq	%rax
	.cfi_def_cfa_offset 432
	movl	44(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 440
	pushq	%r13
	.cfi_def_cfa_offset 448
	pushq	$1
	.cfi_def_cfa_offset 456
	movl	84(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 464
	movl	88(%rsp), %r9d
	movl	80(%rsp), %r8d
	call	compile_b_to_c
	addq	$48, %rsp
	.cfi_def_cfa_offset 416
	movq	%r13, %rdi
	movq	%rax, %rbp
	call	free@PLT
	testq	%rbp, %rbp
	jne	.L245
.L345:
	movl	16(%rsp), %r9d
.L251:
	movq	g_compilation_arena(%rip), %rdi
	movl	%r9d, 8(%rsp)
	call	arena_free@PLT
	xorl	%eax, %eax
	movl	8(%rsp), %r9d
	movq	376(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	%rax, g_compilation_arena(%rip)
	movq	384(%rsp), %r13
	.cfi_restore 13
	movq	392(%rsp), %r14
	.cfi_restore 14
	movq	400(%rsp), %r15
	.cfi_restore 15
	jmp	.L201
.L336:
	.cfi_restore_state
	leaq	.LC54(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L265
	leaq	.LC25(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L266
	leaq	.LC22(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L267
	leaq	.LC55(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L268
	leaq	.LC23(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L269
	leaq	.LC56(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L270
	leaq	.LC24(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L271
	leaq	.LC57(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L204
	movl	$7, %edx
	leaq	.LC58(%rip), %rsi
	movq	%r13, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L207
	leaq	.LC59(%rip), %rsi
	leaq	7(%r13), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L272
	leaq	.LC60(%rip), %rsi
	leaq	7(%r13), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L273
	leaq	.LC61(%rip), %rsi
	leaq	7(%r13), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L349
	xorl	%r12d, %r12d
	movl	%r12d, 28(%rsp)
	jmp	.L204
.L339:
	cmpq	$1, %rdx
	ja	.L258
.L235:
	movq	208(%rsp), %rax
	xorl	%edi, %edi
	leaq	168(%rsp), %rsi
	movq	%rdi, 168(%rsp)
	movq	(%rax), %rbx
	movq	%rbx, %rdi
	call	read_file_all
	movl	$22, %ecx
	movq	%rbx, %r8
	xorl	%esi, %esi
	movq	%rax, %r12
	leaq	256(%rsp), %rdi
	xorl	%eax, %eax
	movl	$1, %edx
	rep stosl
	movq	168(%rsp), %rax
	movl	$1, %ecx
	leaq	112(%rsp), %rdi
	movq	%r12, 240(%rsp)
	movq	%rax, 248(%rsp)
	movabsq	$4294967297, %rax
	movq	%rax, 264(%rsp)
	movq	%rbx, 272(%rsp)
	movq	%r12, 328(%rsp)
	call	mk_tok@PLT
	movl	$12, %ecx
	leaq	112(%rsp), %rsi
	leaq	280(%rsp), %rdi
	rep movsl
	movq	%rbp, %rdi
	call	next@PLT
	movq	%rbp, %rdi
	call	parse_program_ast@PLT
	leaq	280(%rsp), %rdi
	movq	%rax, %rbp
	call	tok_free@PLT
	movq	%rbp, %rdi
	movq	%rbx, %rsi
	call	sem_check_program@PLT
	movq	stdout(%rip), %rdi
	cmpl	$0, 8(%rsp)
	je	.L236
	movl	28(%rsp), %r9d
	movl	$1, %ecx
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movl	$1, %r8d
	call	emit_program_c@PLT
	jmp	.L332
	.p2align 4,,10
	.p2align 3
.L346:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rcx
	movq	%r12, %rdx
	xorl	%eax, %eax
	leaq	.LC120(%rip), %rsi
	addq	$1, %rbx
	call	fprintf@PLT
	cmpq	216(%rsp), %rbx
	jb	.L247
.L347:
	movq	8(%rsp), %rbp
.L242:
	cmpl	$0, 80(%rsp)
	jne	.L350
.L248:
	movl	80(%rsp), %eax
	movq	%rbp, %rdi
	pushq	%rax
	.cfi_def_cfa_offset 424
	movl	36(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 432
	pushq	$1
	.cfi_def_cfa_offset 440
	movl	88(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 448
	leaq	208(%rsp), %rax
	pushq	%rax
	.cfi_def_cfa_offset 456
	movl	144(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 464
	movl	148(%rsp), %r9d
	movl	144(%rsp), %r8d
	movl	140(%rsp), %ecx
	movl	116(%rsp), %edx
	movq	96(%rsp), %rsi
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 416
	movl	%eax, %r9d
	testl	%eax, %eax
	jne	.L249
	xorl	%ebx, %ebx
	cmpq	$0, 248(%rsp)
	je	.L251
	movl	84(%rsp), %r12d
	movl	80(%rsp), %r13d
	movl	%eax, %r14d
	jmp	.L250
.L255:
	testl	%r13d, %r13d
	jne	.L351
.L256:
	movq	%rbp, %rdi
	addq	$1, %rbx
	call	free@PLT
	cmpq	248(%rsp), %rbx
	jnb	.L352
.L250:
	movq	240(%rsp), %rax
	movq	(%rax,%rbx,8), %rbp
	testl	%r12d, %r12d
	jne	.L255
	movq	%rbp, %rdi
	call	unlink@PLT
	jmp	.L256
.L236:
	movq	%rbp, %rsi
	call	emit_program_asm@PLT
	jmp	.L332
.L227:
	movl	36(%rsp), %eax
	orl	8(%rsp), %eax
	je	.L234
.L258:
	leaq	.LC118(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L235
.L265:
	movl	$1, 88(%rsp)
	jmp	.L331
.L340:
	leaq	.LC119(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L240
	.p2align 4,,10
	.p2align 3
.L344:
	movq	56(%rsp), %rbx
.L228:
	movq	%rbx, %rdi
	call	free@PLT
	addq	$1, 16(%rsp)
	movq	216(%rsp), %rdx
	cmpq	%rdx, 16(%rsp)
	jb	.L233
	movl	108(%rsp), %r9d
	movq	72(%rsp), %rbp
	jmp	.L226
.L351:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rdx
	leaq	.LC125(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L256
.L202:
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	movl	$1, g_no_line(%rip)
	xorl	%r10d, %r10d
	movl	%r10d, g_verbose_errors(%rip)
.L222:
	movq	stderr(%rip), %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC79(%rip), %rdi
	call	fwrite@PLT
	movq	(%rbx), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC80(%rip), %rsi
	call	fprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$24, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC81(%rip), %rdi
	call	fwrite@PLT
	movq	(%rbx), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC82(%rip), %rsi
	call	fprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$9, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC83(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC84(%rip), %rdi
	call	fwrite@PLT
	movl	$62, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC85(%rip), %rdi
	call	fwrite@PLT
	movl	$52, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC86(%rip), %rdi
	call	fwrite@PLT
	movl	$53, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC87(%rip), %rdi
	call	fwrite@PLT
	movl	$37, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC88(%rip), %rdi
	call	fwrite@PLT
	movl	$69, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC89(%rip), %rdi
	call	fwrite@PLT
	movl	$40, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC90(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	call	fwrite@PLT
	movl	$58, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC92(%rip), %rdi
	call	fwrite@PLT
	movl	$44, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	call	fwrite@PLT
	movl	$35, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC94(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
	call	fwrite@PLT
	movl	$37, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
	call	fwrite@PLT
	movl	$39, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC97(%rip), %rdi
	call	fwrite@PLT
	movl	$42, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
	call	fwrite@PLT
	movl	$57, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC100(%rip), %rdi
	call	fwrite@PLT
	movl	$41, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC101(%rip), %rdi
	call	fwrite@PLT
	movl	$64, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC102(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$12, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	movl	$65, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC104(%rip), %rdi
	call	fwrite@PLT
	movl	$71, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$33, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC106(%rip), %rdi
	call	fwrite@PLT
	movl	$49, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	movl	$49, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC108(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC109(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
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
	xorl	%r9d, %r9d
	movq	%r9, g_compilation_arena(%rip)
	movl	$2, %r9d
	jmp	.L201
.L337:
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	376(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	384(%rsp), %r13
	.cfi_restore 13
	movq	392(%rsp), %r14
	.cfi_restore 14
	movq	400(%rsp), %r15
	.cfi_restore 15
	jmp	.L222
.L352:
	.cfi_restore_state
	movl	%r14d, %r9d
	jmp	.L251
.L266:
	movl	$1, 92(%rsp)
	jmp	.L204
.L267:
	movl	$1, 96(%rsp)
	jmp	.L204
.L350:
	movq	stderr(%rip), %rdi
	movq	248(%rsp), %rdx
	leaq	.LC121(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L248
.L249:
	movq	stderr(%rip), %rdi
	movl	%eax, %edx
	leaq	.LC122(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpl	$0, 84(%rsp)
	je	.L353
.L252:
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%edx, %edx
	movq	376(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	384(%rsp), %r13
	.cfi_restore 13
	movq	%rdx, g_compilation_arena(%rip)
	movq	392(%rsp), %r14
	.cfi_restore 14
	movl	$1, %r9d
	movq	400(%rsp), %r15
	.cfi_restore 15
	jmp	.L201
.L268:
	.cfi_restore_state
	xorl	%r14d, %r14d
	movl	%r14d, 96(%rsp)
	jmp	.L204
.L353:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC123(%rip), %rdi
	call	fwrite@PLT
	jmp	.L253
.L254:
	movq	240(%rsp), %rax
	movq	stderr(%rip), %rdi
	leaq	.LC124(%rip), %rsi
	movq	(%rax,%rbx,8), %rdx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
.L253:
	cmpq	248(%rsp), %rbx
	jb	.L254
	jmp	.L252
.L269:
	movl	$1, 100(%rsp)
	jmp	.L204
.L270:
	xorl	%r13d, %r13d
	movl	%r13d, 100(%rsp)
	jmp	.L204
.L271:
	movl	$1, 104(%rsp)
	jmp	.L204
.L341:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	48(%rsp), %rsi
	leaq	.LC3(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L241
.L342:
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	movq	%r12, 376(%rsp)
	movq	%r13, 384(%rsp)
	movq	%r14, 392(%rsp)
	movq	%r15, 400(%rsp)
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__stack_chk_fail@PLT
.L348:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L244
.L349:
	leaq	.LC62(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L204
.L273:
	movl	$32, 28(%rsp)
	jmp	.L204
.L272:
	movl	$16, 28(%rsp)
	jmp	.L204
.L207:
	leaq	.LC63(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L208
	movl	$1, g_strict(%rip)
	xorl	%eax, %eax
	movl	%eax, g_extensions(%rip)
	jmp	.L204
.L208:
	leaq	.LC64(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L210
	movl	$1, g_pedantic(%rip)
	jmp	.L204
.L210:
	leaq	.LC65(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L275
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L276
	leaq	.LC67(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L277
	leaq	.LC68(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L204
	leaq	.LC69(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L278
	leaq	.LC70(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L279
	leaq	.LC71(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L280
	leaq	.LC15(%rip), %rsi
	movq	%r13, %rdi
	leal	1(%r15), %r14d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L211
	cmpl	%r14d, %ebp
	jg	.L212
	leaq	.LC72(%rip), %rdi
	call	dief@PLT
.L212:
	movq	8(%rbx,%r12,8), %rax
	movl	%r14d, %r15d
	movq	%rax, 48(%rsp)
	jmp	.L204
.L211:
	leaq	.LC73(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L213
	cmpl	%r14d, %ebp
	jle	.L354
.L214:
	movq	8(%rbx,%r12,8), %r15
	movq	%r15, %rdi
	call	strlen@PLT
	leaq	3(%rax), %r13
	movq	%r13, %rdi
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L355
.L215:
	movq	%r15, %rcx
	leaq	.LC75(%rip), %rdx
	movq	%r13, %rsi
	movq	%r12, %rdi
	xorl	%eax, %eax
	movl	%r14d, %r15d
	call	snprintf@PLT
	leaq	176(%rsp), %rdi
	movq	%r12, %rsi
	call	vec_push@PLT
	jmp	.L204
.L280:
	xorl	%r11d, %r11d
	movl	%r11d, 64(%rsp)
	jmp	.L204
.L279:
	movl	$1, 80(%rsp)
	jmp	.L204
.L355:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L215
.L354:
	leaq	.LC74(%rip), %rdi
	call	dief@PLT
	jmp	.L214
.L213:
	leaq	.LC76(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L216
	cmpl	%r14d, %ebp
	jg	.L217
	leaq	.LC77(%rip), %rdi
	call	dief@PLT
.L217:
	movq	8(%rbx,%r12,8), %rdi
	movl	%r14d, %r15d
	call	sdup@PLT
	leaq	176(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L204
.L216:
	cmpb	$45, 0(%r13)
	je	.L356
	leaq	208(%rsp), %rdi
	movq	%r13, %rsi
	call	vec_push@PLT
	jmp	.L204
.L278:
	movl	$1, 56(%rsp)
	jmp	.L204
.L276:
	movl	$1, 40(%rsp)
	jmp	.L204
.L275:
	movl	$1, 32(%rsp)
	jmp	.L204
.L277:
	movl	$1, 44(%rsp)
	jmp	.L204
.L356:
	movq	%r13, %rsi
	leaq	.LC78(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L204
	.cfi_endproc
.LFE21:
	.size	main, .-main
	.local	libb_o_path.0
	.comm	libb_o_path.0,4096,32
	.local	g_libb_dir
	.comm	g_libb_dir,4096,32
	.section	.data.rel.ro.local,"aw"
	.align 8
.LC30:
	.quad	.LC8
	.align 8
.LC31:
	.quad	.LC15
	.align 8
.LC32:
	.quad	libb_o_path.0
	.align 8
.LC33:
	.quad	.LC13
	.align 8
.LC34:
	.quad	.LC26
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC50:
	.quad	7161675788338426927
	.quad	24866934413088863
	.ident	"GCC: (GNU) 16.1.1 20260430"
	.section	.note.GNU-stack,"",@progbits
