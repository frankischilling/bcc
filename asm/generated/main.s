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
.LFB16:
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
.LFE16:
	.size	init_libb_path, .-init_libb_path
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"output '%s' would overwrite input '%s'"
	.text
	.p2align 4
	.type	protect_input, @function
protect_input:
.LFB15:
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
.LFE15:
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
.LFB17:
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
.LFE17:
	.size	read_file_all, .-read_file_all
	.section	.rodata.str1.1
.LC9:
	.string	"gcc"
.LC10:
	.string	"-std=c99"
.LC11:
	.string	"%s/libb.c"
.LC12:
	.string	"libb.c"
.LC13:
	.string	"libb.h"
.LC14:
	.string	"btarget.h"
.LC15:
	.string	"binit.h"
.LC16:
	.string	"bcall.h"
.LC17:
	.string	"bunix.h"
.LC18:
	.string	"bformat.h"
.LC19:
	.string	"%s/%s"
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"cannot read runtime dependency %s"
	.align 8
.LC21:
	.string	"/tmp/bcc_libb_%016lx_%d_%d_%d.o"
	.section	.rodata.str1.1
.LC22:
	.string	"libb.c not found at %s"
.LC23:
	.string	"Compiling runtime library...\n"
.LC24:
	.string	"-I%s"
.LC25:
	.string	"-DB_BYTEPTR=%d"
.LC26:
	.string	"-DWORD_BITS=%d"
.LC27:
	.string	"-D__bcc_strict_runtime=%d"
.LC28:
	.string	"%s.XXXXXX"
.LC29:
	.string	"cannot create runtime object"
.LC30:
	.string	"-O2"
.LC31:
	.string	"-c"
.LC32:
	.string	"-o"
.LC33:
	.string	"fork failed"
.LC34:
	.string	"Failed to compile libb.c"
.LC35:
	.string	"cannot cache runtime object"
.LC36:
	.string	"-Wall"
.LC37:
	.string	"-Wextra"
.LC38:
	.string	"-Werror"
.LC39:
	.string	"-g"
.LC40:
	.string	"-ldl"
.LC41:
	.string	"-lm"
.LC42:
	.string	"Running:"
.LC43:
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
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%edx, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$20952, %rsp
	.cfi_def_cfa_offset 21008
	movq	.LC44(%rip), %xmm1
	movq	%rdi, 32(%rsp)
	movl	21024(%rsp), %edi
	punpcklqdq	%xmm2, %xmm1
	movq	%rsi, 48(%rsp)
	testl	%edi, %edi
	movl	%ecx, 56(%rsp)
	setne	%dl
	testl	%ebp, %ebp
	movl	%r8d, 60(%rsp)
	sete	%al
	movl	%r9d, 88(%rsp)
	andb	%al, %dl
	movaps	%xmm1, 16(%rsp)
	movb	%dl, 47(%rsp)
	jne	.L149
	leaq	g_libb_dir(%rip), %rax
	xorl	%r12d, %r12d
	leaq	12752(%rsp), %r15
	movq	%rax, 8(%rsp)
	leaq	.LC24(%rip), %r14
	leaq	.LC32(%rip), %rbx
.L47:
	movq	8(%rsp), %rcx
	movq	%r14, %rdx
	xorl	%eax, %eax
	movl	$4096, %esi
	movq	%r15, %rdi
	call	snprintf@PLT
	movq	32(%rsp), %rax
	movq	8(%rax), %r14
	xorl	%eax, %eax
	cmpq	$0, 21016(%rsp)
	je	.L62
	movq	21016(%rsp), %rax
	movq	8(%rax), %rax
.L62:
	leaq	40(%r14,%rax), %rdi
	salq	$3, %rdi
	call	malloc@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L150
.L63:
	movdqa	16(%rsp), %xmm3
	movups	%xmm3, 0(%r13)
	testl	%ebp, %ebp
	jne	.L90
	leaq	.LC30(%rip), %rax
	movl	$24, %edx
	movl	$3, %esi
	movq	%rax, 16(%r13)
	movl	$4, %eax
