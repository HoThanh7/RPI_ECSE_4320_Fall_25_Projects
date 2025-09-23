	.file	"saxpy.c"
	.text
	.p2align 4
	.globl	saxpy_scalar
	.type	saxpy_scalar, @function
saxpy_scalar:
.LFB12:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rdx, %rdx
	je	.L105
	leaq	-1(%rdx), %rsi
	cmpq	$6, %rsi
	jbe	.L12
	leaq	-4(%rcx), %rax
	subq	%rdi, %rax
	cmpq	$56, %rax
	jbe	.L12
	cmpq	$14, %rsi
	jbe	.L13
	movq	%rdx, %r8
	xorl	%esi, %esi
	vbroadcastss	%xmm0, %zmm1
	shrq	$4, %r8
	salq	$6, %r8
	leaq	-64(%r8), %r9
	shrq	$6, %r9
	incq	%r9
	andl	$7, %r9d
	je	.L5
	cmpq	$1, %r9
	je	.L64
	cmpq	$2, %r9
	je	.L65
	cmpq	$3, %r9
	je	.L66
	cmpq	$4, %r9
	je	.L67
	cmpq	$5, %r9
	je	.L68
	cmpq	$6, %r9
	je	.L69
	vmovups	(%rdi), %zmm2
	movl	$64, %esi
	vfmadd213ps	(%rcx), %zmm1, %zmm2
	vmovups	%zmm2, (%rcx)
.L69:
	vmovups	(%rdi,%rsi), %zmm3
	vfmadd213ps	(%rcx,%rsi), %zmm1, %zmm3
	vmovups	%zmm3, (%rcx,%rsi)
	addq	$64, %rsi
.L68:
	vmovups	(%rdi,%rsi), %zmm4
	vfmadd213ps	(%rcx,%rsi), %zmm1, %zmm4
	vmovups	%zmm4, (%rcx,%rsi)
	addq	$64, %rsi
.L67:
	vmovups	(%rdi,%rsi), %zmm5
	vfmadd213ps	(%rcx,%rsi), %zmm1, %zmm5
	vmovups	%zmm5, (%rcx,%rsi)
	addq	$64, %rsi
.L66:
	vmovups	(%rdi,%rsi), %zmm6
	vfmadd213ps	(%rcx,%rsi), %zmm1, %zmm6
	vmovups	%zmm6, (%rcx,%rsi)
	addq	$64, %rsi
.L65:
	vmovups	(%rdi,%rsi), %zmm7
	vfmadd213ps	(%rcx,%rsi), %zmm1, %zmm7
	vmovups	%zmm7, (%rcx,%rsi)
	addq	$64, %rsi
.L64:
	vmovups	(%rdi,%rsi), %zmm8
	vfmadd213ps	(%rcx,%rsi), %zmm1, %zmm8
	vmovups	%zmm8, (%rcx,%rsi)
	addq	$64, %rsi
	cmpq	%r8, %rsi
	je	.L96
.L5:
	vmovups	(%rdi,%rsi), %zmm9
	vfmadd213ps	(%rcx,%rsi), %zmm1, %zmm9
	vmovups	%zmm9, (%rcx,%rsi)
	vmovups	64(%rdi,%rsi), %zmm10
	vfmadd213ps	64(%rcx,%rsi), %zmm1, %zmm10
	vmovups	%zmm10, 64(%rcx,%rsi)
	vmovups	128(%rdi,%rsi), %zmm11
	vfmadd213ps	128(%rcx,%rsi), %zmm1, %zmm11
	vmovups	%zmm11, 128(%rcx,%rsi)
	vmovups	192(%rdi,%rsi), %zmm12
	vfmadd213ps	192(%rcx,%rsi), %zmm1, %zmm12
	vmovups	%zmm12, 192(%rcx,%rsi)
	vmovups	256(%rdi,%rsi), %zmm13
	vfmadd213ps	256(%rcx,%rsi), %zmm1, %zmm13
	vmovups	%zmm13, 256(%rcx,%rsi)
	vmovups	320(%rdi,%rsi), %zmm14
	vfmadd213ps	320(%rcx,%rsi), %zmm1, %zmm14
	vmovups	%zmm14, 320(%rcx,%rsi)
	vmovups	384(%rdi,%rsi), %zmm15
	vfmadd213ps	384(%rcx,%rsi), %zmm1, %zmm15
	vmovups	%zmm15, 384(%rcx,%rsi)
	vmovups	448(%rdi,%rsi), %zmm2
	vfmadd213ps	448(%rcx,%rsi), %zmm1, %zmm2
	vmovups	%zmm2, 448(%rcx,%rsi)
	addq	$512, %rsi
	cmpq	%r8, %rsi
	jne	.L5
.L96:
	movq	%rdx, %r11
	andq	$-16, %r11
	testb	$15, %dl
	je	.L104
	movq	%rdx, %r10
	subq	%r11, %r10
	leaq	-1(%r10), %rax
	cmpq	$6, %rax
	jbe	.L7
.L4:
	movq	%r10, %rsi
	leaq	0(,%r11,4), %r9
	vbroadcastss	%xmm0, %ymm1
	andq	$-8, %rsi
	leaq	(%rcx,%r9), %r8
	addq	%rsi, %r11
	andl	$7, %r10d
	vmovups	(%r8), %ymm3
	vfmadd132ps	(%rdi,%r9), %ymm3, %ymm1
	vmovups	%ymm1, (%r8)
	je	.L104
.L7:
	leaq	0(,%r11,4), %r10
	leaq	1(%r11), %r9
	leaq	(%rcx,%r10), %rax
	vmovss	(%rdi,%r10), %xmm4
	vfmadd213ss	(%rax), %xmm0, %xmm4
	vmovss	%xmm4, (%rax)
	cmpq	%rdx, %r9
	jnb	.L104
	leaq	4(%rcx,%r10), %r8
	leaq	2(%r11), %rsi
	vmovss	4(%rdi,%r10), %xmm5
	vfmadd213ss	(%r8), %xmm0, %xmm5
	vmovss	%xmm5, (%r8)
	cmpq	%rdx, %rsi
	jnb	.L104
	leaq	8(%rcx,%r10), %rax
	leaq	3(%r11), %r9
	vmovss	8(%rdi,%r10), %xmm6
	vfmadd213ss	(%rax), %xmm0, %xmm6
	vmovss	%xmm6, (%rax)
	cmpq	%rdx, %r9
	jnb	.L104
	leaq	12(%rcx,%r10), %r8
	leaq	4(%r11), %rsi
	vmovss	12(%rdi,%r10), %xmm7
	vfmadd213ss	(%r8), %xmm0, %xmm7
	vmovss	%xmm7, (%r8)
	cmpq	%rdx, %rsi
	jnb	.L104
	leaq	16(%rcx,%r10), %rax
	leaq	5(%r11), %r9
	vmovss	16(%rdi,%r10), %xmm8
	vfmadd213ss	(%rax), %xmm0, %xmm8
	vmovss	%xmm8, (%rax)
	cmpq	%rdx, %r9
	jnb	.L104
	leaq	20(%rcx,%r10), %r8
	addq	$6, %r11
	vmovss	20(%rdi,%r10), %xmm9
	vfmadd213ss	(%r8), %xmm0, %xmm9
	vmovss	%xmm9, (%r8)
	cmpq	%rdx, %r11
	jnb	.L104
	leaq	24(%rcx,%r10), %rdx
	vmovss	(%rdx), %xmm10
	vfmadd132ss	24(%rdi,%r10), %xmm10, %xmm0
	vmovss	%xmm0, (%rdx)
	vzeroupper
	ret
	.p2align 4
	.p2align 3
