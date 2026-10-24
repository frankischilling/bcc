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
	je	.L32
.L15:
	xorl	%esi, %esi
	movl	$2, %edx
	movq	%rbx, %rdi
	call	fseek@PLT
	testl	%eax, %eax
	jne	.L33
	movq	%rbx, %rdi
	call	ftell@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	js	.L34
.L17:
	xorl	%edx, %edx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	fseek@PLT
	testl	%eax, %eax
	jne	.L35
.L18:
	leaq	1(%rbp), %rdi
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L36
.L19:
	movq	%r12, %rdi
	movq	%rbx, %rcx
	movq	%rbp, %rdx
	movl	$1, %esi
	call	fread@PLT
	movq	%rbx, %rdi
	movq	%rax, %r15
	call	fclose@PLT
	cmpq	%r15, %rbp
	je	.L20
	movq	%r14, %rsi
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L20:
	movb	$0, (%r12,%rbp)
	testq	%r13, %r13
	je	.L14
	movq	%rbp, 0(%r13)
.L14:
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
.L35:
	.cfi_restore_state
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L18
	.p2align 4,,10
	.p2align 3
.L33:
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movq	%rbx, %rdi
	call	ftell@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jns	.L17
.L34:
	leaq	.LC5(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L17
.L32:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%r14, %rsi
	leaq	.LC3(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L15
.L36:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L19
	.cfi_endproc
.LFE15:
	.size	read_file_all, .-read_file_all
	.section	.rodata.str1.1
.LC8:
	.string	"gcc"
.LC9:
	.string	"-std=c99"
.LC10:
	.string	"%s/libb.c"
.LC11:
	.string	"libb.c"
.LC12:
	.string	"libb.h"
.LC13:
	.string	"btarget.h"
.LC14:
	.string	"%s/%s"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC15:
	.string	"cannot read runtime dependency %s"
	.section	.rodata.str1.1
.LC16:
	.string	"/tmp/bcc_libb_%016lx_%d_%d.o"
.LC17:
	.string	"libb.c not found at %s"
.LC18:
	.string	"Compiling runtime library...\n"
.LC19:
	.string	"-I%s"
.LC20:
	.string	"-DB_BYTEPTR=%d"
.LC21:
	.string	"-DWORD_BITS=%d"
.LC22:
	.string	"%s.XXXXXX"
.LC23:
	.string	"cannot create runtime object"
.LC24:
	.string	"-O2"
.LC25:
	.string	"-c"
.LC26:
	.string	"-o"
.LC27:
	.string	"fork failed"
.LC28:
	.string	"Failed to compile libb.c"
.LC29:
	.string	"cannot cache runtime object"
.LC30:
	.string	"-Wall"
.LC31:
	.string	"-Wextra"
.LC32:
	.string	"-Werror"
.LC33:
	.string	"-g"
.LC34:
	.string	"-ldl"
.LC35:
	.string	"-lm"
.LC36:
	.string	"Running:"
.LC37:
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
	movl	%edx, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$20856, %rsp
	.cfi_def_cfa_offset 20912
	movq	.LC38(%rip), %xmm1
	movl	20928(%rsp), %r14d
	movq	%rdi, 32(%rsp)
	punpcklqdq	%xmm2, %xmm1
	movq	%rsi, 56(%rsp)
	movq	20920(%rsp), %rbp
	testl	%r14d, %r14d
	movl	%ecx, 44(%rsp)
	setne	%dl
	testl	%r13d, %r13d
	movl	%r8d, 48(%rsp)
	sete	%al
	movl	%r9d, 52(%rsp)
	andb	%al, %dl
	movaps	%xmm1, 16(%rsp)
	movb	%dl, 91(%rsp)
	jne	.L141
	leaq	g_libb_dir(%rip), %rax
	xorl	%ebx, %ebx
	leaq	12656(%rsp), %r14
	movq	%rax, 8(%rsp)
	leaq	.LC19(%rip), %r15
.L38:
	movq	8(%rsp), %rcx
	movq	%r15, %rdx
	movl	$4096, %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	32(%rsp), %rax
	movq	8(%rax), %r15
	xorl	%eax, %eax
	testq	%rbp, %rbp
	je	.L53
	movq	8(%rbp), %rax
.L53:
	leaq	40(%r15,%rax), %rdi
	salq	$3, %rdi
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L142
.L54:
	movdqa	16(%rsp), %xmm3
	movups	%xmm3, (%r12)
	testl	%r13d, %r13d
	jne	.L83
	leaq	.LC24(%rip), %rax
	movl	$4, %edx
	movl	$3, %ecx
	movq	%rax, 16(%r12)
	movl	$24, %eax
.L55:
	movl	48(%rsp), %r10d
	testl	%r10d, %r10d
	je	.L56
	leaq	.LC30(%rip), %rcx
	movq	%rcx, (%r12,%rax)
	movslq	%edx, %rax
	movl	%edx, %ecx
	addl	$1, %edx
	salq	$3, %rax
.L56:
	movl	52(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L57
	leaq	.LC31(%rip), %rcx
	movq	%rcx, (%r12,%rax)
	movslq	%edx, %rax
	movl	%edx, %ecx
	addl	$1, %edx
	salq	$3, %rax
.L57:
	movl	20912(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L58
	leaq	.LC32(%rip), %rcx
	movq	%rcx, (%r12,%rax)
	movslq	%edx, %rax
	movl	%edx, %ecx
	addl	$1, %edx
	salq	$3, %rax
.L58:
	movl	44(%rsp), %edi
	testl	%edi, %edi
	je	.L59
	leaq	.LC33(%rip), %rcx
	movq	%rcx, (%r12,%rax)
	movslq	%edx, %rax
	movl	%edx, %ecx
	addl	$1, %edx
	salq	$3, %rax
.L59:
	movl	20928(%rsp), %esi
	testl	%esi, %esi
	je	.L60
	movq	%r14, (%r12,%rax)
	movslq	%edx, %rax
	movl	%edx, %ecx
	addl	$1, %edx
	salq	$3, %rax
.L60:
	addq	%r12, %rax
	testl	%r13d, %r13d
	je	.L61
	leaq	.LC25(%rip), %rcx
	movq	%rcx, (%rax)
	movl	%edx, %ecx
	testq	%r15, %r15
	je	.L143
.L62:
	movq	32(%rsp), %rax
	movq	(%rax), %rdi
	movslq	%ecx, %rax
	leaq	(%r12,%rax,8), %rsi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L67:
	movq	(%rdi,%rax,8), %rdx
	movq	%rdx, (%rsi,%rax,8)
	addq	$1, %rax
	cmpq	%r15, %rax
	jne	.L67
	addl	%eax, %ecx
	cmpb	$0, 91(%rsp)
	je	.L68
.L63:
	leal	1(%rcx), %edx
	movslq	%ecx, %rcx
	movq	%rbx, (%r12,%rcx,8)
	testq	%rbp, %rbp
	je	.L66
.L69:
	movq	8(%rbp), %rsi
	testq	%rsi, %rsi
	je	.L70
.L65:
	movslq	%edx, %rax
	movq	0(%rbp), %r8
	leaq	(%r12,%rax,8), %rdi
	xorl	%eax, %eax
	.p2align 5
	.p2align 4
	.p2align 3
.L71:
	movq	(%r8,%rax,8), %rcx
	movq	%rcx, (%rdi,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %rsi
	jne	.L71
	addl	%esi, %edx
.L70:
	testl	%r13d, %r13d
	je	.L66
.L64:
	movl	20952(%rsp), %eax
	movslq	%edx, %rdx
	movq	$0, (%r12,%rdx,8)
	testl	%eax, %eax
	jne	.L144
	call	fork@PLT
	movl	%eax, %edi
	testl	%eax, %eax
	js	.L145
.L76:
	je	.L146
	leaq	4464(%rsp), %rsi
	xorl	%edx, %edx
	movl	$0, 4464(%rsp)
	call	waitpid@PLT
	movq	%r12, %rdi
	testl	%eax, %eax
	js	.L147
	call	free@PLT
	movl	4464(%rsp), %eax
	testb	$127, %al
	je	.L148
.L77:
	movl	$1, %eax
.L37:
	addq	$20856, %rsp
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
.L86:
	.cfi_restore_state
	movl	%ecx, %edx
	.p2align 4
	.p2align 3
.L66:
	movq	.LC41(%rip), %xmm0
	leaq	.LC35(%rip), %rcx
	movslq	%edx, %rax
	addl	$2, %edx
	movq	%rcx, %xmm4
	punpcklqdq	%xmm4, %xmm0
	movups	%xmm0, (%r12,%rax,8)
	jmp	.L64
	.p2align 4,,10
	.p2align 3
.L61:
	leaq	.LC26(%rip), %rsi
	movslq	%edx, %rdx
	addl	$2, %ecx
	movq	%rsi, (%rax)
	movq	56(%rsp), %rax
	movq	%rax, (%r12,%rdx,8)
	testq	%r15, %r15
	jne	.L62
	cmpb	$0, 91(%rsp)
	jne	.L63
	testq	%rbp, %rbp
	je	.L86
	movq	8(%rbp), %rsi
	movl	%ecx, %edx
	testq	%rsi, %rsi
	jne	.L65
	jmp	.L66
	.p2align 4,,10
	.p2align 3
.L83:
	movl	$3, %edx
	movl	$16, %eax
	movl	$2, %ecx
	jmp	.L55
	.p2align 4,,10
	.p2align 3
.L68:
	movl	%ecx, %edx
	testq	%rbp, %rbp
	jne	.L69
	jmp	.L70
	.p2align 4,,10
	.p2align 3
.L148:
	movzbl	%ah, %eax
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L141:
	leaq	g_libb_dir(%rip), %rax
	movl	$4096, %esi
	leaq	112(%rsp), %r15
	movabsq	$-3750763034362895579, %rbx
	movq	%rax, 8(%rsp)
	leaq	368(%rsp), %rdi
	movq	%rax, %rcx
	leaq	.LC10(%rip), %rdx
	xorl	%eax, %eax
	movq	%rdi, 72(%rsp)
	leaq	12656(%rsp), %r14
	movabsq	$1099511628211, %r12
	call	snprintf@PLT
	leaq	.LC12(%rip), %rax
	movl	%r13d, 80(%rsp)
	movq	.LC39(%rip), %xmm0
	movq	%rax, %xmm5
	leaq	.LC13(%rip), %rax
	movq	%rax, 128(%rsp)
	leaq	136(%rsp), %rax
	punpcklqdq	%xmm5, %xmm0
	movq	%rax, 64(%rsp)
	movaps	%xmm0, 112(%rsp)
.L43:
	movq	(%r15), %r8
	movq	8(%rsp), %rcx
	movl	$8192, %esi
	movq	%r14, %rdi
	leaq	.LC14(%rip), %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	leaq	.LC2(%rip), %rsi
	movq	%r14, %rdi
	call	fopen@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	jne	.L40
	jmp	.L149
	.p2align 4,,10
	.p2align 3
.L41:
	movzbl	%al, %eax
	xorq	%rbx, %rax
	imulq	%r12, %rax
	movq	%rax, %rbx
.L40:
	movq	%r13, %rdi
	call	fgetc@PLT
	cmpl	$-1, %eax
	jne	.L41
	movq	%r13, %rdi
	call	ferror@PLT
	testl	%eax, %eax
	jne	.L150
.L42:
	movq	%r13, %rdi
	addq	$8, %r15
	call	fclose@PLT
	movq	64(%rsp), %rax
	cmpq	%rax, %r15
	jne	.L43
	movq	%rbx, %rcx
	movl	$4096, %esi
	xorl	%eax, %eax
	movl	80(%rsp), %r13d
	movl	20944(%rsp), %r9d
	movl	20936(%rsp), %r8d
	leaq	libb_o_path.0(%rip), %rbx
	leaq	.LC16(%rip), %rdx
	movq	%rbx, %rdi
	call	snprintf@PLT
	movq	72(%rsp), %rdi
	movl	$4, %esi
	call	access@PLT
	testl	%eax, %eax
	jne	.L151
.L44:
	movl	$4, %esi
	movq	%rbx, %rdi
	leaq	.LC19(%rip), %r15
	call	access@PLT
	testl	%eax, %eax
	je	.L45
	movl	20952(%rsp), %r12d
	testl	%r12d, %r12d
	jne	.L152
.L46:
	leaq	4464(%rsp), %rax
	movq	8(%rsp), %rcx
	leaq	.LC19(%rip), %r15
	movl	$8192, %esi
	movq	%rax, %rdi
	movq	%rax, 80(%rsp)
	movq	%r15, %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	movl	20936(%rsp), %r11d
	xorl	%ecx, %ecx
	leaq	144(%rsp), %rdi
	leaq	.LC20(%rip), %rdx
	movl	$64, %esi
	movq	%rdi, 64(%rsp)
	leaq	208(%rsp), %r12
	testl	%r11d, %r11d
	setne	%cl
	xorl	%eax, %eax
	call	snprintf@PLT
	movl	$64, %esi
	movq	%r12, %rdi
	xorl	%eax, %eax
	movl	20944(%rsp), %ecx
	leaq	.LC21(%rip), %rdx
	call	snprintf@PLT
	movq	%rbx, %rcx
	movl	$8192, %esi
	movq	%r14, %rdi
	leaq	.LC22(%rip), %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	movq	%r14, %rdi
	call	mkstemp@PLT
	movl	%eax, %edx
	testl	%eax, %eax
	js	.L153
.L47:
	movl	%edx, %edi
	call	close@PLT
	leaq	.LC25(%rip), %rax
	movq	.LC40(%rip), %xmm0
	movdqa	16(%rsp), %xmm6
	movq	%rax, %xmm7
	leaq	.LC26(%rip), %rax
	movq	$0, 352(%rsp)
	punpcklqdq	%xmm7, %xmm0
	movaps	%xmm6, 272(%rsp)
	movq	%r14, %xmm6
	movaps	%xmm0, 288(%rsp)
	movq	80(%rsp), %xmm0
	movhps	64(%rsp), %xmm0
	movaps	%xmm0, 304(%rsp)
	movq	%r12, %xmm0
	movhps	72(%rsp), %xmm0
	movaps	%xmm0, 320(%rsp)
	movq	%rax, %xmm0
	punpcklqdq	%xmm6, %xmm0
	movaps	%xmm0, 336(%rsp)
	call	fork@PLT
	movl	%eax, %r12d
	testl	%eax, %eax
	js	.L154
	je	.L155
.L49:
	xorl	%edx, %edx
	leaq	108(%rsp), %rsi
	movl	%r12d, %edi
	movl	$0, 108(%rsp)
	call	waitpid@PLT
	testl	%eax, %eax
	js	.L50
	testw	$-129, 108(%rsp)
	je	.L51
.L50:
	movq	%r14, %rdi
	call	unlink@PLT
	leaq	.LC28(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L51:
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	rename@PLT
	testl	%eax, %eax
	je	.L45
	movq	%r14, %rdi
	call	unlink@PLT
	leaq	.LC29(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.p2align 4
	.p2align 3
.L45:
	leaq	libb_o_path.0(%rip), %rbx
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L144:
	movl	$8, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC36(%rip), %rdi
	leaq	8(%r12), %rbx
	leaq	.LC37(%rip), %rbp
	call	fwrite@PLT
	movq	(%r12), %rdx
	testq	%rdx, %rdx
	je	.L75
	.p2align 4
	.p2align 3
.L74:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rsi
	xorl	%eax, %eax
	addq	$8, %rbx
	call	fprintf@PLT
	movq	-8(%rbx), %rdx
	testq	%rdx, %rdx
	jne	.L74
.L75:
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	call	fork@PLT
	movl	%eax, %edi
	testl	%eax, %eax
	jns	.L76
.L145:
	movq	%r12, %rdi
	call	free@PLT
	jmp	.L77
	.p2align 4,,10
	.p2align 3
.L150:
	movq	%r14, %rsi
	leaq	.LC15(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L42
	.p2align 4,,10
	.p2align 3
.L147:
	call	free@PLT
	jmp	.L77
.L143:
	cmpb	$0, 91(%rsp)
	jne	.L63
	testq	%rbp, %rbp
	je	.L64
	movq	8(%rbp), %rsi
	testq	%rsi, %rsi
	jne	.L65
	jmp	.L64
	.p2align 4,,10
	.p2align 3
.L151:
	movq	72(%rsp), %rsi
	leaq	.LC17(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L44
.L152:
	movq	stderr(%rip), %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC18(%rip), %rdi
	call	fwrite@PLT
	jmp	.L46
.L154:
	leaq	.LC27(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L49
.L153:
	movl	%eax, 92(%rsp)
	leaq	.LC23(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	movl	92(%rsp), %edx
	jmp	.L47
.L149:
	movq	%r14, %rsi
	leaq	.LC15(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L40
.L155:
	leaq	.LC8(%rip), %rdi
	leaq	272(%rsp), %rsi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
.L142:
	xorl	%eax, %eax
	leaq	.LC6(%rip), %rdi
	call	dief@PLT
	movq	32(%rsp), %rax
	movq	8(%rax), %r15
	jmp	.L54
.L146:
	leaq	.LC8(%rip), %rdi
	movq	%r12, %rsi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
	.cfi_endproc
.LFE19:
	.size	run_gcc_multi, .-run_gcc_multi
	.section	.rodata.str1.1
.LC42:
	.string	"Reading %s...\n"
.LC44:
	.string	"Lexing...\n"
.LC45:
	.string	"Parsing...\n"
.LC46:
	.string	"Semantic analysis...\n"
.LC47:
	.string	"Code generation...\n"
.LC48:
	.string	"w"
.LC49:
	.string	"mkstemp failed: %s"
.LC50:
	.string	"wb"
.LC51:
	.string	"fdopen failed"
.LC52:
	.string	"%s.c"
.LC53:
	.string	"rename temp failed: %s"
.LC54:
	.string	"cannot reopen '%s': %s"
.LC55:
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
	jne	.L201
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
	movq	.LC43(%rip), %rax
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
	jne	.L181
	movq	%r13, %rdi
	call	parse_program_ast@PLT
	leaq	152(%rsp), %rdi
	movq	%rax, %r13
	call	tok_free@PLT
	testl	%ebp, %ebp
	jne	.L202
.L163:
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	sem_check_program@PLT
.L165:
	movl	296(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L166
	cmpq	$0, 304(%rsp)
	je	.L166
	movq	304(%rsp), %rdi
	call	strdup@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L203
.L167:
	leaq	.LC48(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	je	.L204
.L169:
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
	jne	.L205
.L176:
	movq	%r12, %rdi
	call	free@PLT
.L156:
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
.L166:
	.cfi_restore_state
	movdqa	.LC56(%rip), %xmm0
	leaq	96(%rsp), %r15
	movq	%r15, %rdi
	movaps	%xmm0, 96(%rsp)
	call	mkstemp@PLT
	movl	%eax, %ebp
	testl	%eax, %eax
	js	.L206
.L170:
	leaq	.LC50(%rip), %rsi
	movl	%ebp, %edi
	call	fdopen@PLT
	movq	%rax, 8(%rsp)
	testq	%rax, %rax
	je	.L207
.L171:
	movq	%r15, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L208
.L172:
	leaq	.LC52(%rip), %rsi
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
	jne	.L209
.L173:
	leaq	.LC48(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	jne	.L169
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rsi
	leaq	.LC54(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L169
	.p2align 4,,10
	.p2align 3
.L202:
	movq	%r13, %rdi
	call	dump_ast_program@PLT
	movl	288(%rsp), %edx
	testl	%edx, %edx
	jne	.L163
.L180:
	movq	%r12, %rdi
	xorl	%ebp, %ebp
	call	free@PLT
	jmp	.L156
	.p2align 4,,10
	.p2align 3
.L201:
	movq	%rdi, %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC42(%rip), %rsi
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
	movq	.LC43(%rip), %rax
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
	leaq	.LC44(%rip), %rdi
	call	fwrite@PLT
	testl	%r15d, %r15d
	jne	.L181
	movq	stderr(%rip), %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC45(%rip), %rdi
	call	fwrite@PLT
	movq	%r13, %rdi
	call	parse_program_ast@PLT
	leaq	152(%rsp), %rdi
	movq	%rax, %r13
	call	tok_free@PLT
	testl	%ebp, %ebp
	jne	.L210
.L161:
	movq	stderr(%rip), %rcx
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC46(%rip), %rdi
	call	fwrite@PLT
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	sem_check_program@PLT
	movl	$19, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC47(%rip), %rdi
	call	fwrite@PLT
	jmp	.L165
	.p2align 4,,10
	.p2align 3
.L205:
	leaq	.LC55(%rip), %rsi
	movq	%rbp, %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	jne	.L177
	jmp	.L176
	.p2align 4,,10
	.p2align 3
.L179:
	movq	stdout(%rip), %rsi
	call	putc@PLT
.L177:
	movq	%rbx, %rdi
	call	fgetc@PLT
	movl	%eax, %edi
	cmpl	$-1, %eax
	jne	.L179
	movq	%rbx, %rdi
	call	fclose@PLT
	jmp	.L176
	.p2align 4,,10
	.p2align 3
.L209:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC53(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L173
	.p2align 4,,10
	.p2align 3
.L206:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC49(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L170
	.p2align 4,,10
	.p2align 3
.L210:
	movq	%r13, %rdi
	call	dump_ast_program@PLT
	movl	288(%rsp), %eax
	testl	%eax, %eax
	jne	.L161
	jmp	.L180
	.p2align 4,,10
	.p2align 3
.L181:
	movq	%r13, %rdi
	xorl	%ebp, %ebp
	call	dump_token_stream@PLT
	movq	%r12, %rdi
	call	free@PLT
	jmp	.L156
.L203:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L167
.L208:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L172
.L204:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rsi
	leaq	.LC3(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L169
.L207:
	leaq	.LC51(%rip), %rdi
	call	dief@PLT
	jmp	.L171
	.cfi_endproc
.LFE20:
	.size	compile_b_to_c, .-compile_b_to_c
	.section	.rodata.str1.1
.LC57:
	.string	"a.out"
.LC58:
	.string	"--asm"
.LC59:
	.string	"--keep-c"
.LC60:
	.string	"--emit-c"
.LC61:
	.string	"-Wno-all"
.LC62:
	.string	"-Wno-extra"
.LC63:
	.string	"--byteptr"
.LC64:
	.string	"--wordptr"
.LC65:
	.string	"--word="
.LC66:
	.string	"16"
.LC67:
	.string	"32"
.LC68:
	.string	"host"
	.section	.rodata.str1.8
	.align 8
.LC69:
	.string	"--word must be 16, 32, or host"
	.section	.rodata.str1.1
.LC70:
	.string	"--strict"
.LC71:
	.string	"--pedantic"
.LC72:
	.string	"--dump-tokens"
.LC73:
	.string	"--dump-ast"
.LC74:
	.string	"--dump-c"
.LC75:
	.string	"--no-line"
.LC76:
	.string	"--verbose-errors"
.LC77:
	.string	"-v"
.LC78:
	.string	"--inline-runtime"
.LC79:
	.string	"missing value after -o"
.LC80:
	.string	"-l"
.LC81:
	.string	"missing value after -l"
.LC82:
	.string	"ncurses"
.LC83:
	.string	"ncursesw"
.LC84:
	.string	"curses"
.LC85:
	.string	"panel"
.LC86:
	.string	"panelw"
.LC87:
	.string	"-l%s"
.LC88:
	.string	"-X"
.LC89:
	.string	"missing value after -X"
.LC90:
	.string	"unknown option: %s"
.LC91:
	.string	"usage:\n"
	.section	.rodata.str1.8
	.align 8
.LC92:
	.string	"  %s [options] input.b ... [-o out]\n"
	.section	.rodata.str1.1
.LC93:
	.string	"Multi-file compilation:\n"
	.section	.rodata.str1.8
	.align 8
.LC94:
	.string	"  %s a.b b.b c.b -o prog    compile and link multiple .b files\n"
	.section	.rodata.str1.1
.LC95:
	.string	"options:\n"
	.section	.rodata.str1.8
	.align 8
.LC96:
	.string	"  -S          emit C code to stdout (single file only)\n"
	.align 8
.LC97:
	.string	"  --asm       emit assembly code to stdout (single file only)\n"
	.align 8
.LC98:
	.string	"  -c          compile to object file(s), don't link\n"
	.align 8
.LC99:
	.string	"  -E          emit C code to file (single file only)\n"
	.align 8
.LC100:
	.string	"  --keep-c    keep generated C files\n"
	.align 8
.LC101:
	.string	"  --emit-c    use a.b -> a.b.c naming for C files (implies --keep-c)\n"
	.align 8
.LC102:
	.string	"  -g          include debug information\n"
	.align 8
.LC103:
	.string	"  -l LIB      pass library to linker (can be repeated)\n"
	.align 8
.LC104:
	.string	"  -X FLAG     pass FLAG directly to gcc (can be repeated)\n"
	.align 8
.LC105:
	.string	"  -Wall       enable all warnings (default)\n"
	.align 8
.LC106:
	.string	"  -Wno-all    disable all warnings\n"
	.align 8
.LC107:
	.string	"  -Wextra     enable extra warnings (default)\n"
	.align 8
.LC108:
	.string	"  -Wno-extra  disable extra warnings\n"
	.align 8
.LC109:
	.string	"  -Werror     treat warnings as errors\n"
	.align 8
.LC110:
	.string	"  --byteptr   use byte-addressed pointers\n"
	.align 8
.LC111:
	.string	"  --wordptr   use word-addressed pointers (strict/16-bit default)\n"
	.align 8
.LC112:
	.string	"  --word=N    word size: 16, 32, or host (default: host)\n"
	.align 8
.LC113:
	.string	"              16-bit mode uses translated B addresses and packed words\n"
	.align 8
.LC114:
	.string	"  -v          verbose compilation output\n"
	.align 8
.LC115:
	.string	"  --inline-runtime  embed runtime in each C file (old behavior)\n"
	.section	.rodata.str1.1
.LC116:
	.string	"Strictness:\n"
	.section	.rodata.str1.8
	.align 8
.LC117:
	.string	"  --strict        select the Thompson PDP-11 B72 dialect checks\n"
	.align 8
.LC118:
	.string	"  --pedantic      error on any non-standard syntax (use with --strict)\n"
	.align 8
.LC119:
	.string	"Extensions disabled by --strict:\n"
	.align 8
.LC120:
	.string	"  - Hex literals (0x...)       use octal instead\n"
	.align 8
.LC121:
	.string	"  - Line comments (//)         use /* */ instead\n"
	.align 8
.LC122:
	.string	"  - Backslash escapes (\\n)     use *n instead\n"
	.align 8
.LC123:
	.string	"  - C-style compound (+=)      use =+ instead\n"
	.align 8
.LC124:
	.string	"  - Bracketed auto vectors      use auto v 3; instead\n"
	.align 8
.LC125:
	.string	"  - break/continue/default      ordinary identifiers in B72\n"
	.align 8
.LC126:
	.string	"  - Logical OR (||)            use | or ?: instead\n"
	.align 8
.LC127:
	.string	"  - Long char constants        use one or two chars\n"
	.align 8
.LC128:
	.string	"  --dump-tokens  show tokenized input\n"
	.align 8
.LC129:
	.string	"  --dump-ast     show parsed AST\n"
	.align 8
.LC130:
	.string	"  --dump-c       emit generated C even when compiling\n"
	.align 8
.LC131:
	.string	"  --no-line      disable #line directives\n"
	.align 8
.LC132:
	.string	"  --verbose-errors use verbose error messages instead of 2-letter codes\n"
	.align 8
.LC133:
	.string	"--asm only works with a single input file"
	.section	.rodata.str1.1
.LC134:
	.string	"-S"
.LC135:
	.string	"-"
.LC136:
	.string	"Generated C: %s\n"
	.section	.rodata.str1.8
	.align 8
.LC137:
	.string	"-S and --asm only work with a single input file"
	.align 8
.LC138:
	.string	"-E only works with a single input file"
	.section	.rodata.str1.1
.LC139:
	.string	"Compiled %s -> %s\n"
.LC140:
	.string	"Linking %zu file(s)...\n"
.LC141:
	.string	"gcc failed (exit %d)\n"
.LC142:
	.string	"Generated C files:\n"
.LC143:
	.string	"  %s\n"
.LC144:
	.string	"Kept: %s\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB21:
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
	subq	$408, %rsp
	.cfi_def_cfa_offset 464
	movq	(%rsi), %rdi
	call	init_libb_path
	leaq	g_libb_dir(%rip), %rax
	movq	%rax, g_libb_path(%rip)
	call	arena_new@PLT
	pxor	%xmm0, %xmm0
	movq	$0, 240(%rsp)
	movq	%rax, g_compilation_arena(%rip)
	movq	$0, 272(%rsp)
	movq	$0, 16+g_known_functions(%rip)
	movaps	%xmm0, 224(%rsp)
	movaps	%xmm0, 256(%rsp)
	movups	%xmm0, g_known_functions(%rip)
	cmpl	$1, %ebp
	jle	.L277
	movl	$1, %r14d
	xorl	%r10d, %r10d
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	movl	$1, 44(%rsp)
	movl	%r14d, %r15d
	movl	$0, 12(%rsp)
	movl	$0, 84(%rsp)
	movl	$0, 36(%rsp)
	movl	$0, 32(%rsp)
	movl	$0, 28(%rsp)
	movl	$1, 24(%rsp)
	movl	$0, 100(%rsp)
	movl	$1, 96(%rsp)
	movl	$1, 92(%rsp)
	movl	$0, 88(%rsp)
	movl	$0, 40(%rsp)
	movl	$0, 80(%rsp)
	movl	$0, 68(%rsp)
	movl	$0, 64(%rsp)
	movl	$0, 16(%rsp)
	movl	$0, (%rsp)
	movl	%ecx, 48(%rsp)
	movl	%edx, 56(%rsp)
	movq	%r10, 72(%rsp)
	jmp	.L234
	.p2align 4,,10
	.p2align 3
.L367:
	cmpb	$83, 1(%r13)
	jne	.L305
	cmpb	$0, 2(%r13)
	jne	.L305
	movl	$1, (%rsp)
.L214:
	addl	$1, %r15d
	cmpl	%r15d, %ebp
	jle	.L366
.L234:
	movslq	%r15d, %rax
	movq	(%rbx,%rax,8), %r13
	leaq	0(,%rax,8), %r12
	movzbl	0(%r13), %r14d
	cmpl	$45, %r14d
	je	.L367
.L305:
	leaq	.LC58(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L279
	cmpl	$45, %r14d
	je	.L368
.L307:
	leaq	.LC59(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L369
.L363:
	movl	$1, 80(%rsp)
	jmp	.L214
	.p2align 4,,10
	.p2align 3
.L279:
	addl	$1, %r15d
	movl	$1, 16(%rsp)
	cmpl	%r15d, %ebp
	jg	.L234
.L366:
	movl	48(%rsp), %ecx
	movl	56(%rsp), %edx
	movq	72(%rsp), %r10
	testl	%ecx, %ecx
	je	.L212
.L235:
	movl	%edx, g_verbose_errors(%rip)
	movq	264(%rsp), %rdx
	movl	$1, g_no_line(%rip)
	testq	%rdx, %rdx
	je	.L370
	testq	%r10, %r10
	leaq	.LC57(%rip), %rax
	leaq	288(%rsp), %r12
	cmove	%rax, %r10
	cmpq	$1, %rdx
	je	.L239
	cmpl	$0, 28(%rsp)
	je	.L371
.L239:
	movl	16(%rsp), %r11d
	testl	%r11d, %r11d
	jne	.L372
	cmpl	$0, (%rsp)
	jne	.L373
.L251:
	cmpl	$0, 68(%rsp)
	je	.L254
	cmpq	$1, %rdx
	jbe	.L255
	leaq	.LC138(%rip), %rdi
	xorl	%eax, %eax
	movq	%r10, (%rsp)
	call	dief@PLT
	movq	(%rsp), %r10
.L255:
	movq	256(%rsp), %rax
	xorl	%esi, %esi
	movq	%r10, (%rsp)
	leaq	144(%rsp), %r13
	movq	%rsi, 216(%rsp)
	leaq	216(%rsp), %rsi
	movq	(%rax), %rbp
	movq	%rbp, %rdi
	call	read_file_all
	movl	$24, %ecx
	movq	%rbp, %r8
	xorl	%esi, %esi
	leaq	304(%rsp), %rdx
	movq	%rax, %rbx
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	rep stosl
	movq	216(%rsp), %rax
	movq	%r13, %rdi
	movl	$1, %ecx
	movq	%rbx, 288(%rsp)
	movq	%rax, 296(%rsp)
	movq	.LC43(%rip), %rax
	movq	%rbp, 320(%rsp)
	movq	%rax, 312(%rsp)
	movq	%rbx, 384(%rsp)
	call	mk_tok@PLT
	movq	%r13, %rsi
	movl	$14, %ecx
	leaq	328(%rsp), %rdi
	rep movsl
	movq	%r12, %rdi
	call	next@PLT
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	328(%rsp), %rdi
	movq	%rax, %r12
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	sem_check_program@PLT
	movq	(%rsp), %rdi
	leaq	.LC48(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L374
.L256:
	movl	12(%rsp), %r9d
	movl	24(%rsp), %ecx
	movq	%r13, %rdi
	movq	%rbp, %rdx
	movl	$1, %r8d
	movq	%r12, %rsi
	call	emit_program_c@PLT
	movq	%r13, %rdi
	call	fclose@PLT
.L364:
	movq	%rbx, %rdi
	call	free@PLT
.L365:
	movq	g_compilation_arena(%rip), %rdi
	xorl	%ebp, %ebp
	call	arena_free@PLT
	xorl	%ecx, %ecx
	movq	%rcx, g_compilation_arena(%rip)
.L211:
	addq	$408, %rsp
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
.L368:
	.cfi_restore_state
	cmpb	$99, 1(%r13)
	je	.L375
.L306:
	cmpl	$45, %r14d
	jne	.L307
	cmpb	$69, 1(%r13)
	jne	.L307
	cmpb	$0, 2(%r13)
	jne	.L307
	movl	$1, 68(%rsp)
	jmp	.L214
.L375:
	cmpb	$0, 2(%r13)
	jne	.L306
	movl	$1, 64(%rsp)
	jmp	.L214
.L277:
	xorl	%r14d, %r14d
	xorl	%r12d, %r12d
	xorl	%ebp, %ebp
	xorl	%r13d, %r13d
	movl	$1, 44(%rsp)
	xorl	%r10d, %r10d
	xorl	%edx, %edx
	movl	%ebp, 12(%rsp)
	movl	%ebp, 84(%rsp)
	movl	%r12d, 36(%rsp)
	movl	%r12d, 32(%rsp)
	movl	%r12d, 28(%rsp)
	movl	$1, 24(%rsp)
	movl	%r13d, 100(%rsp)
	movl	$1, 96(%rsp)
	movl	$1, 92(%rsp)
	movl	%r14d, 88(%rsp)
	movl	%r14d, 40(%rsp)
	movl	%r14d, 80(%rsp)
	movl	%r14d, 68(%rsp)
	movl	%r14d, 64(%rsp)
	movl	%r14d, 16(%rsp)
	movl	%r14d, (%rsp)
.L212:
	cmpl	$0, g_strict(%rip)
	setne	%al
	cmpl	$16, 12(%rsp)
	sete	%cl
	orl	%ecx, %eax
	xorl	$1, %eax
	andl	%eax, 24(%rsp)
	jmp	.L235
.L371:
	movl	32(%rsp), %eax
	xorl	$1, %eax
	orl	36(%rsp), %eax
	je	.L240
	leaq	216(%rsp), %rax
	movq	%r10, 136(%rsp)
	xorl	%r13d, %r13d
	movq	%rax, 128(%rsp)
	leaq	304(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	328(%rsp), %rax
	movq	%rax, 112(%rsp)
	movq	%r12, 72(%rsp)
	.p2align 4
	.p2align 3
.L242:
	movq	256(%rsp), %rax
	movq	128(%rsp), %rsi
	xorl	%r15d, %r15d
	movq	$0, 216(%rsp)
	movq	(%rax,%r13,8), %rbx
	movq	%rbx, %rdi
	call	read_file_all
	movq	104(%rsp), %rdi
	movq	%rbx, %r8
	xorl	%esi, %esi
	movq	%rax, %rbp
	movl	$12, %ecx
	xorl	%eax, %eax
	movl	$1, %edx
	rep stosq
	movq	216(%rsp), %rax
	movq	120(%rsp), %rdi
	movl	$1, %ecx
	movq	%rbx, 320(%rsp)
	movq	%rax, 296(%rsp)
	movq	.LC43(%rip), %rax
	movq	%rbp, 288(%rsp)
	movq	%rax, 312(%rsp)
	movq	%rbp, 384(%rsp)
	call	mk_tok@PLT
	movq	72(%rsp), %rbx
	movdqu	144(%rsp), %xmm0
	movq	192(%rsp), %rax
	movups	%xmm0, 328(%rsp)
	movq	%rbx, %rdi
	movdqu	160(%rsp), %xmm0
	movq	%rax, 376(%rsp)
	movups	%xmm0, 344(%rsp)
	movdqu	176(%rsp), %xmm0
	movups	%xmm0, 360(%rsp)
	call	next@PLT
	movq	%rbx, %rdi
	call	parse_program_ast@PLT
	movq	112(%rsp), %rdi
	movq	%rax, %r14
	call	tok_free@PLT
	cmpq	$0, 8(%r14)
	je	.L246
	movq	%rbp, 56(%rsp)
	movq	%r14, %rbp
	movq	%r13, 48(%rsp)
	jmp	.L241
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L243:
	addq	$1, %r15
	cmpq	8(%rbp), %r15
	jnb	.L376
.L241:
	movq	0(%rbp), %rax
	movq	(%rax,%r15,8), %rax
	cmpl	$1, (%rax)
	jne	.L243
	movq	8(%rax), %rax
	movq	8+g_known_functions(%rip), %r13
	movq	(%rax), %r14
	testq	%r13, %r13
	je	.L244
	leaq	g_known_functions(%rip), %rax
	xorl	%ebx, %ebx
	movq	(%rax), %r12
	.p2align 4
	.p2align 3
.L245:
	movq	(%r12,%rbx,8), %rdi
	movq	%r14, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L243
	addq	$1, %rbx
	cmpq	%r13, %rbx
	jne	.L245
.L244:
	movq	%r14, %rdi
	call	sdup@PLT
	leaq	g_known_functions(%rip), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L243
.L369:
	leaq	.LC60(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L283
	leaq	.LC33(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L284
	leaq	.LC30(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L285
	leaq	.LC61(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L286
	leaq	.LC31(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L287
	leaq	.LC62(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L288
	leaq	.LC32(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L289
	leaq	.LC63(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L290
	leaq	.LC64(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L291
	movl	$7, %edx
	leaq	.LC65(%rip), %rsi
	movq	%r13, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L217
	addq	$7, %r13
	leaq	.LC66(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L292
	leaq	.LC67(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L293
	leaq	.LC68(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L377
	xorl	%eax, %eax
	movl	%eax, 12(%rsp)
	jmp	.L214
.L372:
	subq	$1, %rdx
	jne	.L275
.L248:
	pushq	%r9
	.cfi_def_cfa_offset 472
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	movl	$1, %edx
	pushq	$0
	.cfi_def_cfa_offset 480
	movl	28(%rsp), %r14d
	pushq	%r14
	.cfi_def_cfa_offset 488
	pushq	$0
	.cfi_def_cfa_offset 496
	pushq	$0
	.cfi_def_cfa_offset 504
	pushq	$0
	.cfi_def_cfa_offset 512
	movq	304(%rsp), %rax
	movl	132(%rsp), %r15d
	movl	72(%rsp), %r13d
	movq	(%rax), %rdi
	movl	%r15d, %ecx
	movl	%r13d, %esi
	call	compile_b_to_c
	movq	%r12, %rdi
	movl	$6, %ecx
	addq	$48, %rsp
	.cfi_def_cfa_offset 464
	movq	%rax, %rbx
	xorl	%eax, %eax
	leaq	288(%rsp), %rbp
	rep stosl
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	leaq	224(%rsp), %r12
	call	vec_push@PLT
	leaq	.LC134(%rip), %rdi
	call	sdup@PLT
	movq	%r12, %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	pushq	%r15
	.cfi_def_cfa_offset 472
	xorl	%edx, %edx
	movq	%rbp, %rdi
	pushq	%r14
	.cfi_def_cfa_offset 480
	leaq	.LC135(%rip), %rsi
	pushq	%r13
	.cfi_def_cfa_offset 488
	pushq	$0
	.cfi_def_cfa_offset 496
	pushq	%r12
	.cfi_def_cfa_offset 504
	movl	140(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 512
	movl	144(%rsp), %r9d
	movl	140(%rsp), %r8d
	movl	136(%rsp), %ecx
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 464
	movl	%eax, %ebp
	movl	80(%rsp), %eax
	orl	%ebp, %eax
	jne	.L378
	movq	%rbx, %rdi
	call	unlink@PLT
.L250:
	movq	%rbx, %rdi
	call	free@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	xorl	%r8d, %r8d
	movq	%r8, g_compilation_arena(%rip)
	jmp	.L211
.L254:
	movl	68(%rsp), %eax
	movl	$6, %ecx
	movq	%r12, %rdi
	xorl	%r14d, %r14d
	leaq	.LC52(%rip), %r13
	rep stosl
	testq	%rdx, %rdx
	je	.L264
	movq	%r10, 16(%rsp)
	movl	84(%rsp), %r15d
	movq	%r12, (%rsp)
	jmp	.L257
	.p2align 4,,10
	.p2align 3
.L260:
	subq	$8, %rsp
	.cfi_def_cfa_offset 472
	movl	%r15d, %ecx
	movl	$1, %edx
	movq	%rbx, %rdi
	movl	52(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 480
	movl	28(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 488
	pushq	$0
	.cfi_def_cfa_offset 496
	pushq	$0
	.cfi_def_cfa_offset 504
	movl	76(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 512
	movl	80(%rsp), %r9d
	movl	76(%rsp), %r8d
	movl	72(%rsp), %esi
	call	compile_b_to_c
	addq	$48, %rsp
	.cfi_def_cfa_offset 464
	movq	%rax, %r12
.L274:
	testq	%r12, %r12
	je	.L365
	movq	(%rsp), %rdi
	movq	%r12, %rsi
	call	vec_push@PLT
	testl	%r15d, %r15d
	jne	.L379
.L263:
	addq	$1, %r14
	cmpq	264(%rsp), %r14
	jnb	.L380
.L257:
	movq	256(%rsp), %rax
	movl	40(%rsp), %edx
	movq	(%rax,%r14,8), %rbx
	testl	%edx, %edx
	je	.L260
	movq	%rbx, %rdi
	call	strlen@PLT
	leaq	3(%rax), %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L381
.L261:
	movq	%rbx, %rdx
	movq	%r13, %rsi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	sprintf@PLT
	subq	$8, %rsp
	.cfi_def_cfa_offset 472
	movq	%rbx, %rdi
	movl	%r15d, %ecx
	movl	52(%rsp), %eax
	movl	$1, %edx
	pushq	%rax
	.cfi_def_cfa_offset 480
	movl	28(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 488
	pushq	%rbp
	.cfi_def_cfa_offset 496
	pushq	$1
	.cfi_def_cfa_offset 504
	movl	76(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 512
	movl	80(%rsp), %r9d
	movl	76(%rsp), %r8d
	movl	72(%rsp), %esi
	call	compile_b_to_c
	addq	$48, %rsp
	.cfi_def_cfa_offset 464
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	free@PLT
	jmp	.L274
.L378:
	movq	stderr(%rip), %rdi
	movq	%rbx, %rdx
	leaq	.LC136(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L250
.L240:
	cmpl	$0, 16(%rsp)
	jne	.L275
	cmpl	$0, (%rsp)
	je	.L251
.L276:
	leaq	.LC137(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L252:
	movq	256(%rsp), %rax
	xorl	%edi, %edi
	leaq	216(%rsp), %rsi
	leaq	144(%rsp), %r13
	movq	%rdi, 216(%rsp)
	movq	(%rax), %rbp
	movq	%rbp, %rdi
	call	read_file_all
	movl	$24, %ecx
	movq	%rbp, %r8
	xorl	%esi, %esi
	leaq	304(%rsp), %rdx
	movq	%rax, %rbx
	xorl	%eax, %eax
	movq	%rdx, %rdi
	movl	$1, %edx
	rep stosl
	movq	216(%rsp), %rax
	movq	%r13, %rdi
	movl	$1, %ecx
	movq	%rbx, 288(%rsp)
	movq	%rax, 296(%rsp)
	movq	.LC43(%rip), %rax
	movq	%rbp, 320(%rsp)
	movq	%rax, 312(%rsp)
	movq	%rbx, 384(%rsp)
	call	mk_tok@PLT
	leaq	328(%rsp), %rdi
	movq	%r13, %rsi
	movl	$14, %ecx
	rep movsl
	movq	%r12, %rdi
	call	next@PLT
	movq	%r12, %rdi
	call	parse_program_ast@PLT
	leaq	328(%rsp), %rdi
	movq	%rax, %r12
	call	tok_free@PLT
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	sem_check_program@PLT
	movl	12(%rsp), %r9d
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movl	24(%rsp), %ecx
	movq	stdout(%rip), %rdi
	movl	$1, %r8d
	call	emit_program_c@PLT
	jmp	.L364
.L283:
	movl	$1, 40(%rsp)
	jmp	.L363
.L275:
	leaq	.LC133(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L248
	.p2align 4,,10
	.p2align 3
.L376:
	movq	48(%rsp), %r13
	movq	56(%rsp), %rbp
.L246:
	movq	%rbp, %rdi
	addq	$1, %r13
	call	free@PLT
	movq	264(%rsp), %rdx
	cmpq	%rdx, %r13
	jb	.L242
	movq	136(%rsp), %r10
	movq	72(%rsp), %r12
	jmp	.L239
.L379:
	movq	stderr(%rip), %rdi
	movq	%r12, %rcx
	movq	%rbx, %rdx
	xorl	%eax, %eax
	leaq	.LC139(%rip), %rsi
	call	fprintf@PLT
	jmp	.L263
.L373:
	cmpq	$1, %rdx
	jbe	.L252
	jmp	.L276
.L370:
	movl	$7, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC91(%rip), %rdi
	movl	$2, %ebp
	call	fwrite@PLT
	movq	(%rbx), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC92(%rip), %rsi
	call	fprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$24, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC93(%rip), %rdi
	call	fwrite@PLT
	movq	(%rbx), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC94(%rip), %rsi
	call	fprintf@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$9, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC95(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC96(%rip), %rdi
	call	fwrite@PLT
	movl	$62, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC97(%rip), %rdi
	call	fwrite@PLT
	movl	$52, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC98(%rip), %rdi
	call	fwrite@PLT
	movl	$53, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC99(%rip), %rdi
	call	fwrite@PLT
	movl	$37, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC100(%rip), %rdi
	call	fwrite@PLT
	movl	$69, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC101(%rip), %rdi
	call	fwrite@PLT
	movl	$40, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC102(%rip), %rdi
	call	fwrite@PLT
	movl	$55, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC103(%rip), %rdi
	call	fwrite@PLT
	movl	$58, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC104(%rip), %rdi
	call	fwrite@PLT
	movl	$44, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC105(%rip), %rdi
	call	fwrite@PLT
	movl	$35, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC106(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC107(%rip), %rdi
	call	fwrite@PLT
	movl	$37, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC108(%rip), %rdi
	call	fwrite@PLT
	movl	$39, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC109(%rip), %rdi
	call	fwrite@PLT
	movl	$42, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC110(%rip), %rdi
	call	fwrite@PLT
	movl	$66, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC111(%rip), %rdi
	call	fwrite@PLT
	movl	$57, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC112(%rip), %rdi
	call	fwrite@PLT
	movl	$71, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC113(%rip), %rdi
	call	fwrite@PLT
	movl	$41, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC114(%rip), %rdi
	call	fwrite@PLT
	movl	$64, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC115(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$12, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC116(%rip), %rdi
	call	fwrite@PLT
	movl	$64, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC117(%rip), %rdi
	call	fwrite@PLT
	movl	$71, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC118(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	xorl	%ebx, %ebx
	call	fputc@PLT
	movl	$33, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC119(%rip), %rdi
	call	fwrite@PLT
	movl	$49, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC120(%rip), %rdi
	call	fwrite@PLT
	movl	$49, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC121(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC122(%rip), %rdi
	call	fwrite@PLT
	movl	$46, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC123(%rip), %rdi
	call	fwrite@PLT
	movl	$54, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC124(%rip), %rdi
	call	fwrite@PLT
	movl	$60, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC125(%rip), %rdi
	call	fwrite@PLT
	movl	$51, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC126(%rip), %rdi
	call	fwrite@PLT
	movl	$52, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC127(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rsi
	movl	$10, %edi
	call	fputc@PLT
	movl	$38, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC128(%rip), %rdi
	call	fwrite@PLT
	movl	$33, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC129(%rip), %rdi
	call	fwrite@PLT
	movl	$54, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC130(%rip), %rdi
	call	fwrite@PLT
	movl	$42, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC131(%rip), %rdi
	call	fwrite@PLT
	movl	$72, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC132(%rip), %rdi
	call	fwrite@PLT
	movq	g_compilation_arena(%rip), %rdi
	call	arena_free@PLT
	movq	%rbx, g_compilation_arena(%rip)
	jmp	.L211
.L380:
	movq	16(%rsp), %r10
	movq	(%rsp), %r12
.L264:
	cmpl	$0, 84(%rsp)
	jne	.L382
.L259:
	movl	84(%rsp), %eax
	movq	%r10, %rsi
	movq	%r12, %rdi
	pushq	%rax
	.cfi_def_cfa_offset 472
	movl	20(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 480
	movl	40(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 488
	movl	68(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 496
	leaq	256(%rsp), %rax
	pushq	%rax
	.cfi_def_cfa_offset 504
	movl	140(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 512
	movl	144(%rsp), %r9d
	movl	140(%rsp), %r8d
	movl	136(%rsp), %ecx
	movl	112(%rsp), %edx
	call	run_gcc_multi
	addq	$48, %rsp
	.cfi_def_cfa_offset 464
	testl	%eax, %eax
	jne	.L265
	xorl	%ebx, %ebx
	leaq	.LC144(%rip), %r12
	cmpq	$0, 296(%rsp)
	je	.L365
	movl	80(%rsp), %r13d
	movl	84(%rsp), %r14d
	jmp	.L266
.L271:
	testl	%r14d, %r14d
	jne	.L383
.L272:
	movq	%rbp, %rdi
	addq	$1, %rbx
	call	free@PLT
	cmpq	296(%rsp), %rbx
	jnb	.L365
.L266:
	movq	288(%rsp), %rax
	movq	(%rax,%rbx,8), %rbp
	testl	%r13d, %r13d
	jne	.L271
	movq	%rbp, %rdi
	call	unlink@PLT
	jmp	.L272
.L383:
	movq	stderr(%rip), %rdi
	movq	%rbp, %rdx
	movq	%r12, %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L272
.L284:
	movl	$1, 88(%rsp)
	jmp	.L214
.L285:
	movl	$1, 92(%rsp)
	jmp	.L214
.L382:
	movq	296(%rsp), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	movq	%r10, (%rsp)
	leaq	.LC140(%rip), %rsi
	call	fprintf@PLT
	movq	(%rsp), %r10
	jmp	.L259
.L265:
	movq	stderr(%rip), %rdi
	movl	%eax, %edx
	leaq	.LC141(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	cmpl	$0, 80(%rsp)
	je	.L267
.L270:
	movq	g_compilation_arena(%rip), %rdi
	movl	$1, %ebp
	call	arena_free@PLT
	xorl	%eax, %eax
	movq	%rax, g_compilation_arena(%rip)
	jmp	.L211
.L286:
	xorl	%eax, %eax
	movl	%eax, 92(%rsp)
	jmp	.L214
.L287:
	movl	$1, 96(%rsp)
	jmp	.L214
.L267:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	xorl	%ebx, %ebx
	leaq	.LC142(%rip), %rdi
	leaq	.LC143(%rip), %rbp
	call	fwrite@PLT
	jmp	.L268
.L269:
	movq	288(%rsp), %rax
	movq	stderr(%rip), %rdi
	movq	%rbp, %rsi
	movq	(%rax,%rbx,8), %rdx
	xorl	%eax, %eax
	addq	$1, %rbx
	call	fprintf@PLT
.L268:
	cmpq	296(%rsp), %rbx
	jb	.L269
	jmp	.L270
.L288:
	xorl	%eax, %eax
	movl	%eax, 96(%rsp)
	jmp	.L214
.L289:
	movl	$1, 100(%rsp)
	jmp	.L214
.L290:
	movl	$1, 48(%rsp)
	movl	$1, 24(%rsp)
	jmp	.L214
.L291:
	xorl	%eax, %eax
	movl	$1, 48(%rsp)
	movl	%eax, 24(%rsp)
	jmp	.L214
.L292:
	movl	$16, 12(%rsp)
	jmp	.L214
.L217:
	leaq	.LC70(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L219
	movl	$1, g_strict(%rip)
	xorl	%edx, %edx
	movl	%edx, g_extensions(%rip)
	jmp	.L214
.L377:
	leaq	.LC69(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L214
.L381:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L261
.L374:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	(%rsp), %rsi
	leaq	.LC3(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L256
.L293:
	movl	$32, 12(%rsp)
	jmp	.L214
.L219:
	leaq	.LC71(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L221
	movl	$1, g_pedantic(%rip)
	jmp	.L214
.L221:
	leaq	.LC72(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L295
	leaq	.LC73(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L296
	leaq	.LC74(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L297
	leaq	.LC75(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L214
	leaq	.LC76(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L298
	leaq	.LC77(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L299
	leaq	.LC78(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L300
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	leal	1(%r15), %r14d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L222
	cmpl	%r14d, %ebp
	jle	.L384
.L223:
	movq	8(%rbx,%r12), %rax
	movl	%r14d, %r15d
	movq	%rax, 72(%rsp)
	jmp	.L214
.L295:
	movl	$1, 28(%rsp)
	jmp	.L214
.L384:
	leaq	.LC79(%rip), %rdi
	call	dief@PLT
	jmp	.L223
.L222:
	leaq	.LC80(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L224
	cmpl	%r14d, %ebp
	jg	.L225
	leaq	.LC81(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L225:
	movq	8(%rbx,%r12), %r12
	leaq	.LC82(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L226
	leaq	.LC83(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L226
	leaq	.LC84(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L226
	leaq	.LC85(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L226
	leaq	.LC86(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L227
.L226:
	movl	$1, g_use_curses(%rip)
.L227:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	3(%rax), %r15
	movq	%r15, %rdi
	call	malloc@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L385
.L228:
	movq	%r15, %rsi
	movq	%r13, %rdi
	movq	%r12, %rcx
	xorl	%eax, %eax
	leaq	.LC87(%rip), %rdx
	call	snprintf@PLT
	leaq	224(%rsp), %rdi
	movq	%r13, %rsi
	call	vec_push@PLT
.L231:
	movl	%r14d, %r15d
	jmp	.L214
.L224:
	leaq	.LC88(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L229
	cmpl	%r14d, %ebp
	jle	.L386
.L230:
	movq	8(%rbx,%r12), %rdi
	call	sdup@PLT
	leaq	224(%rsp), %rdi
	movq	%rax, %rsi
	call	vec_push@PLT
	jmp	.L231
.L300:
	xorl	%eax, %eax
	movl	%eax, 44(%rsp)
	jmp	.L214
.L385:
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L228
.L386:
	leaq	.LC89(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L230
.L229:
	cmpb	$45, 0(%r13)
	je	.L387
	leaq	256(%rsp), %rax
	movq	%r13, %rsi
	movq	%rax, %rdi
	call	vec_push@PLT
	jmp	.L214
.L299:
	movl	$1, 84(%rsp)
	jmp	.L214
.L297:
	movl	$1, 36(%rsp)
	jmp	.L214
.L296:
	movl	$1, 32(%rsp)
	jmp	.L214
.L298:
	movl	$1, 56(%rsp)
	jmp	.L214
.L387:
	movq	%r13, %rsi
	leaq	.LC90(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	jmp	.L214
	.cfi_endproc
.LFE21:
	.size	main, .-main
	.local	libb_o_path.0
	.comm	libb_o_path.0,4096,32
	.local	g_libb_dir
	.comm	g_libb_dir,4096,32
	.section	.data.rel.ro.local,"aw"
	.align 8
.LC38:
	.quad	.LC8
	.align 8
.LC39:
	.quad	.LC11
	.align 8
.LC40:
	.quad	.LC24
	.align 8
.LC41:
	.quad	.LC34
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC43:
	.long	1
	.long	1
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC56:
	.quad	7161675788338426927
	.quad	24866934413088863
	.section	.note.GNU-stack,"",@progbits
