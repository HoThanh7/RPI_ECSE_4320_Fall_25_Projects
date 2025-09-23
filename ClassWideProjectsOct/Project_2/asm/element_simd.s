	.file	"element.c"
	.text
	.p2align 4
	.globl	element_scalar
	.type	element_scalar, @function
element_scalar:
.LFB12:
	.cfi_startproc
	testq	%rcx, %rcx
	je	.L111
	leaq	-1(%rcx), %r8
	cmpq	$6, %r8
	jbe	.L12
	leaq	-4(%rdi), %rax
	movq	%rax, %r9
	subq	%rsi, %r9
	cmpq	$56, %r9
	jbe	.L12
	subq	%rdx, %rax
	cmpq	$56, %rax
	jbe	.L12
	cmpq	$14, %r8
	jbe	.L13
	movq	%rcx, %r9
	xorl	%eax, %eax
	shrq	$4, %r9
	salq	$6, %r9
	leaq	-64(%r9), %r8
	shrq	$6, %r8
	incq	%r8
	andl	$7, %r8d
	je	.L5
	cmpq	$1, %r8
	je	.L68
	cmpq	$2, %r8
	je	.L69
	cmpq	$3, %r8
	je	.L70
	cmpq	$4, %r8
	je	.L71
	cmpq	$5, %r8
	je	.L72
	cmpq	$6, %r8
	je	.L73
	vmovups	(%rdx), %zmm0
	vmulps	(%rsi), %zmm0, %zmm1
	movl	$64, %eax
	vmovups	%zmm1, (%rdi)
.L73:
	vmovups	(%rdx,%rax), %zmm2
	vmulps	(%rsi,%rax), %zmm2, %zmm3
	vmovups	%zmm3, (%rdi,%rax)
	addq	$64, %rax
.L72:
	vmovups	(%rdx,%rax), %zmm4
	vmulps	(%rsi,%rax), %zmm4, %zmm5
	vmovups	%zmm5, (%rdi,%rax)
	addq	$64, %rax
.L71:
	vmovups	(%rdx,%rax), %zmm6
	vmulps	(%rsi,%rax), %zmm6, %zmm7
	vmovups	%zmm7, (%rdi,%rax)
	addq	$64, %rax
.L70:
	vmovups	(%rdx,%rax), %zmm8
	vmulps	(%rsi,%rax), %zmm8, %zmm9
	vmovups	%zmm9, (%rdi,%rax)
	addq	$64, %rax
.L69:
	vmovups	(%rdx,%rax), %zmm10
	vmulps	(%rsi,%rax), %zmm10, %zmm11
	vmovups	%zmm11, (%rdi,%rax)
	addq	$64, %rax
.L68:
	vmovups	(%rdx,%rax), %zmm12
	vmulps	(%rsi,%rax), %zmm12, %zmm13
	vmovups	%zmm13, (%rdi,%rax)
	addq	$64, %rax
	cmpq	%r9, %rax
	je	.L102
.L5:
	vmovups	(%rdx,%rax), %zmm14
	vmulps	(%rsi,%rax), %zmm14, %zmm15
	vmovups	%zmm15, (%rdi,%rax)
	vmovups	64(%rdx,%rax), %zmm0
	vmulps	64(%rsi,%rax), %zmm0, %zmm1
	vmovups	%zmm1, 64(%rdi,%rax)
	vmovups	128(%rdx,%rax), %zmm2
	vmulps	128(%rsi,%rax), %zmm2, %zmm3
	vmovups	%zmm3, 128(%rdi,%rax)
	vmovups	192(%rdx,%rax), %zmm4
	vmulps	192(%rsi,%rax), %zmm4, %zmm5
	vmovups	%zmm5, 192(%rdi,%rax)
	vmovups	256(%rdx,%rax), %zmm6
	vmulps	256(%rsi,%rax), %zmm6, %zmm7
	vmovups	%zmm7, 256(%rdi,%rax)
	vmovups	320(%rdx,%rax), %zmm8
	vmulps	320(%rsi,%rax), %zmm8, %zmm9
	vmovups	%zmm9, 320(%rdi,%rax)
	vmovups	384(%rdx,%rax), %zmm10
	vmulps	384(%rsi,%rax), %zmm10, %zmm11
	vmovups	%zmm11, 384(%rdi,%rax)
	vmovups	448(%rdx,%rax), %zmm12
	vmulps	448(%rsi,%rax), %zmm12, %zmm13
	vmovups	%zmm13, 448(%rdi,%rax)
	addq	$512, %rax
	cmpq	%r9, %rax
	jne	.L5
.L102:
	movq	%rcx, %r11
	andq	$-16, %r11
	testb	$15, %cl
	je	.L110
	movq	%rcx, %r10
	subq	%r11, %r10
	leaq	-1(%r10), %r9
	cmpq	$6, %r9
	jbe	.L7
.L4:
	leaq	0(,%r11,4), %r8
	movq	%r10, %rax
	vmovups	(%rdx,%r8), %ymm14
	vmulps	(%rsi,%r8), %ymm14, %ymm15
	andq	$-8, %rax
	addq	%rax, %r11
	andl	$7, %r10d
	vmovups	%ymm15, (%rdi,%r8)
	je	.L110
.L7:
	leaq	0(,%r11,4), %r10
	leaq	1(%r11), %r9
	vmovss	(%rsi,%r10), %xmm0
	vmulss	(%rdx,%r10), %xmm0, %xmm1
	vmovss	%xmm1, (%rdi,%r10)
	cmpq	%rcx, %r9
	jnb	.L110
	vmovss	4(%rsi,%r10), %xmm2
	vmulss	4(%rdx,%r10), %xmm2, %xmm3
	leaq	2(%r11), %r8
	vmovss	%xmm3, 4(%rdi,%r10)
	cmpq	%rcx, %r8
	jnb	.L110
	vmovss	8(%rsi,%r10), %xmm4
	vmulss	8(%rdx,%r10), %xmm4, %xmm5
	leaq	3(%r11), %rax
	vmovss	%xmm5, 8(%rdi,%r10)
	cmpq	%rcx, %rax
	jnb	.L110
	vmovss	12(%rsi,%r10), %xmm6
	vmulss	12(%rdx,%r10), %xmm6, %xmm7
	leaq	4(%r11), %r9
	vmovss	%xmm7, 12(%rdi,%r10)
	cmpq	%rcx, %r9
	jnb	.L110
	vmovss	16(%rsi,%r10), %xmm8
	vmulss	16(%rdx,%r10), %xmm8, %xmm9
	leaq	5(%r11), %r8
	vmovss	%xmm9, 16(%rdi,%r10)
	cmpq	%rcx, %r8
	jnb	.L110
	vmovss	20(%rsi,%r10), %xmm10
	vmulss	20(%rdx,%r10), %xmm10, %xmm11
	addq	$6, %r11
	vmovss	%xmm11, 20(%rdi,%r10)
	cmpq	%rcx, %r11
	jnb	.L110
	vmovss	24(%rsi,%r10), %xmm12
	vmulss	24(%rdx,%r10), %xmm12, %xmm13
	vmovss	%xmm13, 24(%rdi,%r10)
	vzeroupper
	ret
	.p2align 4
	.p2align 3