.L104:
	vzeroupper
.L105:
	ret
	.p2align 4
	.p2align 3
.L12:
	movq	%rdx, %r11
	xorl	%r10d, %r10d
	andl	$7, %r11d
	je	.L9
	cmpq	$1, %r11
	je	.L70
	cmpq	$2, %r11
	je	.L71
	cmpq	$3, %r11
	je	.L72
	cmpq	$4, %r11
	je	.L73
	cmpq	$5, %r11
	je	.L74
	cmpq	$6, %r11
	je	.L75
	vmovss	(%rdi), %xmm11
	movl	$1, %r10d
	vfmadd213ss	(%rcx), %xmm0, %xmm11
	vmovss	%xmm11, (%rcx)
.L75:
	vmovss	(%rdi,%r10,4), %xmm12
	vfmadd213ss	(%rcx,%r10,4), %xmm0, %xmm12
	vmovss	%xmm12, (%rcx,%r10,4)
	incq	%r10
.L74:
	vmovss	(%rdi,%r10,4), %xmm13
	vfmadd213ss	(%rcx,%r10,4), %xmm0, %xmm13
	vmovss	%xmm13, (%rcx,%r10,4)
	incq	%r10
.L73:
	vmovss	(%rdi,%r10,4), %xmm14
	vfmadd213ss	(%rcx,%r10,4), %xmm0, %xmm14
	vmovss	%xmm14, (%rcx,%r10,4)
	incq	%r10
.L72:
	vmovss	(%rdi,%r10,4), %xmm15
	vfmadd213ss	(%rcx,%r10,4), %xmm0, %xmm15
	vmovss	%xmm15, (%rcx,%r10,4)
	incq	%r10
.L71:
	vmovss	(%rdi,%r10,4), %xmm2
	vfmadd213ss	(%rcx,%r10,4), %xmm0, %xmm2
	vmovss	%xmm2, (%rcx,%r10,4)
	incq	%r10
.L70:
	vmovss	(%rdi,%r10,4), %xmm1
	vfmadd213ss	(%rcx,%r10,4), %xmm0, %xmm1
	vmovss	%xmm1, (%rcx,%r10,4)
	incq	%r10
	cmpq	%r10, %rdx
	je	.L107
.L9:
	vmovss	(%rdi,%r10,4), %xmm3
	vfmadd213ss	(%rcx,%r10,4), %xmm0, %xmm3
	vmovss	%xmm3, (%rcx,%r10,4)
	vmovss	4(%rdi,%r10,4), %xmm4
	vfmadd213ss	4(%rcx,%r10,4), %xmm0, %xmm4
	vmovss	%xmm4, 4(%rcx,%r10,4)
	vmovss	8(%rdi,%r10,4), %xmm5
	vfmadd213ss	8(%rcx,%r10,4), %xmm0, %xmm5
	vmovss	%xmm5, 8(%rcx,%r10,4)
	vmovss	12(%rdi,%r10,4), %xmm6
	vfmadd213ss	12(%rcx,%r10,4), %xmm0, %xmm6
	vmovss	%xmm6, 12(%rcx,%r10,4)
	vmovss	16(%rdi,%r10,4), %xmm7
	vfmadd213ss	16(%rcx,%r10,4), %xmm0, %xmm7
	vmovss	%xmm7, 16(%rcx,%r10,4)
	vmovss	20(%rdi,%r10,4), %xmm8
	vfmadd213ss	20(%rcx,%r10,4), %xmm0, %xmm8
	vmovss	%xmm8, 20(%rcx,%r10,4)
	vmovss	24(%rdi,%r10,4), %xmm9
	vfmadd213ss	24(%rcx,%r10,4), %xmm0, %xmm9
	vmovss	%xmm9, 24(%rcx,%r10,4)
	vmovss	28(%rdi,%r10,4), %xmm10
	vfmadd213ss	28(%rcx,%r10,4), %xmm0, %xmm10
	vmovss	%xmm10, 28(%rcx,%r10,4)
	addq	$8, %r10
	cmpq	%r10, %rdx
	jne	.L9
	ret
.L13:
	movq	%rdx, %r10
	xorl	%r11d, %r11d
	jmp	.L4
.L107:
	ret
	.cfi_endproc
.LFE12:
	.size	saxpy_scalar, .-saxpy_scalar
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"posix_memalign failed"
.LC8:
	.string	"saxpy,%zu,%.9f,%.6f,%.6e\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB9:
	.section	.text.startup,"ax",@progbits
.LHOTB9:
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
	subq	$64, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L109
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtoull@PLT
	movq	%rax, %r12
.L109:
	leaq	0(,%r12,4), %rbx
	leaq	-96(%rbp), %rdi
	movl	$64, %esi
	movq	$0, -96(%rbp)
	movq	%rbx, %rdx
	movq	$0, -88(%rbp)
	call	posix_memalign@PLT
	testl	%eax, %eax
	jne	.L112
	leaq	-88(%rbp), %rdi
	movq	%rbx, %rdx
	movl	$64, %esi
	call	posix_memalign@PLT
	movl	%eax, %r13d
	testl	%eax, %eax
	jne	.L112
	movl	$42, %edi
	call	srand@PLT
	testq	%r12, %r12
	je	.L113
	movq	%r12, %rax
	xorl	%ebx, %ebx
	andl	$3, %eax
	je	.L114
	cmpq	$1, %rax
	je	.L278
	cmpq	$2, %rax
	je	.L279
	call	rand@PLT
	vxorps	%xmm7, %xmm7, %xmm7
	movq	-96(%rbp), %rdx
	vcvtsi2ssl	%eax, %xmm7, %xmm6
	vmulss	.LC2(%rip), %xmm6, %xmm8
	vmovss	%xmm8, (%rdx,%rbx)
	call	rand@PLT
	vxorps	%xmm9, %xmm9, %xmm9
	movq	-88(%rbp), %rcx
	vcvtsi2ssl	%eax, %xmm9, %xmm10
	vmulss	.LC2(%rip), %xmm10, %xmm11
	vmovss	%xmm11, (%rcx,%rbx)
	movl	$1, %ebx
