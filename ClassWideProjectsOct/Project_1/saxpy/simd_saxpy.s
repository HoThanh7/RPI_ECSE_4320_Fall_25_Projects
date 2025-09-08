	.file	"saxpy.c"
	.text
	.p2align 4
	.globl	saxpy_scalar
	.type	saxpy_scalar, @function
saxpy_scalar:
.LFB26:
	.cfi_startproc
	endbr64
	testq	%rdx, %rdx
	movq	%rsi, %rcx
	movq	%rdx, %rsi
	je	.L99
	leaq	-1(%rdx), %rdx
	cmpq	$2, %rdx
	jbe	.L11
	leaq	4(%rdi), %rax
	movq	%rcx, %r8
	xorl	%r11d, %r11d
	subq	%rax, %r8
	cmpq	$24, %r8
	ja	.L101
.L64:
	movq	%rsi, %rax
	andl	$7, %eax
	je	.L9
	cmpq	$1, %rax
	je	.L71
	cmpq	$2, %rax
	je	.L72
	cmpq	$3, %rax
	je	.L73
	cmpq	$4, %rax
	je	.L74
	cmpq	$5, %rax
	je	.L75
	cmpq	$6, %rax
	jne	.L102
.L76:
	vmovss	(%rdi,%r11,4), %xmm8
	vfmadd213ss	(%rcx,%r11,4), %xmm0, %xmm8
	vmovss	%xmm8, (%rcx,%r11,4)
	addq	$1, %r11
.L75:
	vmovss	(%rdi,%r11,4), %xmm9
	vfmadd213ss	(%rcx,%r11,4), %xmm0, %xmm9
	vmovss	%xmm9, (%rcx,%r11,4)
	addq	$1, %r11
.L74:
	vmovss	(%rdi,%r11,4), %xmm10
	vfmadd213ss	(%rcx,%r11,4), %xmm0, %xmm10
	vmovss	%xmm10, (%rcx,%r11,4)
	addq	$1, %r11
.L73:
	vmovss	(%rdi,%r11,4), %xmm11
	vfmadd213ss	(%rcx,%r11,4), %xmm0, %xmm11
	vmovss	%xmm11, (%rcx,%r11,4)
	addq	$1, %r11
.L72:
	vmovss	(%rdi,%r11,4), %xmm12
	vfmadd213ss	(%rcx,%r11,4), %xmm0, %xmm12
	vmovss	%xmm12, (%rcx,%r11,4)
	addq	$1, %r11
.L71:
	vmovss	(%rdi,%r11,4), %xmm13
	vfmadd213ss	(%rcx,%r11,4), %xmm0, %xmm13
	vmovss	%xmm13, (%rcx,%r11,4)
	addq	$1, %r11
	cmpq	%r11, %rsi
	je	.L103
.L9:
	vmovss	(%rdi,%r11,4), %xmm14
	vfmadd213ss	(%rcx,%r11,4), %xmm0, %xmm14
	vmovss	%xmm14, (%rcx,%r11,4)
	vmovss	4(%rdi,%r11,4), %xmm15
	vfmadd213ss	4(%rcx,%r11,4), %xmm0, %xmm15
	vmovss	%xmm15, 4(%rcx,%r11,4)
	vmovss	8(%rdi,%r11,4), %xmm2
	vfmadd213ss	8(%rcx,%r11,4), %xmm0, %xmm2
	vmovss	%xmm2, 8(%rcx,%r11,4)
	vmovss	12(%rdi,%r11,4), %xmm1
	vfmadd213ss	12(%rcx,%r11,4), %xmm0, %xmm1
	vmovss	%xmm1, 12(%rcx,%r11,4)
	vmovss	16(%rdi,%r11,4), %xmm3
	vfmadd213ss	16(%rcx,%r11,4), %xmm0, %xmm3
	vmovss	%xmm3, 16(%rcx,%r11,4)
	vmovss	20(%rdi,%r11,4), %xmm4
	vfmadd213ss	20(%rcx,%r11,4), %xmm0, %xmm4
	vmovss	%xmm4, 20(%rcx,%r11,4)
	vmovss	24(%rdi,%r11,4), %xmm5
	vfmadd213ss	24(%rcx,%r11,4), %xmm0, %xmm5
	vmovss	%xmm5, 24(%rcx,%r11,4)
	vmovss	28(%rdi,%r11,4), %xmm6
	vfmadd213ss	28(%rcx,%r11,4), %xmm0, %xmm6
	vmovss	%xmm6, 28(%rcx,%r11,4)
	addq	$8, %r11
	cmpq	%r11, %rsi
	jne	.L9
	ret
.L97:
	vzeroupper
.L99:
	ret
	.p2align 4,,10
	.p2align 3
.L101:
	cmpq	$6, %rdx
	jbe	.L13
	movq	%rsi, %r9
	vbroadcastss	%xmm0, %ymm1
	shrq	$3, %r9
	salq	$5, %r9
	leaq	-32(%r9), %r10
	shrq	$5, %r10
	addq	$1, %r10
	andl	$7, %r10d
	je	.L5
	cmpq	$1, %r10
	je	.L65
	cmpq	$2, %r10
	je	.L66
	cmpq	$3, %r10
	je	.L67
	cmpq	$4, %r10
	je	.L68
	cmpq	$5, %r10
	je	.L69
	cmpq	$6, %r10
	jne	.L104
.L70:
	vmovups	(%rdi,%r11), %ymm3
	vfmadd213ps	(%rcx,%r11), %ymm1, %ymm3
	vmovups	%ymm3, (%rcx,%r11)
	addq	$32, %r11
.L69:
	vmovups	(%rdi,%r11), %ymm4
	vfmadd213ps	(%rcx,%r11), %ymm1, %ymm4
	vmovups	%ymm4, (%rcx,%r11)
	addq	$32, %r11
.L68:
	vmovups	(%rdi,%r11), %ymm5
	vfmadd213ps	(%rcx,%r11), %ymm1, %ymm5
	vmovups	%ymm5, (%rcx,%r11)
	addq	$32, %r11
.L67:
	vmovups	(%rdi,%r11), %ymm6
	vfmadd213ps	(%rcx,%r11), %ymm1, %ymm6
	vmovups	%ymm6, (%rcx,%r11)
	addq	$32, %r11