.L110:
	vzeroupper
.L111:
	ret
	.p2align 4
	.p2align 3
.L12:
	movq	%rcx, %r11
	xorl	%r10d, %r10d
	andl	$7, %r11d
	je	.L9
	cmpq	$1, %r11
	je	.L74
	cmpq	$2, %r11
	je	.L75
	cmpq	$3, %r11
	je	.L76
	cmpq	$4, %r11
	je	.L77
	cmpq	$5, %r11
	je	.L78
	cmpq	$6, %r11
	je	.L79
	vmovss	(%rsi), %xmm14
	vmulss	(%rdx), %xmm14, %xmm15
	movl	$1, %r10d
	vmovss	%xmm15, (%rdi)
.L79:
	vmovss	(%rsi,%r10,4), %xmm0
	vmulss	(%rdx,%r10,4), %xmm0, %xmm1
	vmovss	%xmm1, (%rdi,%r10,4)
	incq	%r10
.L78:
	vmovss	(%rsi,%r10,4), %xmm2
	vmulss	(%rdx,%r10,4), %xmm2, %xmm3
	vmovss	%xmm3, (%rdi,%r10,4)
	incq	%r10
.L77:
	vmovss	(%rsi,%r10,4), %xmm4
	vmulss	(%rdx,%r10,4), %xmm4, %xmm5
	vmovss	%xmm5, (%rdi,%r10,4)
	incq	%r10
.L76:
	vmovss	(%rsi,%r10,4), %xmm6
	vmulss	(%rdx,%r10,4), %xmm6, %xmm7
	vmovss	%xmm7, (%rdi,%r10,4)
	incq	%r10
.L75:
	vmovss	(%rsi,%r10,4), %xmm8
	vmulss	(%rdx,%r10,4), %xmm8, %xmm9
	vmovss	%xmm9, (%rdi,%r10,4)
	incq	%r10
.L74:
	vmovss	(%rsi,%r10,4), %xmm10
	vmulss	(%rdx,%r10,4), %xmm10, %xmm11
	vmovss	%xmm11, (%rdi,%r10,4)
	incq	%r10
	cmpq	%r10, %rcx
	je	.L113
.L9:
	vmovss	(%rsi,%r10,4), %xmm12
	vmulss	(%rdx,%r10,4), %xmm12, %xmm13
	leaq	1(%r10), %rax
	leaq	2(%r10), %r9
	leaq	3(%r10), %r8
	leaq	4(%r10), %r11
	vmovss	%xmm13, (%rdi,%r10,4)
	vmovss	(%rsi,%rax,4), %xmm14
	vmulss	(%rdx,%rax,4), %xmm14, %xmm15
	vmovss	%xmm15, (%rdi,%rax,4)
	vmovss	(%rsi,%r9,4), %xmm0
	vmulss	(%rdx,%r9,4), %xmm0, %xmm1
	leaq	5(%r10), %rax
	vmovss	%xmm1, (%rdi,%r9,4)
	vmovss	(%rsi,%r8,4), %xmm2
	vmulss	(%rdx,%r8,4), %xmm2, %xmm3
	leaq	6(%r10), %r9
	vmovss	%xmm3, (%rdi,%r8,4)
	vmovss	(%rsi,%r11,4), %xmm4
	vmulss	(%rdx,%r11,4), %xmm4, %xmm5
	leaq	7(%r10), %r8
	addq	$8, %r10
	vmovss	%xmm5, (%rdi,%r11,4)
	vmovss	(%rsi,%rax,4), %xmm6
	vmulss	(%rdx,%rax,4), %xmm6, %xmm7
	vmovss	%xmm7, (%rdi,%rax,4)
	vmovss	(%rsi,%r9,4), %xmm8
	vmulss	(%rdx,%r9,4), %xmm8, %xmm9
	vmovss	%xmm9, (%rdi,%r9,4)
	vmovss	(%rsi,%r8,4), %xmm10
	vmulss	(%rdx,%r8,4), %xmm10, %xmm11
	vmovss	%xmm11, (%rdi,%r8,4)
	cmpq	%r10, %rcx
	jne	.L9
	ret
.L13:
	movq	%rcx, %r10
	xorl	%r11d, %r11d
	jmp	.L4
.L113:
	ret
	.cfi_endproc
.LFE12:
	.size	element_scalar, .-element_scalar
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"posix_memalign failed"
.LC5:
	.string	"element,%zu,%.9f,%.6f,%.6e\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB6:
	.section	.text.startup,"ax",@progbits
.LHOTB6:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB14:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx
	movl	$10000000, %r12d
	addq	$-128, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L115
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtoull@PLT
	movq	%rax, %r12
.L115:
	leaq	0(,%r12,4), %rbx
	leaq	-104(%rbp), %rdi
	movl	$64, %esi
	movq	$0, -104(%rbp)
	movq	%rbx, %rdx
	movq	$0, -96(%rbp)
	movq	$0, -88(%rbp)
	call	posix_memalign@PLT
	testl	%eax, %eax
	jne	.L118
	leaq	-96(%rbp), %rdi
	movq	%rbx, %rdx
	movl	$64, %esi
	call	posix_memalign@PLT
	testl	%eax, %eax
	jne	.L118
	leaq	-88(%rbp), %rdi
	movq	%rbx, %rdx
	movl	$64, %esi
	call	posix_memalign@PLT
	movl	%eax, %r13d
	testl	%eax, %eax
	jne	.L118
	movl	$42, %edi
	call	srand@PLT
	testq	%r12, %r12
	je	.L119
	movq	%r12, %rax
	xorl	%ebx, %ebx
	andl	$3, %eax
	je	.L120
	cmpq	$1, %rax
	je	.L291
	cmpq	$2, %rax
	je	.L292
	call	rand@PLT
	vxorps	%xmm5, %xmm5, %xmm5
	movq	-104(%rbp), %rdx
	vcvtsi2ssl	%eax, %xmm5, %xmm6
	vmulss	.LC2(%rip), %xmm6, %xmm8
	vmovss	%xmm8, (%rdx,%rbx)
	call	rand@PLT
	vxorps	%xmm9, %xmm9, %xmm9
	movq	-96(%rbp), %rcx
	movq	-88(%rbp), %rsi
	vcvtsi2ssl	%eax, %xmm9, %xmm10
	vmulss	.LC2(%rip), %xmm10, %xmm11
	vmovss	%xmm11, (%rcx,%rbx)
	movl	$0x00000000, (%rsi,%rbx)
	movl	$1, %ebx
