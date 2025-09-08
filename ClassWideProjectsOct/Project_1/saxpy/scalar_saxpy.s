	.file	"saxpy.c"
	.text
	.globl	saxpy_scalar
	.type	saxpy_scalar, @function
saxpy_scalar:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movss	%xmm0, -20(%rbp)
	movq	%rdi, -32(%rbp)
	movq	%rsi, -40(%rbp)
	movq	%rdx, -48(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L2
.L3:
	movq	-8(%rbp), %rax
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	movaps	%xmm0, %xmm1
	mulss	-20(%rbp), %xmm1
	movq	-8(%rbp), %rax
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	movq	-8(%rbp), %rax
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	addss	%xmm1, %xmm0
	movss	%xmm0, (%rax)
	addq	$1, -8(%rbp)
.L2:
	movq	-8(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jb	.L3
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	saxpy_scalar, .-saxpy_scalar
	.section	.rodata
.LC1:
	.string	"posix_memalign failed"
	.align 8
.LC5:
	.string	"N = %zu | Time = %.6f s | GFLOP/s = %.2f | Checksum = %.5e\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movl	%edi, -132(%rbp)
	movq	%rsi, -144(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$1, -132(%rbp)
	jle	.L5
	movq	-144(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movl	$10, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	strtoull@PLT
	jmp	.L6
.L5:
	movl	$10000000, %eax
.L6:
	movq	%rax, -80(%rbp)
	movss	.LC0(%rip), %xmm0
	movss	%xmm0, -124(%rbp)
	movq	-80(%rbp), %rax
	leaq	0(,%rax,4), %rdx
	leaq	-120(%rbp), %rax
	movl	$64, %esi
	movq	%rax, %rdi
	call	posix_memalign@PLT
	testl	%eax, %eax
	jne	.L7
	movq	-80(%rbp), %rax
	leaq	0(,%rax,4), %rdx
	leaq	-112(%rbp), %rax
	movl	$64, %esi
	movq	%rax, %rdi
	call	posix_memalign@PLT
	testl	%eax, %eax
	je	.L8
.L7:
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %eax
	jmp	.L16
.L8:
	movl	$42, %edi
	call	srand@PLT
	movq	$0, -104(%rbp)
	jmp	.L10
.L11:
	call	rand@PLT
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movq	-120(%rbp), %rax
	movq	-104(%rbp), %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movss	.LC2(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, (%rax)
	call	rand@PLT
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movq	-112(%rbp), %rax
	movq	-104(%rbp), %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movss	.LC2(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, (%rax)
	addq	$1, -104(%rbp)
.L10:
	movq	-104(%rbp), %rax
	cmpq	-80(%rbp), %rax
	jb	.L11
	movq	-112(%rbp), %rsi
	movq	-120(%rbp), %rcx
	movq	-80(%rbp), %rdx
	movl	-124(%rbp), %eax
	movq	%rcx, %rdi
	movd	%eax, %xmm0
	call	saxpy_scalar
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-112(%rbp), %rsi
	movq	-120(%rbp), %rcx
	movq	-80(%rbp), %rdx
	movl	-124(%rbp), %eax
	movq	%rcx, %rdi
	movd	%eax, %xmm0
	call	saxpy_scalar
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-32(%rbp), %rdx
	movq	-48(%rbp), %rax
	subq	%rax, %rdx
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rdx, %xmm1
	movq	-24(%rbp), %rdx
	movq	-40(%rbp), %rax
	subq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	movsd	.LC3(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -72(%rbp)
	movq	-80(%rbp), %rax
	testq	%rax, %rax
	js	.L12
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L13
.L12:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L13:
	addsd	%xmm0, %xmm0
	movsd	%xmm0, -64(%rbp)
	movsd	-64(%rbp), %xmm0
	divsd	-72(%rbp), %xmm0
	movsd	.LC3(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -56(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -96(%rbp)
	movq	$0, -88(%rbp)
	jmp	.L14
.L15:
	movq	-112(%rbp), %rax
	movq	-88(%rbp), %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movsd	-96(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -96(%rbp)
	addq	$1, -88(%rbp)
.L14:
	movq	-88(%rbp), %rax
	cmpq	-80(%rbp), %rax
	jb	.L15
	movsd	-96(%rbp), %xmm1
	movsd	-56(%rbp), %xmm0
	movq	-72(%rbp), %rdx
	movq	-80(%rbp), %rax
	movapd	%xmm1, %xmm2
	movapd	%xmm0, %xmm1
	movq	%rdx, %xmm0
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$3, %eax
	call	printf@PLT
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$0, %eax
.L16:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L17
	call	__stack_chk_fail@PLT
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	1075838976
	.align 4
.LC2:
	.long	1325400064
	.align 8
.LC3:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
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
