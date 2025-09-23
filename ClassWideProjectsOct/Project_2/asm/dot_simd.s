	.file	"dot.c"
	.text
	.p2align 4
	.globl	dot_scalar
	.type	dot_scalar, @function
dot_scalar:
.LFB12:
	.cfi_startproc
	movq	%rdi, %rcx
	testq	%rdx, %rdx
	je	.L9
	leaq	-1(%rdx), %rax
	cmpq	$14, %rax
	jbe	.L10
	movq	%rdx, %r8
	xorl	%r10d, %r10d
	vxorps	%xmm0, %xmm0, %xmm0
	shrq	$4, %r8
	salq	$6, %r8
	leaq	-64(%r8), %rdi
	shrq	$6, %rdi
	incq	%rdi
	andl	$7, %edi
	je	.L4
	cmpq	$1, %rdi
	je	.L37
	cmpq	$2, %rdi
	je	.L38
	cmpq	$3, %rdi
	je	.L39
	cmpq	$4, %rdi
	je	.L40
	cmpq	$5, %rdi
	je	.L41
	cmpq	$6, %rdi
	jne	.L62
.L42:
	vmovups	(%rcx,%r10), %zmm7
	vfmadd231ps	(%rsi,%r10), %zmm7, %zmm0
	addq	$64, %r10
.L41:
	vmovups	(%rcx,%r10), %zmm2
	vfmadd231ps	(%rsi,%r10), %zmm2, %zmm0
	addq	$64, %r10
.L40:
	vmovups	(%rcx,%r10), %zmm6
	vfmadd231ps	(%rsi,%r10), %zmm6, %zmm0
	addq	$64, %r10
.L39:
	vmovups	(%rcx,%r10), %zmm5
	vfmadd231ps	(%rsi,%r10), %zmm5, %zmm0
	addq	$64, %r10
.L38:
	vmovups	(%rcx,%r10), %zmm3
	vfmadd231ps	(%rsi,%r10), %zmm3, %zmm0
	addq	$64, %r10
.L37:
	vmovups	(%rcx,%r10), %zmm8
	vfmadd231ps	(%rsi,%r10), %zmm8, %zmm0
	addq	$64, %r10
	cmpq	%r10, %r8
	je	.L53
.L4:
	vmovups	(%rcx,%r10), %zmm9
	vmovups	64(%rcx,%r10), %zmm10
	vmovups	128(%rcx,%r10), %zmm11
	vfmadd231ps	(%rsi,%r10), %zmm9, %zmm0
	vmovups	192(%rcx,%r10), %zmm12
	vmovups	256(%rcx,%r10), %zmm13
	vmovups	320(%rcx,%r10), %zmm14
	vfmadd231ps	64(%rsi,%r10), %zmm10, %zmm0
	vmovups	384(%rcx,%r10), %zmm15
	vmovups	448(%rcx,%r10), %zmm1
	vfmadd231ps	128(%rsi,%r10), %zmm11, %zmm0
	vfmadd231ps	192(%rsi,%r10), %zmm12, %zmm0
	vfmadd231ps	256(%rsi,%r10), %zmm13, %zmm0
	vfmadd231ps	320(%rsi,%r10), %zmm14, %zmm0
	vfmadd231ps	384(%rsi,%r10), %zmm15, %zmm0
	vfmadd231ps	448(%rsi,%r10), %zmm1, %zmm0
	addq	$512, %r10
	cmpq	%r10, %r8
	jne	.L4
.L53:
	vextractf32x8	$0x1, %zmm0, %ymm4
	movq	%rdx, %r9
	vaddps	%ymm0, %ymm4, %ymm1
	andq	$-16, %r9
	vextractf32x4	$0x1, %ymm1, %xmm0
	vaddps	%xmm1, %xmm0, %xmm6
	vmovhlps	%xmm6, %xmm6, %xmm2
	vaddps	%xmm6, %xmm2, %xmm5
	vshufps	$85, %xmm5, %xmm5, %xmm3
	vaddps	%xmm5, %xmm3, %xmm0
	testb	$15, %dl
	je	.L60