.L292:
	call	rand@PLT
	vxorps	%xmm12, %xmm12, %xmm12
	movq	-104(%rbp), %rdi
	leaq	0(,%rbx,4), %r15
	vcvtsi2ssl	%eax, %xmm12, %xmm13
	vmulss	.LC2(%rip), %xmm13, %xmm14
	incq	%rbx
	vmovss	%xmm14, (%rdi,%r15)
	call	rand@PLT
	vxorps	%xmm15, %xmm15, %xmm15
	movq	-96(%rbp), %r8
	movq	-88(%rbp), %r9
	vcvtsi2ssl	%eax, %xmm15, %xmm7
	vmulss	.LC2(%rip), %xmm7, %xmm0
	vmovss	%xmm0, (%r8,%r15)
	movl	$0x00000000, (%r9,%r15)
.L291:
	call	rand@PLT
	vxorps	%xmm4, %xmm4, %xmm4
	movq	-104(%rbp), %r11
	leaq	0(,%rbx,4), %r14
	vcvtsi2ssl	%eax, %xmm4, %xmm1
	vmulss	.LC2(%rip), %xmm1, %xmm2
	vmovss	%xmm2, (%r11,%r14)
	call	rand@PLT
	vxorps	%xmm3, %xmm3, %xmm3
	movq	-96(%rbp), %r10
	movq	-88(%rbp), %rdx
	vcvtsi2ssl	%eax, %xmm3, %xmm5
	vmulss	.LC2(%rip), %xmm5, %xmm6
	vmovss	%xmm6, (%r10,%r14)
	movl	$0x00000000, (%rdx,%r14)
	movq	%rbx, %r14
	incq	%rbx
	cmpq	%rbx, %r12
	je	.L382
.L120:
	call	rand@PLT
	vxorps	%xmm8, %xmm8, %xmm8
	leaq	0(,%rbx,4), %r15
	leaq	1(%rbx), %r14
	vcvtsi2ssl	%eax, %xmm8, %xmm9
	vmulss	.LC2(%rip), %xmm9, %xmm10
	movq	-104(%rbp), %rax
	salq	$2, %r14
	vmovss	%xmm10, (%rax,%r15)
	call	rand@PLT
	vxorps	%xmm11, %xmm11, %xmm11
	movq	-96(%rbp), %rcx
	movq	-88(%rbp), %rsi
	vcvtsi2ssl	%eax, %xmm11, %xmm12
	vmulss	.LC2(%rip), %xmm12, %xmm13
	vmovss	%xmm13, (%rcx,%r15)
	movl	$0x00000000, (%rsi,%r15)
	leaq	2(%rbx), %r15
	call	rand@PLT
	vxorps	%xmm14, %xmm14, %xmm14
	movq	-104(%rbp), %rdi
	vcvtsi2ssl	%eax, %xmm14, %xmm15
	vmulss	.LC2(%rip), %xmm15, %xmm7
	salq	$2, %r15
	vmovss	%xmm7, (%rdi,%r14)
	call	rand@PLT
	vxorps	%xmm0, %xmm0, %xmm0
	movq	-96(%rbp), %r8
	movq	-88(%rbp), %r9
	vcvtsi2ssl	%eax, %xmm0, %xmm4
	vmulss	.LC2(%rip), %xmm4, %xmm1
	vmovss	%xmm1, (%r8,%r14)
	movl	$0x00000000, (%r9,%r14)
	leaq	3(%rbx), %r14
	addq	$4, %rbx
	call	rand@PLT
	vxorps	%xmm2, %xmm2, %xmm2
	movq	-104(%rbp), %r11
	vcvtsi2ssl	%eax, %xmm2, %xmm3
	vmulss	.LC2(%rip), %xmm3, %xmm5
	vmovss	%xmm5, (%r11,%r15)
	call	rand@PLT
	vxorps	%xmm6, %xmm6, %xmm6
	movq	-96(%rbp), %r10
	movq	-88(%rbp), %rdx
	vcvtsi2ssl	%eax, %xmm6, %xmm8
	vmulss	.LC2(%rip), %xmm8, %xmm9
	vmovss	%xmm9, (%r10,%r15)
	movl	$0x00000000, (%rdx,%r15)
	leaq	0(,%r14,4), %r15
	call	rand@PLT
	vxorps	%xmm10, %xmm10, %xmm10
	vcvtsi2ssl	%eax, %xmm10, %xmm11
	vmulss	.LC2(%rip), %xmm11, %xmm12
	movq	-104(%rbp), %rax
	vmovss	%xmm12, (%rax,%r15)
	call	rand@PLT
	vxorps	%xmm13, %xmm13, %xmm13
	movq	-96(%rbp), %r10
	movq	-88(%rbp), %rdx
	vcvtsi2ssl	%eax, %xmm13, %xmm14
	vmulss	.LC2(%rip), %xmm14, %xmm15
	vmovss	%xmm15, (%r10,%r15)
	movl	$0x00000000, (%rdx,%r15)
	cmpq	%rbx, %r12
	jne	.L120
.L382:
	movq	-104(%rbp), %rcx
	cmpq	$6, %r14
	jbe	.L149
	leaq	-4(%rdx), %rdi
	movq	%rdi, %rsi
	subq	%rcx, %rsi
	cmpq	$56, %rsi
	jbe	.L149
	subq	%r10, %rdi
	cmpq	$56, %rdi
	jbe	.L149
	cmpq	$14, %r14
	jbe	.L150
	movq	%r12, %r8
	xorl	%eax, %eax
	shrq	$4, %r8
	salq	$6, %r8
	leaq	-64(%r8), %r15
	shrq	$6, %r15
	incq	%r15
	andl	$7, %r15d
	je	.L125
	cmpq	$1, %r15
	je	.L293
	cmpq	$2, %r15
	je	.L294
	cmpq	$3, %r15
	je	.L295
	cmpq	$4, %r15
	je	.L296
	cmpq	$5, %r15
	je	.L297
	cmpq	$6, %r15
	je	.L298
	vmovups	(%r10), %zmm7
	vmulps	(%rcx), %zmm7, %zmm0
	movl	$64, %eax
	vmovups	%zmm0, (%rdx)
.L298:
	vmovups	(%r10,%rax), %zmm4
	vmulps	(%rcx,%rax), %zmm4, %zmm1
	vmovups	%zmm1, (%rdx,%rax)
	addq	$64, %rax
.L297:
	vmovups	(%r10,%rax), %zmm2
	vmulps	(%rcx,%rax), %zmm2, %zmm3
	vmovups	%zmm3, (%rdx,%rax)
	addq	$64, %rax
.L296:
	vmovups	(%r10,%rax), %zmm5
	vmulps	(%rcx,%rax), %zmm5, %zmm6
	vmovups	%zmm6, (%rdx,%rax)
	addq	$64, %rax
.L295:
	vmovups	(%r10,%rax), %zmm8
	vmulps	(%rcx,%rax), %zmm8, %zmm9
	vmovups	%zmm9, (%rdx,%rax)
	addq	$64, %rax