.L66:
	vmovups	(%rdi,%r11), %ymm7
	vfmadd213ps	(%rcx,%r11), %ymm1, %ymm7
	vmovups	%ymm7, (%rcx,%r11)
	addq	$32, %r11
.L65:
	vmovups	(%rdi,%r11), %ymm8
	vfmadd213ps	(%rcx,%r11), %ymm1, %ymm8
	vmovups	%ymm8, (%rcx,%r11)
	addq	$32, %r11
	cmpq	%r9, %r11
	je	.L96
.L5:
	vmovups	(%rdi,%r11), %ymm9
	vfmadd213ps	(%rcx,%r11), %ymm1, %ymm9
	vmovups	%ymm9, (%rcx,%r11)
	vmovups	32(%rdi,%r11), %ymm10
	vfmadd213ps	32(%rcx,%r11), %ymm1, %ymm10
	vmovups	%ymm10, 32(%rcx,%r11)
	vmovups	64(%rdi,%r11), %ymm11
	vfmadd213ps	64(%rcx,%r11), %ymm1, %ymm11
	vmovups	%ymm11, 64(%rcx,%r11)
	vmovups	96(%rdi,%r11), %ymm12
	vfmadd213ps	96(%rcx,%r11), %ymm1, %ymm12
	vmovups	%ymm12, 96(%rcx,%r11)
	vmovups	128(%rdi,%r11), %ymm13
	vfmadd213ps	128(%rcx,%r11), %ymm1, %ymm13
	vmovups	%ymm13, 128(%rcx,%r11)
	vmovups	160(%rdi,%r11), %ymm14
	vfmadd213ps	160(%rcx,%r11), %ymm1, %ymm14
	vmovups	%ymm14, 160(%rcx,%r11)
	vmovups	192(%rdi,%r11), %ymm15
	vfmadd213ps	192(%rcx,%r11), %ymm1, %ymm15
	vmovups	%ymm15, 192(%rcx,%r11)
	vmovups	224(%rdi,%r11), %ymm2
	vfmadd213ps	224(%rcx,%r11), %ymm1, %ymm2
	vmovups	%ymm2, 224(%rcx,%r11)
	addq	$256, %r11
	cmpq	%r9, %r11
	jne	.L5
.L96:
	movq	%rsi, %rax
	andq	$-8, %rax
	testb	$7, %sil
	je	.L97
	movq	%rsi, %rdx
	subq	%rax, %rdx
	leaq	-1(%rdx), %r8
	cmpq	$2, %r8
	jbe	.L105
	vzeroupper
.L4:
	leaq	(%rcx,%rax,4), %r9
	vshufps	$0, %xmm0, %xmm0, %xmm1
	movq	%rdx, %r10
	vmovups	(%r9), %xmm3
	vfmadd132ps	(%rdi,%rax,4), %xmm3, %xmm1
	andq	$-4, %r10
	addq	%r10, %rax
	andl	$3, %edx
	vmovups	%xmm1, (%r9)
	je	.L99
.L7:
	leaq	0(,%rax,4), %r11
	vmovss	(%rdi,%rax,4), %xmm4
	leaq	1(%rax), %r8
	leaq	(%rcx,%r11), %rdx
	cmpq	%rsi, %r8
	vfmadd213ss	(%rdx), %xmm0, %xmm4
	vmovss	%xmm4, (%rdx)
	jnb	.L99
	leaq	4(%rcx,%r11), %r9
	vmovss	4(%rdi,%r11), %xmm5
	addq	$2, %rax
	vfmadd213ss	(%r9), %xmm0, %xmm5
	cmpq	%rsi, %rax
	vmovss	%xmm5, (%r9)
	jnb	.L99
	leaq	8(%rcx,%r11), %rcx
	vmovss	(%rcx), %xmm6
	vfmadd132ss	8(%rdi,%r11), %xmm6, %xmm0
	vmovss	%xmm0, (%rcx)
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	xorl	%r11d, %r11d
	jmp	.L64
	.p2align 4,,10
	.p2align 3
.L102:
	vmovss	(%rdi), %xmm7
	vfmadd213ss	(%rcx), %xmm0, %xmm7
	movl	$1, %r11d
	vmovss	%xmm7, (%rcx)
	jmp	.L76
.L103:
	ret
.L104:
	vmovups	(%rdi), %ymm2
	vfmadd213ps	(%rcx), %ymm1, %ymm2
	movl	$32, %r11d
	vmovups	%ymm2, (%rcx)
	jmp	.L70
.L13:
	movq	%rsi, %rdx
	xorl	%eax, %eax
	jmp	.L4
.L105:
	vzeroupper
	jmp	.L7
	.cfi_endproc
.LFE26:
	.size	saxpy_scalar, .-saxpy_scalar
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"posix_memalign failed"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC8:
	.string	"N = %zu | Time = %.6f s | GFLOP/s = %.2f | Checksum = %.5e\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB9:
	.section	.text.startup,"ax",@progbits
.LHOTB9:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB27:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x60,0x6
	.cfi_escape 0x10,0xe,0x2,0x76,0x78
	.cfi_escape 0x10,0xd,0x2,0x76,0x70
	.cfi_escape 0x10,0xc,0x2,0x76,0x68
	pushq	%rbx
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	movl	$10000000, %ebx
	subq	$104, %rsp
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L107
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtoull@PLT
	movq	%rax, %rbx
.L107:
	leaq	0(,%rbx,4), %r12
	leaq	-112(%rbp), %rdi
	movl	$64, %esi
	movq	%r12, %rdx
	call	posix_memalign@PLT
	testl	%eax, %eax
	jne	.L110
	movq	%r12, %rdx
	leaq	-104(%rbp), %rdi
	movl	$64, %esi
	call	posix_memalign@PLT
	testl	%eax, %eax
	movl	%eax, %r12d
	jne	.L110
	movl	$42, %edi
	call	srand@PLT
	testq	%rbx, %rbx
	je	.L111
	movq	%rbx, %rcx
	xorl	%r13d, %r13d
	andl	$3, %ecx
	je	.L112
	cmpq	$1, %rcx
	je	.L278
	cmpq	$2, %rcx
	je	.L279
	call	rand@PLT
	vxorps	%xmm3, %xmm3, %xmm3
	movq	-112(%rbp), %rsi
	vcvtsi2ssl	%eax, %xmm3, %xmm1
	vmulss	.LC2(%rip), %xmm1, %xmm2
	vmovss	%xmm2, (%rsi,%r13)
	call	rand@PLT
	vxorps	%xmm4, %xmm4, %xmm4
	movq	-104(%rbp), %rdi
	vcvtsi2ssl	%eax, %xmm4, %xmm6
	vmulss	.LC2(%rip), %xmm6, %xmm7
	vmovss	%xmm7, (%rdi,%r13)
	movl	$1, %r13d