.L279:
	call	rand@PLT
	vxorps	%xmm12, %xmm12, %xmm12
	movq	-96(%rbp), %rsi
	leaq	0(,%rbx,4), %r15
	vcvtsi2ssl	%eax, %xmm12, %xmm13
	vmulss	.LC2(%rip), %xmm13, %xmm14
	incq	%rbx
	vmovss	%xmm14, (%rsi,%r15)
	call	rand@PLT
	vxorps	%xmm15, %xmm15, %xmm15
	movq	-88(%rbp), %rdi
	vcvtsi2ssl	%eax, %xmm15, %xmm4
	vmulss	.LC2(%rip), %xmm4, %xmm1
	vmovss	%xmm1, (%rdi,%r15)
.L278:
	call	rand@PLT
	vxorps	%xmm0, %xmm0, %xmm0
	movq	-96(%rbp), %r8
	leaq	0(,%rbx,4), %r14
	vcvtsi2ssl	%eax, %xmm0, %xmm2
	vmulss	.LC2(%rip), %xmm2, %xmm3
	vmovss	%xmm3, (%r8,%r14)
	call	rand@PLT
	vxorps	%xmm5, %xmm5, %xmm5
	movq	-88(%rbp), %r9
	vcvtsi2ssl	%eax, %xmm5, %xmm7
	vmulss	.LC2(%rip), %xmm7, %xmm6
	vmovss	%xmm6, (%r9,%r14)
	movq	%rbx, %r14
	incq	%rbx
	cmpq	%rbx, %r12
	je	.L365
.L114:
	call	rand@PLT
	vxorps	%xmm8, %xmm8, %xmm8
	movq	-96(%rbp), %r11
	leaq	0(,%rbx,4), %r15
	vcvtsi2ssl	%eax, %xmm8, %xmm9
	vmulss	.LC2(%rip), %xmm9, %xmm10
	leaq	1(%rbx), %r14
	salq	$2, %r14
	vmovss	%xmm10, (%r11,%r15)
	call	rand@PLT
	vxorps	%xmm11, %xmm11, %xmm11
	movq	-88(%rbp), %r10
	vcvtsi2ssl	%eax, %xmm11, %xmm12
	vmulss	.LC2(%rip), %xmm12, %xmm13
	vmovss	%xmm13, (%r10,%r15)
	leaq	2(%rbx), %r15
	call	rand@PLT
	vxorps	%xmm14, %xmm14, %xmm14
	vcvtsi2ssl	%eax, %xmm14, %xmm15
	vmulss	.LC2(%rip), %xmm15, %xmm4
	movq	-96(%rbp), %rax
	salq	$2, %r15
	vmovss	%xmm4, (%rax,%r14)
	call	rand@PLT
	vxorps	%xmm1, %xmm1, %xmm1
	movq	-88(%rbp), %rdx
	vcvtsi2ssl	%eax, %xmm1, %xmm0
	vmulss	.LC2(%rip), %xmm0, %xmm2
	vmovss	%xmm2, (%rdx,%r14)
	leaq	3(%rbx), %r14
	addq	$4, %rbx
	call	rand@PLT
	vxorps	%xmm3, %xmm3, %xmm3
	movq	-96(%rbp), %rcx
	vcvtsi2ssl	%eax, %xmm3, %xmm5
	vmulss	.LC2(%rip), %xmm5, %xmm7
	vmovss	%xmm7, (%rcx,%r15)
	call	rand@PLT
	vxorps	%xmm6, %xmm6, %xmm6
	movq	-88(%rbp), %rsi
	vcvtsi2ssl	%eax, %xmm6, %xmm8
	vmulss	.LC2(%rip), %xmm8, %xmm9
	vmovss	%xmm9, (%rsi,%r15)
	leaq	0(,%r14,4), %r15
	call	rand@PLT
	vxorps	%xmm10, %xmm10, %xmm10
	movq	-96(%rbp), %rdi
	vcvtsi2ssl	%eax, %xmm10, %xmm11
	vmulss	.LC2(%rip), %xmm11, %xmm12
	vmovss	%xmm12, (%rdi,%r15)
	call	rand@PLT
	vxorps	%xmm13, %xmm13, %xmm13
	movq	-88(%rbp), %r9
	vcvtsi2ssl	%eax, %xmm13, %xmm14
	vmulss	.LC2(%rip), %xmm14, %xmm15
	vmovss	%xmm15, (%r9,%r15)
	cmpq	%rbx, %r12
	jne	.L114
.L365:
	movq	-96(%rbp), %r8
	cmpq	$6, %r14
	jbe	.L143
	leaq	-4(%r9), %r11
	subq	%r8, %r11
	cmpq	$56, %r11
	jbe	.L143
	cmpq	$14, %r14
	jbe	.L144
	movq	%r12, %rdx
	xorl	%esi, %esi
	vbroadcastss	.LC5(%rip), %zmm4
	shrq	$4, %rdx
	salq	$6, %rdx
	leaq	-64(%rdx), %rcx
	shrq	$6, %rcx
	incq	%rcx
	andl	$7, %ecx
	je	.L119
	cmpq	$1, %rcx
	je	.L280
	cmpq	$2, %rcx
	je	.L281
	cmpq	$3, %rcx
	je	.L282
	cmpq	$4, %rcx
	je	.L283
	cmpq	$5, %rcx
	je	.L284
	cmpq	$6, %rcx
	je	.L285
	vmovups	(%r8), %zmm1
	movl	$64, %esi
	vfmadd213ps	(%r9), %zmm4, %zmm1
	vmovups	%zmm1, (%r9)
.L285:
	vmovups	(%r8,%rsi), %zmm0
	vfmadd213ps	(%r9,%rsi), %zmm4, %zmm0
	vmovups	%zmm0, (%r9,%rsi)
	addq	$64, %rsi
.L284:
	vmovups	(%r8,%rsi), %zmm2
	vfmadd213ps	(%r9,%rsi), %zmm4, %zmm2
	vmovups	%zmm2, (%r9,%rsi)
	addq	$64, %rsi
.L283:
	vmovups	(%r8,%rsi), %zmm3
	vfmadd213ps	(%r9,%rsi), %zmm4, %zmm3
	vmovups	%zmm3, (%r9,%rsi)
	addq	$64, %rsi
.L282:
	vmovups	(%r8,%rsi), %zmm5
	vfmadd213ps	(%r9,%rsi), %zmm4, %zmm5
	vmovups	%zmm5, (%r9,%rsi)
	addq	$64, %rsi
.L281:
	vmovups	(%r8,%rsi), %zmm7
	vfmadd213ps	(%r9,%rsi), %zmm4, %zmm7
	vmovups	%zmm7, (%r9,%rsi)
	addq	$64, %rsi
.L280:
	vmovups	(%r8,%rsi), %zmm6
	vfmadd213ps	(%r9,%rsi), %zmm4, %zmm6
	vmovups	%zmm6, (%r9,%rsi)
	addq	$64, %rsi
	cmpq	%rdx, %rsi
	je	.L364