.L294:
	vmovups	(%r10,%rax), %zmm10
	vmulps	(%rcx,%rax), %zmm10, %zmm11
	vmovups	%zmm11, (%rdx,%rax)
	addq	$64, %rax
.L293:
	vmovups	(%r10,%rax), %zmm12
	vmulps	(%rcx,%rax), %zmm12, %zmm13
	vmovups	%zmm13, (%rdx,%rax)
	addq	$64, %rax
	cmpq	%r8, %rax
	je	.L381
.L125:
	vmovups	(%r10,%rax), %zmm14
	vmulps	(%rcx,%rax), %zmm14, %zmm15
	vmovups	%zmm15, (%rdx,%rax)
	vmovups	64(%r10,%rax), %zmm7
	vmulps	64(%rcx,%rax), %zmm7, %zmm0
	vmovups	%zmm0, 64(%rdx,%rax)
	vmovups	128(%r10,%rax), %zmm4
	vmulps	128(%rcx,%rax), %zmm4, %zmm1
	vmovups	%zmm1, 128(%rdx,%rax)
	vmovups	192(%r10,%rax), %zmm2
	vmulps	192(%rcx,%rax), %zmm2, %zmm3
	vmovups	%zmm3, 192(%rdx,%rax)
	vmovups	256(%r10,%rax), %zmm5
	vmulps	256(%rcx,%rax), %zmm5, %zmm6
	vmovups	%zmm6, 256(%rdx,%rax)
	vmovups	320(%r10,%rax), %zmm8
	vmulps	320(%rcx,%rax), %zmm8, %zmm9
	vmovups	%zmm9, 320(%rdx,%rax)
	vmovups	384(%r10,%rax), %zmm10
	vmulps	384(%rcx,%rax), %zmm10, %zmm11
	vmovups	%zmm11, 384(%rdx,%rax)
	vmovups	448(%r10,%rax), %zmm12
	vmulps	448(%rcx,%rax), %zmm12, %zmm13
	vmovups	%zmm13, 448(%rdx,%rax)
	addq	$512, %rax
	cmpq	%r8, %rax
	jne	.L125
.L381:
	movq	%rbx, %r11
	andq	$-16, %r11
	testb	$15, %bl
	je	.L126
	movq	%rbx, %r9
	subq	%r11, %r9
	leaq	-1(%r9), %rdi
	cmpq	$6, %rdi
	jbe	.L127
.L124:
	vmovups	(%r10,%r11,4), %ymm14
	vmulps	(%rcx,%r11,4), %ymm14, %ymm15
	movq	%r9, %rsi
	andq	$-8, %rsi
	vmovups	%ymm15, (%rdx,%r11,4)
	addq	%rsi, %r11
	andb	$7, %r9b
	je	.L126
.L127:
	vmovss	(%rcx,%r11,4), %xmm7
	vmulss	(%r10,%r11,4), %xmm7, %xmm0
	leaq	1(%r11), %r8
	leaq	0(,%r11,4), %r9
	vmovss	%xmm0, (%rdx,%r11,4)
	cmpq	%rbx, %r8
	jnb	.L126
	vmovss	4(%rcx,%r9), %xmm4
	vmulss	4(%r10,%r9), %xmm4, %xmm1
	leaq	2(%r11), %r15
	vmovss	%xmm1, 4(%rdx,%r9)
	cmpq	%rbx, %r15
	jnb	.L126
	vmovss	8(%rcx,%r9), %xmm2
	vmulss	8(%r10,%r9), %xmm2, %xmm3
	leaq	3(%r11), %rax
	vmovss	%xmm3, 8(%rdx,%r9)
	cmpq	%rbx, %rax
	jnb	.L126
	vmovss	12(%rcx,%r9), %xmm5
	vmulss	12(%r10,%r9), %xmm5, %xmm6
	leaq	4(%r11), %rdi
	vmovss	%xmm6, 12(%rdx,%r9)
	cmpq	%rbx, %rdi
	jnb	.L126
	vmovss	16(%rcx,%r9), %xmm8
	vmulss	16(%r10,%r9), %xmm8, %xmm9
	leaq	5(%r11), %rsi
	vmovss	%xmm9, 16(%rdx,%r9)
	cmpq	%rbx, %rsi
	jnb	.L126
	vmovss	20(%rcx,%r9), %xmm10
	vmulss	20(%r10,%r9), %xmm10, %xmm11
	addq	$6, %r11
	vmovss	%xmm11, 20(%rdx,%r9)
	cmpq	%rbx, %r11
	jnb	.L126
	vmovss	24(%rcx,%r9), %xmm12
	vmulss	24(%r10,%r9), %xmm12, %xmm13
	vmovss	%xmm13, 24(%rdx,%r9)
.L126:
	leaq	-80(%rbp), %r15
	movl	$1, %edi
	vzeroupper
	movq	%r15, %rsi
	call	clock_gettime@PLT
	movq	-96(%rbp), %r10
	movq	-104(%rbp), %r11
	movq	-88(%rbp), %rcx
	vxorpd	%xmm14, %xmm14, %xmm14
	vmovsd	.LC4(%rip), %xmm4
	vcvtsi2sdq	-72(%rbp), %xmm14, %xmm15
	vcvtsi2sdq	-80(%rbp), %xmm14, %xmm7
	vfmadd132sd	%xmm4, %xmm7, %xmm15
	vmovsd	%xmm15, -120(%rbp)
.L131:
	leaq	-4(%rcx), %r8
	movq	%r8, %rdx
	subq	%r10, %rdx
	cmpq	$56, %rdx
	jbe	.L132
	subq	%r11, %r8
	cmpq	$56, %r8
	jbe	.L132
	cmpq	$14, %r14
	jbe	.L151
	movq	%rbx, %rdi
	xorl	%eax, %eax
	shrq	$4, %rdi
	salq	$6, %rdi
	leaq	-64(%rdi), %r8
	shrq	$6, %r8
	incq	%r8
	andl	$7, %r8d
	je	.L134
	cmpq	$1, %r8
	je	.L305
	cmpq	$2, %r8
	je	.L306
	cmpq	$3, %r8
	je	.L307
	cmpq	$4, %r8
	je	.L308
	cmpq	$5, %r8
	je	.L309
	cmpq	$6, %r8
	je	.L310
	vmovups	(%r10), %zmm2
	vmulps	(%r11), %zmm2, %zmm3
	movl	$64, %eax
	vmovups	%zmm3, (%rcx)
.L310:
	vmovups	(%r10,%rax), %zmm5
	vmulps	(%r11,%rax), %zmm5, %zmm6
	vmovups	%zmm6, (%rcx,%rax)
	addq	$64, %rax
.L309:
	vmovups	(%r10,%rax), %zmm8
	vmulps	(%r11,%rax), %zmm8, %zmm9
	vmovups	%zmm9, (%rcx,%rax)
	addq	$64, %rax
