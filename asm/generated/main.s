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
	.string	"bprimitives.h"
.LC20:
	.string	"%s/%s"
	.section	.rodata.str1.8
	.align 8
.LC21:
	.string	"cannot read runtime dependency %s"
	.align 8
.LC22:
	.string	"/tmp/bcc_libb_%016lx_%d_%d_%d.o"
	.section	.rodata.str1.1
.LC23:
	.string	"libb.c not found at %s"
.LC24:
	.string	"Compiling runtime library...\n"
.LC25:
	.string	"-I%s"
.LC26:
	.string	"-DB_BYTEPTR=%d"
.LC27:
	.string	"-DWORD_BITS=%d"
.LC28:
	.string	"-D__bcc_strict_runtime=%d"
.LC29:
	.string	"%s.XXXXXX"
.LC30:
	.string	"cannot create runtime object"
.LC31:
	.string	"-O2"
.LC32:
	.string	"-c"
.LC33:
	.string	"-o"
.LC34:
	.string	"fork failed"
.LC35:
	.string	"Failed to compile libb.c"
.LC36:
	.string	"cannot cache runtime object"
.LC37:
	.string	"-Wall"
.LC38:
	.string	"-Wextra"
.LC39:
	.string	"-Werror"
.LC40:
	.string	"-g"
.LC41:
	.string	"-ldl"
.LC42:
	.string	"-lm"
.LC43:
	.string	"Running:"
.LC44:
	.string	" %s"
	.text
	.p2align 4
	.globl	run_gcc_multi
	.type	run_gcc_multi, @function
run_gcc_multi:
.LFB22:
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
	movq	.LC45(%rip), %xmm1
	movq	%rdi, 24(%rsp)
	movl	21024(%rsp), %edi
	punpcklqdq	%xmm2, %xmm1
	movq	%rsi, 56(%rsp)
	testl	%edi, %edi
	movl	%ecx, 64(%rsp)
	setne	%dl
	testl	%ebp, %ebp
	movl	%r8d, 68(%rsp)
	sete	%al
	movl	%r9d, 88(%rsp)
	andb	%al, %dl
	movaps	%xmm1, 32(%rsp)
	movb	%dl, 55(%rsp)
	jne	.L149
	leaq	g_libb_dir(%rip), %rax
	xorl	%r12d, %r12d
	leaq	12752(%rsp), %r15
	movq	%rax, 8(%rsp)
	leaq	.LC25(%rip), %r14
	leaq	.LC33(%rip), %rbx
.L47:
	movq	8(%rsp), %rcx
	movq	%r14, %rdx
	xorl	%eax, %eax
	movl	$4096, %esi
	movq	%r15, %rdi
	call	snprintf@PLT
	movq	24(%rsp), %rax
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
	movdqa	32(%rsp), %xmm3
	movups	%xmm3, 0(%r13)
	testl	%ebp, %ebp
	jne	.L90
	leaq	.LC31(%rip), %rax
	movl	$24, %edx
	movl	$3, %esi
	movq	%rax, 16(%r13)
	movl	$4, %eax