.L119:
	vmovups	(%r8,%rsi), %zmm8
	vfmadd213ps	(%r9,%rsi), %zmm4, %zmm8
	vmovups	%zmm8, (%r9,%rsi)
	vmovups	64(%r8,%rsi), %zmm9
	vfmadd213ps	64(%r9,%rsi), %zmm4, %zmm9
	vmovups	%zmm9, 64(%r9,%rsi)
	vmovups	128(%r8,%rsi), %zmm10
	vfmadd213ps	128(%r9,%rsi), %zmm4, %zmm10
	vmovups	%zmm10, 128(%r9,%rsi)
	vmovups	192(%r8,%rsi), %zmm11
	vfmadd213ps	192(%r9,%rsi), %zmm4, %zmm11
	vmovups	%zmm11, 192(%r9,%rsi)
	vmovups	256(%r8,%rsi), %zmm12
	vfmadd213ps	256(%r9,%rsi), %zmm4, %zmm12
	vmovups	%zmm12, 256(%r9,%rsi)
	vmovups	320(%r8,%rsi), %zmm13
	vfmadd213ps	320(%r9,%rsi), %zmm4, %zmm13
	vmovups	%zmm13, 320(%r9,%rsi)
	vmovups	384(%r8,%rsi), %zmm14
	vfmadd213ps	384(%r9,%rsi), %zmm4, %zmm14
	vmovups	%zmm14, 384(%r9,%rsi)
	vmovups	448(%r8,%rsi), %zmm15
	vfmadd213ps	448(%r9,%rsi), %zmm4, %zmm15
	vmovups	%zmm15, 448(%r9,%rsi)
	addq	$512, %rsi
	cmpq	%rdx, %rsi
	jne	.L119
.L364:
	movq	%rbx, %rax
	andq	$-16, %rax
	testb	$15, %bl
	je	.L120
	movq	%rbx, %r10
	subq	%rax, %r10
	leaq	-1(%r10), %r15
	cmpq	$6, %r15
	jbe	.L121
.L118:
	leaq	(%r9,%rax,4), %rdi
	vmovups	(%r8,%rax,4), %ymm4
	movq	%r10, %r11
	vmovups	(%rdi), %ymm1
	andq	$-8, %r11
	addq	%r11, %rax
	andb	$7, %r10b
	vfmadd132ps	.LC5(%rip){1to8}, %ymm1, %ymm4
	vmovups	%ymm4, (%rdi)
	je	.L120
.L121:
	leaq	0(,%rax,4), %r10
	leaq	1(%rax), %rcx
	vmovss	(%r8,%rax,4), %xmm2
	vmovss	.LC5(%rip), %xmm0
	leaq	(%r9,%r10), %rdx
	vfmadd213ss	(%rdx), %xmm0, %xmm2
	vmovss	%xmm2, (%rdx)
	cmpq	%rbx, %rcx
	jnb	.L120
	leaq	4(%r9,%r10), %rsi
	leaq	2(%rax), %r15
	vmovss	4(%r8,%r10), %xmm3
	vfmadd213ss	(%rsi), %xmm0, %xmm3
	vmovss	%xmm3, (%rsi)
	cmpq	%rbx, %r15
	jnb	.L120
	leaq	8(%r9,%r10), %rdi
	leaq	3(%rax), %r11
	vmovss	8(%r8,%r10), %xmm5
	vfmadd213ss	(%rdi), %xmm0, %xmm5
	vmovss	%xmm5, (%rdi)
	cmpq	%rbx, %r11
	jnb	.L120
	leaq	12(%r9,%r10), %rdx
	leaq	4(%rax), %rcx
	vmovss	12(%r8,%r10), %xmm7
	vfmadd213ss	(%rdx), %xmm0, %xmm7
	vmovss	%xmm7, (%rdx)
	cmpq	%rbx, %rcx
	jnb	.L120
	leaq	16(%r9,%r10), %rsi
	leaq	5(%rax), %r15
	vmovss	16(%r8,%r10), %xmm6
	vfmadd213ss	(%rsi), %xmm0, %xmm6
	vmovss	%xmm6, (%rsi)
	cmpq	%rbx, %r15
	jnb	.L120
	leaq	20(%r9,%r10), %rdi
	addq	$6, %rax
	vmovss	20(%r8,%r10), %xmm8
	vfmadd213ss	(%rdi), %xmm0, %xmm8
	vmovss	%xmm8, (%rdi)
	cmpq	%rbx, %rax
	jnb	.L120
	leaq	24(%r9,%r10), %r9
	vmovss	(%r9), %xmm9
	vfmadd132ss	24(%r8,%r10), %xmm9, %xmm0
	vmovss	%xmm0, (%r9)
.L120:
	leaq	-80(%rbp), %r15
	movl	$1, %edi
	vzeroupper
	movq	%r15, %rsi
	call	clock_gettime@PLT
	movq	-88(%rbp), %r8
	movq	-96(%rbp), %r10
	vxorpd	%xmm10, %xmm10, %xmm10
	vmovsd	.LC3(%rip), %xmm13
	vcvtsi2sdq	-72(%rbp), %xmm10, %xmm11
	vcvtsi2sdq	-80(%rbp), %xmm10, %xmm12
	vfmadd132sd	%xmm13, %xmm12, %xmm11
	vmovsd	%xmm11, -104(%rbp)
.L125:
	leaq	-4(%r8), %rsi
	vmovss	.LC5(%rip), %xmm0
	subq	%r10, %rsi
	cmpq	$56, %rsi
	jbe	.L126
	cmpq	$14, %r14
	jbe	.L145
	movq	%rbx, %rdi
	xorl	%r9d, %r9d
	vbroadcastss	.LC5(%rip), %zmm0
	shrq	$4, %rdi
	salq	$6, %rdi
	leaq	-64(%rdi), %rsi
	shrq	$6, %rsi
	incq	%rsi
	andl	$7, %esi
	je	.L128
	cmpq	$1, %rsi
	je	.L292
	cmpq	$2, %rsi
	je	.L293
	cmpq	$3, %rsi
	je	.L294
	cmpq	$4, %rsi
	je	.L295
	cmpq	$5, %rsi
	je	.L296
	cmpq	$6, %rsi
	je	.L297
	vmovups	(%r10), %zmm2
	movl	$64, %r9d
	vfmadd213ps	(%r8), %zmm0, %zmm2
	vmovups	%zmm2, (%r8)
.L297:
	vmovups	(%r10,%r9), %zmm3
	vfmadd213ps	(%r8,%r9), %zmm0, %zmm3
	vmovups	%zmm3, (%r8,%r9)
	addq	$64, %r9
.L296:
	vmovups	(%r10,%r9), %zmm5
	vfmadd213ps	(%r8,%r9), %zmm0, %zmm5
	vmovups	%zmm5, (%r8,%r9)
	addq	$64, %r9