.L308:
	vmovups	(%r10,%rax), %zmm10
	vmulps	(%r11,%rax), %zmm10, %zmm11
	vmovups	%zmm11, (%rcx,%rax)
	addq	$64, %rax
.L307:
	vmovups	(%r10,%rax), %zmm12
	vmulps	(%r11,%rax), %zmm12, %zmm13
	vmovups	%zmm13, (%rcx,%rax)
	addq	$64, %rax
.L306:
	vmovups	(%r10,%rax), %zmm14
	vmulps	(%r11,%rax), %zmm14, %zmm15
	vmovups	%zmm15, (%rcx,%rax)
	addq	$64, %rax
.L305:
	vmovups	(%r10,%rax), %zmm7
	vmulps	(%r11,%rax), %zmm7, %zmm1
	vmovups	%zmm1, (%rcx,%rax)
	addq	$64, %rax
	cmpq	%rax, %rdi
	je	.L379
.L134:
	vmovups	(%r10,%rax), %zmm0
	vmulps	(%r11,%rax), %zmm0, %zmm2
	vmovups	%zmm2, (%rcx,%rax)
	vmovups	64(%r10,%rax), %zmm3
	vmulps	64(%r11,%rax), %zmm3, %zmm5
	vmovups	%zmm5, 64(%rcx,%rax)
	vmovups	128(%r10,%rax), %zmm6
	vmulps	128(%r11,%rax), %zmm6, %zmm8
	vmovups	%zmm8, 128(%rcx,%rax)
	vmovups	192(%r10,%rax), %zmm9
	vmulps	192(%r11,%rax), %zmm9, %zmm10
	vmovups	%zmm10, 192(%rcx,%rax)
	vmovups	256(%r10,%rax), %zmm11
	vmulps	256(%r11,%rax), %zmm11, %zmm12
	vmovups	%zmm12, 256(%rcx,%rax)
	vmovups	320(%r10,%rax), %zmm13
	vmulps	320(%r11,%rax), %zmm13, %zmm14
	vmovups	%zmm14, 320(%rcx,%rax)
	vmovups	384(%r10,%rax), %zmm15
	vmulps	384(%r11,%rax), %zmm15, %zmm7
	vmovups	%zmm7, 384(%rcx,%rax)
	vmovups	448(%r10,%rax), %zmm1
	vmulps	448(%r11,%rax), %zmm1, %zmm0
	vmovups	%zmm0, 448(%rcx,%rax)
	addq	$512, %rax
	cmpq	%rax, %rdi
	jne	.L134
.L379:
	movq	%rbx, %r9
	andq	$-16, %r9
	testb	$15, %bl
	je	.L135
	movq	%rbx, %rsi
	subq	%r9, %rsi
	leaq	-1(%rsi), %rdx
	cmpq	$6, %rdx
	jbe	.L136
.L133:
	vmovups	(%r10,%r9,4), %ymm10
	vmulps	(%r11,%r9,4), %ymm10, %ymm11
	movq	%rsi, %rdi
	andq	$-8, %rdi
	vmovups	%ymm11, (%rcx,%r9,4)
	addq	%rdi, %r9
	andb	$7, %sil
	je	.L389
.L136:
	vmovss	(%r11,%r9,4), %xmm12
	vmulss	(%r10,%r9,4), %xmm12, %xmm13
	leaq	1(%r9), %r8
	leaq	0(,%r9,4), %rsi
	vmovss	%xmm13, (%rcx,%r9,4)
	cmpq	%rbx, %r8
	jnb	.L389
	vmovss	4(%r10,%rsi), %xmm14
	vmulss	4(%r11,%rsi), %xmm14, %xmm15
	leaq	2(%r9), %rax
	vmovss	%xmm15, 4(%rcx,%rsi)
	cmpq	%rbx, %rax
	jnb	.L389
	vmovss	8(%r11,%rsi), %xmm7
	vmulss	8(%r10,%rsi), %xmm7, %xmm1
	leaq	3(%r9), %rdx
	vmovss	%xmm1, 8(%rcx,%rsi)
	cmpq	%rbx, %rdx
	jnb	.L389
	vmovss	12(%r11,%rsi), %xmm0
	vmulss	12(%r10,%rsi), %xmm0, %xmm3
	leaq	4(%r9), %rdi
	vmovss	%xmm3, 12(%rcx,%rsi)
	cmpq	%rbx, %rdi
	jnb	.L389
	vmovss	16(%r11,%rsi), %xmm2
	vmulss	16(%r10,%rsi), %xmm2, %xmm5
	leaq	5(%r9), %r8
	vmovss	%xmm5, 16(%rcx,%rsi)
	cmpq	%rbx, %r8
	jnb	.L389
	vmovss	20(%r11,%rsi), %xmm8
	vmulss	20(%r10,%rsi), %xmm8, %xmm6
	addq	$6, %r9
	vmovss	%xmm6, 20(%rcx,%rsi)
	cmpq	%rbx, %r9
	jnb	.L389
	vmovss	24(%r11,%rsi), %xmm9
	vmulss	24(%r10,%rsi), %xmm9, %xmm10
	vmovss	%xmm10, 24(%rcx,%rsi)
	vzeroupper
.L139:
	movq	%r15, %rsi
	movl	$1, %edi
	vmovsd	%xmm4, -128(%rbp)
	call	clock_gettime@PLT
	vxorpd	%xmm4, %xmm4, %xmm4
	vmovsd	-128(%rbp), %xmm13
	vcvtsi2sdq	-72(%rbp), %xmm4, %xmm11
	vcvtsi2sdq	-80(%rbp), %xmm4, %xmm12
	vcvtsi2sdq	%rbx, %xmm4, %xmm14
	vfmadd132sd	%xmm13, %xmm12, %xmm11
	vmulsd	%xmm13, %xmm14, %xmm15
	vsubsd	-120(%rbp), %xmm11, %xmm8
	movq	-88(%rbp), %r10
	vdivsd	%xmm8, %xmm15, %xmm1
	cmpq	$14, %r14
	jbe	.L152
.L145:
	movq	%rbx, %rcx
	movq	%r10, %r11
	vxorpd	%xmm0, %xmm0, %xmm0
	shrq	$4, %rcx
	salq	$6, %rcx
	leaq	(%rcx,%r10), %r15
	subq	$64, %rcx
	shrq	$6, %rcx
	incq	%rcx
	andl	$7, %ecx
	je	.L141
	cmpq	$1, %rcx
	je	.L317
	cmpq	$2, %rcx
	je	.L318
	cmpq	$3, %rcx
	je	.L319
	cmpq	$4, %rcx
	je	.L320
	cmpq	$5, %rcx
	je	.L321
	cmpq	$6, %rcx
	jne	.L399
.L322:
	vmovups	(%r11), %zmm6
	addq	$64, %r11
	vextractf32x8	$0x1, %zmm6, %ymm9
	vcvtps2pd	%ymm6, %zmm4
	vcvtps2pd	%ymm9, %zmm10
	vaddpd	%zmm4, %zmm10, %zmm11
	vaddpd	%zmm11, %zmm0, %zmm0
