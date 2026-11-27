	.file	"runtime_cache.c"
	.text
	.p2align 4
	.type	discard_temporary, @function
discard_temporary:
.LFB49:
	.cfi_startproc
	endbr64
	cmpb	$0, temporary_object(%rip)
	jne	.L8
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	temporary_object(%rip), %rdi
	call	unlink@PLT
	movb	$0, temporary_object(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE49:
	.size	discard_temporary, .-discard_temporary
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"gcc"
.LC1:
	.string	"-std=c99"
.LC2:
	.string	"-O2"
.LC3:
	.string	"-c"
.LC4:
	.string	"-o"
.LC5:
	.string	"libb.c"
.LC6:
	.string	"libb.h"
.LC7:
	.string	"btarget.h"
.LC8:
	.string	"binit.h"
.LC9:
	.string	"bcall.h"
.LC10:
	.string	"bunix.h"
.LC11:
	.string	"bformat.h"
.LC12:
	.string	"bprimitives.h"
.LC13:
	.string	"BCC_CACHE_DIR"
.LC14:
	.string	"%s"
.LC15:
	.string	"/tmp/bcc-libb-%lu"
.LC16:
	.string	"%s/libb.c"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC17:
	.string	"runtime source path is too long"
	.section	.rodata.str1.1
.LC18:
	.string	"%s/%s"
.LC19:
	.string	"rb"
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"cannot read runtime dependency %s"
	.section	.rodata.str1.1
.LC21:
	.string	"libb.c not found at %s"
.LC22:
	.string	"%s/libb_%016lx_%d_%d_%d.o"
.LC23:
	.string	"%s.XXXXXX"
.LC24:
	.string	"cannot create runtime object"
.LC25:
	.string	"cannot protect runtime object"
.LC26:
	.string	"cannot close runtime object"
.LC27:
	.string	"fork failed"
.LC28:
	.string	"Failed to compile libb.c"
	.section	.rodata.str1.8
	.align 8
.LC29:
	.string	"cannot register runtime object cleanup"
	.section	.rodata.str1.1
.LC30:
	.string	"-I%s"
.LC31:
	.string	"-DB_BYTEPTR=%d"
.LC32:
	.string	"-DWORD_BITS=%d"
.LC33:
	.string	"-D__bcc_strict_runtime=%d"
.LC34:
	.string	"Compiling runtime library...\n"
	.text
	.p2align 4
	.globl	compile_libb
	.type	compile_libb, @function
compile_libb:
.LFB53:
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
	leaq	-24576(%rsp), %r11
	.cfi_def_cfa 11, 24632
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	.cfi_def_cfa_register 7
	subq	$584, %rsp
	.cfi_def_cfa_offset 25216
	movq	.LC36(%rip), %xmm1
	movq	%rdi, (%rsp)
	leaq	.LC13(%rip), %rdi
	movl	%ecx, 56(%rsp)
	leaq	368(%rsp), %rcx
	movl	%esi, 40(%rsp)
	movl	%edx, 44(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 25144(%rsp)
	leaq	.LC1(%rip), %rax
	movq	%rcx, 24(%rsp)
	leaq	496(%rsp), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %xmm5
	leaq	16944(%rsp), %rax
	movq	%rax, %xmm2
	movq	%rax, 128(%rsp)
	punpcklqdq	%xmm5, %xmm1
	leaq	432(%rsp), %rax
	movq	%rax, %xmm3
	movhps	24(%rsp), %xmm2
	movaps	%xmm1, 112(%rsp)
	movq	%rax, 136(%rsp)
	leaq	560(%rsp), %rax
	movhps	32(%rsp), %xmm3
	movq	%rax, %rcx
	movq	%rax, 16(%rsp)
	leaq	.LC4(%rip), %rax
	movq	%rcx, %xmm4
	movq	%rax, %xmm6
	movaps	%xmm2, 96(%rsp)
	punpcklqdq	%xmm6, %xmm4
	movaps	%xmm3, 80(%rsp)
	movaps	%xmm4, 64(%rsp)
	call	getenv@PLT
	testq	%rax, %rax
	je	.L10
	cmpb	$0, (%rax)
	jne	.L86
.L10:
	call	geteuid@PLT
	movl	$4096, %ecx
	movl	$2, %edx
	leaq	4656(%rsp), %rbp
	movl	%eax, %r9d
	leaq	.LC15(%rip), %r8
	movq	%rbp, %rdi
	xorl	%eax, %eax
	movl	$4096, %esi
	call	__snprintf_chk@PLT
	movl	%eax, %ecx
.L12:
	cmpl	$1, %ecx
	jle	.L14
	movslq	%ecx, %rax
	subl	$2, %ecx
	leaq	0(%rbp,%rax), %rdx
	leaq	4655(%rsp,%rax), %rax
	subq	%rcx, %rax
	jmp	.L15
	.p2align 4,,10
	.p2align 3
.L18:
	movb	$0, -1(%rdx)
	subq	$1, %rdx
	cmpq	%rax, %rdx
	je	.L14
.L15:
	cmpb	$47, -1(%rdx)
	je	.L18
.L14:
	movl	$448, %esi
	movq	%rbp, %rdi
	call	mkdir@PLT
	testl	%eax, %eax
	je	.L87
	call	__errno_location@PLT
	cmpl	$17, (%rax)
	je	.L20
.L11:
	movl	$0, 60(%rsp)
.L13:
	movq	(%rsp), %r9
	movq	16(%rsp), %rdi
	xorl	%eax, %eax
	movl	$4096, %ecx
	leaq	.LC16(%rip), %r8
	movl	$2, %edx
	movl	$4096, %esi
	call	__snprintf_chk@PLT
	cmpl	$4095, %eax
	ja	.L88
	leaq	.LC6(%rip), %rax
	leaq	.LC5(%rip), %rcx
	movq	%rbp, 48(%rsp)
	movabsq	$-3750763034362895579, %rbx
	movq	%rax, %xmm7
	movq	%rcx, %xmm0
	leaq	.LC8(%rip), %rax
	movabsq	$1099511628211, %r12
	punpcklqdq	%xmm7, %xmm0
	leaq	.LC7(%rip), %rcx
	movq	%rax, %xmm5
	movaps	%xmm0, 160(%rsp)
	movq	%rcx, %xmm0
	leaq	.LC10(%rip), %rax
	leaq	.LC9(%rip), %rcx
	punpcklqdq	%xmm5, %xmm0
	movq	%rax, %xmm6
	leaq	.LC12(%rip), %rax
	movaps	%xmm0, 176(%rsp)
	movq	%rcx, %xmm0
	movq	%rax, %xmm7
	leaq	.LC11(%rip), %rcx
	punpcklqdq	%xmm6, %xmm0
	leaq	224(%rsp), %rax
	leaq	160(%rsp), %r13
	movaps	%xmm0, 192(%rsp)
	movq	%rcx, %xmm0
	leaq	8752(%rsp), %r15
	movq	%rax, 8(%rsp)
	punpcklqdq	%xmm7, %xmm0
	movaps	%xmm0, 208(%rsp)
	.p2align 4,,10
	.p2align 3
.L25:
	subq	$8, %rsp
	.cfi_def_cfa_offset 25224
	pushq	0(%r13)
	.cfi_def_cfa_offset 25232
	movl	$8192, %ecx
	movq	%r15, %rdi
	movq	16(%rsp), %r9
	leaq	.LC18(%rip), %r8
	movl	$2, %edx
	xorl	%eax, %eax
	movl	$8192, %esi
	call	__snprintf_chk@PLT
	leaq	.LC19(%rip), %rsi
	movq	%r15, %rdi
	call	fopen@PLT
	popq	%r14
	.cfi_def_cfa_offset 25224
	movq	%rax, %rbp
	popq	%rax
	.cfi_def_cfa_offset 25216
	testq	%rbp, %rbp
	jne	.L22
	jmp	.L24
	.p2align 4,,10
	.p2align 3
.L23:
	movzbl	%al, %eax
	xorq	%rbx, %rax
	imulq	%r12, %rax
	movq	%rax, %rbx
.L22:
	movq	%rbp, %rdi
	call	fgetc@PLT
	cmpl	$-1, %eax
	jne	.L23
	movq	%rbp, %rdi
	call	ferror@PLT
	movl	%eax, %r14d
	testl	%eax, %eax
	jne	.L24
	movq	%rbp, %rdi
	addq	$8, %r13
	call	fclose@PLT
	movq	8(%rsp), %rax
	cmpq	%rax, %r13
	jne	.L25
	movl	60(%rsp), %r11d
	movq	48(%rsp), %rbp
	testl	%r11d, %r11d
	jne	.L26
	movq	16(%rsp), %rdi
	movl	$4, %esi
	call	access@PLT
	testl	%eax, %eax
	jne	.L28
	movl	40(%rsp), %edi
	testl	%edi, %edi
	jne	.L89
.L85:
	movq	(%rsp), %r9
	movl	$8192, %ecx
	movl	$2, %edx
	xorl	%eax, %eax
	movq	128(%rsp), %rdi
	leaq	.LC30(%rip), %r8
	movl	$8192, %esi
	call	__snprintf_chk@PLT
	movl	44(%rsp), %eax
	xorl	%r9d, %r9d
	movq	24(%rsp), %rdi
	movl	$64, %ecx
	movl	$2, %edx
	movl	$64, %esi
	testl	%eax, %eax
	leaq	.LC31(%rip), %r8
	setne	%r9b
	xorl	%eax, %eax
	call	__snprintf_chk@PLT
	movl	56(%rsp), %r9d
	movl	$64, %ecx
	xorl	%eax, %eax
	movq	136(%rsp), %rdi
	movl	$2, %edx
	movl	$64, %esi
	leaq	.LC32(%rip), %r8
	call	__snprintf_chk@PLT
	movl	g_strict(%rip), %edx
	xorl	%r9d, %r9d
	movq	32(%rsp), %rdi
	leaq	.LC33(%rip), %r8
	movl	$64, %ecx
	movl	$64, %esi
	testl	%edx, %edx
	movl	$2, %edx
	setne	%r9b
	xorl	%eax, %eax
	call	__snprintf_chk@PLT
.L34:
	movdqa	.LC35(%rip), %xmm0
	movq	%r15, %rdi
	movabsq	$24866934413088813, %rax
	movaps	%xmm0, 8752(%rsp)
	movq	%rax, 8765(%rsp)
	call	mkstemp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	js	.L90
.L35:
	movl	%ebx, %edi
	movl	$384, %esi
	call	fchmod@PLT
	movl	%ebx, %edi
	testl	%eax, %eax
	jne	.L91
	call	close@PLT
	testl	%eax, %eax
	jne	.L92
	leaq	.LC3(%rip), %rax
	leaq	.LC2(%rip), %rcx
	movdqa	112(%rsp), %xmm5
	movdqa	96(%rsp), %xmm7
	movdqa	80(%rsp), %xmm1
	movdqa	64(%rsp), %xmm2
	movq	%rcx, %xmm0
	movq	%rax, %xmm6
	punpcklqdq	%xmm6, %xmm0
	movq	%r15, 304(%rsp)
	movq	$0, 312(%rsp)
	movaps	%xmm5, 224(%rsp)
	movaps	%xmm0, 240(%rsp)
	movaps	%xmm7, 256(%rsp)
	movaps	%xmm1, 272(%rsp)
	movaps	%xmm2, 288(%rsp)
	call	fork@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	js	.L93
	je	.L94
	movl	$0, 156(%rsp)
	leaq	156(%rsp), %rbp
	jmp	.L42
	.p2align 4,,10
	.p2align 3
.L95:
	call	__errno_location@PLT
	cmpl	$4, (%rax)
	jne	.L43
.L42:
	xorl	%edx, %edx
	movq	%rbp, %rsi
	movl	%ebx, %edi
	call	waitpid@PLT
	testl	%eax, %eax
	js	.L95
	testl	$65407, 156(%rsp)
	jne	.L43
	testl	%r14d, %r14d
	je	.L48
	leaq	libb_o_path.1(%rip), %rbp
	movq	%r15, %rdi
	movq	%rbp, %rsi
	call	rename@PLT
	testl	%eax, %eax
	jne	.L48
.L57:
	leaq	libb_o_path.1(%rip), %rax
.L9:
	movq	25144(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L96
	addq	$25160, %rsp
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
.L87:
	.cfi_restore_state
	movl	$448, %esi
	movq	%rbp, %rdi
	call	chmod@PLT
	testl	%eax, %eax
	jne	.L11
.L20:
	leaq	224(%rsp), %rsi
	movq	%rbp, %rdi
	call	lstat@PLT
	testl	%eax, %eax
	jne	.L11
	movl	248(%rsp), %eax
	andl	$61440, %eax
	cmpl	$16384, %eax
	jne	.L11
	movl	252(%rsp), %ebx
	call	geteuid@PLT
	cmpl	%eax, %ebx
	jne	.L11
	movl	248(%rsp), %eax
	andl	$511, %eax
	cmpl	$448, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, 60(%rsp)
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L48:
	cmpb	$0, temporary_object(%rip)
	leaq	temporary_object(%rip), %rbx
	jne	.L97
.L47:
	movq	%r15, %rdi
	call	strlen@PLT
	leaq	temporary_object(%rip), %rdi
	addq	$1, %rax
	cmpl	$8, %eax
	jb	.L50
	movl	%eax, %ecx
	movq	%r15, %rsi
	movq	%rbx, %rdi
	shrl	$3, %ecx
	rep movsq
	movq	%rsi, %r15
.L50:
	xorl	%edx, %edx
	testb	$4, %al
	je	.L51
	movl	(%r15), %edx
	movl	%edx, (%rdi)
	movl	$4, %edx
.L51:
	testb	$2, %al
	je	.L52
	movzwl	(%r15,%rdx), %ecx
	movw	%cx, (%rdi,%rdx)
	addq	$2, %rdx
.L52:
	testb	$1, %al
	je	.L53
	movzbl	(%r15,%rdx), %eax
	movb	%al, (%rdi,%rdx)
.L53:
	movl	registered.0(%rip), %r8d
	testl	%r8d, %r8d
	je	.L98
.L54:
	leaq	temporary_object(%rip), %rax
	jmp	.L9
.L26:
	xorl	%eax, %eax
	movq	%rbp, %r9
	movl	$4224, %esi
	movl	$4224, %ecx
	movl	g_strict(%rip), %r10d
	leaq	libb_o_path.1(%rip), %rbp
	movl	$2, %edx
	leaq	.LC22(%rip), %r8
	movq	%rbp, %rdi
	testl	%r10d, %r10d
	setne	%al
	pushq	%rax
	.cfi_def_cfa_offset 25224
	movl	64(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 25232
	movl	60(%rsp), %eax
	pushq	%rax
	.cfi_def_cfa_offset 25240
	xorl	%eax, %eax
	pushq	%rbx
	.cfi_def_cfa_offset 25248
	call	__snprintf_chk@PLT
	movq	48(%rsp), %rdi
	addq	$32, %rsp
	.cfi_def_cfa_offset 25216
	movl	$4, %esi
	call	access@PLT
	testl	%eax, %eax
	jne	.L28
	movq	8(%rsp), %rsi
	movq	%rbp, %rdi
	call	lstat@PLT
	testl	%eax, %eax
	je	.L99
.L29:
	movl	40(%rsp), %r9d
	testl	%r9d, %r9d
	jne	.L100
.L84:
	movq	(%rsp), %r9
	movl	$8192, %ecx
	movl	$2, %edx
	xorl	%eax, %eax
	movq	128(%rsp), %rdi
	leaq	.LC30(%rip), %r8
	movl	$8192, %esi
	call	__snprintf_chk@PLT
	movl	44(%rsp), %ecx
	xorl	%r9d, %r9d
	movq	24(%rsp), %rdi
	leaq	.LC31(%rip), %r8
	movl	$2, %edx
	movl	$64, %esi
	testl	%ecx, %ecx
	movl	$64, %ecx
	setne	%r9b
	xorl	%eax, %eax
	call	__snprintf_chk@PLT
	movl	56(%rsp), %r9d
	movl	$64, %ecx
	xorl	%eax, %eax
	movq	136(%rsp), %rdi
	movl	$2, %edx
	movl	$64, %esi
	leaq	.LC32(%rip), %r8
	call	__snprintf_chk@PLT
	movl	g_strict(%rip), %esi
	xorl	%r9d, %r9d
	movq	32(%rsp), %rdi
	leaq	.LC33(%rip), %r8
	movl	$64, %ecx
	movl	$2, %edx
	testl	%esi, %esi
	movl	$64, %esi
	setne	%r9b
	xorl	%eax, %eax
	call	__snprintf_chk@PLT
	movl	$4232, %ecx
	movq	%r15, %rdi
	xorl	%eax, %eax
	leaq	libb_o_path.1(%rip), %r9
	movl	$2, %edx
	movl	$4232, %esi
	leaq	.LC23(%rip), %r8
	call	__snprintf_chk@PLT
	movq	%r15, %rdi
	call	mkstemp@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	js	.L34
	movl	60(%rsp), %r14d
	jmp	.L35
.L86:
	leaq	4656(%rsp), %rbp
	movq	%rax, %rcx
	movl	$4096, %esi
	xorl	%eax, %eax
	leaq	.LC14(%rip), %rdx
	movq	%rbp, %rdi
	call	snprintf@PLT
	movl	%eax, %ecx
	cmpl	$4095, %eax
	ja	.L11
	jmp	.L12
.L99:
	movl	248(%rsp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	jne	.L29
	movl	252(%rsp), %ebx
	call	geteuid@PLT
	cmpl	%eax, %ebx
	jne	.L29
	testb	$63, 248(%rsp)
	jne	.L29
	cmpq	$1, 240(%rsp)
	jne	.L29
	cmpq	$0, 272(%rsp)
	jle	.L29
	movl	$4, %esi
	movq	%rbp, %rdi
	call	access@PLT
	testl	%eax, %eax
	jne	.L29
	jmp	.L57
	.p2align 4,,10
	.p2align 3
.L97:
	movq	%rbx, %rdi
	call	unlink@PLT
	movb	$0, temporary_object(%rip)
	jmp	.L47
.L98:
	leaq	discard_temporary(%rip), %rdi
	call	atexit@PLT
	testl	%eax, %eax
	jne	.L101
	movl	$1, registered.0(%rip)
	jmp	.L54
.L100:
	movq	stderr(%rip), %rdi
	leaq	.LC34(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L84
.L24:
	movq	%r15, %rsi
	leaq	.LC20(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L101:
	cmpb	$0, temporary_object(%rip)
	jne	.L102
.L56:
	leaq	.LC29(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L90:
	leaq	.LC24(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L91:
	call	close@PLT
	movq	%r15, %rdi
	call	unlink@PLT
	leaq	.LC25(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L102:
	movq	%rbx, %rdi
	call	unlink@PLT
	movb	$0, temporary_object(%rip)
	jmp	.L56
.L92:
	movq	%r15, %rdi
	call	unlink@PLT
	leaq	.LC26(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L93:
	movq	%r15, %rdi
	call	unlink@PLT
	leaq	.LC27(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L94:
	movq	8(%rsp), %rsi
	leaq	.LC0(%rip), %rdi
	call	execvp@PLT
	movl	$127, %edi
	call	_exit@PLT
.L43:
	movq	%r15, %rdi
	call	unlink@PLT
	leaq	.LC28(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L96:
	call	__stack_chk_fail@PLT
.L89:
	movq	stderr(%rip), %rdi
	leaq	.LC34(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L85
.L28:
	movq	16(%rsp), %rsi
	leaq	.LC21(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
.L88:
	leaq	.LC17(%rip), %rdi
	xorl	%eax, %eax
	call	dief@PLT
	.cfi_endproc
.LFE53:
	.size	compile_libb, .-compile_libb
	.local	registered.0
	.comm	registered.0,4,4
	.local	libb_o_path.1
	.comm	libb_o_path.1,4224,32
	.local	temporary_object
	.comm	temporary_object,8192,32
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC35:
	.quad	7161675788338426927
	.quad	6365887973869317165
	.section	.data.rel.ro.local,"aw"
	.align 8
.LC36:
	.quad	.LC0
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