.L295:
	vmovups	(%r10,%r9), %zmm7
	vfmadd213ps	(%r8,%r9), %zmm0, %zmm7
	vmovups	%zmm7, (%r8,%r9)
	addq	$64, %r9
.L294:
	vmovups	(%r10,%r9), %zmm6
	vfmadd213ps	(%r8,%r9), %zmm0, %zmm6
	vmovups	%zmm6, (%r8,%r9)
	addq	$64, %r9
.L293:
	vmovups	(%r10,%r9), %zmm8
	vfmadd213ps	(%r8,%r9), %zmm0, %zmm8
	vmovups	%zmm8, (%r8,%r9)
	addq	$64, %r9
.L292:
	vmovups	(%r10,%r9), %zmm9
	vfmadd213ps	(%r8,%r9), %zmm0, %zmm9
	vmovups	%zmm9, (%r8,%r9)
	addq	$64, %r9
	cmpq	%r9, %rdi
	je	.L362
.L128:
	vmovups	(%r10,%r9), %zmm10
	vfmadd213ps	(%r8,%r9), %zmm0, %zmm10
	vmovups	%zmm10, (%r8,%r9)
	vmovups	64(%r10,%r9), %zmm11
	vfmadd213ps	64(%r8,%r9), %zmm0, %zmm11
	vmovups	%zmm11, 64(%r8,%r9)
	vmovups	128(%r10,%r9), %zmm12
	vfmadd213ps	128(%r8,%r9), %zmm0, %zmm12
	vmovups	%zmm12, 128(%r8,%r9)
	vmovups	192(%r10,%r9), %zmm14
	vfmadd213ps	192(%r8,%r9), %zmm0, %zmm14
	vmovups	%zmm14, 192(%r8,%r9)
	vmovups	256(%r10,%r9), %zmm15
	vfmadd213ps	256(%r8,%r9), %zmm0, %zmm15
	vmovups	%zmm15, 256(%r8,%r9)
	vmovups	320(%r10,%r9), %zmm4
	vfmadd213ps	320(%r8,%r9), %zmm0, %zmm4
	vmovups	%zmm4, 320(%r8,%r9)
	vmovups	384(%r10,%r9), %zmm1
	vfmadd213ps	384(%r8,%r9), %zmm0, %zmm1
	vmovups	%zmm1, 384(%r8,%r9)
	vmovups	448(%r10,%r9), %zmm2
	vfmadd213ps	448(%r8,%r9), %zmm0, %zmm2
	vmovups	%zmm2, 448(%r8,%r9)
	addq	$512, %r9
	cmpq	%r9, %rdi
	jne	.L128
.L362:
	movq	%rbx, %rcx
	andq	$-16, %rcx
	testb	$15, %bl
	je	.L129
	movq	%rbx, %rdx
	subq	%rcx, %rdx
	leaq	-1(%rdx), %r11
	cmpq	$6, %r11
	jbe	.L130
.L127:
	leaq	(%r8,%rcx,4), %rax
	vmovups	(%r10,%rcx,4), %ymm9
	movq	%rdx, %rdi
	vmovups	(%rax), %ymm10
	andq	$-8, %rdi
	addq	%rdi, %rcx
	andb	$7, %dl
	vfmadd132ps	.LC5(%rip){1to8}, %ymm10, %ymm9
	vmovups	%ymm9, (%rax)
	je	.L372
.L130:
	leaq	0(,%rcx,4), %rdx
	leaq	1(%rcx), %r9
	vmovss	(%r10,%rcx,4), %xmm12
	vmovss	.LC5(%rip), %xmm11
	leaq	(%r8,%rdx), %rsi
	vfmadd213ss	(%rsi), %xmm11, %xmm12
	vmovss	%xmm12, (%rsi)
	cmpq	%rbx, %r9
	jnb	.L372
	leaq	4(%r8,%rdx), %r11
	leaq	2(%rcx), %rax
	vmovss	4(%r10,%rdx), %xmm14
	vfmadd213ss	(%r11), %xmm11, %xmm14
	vmovss	%xmm14, (%r11)
	cmpq	%rbx, %rax
	jnb	.L372
	leaq	8(%r8,%rdx), %rdi
	leaq	3(%rcx), %rsi
	vmovss	8(%r10,%rdx), %xmm15
	vfmadd213ss	(%rdi), %xmm11, %xmm15
	vmovss	%xmm15, (%rdi)
	cmpq	%rbx, %rsi
	jnb	.L372
	leaq	12(%r8,%rdx), %r9
	leaq	4(%rcx), %r11
	vmovss	12(%r10,%rdx), %xmm4
	vfmadd213ss	(%r9), %xmm11, %xmm4
	vmovss	%xmm4, (%r9)
	cmpq	%rbx, %r11
	jnb	.L372
	leaq	16(%r8,%rdx), %rax
	leaq	5(%rcx), %rdi
	vmovss	16(%r10,%rdx), %xmm1
	vfmadd213ss	(%rax), %xmm11, %xmm1
	vmovss	%xmm1, (%rax)
	cmpq	%rbx, %rdi
	jnb	.L372
	leaq	20(%r8,%rdx), %rsi
	addq	$6, %rcx
	vmovss	20(%r10,%rdx), %xmm2
	vfmadd213ss	(%rsi), %xmm11, %xmm2
	vmovss	%xmm2, (%rsi)
	cmpq	%rbx, %rcx
	jnb	.L372
	leaq	24(%r8,%rdx), %r8
	vmovss	(%r8), %xmm0
	vfmadd132ss	24(%r10,%rdx), %xmm0, %xmm11
	vmovss	%xmm11, (%r8)
	vzeroupper
.L133:
	movq	%r15, %rsi
	movl	$1, %edi
	vmovsd	%xmm13, -112(%rbp)
	call	clock_gettime@PLT
	vxorpd	%xmm13, %xmm13, %xmm13
	vmovsd	-112(%rbp), %xmm8
	vcvtsi2sdq	-72(%rbp), %xmm13, %xmm3
	vcvtsi2sdq	-80(%rbp), %xmm13, %xmm5
	vcvtsi2sdq	%rbx, %xmm13, %xmm7
	vfmadd132sd	%xmm8, %xmm5, %xmm3
	vmulsd	.LC7(%rip), %xmm7, %xmm6
	vsubsd	-104(%rbp), %xmm3, %xmm8
	movq	-88(%rbp), %r15
	vdivsd	%xmm8, %xmm6, %xmm1
	cmpq	$14, %r14
	jbe	.L146
.L139:
	movq	%rbx, %r10
	movq	%r15, %rdx
	vxorpd	%xmm0, %xmm0, %xmm0
	shrq	$4, %r10
	salq	$6, %r10
	leaq	(%r10,%r15), %rcx
	subq	$64, %r10
	shrq	$6, %r10
	incq	%r10
	andl	$7, %r10d
	je	.L135
	cmpq	$1, %r10
	je	.L304
	cmpq	$2, %r10
	je	.L305
	cmpq	$3, %r10
	je	.L306
	cmpq	$4, %r10
	je	.L307
	cmpq	$5, %r10
	je	.L308
	cmpq	$6, %r10
	jne	.L382