.L3:
	movq	%rdx, %r11
	subq	%r9, %r11
	leaq	-1(%r11), %rax
	cmpq	$6, %rax
	jbe	.L7
	vmovups	(%rcx,%r9,4), %ymm8
	vfmadd231ps	(%rsi,%r9,4), %ymm8, %ymm1
	vextractf32x4	$0x1, %ymm1, %xmm9
	vaddps	%xmm1, %xmm9, %xmm10
	movq	%r11, %r8
	andq	$-8, %r8
	vmovhlps	%xmm10, %xmm10, %xmm11
	addq	%r8, %r9
	andl	$7, %r11d
	vaddps	%xmm10, %xmm11, %xmm12
	vshufps	$85, %xmm12, %xmm12, %xmm13
	vaddps	%xmm12, %xmm13, %xmm0
	je	.L60
.L7:
	leaq	1(%r9), %r10
	vmovss	(%rcx,%r9,4), %xmm14
	leaq	0(,%r9,4), %rdi
	vfmadd231ss	(%rsi,%r9,4), %xmm14, %xmm0
	cmpq	%rdx, %r10
	jnb	.L60
	leaq	2(%r9), %r11
	vmovss	4(%rsi,%rdi), %xmm15
	vfmadd231ss	4(%rcx,%rdi), %xmm15, %xmm0
	cmpq	%rdx, %r11
	jnb	.L60
	leaq	3(%r9), %rax
	vmovss	8(%rcx,%rdi), %xmm1
	vfmadd231ss	8(%rsi,%rdi), %xmm1, %xmm0
	cmpq	%rdx, %rax
	jnb	.L60
	leaq	4(%r9), %r8
	vmovss	12(%rcx,%rdi), %xmm4
	vfmadd231ss	12(%rsi,%rdi), %xmm4, %xmm0
	cmpq	%rdx, %r8
	jnb	.L60
	leaq	5(%r9), %r10
	vmovss	16(%rcx,%rdi), %xmm7
	vfmadd231ss	16(%rsi,%rdi), %xmm7, %xmm0
	cmpq	%rdx, %r10
	jnb	.L60
	addq	$6, %r9
	vmovss	20(%rcx,%rdi), %xmm6
	vfmadd231ss	20(%rsi,%rdi), %xmm6, %xmm0
	cmpq	%rdx, %r9
	jnb	.L60
	vmovss	24(%rcx,%rdi), %xmm2
	vfmadd231ss	24(%rsi,%rdi), %xmm2, %xmm0
	vzeroupper
	ret
	.p2align 4
	.p2align 3
.L60:
	vzeroupper
	ret
	.p2align 4
	.p2align 3
.L62:
	vmovups	(%rcx), %zmm4
	movl	$64, %r10d
	vfmadd231ps	(%rsi), %zmm4, %zmm0
	jmp	.L42
	.p2align 4
	.p2align 3
.L9:
	vxorps	%xmm0, %xmm0, %xmm0
	ret
.L10:
	xorl	%r9d, %r9d
	vxorps	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.L3
	.cfi_endproc
.LFE12:
	.size	dot_scalar, .-dot_scalar
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"posix_memalign failed"
.LC6:
	.string	"dot,%zu,%.9f,%.6f,%.6e\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB7:
	.section	.text.startup,"ax",@progbits
.LHOTB7:
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
	jle	.L64
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtoull@PLT
	movq	%rax, %r12