.L64:
	movl	60(%rsp), %r10d
	testl	%r10d, %r10d
	je	.L65
	leaq	.LC36(%rip), %rcx
	movslq	%eax, %rsi
	movq	%rcx, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L65:
	movl	88(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L66
	leaq	.LC37(%rip), %rcx
	movslq	%eax, %rsi
	movq	%rcx, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L66:
	movl	21008(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L67
	leaq	.LC38(%rip), %rcx
	movslq	%eax, %rsi
	movq	%rcx, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L67:
	movl	56(%rsp), %edi
	testl	%edi, %edi
	je	.L68
	leaq	.LC39(%rip), %rcx
	movslq	%eax, %rsi
	movq	%rcx, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L68:
	movl	21024(%rsp), %ecx
	testl	%ecx, %ecx
	je	.L69
	movq	%r15, 0(%r13,%rdx)
	movslq	%eax, %rdx
	movslq	%eax, %rsi
	addl	$1, %eax
	salq	$3, %rdx
.L69:
	testl	%ebp, %ebp
	je	.L70
	leaq	.LC31(%rip), %rcx
	movslq	%eax, %rsi
	movq	%rcx, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L70:
	movq	%rbx, 0(%r13,%rdx)
	movq	48(%rsp), %rbx
	cltq
	leal	2(%rsi), %ecx
	movq	%rbx, 0(%r13,%rax,8)
	testq	%r14, %r14
	je	.L71
	movq	32(%rsp), %rax
	leaq	0(%r13,%rsi,8), %rsi
	movq	(%rax), %rdi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L72:
	movq	(%rdi,%rax,8), %rdx
	movq	%rdx, 16(%rsi,%rax,8)
	addq	$1, %rax
	cmpq	%r14, %rax
	jne	.L72
	addl	%eax, %ecx
.L71:
	cmpb	$0, 47(%rsp)
	je	.L73
	movslq	%ecx, %rax
	addl	$1, %ecx
	cmpq	$0, 21016(%rsp)
	movq	%r12, 0(%r13,%rax,8)
	je	.L75
.L74:
	movq	21016(%rsp), %rax
	movq	8(%rax), %rsi
	testq	%rsi, %rsi
	je	.L76
	movq	(%rax), %r8
	movslq	%ecx, %rax
	leaq	0(%r13,%rax,8), %rdi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L77:
	movq	(%r8,%rax,8), %rdx
	movq	%rdx, (%rdi,%rax,8)
	addq	$1, %rax
	cmpq	%rsi, %rax
	jne	.L77
	addl	%eax, %ecx
.L76:
	testl	%ebp, %ebp
	je	.L75
.L78:
	movl	21048(%rsp), %eax
	movslq	%ecx, %rcx
	movq	$0, 0(%r13,%rcx,8)
	testl	%eax, %eax
	jne	.L151
	call	fork@PLT
	movl	%eax, %edi
	testl	%eax, %eax
	js	.L152
.L83:
	je	.L153
	leaq	4560(%rsp), %rsi
	xorl	%edx, %edx
	movl	$0, 4560(%rsp)
	call	waitpid@PLT
	movq	%r13, %rdi
	testl	%eax, %eax
	js	.L154
	call	free@PLT
	movl	4560(%rsp), %eax
	testb	$127, %al
	je	.L155
.L84:
	movl	$1, %eax
.L46:
	addq	$20952, %rsp
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
.L75:
	.cfi_restore_state
	movq	.LC49(%rip), %xmm0
	leaq	.LC41(%rip), %rdx
	movslq	%ecx, %rax
	addl	$2, %ecx
	movq	%rdx, %xmm4
	punpcklqdq	%xmm4, %xmm0
	movups	%xmm0, 0(%r13,%rax,8)
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L73:
	cmpq	$0, 21016(%rsp)
	jne	.L74
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L90:
	movl	$3, %eax
	movl	$16, %edx
	movl	$2, %esi
	jmp	.L64
	.p2align 4,,10
	.p2align 3
.L155:
	movzbl	%ah, %eax
	jmp	.L46
	.p2align 4,,10
	.p2align 3
.L151:
	movq	stderr(%rip), %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC42(%rip), %rdi
	leaq	8(%r13), %rbx
	leaq	.LC43(%rip), %rbp
	call	fwrite@PLT
	movq	0(%r13), %rdx
	testq	%rdx, %rdx
	je	.L82
	.p2align 4
	.p2align 3
.L81:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rsi
	xorl	%eax, %eax
	addq	$8, %rbx
	call	fprintf@PLT
	movq	-8(%rbx), %rdx
	testq	%rdx, %rdx
	jne	.L81
.L82:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	call	fork@PLT
	movl	%eax, %edi
	testl	%eax, %eax
	jns	.L83
.L152:
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L84
	.p2align 4,,10
	.p2align 3
.L149:
	leaq	g_libb_dir(%rip), %rax
	movl	$4096, %esi
	leaq	112(%rsp), %r13
	movabsq	$-3750763034362895579, %rbx
	movq	%rax, 8(%rsp)
	leaq	464(%rsp), %rdi
	movq	%rax, %rcx
	leaq	.LC11(%rip), %rdx
	xorl	%eax, %eax
	movq	%rdi, 64(%rsp)
	leaq	168(%rsp), %r14
	leaq	12752(%rsp), %r15
	call	snprintf@PLT
	movl	%ebp, 72(%rsp)
	leaq	.LC13(%rip), %rax
	movq	.LC45(%rip), %xmm0
	movabsq	$1099511628211, %r12
	movq	%rax, %xmm5
	leaq	.LC15(%rip), %rax
	punpcklqdq	%xmm5, %xmm0
	movq	%rax, %xmm6
	leaq	.LC17(%rip), %rax
	movaps	%xmm0, 112(%rsp)
	movq	%rax, %xmm7
	movq	.LC46(%rip), %xmm0
	leaq	.LC18(%rip), %rax
	movq	%rax, 160(%rsp)
	punpcklqdq	%xmm6, %xmm0
	movaps	%xmm0, 128(%rsp)
	movq	.LC47(%rip), %xmm0
	punpcklqdq	%xmm7, %xmm0
	movaps	%xmm0, 144(%rsp)
	.p2align 4
	.p2align 3
.L52:
	movq	0(%r13), %r8
	movq	8(%rsp), %rcx
	movl	$8192, %esi
	xorl	%eax, %eax
	leaq	.LC19(%rip), %rdx
	movq	%r15, %rdi
	call	snprintf@PLT
	leaq	.LC3(%rip), %rsi
	movq	%r15, %rdi
	call	fopen@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jne	.L49
	jmp	.L156
	.p2align 4,,10
	.p2align 3
.L50:
	movzbl	%al, %eax
	xorq	%rbx, %rax
	imulq	%r12, %rax
	movq	%rax, %rbx
.L49:
	movq	%rbp, %rdi
	call	fgetc@PLT
	cmpl	$-1, %eax
	jne	.L50
	movq	%rbp, %rdi
	call	ferror@PLT
	testl	%eax, %eax
	jne	.L157
.L51:
	movq	%rbp, %rdi
	addq	$8, %r13
	call	fclose@PLT
	cmpq	%r14, %r13
	jne	.L52
	movl	g_strict(%rip), %edx
	movl	72(%rsp), %ebp
	xorl	%eax, %eax
	subq	$8, %rsp
	.cfi_def_cfa_offset 21016
	leaq	libb_o_path.0(%rip), %r12
	movq	%rbx, %rcx
	movl	$4096, %esi
	testl	%edx, %edx
	movq	%r12, %rdi
	leaq	.LC21(%rip), %rdx
	setne	%al
	pushq	%rax
	.cfi_def_cfa_offset 21024
	movl	21056(%rsp), %r9d
	xorl	%eax, %eax
	movl	21048(%rsp), %r8d
	call	snprintf@PLT
	movq	80(%rsp), %rdi
	movl	$4, %esi
	call	access@PLT
	popq	%rcx
	.cfi_def_cfa_offset 21016
	popq	%rsi
	.cfi_def_cfa_offset 21008
	testl	%eax, %eax
	jne	.L158
.L53:
	movl	$4, %esi
	movq	%r12, %rdi
	leaq	.LC24(%rip), %r14
	call	access@PLT
	leaq	.LC32(%rip), %rbx
	testl	%eax, %eax
	je	.L54
	movl	21048(%rsp), %eax
	testl	%eax, %eax
	jne	.L159
.L55:
	movq	8(%rsp), %rcx
	leaq	4560(%rsp), %rbx
	leaq	.LC24(%rip), %r14
	xorl	%eax, %eax
	movq	%r14, %rdx
	movl	$8192, %esi
	movq	%rbx, %rdi
	call	snprintf@PLT
	movl	21032(%rsp), %r11d
	xorl	%ecx, %ecx
	leaq	176(%rsp), %rdi
	leaq	.LC25(%rip), %rdx
	movl	$64, %esi
	movq	%rdi, 80(%rsp)
	leaq	240(%rsp), %r13
	testl	%r11d, %r11d
	setne	%cl
	xorl	%eax, %eax
	call	snprintf@PLT
	movl	$64, %esi
	movq	%r13, %rdi
	xorl	%eax, %eax
	movl	21040(%rsp), %ecx
	leaq	.LC26(%rip), %rdx
	call	snprintf@PLT
	movl	g_strict(%rip), %eax
	xorl	%ecx, %ecx
	leaq	304(%rsp), %rdi
	leaq	.LC27(%rip), %rdx
	movl	$64, %esi
	movq	%rdi, 72(%rsp)
	testl	%eax, %eax
	setne	%cl
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	%r12, %rcx
	movl	$8192, %esi
	movq	%r15, %rdi
	leaq	.LC28(%rip), %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	%r15, %rdi
	call	mkstemp@PLT
	movl	%eax, %edx
	testl	%eax, %eax
	js	.L160
.L56:
	movl	%edx, %edi
	call	close@PLT
	leaq	.LC31(%rip), %rax
	movq	.LC48(%rip), %xmm0
	movdqa	16(%rsp), %xmm5
	movq	%rax, %xmm6
	movq	%r15, 448(%rsp)
	punpcklqdq	%xmm6, %xmm0
	movaps	%xmm5, 368(%rsp)
	movaps	%xmm0, 384(%rsp)
	movq	%rbx, %xmm0
	leaq	.LC32(%rip), %rbx
	movhps	80(%rsp), %xmm0
	movq	%rbx, %xmm7
	movq	$0, 456(%rsp)
	movaps	%xmm0, 400(%rsp)
	movq	%r13, %xmm0
	movhps	72(%rsp), %xmm0
	movaps	%xmm0, 416(%rsp)
	movq	64(%rsp), %xmm0
	punpcklqdq	%xmm7, %xmm0
	movaps	%xmm0, 432(%rsp)
	call	fork@PLT
	movl	%eax, %r13d
	testl	%eax, %eax
	js	.L161
	je	.L162
.L58:
	xorl	%edx, %edx
	leaq	108(%rsp), %rsi
	movl	%r13d, %edi
	movl	$0, 108(%rsp)
	call	waitpid@PLT
	testl	%eax, %eax
	js	.L59
	testw	$-129, 108(%rsp)
	je	.L60
.L59:
	movq	%r15, %rdi
	call	unlink@PLT
	leaq	.LC34(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L60:
	movq	%r12, %rsi
	movq	%r15, %rdi
	call	rename@PLT
	testl	%eax, %eax
	je	.L54
	movq	%r15, %rdi
	call	unlink@PLT
	leaq	.LC35(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4
	.p2align 3
.L54:
	leaq	libb_o_path.0(%rip), %r12
	jmp	.L47
	.p2align 4,,10
	.p2align 3
.L157:
	movq	%r15, %rsi
	leaq	.LC20(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L51
	.p2align 4,,10
	.p2align 3
.L154:
	call	free@PLT
	jmp	.L84
.L158:
	movq	64(%rsp), %rsi
	leaq	.LC22(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L53
.L159:
	movq	stderr(%rip), %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC23(%rip), %rdi
	call	fwrite@PLT
	jmp	.L55
.L160:
	movl	%eax, 92(%rsp)
	leaq	.LC29(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movl	92(%rsp), %edx
	jmp	.L56
.L161:
	leaq	.LC33(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L58
.L150:
	xorl	%eax, %eax
	leaq	.LC7(%rip), %rdi
	call	dief@PLT
	movq	32(%rsp), %rax
	movq	8(%rax), %r14
	jmp	.L63
.L162:
	leaq	.LC9(%rip), %rdi
	leaq	368(%rsp), %rsi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
.L156:
	movq	%r15, %rsi
	leaq	.LC20(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L49
.L153:
	leaq	.LC9(%rip), %rdi
	movq	%r13, %rsi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
	.cfi_endproc
.LFE21:
	.size	run_gcc_multi, .-run_gcc_multi
	.section	.rodata.str1.1
.LC50:
	.string	"Reading %s...\n"
.LC52:
	.string	"Lexing...\n"
.LC53:
	.string	"Parsing...\n"
.LC54:
	.string	"Semantic analysis...\n"
.LC55:
	.string	"Code generation...\n"
.LC56:
	.string	"w"
.LC57:
	.string	"mkstemp failed: %s"
.LC58:
	.string	"wb"
.LC59:
	.string	"fdopen failed"
.LC60:
	.string	"%s.c"
.LC61:
	.string	"rename temp failed: %s"
.LC62:
	.string	"cannot reopen '%s': %s"
.LC63:
	.string	"r"
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
	movl	%r8d, %r15d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%edx, %r14d
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
	subq	$232, %rsp
	.cfi_def_cfa_offset 288
	movl	%esi, 4(%rsp)
	testl	%ecx, %ecx
	jne	.L208
	leaq	88(%rsp), %rsi
	leaq	112(%rsp), %r13
	movq	$0, 88(%rsp)
	call	read_file_all
	movl	$12, %ecx
	xorl	%esi, %esi
	movq	%rbx, %r8
	leaq	128(%rsp), %rdx
	movq	%rax, %r12
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	movq	%r12, 112(%rsp)
	rep stosq
	movq	88(%rsp), %rax
	leaq	16(%rsp), %rdi
	movl	$1, %ecx
	movq	%rbx, 144(%rsp)
	movq	%rax, 120(%rsp)
	movq	.LC51(%rip), %rax
	movq	%r12, 208(%rsp)
	movq	%rax, 136(%rsp)
	call	mk_tok@PLT
	movdqu	16(%rsp), %xmm0
	movq	64(%rsp), %rax
	movq	%r13, %rdi
	movups	%xmm0, 152(%rsp)
	movdqu	32(%rsp), %xmm0
	movq	%rax, 200(%rsp)
	movups	%xmm0, 168(%rsp)
	movdqu	48(%rsp), %xmm0
	movups	%xmm0, 184(%rsp)
	call	next@PLT
	testl	%r15d, %r15d
	jne	.L188
	movq	%r13, %rdi
	call	parse_program_ast@PLT
	leaq	152(%rsp), %rdi
	movq	%rax, %r13
	call	tok_free@PLT
	testl	%ebp, %ebp
	jne	.L209
.L170:
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	sem_check_program@PLT
.L172:
	movl	296(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L173
	cmpq	$0, 304(%rsp)
	je	.L173
	movq	304(%rsp), %rdi
	call	strdup@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L210
.L174:
	leaq	.LC56(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	je	.L211
.L176:
	subq	$8, %rsp
	.cfi_def_cfa_offset 296
	movq	%r13, %rsi
	movl	%r14d, %r8d
	movq	%rbx, %rdx
	movl	328(%rsp), %eax
	movq	%r15, %rdi
	pushq	%rax
	.cfi_def_cfa_offset 304
	movl	328(%rsp), %r9d
	movl	20(%rsp), %ecx
	call	emit_program_c_ext@PLT
	movq	%r15, %rdi
	call	fclose@PLT
	popq	%rcx
	.cfi_def_cfa_offset 296
	popq	%rsi
	.cfi_def_cfa_offset 288
	movl	288(%rsp), %edi
	testl	%edi, %edi
	jne	.L212
.L183:
	movq	%r12, %rdi
	call	free@PLT
.L163:
	addq	$232, %rsp
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
.L173:
	.cfi_restore_state
	movdqa	.LC64(%rip), %xmm0
	leaq	96(%rsp), %r15
	movq	%r15, %rdi
	movaps	%xmm0, 96(%rsp)
	call	mkstemp@PLT
	movl	%eax, %ebp
	testl	%eax, %eax
	js	.L213
.L177:
	leaq	.LC58(%rip), %rsi
	movl	%ebp, %edi
	call	fdopen@PLT
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L214
.L178:
	movq	%r15, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L215
.L179:
	leaq	.LC60(%rip), %rsi
	movq	%r15, %rdx
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	8(%rsp), %rdi
	call	fclose@PLT
	movq	%rbp, %rsi
	movq	%r15, %rdi
	call	rename@PLT
	testl	%eax, %eax
	jne	.L216
.L180:
	leaq	.LC56(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	jne	.L176
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rsi
	leaq	.LC62(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L176
	.p2align 4,,10
	.p2align 3
.L209:
	movq	%r13, %rdi
	call	dump_ast_program@PLT
	movl	288(%rsp), %edx
	testl	%edx, %edx
	jne	.L170
.L187:
	movq	%r12, %rdi
	xorl	%ebp, %ebp
	call	free@PLT
	jmp	.L163
	.p2align 4,,10
	.p2align 3
.L208:
	movq	%rdi, %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC50(%rip), %rsi
	leaq	112(%rsp), %r13
	call	fprintf@PLT
	leaq	88(%rsp), %rsi
	movq	%rbx, %rdi
	movq	$0, 88(%rsp)
	call	read_file_all
	movl	$12, %ecx
	xorl	%esi, %esi
	movq	%rbx, %r8
	leaq	128(%rsp), %rdx
	movq	%rax, %r12
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	movq	%r12, 112(%rsp)
	rep stosq
	movq	88(%rsp), %rax
	movl	$1, %ecx
	leaq	16(%rsp), %rdi
	movq	%rbx, 144(%rsp)
	movq	%rax, 120(%rsp)
	movq	.LC51(%rip), %rax
	movq	%r12, 208(%rsp)
	movq	%rax, 136(%rsp)
	call	mk_tok@PLT
	movdqu	16(%rsp), %xmm0
	movq	64(%rsp), %rax
	movq	%r13, %rdi
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
	leaq	.LC52(%rip), %rdi
	call	fwrite@PLT
	testl	%r15d, %r15d
	jne	.L188
	movq	stderr(%rip), %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC53(%rip), %rdi
	call	fwrite@PLT
	movq	%r13, %rdi
	call	parse_program_ast@PLT
	leaq	152(%rsp), %rdi
	movq	%rax, %r13
	call	tok_free@PLT
	testl	%ebp, %ebp
	jne	.L217
.L168:
	movq	stderr(%rip), %rcx
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC54(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	sem_check_program@PLT
	movl	$19, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC55(%rip), %rdi
	call	fwrite@PLT
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L212:
	leaq	.LC63(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	jne	.L184
	jmp	.L183
	.p2align 4,,10
	.p2align 3
.L186:
	movq	stdout(%rip), %rsi
	call	putc@PLT
.L184:
	movq	%rbx, %rdi
	call	fgetc@PLT
	movl	%eax, %edi
	cmpl	$-1, %eax
	jne	.L186
	movq	%rbx, %rdi
	call	fclose@PLT
	jmp	.L183
	.p2align 4,,10
	.p2align 3
.L216:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC61(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L180
	.p2align 4,,10
	.p2align 3
.L213:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC57(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L177
	.p2align 4,,10
	.p2align 3
.L217:
	movq	%r13, %rdi
	call	dump_ast_program@PLT
	movl	288(%rsp), %eax
	testl	%eax, %eax
	jne	.L168
	jmp	.L187
	.p2align 4,,10
	.p2align 3
.L188:
	movq	%r13, %rdi
	xorl	%ebp, %ebp
	call	dump_token_stream@PLT
	movq	%r12, %rdi
	call	free@PLT
	jmp	.L163
.L210:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L174
.L215:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L179
.L211:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L176
.L214:
	leaq	.LC59(%rip), %rdi
	call	dief@PLT
	jmp	.L178
	.cfi_endproc
.LFE22:
	.size	compile_b_to_c, .-compile_b_to_c
	.section	.rodata.str1.1
.LC65:
	.string	"a.out"
.LC66:
	.string	"--asm"
.LC67:
	.string	"--keep-c"
.LC68:
	.string	"--emit-c"
.LC69:
	.string	"-Wno-all"
.LC70:
	.string	"-Wno-extra"
.LC71:
	.string	"--byteptr"
.LC72:
	.string	"--wordptr"
.LC73:
	.string	"--word="
.LC74:
	.string	"16"
.LC75:
	.string	"32"
.LC76:
	.string	"host"
	.section	.rodata.str1.8
	.align 8
.LC77:
	.string	"--word must be 16, 32, or host"
	.section	.rodata.str1.1
.LC78:
	.string	"--strict"
.LC79:
	.string	"--pedantic"
.LC80:
	.string	"--dump-tokens"
.LC81:
	.string	"--dump-ast"
.LC82:
	.string	"--dump-c"
.LC83:
	.string	"--no-line"
.LC84:
	.string	"--verbose-errors"
.LC85:
	.string	"-v"
.LC86:
	.string	"--inline-runtime"
.LC87:
	.string	"missing value after -o"
.LC88:
	.string	"-l"
.LC89:
	.string	"missing value after -l"
.LC90:
	.string	"ncurses"
.LC91:
	.string	"ncursesw"
.LC92:
	.string	"curses"
.LC93:
	.string	"panel"
.LC94:
	.string	"panelw"
.LC95:
	.string	"-l%s"
.LC96:
	.string	"-X"
.LC97:
	.string	"missing value after -X"
.LC98:
	.string	"unknown option: %s"
.LC99:
	.string	"usage:\n"
	.section	.rodata.str1.8
	.align 8
.LC100:
	.string	"  %s [options] input.b ... [-o out]\n"
	.section	.rodata.str1.1
.LC101:
	.string	"Multi-file compilation:\n"
	.section	.rodata.str1.8
	.align 8
.LC102:
	.string	"  %s a.b b.b c.b -o prog    compile and link multiple .b files\n"
	.section	.rodata.str1.1
.LC103:
	.string	"options:\n"
	.section	.rodata.str1.8
	.align 8
.LC104:
	.string	"  -S          emit C code to stdout (single file only)\n"
	.align 8
.LC105:
	.string	"  --asm       emit assembly code to stdout (single file only)\n"
	.align 8
.LC106:
	.string	"  -c          compile to object file(s), don't link\n"
	.align 8
.LC107:
	.string	"  -E          emit C code to file (single file only)\n"
	.align 8
.LC108:
	.string	"  --keep-c    keep generated C files\n"
	.align 8
.LC109:
	.string	"  --emit-c    use a.b -> a.b.c naming for C files (implies --keep-c)\n"
	.align 8
.LC110:
	.string	"  -g          include debug information\n"
	.align 8
.LC111:
	.string	"  -l LIB      pass library to linker (can be repeated)\n"
	.align 8
.LC112:
	.string	"  -X FLAG     pass FLAG directly to gcc (can be repeated)\n"
	.align 8
.LC113:
	.string	"  -Wall       enable all warnings (default)\n"
	.align 8
.LC114:
	.string	"  -Wno-all    disable all warnings\n"
	.align 8
.LC115:
	.string	"  -Wextra     enable extra warnings (default)\n"
	.align 8
.LC116:
	.string	"  -Wno-extra  disable extra warnings\n"
	.align 8
.LC117:
	.string	"  -Werror     treat warnings as errors\n"
	.align 8
.LC118:
	.string	"  --byteptr   use byte-addressed pointers\n"
	.align 8
.LC119:
	.string	"  --wordptr   use word-addressed pointers (strict/16-bit default)\n"
	.align 8
.LC120:
	.string	"  --word=N    word size: 16, 32, or host (default: host)\n"
	.align 8
.LC121:
	.string	"              16-bit mode uses translated B addresses and packed words\n"
	.align 8
.LC122:
	.string	"  -v          verbose compilation output\n"
	.align 8
.LC123:
	.string	"  --inline-runtime  embed runtime in each C file (old behavior)\n"
	.section	.rodata.str1.1
.LC124:
	.string	"Strictness:\n"
	.section	.rodata.str1.8
	.align 8
.LC125:
	.string	"  --strict        select the Thompson PDP-11 B72 dialect checks\n"
	.align 8
.LC126:
	.string	"  --pedantic      error on any non-standard syntax (use with --strict)\n"
	.align 8
.LC127:
	.string	"Extensions disabled by --strict:\n"
	.align 8
.LC128:
	.string	"  - Hex literals (0x...)       use octal instead\n"
	.align 8
.LC129:
	.string	"  - Line comments (//)         use /* */ instead\n"
	.align 8
.LC130:
	.string	"  - Backslash escapes (\\n)     use *n instead\n"
	.align 8
.LC131:
	.string	"  - C-style compound (+=)      use =+ instead\n"
	.align 8
.LC132:
	.string	"  - Bracketed auto vectors      use auto v 3; instead\n"
	.align 8
.LC133:
	.string	"  - break/continue/default      ordinary identifiers in B72\n"
	.align 8
.LC134:
	.string	"  - Logical OR (||)            use | or ?: instead\n"
	.align 8
.LC135:
	.string	"  - Long char constants        use one or two chars\n"
	.align 8
.LC136:
	.string	"  --dump-tokens  show tokenized input\n"
	.align 8
.LC137:
	.string	"  --dump-ast     show parsed AST\n"
	.align 8
.LC138:
	.string	"  --dump-c       emit generated C even when compiling\n"
	.align 8
.LC139:
	.string	"  --no-line      disable #line directives\n"
	.align 8
.LC140:
	.string	"  --verbose-errors use verbose error messages instead of 2-letter codes\n"
	.align 8
.LC141:
	.string	"-c with -o requires exactly one input"
	.align 8
.LC142:
	.string	"inputs produce the same object path '%s'; compile them separately with -o"
	.align 8
.LC143:
	.string	"--asm only works with a single input file"
	.section	.rodata.str1.1
.LC144:
	.string	"-S"
.LC145:
	.string	"-"
.LC146:
	.string	"Generated C: %s\n"
	.section	.rodata.str1.8
	.align 8
.LC147:
	.string	"-S and --asm only work with a single input file"
	.align 8
.LC148:
	.string	"-E only works with a single input file"
	.section	.rodata.str1.1
.LC149:
	.string	"Compiled %s -> %s\n"
.LC150:
	.string	"Linking %zu file(s)...\n"
.LC152:
	.string	"gcc failed (exit %d)\n"
.LC153:
	.string	"Generated C files:\n"
.LC154:
	.string	"  %s\n"
.LC155:
	.string	"Kept: %s\n"
	.section	.rodata.str1.8
	.align 8
.LC156:
	.string	"duplicate external function '%s'"
	.align 8
.LC157:
	.string	"conflicting external definition '%s'"
	.align 8
.LC158:
	.string	"duplicate external variable '%s'"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
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
	subq	$456, %rsp
	.cfi_def_cfa_offset 512
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
	jle	.L315
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
	jmp	.L241
	.p2align 4,,10
	.p2align 3
.L436:
	cmpb	$83, 1(%r15)
	jne	.L345
	cmpb	$0, 2(%r15)
	jne	.L345
	movl	$1, 8(%rsp)
.L221:
	addl	$1, %r14d
	cmpl	%r14d, %ebp
	jle	.L435
.L241:
	movslq	%r14d, %rax
	movq	(%rbx,%rax,8), %r15
	leaq	0(,%rax,8), %r12
	movzbl	(%r15), %r13d
	cmpl	$45, %r13d
	je	.L436
.L345:
	leaq	.LC66(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L317
	cmpl	$45, %r13d
	je	.L437
.L347:
	leaq	.LC67(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L438
.L432:
	movl	$1, 92(%rsp)
	jmp	.L221
	.p2align 4,,10
	.p2align 3
.L317:
	addl	$1, %r14d
	movl	$1, 48(%rsp)
	cmpl	%r14d, %ebp
	jg	.L241
.L435:
	movl	16(%rsp), %ecx
	movl	24(%rsp), %edx
	testl	%ecx, %ecx
	je	.L219
.L242:
	movq	248(%rsp), %rax
	movl	%edx, g_verbose_errors(%rip)
	movl	$1, g_no_line(%rip)
	testq	%rax, %rax
	je	.L439
	movl	60(%rsp), %r11d
	pxor	%xmm0, %xmm0
	movq	$0, 288(%rsp)
	movaps	%xmm0, 272(%rsp)
	testl	%r11d, %r11d
	jne	.L245
	cmpq	$0, 40(%rsp)
	je	.L440
.L247:
	movq	40(%rsp), %rdi
	leaq	240(%rsp), %rsi
	call	protect_input
.L260:
	movq	248(%rsp), %rdx
	cmpq	$1, %rdx
	jbe	.L261
	cmpl	$0, 56(%rsp)
	je	.L441
.L261:
	movl	48(%rsp), %r9d
	testl	%r9d, %r9d
	jne	.L442
	cmpl	$0, 8(%rsp)
	jne	.L443
.L284:
	cmpl	$0, 72(%rsp)
	je	.L287
	cmpq	$1, %rdx
	jbe	.L288
	leaq	.LC148(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L288:
	movq	240(%rsp), %rax
	xorl	%ecx, %ecx
	leaq	304(%rsp), %rsi
	leaq	144(%rsp), %r13
	leaq	336(%rsp), %r12
	movq	(%rax), %rbp
	movq	%rcx, 304(%rsp)
	movq	%rbp, %rdi
	call	read_file_all
	movl	$24, %ecx
	movq	%rbp, %r8
	xorl	%esi, %esi
	leaq	352(%rsp), %rdx
	movq	%rax, %rbx
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	rep stosl
	movq	304(%rsp), %rax
	movq	%r13, %rdi
	movl	$1, %ecx
	movq	%rbx, 336(%rsp)
	movq	%rax, 344(%rsp)
	movq	.LC51(%rip), %rax
	movq	%rbp, 368(%rsp)
	movq	%rax, 360(%rsp)
	movq	%rbx, 432(%rsp)
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
	movq	40(%rsp), %rdi
	leaq	.LC56(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L444
.L289:
	movl	32(%rsp), %r9d
	movl	36(%rsp), %ecx
	movq	%r13, %rdi
	movq	%rbp, %rdx
	movl	$1, %r8d
	movq	%r12, %rsi
	call	emit_program_c@PLT
	movq	%r13, %rdi
	call	fclose@PLT
.L433:
	movq	%rbx, %rdi
	call	free@PLT
.L434:
	movq	g_compilation_arena(%rip), %rdi
	xorl	%ebp, %ebp
	call	arena_free@PLT
	xorl	%edx, %edx
	movq	%rdx, g_compilation_arena(%rip)
.L218:
	addq	$456, %rsp
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
.L437:
	.cfi_restore_state
	cmpb	$99, 1(%r15)
	je	.L445
.L346:
	cmpl	$45, %r13d
	jne	.L347
	cmpb	$69, 1(%r15)
	jne	.L347
	cmpb	$0, 2(%r15)
	jne	.L347
	movl	$1, 72(%rsp)
	jmp	.L221
.L315:
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	xorl	%r12d, %r12d
	xorl	%ebp, %ebp
	xorl	%r14d, %r14d
	movq	%rbp, 40(%rsp)
	xorl	%edx, %edx
	movl	$1, 52(%rsp)
	movl	%r12d, 32(%rsp)
	movl	%r12d, 88(%rsp)
	movl	%r13d, 68(%rsp)
	movl	%r13d, 64(%rsp)
	movl	%r13d, 56(%rsp)
	movl	$1, 36(%rsp)
	movl	%r14d, 96(%rsp)
	movl	$1, 84(%rsp)
	movl	$1, 80(%rsp)
	movl	%r15d, 76(%rsp)
	movl	%r15d, 100(%rsp)
	movl	%r15d, 92(%rsp)
	movl	%r15d, 72(%rsp)
	movl	%r15d, 60(%rsp)
	movl	%r15d, 48(%rsp)
	movl	%r15d, 8(%rsp)
.L219:
	cmpl	$0, g_strict(%rip)
	setne	%al
	cmpl	$16, 32(%rsp)
	sete	%cl
	orl	%ecx, %eax
	xorl	$1, %eax
	andl	%eax, 36(%rsp)
	jmp	.L242
.L445:
	cmpb	$0, 2(%r15)
	jne	.L346
	movl	$1, 60(%rsp)
	jmp	.L221
.L245:
	cmpq	$0, 40(%rsp)
	je	.L248
	subq	$1, %rax
	je	.L248
	xorl	%eax, %eax
	leaq	.LC141(%rip), %rdi
	call	dief@PLT
	cmpq	$0, 248(%rsp)
	je	.L249
.L248:
	leaq	272(%rsp), %rax
	leaq	240(%rsp), %r15
	xorl	%r12d, %r12d
	movq	%rax, 16(%rsp)
	leaq	.LC142(%rip), %r13
	movq	%r15, 24(%rsp)
	movq	40(%rsp), %r15
	.p2align 4
	.p2align 3
.L256:
	testq	%r15, %r15
	je	.L250
	movq	%r15, %rdi
	call	sdup@PLT
	movq	%rax, %rbx
.L251:
	xorl	%ebp, %ebp
	cmpq	$0, 280(%rsp)
	jne	.L255
	jmp	.L259
	.p2align 4,,10
	.p2align 3
.L258:
	addq	$1, %rbp
	cmpq	280(%rsp), %rbp
	jnb	.L259
.L255:
	movq	272(%rsp), %rax
	movq	%rbx, %rdi
	movq	(%rax,%rbp,8), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L258
	movq	%rbx, %rsi
	movq	%r13, %rdi
	addq	$1, %rbp
	call	dief@PLT
	cmpq	280(%rsp), %rbp
	jb	.L255
.L259:
	movq	24(%rsp), %rsi
	movq	%rbx, %rdi
	addq	$1, %r12
	call	protect_input
	movq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	vec_push@PLT
	cmpq	248(%rsp), %r12
	jb	.L256
	cmpq	$0, 40(%rsp)
	jne	.L260
	leaq	.LC65(%rip), %rax
	movq	%rax, 40(%rsp)
	jmp	.L260
.L438:
	leaq	.LC68(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L321
	leaq	.LC39(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L322
	leaq	.LC36(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L323
	leaq	.LC69(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L324
	leaq	.LC37(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L325
	leaq	.LC70(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L326
	leaq	.LC38(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L327
	leaq	.LC71(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L328
	leaq	.LC72(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L329
	movl	$7, %edx
	leaq	.LC73(%rip), %rsi
	movq	%r15, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L224
	addq	$7, %r15
	leaq	.LC74(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L330
	leaq	.LC75(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L331
	leaq	.LC76(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L446
	xorl	%eax, %eax
	movl	%eax, 32(%rsp)
	jmp	.L221
	.p2align 4,,10
	.p2align 3
.L250:
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
	je	.L253
	cmpq	%rax, %r14
	je	.L253
	subq	%r14, %rbp
.L254:
	leaq	3(%rbp), %rdi
	call	xmalloc@PLT
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rax, %rbx
	movq	%rax, %rdi
	call	memcpy@PLT
	addq	%rbx, %rbp
	movl	$28462, %r10d
	movw	%r10w, 0(%rbp)
	movb	$0, 2(%rbp)
	jmp	.L251
.L253:
	movq	%r14, %rdi
	call	strlen@PLT
	movq	%rax, %rbp
	jmp	.L254
.L441:
	movl	64(%rsp), %eax
	xorl	$1, %eax
	orl	68(%rsp), %eax
	je	.L262
	leaq	336(%rsp), %rax
	leaq	304(%rsp), %r14
	xorl	%r13d, %r13d
	movq	%rax, 104(%rsp)
	leaq	352(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	376(%rsp), %rax
	movq	%rax, 120(%rsp)
	movq	%r14, 136(%rsp)
	.p2align 4
	.p2align 3
.L264:
	movq	240(%rsp), %rax
	movq	136(%rsp), %rsi
	xorl	%r14d, %r14d
	movq	(%rax,%r13,8), %rbx
	movq	$0, 304(%rsp)
	movq	%rbx, %rdi
	call	read_file_all
	movq	112(%rsp), %rdi
	movq	%rbx, %r8
	xorl	%esi, %esi
	movq	%rax, %rbp
	movl	$12, %ecx
	xorl	%eax, %eax
	movl	$1, %edx
	rep stosq
	movq	304(%rsp), %rax
	movl	$1, %ecx
	movq	128(%rsp), %rdi
	movq	%rbx, 368(%rsp)
	movq	%rax, 344(%rsp)
	movq	.LC51(%rip), %rax
	movq	%rbp, 336(%rsp)
	movq	%rax, 360(%rsp)
	movq	%rbp, 432(%rsp)
	call	mk_tok@PLT
	movq	104(%rsp), %rbx
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
	movq	120(%rsp), %rdi
	movq	%rax, %r15
	call	tok_free@PLT
	cmpq	$0, 8(%r15)
	je	.L279
	movq	%rbp, 24(%rsp)
	movq	%r15, %rbp
	movq	%r14, %r15
	movq	%r13, 16(%rsp)
	jmp	.L263
	.p2align 4,,10
	.p2align 3
.L265:
	cmpl	$2, %eax
	je	.L447
.L272:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L448
.L263:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rcx
	movl	(%rcx), %eax
	cmpl	$1, %eax
	jne	.L265
	movq	8(%rcx), %rax
	movq	8+g_known_variables(%rip), %r13
	movq	(%rax), %r14
	leaq	g_known_variables(%rip), %rax
	movq	(%rax), %r12
	testq	%r13, %r13
	je	.L266
	xorl	%ebx, %ebx
	jmp	.L268
	.p2align 4,,10
	.p2align 3
.L449:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L266
.L268:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L449
	movq	%r14, %rsi
	leaq	.LC157(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L266:
	movq	8+g_known_functions(%rip), %r13
	movq	g_known_functions(%rip), %r12
	testq	%r13, %r13
	je	.L269
	xorl	%ebx, %ebx
	jmp	.L271
	.p2align 4,,10
	.p2align 3
.L450:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L269
.L271:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L450
	movq	%r14, %rsi
	leaq	.LC156(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L269:
	movq	%r14, %rdi
	addq	$1, %r15
	call	sdup@PLT
	leaq	g_known_functions(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpq	8(%rbp), %r15
	jb	.L263
.L448:
	movq	16(%rsp), %r13
	movq	24(%rsp), %rbp
.L279:
	movq	%rbp, %rdi
	addq	$1, %r13
	call	free@PLT
	movq	248(%rsp), %rdx
	cmpq	%rdx, %r13
	jb	.L264
	jmp	.L261
.L442:
	subq	$1, %rdx
	jne	.L313
.L281:
	pushq	%r8
	.cfi_def_cfa_offset 520
	xorl	%r9d, %r9d
	xorl	%r8d, %r8d
	movl	$1, %edx
	pushq	$0
	.cfi_def_cfa_offset 528
	movl	48(%rsp), %r15d
	pushq	%r15
	.cfi_def_cfa_offset 536
	pushq	$0
	.cfi_def_cfa_offset 544
	pushq	$0
	.cfi_def_cfa_offset 552
	pushq	$0
	.cfi_def_cfa_offset 560
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
	.cfi_def_cfa_offset 512
	movq	%rax, %rbx
	xorl	%eax, %eax
	leaq	336(%rsp), %rbp
	rep stosl
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	leaq	208(%rsp), %r12
	call	vec_push@PLT
	leaq	.LC144(%rip), %rdi
	call	sdup@PLT
	movq	%r12, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	pushq	%r14
	.cfi_def_cfa_offset 520
	xorl	%edx, %edx
	movq	%rbp, %rdi
	pushq	%r15
	.cfi_def_cfa_offset 528
	leaq	.LC145(%rip), %rsi
	pushq	%r13
	.cfi_def_cfa_offset 536
	pushq	$0
	.cfi_def_cfa_offset 544
	pushq	%r12
	.cfi_def_cfa_offset 552
	movl	136(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 560
	movl	132(%rsp), %r9d
	movl	128(%rsp), %r8d
	movl	124(%rsp), %ecx
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 512
	movl	%eax, %ebp
	movl	92(%rsp), %eax
	orl	%ebp, %eax
	jne	.L451
	movq	%rbx, %rdi
	call	unlink@PLT
.L283:
	movq	%rbx, %rdi
	call	free@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%edi, %edi
	movq	%rdi, g_compilation_arena(%rip)
	jmp	.L218
.L287:
	movl	72(%rsp), %eax
	leaq	304(%rsp), %r14
	movl	$6, %ecx
	xorl	%ebx, %ebx
	movq	%r14, %rdi
	leaq	240(%rsp), %r13
	rep stosl
	testq	%rdx, %rdx
	je	.L297
	movq	%r13, 16(%rsp)
	movl	100(%rsp), %r15d
	movq	%r14, 8(%rsp)
	movl	88(%rsp), %r13d
	jmp	.L290
	.p2align 4,,10
	.p2align 3
.L293:
	subq	$8, %rsp
	.cfi_def_cfa_offset 520
	movl	%r13d, %ecx
	movl	$1, %edx
	movq	%r12, %rdi
	movl	60(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 528
	movl	48(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 536
	pushq	$0
	.cfi_def_cfa_offset 544
	pushq	$0
	.cfi_def_cfa_offset 552
	movl	108(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 560
	movl	112(%rsp), %r9d
	movl	104(%rsp), %r8d
	movl	84(%rsp), %esi
	call	compile_b_to_c
	addq	$48, %rsp
	.cfi_def_cfa_offset 512
	movq	%rax, %r14
.L312:
	testq	%r14, %r14
	je	.L434
	movq	8(%rsp), %rdi
	movq	%r14, %rsi
	call	vec_push@PLT
	testl	%r13d, %r13d
	jne	.L452
.L296:
	addq	$1, %rbx
	cmpq	248(%rsp), %rbx
	jnb	.L453
.L290:
	movq	240(%rsp), %rax
	movq	(%rax,%rbx,8), %r12
	testl	%r15d, %r15d
	je	.L293
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L454
.L294:
	movq	%r12, %rdx
	movq	%rbp, %rdi
	leaq	.LC60(%rip), %rsi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	16(%rsp), %rsi
	movq	%rbp, %rdi
	call	protect_input
	subq	$8, %rsp
	.cfi_def_cfa_offset 520
	movq	%r12, %rdi
	movl	%r13d, %ecx
	movl	60(%rsp), %eax
	movl	$1, %edx
	pushq	%rax
	.cfi_def_cfa_offset 528
	movl	48(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 536
	pushq	%rbp
	.cfi_def_cfa_offset 544
	pushq	$1
	.cfi_def_cfa_offset 552
	movl	108(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 560
	movl	112(%rsp), %r9d
	movl	104(%rsp), %r8d
	movl	84(%rsp), %esi
	call	compile_b_to_c
	addq	$48, %rsp
	.cfi_def_cfa_offset 512
	movq	%rbp, %rdi
	movq	%rax, %r14
	call	free@PLT
	jmp	.L312
.L451:
	movq	stderr(%rip), %rdi
	movq	%rbx, %rdx
	leaq	.LC146(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L283
.L262:
	cmpl	$0, 48(%rsp)
	jne	.L313
	cmpl	$0, 8(%rsp)
	je	.L284
.L314:
	leaq	.LC147(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L285:
	movq	240(%rsp), %rax
	xorl	%esi, %esi
	leaq	144(%rsp), %r13
	leaq	336(%rsp), %r12
	movq	(%rax), %rbp
	movq	%rsi, 304(%rsp)
	leaq	304(%rsp), %rsi
	movq	%rbp, %rdi
	call	read_file_all
	movl	$24, %ecx
	movq	%rbp, %r8
	xorl	%esi, %esi
	leaq	352(%rsp), %rdx
	movq	%rax, %rbx
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	rep stosl
	movq	304(%rsp), %rax
	movq	%r13, %rdi
	movl	$1, %ecx
	movq	%rbx, 336(%rsp)
	movq	%rax, 344(%rsp)
	movq	.LC51(%rip), %rax
	movq	%rbp, 368(%rsp)
	movq	%rax, 360(%rsp)
	movq	%rbx, 432(%rsp)
	call	mk_tok@PLT
	leaq	376(%rsp), %rdi
	movq	%r13, %rsi
	movl	$14, %ecx
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
	movl	32(%rsp), %r9d
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movl	36(%rsp), %ecx
	movq	stdout(%rip), %rdi
	movl	$1, %r8d
	call	emit_program_c@PLT
	jmp	.L433
.L321:
	movl	$1, 100(%rsp)
	jmp	.L432
.L313:
	leaq	.LC143(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L281
	.p2align 4,,10
	.p2align 3
.L447:
	movq	8(%rcx), %rax
	movq	8+g_known_functions(%rip), %r13
	movq	g_known_functions(%rip), %r12
	movq	16(%rax), %r14
	testq	%r13, %r13
	je	.L273
	xorl	%ebx, %ebx
	jmp	.L275
	.p2align 4,,10
	.p2align 3
.L455:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L273
.L275:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L455
	movq	%r14, %rsi
	leaq	.LC157(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L273:
	movq	8+g_known_variables(%rip), %r13
	leaq	g_known_variables(%rip), %rax
	movq	(%rax), %r12
	testq	%r13, %r13
	je	.L276
	xorl	%ebx, %ebx
	jmp	.L278
	.p2align 4,,10
	.p2align 3
.L456:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L276
.L278:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L456
	movq	%r14, %rsi
	leaq	.LC158(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L276:
	movq	%r14, %rdi
	call	sdup@PLT
	leaq	g_known_variables(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L272
.L452:
	movq	stderr(%rip), %rdi
	movq	%r14, %rcx
	movq	%r12, %rdx
	xorl	%eax, %eax
	leaq	.LC149(%rip), %rsi
	call	fprintf@PLT
	jmp	.L296
.L443:
	cmpq	$1, %rdx
	jbe	.L285
	jmp	.L314
.L440:
	leaq	.LC65(%rip), %rax
	movq	%rax, 40(%rsp)
	jmp	.L247
.L439:
	movl	$7, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	movl	$2, %ebp
	call	fwrite@PLT
	movq	(%rbx), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC100(%rip), %rsi
	call	fprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$24, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC101(%rip), %rdi
	call	fwrite@PLT
	movq	(%rbx), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC102(%rip), %rsi
	call	fprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$9, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC104(%rip), %rdi
	call	fwrite@PLT
	movl	$62, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movl	$52, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC106(%rip), %rdi
	call	fwrite@PLT
	movl	$53, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	movl	$37, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC108(%rip), %rdi
	call	fwrite@PLT
	movl	$69, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC109(%rip), %rdi
	call	fwrite@PLT
	movl	$40, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC110(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movl	$58, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC112(%rip), %rdi
	call	fwrite@PLT
	movl	$44, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	movl	$35, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC114(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movl	$37, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
	movl	$39, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movl	$42, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	movl	$66, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	movl	$57, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	movl	$71, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
	call	fwrite@PLT
	movl	$41, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	movl	$64, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$12, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
	movl	$64, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC125(%rip), %rdi
	call	fwrite@PLT
	movl	$71, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC126(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	xorl	%ebx, %ebx
	call	fputc@PLT
	movl	$33, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC127(%rip), %rdi
	call	fwrite@PLT
	movl	$49, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC128(%rip), %rdi
	call	fwrite@PLT
	movl	$49, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC130(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movl	$54, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movl	$60, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	movl	$51, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC134(%rip), %rdi
	call	fwrite@PLT
	movl	$52, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$38, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	movl	$33, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movl	$54, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	movl	$42, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	movl	$72, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC140(%rip), %rdi
	call	fwrite@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	movq	%rbx, g_compilation_arena(%rip)
	jmp	.L218
.L453:
	movq	8(%rsp), %r14
.L297:
	cmpl	$0, 88(%rsp)
	jne	.L457
.L292:
	xorl	%ebp, %ebp
	cmpl	$0, 60(%rsp)
	movl	$1, %ebx
	je	.L458
	movl	96(%rsp), %r12d
	movl	36(%rsp), %r13d
	movl	88(%rsp), %r14d
	movl	32(%rsp), %r15d
	jmp	.L298
.L302:
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
	.cfi_def_cfa_offset 520
	pushq	%r15
	.cfi_def_cfa_offset 528
	pushq	%r13
	.cfi_def_cfa_offset 536
	movl	76(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 544
	leaq	240(%rsp), %rax
	pushq	%rax
	.cfi_def_cfa_offset 552
	pushq	%r12
	.cfi_def_cfa_offset 560
	movl	132(%rsp), %r9d
	movl	128(%rsp), %r8d
	movl	124(%rsp), %ecx
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 512
	testl	%eax, %eax
	jne	.L301
	addq	$1, %rbp
.L298:
	cmpq	312(%rsp), %rbp
	jb	.L302
.L303:
	xorl	%ebx, %ebx
	leaq	.LC155(%rip), %r12
	cmpq	$0, 312(%rsp)
	je	.L434
	movl	92(%rsp), %r13d
	movl	88(%rsp), %r14d
	jmp	.L304
.L309:
	testl	%r14d, %r14d
	jne	.L459
.L310:
	movq	%rbp, %rdi
	addq	$1, %rbx
	call	free@PLT
	cmpq	312(%rsp), %rbx
	jnb	.L434
.L304:
	movq	304(%rsp), %rax
	movq	(%rax,%rbx,8), %rbp
	testl	%r13d, %r13d
	jne	.L309
	movq	%rbp, %rdi
	call	unlink@PLT
	jmp	.L310
.L459:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rdx
	movq	%r12, %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L310
.L322:
	movl	$1, 76(%rsp)
	jmp	.L221
.L249:
	xorl	%edx, %edx
	jmp	.L261
.L323:
	movl	$1, 80(%rsp)
	jmp	.L221
.L458:
	movl	88(%rsp), %eax
	xorl	%edx, %edx
	movq	%r14, %rdi
	pushq	%rax
	.cfi_def_cfa_offset 520
	movl	40(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 528
	movl	52(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 536
	movl	76(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 544
	leaq	240(%rsp), %rax
	pushq	%rax
	.cfi_def_cfa_offset 552
	movl	136(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 560
	movl	132(%rsp), %r9d
	movl	128(%rsp), %r8d
	movl	124(%rsp), %ecx
	movq	88(%rsp), %rsi
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 512
	testl	%eax, %eax
	je	.L303
.L301:
	movq	stderr(%rip), %rdi
	movl	%eax, %edx
	leaq	.LC152(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpl	$0, 92(%rsp)
	je	.L305
.L308:
	movq	g_compilation_arena(%rip), %rdi
	movl	$1, %ebp
	call	arena_free@PLT
	xorl	%eax, %eax
	movq	%rax, g_compilation_arena(%rip)
	jmp	.L218
.L457:
	movq	stderr(%rip), %rdi
	movq	312(%rsp), %rdx
	leaq	.LC150(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L292
.L324:
	xorl	%eax, %eax
	movl	%eax, 80(%rsp)
	jmp	.L221
.L305:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC153(%rip), %rdi
	leaq	.LC154(%rip), %rbp
	call	fwrite@PLT
	jmp	.L306
.L307:
	movq	304(%rsp), %rax
	movq	stderr(%rip), %rdi
	movq	%rbp, %rsi
	movq	(%rax,%rbx,8), %rdx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
.L306:
	cmpq	312(%rsp), %rbx
	jb	.L307
	jmp	.L308
.L325:
	movl	$1, 84(%rsp)
	jmp	.L221
.L327:
	movl	$1, 96(%rsp)
	jmp	.L221
.L326:
	xorl	%eax, %eax
	movl	%eax, 84(%rsp)
	jmp	.L221
.L446:
	leaq	.LC77(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L221
.L331:
	movl	$32, 32(%rsp)
	jmp	.L221
.L454:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L294
.L444:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	40(%rsp), %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L289
.L330:
	movl	$16, 32(%rsp)
	jmp	.L221
.L224:
	leaq	.LC78(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L226
	movl	$1, g_strict(%rip)
	xorl	%edx, %edx
	movl	%edx, g_extensions(%rip)
	jmp	.L221
.L329:
	xorl	%eax, %eax
	movl	$1, 16(%rsp)
	movl	%eax, 36(%rsp)
	jmp	.L221
.L328:
	movl	$1, 16(%rsp)
	movl	$1, 36(%rsp)
	jmp	.L221
.L226:
	leaq	.LC79(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L228
	movl	$1, g_pedantic(%rip)
	jmp	.L221
.L228:
	leaq	.LC80(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L333
	leaq	.LC81(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L334
	leaq	.LC82(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L335
	leaq	.LC83(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L221
	leaq	.LC84(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L336
	leaq	.LC85(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L337
	leaq	.LC86(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L338
	leaq	.LC32(%rip), %rsi
	movq	%r15, %rdi
	leal	1(%r14), %r13d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L229
	cmpl	%r13d, %ebp
	jg	.L230
	leaq	.LC87(%rip), %rdi
	call	dief@PLT
.L230:
	movq	8(%rbx,%r12), %rax
	movl	%r13d, %r14d
	movq	%rax, 40(%rsp)
	jmp	.L221
.L229:
	leaq	.LC88(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L231
	cmpl	%r13d, %ebp
	jle	.L460
.L232:
	movq	8(%rbx,%r12), %r12
	leaq	.LC90(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L233
	leaq	.LC91(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L233
	leaq	.LC92(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L233
	leaq	.LC93(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L233
	leaq	.LC94(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L234
.L233:
	movl	$1, g_use_curses(%rip)
.L234:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %r15
	movq	%r15, %rdi
	call	malloc@PLT
	movq	%rax, %r14
	testq	%rax, %rax
	je	.L461
.L235:
	movq	%r15, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	xorl	%eax, %eax
	leaq	.LC95(%rip), %rdx
	call	snprintf@PLT
	leaq	208(%rsp), %rdi
	movq	%r14, %rsi
	call	vec_push@PLT
.L238:
	movl	%r13d, %r14d
	jmp	.L221
.L460:
	leaq	.LC89(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L232
.L461:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L235
.L231:
	leaq	.LC96(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L236
	cmpl	%r13d, %ebp
	jg	.L237
	leaq	.LC97(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L237:
	movq	8(%rbx,%r12), %rdi
	call	sdup@PLT
	leaq	208(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L238
.L236:
	cmpb	$45, (%r15)
	je	.L462
	leaq	240(%rsp), %rax
	movq	%r15, %rsi
	movq	%rax, %rdi
	call	vec_push@PLT
	jmp	.L221
.L338:
	xorl	%eax, %eax
	movl	%eax, 52(%rsp)
	jmp	.L221
.L337:
	movl	$1, 88(%rsp)
	jmp	.L221
.L462:
	movq	%r15, %rsi
	leaq	.LC98(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L221
.L336:
	movl	$1, 24(%rsp)
	jmp	.L221
.L335:
	movl	$1, 68(%rsp)
	jmp	.L221
.L334:
	movl	$1, 64(%rsp)
	jmp	.L221
.L333:
	movl	$1, 56(%rsp)
	jmp	.L221
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.local	libb_o_path.0
	.comm	libb_o_path.0,4096,32
	.local	g_libb_dir
	.comm	g_libb_dir,4096,32
	.section	.data.rel.ro.local,"aw"
	.align 8
.LC44:
	.quad	.LC9
	.align 8
.LC45:
	.quad	.LC12
	.align 8
.LC46:
	.quad	.LC14
	.align 8
.LC47:
	.quad	.LC16
	.align 8
.LC48:
	.quad	.LC30
	.align 8
.LC49:
	.quad	.LC40
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC51:
	.long	1
	.long	1
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC64:
	.quad	7161675788338426927
	.quad	24866934413088863
	.section	.note.GNU-stack,"",@progbits