.L309:
	vmovups	(%rdx), %zmm15
	addq	$64, %rdx
	vextractf32x8	$0x1, %zmm15, %ymm4
	vcvtps2pd	%ymm15, %zmm13
	vcvtps2pd	%ymm4, %zmm2
	vaddpd	%zmm13, %zmm2, %zmm3
	vaddpd	%zmm3, %zmm0, %zmm0
.L308:
	vmovups	(%rdx), %zmm5
	addq	$64, %rdx
	vextractf32x8	$0x1, %zmm5, %ymm7
	vcvtps2pd	%ymm5, %zmm9
	vcvtps2pd	%ymm7, %zmm6
	vaddpd	%zmm9, %zmm6, %zmm10
	vaddpd	%zmm10, %zmm0, %zmm0
.L307:
	vmovups	(%rdx), %zmm11
	addq	$64, %rdx
	vextractf32x8	$0x1, %zmm11, %ymm12
	vcvtps2pd	%ymm11, %zmm15
	vcvtps2pd	%ymm12, %zmm14
	vaddpd	%zmm15, %zmm14, %zmm4
	vaddpd	%zmm4, %zmm0, %zmm0
.L306:
	vmovups	(%rdx), %zmm13
	addq	$64, %rdx
	vextractf32x8	$0x1, %zmm13, %ymm2
	vcvtps2pd	%ymm13, %zmm3
	vcvtps2pd	%ymm2, %zmm5
	vaddpd	%zmm3, %zmm5, %zmm7
	vaddpd	%zmm7, %zmm0, %zmm0
.L305:
	vmovups	(%rdx), %zmm6
	addq	$64, %rdx
	vextractf32x8	$0x1, %zmm6, %ymm9
	vcvtps2pd	%ymm6, %zmm11
	vcvtps2pd	%ymm9, %zmm10
	vaddpd	%zmm11, %zmm10, %zmm12
	vaddpd	%zmm12, %zmm0, %zmm0
.L304:
	vmovups	(%rdx), %zmm14
	addq	$64, %rdx
	vextractf32x8	$0x1, %zmm14, %ymm15
	vcvtps2pd	%ymm14, %zmm13
	vcvtps2pd	%ymm15, %zmm4
	vaddpd	%zmm13, %zmm4, %zmm2
	vaddpd	%zmm2, %zmm0, %zmm0
	cmpq	%rdx, %rcx
	je	.L361
.L135:
	vmovups	(%rdx), %zmm5
	vmovups	64(%rdx), %zmm11
	vmovups	128(%rdx), %zmm2
	addq	$512, %rdx
	vextractf32x8	$0x1, %zmm5, %ymm3
	vcvtps2pd	%ymm5, %zmm6
	vcvtps2pd	%ymm3, %zmm7
	vextractf32x8	$0x1, %zmm11, %ymm12
	vcvtps2pd	%ymm12, %zmm14
	vcvtps2pd	%ymm11, %zmm15
	vcvtps2pd	%ymm2, %zmm3
	vaddpd	%zmm6, %zmm7, %zmm9
	vaddpd	%zmm15, %zmm14, %zmm4
	vaddpd	%zmm9, %zmm0, %zmm10
	vmovups	-320(%rdx), %zmm9
	vextractf32x8	$0x1, %zmm2, %ymm0
	vcvtps2pd	%ymm0, %zmm5
	vaddpd	%zmm4, %zmm10, %zmm13
	vmovups	-256(%rdx), %zmm4
	vextractf32x8	$0x1, %zmm9, %ymm10
	vcvtps2pd	%ymm9, %zmm12
	vaddpd	%zmm3, %zmm5, %zmm7
	vmovups	-192(%rdx), %zmm3
	vcvtps2pd	%ymm10, %zmm11
	vaddpd	%zmm7, %zmm13, %zmm6
	vextractf32x8	$0x1, %zmm4, %ymm13
	vcvtps2pd	%ymm13, %zmm2
	vcvtps2pd	%ymm4, %zmm0
	vcvtps2pd	%ymm3, %zmm10
	vaddpd	%zmm12, %zmm11, %zmm14
	vaddpd	%zmm0, %zmm2, %zmm5
	vaddpd	%zmm14, %zmm6, %zmm15
	vextractf32x8	$0x1, %zmm3, %ymm6
	vmovups	-128(%rdx), %zmm14
	vcvtps2pd	%ymm6, %zmm9
	vaddpd	%zmm5, %zmm15, %zmm7
	vextractf32x8	$0x1, %zmm14, %ymm15
	vcvtps2pd	%ymm14, %zmm13
	vaddpd	%zmm10, %zmm9, %zmm11
	vcvtps2pd	%ymm15, %zmm4
	vaddpd	%zmm11, %zmm7, %zmm12
	vmovups	-64(%rdx), %zmm7
	vaddpd	%zmm13, %zmm4, %zmm2
	vextractf32x8	$0x1, %zmm7, %ymm0
	vcvtps2pd	%ymm7, %zmm3
	vaddpd	%zmm2, %zmm12, %zmm5
	vcvtps2pd	%ymm0, %zmm6
	vaddpd	%zmm3, %zmm6, %zmm9
	vaddpd	%zmm9, %zmm5, %zmm0
	cmpq	%rdx, %rcx
	jne	.L135
.L361:
	vextractf64x4	$0x1, %zmm0, %ymm10
	movq	%rbx, %r14
	vaddpd	%ymm0, %ymm10, %ymm11
	andq	$-16, %r14
	vextractf64x2	$0x1, %ymm11, %xmm12
	vaddpd	%xmm11, %xmm12, %xmm15
	vmovapd	%ymm11, %ymm9
	vunpckhpd	%xmm15, %xmm15, %xmm4
	vaddpd	%xmm15, %xmm4, %xmm2
	testb	$15, %bl
	je	.L379
.L134:
	movq	%rbx, %r9
	subq	%r14, %r9
	leaq	-1(%r9), %r11
	cmpq	$6, %r11
	jbe	.L137
	vmovups	(%r15,%r14,4), %ymm13
	movq	%r9, %rax
	andq	$-8, %rax
	addq	%rax, %r14
	andl	$7, %r9d
	vextractf32x4	$0x1, %ymm13, %xmm2
	vcvtps2pd	%xmm13, %ymm5
	vcvtps2pd	%xmm2, %ymm7
	vaddpd	%ymm7, %ymm5, %ymm0
	vaddpd	%ymm9, %ymm0, %ymm6
	vextractf64x2	$0x1, %ymm6, %xmm3
	vaddpd	%xmm6, %xmm3, %xmm9
	vunpckhpd	%xmm9, %xmm9, %xmm10
	vaddpd	%xmm9, %xmm10, %xmm2
	je	.L379