.L64:
	leaq	0(,%r12,4), %rbx
	leaq	-96(%rbp), %rdi
	movl	$64, %esi
	movq	$0, -96(%rbp)
	movq	%rbx, %rdx
	movq	$0, -88(%rbp)
	call	posix_memalign@PLT
	testl	%eax, %eax
	jne	.L67
	leaq	-88(%rbp), %rdi
	movq	%rbx, %rdx
	movl	$64, %esi
	call	posix_memalign@PLT
	movl	%eax, %r13d
	testl	%eax, %eax
	jne	.L67
	movl	$42, %edi
	call	srand@PLT
	testq	%r12, %r12
	je	.L83
	movq	%r12, %rax
	xorl	%ebx, %ebx
	andl	$3, %eax
	je	.L69
	cmpq	$1, %rax
	je	.L149
	cmpq	$2, %rax
	je	.L150
	call	rand@PLT
	vxorps	%xmm7, %xmm7, %xmm7
	movq	-96(%rbp), %rdx
	vcvtsi2ssl	%eax, %xmm7, %xmm1
	vmulss	.LC3(%rip), %xmm1, %xmm2
	vmovss	%xmm2, (%rdx,%rbx)
	call	rand@PLT
	vxorps	%xmm3, %xmm3, %xmm3
	movq	-88(%rbp), %rcx
	vcvtsi2ssl	%eax, %xmm3, %xmm4
	vmulss	.LC3(%rip), %xmm4, %xmm5
	vmovss	%xmm5, (%rcx,%rbx)
	movl	$1, %ebx
.L150:
	call	rand@PLT
	vxorps	%xmm6, %xmm6, %xmm6
	movq	-96(%rbp), %rsi
	leaq	0(,%rbx,4), %r14
	vcvtsi2ssl	%eax, %xmm6, %xmm8
	vmulss	.LC3(%rip), %xmm8, %xmm9
	incq	%rbx
	vmovss	%xmm9, (%rsi,%r14)
	call	rand@PLT
	vxorps	%xmm10, %xmm10, %xmm10
	movq	-88(%rbp), %rdi
	vcvtsi2ssl	%eax, %xmm10, %xmm11
	vmulss	.LC3(%rip), %xmm11, %xmm12
	vmovss	%xmm12, (%rdi,%r14)
.L149:
	call	rand@PLT
	vxorps	%xmm13, %xmm13, %xmm13
	movq	-96(%rbp), %r8
	leaq	0(,%rbx,4), %r15
	vcvtsi2ssl	%eax, %xmm13, %xmm14
	vmulss	.LC3(%rip), %xmm14, %xmm15
	movq	%rbx, %r14
	incq	%rbx
	vmovss	%xmm15, (%r8,%r15)
	call	rand@PLT
	vxorps	%xmm0, %xmm0, %xmm0
	movq	-88(%rbp), %r9
	vcvtsi2ssl	%eax, %xmm0, %xmm7
	vmulss	.LC3(%rip), %xmm7, %xmm1
	vmovss	%xmm1, (%r9,%r15)
	cmpq	%rbx, %r12
	je	.L189
.L69:
	call	rand@PLT
	vxorps	%xmm2, %xmm2, %xmm2
	movq	-96(%rbp), %r11
	leaq	0(,%rbx,4), %r15
	vcvtsi2ssl	%eax, %xmm2, %xmm3
	vmulss	.LC3(%rip), %xmm3, %xmm4
	leaq	1(%rbx), %r14
	salq	$2, %r14
	vmovss	%xmm4, (%r11,%r15)
	call	rand@PLT
	vxorps	%xmm5, %xmm5, %xmm5
	movq	-88(%rbp), %r10
	vcvtsi2ssl	%eax, %xmm5, %xmm6
	vmulss	.LC3(%rip), %xmm6, %xmm8
	vmovss	%xmm8, (%r10,%r15)
	leaq	2(%rbx), %r15
	call	rand@PLT
	vxorps	%xmm9, %xmm9, %xmm9
	vcvtsi2ssl	%eax, %xmm9, %xmm10
	vmulss	.LC3(%rip), %xmm10, %xmm11
	movq	-96(%rbp), %rax
	salq	$2, %r15
	vmovss	%xmm11, (%rax,%r14)
	call	rand@PLT
	vxorps	%xmm12, %xmm12, %xmm12
	movq	-88(%rbp), %rdx
	vcvtsi2ssl	%eax, %xmm12, %xmm13
	vmulss	.LC3(%rip), %xmm13, %xmm14
	vmovss	%xmm14, (%rdx,%r14)
	leaq	3(%rbx), %r14
	addq	$4, %rbx
	call	rand@PLT
	vxorps	%xmm15, %xmm15, %xmm15
	movq	-96(%rbp), %rcx
	vcvtsi2ssl	%eax, %xmm15, %xmm0
	vmulss	.LC3(%rip), %xmm0, %xmm7
	vmovss	%xmm7, (%rcx,%r15)
	call	rand@PLT
	vxorps	%xmm1, %xmm1, %xmm1
	movq	-88(%rbp), %rsi
	vcvtsi2ssl	%eax, %xmm1, %xmm2
	vmulss	.LC3(%rip), %xmm2, %xmm3
	vmovss	%xmm3, (%rsi,%r15)
	leaq	0(,%r14,4), %r15
	call	rand@PLT
	vxorps	%xmm4, %xmm4, %xmm4
	movq	-96(%rbp), %rdi
	vcvtsi2ssl	%eax, %xmm4, %xmm5
	vmulss	.LC3(%rip), %xmm5, %xmm6
	vmovss	%xmm6, (%rdi,%r15)
	call	rand@PLT
	vxorps	%xmm8, %xmm8, %xmm8
	movq	-88(%rbp), %r9
	vcvtsi2ssl	%eax, %xmm8, %xmm9
	vmulss	.LC3(%rip), %xmm9, %xmm10
	vmovss	%xmm10, (%r9,%r15)
	cmpq	%rbx, %r12
	jne	.L69