.L279:
	call	rand@PLT
	vxorps	%xmm8, %xmm8, %xmm8
	movq	-112(%rbp), %r8
	leaq	0(,%r13,4), %r14
	vcvtsi2ssl	%eax, %xmm8, %xmm9
	vmulss	.LC2(%rip), %xmm9, %xmm10
	addq	$1, %r13
	vmovss	%xmm10, (%r8,%r14)
	call	rand@PLT
	vxorps	%xmm11, %xmm11, %xmm11
	movq	-104(%rbp), %r9
	vcvtsi2ssl	%eax, %xmm11, %xmm12
	vmulss	.LC2(%rip), %xmm12, %xmm13
	vmovss	%xmm13, (%r9,%r14)
.L278:
	call	rand@PLT
	vxorps	%xmm14, %xmm14, %xmm14
	movq	-112(%rbp), %r11
	leaq	0(,%r13,4), %r14
	vcvtsi2ssl	%eax, %xmm14, %xmm15
	vmulss	.LC2(%rip), %xmm15, %xmm5
	vmovss	%xmm5, (%r11,%r14)
	call	rand@PLT
	vxorps	%xmm0, %xmm0, %xmm0
	movq	-104(%rbp), %r10
	vcvtsi2ssl	%eax, %xmm0, %xmm3
	vmulss	.LC2(%rip), %xmm3, %xmm1
	vmovss	%xmm1, (%r10,%r14)
	movq	%r13, %r14
	addq	$1, %r13
	cmpq	%r13, %rbx
	je	.L365
.L112:
	call	rand@PLT
	vxorps	%xmm2, %xmm2, %xmm2
	leaq	1(%r13), %r14
	vcvtsi2ssl	%eax, %xmm2, %xmm4
	vmulss	.LC2(%rip), %xmm4, %xmm6
	movq	-112(%rbp), %rax
	vmovss	%xmm6, (%rax,%r13,4)
	call	rand@PLT
	vxorps	%xmm7, %xmm7, %xmm7
	movq	-104(%rbp), %rdx
	vcvtsi2ssl	%eax, %xmm7, %xmm8
	vmulss	.LC2(%rip), %xmm8, %xmm9
	vmovss	%xmm9, (%rdx,%r13,4)
	call	rand@PLT
	vxorps	%xmm10, %xmm10, %xmm10
	movq	-112(%rbp), %rcx
	vcvtsi2ssl	%eax, %xmm10, %xmm11
	vmulss	.LC2(%rip), %xmm11, %xmm12
	vmovss	%xmm12, (%rcx,%r14,4)
	call	rand@PLT
	vxorps	%xmm13, %xmm13, %xmm13
	movq	-104(%rbp), %rsi
	vcvtsi2ssl	%eax, %xmm13, %xmm14
	vmulss	.LC2(%rip), %xmm14, %xmm15
	vmovss	%xmm15, (%rsi,%r14,4)
	leaq	2(%r13), %r14
	call	rand@PLT
	vxorps	%xmm5, %xmm5, %xmm5
	movq	-112(%rbp), %rdi
	vcvtsi2ssl	%eax, %xmm5, %xmm0
	vmulss	.LC2(%rip), %xmm0, %xmm3
	vmovss	%xmm3, (%rdi,%r14,4)
	call	rand@PLT
	vxorps	%xmm1, %xmm1, %xmm1
	movq	-104(%rbp), %r8
	vcvtsi2ssl	%eax, %xmm1, %xmm2
	vmulss	.LC2(%rip), %xmm2, %xmm4
	vmovss	%xmm4, (%r8,%r14,4)
	leaq	3(%r13), %r14
	addq	$4, %r13
	call	rand@PLT
	vxorps	%xmm6, %xmm6, %xmm6
	movq	-112(%rbp), %r9
	vcvtsi2ssl	%eax, %xmm6, %xmm7
	vmulss	.LC2(%rip), %xmm7, %xmm8
	vmovss	%xmm8, (%r9,%r14,4)
	call	rand@PLT
	vxorps	%xmm9, %xmm9, %xmm9
	movq	-104(%rbp), %r10
	cmpq	%r13, %rbx
	vcvtsi2ssl	%eax, %xmm9, %xmm10
	vmulss	.LC2(%rip), %xmm10, %xmm11
	vmovss	%xmm11, (%r10,%r14,4)
	jne	.L112
.L365:
	cmpq	$2, %r14
	movq	-112(%rbp), %r11
	jbe	.L373
	leaq	4(%r11), %rax
	movq	%r10, %rdx
	xorl	%edi, %edi
	subq	%rax, %rdx
	cmpq	$24, %rdx
	ja	.L374
.L115:
	leaq	1(%r14), %rdx
	vmovss	.LC5(%rip), %xmm3
	andl	$7, %edx
	je	.L121
	cmpq	$1, %rdx
	je	.L286
	cmpq	$2, %rdx
	je	.L287
	cmpq	$3, %rdx
	je	.L288
	cmpq	$4, %rdx
	je	.L289
	cmpq	$5, %rdx
	je	.L290
	cmpq	$6, %rdx
	jne	.L375
.L291:
	vmovss	(%r11,%rdi,4), %xmm2
	vfmadd213ss	(%r10,%rdi,4), %xmm3, %xmm2
	vmovss	%xmm2, (%r10,%rdi,4)
	addq	$1, %rdi
.L290:
	vmovss	(%r11,%rdi,4), %xmm4
	vfmadd213ss	(%r10,%rdi,4), %xmm3, %xmm4
	vmovss	%xmm4, (%r10,%rdi,4)
	addq	$1, %rdi