.L137:
	leaq	1(%r14), %rsi
	vxorpd	%xmm11, %xmm11, %xmm11
	leaq	0(,%r14,4), %rdi
	vcvtss2sd	(%r15,%r14,4), %xmm11, %xmm12
	vaddsd	%xmm12, %xmm2, %xmm2
	cmpq	%rbx, %rsi
	jnb	.L379
	leaq	2(%r14), %r8
	vcvtss2sd	4(%r15,%rdi), %xmm11, %xmm14
	vaddsd	%xmm14, %xmm2, %xmm2
	cmpq	%rbx, %r8
	jnb	.L379
	leaq	3(%r14), %r10
	vcvtss2sd	8(%r15,%rdi), %xmm11, %xmm15
	vaddsd	%xmm15, %xmm2, %xmm2
	cmpq	%rbx, %r10
	jnb	.L379
	leaq	4(%r14), %rcx
	vcvtss2sd	12(%r15,%rdi), %xmm11, %xmm4
	vaddsd	%xmm4, %xmm2, %xmm2
	cmpq	%rbx, %rcx
	jnb	.L379
	leaq	5(%r14), %rdx
	vcvtss2sd	16(%r15,%rdi), %xmm11, %xmm13
	vaddsd	%xmm13, %xmm2, %xmm2
	cmpq	%rbx, %rdx
	jnb	.L379
	addq	$6, %r14
	vcvtss2sd	20(%r15,%rdi), %xmm11, %xmm5
	vaddsd	%xmm5, %xmm2, %xmm2
	cmpq	%rbx, %r14
	jnb	.L379
	vcvtss2sd	24(%r15,%rdi), %xmm11, %xmm7
	vaddsd	%xmm7, %xmm2, %xmm2
	vzeroupper
.L116:
	vmovapd	%xmm8, %xmm0
	movq	%r12, %rsi
	leaq	.LC8(%rip), %rdi
	movl	$3, %eax
	call	printf@PLT
	movq	-96(%rbp), %rdi
	call	free@PLT
	movq	-88(%rbp), %rdi
	call	free@PLT
.L108:
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L383
	addq	$64, %rsp
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
.L372:
	.cfi_restore_state
	vzeroupper
	jmp	.L133
.L379:
	vzeroupper
	jmp	.L116
.L382:
	vmovups	(%r15), %zmm10
	leaq	64(%r15), %rdx
	vextractf32x8	$0x1, %zmm10, %ymm11
	vcvtps2pd	%ymm10, %zmm14
	vcvtps2pd	%ymm11, %zmm12
	vaddpd	%zmm14, %zmm12, %zmm0
	jmp	.L309
.L143:
	leaq	1(%r14), %r11
	xorl	%eax, %eax
	vmovss	.LC5(%rip), %xmm14
	andl	$7, %r11d
	je	.L123
	cmpq	$1, %r11
	je	.L286
	cmpq	$2, %r11
	je	.L287
	cmpq	$3, %r11
	je	.L288
	cmpq	$4, %r11
	je	.L289
	cmpq	$5, %r11
	je	.L290
	cmpq	$6, %r11
	je	.L291
	vmovss	(%r8), %xmm15
	movl	$1, %eax
	vfmadd213ss	(%r9), %xmm14, %xmm15
	vmovss	%xmm15, (%r9)
.L291:
	vmovss	(%r8,%rax,4), %xmm4
	vfmadd213ss	(%r9,%rax,4), %xmm14, %xmm4
	vmovss	%xmm4, (%r9,%rax,4)
	incq	%rax
.L290:
	vmovss	(%r8,%rax,4), %xmm1
	vfmadd213ss	(%r9,%rax,4), %xmm14, %xmm1
	vmovss	%xmm1, (%r9,%rax,4)
	incq	%rax
.L289:
	vmovss	(%r8,%rax,4), %xmm0
	vfmadd213ss	(%r9,%rax,4), %xmm14, %xmm0
	vmovss	%xmm0, (%r9,%rax,4)
	incq	%rax
.L288:
	vmovss	(%r8,%rax,4), %xmm2
	vfmadd213ss	(%r9,%rax,4), %xmm14, %xmm2
	vmovss	%xmm2, (%r9,%rax,4)
	incq	%rax
.L287:
	vmovss	(%r8,%rax,4), %xmm3
	vfmadd213ss	(%r9,%rax,4), %xmm14, %xmm3
	vmovss	%xmm3, (%r9,%rax,4)
	incq	%rax
.L286:
	movq	%rax, %rdx
	vmovss	(%r8,%rax,4), %xmm5
	vfmadd213ss	(%r9,%rax,4), %xmm14, %xmm5
	vmovss	%xmm5, (%r9,%rax,4)
	incq	%rax
	cmpq	%rdx, %r14
	je	.L363
.L123:
	leaq	7(%rax), %rcx
	vmovss	(%r8,%rax,4), %xmm7
	vfmadd213ss	(%r9,%rax,4), %xmm14, %xmm7
	vmovss	%xmm7, (%r9,%rax,4)
	vmovss	4(%r8,%rax,4), %xmm6
	vfmadd213ss	4(%r9,%rax,4), %xmm14, %xmm6
	vmovss	%xmm6, 4(%r9,%rax,4)
	vmovss	8(%r8,%rax,4), %xmm8
	vfmadd213ss	8(%r9,%rax,4), %xmm14, %xmm8
	vmovss	%xmm8, 8(%r9,%rax,4)
	vmovss	12(%r8,%rax,4), %xmm9
	vfmadd213ss	12(%r9,%rax,4), %xmm14, %xmm9
	vmovss	%xmm9, 12(%r9,%rax,4)
	vmovss	16(%r8,%rax,4), %xmm10
	vfmadd213ss	16(%r9,%rax,4), %xmm14, %xmm10
	vmovss	%xmm10, 16(%r9,%rax,4)
	vmovss	20(%r8,%rax,4), %xmm11
	vfmadd213ss	20(%r9,%rax,4), %xmm14, %xmm11
	vmovss	%xmm11, 20(%r9,%rax,4)
	vmovss	24(%r8,%rax,4), %xmm12
	vfmadd213ss	24(%r9,%rax,4), %xmm14, %xmm12
	vmovss	%xmm12, 24(%r9,%rax,4)
	vmovss	28(%r8,%rax,4), %xmm13
	vfmadd213ss	28(%r9,%rax,4), %xmm14, %xmm13
	addq	$8, %rax
	vmovss	%xmm13, (%r9,%rcx,4)
	cmpq	%rcx, %r14
	jne	.L123