.L189:
	movq	-96(%rbp), %r8
	cmpq	$14, %r14
	jbe	.L84
	movq	%r12, %r10
	xorl	%eax, %eax
	vxorps	%xmm12, %xmm12, %xmm12
	shrq	$4, %r10
	salq	$6, %r10
	leaq	-64(%r10), %r14
	shrq	$6, %r14
	incq	%r14
	andl	$7, %r14d
	je	.L71
	cmpq	$1, %r14
	je	.L151
	cmpq	$2, %r14
	je	.L152
	cmpq	$3, %r14
	je	.L153
	cmpq	$4, %r14
	je	.L154
	cmpq	$5, %r14
	je	.L155
	cmpq	$6, %r14
	jne	.L206
.L156:
	vmovups	(%r8,%rax), %zmm14
	vfmadd231ps	(%r9,%rax), %zmm14, %zmm12
	addq	$64, %rax
.L155:
	vmovups	(%r8,%rax), %zmm15
	vfmadd231ps	(%r9,%rax), %zmm15, %zmm12
	addq	$64, %rax
.L154:
	vmovups	(%r8,%rax), %zmm0
	vfmadd231ps	(%r9,%rax), %zmm0, %zmm12
	addq	$64, %rax
.L153:
	vmovups	(%r8,%rax), %zmm7
	vfmadd231ps	(%r9,%rax), %zmm7, %zmm12
	addq	$64, %rax
.L152:
	vmovups	(%r8,%rax), %zmm1
	vfmadd231ps	(%r9,%rax), %zmm1, %zmm12
	addq	$64, %rax
.L151:
	vmovups	(%r8,%rax), %zmm2
	vfmadd231ps	(%r9,%rax), %zmm2, %zmm12
	addq	$64, %rax
	cmpq	%rax, %r10
	je	.L188
.L71:
	vmovups	(%r8,%rax), %zmm3
	vmovups	64(%r8,%rax), %zmm4
	vmovups	128(%r8,%rax), %zmm5
	vfmadd231ps	(%r9,%rax), %zmm3, %zmm12
	vmovups	192(%r8,%rax), %zmm6
	vmovups	256(%r8,%rax), %zmm8
	vmovups	320(%r8,%rax), %zmm9
	vfmadd231ps	64(%r9,%rax), %zmm4, %zmm12
	vmovups	384(%r8,%rax), %zmm10
	vmovups	448(%r8,%rax), %zmm11
	vfmadd231ps	128(%r9,%rax), %zmm5, %zmm12
	vfmadd231ps	192(%r9,%rax), %zmm6, %zmm12
	vfmadd231ps	256(%r9,%rax), %zmm8, %zmm12
	vfmadd231ps	320(%r9,%rax), %zmm9, %zmm12
	vfmadd231ps	384(%r9,%rax), %zmm10, %zmm12
	vfmadd231ps	448(%r9,%rax), %zmm11, %zmm12
	addq	$512, %rax
	cmpq	%rax, %r10
	jne	.L71