.L321:
	vmovups	(%r11), %zmm12
	addq	$64, %r11
	vextractf32x8	$0x1, %zmm12, %ymm13
	vcvtps2pd	%ymm12, %zmm15
	vcvtps2pd	%ymm13, %zmm14
	vaddpd	%zmm15, %zmm14, %zmm7
	vaddpd	%zmm7, %zmm0, %zmm0
.L320:
	vmovups	(%r11), %zmm3
	addq	$64, %r11
	vextractf32x8	$0x1, %zmm3, %ymm5
	vcvtps2pd	%ymm3, %zmm6
	vcvtps2pd	%ymm5, %zmm2
	vaddpd	%zmm6, %zmm2, %zmm9
	vaddpd	%zmm9, %zmm0, %zmm0
.L319:
	vmovups	(%r11), %zmm10
	addq	$64, %r11
	vextractf32x8	$0x1, %zmm10, %ymm4
	vcvtps2pd	%ymm10, %zmm12
	vcvtps2pd	%ymm4, %zmm11
	vaddpd	%zmm12, %zmm11, %zmm13
	vaddpd	%zmm13, %zmm0, %zmm0
.L318:
	vmovups	(%r11), %zmm14
	addq	$64, %r11
	vextractf32x8	$0x1, %zmm14, %ymm15
	vcvtps2pd	%ymm14, %zmm3
	vcvtps2pd	%ymm15, %zmm7
	vaddpd	%zmm3, %zmm7, %zmm5
	vaddpd	%zmm5, %zmm0, %zmm0
.L317:
	vmovups	(%r11), %zmm6
	addq	$64, %r11
	vextractf32x8	$0x1, %zmm6, %ymm2
	vcvtps2pd	%ymm6, %zmm10
	vcvtps2pd	%ymm2, %zmm9
	vaddpd	%zmm10, %zmm9, %zmm4
	vaddpd	%zmm4, %zmm0, %zmm0
	cmpq	%r11, %r15
	je	.L378
.L141:
	vmovups	(%r11), %zmm11
	vmovups	64(%r11), %zmm3
	vmovups	128(%r11), %zmm4
	addq	$512, %r11
	vextractf32x8	$0x1, %zmm11, %ymm12
	vcvtps2pd	%ymm11, %zmm14
	vcvtps2pd	%ymm12, %zmm13
	vextractf32x8	$0x1, %zmm3, %ymm5
	vcvtps2pd	%ymm5, %zmm6
	vcvtps2pd	%ymm3, %zmm2
	vcvtps2pd	%ymm4, %zmm12
	vaddpd	%zmm14, %zmm13, %zmm15
	vaddpd	%zmm2, %zmm6, %zmm9
	vaddpd	%zmm15, %zmm0, %zmm7
	vmovups	-320(%r11), %zmm15
	vextractf32x8	$0x1, %zmm4, %ymm0
	vcvtps2pd	%ymm0, %zmm11
	vaddpd	%zmm9, %zmm7, %zmm10
	vmovups	-256(%r11), %zmm9
	vextractf32x8	$0x1, %zmm15, %ymm7
	vcvtps2pd	%ymm15, %zmm3
	vaddpd	%zmm12, %zmm11, %zmm13
	vcvtps2pd	%ymm7, %zmm5
	vaddpd	%zmm13, %zmm10, %zmm14
	vmovups	-192(%r11), %zmm13
	vextractf32x8	$0x1, %zmm9, %ymm10
	vcvtps2pd	%ymm10, %zmm4
	vcvtps2pd	%ymm9, %zmm0
	vaddpd	%zmm3, %zmm5, %zmm6
	vcvtps2pd	%ymm13, %zmm7
	vmovups	-128(%r11), %zmm3
	vaddpd	%zmm0, %zmm4, %zmm11
	vmovups	-64(%r11), %zmm0
	vaddpd	%zmm6, %zmm14, %zmm2
	vextractf32x8	$0x1, %zmm13, %ymm14
	vcvtps2pd	%ymm14, %zmm15
	vcvtps2pd	%ymm3, %zmm10
	vcvtps2pd	%ymm0, %zmm14
	vaddpd	%zmm11, %zmm2, %zmm12
	vextractf32x8	$0x1, %zmm3, %ymm2
	vaddpd	%zmm7, %zmm15, %zmm5
	vcvtps2pd	%ymm2, %zmm9
	vaddpd	%zmm5, %zmm12, %zmm6
	vextractf32x8	$0x1, %zmm0, %ymm12
	vcvtps2pd	%ymm12, %zmm13
	vaddpd	%zmm10, %zmm9, %zmm4
	vaddpd	%zmm4, %zmm6, %zmm11
	vaddpd	%zmm14, %zmm13, %zmm15
	vaddpd	%zmm15, %zmm11, %zmm0
	cmpq	%r11, %r15
	jne	.L141
.L378:
	vextractf64x4	$0x1, %zmm0, %ymm7
	movq	%rbx, %r14
	vaddpd	%ymm0, %ymm7, %ymm5
	andq	$-16, %r14
	vextractf64x2	$0x1, %ymm5, %xmm6
	vaddpd	%xmm5, %xmm6, %xmm9
	vmovapd	%ymm5, %ymm7
	vunpckhpd	%xmm9, %xmm9, %xmm2
	vaddpd	%xmm9, %xmm2, %xmm2
	testb	$15, %bl
	je	.L396
.L140:
	movq	%rbx, %r8
	subq	%r14, %r8
	leaq	-1(%r8), %rsi
	cmpq	$6, %rsi
	jbe	.L143
	vmovups	(%r10,%r14,4), %ymm10
	movq	%r8, %r9
	andq	$-8, %r9
	addq	%r9, %r14
	andl	$7, %r8d
	vcvtps2pd	%xmm10, %ymm4
	vextractf32x4	$0x1, %ymm10, %xmm11
	vcvtps2pd	%xmm11, %ymm0
	vaddpd	%ymm0, %ymm4, %ymm12
	vaddpd	%ymm7, %ymm12, %ymm13
	vextractf64x2	$0x1, %ymm13, %xmm14
	vaddpd	%xmm13, %xmm14, %xmm15
	vunpckhpd	%xmm15, %xmm15, %xmm7
	vaddpd	%xmm15, %xmm7, %xmm2
	je	.L396