.L64:
	movl	68(%rsp), %r10d
	testl	%r10d, %r10d
	je	.L65
	leaq	.LC37(%rip), %rcx
	movslq	%eax, %rsi
	movq	%rcx, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L65:
	movl	88(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L66
	leaq	.LC38(%rip), %rcx
	movslq	%eax, %rsi
	movq	%rcx, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L66:
	movl	21008(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L67
	leaq	.LC39(%rip), %rcx
	movslq	%eax, %rsi
	movq	%rcx, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L67:
	movl	64(%rsp), %edi
	testl	%edi, %edi
	je	.L68
	leaq	.LC40(%rip), %rcx
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
	leaq	.LC32(%rip), %rcx
	movslq	%eax, %rsi
	movq	%rcx, 0(%r13,%rdx)
	movslq	%eax, %rdx
	addl	$1, %eax
	salq	$3, %rdx
.L70:
	movq	%rbx, 0(%r13,%rdx)
	movq	56(%rsp), %rbx
	cltq
	leal	2(%rsi), %ecx
	movq	%rbx, 0(%r13,%rax,8)
	testq	%r14, %r14
	je	.L71
	movq	24(%rsp), %rax
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
	cmpb	$0, 55(%rsp)
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
	movq	.LC51(%rip), %xmm0
	leaq	.LC42(%rip), %rdx
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
.L155:
	movzbl	%ah, %eax
	jmp	.L46
	.p2align 4,,10
	.p2align 3
.L151:
	movq	stderr(%rip), %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC43(%rip), %rdi
	leaq	8(%r13), %rbx
	leaq	.LC44(%rip), %rbp
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
	movq	%rdi, 72(%rsp)
	leaq	12752(%rsp), %r15
	leaq	.LC3(%rip), %r14
	call	snprintf@PLT
	movl	%ebp, 80(%rsp)
	leaq	.LC13(%rip), %rax
	movq	.LC46(%rip), %xmm0
	movabsq	$1099511628211, %r12
	movq	%rax, %xmm5
	leaq	.LC15(%rip), %rax
	punpcklqdq	%xmm5, %xmm0
	movq	%rax, %xmm6
	leaq	.LC17(%rip), %rax
	movaps	%xmm0, 112(%rsp)
	movq	%rax, %xmm7
	movq	.LC47(%rip), %xmm0
	leaq	.LC19(%rip), %rax
	movq	%rax, %xmm5
	leaq	176(%rsp), %rax
	punpcklqdq	%xmm6, %xmm0
	movq	%rax, 16(%rsp)
	movaps	%xmm0, 128(%rsp)
	movq	.LC48(%rip), %xmm0
	punpcklqdq	%xmm7, %xmm0
	movaps	%xmm0, 144(%rsp)
	movq	.LC49(%rip), %xmm0
	punpcklqdq	%xmm5, %xmm0
	movaps	%xmm0, 160(%rsp)
	.p2align 4
	.p2align 3
.L52:
	movq	0(%r13), %r8
	movq	8(%rsp), %rcx
	movl	$8192, %esi
	xorl	%eax, %eax
	leaq	.LC20(%rip), %rdx
	movq	%r15, %rdi
	call	snprintf@PLT
	movq	%r14, %rsi
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
	movq	16(%rsp), %rax
	cmpq	%rax, %r13
	jne	.L52
	movl	g_strict(%rip), %edx
	movl	80(%rsp), %ebp
	xorl	%eax, %eax
	subq	$8, %rsp
	.cfi_def_cfa_offset 21016
	leaq	libb_o_path.0(%rip), %r12
	movq	%rbx, %rcx
	movl	$4096, %esi
	testl	%edx, %edx
	movq	%r12, %rdi
	leaq	.LC22(%rip), %rdx
	setne	%al
	pushq	%rax
	.cfi_def_cfa_offset 21024
	movl	21056(%rsp), %r9d
	xorl	%eax, %eax
	movl	21048(%rsp), %r8d
	call	snprintf@PLT
	movq	88(%rsp), %rdi
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
	leaq	.LC25(%rip), %r14
	call	access@PLT
	leaq	.LC33(%rip), %rbx
	testl	%eax, %eax
	je	.L54
	movl	21048(%rsp), %eax
	testl	%eax, %eax
	jne	.L159
.L55:
	movq	8(%rsp), %rcx
	leaq	4560(%rsp), %rbx
	leaq	.LC25(%rip), %r14
	xorl	%eax, %eax
	movq	%r14, %rdx
	movl	$8192, %esi
	movq	%rbx, %rdi
	call	snprintf@PLT
	movl	21032(%rsp), %r11d
	xorl	%ecx, %ecx
	movq	16(%rsp), %rdi
	leaq	.LC26(%rip), %rdx
	movl	$64, %esi
	leaq	240(%rsp), %r13
	testl	%r11d, %r11d
	setne	%cl
	xorl	%eax, %eax
	call	snprintf@PLT
	movl	$64, %esi
	movq	%r13, %rdi
	xorl	%eax, %eax
	movl	21040(%rsp), %ecx
	leaq	.LC27(%rip), %rdx
	call	snprintf@PLT
	movl	g_strict(%rip), %eax
	xorl	%ecx, %ecx
	leaq	304(%rsp), %rdi
	leaq	.LC28(%rip), %rdx
	movl	$64, %esi
	movq	%rdi, 80(%rsp)
	testl	%eax, %eax
	setne	%cl
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	%r12, %rcx
	movl	$8192, %esi
	movq	%r15, %rdi
	leaq	.LC29(%rip), %rdx
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
	leaq	.LC32(%rip), %rax
	movq	.LC50(%rip), %xmm0
	movdqa	32(%rsp), %xmm6
	movq	%rax, %xmm7
	movq	%r15, 448(%rsp)
	punpcklqdq	%xmm7, %xmm0
	movaps	%xmm6, 368(%rsp)
	movaps	%xmm0, 384(%rsp)
	movq	%rbx, %xmm0
	leaq	.LC33(%rip), %rbx
	movhps	16(%rsp), %xmm0
	movq	%rbx, %xmm6
	movq	$0, 456(%rsp)
	movaps	%xmm0, 400(%rsp)
	movq	%r13, %xmm0
	movhps	80(%rsp), %xmm0
	movaps	%xmm0, 416(%rsp)
	movq	72(%rsp), %xmm0
	punpcklqdq	%xmm6, %xmm0
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
	leaq	.LC35(%rip), %rdi
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
	leaq	.LC36(%rip), %rdi
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
	leaq	.LC21(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L51
.L154:
	call	free@PLT
	jmp	.L84
.L158:
	movq	72(%rsp), %rsi
	leaq	.LC23(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L53
.L159:
	movq	stderr(%rip), %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC24(%rip), %rdi
	call	fwrite@PLT
	jmp	.L55
.L160:
	movl	%eax, 92(%rsp)
	leaq	.LC30(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movl	92(%rsp), %edx
	jmp	.L56
.L161:
	leaq	.LC34(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L58
.L150:
	xorl	%eax, %eax
	leaq	.LC7(%rip), %rdi
	call	dief@PLT
	movq	24(%rsp), %rax
	movq	8(%rax), %r14
	jmp	.L63
.L162:
	leaq	.LC9(%rip), %rdi
	leaq	368(%rsp), %rsi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
	.p2align 4,,10
	.p2align 3
.L156:
	movq	%r15, %rsi
	leaq	.LC21(%rip), %rdi
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
.LFE22:
	.size	run_gcc_multi, .-run_gcc_multi
	.section	.rodata.str1.1
.LC52:
	.string	"Reading %s...\n"
.LC54:
	.string	"Lexing...\n"
.LC55:
	.string	"Parsing...\n"
.LC56:
	.string	"Semantic analysis...\n"
.LC57:
	.string	"Code generation...\n"
.LC58:
	.string	"w"
.LC59:
	.string	"mkstemp failed: %s"
.LC60:
	.string	"wb"
.LC61:
	.string	"fdopen failed"
.LC62:
	.string	"%s.c"
.LC63:
	.string	"cannot write '%s'"
.LC64:
	.string	"rename temp failed: %s"
.LC65:
	.string	"cannot reopen '%s': %s"
.LC66:
	.string	"r"
.LC67:
	.string	"cannot read '%s'"
	.text
	.p2align 4
	.globl	compile_b_to_c
	.type	compile_b_to_c, @function
compile_b_to_c:
.LFB23:
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
	jne	.L225
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
	movq	.LC53(%rip), %rax
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
	jne	.L192
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	152(%rsp), %rdi
	movq	%rax, %r14
	call	tok_free@PLT
	testl	%ebp, %ebp
	jne	.L226
.L170:
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	sem_check_program@PLT
.L172:
	movl	312(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L173
	cmpq	$0, 320(%rsp)
	je	.L173
	movq	320(%rsp), %rdi
	call	strdup@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L227
.L174:
	leaq	.LC58(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L228
.L176:
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
	je	.L195
	testl	%ebx, %ebx
	jne	.L195
	movl	304(%rsp), %ecx
	testl	%ecx, %ecx
	jne	.L229
.L186:
	movq	%r13, %rdi
	call	free@PLT
.L163:
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
.L173:
	.cfi_restore_state
	movdqa	.LC68(%rip), %xmm0
	leaq	96(%rsp), %r12
	movq	%r12, %rdi
	movaps	%xmm0, 96(%rsp)
	call	mkstemp@PLT
	movl	%eax, %ebp
	testl	%eax, %eax
	js	.L230
.L177:
	leaq	.LC60(%rip), %rsi
	movl	%ebp, %edi
	call	fdopen@PLT
	movq	%rax, (%rsp)
	testq	%rax, %rax
	je	.L231
.L178:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L232
.L179:
	movq	%r12, %rdx
	leaq	.LC62(%rip), %rsi
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
	jne	.L194
	cmpl	$-1, %eax
	je	.L194
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	rename@PLT
	testl	%eax, %eax
	jne	.L233
.L182:
	leaq	.LC58(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	jne	.L176
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rsi
	leaq	.LC65(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L176
	.p2align 4,,10
	.p2align 3
.L226:
	movq	%r14, %rdi
	call	dump_ast_program@PLT
	movl	304(%rsp), %edx
	testl	%edx, %edx
	jne	.L170
.L191:
	movq	%r13, %rdi
	xorl	%ebp, %ebp
	call	free@PLT
	jmp	.L163
	.p2align 4,,10
	.p2align 3
.L194:
	movq	%r12, %rsi
	leaq	.LC63(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	rename@PLT
	testl	%eax, %eax
	je	.L182
.L233:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC64(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L182
	.p2align 4,,10
	.p2align 3
.L195:
	movq	%rbp, %rsi
	leaq	.LC63(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movl	304(%rsp), %ecx
	testl	%ecx, %ecx
	je	.L186
.L229:
	leaq	.LC66(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	jne	.L188
	jmp	.L234
	.p2align 4,,10
	.p2align 3
.L189:
	movq	stdout(%rip), %rsi
	call	putc@PLT
.L188:
	movq	%rbx, %rdi
	call	fgetc@PLT
	movl	%eax, %edi
	cmpl	$-1, %eax
	jne	.L189
	movq	%rbx, %rdi
	call	ferror@PLT
	testl	%eax, %eax
	jne	.L235
.L190:
	movq	%rbx, %rdi
	call	fclose@PLT
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L225:
	movq	%rdi, %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC52(%rip), %rsi
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
	movq	.LC53(%rip), %rax
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
	leaq	.LC54(%rip), %rdi
	call	fwrite@PLT
	testl	%r14d, %r14d
	jne	.L192
	movq	stderr(%rip), %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC55(%rip), %rdi
	call	fwrite@PLT
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	152(%rsp), %rdi
	movq	%rax, %r14
	call	tok_free@PLT
	testl	%ebp, %ebp
	jne	.L236
.L168:
	movq	stderr(%rip), %rcx
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC56(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	sem_check_program@PLT
	movl	$19, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC57(%rip), %rdi
	call	fwrite@PLT
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L235:
	movq	%rbp, %rsi
	leaq	.LC67(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L190
	.p2align 4,,10
	.p2align 3
.L230:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC59(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L177
	.p2align 4,,10
	.p2align 3
.L236:
	movq	%r14, %rdi
	call	dump_ast_program@PLT
	movl	304(%rsp), %eax
	testl	%eax, %eax
	jne	.L168
	jmp	.L191
	.p2align 4,,10
	.p2align 3
.L192:
	movq	%r12, %rdi
	xorl	%ebp, %ebp
	call	dump_token_stream@PLT
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L163
.L227:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L174
.L231:
	leaq	.LC61(%rip), %rdi
	call	dief@PLT
	jmp	.L178
.L232:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L179
.L228:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L176
.L234:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L188
	.cfi_endproc
.LFE23:
	.size	compile_b_to_c, .-compile_b_to_c
	.section	.rodata.str1.1
.LC69:
	.string	"a.out"
.LC70:
	.string	"--asm"
.LC71:
	.string	"--keep-c"
.LC72:
	.string	"--emit-c"
.LC73:
	.string	"-Wno-all"
.LC74:
	.string	"-Wno-extra"
.LC75:
	.string	"--byteptr"
.LC76:
	.string	"--wordptr"
.LC77:
	.string	"--word="
.LC78:
	.string	"16"
.LC79:
	.string	"32"
.LC80:
	.string	"host"
	.section	.rodata.str1.8
	.align 8
.LC81:
	.string	"--word must be 16, 32, or host"
	.section	.rodata.str1.1
.LC82:
	.string	"--strict"
.LC83:
	.string	"--pedantic"
.LC84:
	.string	"--dump-tokens"
.LC85:
	.string	"--dump-ast"
.LC86:
	.string	"--dump-c"
.LC87:
	.string	"--no-line"
.LC88:
	.string	"--verbose-errors"
.LC89:
	.string	"-v"
.LC90:
	.string	"--inline-runtime"
.LC91:
	.string	"missing value after -o"
.LC92:
	.string	"-l"
.LC93:
	.string	"missing value after -l"
.LC94:
	.string	"ncurses"
.LC95:
	.string	"ncursesw"
.LC96:
	.string	"curses"
.LC97:
	.string	"panel"
.LC98:
	.string	"panelw"
.LC99:
	.string	"-l%s"
.LC100:
	.string	"-X"
.LC101:
	.string	"missing value after -X"
.LC102:
	.string	"unknown option: %s"
.LC103:
	.string	"usage:\n"
	.section	.rodata.str1.8
	.align 8
.LC104:
	.string	"  %s [options] input.b ... [-o out]\n"
	.section	.rodata.str1.1
.LC105:
	.string	"Multi-file compilation:\n"
	.section	.rodata.str1.8
	.align 8
.LC106:
	.string	"  %s a.b b.b c.b -o prog    compile and link multiple .b files\n"
	.section	.rodata.str1.1
.LC107:
	.string	"options:\n"
	.section	.rodata.str1.8
	.align 8
.LC108:
	.string	"  -S          emit C code to stdout (single file only)\n"
	.align 8
.LC109:
	.string	"  --asm       emit assembly code to stdout (single file only)\n"
	.align 8
.LC110:
	.string	"  -c          compile to object file(s), don't link\n"
	.align 8
.LC111:
	.string	"  -E          emit C code to file (single file only)\n"
	.align 8
.LC112:
	.string	"  --keep-c    keep generated C files\n"
	.align 8
.LC113:
	.string	"  --emit-c    use a.b -> a.b.c naming for C files (implies --keep-c)\n"
	.align 8
.LC114:
	.string	"  -g          include debug information\n"
	.align 8
.LC115:
	.string	"  -l LIB      pass library to linker (can be repeated)\n"
	.align 8
.LC116:
	.string	"  -X FLAG     pass FLAG directly to gcc (can be repeated)\n"
	.align 8
.LC117:
	.string	"  -Wall       enable all warnings (default)\n"
	.align 8
.LC118:
	.string	"  -Wno-all    disable all warnings\n"
	.align 8
.LC119:
	.string	"  -Wextra     enable extra warnings (default)\n"
	.align 8
.LC120:
	.string	"  -Wno-extra  disable extra warnings\n"
	.align 8
.LC121:
	.string	"  -Werror     treat warnings as errors\n"
	.align 8
.LC122:
	.string	"  --byteptr   use byte-addressed pointers\n"
	.align 8
.LC123:
	.string	"  --wordptr   use word-addressed pointers (strict/16-bit default)\n"
	.align 8
.LC124:
	.string	"  --word=N    word size: 16, 32, or host (default: host)\n"
	.align 8
.LC125:
	.string	"              16-bit mode uses translated B addresses and packed words\n"
	.align 8
.LC126:
	.string	"  -v          verbose compilation output\n"
	.align 8
.LC127:
	.string	"  --inline-runtime  embed runtime in each C file (old behavior)\n"
	.section	.rodata.str1.1
.LC128:
	.string	"Strictness:\n"
	.section	.rodata.str1.8
	.align 8
.LC129:
	.string	"  --strict        select the Thompson PDP-11 B72 dialect checks\n"
	.align 8
.LC130:
	.string	"  --pedantic      error on any non-standard syntax (use with --strict)\n"
	.align 8
.LC131:
	.string	"Extensions disabled by --strict:\n"
	.align 8
.LC132:
	.string	"  - Hex literals (0x...)       use octal instead\n"
	.align 8
.LC133:
	.string	"  - Line comments (//)         use /* */ instead\n"
	.align 8
.LC134:
	.string	"  - Backslash escapes (\\n)     use *n instead\n"
	.align 8
.LC135:
	.string	"  - C-style compound (+=)      use =+ instead\n"
	.align 8
.LC136:
	.string	"  - Bracketed auto vectors      use auto v 3; instead\n"
	.align 8
.LC137:
	.string	"  - break/continue/default      ordinary identifiers in B72\n"
	.align 8
.LC138:
	.string	"  - Logical OR (||)            use | or ?: instead\n"
	.align 8
.LC139:
	.string	"  - Long char constants        use one or two chars\n"
	.align 8
.LC140:
	.string	"  --dump-tokens  show tokenized input\n"
	.align 8
.LC141:
	.string	"  --dump-ast     show parsed AST\n"
	.align 8
.LC142:
	.string	"  --dump-c       emit generated C even when compiling\n"
	.align 8
.LC143:
	.string	"  --no-line      disable #line directives\n"
	.align 8
.LC144:
	.string	"  --verbose-errors use verbose error messages instead of 2-letter codes\n"
	.align 8
.LC145:
	.string	"-c with -o requires exactly one input"
	.align 8
.LC146:
	.string	"inputs produce the same object path '%s'; compile them separately with -o"
	.align 8
.LC147:
	.string	"--asm only works with a single input file"
	.section	.rodata.str1.1
.LC148:
	.string	"-S"
.LC149:
	.string	"-"
.LC150:
	.string	"Generated C: %s\n"
	.section	.rodata.str1.8
	.align 8
.LC151:
	.string	"-S and --asm only work with a single input file"
	.align 8
.LC152:
	.string	"-E only works with a single input file"
	.section	.rodata.str1.1
.LC153:
	.string	"Compiled %s -> %s\n"
.LC154:
	.string	"Linking %zu file(s)...\n"
.LC156:
	.string	"gcc failed (exit %d)\n"
.LC157:
	.string	"Generated C files:\n"
.LC158:
	.string	"  %s\n"
.LC159:
	.string	"Kept: %s\n"
	.section	.rodata.str1.8
	.align 8
.LC160:
	.string	"duplicate external function '%s'"
	.align 8
.LC161:
	.string	"conflicting external definition '%s'"
	.align 8
.LC162:
	.string	"duplicate external variable '%s'"
	.text
	.p2align 4
	.type	run_main, @function
run_main:
.LFB24:
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
	jle	.L336
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
	jmp	.L260
	.p2align 4,,10
	.p2align 3
.L459:
	cmpb	$83, 1(%r15)
	jne	.L367
	cmpb	$0, 2(%r15)
	jne	.L367
	movl	$1, 8(%rsp)
.L240:
	addl	$1, %r14d
	cmpl	%r14d, %ebp
	jle	.L458
.L260:
	movslq	%r14d, %rax
	movq	(%rbx,%rax,8), %r15
	leaq	0(,%rax,8), %r12
	movzbl	(%r15), %r13d
	cmpl	$45, %r13d
	je	.L459
.L367:
	leaq	.LC70(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L338
	cmpl	$45, %r13d
	je	.L460
.L369:
	leaq	.LC71(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L461
.L457:
	movl	$1, 92(%rsp)
	jmp	.L240
	.p2align 4,,10
	.p2align 3
.L338:
	addl	$1, %r14d
	movl	$1, 48(%rsp)
	cmpl	%r14d, %ebp
	jg	.L260
.L458:
	movl	16(%rsp), %ecx
	movl	24(%rsp), %edx
	testl	%ecx, %ecx
	je	.L238
.L261:
	movq	248(%rsp), %rax
	movl	%edx, g_verbose_errors(%rip)
	movl	$1, g_no_line(%rip)
	testq	%rax, %rax
	je	.L462
	movl	60(%rsp), %r15d
	pxor	%xmm0, %xmm0
	movq	$0, 288(%rsp)
	movaps	%xmm0, 272(%rsp)
	testl	%r15d, %r15d
	jne	.L264
	cmpq	$0, 40(%rsp)
	je	.L463
.L266:
	movq	40(%rsp), %rdi
	leaq	240(%rsp), %rsi
	call	protect_input
.L279:
	movq	248(%rsp), %rdx
	cmpq	$1, %rdx
	jbe	.L280
	cmpl	$0, 56(%rsp)
	je	.L464
.L280:
	movl	48(%rsp), %r11d
	testl	%r11d, %r11d
	jne	.L465
	cmpl	$0, 8(%rsp)
	jne	.L466
.L303:
	cmpl	$0, 72(%rsp)
	je	.L306
	cmpq	$1, %rdx
	jbe	.L307
	leaq	.LC152(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L307:
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
	movq	.LC53(%rip), %rax
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
	leaq	.LC58(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L467
.L308:
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
	je	.L366
	testl	%r12d, %r12d
	jne	.L366
.L309:
	movq	%rbp, %rdi
	call	free@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%ecx, %ecx
	movq	%rcx, g_compilation_arena(%rip)
.L305:
	xorl	%ebp, %ebp
.L237:
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
.L460:
	.cfi_restore_state
	cmpb	$99, 1(%r15)
	je	.L468
.L368:
	cmpl	$45, %r13d
	jne	.L369
	cmpb	$69, 1(%r15)
	jne	.L369
	cmpb	$0, 2(%r15)
	jne	.L369
	movl	$1, 72(%rsp)
	jmp	.L240
.L336:
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
.L238:
	cmpl	$0, g_strict(%rip)
	setne	%al
	cmpl	$16, 32(%rsp)
	sete	%cl
	orl	%ecx, %eax
	xorl	$1, %eax
	andl	%eax, 36(%rsp)
	jmp	.L261
.L468:
	cmpb	$0, 2(%r15)
	jne	.L368
	movl	$1, 60(%rsp)
	jmp	.L240
.L264:
	cmpq	$0, 40(%rsp)
	je	.L267
	subq	$1, %rax
	je	.L267
	xorl	%eax, %eax
	leaq	.LC145(%rip), %rdi
	call	dief@PLT
	cmpq	$0, 248(%rsp)
	je	.L268
.L267:
	leaq	272(%rsp), %rax
	leaq	240(%rsp), %r15
	xorl	%r12d, %r12d
	movq	%rax, 16(%rsp)
	leaq	.LC146(%rip), %r13
	movq	%r15, 24(%rsp)
	movq	40(%rsp), %r15
	.p2align 4
	.p2align 3
.L275:
	testq	%r15, %r15
	je	.L269
	movq	%r15, %rdi
	call	sdup@PLT
	movq	%rax, %rbx
.L270:
	xorl	%ebp, %ebp
	cmpq	$0, 280(%rsp)
	jne	.L274
	jmp	.L278
	.p2align 4,,10
	.p2align 3
.L277:
	addq	$1, %rbp
	cmpq	280(%rsp), %rbp
	jnb	.L278
.L274:
	movq	272(%rsp), %rax
	movq	%rbx, %rdi
	movq	(%rax,%rbp,8), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L277
	movq	%rbx, %rsi
	movq	%r13, %rdi
	addq	$1, %rbp
	call	dief@PLT
	cmpq	280(%rsp), %rbp
	jb	.L274
.L278:
	movq	24(%rsp), %rsi
	movq	%rbx, %rdi
	addq	$1, %r12
	call	protect_input
	movq	16(%rsp), %rdi
	movq	%rbx, %rsi
	call	vec_push@PLT
	cmpq	248(%rsp), %r12
	jb	.L275
	cmpq	$0, 40(%rsp)
	jne	.L279
	leaq	.LC69(%rip), %rax
	movq	%rax, 40(%rsp)
	jmp	.L279
.L461:
	leaq	.LC72(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L342
	leaq	.LC40(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L343
	leaq	.LC37(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L344
	leaq	.LC73(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L345
	leaq	.LC38(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L346
	leaq	.LC74(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L347
	leaq	.LC39(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L348
	leaq	.LC75(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L349
	leaq	.LC76(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L350
	movl	$7, %edx
	leaq	.LC77(%rip), %rsi
	movq	%r15, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L243
	addq	$7, %r15
	leaq	.LC78(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L351
	leaq	.LC79(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L352
	leaq	.LC80(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L469
	xorl	%edi, %edi
	movl	%edi, 32(%rsp)
	jmp	.L240
	.p2align 4,,10
	.p2align 3
.L269:
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
	je	.L272
	cmpq	%rax, %r14
	je	.L272
	subq	%r14, %rbp
.L273:
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
	jmp	.L270
.L272:
	movq	%r14, %rdi
	call	strlen@PLT
	movq	%rax, %rbp
	jmp	.L273
.L464:
	movl	64(%rsp), %eax
	xorl	$1, %eax
	orl	68(%rsp), %eax
	je	.L281
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
.L283:
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
	movq	.LC53(%rip), %rax
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
	je	.L298
	movq	%rbp, 24(%rsp)
	movq	%r15, %rbp
	movq	%r14, %r15
	movq	%r13, 16(%rsp)
	jmp	.L282
	.p2align 4,,10
	.p2align 3
.L284:
	cmpl	$2, %eax
	je	.L470
.L291:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L471
.L282:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rcx
	movl	(%rcx), %eax
	cmpl	$1, %eax
	jne	.L284
	movq	8(%rcx), %rax
	movq	8+g_known_variables(%rip), %r13
	movq	(%rax), %r14
	leaq	g_known_variables(%rip), %rax
	movq	(%rax), %r12
	testq	%r13, %r13
	je	.L285
	xorl	%ebx, %ebx
	jmp	.L287
	.p2align 4,,10
	.p2align 3
.L472:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L285
.L287:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L472
	movq	%r14, %rsi
	leaq	.LC161(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L285:
	movq	8+g_known_functions(%rip), %r13
	movq	g_known_functions(%rip), %r12
	testq	%r13, %r13
	je	.L288
	xorl	%ebx, %ebx
	jmp	.L290
	.p2align 4,,10
	.p2align 3
.L473:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L288
.L290:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L473
	movq	%r14, %rsi
	leaq	.LC160(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L288:
	movq	%r14, %rdi
	addq	$1, %r15
	call	sdup@PLT
	leaq	g_known_functions(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	cmpq	8(%rbp), %r15
	jb	.L282
.L471:
	movq	16(%rsp), %r13
	movq	24(%rsp), %rbp
.L298:
	movq	%rbp, %rdi
	addq	$1, %r13
	call	free@PLT
	movq	248(%rsp), %rdx
	cmpq	%rdx, %r13
	jb	.L283
	jmp	.L280
.L465:
	subq	$1, %rdx
	jne	.L334
.L300:
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
	leaq	.LC148(%rip), %rdi
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
	leaq	.LC149(%rip), %rsi
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
	jne	.L474
	movq	%rbx, %rdi
	call	unlink@PLT
.L302:
	movq	%rbx, %rdi
	call	free@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%r9d, %r9d
	movq	%r9, g_compilation_arena(%rip)
	jmp	.L237
.L306:
	movl	72(%rsp), %eax
	leaq	304(%rsp), %r14
	movl	$6, %ecx
	xorl	%ebx, %ebx
	movq	%r14, %rdi
	leaq	240(%rsp), %r13
	rep stosl
	testq	%rdx, %rdx
	je	.L318
	movq	%r13, 16(%rsp)
	movl	100(%rsp), %r15d
	movq	%r14, 8(%rsp)
	movl	88(%rsp), %r13d
	jmp	.L311
	.p2align 4,,10
	.p2align 3
.L314:
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
.L333:
	testq	%r14, %r14
	je	.L332
	movq	8(%rsp), %rdi
	movq	%r14, %rsi
	call	vec_push@PLT
	testl	%r13d, %r13d
	jne	.L475
.L317:
	addq	$1, %rbx
	cmpq	248(%rsp), %rbx
	jnb	.L476
.L311:
	movq	240(%rsp), %rax
	movq	(%rax,%rbx,8), %r12
	testl	%r15d, %r15d
	je	.L314
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L477
.L315:
	movq	%r12, %rdx
	movq	%rbp, %rdi
	leaq	.LC62(%rip), %rsi
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
	jmp	.L333
.L474:
	movq	stderr(%rip), %rdi
	movq	%rbx, %rdx
	leaq	.LC150(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L302
.L281:
	cmpl	$0, 48(%rsp)
	jne	.L334
	cmpl	$0, 8(%rsp)
	je	.L303
.L335:
	leaq	.LC151(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L304:
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
	movq	.LC53(%rip), %rax
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
	jmp	.L305
.L342:
	movl	$1, 100(%rsp)
	jmp	.L457
.L334:
	leaq	.LC147(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L300
	.p2align 4,,10
	.p2align 3
.L470:
	movq	8(%rcx), %rax
	movq	8+g_known_functions(%rip), %r13
	movq	g_known_functions(%rip), %r12
	movq	16(%rax), %r14
	testq	%r13, %r13
	je	.L292
	xorl	%ebx, %ebx
	jmp	.L294
	.p2align 4,,10
	.p2align 3
.L478:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L292
.L294:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L478
	movq	%r14, %rsi
	leaq	.LC161(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L292:
	movq	8+g_known_variables(%rip), %r13
	leaq	g_known_variables(%rip), %rax
	movq	(%rax), %r12
	testq	%r13, %r13
	je	.L295
	xorl	%ebx, %ebx
	jmp	.L297
	.p2align 4,,10
	.p2align 3
.L479:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	je	.L295
.L297:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L479
	movq	%r14, %rsi
	leaq	.LC162(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L295:
	movq	%r14, %rdi
	call	sdup@PLT
	leaq	g_known_variables(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L291
.L475:
	movq	stderr(%rip), %rdi
	movq	%r14, %rcx
	movq	%r12, %rdx
	xorl	%eax, %eax
	leaq	.LC153(%rip), %rsi
	call	fprintf@PLT
	jmp	.L317
.L332:
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%edx, %edx
	movq	%rdx, g_compilation_arena(%rip)
	jmp	.L305
.L466:
	cmpq	$1, %rdx
	jbe	.L304
	jmp	.L335
.L463:
	leaq	.LC69(%rip), %rax
	movq	%rax, 40(%rsp)
	jmp	.L266
.L462:
	movl	$7, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	movl	$2, %ebp
	call	fwrite@PLT
	movq	(%rbx), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC104(%rip), %rsi
	call	fprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$24, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movq	(%rbx), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC106(%rip), %rsi
	call	fprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$9, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC108(%rip), %rdi
	call	fwrite@PLT
	movl	$62, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC109(%rip), %rdi
	call	fwrite@PLT
	movl	$52, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC110(%rip), %rdi
	call	fwrite@PLT
	movl	$53, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movl	$37, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC112(%rip), %rdi
	call	fwrite@PLT
	movl	$69, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	movl	$40, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC114(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movl	$58, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
	movl	$44, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movl	$35, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	movl	$37, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	movl	$39, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
	call	fwrite@PLT
	movl	$42, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	movl	$66, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
	call	fwrite@PLT
	movl	$57, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
	movl	$71, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC125(%rip), %rdi
	call	fwrite@PLT
	movl	$41, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC126(%rip), %rdi
	call	fwrite@PLT
	movl	$64, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC127(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$12, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC128(%rip), %rdi
	call	fwrite@PLT
	movl	$64, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	movl	$71, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC130(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$33, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movl	$49, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movl	$49, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC133(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC134(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	movl	$54, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	movl	$60, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
	movl	$51, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	movl	$52, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC139(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$38, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC140(%rip), %rdi
	call	fwrite@PLT
	movl	$33, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	movl	$54, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC142(%rip), %rdi
	call	fwrite@PLT
	movl	$42, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC143(%rip), %rdi
	call	fwrite@PLT
	movl	$72, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC144(%rip), %rdi
	call	fwrite@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%eax, %eax
	movq	%rax, g_compilation_arena(%rip)
	jmp	.L237
.L366:
	movq	40(%rsp), %rsi
	leaq	.LC63(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L309
.L476:
	movq	8(%rsp), %r14
.L318:
	cmpl	$0, 88(%rsp)
	jne	.L480
.L313:
	xorl	%ebp, %ebp
	cmpl	$0, 60(%rsp)
	movl	$1, %ebx
	je	.L481
	movl	96(%rsp), %r12d
	movl	36(%rsp), %r13d
	movl	88(%rsp), %r14d
	movl	32(%rsp), %r15d
	jmp	.L319
.L323:
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
	jne	.L322
	addq	$1, %rbp
.L319:
	cmpq	312(%rsp), %rbp
	jb	.L323
.L324:
	xorl	%ebx, %ebx
	leaq	.LC159(%rip), %r12
	cmpq	$0, 312(%rsp)
	je	.L332
	movl	92(%rsp), %r13d
	movl	88(%rsp), %r14d
	jmp	.L325
.L330:
	testl	%r14d, %r14d
	jne	.L482
.L331:
	movq	%rbp, %rdi
	addq	$1, %rbx
	call	free@PLT
	cmpq	312(%rsp), %rbx
	jnb	.L332
.L325:
	movq	304(%rsp), %rax
	movq	(%rax,%rbx,8), %rbp
	testl	%r13d, %r13d
	jne	.L330
	movq	%rbp, %rdi
	call	unlink@PLT
	jmp	.L331
.L482:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rdx
	movq	%r12, %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L331
.L343:
	movl	$1, 76(%rsp)
	jmp	.L240
.L268:
	xorl	%edx, %edx
	jmp	.L280
.L344:
	movl	$1, 80(%rsp)
	jmp	.L240
.L481:
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
	je	.L324
.L322:
	movq	stderr(%rip), %rdi
	movl	%eax, %edx
	leaq	.LC156(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpl	$0, 92(%rsp)
	je	.L326
.L329:
	movq	g_compilation_arena(%rip), %rdi
	movl	$1, %ebp
	call	arena_free@PLT
	xorl	%eax, %eax
	movq	%rax, g_compilation_arena(%rip)
	jmp	.L237
.L480:
	movq	stderr(%rip), %rdi
	movq	312(%rsp), %rdx
	leaq	.LC154(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L313
.L345:
	xorl	%r10d, %r10d
	movl	%r10d, 80(%rsp)
	jmp	.L240
.L326:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC157(%rip), %rdi
	leaq	.LC158(%rip), %rbp
	call	fwrite@PLT
	jmp	.L327
.L328:
	movq	304(%rsp), %rax
	movq	stderr(%rip), %rdi
	movq	%rbp, %rsi
	movq	(%rax,%rbx,8), %rdx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
.L327:
	cmpq	312(%rsp), %rbx
	jb	.L328
	jmp	.L329
.L346:
	movl	$1, 84(%rsp)
	jmp	.L240
.L348:
	movl	$1, 96(%rsp)
	jmp	.L240
.L347:
	xorl	%r9d, %r9d
	movl	%r9d, 84(%rsp)
	jmp	.L240
.L469:
	leaq	.LC81(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L240
.L352:
	movl	$32, 32(%rsp)
	jmp	.L240
.L477:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L315
.L467:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	40(%rsp), %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L308
.L351:
	movl	$16, 32(%rsp)
	jmp	.L240
.L243:
	leaq	.LC82(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L245
	movl	$1, g_strict(%rip)
	xorl	%r11d, %r11d
	movl	%r11d, g_extensions(%rip)
	jmp	.L240
.L350:
	xorl	%r8d, %r8d
	movl	$1, 16(%rsp)
	movl	%r8d, 36(%rsp)
	jmp	.L240
.L349:
	movl	$1, 16(%rsp)
	movl	$1, 36(%rsp)
	jmp	.L240
.L245:
	leaq	.LC83(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L247
	movl	$1, g_pedantic(%rip)
	jmp	.L240
.L247:
	leaq	.LC84(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L354
	leaq	.LC85(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L355
	leaq	.LC86(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L356
	leaq	.LC87(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L240
	leaq	.LC88(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L357
	leaq	.LC89(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L358
	leaq	.LC90(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L359
	leaq	.LC33(%rip), %rsi
	movq	%r15, %rdi
	leal	1(%r14), %r13d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L248
	cmpl	%r13d, %ebp
	jg	.L249
	leaq	.LC91(%rip), %rdi
	call	dief@PLT
.L249:
	movq	8(%rbx,%r12), %rax
	movl	%r13d, %r14d
	movq	%rax, 40(%rsp)
	jmp	.L240
.L248:
	leaq	.LC92(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L250
	cmpl	%r13d, %ebp
	jle	.L483
.L251:
	movq	8(%rbx,%r12), %r12
	leaq	.LC94(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L252
	leaq	.LC95(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L252
	leaq	.LC96(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L252
	leaq	.LC97(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L252
	leaq	.LC98(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L253
.L252:
	movl	$1, g_use_curses(%rip)
.L253:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %r15
	movq	%r15, %rdi
	call	malloc@PLT
	movq	%rax, %r14
	testq	%rax, %rax
	je	.L484
.L254:
	movq	%r15, %rsi
	movq	%r14, %rdi
	movq	%r12, %rcx
	xorl	%eax, %eax
	leaq	.LC99(%rip), %rdx
	call	snprintf@PLT
	leaq	208(%rsp), %rdi
	movq	%r14, %rsi
	call	vec_push@PLT
.L257:
	movl	%r13d, %r14d
	jmp	.L240
.L483:
	leaq	.LC93(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L251
.L484:
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L254
.L250:
	leaq	.LC100(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L255
	cmpl	%r13d, %ebp
	jg	.L256
	leaq	.LC101(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L256:
	movq	8(%rbx,%r12), %rdi
	call	sdup@PLT
	leaq	208(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L257
.L255:
	cmpb	$45, (%r15)
	je	.L485
	leaq	240(%rsp), %rax
	movq	%r15, %rsi
	movq	%rax, %rdi
	call	vec_push@PLT
	jmp	.L240
.L359:
	xorl	%esi, %esi
	movl	%esi, 52(%rsp)
	jmp	.L240
.L358:
	movl	$1, 88(%rsp)
	jmp	.L240
.L485:
	movq	%r15, %rsi
	leaq	.LC102(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L240
.L357:
	movl	$1, 24(%rsp)
	jmp	.L240
.L356:
	movl	$1, 68(%rsp)
	jmp	.L240
.L355:
	movl	$1, 64(%rsp)
	jmp	.L240
.L354:
	movl	$1, 56(%rsp)
	jmp	.L240
	.cfi_endproc
.LFE24:
	.size	run_main, .-run_main
	.section	.rodata.str1.1
.LC164:
	.string	"cannot write standard output"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB25:
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
	jne	.L489
	cmpl	$-1, %eax
	je	.L489
.L486:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	%ebx, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L489:
	.cfi_restore_state
	leaq	.LC164(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L486
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.local	libb_o_path.0
	.comm	libb_o_path.0,4096,32
	.local	g_libb_dir
	.comm	g_libb_dir,4096,32
	.section	.data.rel.ro.local,"aw"
	.align 8
.LC45:
	.quad	.LC9
	.align 8
.LC46:
	.quad	.LC12
	.align 8
.LC47:
	.quad	.LC14
	.align 8
.LC48:
	.quad	.LC16
	.align 8
.LC49:
	.quad	.LC18
	.align 8
.LC50:
	.quad	.LC31
	.align 8
.LC51:
	.quad	.LC41
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC53:
	.long	1
	.long	1
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC68:
	.quad	7161675788338426927
	.quad	24866934413088863
	.section	.note.GNU-stack,"",@progbits