.L188:
	vextractf32x8	$0x1, %zmm12, %ymm13
	movq	%rbx, %r11
	vaddps	%ymm12, %ymm13, %ymm11
	andq	$-16, %r11
	vextractf32x4	$0x1, %ymm11, %xmm12
	vaddps	%xmm11, %xmm12, %xmm15
	vmovhlps	%xmm15, %xmm15, %xmm0
	vaddps	%xmm15, %xmm0, %xmm7
	vshufps	$85, %xmm7, %xmm7, %xmm1
	vaddps	%xmm7, %xmm1, %xmm0
	testb	$15, %bl
	je	.L196
.L70:
	movq	%rbx, %rdx
	subq	%r11, %rdx
	leaq	-1(%rdx), %rcx
	cmpq	$6, %rcx
	jbe	.L73
	vmovups	(%r8,%r11,4), %ymm2
	vfmadd231ps	(%r9,%r11,4), %ymm2, %ymm11
	vextractf32x4	$0x1, %ymm11, %xmm3
	vaddps	%xmm11, %xmm3, %xmm4
	movq	%rdx, %rsi
	andq	$-8, %rsi
	vmovhlps	%xmm4, %xmm4, %xmm5
	addq	%rsi, %r11
	andl	$7, %edx
	vaddps	%xmm4, %xmm5, %xmm6
	vshufps	$85, %xmm6, %xmm6, %xmm8
	vaddps	%xmm6, %xmm8, %xmm0
	je	.L196
.L73:
	leaq	1(%r11), %rdi
	vmovss	(%r8,%r11,4), %xmm9
	leaq	0(,%r11,4), %r15
	vfmadd231ss	(%r9,%r11,4), %xmm9, %xmm0
	cmpq	%rbx, %rdi
	jnb	.L196
	leaq	2(%r11), %r10
	vmovss	4(%r8,%r15), %xmm10
	vfmadd231ss	4(%r9,%r15), %xmm10, %xmm0
	cmpq	%rbx, %r10
	jnb	.L196
	leaq	3(%r11), %r14
	vmovss	8(%r8,%r15), %xmm11
	vfmadd231ss	8(%r9,%r15), %xmm11, %xmm0
	cmpq	%rbx, %r14
	jnb	.L196
	leaq	4(%r11), %rax
	vmovss	12(%r8,%r15), %xmm13
	vfmadd231ss	12(%r9,%r15), %xmm13, %xmm0
	cmpq	%rbx, %rax
	jnb	.L196
	leaq	5(%r11), %rdx
	vmovss	16(%r8,%r15), %xmm12
	vfmadd231ss	16(%r9,%r15), %xmm12, %xmm0
	cmpq	%rbx, %rdx
	jnb	.L196
	addq	$6, %r11
	vmovss	20(%r8,%r15), %xmm14
	vfmadd231ss	20(%r9,%r15), %xmm14, %xmm0
	cmpq	%rbx, %r11
	jnb	.L196
	vmovss	24(%r8,%r15), %xmm15
	vfmadd231ss	24(%r9,%r15), %xmm15, %xmm0
	vzeroupper
	jmp	.L68
.L196:
	vzeroupper