.L143:
	leaq	1(%r14), %rdx
	vxorpd	%xmm5, %xmm5, %xmm5
	leaq	0(,%r14,4), %rax
	vcvtss2sd	(%r10,%r14,4), %xmm5, %xmm6
	vaddsd	%xmm6, %xmm2, %xmm2
	cmpq	%rbx, %rdx
	jnb	.L396
	leaq	2(%r14), %rdi
	vcvtss2sd	4(%r10,%rax), %xmm5, %xmm3
	vaddsd	%xmm3, %xmm2, %xmm2
	cmpq	%rbx, %rdi
	jnb	.L396
	leaq	3(%r14), %rcx
	vcvtss2sd	8(%r10,%rax), %xmm5, %xmm9
	vaddsd	%xmm9, %xmm2, %xmm2
	cmpq	%rbx, %rcx
	jnb	.L396
	leaq	4(%r14), %r15
	vcvtss2sd	12(%r10,%rax), %xmm5, %xmm10
	vaddsd	%xmm10, %xmm2, %xmm2
	cmpq	%rbx, %r15
	jnb	.L396
	leaq	5(%r14), %r11
	vcvtss2sd	16(%r10,%rax), %xmm5, %xmm4
	vaddsd	%xmm4, %xmm2, %xmm2
	cmpq	%rbx, %r11
	jnb	.L396
	addq	$6, %r14
	vcvtss2sd	20(%r10,%rax), %xmm5, %xmm11
	vaddsd	%xmm11, %xmm2, %xmm2
	cmpq	%rbx, %r14
	jnb	.L396
	vcvtss2sd	24(%r10,%rax), %xmm5, %xmm0
	vaddsd	%xmm0, %xmm2, %xmm2
	vzeroupper
.L122:
	vmovapd	%xmm8, %xmm0
	movq	%r12, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$3, %eax
	call	printf@PLT
	movq	-104(%rbp), %rdi
	call	free@PLT
	movq	-96(%rbp), %rdi
	call	free@PLT
	movq	-88(%rbp), %rdi
	call	free@PLT
.L114:
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L400
	subq	$-128, %rsp
	movl	%r13d, %eax
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L389:
	.cfi_restore_state
	vzeroupper
	jmp	.L139
.L396:
	vzeroupper
	jmp	.L122
.L399:
	vmovups	(%r10), %zmm3
	leaq	64(%r10), %r11
	vextractf32x8	$0x1, %zmm3, %ymm0
	vcvtps2pd	%ymm3, %zmm2
	vcvtps2pd	%ymm0, %zmm5
	vaddpd	%zmm2, %zmm5, %zmm0
	jmp	.L322
.L149:
	leaq	1(%r14), %r9
	xorl	%r8d, %r8d
	andl	$7, %r9d
	je	.L129
	cmpq	$1, %r9
	je	.L299
	cmpq	$2, %r9
	je	.L300
	cmpq	$3, %r9
	je	.L301
	cmpq	$4, %r9
	je	.L302
	cmpq	$5, %r9
	je	.L303
	cmpq	$6, %r9
	je	.L304
	vmovss	(%rcx), %xmm0
	vmulss	(%r10), %xmm0, %xmm1
	movl	$1, %r8d
	vmovss	%xmm1, (%rdx)
.L304:
	vmovss	(%rcx,%r8,4), %xmm2
	vmulss	(%r10,%r8,4), %xmm2, %xmm3
	vmovss	%xmm3, (%rdx,%r8,4)
	incq	%r8
.L303:
	vmovss	(%rcx,%r8,4), %xmm5
	vmulss	(%r10,%r8,4), %xmm5, %xmm6
	vmovss	%xmm6, (%rdx,%r8,4)
	incq	%r8
.L302:
	vmovss	(%rcx,%r8,4), %xmm8
	vmulss	(%r10,%r8,4), %xmm8, %xmm9
	vmovss	%xmm9, (%rdx,%r8,4)
	incq	%r8
.L301:
	vmovss	(%rcx,%r8,4), %xmm10
	vmulss	(%r10,%r8,4), %xmm10, %xmm11
	vmovss	%xmm11, (%rdx,%r8,4)
	incq	%r8
.L300:
	vmovss	(%rcx,%r8,4), %xmm12
	vmulss	(%r10,%r8,4), %xmm12, %xmm13
	vmovss	%xmm13, (%rdx,%r8,4)
	incq	%r8
.L299:
	vmovss	(%rcx,%r8,4), %xmm14
	vmulss	(%r10,%r8,4), %xmm14, %xmm15
	movq	%r8, %rax
	vmovss	%xmm15, (%rdx,%r8,4)
	incq	%r8
	cmpq	%rax, %r14
	je	.L380
.L129:
	vmovss	(%rcx,%r8,4), %xmm7
	vmulss	(%r10,%r8,4), %xmm7, %xmm4
	leaq	1(%r8), %rdi
	leaq	2(%r8), %rsi
	leaq	3(%r8), %r15
	leaq	4(%r8), %r11
	leaq	5(%r8), %r9
	leaq	6(%r8), %rax
	vmovss	%xmm4, (%rdx,%r8,4)
	vmovss	(%rcx,%rdi,4), %xmm0
	vmulss	(%r10,%rdi,4), %xmm0, %xmm1
	vmovss	%xmm1, (%rdx,%rdi,4)
	vmovss	(%rcx,%rsi,4), %xmm2
	vmulss	(%r10,%rsi,4), %xmm2, %xmm3
	leaq	7(%r8), %rdi
	addq	$8, %r8
	vmovss	%xmm3, (%rdx,%rsi,4)
	vmovss	(%rcx,%r15,4), %xmm5
	vmulss	(%r10,%r15,4), %xmm5, %xmm6
	vmovss	%xmm6, (%rdx,%r15,4)
	vmovss	(%rcx,%r11,4), %xmm8
	vmulss	(%r10,%r11,4), %xmm8, %xmm9
	vmovss	%xmm9, (%rdx,%r11,4)
	vmovss	(%rcx,%r9,4), %xmm10
	vmulss	(%r10,%r9,4), %xmm10, %xmm11
	vmovss	%xmm11, (%rdx,%r9,4)
	vmovss	(%rcx,%rax,4), %xmm12
	vmulss	(%r10,%rax,4), %xmm12, %xmm13
	vmovss	%xmm13, (%rdx,%rax,4)
	vmovss	(%rcx,%rdi,4), %xmm14
	vmulss	(%r10,%rdi,4), %xmm14, %xmm15
	vmovss	%xmm15, (%rdx,%rdi,4)
	cmpq	%rdi, %r14
	jne	.L129
.L380:
	leaq	-80(%rbp), %r15
	movl	$1, %edi
	movq	%r15, %rsi
	call	clock_gettime@PLT
	vxorpd	%xmm7, %xmm7, %xmm7
	vmovsd	.LC4(%rip), %xmm4
	vcvtsi2sdq	-72(%rbp), %xmm7, %xmm1
	vcvtsi2sdq	-80(%rbp), %xmm7, %xmm0
	vfmadd132sd	%xmm4, %xmm0, %xmm1
	movq	-96(%rbp), %r10
	movq	-104(%rbp), %r11
	movq	-88(%rbp), %rcx
	vmovsd	%xmm1, -120(%rbp)
	cmpq	$6, %r14
	ja	.L131