.L289:
	vmovss	(%r11,%rdi,4), %xmm6
	vfmadd213ss	(%r10,%rdi,4), %xmm3, %xmm6
	vmovss	%xmm6, (%r10,%rdi,4)
	addq	$1, %rdi
.L288:
	vmovss	(%r11,%rdi,4), %xmm7
	vfmadd213ss	(%r10,%rdi,4), %xmm3, %xmm7
	vmovss	%xmm7, (%r10,%rdi,4)
	addq	$1, %rdi
.L287:
	vmovss	(%r11,%rdi,4), %xmm8
	vfmadd213ss	(%r10,%rdi,4), %xmm3, %xmm8
	vmovss	%xmm8, (%r10,%rdi,4)
	addq	$1, %rdi
.L286:
	vmovss	(%r11,%rdi,4), %xmm9
	vfmadd213ss	(%r10,%rdi,4), %xmm3, %xmm9
	movq	%rdi, %rcx
	vmovss	%xmm9, (%r10,%rdi,4)
	addq	$1, %rdi
	cmpq	%rcx, %r14
	je	.L363
.L121:
	vmovss	(%r11,%rdi,4), %xmm10
	vfmadd213ss	(%r10,%rdi,4), %xmm3, %xmm10
	leaq	7(%rdi), %rsi
	vmovss	%xmm10, (%r10,%rdi,4)
	vmovss	4(%r11,%rdi,4), %xmm11
	vfmadd213ss	4(%r10,%rdi,4), %xmm3, %xmm11
	vmovss	%xmm11, 4(%r10,%rdi,4)
	vmovss	8(%r11,%rdi,4), %xmm12
	vfmadd213ss	8(%r10,%rdi,4), %xmm3, %xmm12
	vmovss	%xmm12, 8(%r10,%rdi,4)
	vmovss	12(%r11,%rdi,4), %xmm13
	vfmadd213ss	12(%r10,%rdi,4), %xmm3, %xmm13
	vmovss	%xmm13, 12(%r10,%rdi,4)
	vmovss	16(%r11,%rdi,4), %xmm14
	vfmadd213ss	16(%r10,%rdi,4), %xmm3, %xmm14
	vmovss	%xmm14, 16(%r10,%rdi,4)
	vmovss	20(%r11,%rdi,4), %xmm15
	vfmadd213ss	20(%r10,%rdi,4), %xmm3, %xmm15
	vmovss	%xmm15, 20(%r10,%rdi,4)
	vmovss	24(%r11,%rdi,4), %xmm5
	vfmadd213ss	24(%r10,%rdi,4), %xmm3, %xmm5
	vmovss	%xmm5, 24(%r10,%rdi,4)
	vmovss	28(%r11,%rdi,4), %xmm0
	vfmadd213ss	28(%r10,%rdi,4), %xmm3, %xmm0
	addq	$8, %rdi
	cmpq	%rsi, %r14
	vmovss	%xmm0, (%r10,%rsi,4)
	jne	.L121
.L363:
	leaq	-96(%rbp), %rsi
	movl	$1, %edi
	vmovss	%xmm3, -116(%rbp)
	call	clock_gettime@PLT
	cmpq	$2, %r14
	movq	-104(%rbp), %r11
	movq	-112(%rbp), %r8
	vmovss	-116(%rbp), %xmm3
	ja	.L123
.L124:
	leaq	1(%r14), %rdx
	xorl	%edi, %edi
	andl	$7, %edx
	je	.L130
	cmpq	$1, %rdx
	je	.L298
	cmpq	$2, %rdx
	je	.L299
	cmpq	$3, %rdx
	je	.L300
	cmpq	$4, %rdx
	je	.L301
	cmpq	$5, %rdx
	je	.L302
	cmpq	$6, %rdx
	jne	.L376
.L303:
	vmovss	(%r8,%rdi,4), %xmm10
	vfmadd213ss	(%r11,%rdi,4), %xmm3, %xmm10
	vmovss	%xmm10, (%r11,%rdi,4)
	addq	$1, %rdi
.L302:
	vmovss	(%r8,%rdi,4), %xmm11
	vfmadd213ss	(%r11,%rdi,4), %xmm3, %xmm11
	vmovss	%xmm11, (%r11,%rdi,4)
	addq	$1, %rdi
.L301:
	vmovss	(%r8,%rdi,4), %xmm12
	vfmadd213ss	(%r11,%rdi,4), %xmm3, %xmm12
	vmovss	%xmm12, (%r11,%rdi,4)
	addq	$1, %rdi
.L300:
	vmovss	(%r8,%rdi,4), %xmm13
	vfmadd213ss	(%r11,%rdi,4), %xmm3, %xmm13
	vmovss	%xmm13, (%r11,%rdi,4)
	addq	$1, %rdi
.L299:
	vmovss	(%r8,%rdi,4), %xmm14
	vfmadd213ss	(%r11,%rdi,4), %xmm3, %xmm14
	vmovss	%xmm14, (%r11,%rdi,4)
	addq	$1, %rdi
.L298:
	vmovss	(%r8,%rdi,4), %xmm15
	vfmadd213ss	(%r11,%rdi,4), %xmm3, %xmm15
	movq	%rdi, %rsi
	vmovss	%xmm15, (%r11,%rdi,4)
	addq	$1, %rdi
	cmpq	%rsi, %r14
	je	.L131
.L130:
	vmovss	(%r8,%rdi,4), %xmm5
	vfmadd213ss	(%r11,%rdi,4), %xmm3, %xmm5
	leaq	7(%rdi), %r9
	vmovss	%xmm5, (%r11,%rdi,4)
	vmovss	4(%r8,%rdi,4), %xmm0
	vfmadd213ss	4(%r11,%rdi,4), %xmm3, %xmm0
	vmovss	%xmm0, 4(%r11,%rdi,4)
	vmovss	8(%r8,%rdi,4), %xmm2
	vfmadd213ss	8(%r11,%rdi,4), %xmm3, %xmm2
	vmovss	%xmm2, 8(%r11,%rdi,4)
	vmovss	12(%r8,%rdi,4), %xmm1
	vfmadd213ss	12(%r11,%rdi,4), %xmm3, %xmm1
	vmovss	%xmm1, 12(%r11,%rdi,4)
	vmovss	16(%r8,%rdi,4), %xmm4
	vfmadd213ss	16(%r11,%rdi,4), %xmm3, %xmm4
	vmovss	%xmm4, 16(%r11,%rdi,4)
	vmovss	20(%r8,%rdi,4), %xmm6
	vfmadd213ss	20(%r11,%rdi,4), %xmm3, %xmm6
	vmovss	%xmm6, 20(%r11,%rdi,4)
	vmovss	24(%r8,%rdi,4), %xmm7
	vfmadd213ss	24(%r11,%rdi,4), %xmm3, %xmm7
	vmovss	%xmm7, 24(%r11,%rdi,4)
	vmovss	28(%r8,%rdi,4), %xmm8
	vfmadd213ss	28(%r11,%rdi,4), %xmm3, %xmm8
	addq	$8, %rdi
	cmpq	%r9, %r14
	vmovss	%xmm8, (%r11,%r9,4)
	jne	.L130
	.p2align 4,,10
	.p2align 3