.L68:
	leaq	-80(%rbp), %rbx
	movl	$1, %edi
	vmovss	%xmm0, -100(%rbp)
	vmovss	-100(%rbp), %xmm0
	movq	%rbx, %rsi
	call	clock_gettime@PLT
	movq	%rbx, %rsi
	movl	$1, %edi
	vxorpd	%xmm7, %xmm7, %xmm7
	vcvtsi2sdq	-72(%rbp), %xmm7, %xmm1
	vcvtsi2sdq	-80(%rbp), %xmm7, %xmm0
	vmovlpd	%xmm1, -128(%rbp)
	vmovlpd	%xmm0, -120(%rbp)
	call	clock_gettime@PLT
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovsd	.LC4(%rip), %xmm5
	vcvtsi2sdq	-72(%rbp), %xmm2, %xmm3
	vcvtsi2sdq	-80(%rbp), %xmm2, %xmm4
	vfmadd132sd	%xmm5, %xmm4, %xmm3
	vmovsd	-128(%rbp), %xmm6
	vcvtsi2sdq	%r12, %xmm2, %xmm9
	vfmadd213sd	-120(%rbp), %xmm5, %xmm6
	vmulsd	.LC5(%rip), %xmm9, %xmm10
	vsubsd	%xmm6, %xmm3, %xmm8
	vdivsd	%xmm8, %xmm10, %xmm1
	testq	%r12, %r12
	je	.L85
	leaq	-1(%r12), %r8
	movq	-88(%rbp), %r9
	cmpq	$14, %r8
	jbe	.L86
	movq	%r12, %rcx
	movq	%r9, %r15
	vxorpd	%xmm0, %xmm0, %xmm0
	shrq	$4, %rcx
	salq	$6, %rcx
	leaq	(%rcx,%r9), %rsi
	subq	$64, %rcx
	shrq	$6, %rcx
	incq	%rcx
	andl	$7, %ecx
	je	.L77
	cmpq	$1, %rcx
	je	.L157
	cmpq	$2, %rcx
	je	.L158
	cmpq	$3, %rcx
	je	.L159
	cmpq	$4, %rcx
	je	.L160
	cmpq	$5, %rcx
	je	.L161
	cmpq	$6, %rcx
	jne	.L207
.L162:
	vmovups	(%r15), %zmm7
	addq	$64, %r15
	vextractf32x8	$0x1, %zmm7, %ymm2
	vcvtps2pd	%ymm7, %zmm4
	vcvtps2pd	%ymm2, %zmm3
	vaddpd	%zmm4, %zmm3, %zmm5
	vaddpd	%zmm5, %zmm0, %zmm0
.L161:
	vmovups	(%r15), %zmm6
	addq	$64, %r15
	vextractf32x8	$0x1, %zmm6, %ymm9
	vcvtps2pd	%ymm6, %zmm11
	vcvtps2pd	%ymm9, %zmm10
	vaddpd	%zmm11, %zmm10, %zmm13
	vaddpd	%zmm13, %zmm0, %zmm0
.L160:
	vmovups	(%r15), %zmm12
	addq	$64, %r15
	vextractf32x8	$0x1, %zmm12, %ymm14
	vcvtps2pd	%ymm12, %zmm7
	vcvtps2pd	%ymm14, %zmm15
	vaddpd	%zmm7, %zmm15, %zmm2
	vaddpd	%zmm2, %zmm0, %zmm0
.L159:
	vmovups	(%r15), %zmm3
	addq	$64, %r15
	vextractf32x8	$0x1, %zmm3, %ymm4
	vcvtps2pd	%ymm3, %zmm6
	vcvtps2pd	%ymm4, %zmm5
	vaddpd	%zmm6, %zmm5, %zmm9
	vaddpd	%zmm9, %zmm0, %zmm0
.L158:
	vmovups	(%r15), %zmm10
	addq	$64, %r15
	vextractf32x8	$0x1, %zmm10, %ymm11
	vcvtps2pd	%ymm10, %zmm12
	vcvtps2pd	%ymm11, %zmm13
	vaddpd	%zmm12, %zmm13, %zmm14
	vaddpd	%zmm14, %zmm0, %zmm0
.L157:
	vmovups	(%r15), %zmm15
	addq	$64, %r15
	vextractf32x8	$0x1, %zmm15, %ymm7
	vcvtps2pd	%ymm15, %zmm3
	vcvtps2pd	%ymm7, %zmm2
	vaddpd	%zmm3, %zmm2, %zmm4
	vaddpd	%zmm4, %zmm0, %zmm0
	cmpq	%rsi, %r15
	je	.L187