.L132:
	leaq	1(%r14), %r9
	xorl	%esi, %esi
	andl	$7, %r9d
	je	.L138
	cmpq	$1, %r9
	je	.L311
	cmpq	$2, %r9
	je	.L312
	cmpq	$3, %r9
	je	.L313
	cmpq	$4, %r9
	je	.L314
	cmpq	$5, %r9
	je	.L315
	cmpq	$6, %r9
	je	.L316
	vmovss	(%r11), %xmm11
	vmulss	(%r10), %xmm11, %xmm12
	movl	$1, %esi
	vmovss	%xmm12, (%rcx)
.L316:
	vmovss	(%r11,%rsi,4), %xmm13
	vmulss	(%r10,%rsi,4), %xmm13, %xmm14
	vmovss	%xmm14, (%rcx,%rsi,4)
	incq	%rsi
.L315:
	vmovss	(%r11,%rsi,4), %xmm15
	vmulss	(%r10,%rsi,4), %xmm15, %xmm7
	vmovss	%xmm7, (%rcx,%rsi,4)
	incq	%rsi
.L314:
	vmovss	(%r11,%rsi,4), %xmm1
	vmulss	(%r10,%rsi,4), %xmm1, %xmm0
	vmovss	%xmm0, (%rcx,%rsi,4)
	incq	%rsi
.L313:
	vmovss	(%r11,%rsi,4), %xmm3
	vmulss	(%r10,%rsi,4), %xmm3, %xmm2
	vmovss	%xmm2, (%rcx,%rsi,4)
	incq	%rsi
.L312:
	vmovss	(%r11,%rsi,4), %xmm5
	vmulss	(%r10,%rsi,4), %xmm5, %xmm8
	vmovss	%xmm8, (%rcx,%rsi,4)
	incq	%rsi
.L311:
	vmovss	(%r11,%rsi,4), %xmm6
	vmulss	(%r10,%rsi,4), %xmm6, %xmm9
	movq	%rsi, %rax
	vmovss	%xmm9, (%rcx,%rsi,4)
	incq	%rsi
	cmpq	%rax, %r14
	je	.L139
.L138:
	vmovss	(%r11,%rsi,4), %xmm10
	vmulss	(%r10,%rsi,4), %xmm10, %xmm11
	leaq	1(%rsi), %rdx
	leaq	2(%rsi), %rdi
	leaq	3(%rsi), %r8
	leaq	4(%rsi), %r9
	leaq	5(%rsi), %rax
	vmovss	%xmm11, (%rcx,%rsi,4)
	vmovss	(%r11,%rdx,4), %xmm12
	vmulss	(%r10,%rdx,4), %xmm12, %xmm13
	vmovss	%xmm13, (%rcx,%rdx,4)
	vmovss	(%r11,%rdi,4), %xmm14
	vmulss	(%r10,%rdi,4), %xmm14, %xmm15
	leaq	6(%rsi), %rdx
	vmovss	%xmm15, (%rcx,%rdi,4)
	vmovss	(%r11,%r8,4), %xmm7
	vmulss	(%r10,%r8,4), %xmm7, %xmm1
	leaq	7(%rsi), %rdi
	addq	$8, %rsi
	vmovss	%xmm1, (%rcx,%r8,4)
	vmovss	(%r11,%r9,4), %xmm0
	vmulss	(%r10,%r9,4), %xmm0, %xmm3
	vmovss	%xmm3, (%rcx,%r9,4)
	vmovss	(%r11,%rax,4), %xmm2
	vmulss	(%r10,%rax,4), %xmm2, %xmm5
	vmovss	%xmm5, (%rcx,%rax,4)
	vmovss	(%r11,%rdx,4), %xmm8
	vmulss	(%r10,%rdx,4), %xmm8, %xmm6
	vmovss	%xmm6, (%rcx,%rdx,4)
	vmovss	(%r11,%rdi,4), %xmm9
	vmulss	(%r10,%rdi,4), %xmm9, %xmm10
	vmovss	%xmm10, (%rcx,%rdi,4)
	cmpq	%rdi, %r14
	jne	.L138
	jmp	.L139
.L119:
	leaq	-80(%rbp), %r14
	movl	$1, %edi
	movq	%r14, %rsi
	call	clock_gettime@PLT
	movq	%r14, %rsi
	movl	$1, %edi
	vxorpd	%xmm7, %xmm7, %xmm7
	vcvtsi2sdq	-72(%rbp), %xmm7, %xmm4
	vcvtsi2sdq	-80(%rbp), %xmm7, %xmm0
	vfmadd132sd	.LC4(%rip), %xmm0, %xmm4
	vmovsd	%xmm4, -120(%rbp)
	call	clock_gettime@PLT
	vxorpd	%xmm1, %xmm1, %xmm1
	vcvtsi2sdq	-72(%rbp), %xmm1, %xmm2
	vcvtsi2sdq	-80(%rbp), %xmm1, %xmm3
	vxorpd	%xmm1, %xmm1, %xmm1
	vfmadd132sd	.LC4(%rip), %xmm3, %xmm2
	vsubsd	-120(%rbp), %xmm2, %xmm8
	vmovapd	%xmm1, %xmm2
	jmp	.L122
.L152:
	xorl	%r14d, %r14d
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm2, %xmm2, %xmm2
	jmp	.L140
.L151:
	movq	%rbx, %rsi
	xorl	%r9d, %r9d
	jmp	.L133
.L150:
	movq	%r12, %r9
	xorl	%r11d, %r11d
	jmp	.L124
.L135:
	movq	%r15, %rsi
	movl	$1, %edi
	vmovsd	%xmm4, -128(%rbp)
	vzeroupper
	call	clock_gettime@PLT
	vxorpd	%xmm3, %xmm3, %xmm3
	vmovsd	-128(%rbp), %xmm5
	vcvtsi2sdq	-72(%rbp), %xmm3, %xmm4
	vcvtsi2sdq	-80(%rbp), %xmm3, %xmm2
	vcvtsi2sdq	%rbx, %xmm3, %xmm6
	vfmadd132sd	%xmm5, %xmm2, %xmm4
	vmulsd	%xmm5, %xmm6, %xmm9
	vsubsd	-120(%rbp), %xmm4, %xmm8
	movq	-88(%rbp), %r10
	vdivsd	%xmm8, %xmm9, %xmm1
	jmp	.L145
.L400:
	call	__stack_chk_fail@PLT
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB14:
.L118:
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	.cfi_escape 0x10,0x6,0x2,0x76,0
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	leaq	.LC1(%rip), %rdi
	movl	$1, %r13d
	call	perror@PLT
	jmp	.L114
	.cfi_endproc
.LFE14:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE6:
	.section	.text.startup
.LHOTE6:
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC2:
	.long	805306368
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC4:
	.long	-400107883
	.long	1041313291
	.ident	"GCC: (GNU) 14.3.0"
	.section	.note.GNU-stack,"",@progbits