.L131:
	leaq	-80(%rbp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	vxorpd	%xmm9, %xmm9, %xmm9
	movq	-72(%rbp), %r11
	movq	-80(%rbp), %r8
	subq	-88(%rbp), %r11
	subq	-96(%rbp), %r8
	leaq	-1(%rbx), %r10
	vcvtsi2sdq	%r11, %xmm9, %xmm3
	cmpq	$6, %r10
	movq	-104(%rbp), %r14
	vcvtsi2sdq	%r8, %xmm9, %xmm10
	vfmadd132sd	.LC3(%rip), %xmm10, %xmm3
	vcvtsi2sdq	%rbx, %xmm9, %xmm11
	vmulsd	.LC7(%rip), %xmm11, %xmm12
	vdivsd	%xmm3, %xmm12, %xmm1
	jbe	.L144
	movq	%rbx, %rcx
	movq	%r14, %rax
	vxorpd	%xmm0, %xmm0, %xmm0
	shrq	$3, %rcx
	salq	$5, %rcx
	leaq	(%rcx,%r14), %r13
	subq	$32, %rcx
	shrq	$5, %rcx
	addq	$1, %rcx
	andl	$7, %ecx
	je	.L133
	cmpq	$1, %rcx
	je	.L304
	cmpq	$2, %rcx
	je	.L305
	cmpq	$3, %rcx
	je	.L306
	cmpq	$4, %rcx
	je	.L307
	cmpq	$5, %rcx
	je	.L308
	cmpq	$6, %rcx
	jne	.L377
.L309:
	vmovups	(%rax), %ymm4
	addq	$32, %rax
	vextractf128	$0x1, %ymm4, %xmm2
	vcvtps2pd	%xmm4, %ymm7
	vcvtps2pd	%xmm2, %ymm6
	vaddpd	%ymm7, %ymm6, %ymm8
	vaddpd	%ymm8, %ymm0, %ymm0
.L308:
	vmovups	(%rax), %ymm9
	addq	$32, %rax
	vextractf128	$0x1, %ymm9, %xmm10
	vcvtps2pd	%xmm9, %ymm12
	vcvtps2pd	%xmm10, %ymm11
	vaddpd	%ymm12, %ymm11, %ymm13
	vaddpd	%ymm13, %ymm0, %ymm0
.L307:
	vmovups	(%rax), %ymm14
	addq	$32, %rax
	vextractf128	$0x1, %ymm14, %xmm15
	vcvtps2pd	%xmm14, %ymm4
	vcvtps2pd	%xmm15, %ymm5
	vaddpd	%ymm4, %ymm5, %ymm2
	vaddpd	%ymm2, %ymm0, %ymm0
.L306:
	vmovups	(%rax), %ymm6
	addq	$32, %rax
	vextractf128	$0x1, %ymm6, %xmm7
	vcvtps2pd	%xmm6, %ymm9
	vcvtps2pd	%xmm7, %ymm8
	vaddpd	%ymm9, %ymm8, %ymm10
	vaddpd	%ymm10, %ymm0, %ymm0
.L305:
	vmovups	(%rax), %ymm11
	addq	$32, %rax
	vextractf128	$0x1, %ymm11, %xmm12
	vcvtps2pd	%xmm11, %ymm14
	vcvtps2pd	%xmm12, %ymm13
	vaddpd	%ymm14, %ymm13, %ymm15
	vaddpd	%ymm15, %ymm0, %ymm0
.L304:
	vmovups	(%rax), %ymm5
	addq	$32, %rax
	cmpq	%rax, %r13
	vextractf128	$0x1, %ymm5, %xmm4
	vcvtps2pd	%xmm5, %ymm6
	vcvtps2pd	%xmm4, %ymm2
	vaddpd	%ymm6, %ymm2, %ymm7
	vaddpd	%ymm7, %ymm0, %ymm0
	je	.L361
.L133:
	vmovups	(%rax), %ymm8
	vmovups	32(%rax), %ymm14
	addq	$256, %rax
	vmovups	-192(%rax), %ymm7
	vextractf128	$0x1, %ymm8, %xmm9
	vcvtps2pd	%xmm8, %ymm11
	vextractf128	$0x1, %ymm14, %xmm15
	vcvtps2pd	%xmm14, %ymm4
	vcvtps2pd	%xmm9, %ymm10
	vaddpd	%ymm11, %ymm10, %ymm12
	vcvtps2pd	%xmm15, %ymm5
	vaddpd	%ymm4, %ymm5, %ymm2
	vcvtps2pd	%xmm7, %ymm9
	vmovups	-128(%rax), %ymm4
	vaddpd	%ymm12, %ymm0, %ymm13
	vextractf128	$0x1, %ymm7, %xmm0
	vmovups	-160(%rax), %ymm12
	vcvtps2pd	%xmm0, %ymm8
	vaddpd	%ymm9, %ymm8, %ymm10
	vcvtps2pd	%xmm4, %ymm0
	vcvtps2pd	%xmm12, %ymm15
	vaddpd	%ymm2, %ymm13, %ymm6
	vextractf128	$0x1, %ymm12, %xmm13
	vcvtps2pd	%xmm13, %ymm14
	vaddpd	%ymm15, %ymm14, %ymm5
	vaddpd	%ymm10, %ymm6, %ymm11
	vextractf128	$0x1, %ymm4, %xmm6
	vmovups	-96(%rax), %ymm10
	vcvtps2pd	%xmm6, %ymm7
	vaddpd	%ymm0, %ymm7, %ymm8
	vcvtps2pd	%xmm10, %ymm13
	vaddpd	%ymm5, %ymm11, %ymm2
	vextractf128	$0x1, %ymm10, %xmm11
	vmovups	-64(%rax), %ymm5
	vcvtps2pd	%xmm11, %ymm12
	vaddpd	%ymm13, %ymm12, %ymm14
	vcvtps2pd	%xmm5, %ymm4
	vaddpd	%ymm8, %ymm2, %ymm9
	vextractf128	$0x1, %ymm5, %xmm2
	vcvtps2pd	%xmm2, %ymm6
	vaddpd	%ymm4, %ymm6, %ymm7
	vaddpd	%ymm14, %ymm9, %ymm15
	vmovups	-32(%rax), %ymm9
	cmpq	%rax, %r13
	vextractf128	$0x1, %ymm9, %xmm0
	vcvtps2pd	%xmm9, %ymm11
	vcvtps2pd	%xmm0, %ymm10
	vaddpd	%ymm7, %ymm15, %ymm8
	vaddpd	%ymm11, %ymm10, %ymm12
	vaddpd	%ymm12, %ymm8, %ymm0
	jne	.L133
.L361:
	vextractf128	$0x1, %ymm0, %xmm13
	movq	%rbx, %rdi
	vaddpd	%xmm0, %xmm13, %xmm14
	andq	$-8, %rdi
	vaddpd	%xmm13, %xmm0, %xmm6
	testb	$7, %bl
	vunpckhpd	%xmm14, %xmm14, %xmm15
	vaddpd	%xmm14, %xmm15, %xmm2
	je	.L378
	vzeroupper
.L132:
	movq	%rbx, %rdx
	subq	%rdi, %rdx
	leaq	-1(%rdx), %rsi
	cmpq	$2, %rsi
	jbe	.L136
	vmovups	(%r14,%rdi,4), %xmm5
	vxorps	%xmm2, %xmm2, %xmm2
	movq	%rdx, %r9
	andq	$-4, %r9
	vmovhlps	%xmm5, %xmm2, %xmm7
	vcvtps2pd	%xmm5, %xmm4
	addq	%r9, %rdi
	andl	$3, %edx
	vcvtps2pd	%xmm7, %xmm8
	vaddpd	%xmm8, %xmm4, %xmm9
	vaddpd	%xmm6, %xmm9, %xmm0
	vunpckhpd	%xmm0, %xmm0, %xmm10
	vaddpd	%xmm0, %xmm10, %xmm2
	je	.L114
.L136:
	leaq	1(%rdi), %r8
	vxorpd	%xmm11, %xmm11, %xmm11
	leaq	0(,%rdi,4), %r11
	cmpq	%rbx, %r8
	vcvtss2sd	(%r14,%rdi,4), %xmm11, %xmm12
	vaddsd	%xmm12, %xmm2, %xmm2
	jnb	.L114
	addq	$2, %rdi
	vcvtss2sd	4(%r14,%r11), %xmm11, %xmm13
	vaddsd	%xmm13, %xmm2, %xmm2
	cmpq	%rbx, %rdi
	jnb	.L114
	vcvtss2sd	8(%r14,%r11), %xmm11, %xmm14
	vaddsd	%xmm14, %xmm2, %xmm2
.L114:
	vmovsd	%xmm3, %xmm3, %xmm0
	movq	%rbx, %rdx
	movl	$2, %edi
	movl	$3, %eax
	leaq	.LC8(%rip), %rsi
	call	__printf_chk@PLT
	movq	-112(%rbp), %rdi
	call	free@PLT
	movq	-104(%rbp), %rdi
	call	free@PLT
.L106:
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L379
	addq	$104, %rsp
	movl	%r12d, %eax
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L374:
	.cfi_restore_state
	cmpq	$6, %r14
	jbe	.L142
	vbroadcastss	.LC5(%rip), %ymm12
	movq	%rbx, %rcx
	shrq	$3, %rcx
	salq	$5, %rcx
	leaq	-32(%rcx), %rsi
	shrq	$5, %rsi
	addq	$1, %rsi
	andl	$7, %esi
	je	.L117
	cmpq	$1, %rsi
	je	.L280
	cmpq	$2, %rsi
	je	.L281
	cmpq	$3, %rsi
	je	.L282
	cmpq	$4, %rsi
	je	.L283
	cmpq	$5, %rsi
	je	.L284
	cmpq	$6, %rsi
	jne	.L380
.L285:
	vmovups	(%r11,%rdi), %ymm14
	vfmadd213ps	(%r10,%rdi), %ymm12, %ymm14
	vmovups	%ymm14, (%r10,%rdi)
	addq	$32, %rdi
.L284:
	vmovups	(%r11,%rdi), %ymm15
	vfmadd213ps	(%r10,%rdi), %ymm12, %ymm15
	vmovups	%ymm15, (%r10,%rdi)
	addq	$32, %rdi
.L283:
	vmovups	(%r11,%rdi), %ymm5
	vfmadd213ps	(%r10,%rdi), %ymm12, %ymm5
	vmovups	%ymm5, (%r10,%rdi)
	addq	$32, %rdi
.L282:
	vmovups	(%r11,%rdi), %ymm0
	vfmadd213ps	(%r10,%rdi), %ymm12, %ymm0
	vmovups	%ymm0, (%r10,%rdi)
	addq	$32, %rdi
.L281:
	vmovups	(%r11,%rdi), %ymm3
	vfmadd213ps	(%r10,%rdi), %ymm12, %ymm3
	vmovups	%ymm3, (%r10,%rdi)
	addq	$32, %rdi
.L280:
	vmovups	(%r11,%rdi), %ymm1
	vfmadd213ps	(%r10,%rdi), %ymm12, %ymm1
	vmovups	%ymm1, (%r10,%rdi)
	addq	$32, %rdi
	cmpq	%rcx, %rdi
	je	.L364
.L117:
	vmovups	(%r11,%rdi), %ymm2
	vfmadd213ps	(%r10,%rdi), %ymm12, %ymm2
	vmovups	%ymm2, (%r10,%rdi)
	vmovups	32(%r11,%rdi), %ymm4
	vfmadd213ps	32(%r10,%rdi), %ymm12, %ymm4
	vmovups	%ymm4, 32(%r10,%rdi)
	vmovups	64(%r11,%rdi), %ymm6
	vfmadd213ps	64(%r10,%rdi), %ymm12, %ymm6
	vmovups	%ymm6, 64(%r10,%rdi)
	vmovups	96(%r11,%rdi), %ymm7
	vfmadd213ps	96(%r10,%rdi), %ymm12, %ymm7
	vmovups	%ymm7, 96(%r10,%rdi)
	vmovups	128(%r11,%rdi), %ymm8
	vfmadd213ps	128(%r10,%rdi), %ymm12, %ymm8
	vmovups	%ymm8, 128(%r10,%rdi)
	vmovups	160(%r11,%rdi), %ymm9
	vfmadd213ps	160(%r10,%rdi), %ymm12, %ymm9
	vmovups	%ymm9, 160(%r10,%rdi)
	vmovups	192(%r11,%rdi), %ymm10
	vfmadd213ps	192(%r10,%rdi), %ymm12, %ymm10
	vmovups	%ymm10, 192(%r10,%rdi)
	vmovups	224(%r11,%rdi), %ymm11
	vfmadd213ps	224(%r10,%rdi), %ymm12, %ymm11
	vmovups	%ymm11, 224(%r10,%rdi)
	addq	$256, %rdi
	cmpq	%rcx, %rdi
	jne	.L117
.L364:
	movq	%r13, %r8
	andq	$-8, %r8
	testb	$7, %r13b
	je	.L366
	movq	%r13, %r9
	subq	%r8, %r9
	leaq	-1(%r9), %rax
	cmpq	$2, %rax
	jbe	.L381
	vzeroupper
.L116:
	vbroadcastss	.LC5(%rip), %xmm12
	leaq	(%r10,%r8,4), %rdx
	movq	%r9, %rcx
	vmovups	(%rdx), %xmm13
	vfmadd132ps	(%r11,%r8,4), %xmm13, %xmm12
	andq	$-4, %rcx
	addq	%rcx, %r8
	andb	$3, %r9b
	vmovups	%xmm12, (%rdx)
	je	.L118
.L119:
	leaq	0(,%r8,4), %rsi
	vmovss	(%r11,%r8,4), %xmm15
	vmovss	.LC5(%rip), %xmm14
	leaq	1(%r8), %r9
	leaq	(%r10,%rsi), %rdi
	cmpq	%r13, %r9
	vfmadd213ss	(%rdi), %xmm14, %xmm15
	vmovss	%xmm15, (%rdi)
	jnb	.L118
	leaq	4(%r10,%rsi), %rax
	vmovss	4(%r11,%rsi), %xmm5
	addq	$2, %r8
	vfmadd213ss	(%rax), %xmm14, %xmm5
	cmpq	%r13, %r8
	vmovss	%xmm5, (%rax)
	jnb	.L118
	leaq	8(%r10,%rsi), %r10
	vmovss	(%r10), %xmm0
	vfmadd132ss	8(%r11,%rsi), %xmm0, %xmm14
	vmovss	%xmm14, (%r10)
.L118:
	leaq	-96(%rbp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-104(%rbp), %r11
	movq	-112(%rbp), %r8
.L123:
	leaq	4(%r8), %rdi
	movq	%r11, %r9
	vmovss	.LC5(%rip), %xmm3
	subq	%rdi, %r9
	cmpq	$24, %r9
	jbe	.L124
	cmpq	$6, %r14
	jbe	.L143
	movq	%r13, %r14
	xorl	%eax, %eax
	vbroadcastss	%xmm3, %ymm2
	shrq	$3, %r14
	salq	$5, %r14
	leaq	-32(%r14), %r10
	shrq	$5, %r10
	addq	$1, %r10
	andl	$7, %r10d
	je	.L126
	cmpq	$1, %r10
	je	.L292
	cmpq	$2, %r10
	je	.L293
	cmpq	$3, %r10
	je	.L294
	cmpq	$4, %r10
	je	.L295
	cmpq	$5, %r10
	je	.L296
	cmpq	$6, %r10
	jne	.L382
.L297:
	vmovups	(%r8,%rax), %ymm4
	vfmadd213ps	(%r11,%rax), %ymm2, %ymm4
	vmovups	%ymm4, (%r11,%rax)
	addq	$32, %rax
.L296:
	vmovups	(%r8,%rax), %ymm6
	vfmadd213ps	(%r11,%rax), %ymm2, %ymm6
	vmovups	%ymm6, (%r11,%rax)
	addq	$32, %rax
.L295:
	vmovups	(%r8,%rax), %ymm7
	vfmadd213ps	(%r11,%rax), %ymm2, %ymm7
	vmovups	%ymm7, (%r11,%rax)
	addq	$32, %rax
.L294:
	vmovups	(%r8,%rax), %ymm8
	vfmadd213ps	(%r11,%rax), %ymm2, %ymm8
	vmovups	%ymm8, (%r11,%rax)
	addq	$32, %rax
.L293:
	vmovups	(%r8,%rax), %ymm9
	vfmadd213ps	(%r11,%rax), %ymm2, %ymm9
	vmovups	%ymm9, (%r11,%rax)
	addq	$32, %rax
.L292:
	vmovups	(%r8,%rax), %ymm10
	vfmadd213ps	(%r11,%rax), %ymm2, %ymm10
	vmovups	%ymm10, (%r11,%rax)
	addq	$32, %rax
	cmpq	%rax, %r14
	je	.L362
.L126:
	vmovups	(%r8,%rax), %ymm11
	vfmadd213ps	(%r11,%rax), %ymm2, %ymm11
	vmovups	%ymm11, (%r11,%rax)
	vmovups	32(%r8,%rax), %ymm12
	vfmadd213ps	32(%r11,%rax), %ymm2, %ymm12
	vmovups	%ymm12, 32(%r11,%rax)
	vmovups	64(%r8,%rax), %ymm13
	vfmadd213ps	64(%r11,%rax), %ymm2, %ymm13
	vmovups	%ymm13, 64(%r11,%rax)
	vmovups	96(%r8,%rax), %ymm14
	vfmadd213ps	96(%r11,%rax), %ymm2, %ymm14
	vmovups	%ymm14, 96(%r11,%rax)
	vmovups	128(%r8,%rax), %ymm15
	vfmadd213ps	128(%r11,%rax), %ymm2, %ymm15
	vmovups	%ymm15, 128(%r11,%rax)
	vmovups	160(%r8,%rax), %ymm5
	vfmadd213ps	160(%r11,%rax), %ymm2, %ymm5
	vmovups	%ymm5, 160(%r11,%rax)
	vmovups	192(%r8,%rax), %ymm0
	vfmadd213ps	192(%r11,%rax), %ymm2, %ymm0
	vmovups	%ymm0, 192(%r11,%rax)
	vmovups	224(%r8,%rax), %ymm3
	vfmadd213ps	224(%r11,%rax), %ymm2, %ymm3
	vmovups	%ymm3, 224(%r11,%rax)
	addq	$256, %rax
	cmpq	%rax, %r14
	jne	.L126
.L362:
	movq	%r13, %rdx
	andq	$-8, %rdx
	testb	$7, %r13b
	je	.L368
	movq	%r13, %rcx
	subq	%rdx, %rcx
	leaq	-1(%rcx), %rsi
	cmpq	$2, %rsi
	jbe	.L383
	vzeroupper
.L125:
	vbroadcastss	.LC5(%rip), %xmm2
	leaq	(%r11,%rdx,4), %rdi
	movq	%rcx, %r9
	vmovups	(%rdi), %xmm1
	vfmadd132ps	(%r8,%rdx,4), %xmm1, %xmm2
	andq	$-4, %r9
	addq	%r9, %rdx
	andb	$3, %cl
	vmovups	%xmm2, (%rdi)
	je	.L131
.L128:
	leaq	0(,%rdx,4), %r14
	vmovss	(%r8,%rdx,4), %xmm6
	vmovss	.LC5(%rip), %xmm4
	leaq	1(%rdx), %rax
	leaq	(%r11,%r14), %r10
	cmpq	%r13, %rax
	vfmadd213ss	(%r10), %xmm4, %xmm6
	vmovss	%xmm6, (%r10)
	jnb	.L131
	leaq	4(%r11,%r14), %rcx
	vmovss	4(%r8,%r14), %xmm7
	addq	$2, %rdx
	vfmadd213ss	(%rcx), %xmm4, %xmm7
	cmpq	%r13, %rdx
	vmovss	%xmm7, (%rcx)
	jnb	.L131
	leaq	8(%r11,%r14), %r13
	vmovss	0(%r13), %xmm8
	vfmadd132ss	8(%r8,%r14), %xmm8, %xmm4
	vmovss	%xmm4, 0(%r13)
	jmp	.L131
.L373:
	xorl	%edi, %edi
	jmp	.L115
.L375:
	vmovss	(%r11), %xmm1
	vfmadd213ss	(%r10), %xmm3, %xmm1
	movl	$1, %edi
	vmovss	%xmm1, (%r10)
	jmp	.L291
.L376:
	vmovss	(%r8), %xmm9
	vfmadd213ss	(%r11), %xmm3, %xmm9
	movl	$1, %edi
	vmovss	%xmm9, (%r11)
	jmp	.L303
.L377:
	vmovups	(%r14), %ymm13
	leaq	32(%r14), %rax
	vextractf128	$0x1, %ymm13, %xmm14
	vcvtps2pd	%xmm13, %ymm5
	vcvtps2pd	%xmm14, %ymm15
	vaddpd	%ymm5, %ymm15, %ymm0
	jmp	.L309
.L111:
	leaq	-96(%rbp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	leaq	-80(%rbp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	vxorpd	%xmm5, %xmm5, %xmm5
	movq	-72(%rbp), %rax
	movq	-80(%rbp), %rdx
	subq	-88(%rbp), %rax
	subq	-96(%rbp), %rdx
	vxorpd	%xmm1, %xmm1, %xmm1
	vcvtsi2sdq	%rax, %xmm5, %xmm3
	vmovsd	%xmm1, %xmm1, %xmm2
	vcvtsi2sdq	%rdx, %xmm5, %xmm0
	vfmadd132sd	.LC3(%rip), %xmm0, %xmm3
	jmp	.L114
.L378:
	vzeroupper
	jmp	.L114
.L144:
	vxorpd	%xmm6, %xmm6, %xmm6
	xorl	%edi, %edi
	vxorpd	%xmm2, %xmm2, %xmm2
	jmp	.L132
.L380:
	vmovups	(%r11), %ymm13
	vfmadd213ps	(%r10), %ymm12, %ymm13
	movl	$32, %edi
	vmovups	%ymm13, (%r10)
	jmp	.L285
.L382:
	vmovups	(%r8), %ymm1
	vfmadd213ps	(%r11), %ymm2, %ymm1
	movl	$32, %eax
	vmovups	%ymm1, (%r11)
	jmp	.L297
.L368:
	vzeroupper
	jmp	.L131
.L366:
	vzeroupper
	jmp	.L118
.L143:
	movq	%r13, %rcx
	xorl	%edx, %edx
	jmp	.L125
.L142:
	movq	%rbx, %r9
	xorl	%r8d, %r8d
	jmp	.L116
.L383:
	vzeroupper
	jmp	.L128
.L381:
	vzeroupper
	jmp	.L119
.L379:
	call	__stack_chk_fail@PLT
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB27:
.L110:
	.cfi_escape 0xf,0x3,0x76,0x60,0x6
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	.cfi_escape 0x10,0x6,0x2,0x76,0
	.cfi_escape 0x10,0xc,0x2,0x76,0x68
	.cfi_escape 0x10,0xd,0x2,0x76,0x70
	.cfi_escape 0x10,0xe,0x2,0x76,0x78
	leaq	.LC1(%rip), %rdi
	movl	$1, %r12d
	call	perror@PLT
	jmp	.L106
	.cfi_endproc
.LFE27:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE9:
	.section	.text.startup
.LHOTE9:
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC2:
	.long	805306368
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.long	-400107883
	.long	1041313291
	.section	.rodata.cst4
	.align 4
.LC5:
	.long	1075838976
	.section	.rodata.cst8
	.align 8
.LC7:
	.long	-400107883
	.long	1042361867
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