.L77:
	vmovups	(%r15), %zmm5
	vmovups	64(%r15), %zmm12
	vmovups	128(%r15), %zmm4
	addq	$512, %r15
	vextractf32x8	$0x1, %zmm5, %ymm6
	vcvtps2pd	%ymm5, %zmm10
	vcvtps2pd	%ymm6, %zmm9
	vextractf32x8	$0x1, %zmm12, %ymm14
	vcvtps2pd	%ymm14, %zmm15
	vcvtps2pd	%ymm12, %zmm7
	vcvtps2pd	%ymm4, %zmm6
	vaddpd	%zmm10, %zmm9, %zmm11
	vaddpd	%zmm7, %zmm15, %zmm2
	vaddpd	%zmm11, %zmm0, %zmm13
	vmovups	-320(%r15), %zmm11
	vextractf32x8	$0x1, %zmm4, %ymm0
	vcvtps2pd	%ymm0, %zmm5
	vaddpd	%zmm2, %zmm13, %zmm3
	vmovups	-256(%r15), %zmm2
	vextractf32x8	$0x1, %zmm11, %ymm13
	vcvtps2pd	%ymm11, %zmm14
	vaddpd	%zmm6, %zmm5, %zmm9
	vcvtps2pd	%ymm13, %zmm12
	vaddpd	%zmm9, %zmm3, %zmm10
	vmovups	-192(%r15), %zmm9
	vextractf32x8	$0x1, %zmm2, %ymm3
	vcvtps2pd	%ymm3, %zmm0
	vcvtps2pd	%ymm2, %zmm4
	vaddpd	%zmm14, %zmm12, %zmm15
	vcvtps2pd	%ymm9, %zmm13
	vaddpd	%zmm4, %zmm0, %zmm5
	vmovups	-64(%r15), %zmm4
	vaddpd	%zmm15, %zmm10, %zmm7
	vextractf32x8	$0x1, %zmm9, %ymm10
	vmovups	-128(%r15), %zmm15
	vcvtps2pd	%ymm10, %zmm11
	vaddpd	%zmm5, %zmm7, %zmm6
	vcvtps2pd	%ymm4, %zmm10
	vextractf32x8	$0x1, %zmm15, %ymm7
	vcvtps2pd	%ymm7, %zmm2
	vcvtps2pd	%ymm15, %zmm3
	vaddpd	%zmm13, %zmm11, %zmm12
	vaddpd	%zmm12, %zmm6, %zmm14
	vextractf32x8	$0x1, %zmm4, %ymm6
	vcvtps2pd	%ymm6, %zmm9
	vaddpd	%zmm3, %zmm2, %zmm0
	vaddpd	%zmm0, %zmm14, %zmm5
	vaddpd	%zmm10, %zmm9, %zmm11
	vaddpd	%zmm11, %zmm5, %zmm0
	cmpq	%rsi, %r15
	jne	.L77
.L187:
	vextractf64x4	$0x1, %zmm0, %ymm13
	movq	%r12, %r11
	vaddpd	%ymm0, %ymm13, %ymm12
	andq	$-16, %r11
	vextractf64x2	$0x1, %ymm12, %xmm14
	vaddpd	%xmm12, %xmm14, %xmm7
	vmovapd	%ymm12, %ymm11
	vunpckhpd	%xmm7, %xmm7, %xmm2
	vaddpd	%xmm7, %xmm2, %xmm2
	testb	$15, %r12b
	je	.L203
.L76:
	movq	%r12, %rdi
	subq	%r11, %rdi
	leaq	-1(%rdi), %r10
	cmpq	$6, %r10
	jbe	.L79
	vmovups	(%r9,%r11,4), %ymm3
	movq	%rdi, %r14
	andq	$-8, %r14
	addq	%r14, %r11
	andl	$7, %edi
	vcvtps2pd	%xmm3, %ymm0
	vextractf32x4	$0x1, %ymm3, %xmm5
	vcvtps2pd	%xmm5, %ymm4
	vaddpd	%ymm4, %ymm0, %ymm6
	vaddpd	%ymm11, %ymm6, %ymm9
	vextractf64x2	$0x1, %ymm9, %xmm10
	vaddpd	%xmm9, %xmm10, %xmm11
	vunpckhpd	%xmm11, %xmm11, %xmm13
	vaddpd	%xmm11, %xmm13, %xmm2
	je	.L203