.L363:
	leaq	-80(%rbp), %r15
	movl	$1, %edi
	vmovss	%xmm14, -112(%rbp)
	movq	%r15, %rsi
	call	clock_gettime@PLT
	vxorpd	%xmm14, %xmm14, %xmm14
	vmovsd	.LC3(%rip), %xmm13
	vcvtsi2sdq	-72(%rbp), %xmm14, %xmm15
	vcvtsi2sdq	-80(%rbp), %xmm14, %xmm4
	vfmadd132sd	%xmm13, %xmm4, %xmm15
	cmpq	$6, %r14
	vmovss	-112(%rbp), %xmm0
	movq	-88(%rbp), %r8
	movq	-96(%rbp), %r10
	vmovsd	%xmm15, -104(%rbp)
	ja	.L125
.L126:
	leaq	1(%r14), %rdi
	xorl	%r9d, %r9d
	andl	$7, %edi
	je	.L132
	cmpq	$1, %rdi
	je	.L298
	cmpq	$2, %rdi
	je	.L299
	cmpq	$3, %rdi
	je	.L300
	cmpq	$4, %rdi
	je	.L301
	cmpq	$5, %rdi
	je	.L302
	cmpq	$6, %rdi
	je	.L303
	vmovss	(%r10), %xmm1
	movl	$1, %r9d
	vfmadd213ss	(%r8), %xmm0, %xmm1
	vmovss	%xmm1, (%r8)
.L303:
	vmovss	(%r10,%r9,4), %xmm2
	vfmadd213ss	(%r8,%r9,4), %xmm0, %xmm2
	vmovss	%xmm2, (%r8,%r9,4)
	incq	%r9
.L302:
	vmovss	(%r10,%r9,4), %xmm3
	vfmadd213ss	(%r8,%r9,4), %xmm0, %xmm3
	vmovss	%xmm3, (%r8,%r9,4)
	incq	%r9
.L301:
	vmovss	(%r10,%r9,4), %xmm5
	vfmadd213ss	(%r8,%r9,4), %xmm0, %xmm5
	vmovss	%xmm5, (%r8,%r9,4)
	incq	%r9
.L300:
	vmovss	(%r10,%r9,4), %xmm7
	vfmadd213ss	(%r8,%r9,4), %xmm0, %xmm7
	vmovss	%xmm7, (%r8,%r9,4)
	incq	%r9
.L299:
	vmovss	(%r10,%r9,4), %xmm6
	vfmadd213ss	(%r8,%r9,4), %xmm0, %xmm6
	vmovss	%xmm6, (%r8,%r9,4)
	incq	%r9
.L298:
	movq	%r9, %r11
	vmovss	(%r10,%r9,4), %xmm8
	vfmadd213ss	(%r8,%r9,4), %xmm0, %xmm8
	vmovss	%xmm8, (%r8,%r9,4)
	incq	%r9
	cmpq	%r11, %r14
	je	.L133
.L132:
	leaq	7(%r9), %rax
	vmovss	(%r10,%r9,4), %xmm9
	vfmadd213ss	(%r8,%r9,4), %xmm0, %xmm9
	vmovss	%xmm9, (%r8,%r9,4)
	vmovss	4(%r10,%r9,4), %xmm10
	vfmadd213ss	4(%r8,%r9,4), %xmm0, %xmm10
	vmovss	%xmm10, 4(%r8,%r9,4)
	vmovss	8(%r10,%r9,4), %xmm11
	vfmadd213ss	8(%r8,%r9,4), %xmm0, %xmm11
	vmovss	%xmm11, 8(%r8,%r9,4)
	vmovss	12(%r10,%r9,4), %xmm12
	vfmadd213ss	12(%r8,%r9,4), %xmm0, %xmm12
	vmovss	%xmm12, 12(%r8,%r9,4)
	vmovss	16(%r10,%r9,4), %xmm14
	vfmadd213ss	16(%r8,%r9,4), %xmm0, %xmm14
	vmovss	%xmm14, 16(%r8,%r9,4)
	vmovss	20(%r10,%r9,4), %xmm15
	vfmadd213ss	20(%r8,%r9,4), %xmm0, %xmm15
	vmovss	%xmm15, 20(%r8,%r9,4)
	vmovss	24(%r10,%r9,4), %xmm4
	vfmadd213ss	24(%r8,%r9,4), %xmm0, %xmm4
	vmovss	%xmm4, 24(%r8,%r9,4)
	vmovss	28(%r10,%r9,4), %xmm1
	vfmadd213ss	28(%r8,%r9,4), %xmm0, %xmm1
	addq	$8, %r9
	vmovss	%xmm1, (%r8,%rax,4)
	cmpq	%rax, %r14
	jne	.L132
	jmp	.L133
.L113:
	leaq	-80(%rbp), %r14
	movl	$1, %edi
	movq	%r14, %rsi
	call	clock_gettime@PLT
	movq	%r14, %rsi
	movl	$1, %edi
	vxorpd	%xmm4, %xmm4, %xmm4
	vcvtsi2sdq	-72(%rbp), %xmm4, %xmm1
	vcvtsi2sdq	-80(%rbp), %xmm4, %xmm0
	vfmadd132sd	.LC3(%rip), %xmm0, %xmm1
	vmovsd	%xmm1, -104(%rbp)
	call	clock_gettime@PLT
	vxorpd	%xmm2, %xmm2, %xmm2
	vxorpd	%xmm1, %xmm1, %xmm1
	vcvtsi2sdq	-72(%rbp), %xmm2, %xmm3
	vcvtsi2sdq	-80(%rbp), %xmm2, %xmm5
	vmovapd	%xmm1, %xmm2
	vfmadd132sd	.LC3(%rip), %xmm5, %xmm3
	vsubsd	-104(%rbp), %xmm3, %xmm8
	jmp	.L116
.L146:
	xorl	%r14d, %r14d
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm2, %xmm2, %xmm2
	jmp	.L134
.L145:
	movq	%rbx, %rdx
	xorl	%ecx, %ecx
	jmp	.L127
.L144:
	movq	%r12, %r10
	xorl	%eax, %eax
	jmp	.L118
.L129:
	movq	%r15, %rsi
	movl	$1, %edi
	vmovsd	%xmm13, -112(%rbp)
	vzeroupper
	call	clock_gettime@PLT
	vxorpd	%xmm13, %xmm13, %xmm13
	vmovsd	-112(%rbp), %xmm5
	vcvtsi2sdq	-72(%rbp), %xmm13, %xmm0
	vcvtsi2sdq	-80(%rbp), %xmm13, %xmm3
	vcvtsi2sdq	%rbx, %xmm13, %xmm7
	vfmadd132sd	%xmm5, %xmm3, %xmm0
	vmulsd	.LC7(%rip), %xmm7, %xmm6
	vsubsd	-104(%rbp), %xmm0, %xmm8
	movq	-88(%rbp), %r15
	vdivsd	%xmm8, %xmm6, %xmm1
	jmp	.L139
.L383:
	call	__stack_chk_fail@PLT
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB14:
.L112:
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
	jmp	.L108
	.cfi_endproc
.LFE14:
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
	.ident	"GCC: (GNU) 14.3.0"
	.section	.note.GNU-stack,"",@progbits