.L79:
	leaq	1(%r11), %rdx
	vxorpd	%xmm12, %xmm12, %xmm12
	leaq	0(,%r11,4), %rax
	vcvtss2sd	(%r9,%r11,4), %xmm12, %xmm14
	vaddsd	%xmm14, %xmm2, %xmm2
	cmpq	%r12, %rdx
	jnb	.L203
	leaq	2(%r11), %rbx
	vcvtss2sd	4(%r9,%rax), %xmm12, %xmm15
	vaddsd	%xmm15, %xmm2, %xmm2
	cmpq	%r12, %rbx
	jnb	.L203
	leaq	3(%r11), %r8
	vcvtss2sd	8(%r9,%rax), %xmm12, %xmm7
	vaddsd	%xmm7, %xmm2, %xmm2
	cmpq	%r12, %r8
	jnb	.L203
	leaq	4(%r11), %rcx
	vcvtss2sd	12(%r9,%rax), %xmm12, %xmm3
	vaddsd	%xmm3, %xmm2, %xmm2
	cmpq	%r12, %rcx
	jnb	.L203
	leaq	5(%r11), %rsi
	vcvtss2sd	16(%r9,%rax), %xmm12, %xmm0
	vaddsd	%xmm0, %xmm2, %xmm2
	cmpq	%r12, %rsi
	jnb	.L203
	addq	$6, %r11
	vcvtss2sd	20(%r9,%rax), %xmm12, %xmm5
	vaddsd	%xmm5, %xmm2, %xmm2
	cmpq	%r12, %r11
	jnb	.L203
	vcvtss2sd	24(%r9,%rax), %xmm12, %xmm4
	vaddsd	%xmm4, %xmm2, %xmm2
	vzeroupper
	jmp	.L75
.L203:
	vzeroupper
.L75:
	vmovapd	%xmm8, %xmm0
	movq	%r12, %rsi
	leaq	.LC6(%rip), %rdi
	movl	$3, %eax
	call	printf@PLT
	movq	-96(%rbp), %rdi
	call	free@PLT
	movq	-88(%rbp), %rdi
	call	free@PLT
.L63:
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L208
	subq	$-128, %rsp
	movl	%r13d, %eax
	popq	%rbx
	popq	%r9
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r9), %rsp
	.cfi_def_cfa 7, 8
	ret
.L206:
	.cfi_restore_state
	vmovups	(%r8), %zmm13
	movl	$64, %eax
	vfmadd231ps	(%r9), %zmm13, %zmm12
	jmp	.L156
.L207:
	vmovups	(%r9), %zmm13
	leaq	64(%r9), %r15
	vextractf32x8	$0x1, %zmm13, %ymm12
	vcvtps2pd	%ymm13, %zmm15
	vcvtps2pd	%ymm12, %zmm14
	vaddpd	%zmm15, %zmm14, %zmm0
	jmp	.L162
.L83:
	vxorps	%xmm0, %xmm0, %xmm0
	jmp	.L68
.L85:
	vxorpd	%xmm2, %xmm2, %xmm2
	jmp	.L75
.L84:
	vxorps	%xmm0, %xmm0, %xmm0
	xorl	%r11d, %r11d
	vxorps	%xmm11, %xmm11, %xmm11
	jmp	.L70
.L86:
	xorl	%r11d, %r11d
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm2, %xmm2, %xmm2
	jmp	.L76
.L208:
	call	__stack_chk_fail@PLT
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB14:
.L67:
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	.cfi_escape 0x10,0x6,0x2,0x76,0
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	leaq	.LC2(%rip), %rdi
	movl	$1, %r13d
	call	perror@PLT
	jmp	.L63
	.cfi_endproc
.LFE14:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE7:
	.section	.text.startup
.LHOTE7:
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC3:
	.long	805306368
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC4:
	.long	-400107883
	.long	1041313291
	.align 8
.LC5:
	.long	-400107883
	.long	1042361867
	.ident	"GCC: (GNU) 14.3.0"
	.section	.note.GNU-stack,"",@progbits
