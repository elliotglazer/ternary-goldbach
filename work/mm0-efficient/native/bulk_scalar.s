	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
@feat.00 = 0
	.att_syntax
	.file	"bulk_check.c"
	.def	main;
	.scl	2;
	.type	32;
	.endef
	.section	.rdata,"dr"
	.p2align	4, 0x0                          # -- Begin function main
.LCPI0_0:
	.quad	0x3eb0c6f7a0b5ed8d              # double 9.9999999999999995E-7
.LCPI0_1:
	.quad	0x3fbeb851eb851eb8              # double 0.12
.LCPI0_2:
	.long	1127219200                      # 0x43300000
	.long	1160773632                      # 0x45300000
	.long	0                               # 0x0
	.long	0                               # 0x0
.LCPI0_3:
	.quad	0x4330000000000000              # double 4503599627370496
	.quad	0x4530000000000000              # double 1.9342813113834067E+25
.LCPI0_4:
	.quad	0x3e7ad7f29abcaf48              # double 9.9999999999999995E-8
	.section	.text$main,"xr",one_only,main,unique,0
	.globl	main
	.p2align	4
main:                                   # @main
.seh_proc main
# %bb.0:
	pushq	%rbp
	.seh_pushreg %rbp
	pushq	%r15
	.seh_pushreg %r15
	pushq	%r14
	.seh_pushreg %r14
	pushq	%r13
	.seh_pushreg %r13
	pushq	%r12
	.seh_pushreg %r12
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbx
	.seh_pushreg %rbx
	subq	$536, %rsp                      # imm = 0x218
	.seh_stackalloc 536
	leaq	128(%rsp), %rbp
	.seh_setframe %rbp, 128
	movapd	%xmm14, 384(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm14, 512
	movapd	%xmm13, 368(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm13, 496
	movapd	%xmm12, 352(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm12, 480
	movapd	%xmm11, 336(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm11, 464
	movapd	%xmm10, 320(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm10, 448
	movapd	%xmm9, 304(%rbp)                # 16-byte Spill
	.seh_savexmm %xmm9, 432
	movapd	%xmm8, 288(%rbp)                # 16-byte Spill
	.seh_savexmm %xmm8, 416
	movapd	%xmm7, 272(%rbp)                # 16-byte Spill
	.seh_savexmm %xmm7, 400
	movapd	%xmm6, 256(%rbp)                # 16-byte Spill
	.seh_savexmm %xmm6, 384
	.seh_endprologue
	movq	%rdx, %r14
	movl	%ecx, %esi
	movl	$2, %r13d
	callq	__main
	cmpl	$2, %esi
	jne	.LBB0_150
# %bb.1:
	leaq	128(%rbp), %rcx
	callq	*__imp_QueryPerformanceCounter(%rip)
	leaq	32(%rbp), %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	xorps	%xmm7, %xmm7
	cvtsi2sdq	128(%rbp), %xmm7
	xorps	%xmm8, %xmm8
	cvtsi2sdq	32(%rbp), %xmm8
	movq	8(%r14), %rcx
	leaq	.str.7(%rip), %rdx
	callq	fopen
	testq	%rax, %rax
	je	.LBB0_16
# %bb.2:
	movq	%rax, %rdi
	leaq	128(%rbp), %rcx
	movl	$1, %edx
	movl	$8, %r8d
	movq	%rax, %r9
	callq	fread
	cmpq	$8, %rax
	jne	.LBB0_16
# %bb.3:
	cmpb	$66, 128(%rbp)
	jne	.LBB0_16
# %bb.4:
	cmpb	$85, 129(%rbp)
	jne	.LBB0_16
# %bb.5:
	cmpb	$76, 130(%rbp)
	jne	.LBB0_16
# %bb.6:
	cmpb	$75, 131(%rbp)
	jne	.LBB0_16
# %bb.7:
	cmpb	$67, 132(%rbp)
	jne	.LBB0_16
# %bb.8:
	cmpb	$79, 133(%rbp)
	jne	.LBB0_16
# %bb.9:
	cmpb	$86, 134(%rbp)
	jne	.LBB0_16
# %bb.10:
	cmpb	$49, 135(%rbp)
	jne	.LBB0_16
# %bb.11:
	leaq	-24(%rbp), %rcx
	movl	$8, %edx
	movl	$1, %r8d
	movq	%rdi, %r9
	callq	fread
	cmpq	$1, %rax
	jne	.LBB0_16
# %bb.12:
	movq	-24(%rbp), %rsi
	testq	%rsi, %rsi
	je	.LBB0_16
# %bb.13:
	cmpq	$1024, %rsi                     # imm = 0x400
	ja	.LBB0_16
# %bb.151:
	movq	%rsi, %rax
	shlq	$4, %rax
	leaq	(%rax,%rax,4), %rcx
	callq	malloc
	testq	%rax, %rax
	je	.LBB0_16
# %bb.152:
	movq	%rax, %r15
	movq	%rax, %rbx
	.p2align	4
.LBB0_153:                              # =>This Inner Loop Header: Depth=1
	movq	%rdi, %rcx
	movq	%rbx, %rdx
	callq	read_case
	testl	%eax, %eax
	je	.LBB0_16
# %bb.154:                              #   in Loop: Header=BB0_153 Depth=1
	addq	$80, %rbx
	decq	%rsi
	jne	.LBB0_153
# %bb.155:
	movq	%rdi, %rcx
	callq	fclose
	movq	%r15, %rbx
	jmp	.LBB0_17
.LBB0_16:
	xorl	%ebx, %ebx
.LBB0_17:
	leaq	128(%rbp), %rcx
	callq	*__imp_QueryPerformanceCounter(%rip)
	leaq	32(%rbp), %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	testq	%rbx, %rbx
	je	.LBB0_77
# %bb.18:
	cvtsi2sdq	128(%rbp), %xmm6
	cvtsi2sdq	32(%rbp), %xmm9
	xorpd	%xmm0, %xmm0
	movapd	%xmm0, (%rbp)
	movq	$0, 16(%rbp)
	movq	-24(%rbp), %rdx
	movq	$0, 232(%rbp)                   # 8-byte Folded Spill
	testq	%rdx, %rdx
	movq	%rdx, 224(%rbp)                 # 8-byte Spill
	je	.LBB0_78
# %bb.19:
	leal	(%rdx,%rdx), %eax
	leal	(%rax,%rax,4), %r15d
	xorl	%eax, %eax
	leaq	128(%rbp), %r12
	movq	%rbp, %r13
	movq	%rbx, %rdi
	xorl	%esi, %esi
.LBB0_20:                               # =>This Inner Loop Header: Depth=1
	addq	(%rdi), %rax
	movq	%rax, -8(%rbp)                  # 8-byte Spill
	movq	%r12, %rcx
	movq	%rdi, %rdx
	xorl	%r8d, %r8d
	movq	%r13, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_76
# %bb.21:                               #   in Loop: Header=BB0_20 Depth=1
	movl	132(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_76
# %bb.22:                               #   in Loop: Header=BB0_20 Depth=1
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movl	$1, %r8d
	movq	%r13, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_76
# %bb.23:                               #   in Loop: Header=BB0_20 Depth=1
	movl	132(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_76
# %bb.24:                               #   in Loop: Header=BB0_20 Depth=1
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movl	$2, %r8d
	movq	%r13, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_76
# %bb.25:                               #   in Loop: Header=BB0_20 Depth=1
	movl	132(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_76
# %bb.26:                               #   in Loop: Header=BB0_20 Depth=1
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movl	$3, %r8d
	movq	%r13, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_76
# %bb.27:                               #   in Loop: Header=BB0_20 Depth=1
	movl	132(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_76
# %bb.28:                               #   in Loop: Header=BB0_20 Depth=1
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movl	$4, %r8d
	movq	%r13, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_76
# %bb.29:                               #   in Loop: Header=BB0_20 Depth=1
	movl	132(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_76
# %bb.30:                               #   in Loop: Header=BB0_20 Depth=1
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movl	$5, %r8d
	movq	%r13, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_76
# %bb.31:                               #   in Loop: Header=BB0_20 Depth=1
	movl	132(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_76
# %bb.32:                               #   in Loop: Header=BB0_20 Depth=1
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movl	$6, %r8d
	movq	%r13, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_76
# %bb.33:                               #   in Loop: Header=BB0_20 Depth=1
	movl	132(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_76
# %bb.34:                               #   in Loop: Header=BB0_20 Depth=1
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movl	$7, %r8d
	movq	%r13, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_76
# %bb.35:                               #   in Loop: Header=BB0_20 Depth=1
	movl	132(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_76
# %bb.36:                               #   in Loop: Header=BB0_20 Depth=1
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movl	$8, %r8d
	movq	%r13, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_76
# %bb.37:                               #   in Loop: Header=BB0_20 Depth=1
	movl	132(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_76
# %bb.38:                               #   in Loop: Header=BB0_20 Depth=1
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movl	$9, %r8d
	movq	%r13, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_76
# %bb.39:                               #   in Loop: Header=BB0_20 Depth=1
	movl	132(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_76
# %bb.40:                               #   in Loop: Header=BB0_20 Depth=1
	incq	%rsi
	addq	$80, %rdi
	movq	224(%rbp), %rdx                 # 8-byte Reload
	cmpq	%rsi, %rdx
	movq	-8(%rbp), %rax                  # 8-byte Reload
	jne	.LBB0_20
# %bb.41:
	movl	%r15d, -12(%rbp)                # 4-byte Spill
	movq	%r14, 24(%rbp)                  # 8-byte Spill
	movl	$1048576, %r8d                  # imm = 0x100000
	leaq	32(%rbp), %r13
	leaq	128(%rbp), %rsi
	movq	%rbp, %r15
	movl	$0, 104(%rbp)                   # 4-byte Folded Spill
	xorl	%r9d, %r9d
.LBB0_42:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_58 Depth 2
	testq	%r9, %r9
	je	.LBB0_44
# %bb.43:                               #   in Loop: Header=BB0_42 Depth=1
	leaq	(%r9,%r9,4), %rax
	shlq	$4, %rax
	movq	(%rbx,%rax), %rcx
	cmpq	-80(%rbx,%rax), %rcx
	je	.LBB0_74
.LBB0_44:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r9, 120(%rbp)                  # 8-byte Spill
	leaq	(%r9,%r9,4), %rax
	shlq	$4, %rax
	movups	(%rbx,%rax), %xmm0
	movupd	16(%rbx,%rax), %xmm1
	movupd	32(%rbx,%rax), %xmm2
	movups	48(%rbx,%rax), %xmm3
	movaps	%xmm0, 128(%rbp)
	movapd	%xmm1, 144(%rbp)
	movupd	64(%rbx,%rax), %xmm0
	movapd	%xmm0, 192(%rbp)
	movaps	%xmm3, 176(%rbp)
	movq	128(%rbp), %rdi
	cmpq	$1048576, %rdi                  # imm = 0x100000
	cmovaeq	%r8, %rdi
	movapd	%xmm2, 160(%rbp)
	movq	%rdi, 128(%rbp)
	movq	152(%rbp), %rax
	leaq	8(,%rax,8), %r14
	movq	%r14, %rcx
	callq	malloc
	movq	200(%rbp), %r12
	movq	%rax, 208(%rbp)                 # 8-byte Spill
	movq	%rax, %rcx
	movq	%r12, %rdx
	movq	%r14, %r8
	callq	memcpy
	movq	%r12, %rcx
	xorl	%edx, %edx
	movq	%r14, 216(%rbp)                 # 8-byte Spill
	movq	%r14, %r8
	callq	memset
	movq	%r13, %rcx
	movq	%rsi, %rdx
	xorl	%r8d, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	movq	%r13, %r14
	movl	$5, %r13d
	jne	.LBB0_150
# %bb.45:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$1, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.46:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$2, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.47:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$3, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.48:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$4, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.49:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$5, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.50:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$6, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.51:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$7, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.52:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$8, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.53:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$9, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.54:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r12, %rcx
	movq	208(%rbp), %rdx                 # 8-byte Reload
	movq	216(%rbp), %r8                  # 8-byte Reload
	callq	memcpy
	movq	144(%rbp), %r8
	testq	%r8, %r8
	je	.LBB0_61
# %bb.55:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%rdi, %rax
	shrq	%rax
	movq	192(%rbp), %rdx
	cmpq	$1, %r8
	jne	.LBB0_57
# %bb.56:                               #   in Loop: Header=BB0_42 Depth=1
	xorl	%r9d, %r9d
	jmp	.LBB0_60
.LBB0_57:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%rbx, %r13
	movq	%r8, %r10
	andq	$-2, %r10
	leaq	24(%rdx), %r11
	xorl	%r9d, %r9d
.LBB0_58:                               #   Parent Loop BB0_42 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-16(%r11), %rcx
	addq	%rax, %rcx
	movq	$-2, %rbx
	rolq	%cl, %rbx
	shrq	$6, %rcx
	andq	%rbx, (%r12,%rcx,8)
	movq	(%r11), %rcx
	addq	%rax, %rcx
	movq	$-2, %rbx
	rolq	%cl, %rbx
	shrq	$6, %rcx
	andq	%rbx, (%r12,%rcx,8)
	addq	$2, %r9
	addq	$32, %r11
	cmpq	%r9, %r10
	jne	.LBB0_58
# %bb.59:                               #   in Loop: Header=BB0_42 Depth=1
	testb	$1, %r8b
	movq	%r13, %rbx
	je	.LBB0_61
.LBB0_60:                               #   in Loop: Header=BB0_42 Depth=1
	shlq	$4, %r9
	addq	8(%rdx,%r9), %rax
	movq	$-2, %rdx
	movl	%eax, %ecx
	rolq	%cl, %rdx
	shrq	$6, %rax
	andq	%rdx, (%r12,%rax,8)
.LBB0_61:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	xorl	%r8d, %r8d
	movq	%rbp, %r15
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	movl	$6, %r13d
	jne	.LBB0_150
# %bb.62:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$1, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.63:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$2, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.64:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$3, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.65:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$4, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.66:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$5, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.67:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$6, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.68:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$7, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.69:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$8, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.70:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movl	$9, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_150
# %bb.71:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%rbx, %r13
	movq	%r12, %rcx
	movq	208(%rbp), %rdx                 # 8-byte Reload
	movq	216(%rbp), %r8                  # 8-byte Reload
	callq	memcpy
	movq	136(%rbp), %rax
	movq	192(%rbp), %rbx
	movq	8(%rbx), %r12
	subq	%rdi, %rax
	incq	%rax
	movq	%rax, 8(%rbx)
	movq	%r14, %rcx
	movq	%rsi, %rdx
	xorl	%r8d, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 48(%rbp)
	je	.LBB0_158
# %bb.72:                               #   in Loop: Header=BB0_42 Depth=1
	movq	%r12, 8(%rbx)
	movq	(%rbx), %rdi
	leaq	2(%rdi), %rax
	movq	%rax, (%rbx)
	movq	%r14, %r12
	movq	%r14, %rcx
	movq	%rsi, %r14
	movq	%rsi, %rdx
	xorl	%r8d, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 48(%rbp)
	je	.LBB0_159
# %bb.73:                               #   in Loop: Header=BB0_42 Depth=1
	addl	$22, 104(%rbp)                  # 4-byte Folded Spill
	movq	%rdi, (%rbx)
	movq	208(%rbp), %rcx                 # 8-byte Reload
	callq	free
	movq	%r13, %rbx
	movq	224(%rbp), %rdx                 # 8-byte Reload
	movl	$1048576, %r8d                  # imm = 0x100000
	movq	%r12, %r13
	movq	%r14, %rsi
	movq	120(%rbp), %r9                  # 8-byte Reload
.LBB0_74:                               #   in Loop: Header=BB0_42 Depth=1
	incq	%r9
	cmpq	%rdx, %r9
	jne	.LBB0_42
# %bb.75:
	movq	24(%rbp), %r14                  # 8-byte Reload
	movl	104(%rbp), %eax                 # 4-byte Reload
	movl	-12(%rbp), %r9d                 # 4-byte Reload
	jmp	.LBB0_79
.LBB0_76:
	movl	$4, %r13d
	jmp	.LBB0_150
.LBB0_77:
	movl	$3, %r13d
	jmp	.LBB0_150
.LBB0_78:
	xorl	%r9d, %r9d
	movq	$0, -8(%rbp)                    # 8-byte Folded Spill
	xorl	%eax, %eax
.LBB0_79:
	divsd	%xmm8, %xmm7
	divsd	%xmm9, %xmm6
	subsd	%xmm7, %xmm6
	movq	$0, 96(%rbp)
	movl	%eax, 32(%rsp)
	leaq	.str(%rip), %rcx
	movapd	%xmm6, %xmm2
	movq	%xmm6, %r8
	callq	printf
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	leaq	32(%rbp), %rsi
	movq	__imp_QueryPerformanceFrequency(%rip), %r15
	movsd	.LCPI0_0(%rip), %xmm9           # xmm9 = [9.9999999999999995E-7,0.0E+0]
	movsd	.LCPI0_1(%rip), %xmm10          # xmm10 = [1.2E-1,0.0E+0]
	movq	.LCPI0_2(%rip), %xmm6           # xmm6 = [1127219200,1160773632,0,0]
	movapd	.LCPI0_3(%rip), %xmm7           # xmm7 = [4.503599627370496E+15,1.9342813113834067E+25]
	movsd	.LCPI0_4(%rip), %xmm8           # xmm8 = [9.9999999999999995E-8,0.0E+0]
	movapd	.LCPI0_3(%rip), %xmm11          # xmm11 = [4.503599627370496E+15,1.9342813113834067E+25]
	movq	$0, 216(%rbp)                   # 8-byte Folded Spill
	movq	%r14, 24(%rbp)                  # 8-byte Spill
	movq	%rbx, 112(%rbp)                 # 8-byte Spill
.LBB0_80:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_83 Depth 2
                                        #       Child Loop BB0_86 Depth 3
                                        #       Child Loop BB0_91 Depth 3
                                        #         Child Loop BB0_93 Depth 4
                                        #       Child Loop BB0_98 Depth 3
                                        #         Child Loop BB0_100 Depth 4
                                        #       Child Loop BB0_105 Depth 3
                                        #         Child Loop BB0_107 Depth 4
	xorl	%eax, %eax
	jmp	.LBB0_83
.LBB0_81:                               #   in Loop: Header=BB0_83 Depth=2
	movq	24(%rbp), %r14                  # 8-byte Reload
	movq	112(%rbp), %rbx                 # 8-byte Reload
	movq	__imp_QueryPerformanceFrequency(%rip), %r15
	leaq	32(%rbp), %rsi
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
.LBB0_82:                               #   in Loop: Header=BB0_83 Depth=2
	movq	208(%rbp), %rax                 # 8-byte Reload
	incq	%rax
	cmpq	$7, %rax
	je	.LBB0_111
.LBB0_83:                               #   Parent Loop BB0_80 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_86 Depth 3
                                        #       Child Loop BB0_91 Depth 3
                                        #         Child Loop BB0_93 Depth 4
                                        #       Child Loop BB0_98 Depth 3
                                        #         Child Loop BB0_100 Depth 4
                                        #       Child Loop BB0_105 Depth 3
                                        #         Child Loop BB0_107 Depth 4
	movq	%rax, 208(%rbp)                 # 8-byte Spill
	leal	(%rax,%rax), %ecx
	movl	$65536, %r12d                   # imm = 0x10000
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r12
	leaq	128(%rbp), %rcx
	callq	*%rdi
	movq	%rsi, %rcx
	callq	*%r15
	movq	224(%rbp), %rcx                 # 8-byte Reload
	testq	%rcx, %rcx
	je	.LBB0_82
# %bb.84:                               #   in Loop: Header=BB0_83 Depth=2
	xorps	%xmm12, %xmm12
	cvtsi2sdq	128(%rbp), %xmm12
	xorps	%xmm0, %xmm0
	cvtsi2sdq	32(%rbp), %xmm0
	divsd	%xmm0, %xmm12
	xorl	%r14d, %r14d
	movq	%rbx, %rdi
	xorl	%ebx, %ebx
	xorl	%esi, %esi
	xorl	%edx, %edx
	xorl	%r15d, %r15d
	jmp	.LBB0_86
	.p2align	4
.LBB0_85:                               #   in Loop: Header=BB0_86 Depth=3
	incq	%rbx
	addq	$80, %rdi
	cmpq	%rbx, %rcx
	je	.LBB0_88
.LBB0_86:                               #   Parent Loop BB0_80 Depth=1
                                        #     Parent Loop BB0_83 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	cmpq	%r12, (%rdi)
	jne	.LBB0_85
# %bb.87:                               #   in Loop: Header=BB0_86 Depth=3
	leaq	128(%rbp), %rcx
	movl	%esi, %r13d
	movq	%r15, %rsi
	movq	%rdx, %r15
	movq	%rdi, %rdx
	movq	232(%rbp), %r8                  # 8-byte Reload
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%rbp, %r9
	callq	check
	movq	%r15, %rdx
	movq	%rsi, %r15
	movl	%r13d, %esi
	movq	224(%rbp), %rcx                 # 8-byte Reload
	movl	132(%rbp), %eax
	addq	%rax, 96(%rbp)
	addq	%r12, %r15
	addq	136(%rbp), %rdx
	addq	%rax, %r14
	incl	%esi
	jmp	.LBB0_85
.LBB0_88:                               #   in Loop: Header=BB0_83 Depth=2
	testl	%esi, %esi
	je	.LBB0_81
# %bb.89:                               #   in Loop: Header=BB0_83 Depth=2
	movq	%rdx, 104(%rbp)                 # 8-byte Spill
	movq	%r14, 120(%rbp)                 # 8-byte Spill
	leaq	128(%rbp), %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %rbx
	callq	*%rbx
	leaq	32(%rbp), %r13
	movq	%r13, %rcx
	movq	__imp_QueryPerformanceFrequency(%rip), %rdi
	callq	*%rdi
	xorps	%xmm0, %xmm0
	cvtsi2sdq	128(%rbp), %xmm0
	cvtsi2sdq	32(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	subsd	%xmm12, %xmm0
	maxsd	%xmm9, %xmm0
	movapd	%xmm10, %xmm1
	divsd	%xmm0, %xmm1
	cvttsd2si	%xmm1, %r14
	cmpl	$2, %r14d
	movl	$1, %eax
	cmovbl	%eax, %r14d
	cmpl	$100, %r14d
	movl	$100, %eax
	cmovael	%eax, %r14d
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	248(%rbp), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	leaq	128(%rbp), %rdi
	movq	%rdi, %rdx
	movq	%r13, %r8
	leaq	240(%rbp), %r9
	callq	*__imp_GetProcessTimes(%rip)
	movl	248(%rbp), %eax
	movl	252(%rbp), %ecx
	shlq	$32, %rcx
	addq	240(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	%xmm6, %xmm0            # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1]
	subpd	%xmm7, %xmm0
	movapd	%xmm0, %xmm13
	unpckhpd	%xmm0, %xmm13                   # xmm13 = xmm13[1],xmm0[1]
	addsd	%xmm0, %xmm13
	mulsd	%xmm8, %xmm13
	movq	%rdi, %rcx
	callq	*%rbx
	movq	%r13, %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	movq	224(%rbp), %rax                 # 8-byte Reload
	cvtsi2sdq	128(%rbp), %xmm12
	xorps	%xmm0, %xmm0
	cvtsi2sdq	32(%rbp), %xmm0
	divsd	%xmm0, %xmm12
	xorl	%ebx, %ebx
	jmp	.LBB0_91
	.p2align	4
.LBB0_90:                               #   in Loop: Header=BB0_91 Depth=3
	incl	%ebx
	cmpl	%r14d, %ebx
	je	.LBB0_96
.LBB0_91:                               #   Parent Loop BB0_80 Depth=1
                                        #     Parent Loop BB0_83 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_93 Depth 4
	movq	112(%rbp), %rdi                 # 8-byte Reload
	xorl	%r13d, %r13d
	jmp	.LBB0_93
	.p2align	4
.LBB0_92:                               #   in Loop: Header=BB0_93 Depth=4
	incq	%r13
	addq	$80, %rdi
	cmpq	%r13, %rax
	je	.LBB0_90
.LBB0_93:                               #   Parent Loop BB0_80 Depth=1
                                        #     Parent Loop BB0_83 Depth=2
                                        #       Parent Loop BB0_91 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	cmpq	%r12, (%rdi)
	jne	.LBB0_92
# %bb.94:                               #   in Loop: Header=BB0_93 Depth=4
	leaq	128(%rbp), %rcx
	movq	%rdi, %rdx
	movq	232(%rbp), %r8                  # 8-byte Reload
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%rbp, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_149
# %bb.95:                               #   in Loop: Header=BB0_93 Depth=4
	movl	132(%rbp), %eax
	addq	%rax, 96(%rbp)
	movq	224(%rbp), %rax                 # 8-byte Reload
	jmp	.LBB0_92
.LBB0_96:                               #   in Loop: Header=BB0_83 Depth=2
	movq	__imp_GetCurrentProcess(%rip), %r13
	callq	*%r13
	leaq	248(%rbp), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	leaq	128(%rbp), %rdi
	movq	%rdi, %rdx
	leaq	32(%rbp), %r13
	movq	%r13, %r8
	leaq	240(%rbp), %r9
	movq	__imp_GetProcessTimes(%rip), %rax
	callq	*%rax
	movl	248(%rbp), %eax
	movl	252(%rbp), %ecx
	shlq	$32, %rcx
	addq	240(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	%xmm6, %xmm0            # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1]
	subpd	%xmm11, %xmm0
	movapd	%xmm0, %xmm14
	unpckhpd	%xmm0, %xmm14                   # xmm14 = xmm14[1],xmm0[1]
	addsd	%xmm0, %xmm14
	mulsd	%xmm8, %xmm14
	subsd	%xmm13, %xmm14
	movq	%rdi, %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	callq	*%rdi
	movq	%r13, %rcx
	movq	__imp_QueryPerformanceFrequency(%rip), %rbx
	callq	*%rbx
	xorps	%xmm0, %xmm0
	cvtsi2sdq	128(%rbp), %xmm0
	cvtsi2sdq	32(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	subsd	%xmm12, %xmm0
	cmpl	$0, 216(%rbp)                   # 4-byte Folded Reload
	leaq	.str.2(%rip), %rdx
	leaq	.str.3(%rip), %rax
	cmoveq	%rax, %rdx
	movsd	%xmm14, 88(%rsp)
	movsd	%xmm0, 80(%rsp)
	movq	120(%rbp), %rax                 # 8-byte Reload
	movq	%rax, 72(%rsp)
	movq	104(%rbp), %rax                 # 8-byte Reload
	movq	%rax, 64(%rsp)
	movq	%r15, 56(%rsp)
	movl	%r14d, 48(%rsp)
	movl	%esi, 40(%rsp)
	movl	$0, 32(%rsp)
	leaq	.str.1(%rip), %rcx
	movq	232(%rbp), %r8                  # 8-byte Reload
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%r12, %r9
	callq	printf
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	248(%rbp), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	leaq	128(%rbp), %rbx
	movq	%rbx, %rdx
	movq	%r13, %r8
	leaq	240(%rbp), %r9
	callq	*__imp_GetProcessTimes(%rip)
	movl	248(%rbp), %eax
	movl	252(%rbp), %ecx
	shlq	$32, %rcx
	addq	240(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	%xmm6, %xmm0            # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1]
	subpd	%xmm11, %xmm0
	movapd	%xmm0, %xmm13
	unpckhpd	%xmm0, %xmm13                   # xmm13 = xmm13[1],xmm0[1]
	addsd	%xmm0, %xmm13
	mulsd	%xmm8, %xmm13
	movq	%rbx, %rcx
	callq	*%rdi
	movq	%r13, %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	movq	224(%rbp), %rax                 # 8-byte Reload
	cvtsi2sdq	128(%rbp), %xmm12
	xorps	%xmm0, %xmm0
	cvtsi2sdq	32(%rbp), %xmm0
	divsd	%xmm0, %xmm12
	xorl	%ebx, %ebx
	jmp	.LBB0_98
.LBB0_97:                               #   in Loop: Header=BB0_98 Depth=3
	incl	%ebx
	cmpl	%r14d, %ebx
	je	.LBB0_103
.LBB0_98:                               #   Parent Loop BB0_80 Depth=1
                                        #     Parent Loop BB0_83 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_100 Depth 4
	movq	112(%rbp), %rdi                 # 8-byte Reload
	xorl	%r13d, %r13d
	jmp	.LBB0_100
	.p2align	4
.LBB0_99:                               #   in Loop: Header=BB0_100 Depth=4
	incq	%r13
	addq	$80, %rdi
	cmpq	%r13, %rax
	je	.LBB0_97
.LBB0_100:                              #   Parent Loop BB0_80 Depth=1
                                        #     Parent Loop BB0_83 Depth=2
                                        #       Parent Loop BB0_98 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	cmpq	%r12, (%rdi)
	jne	.LBB0_99
# %bb.101:                              #   in Loop: Header=BB0_100 Depth=4
	leaq	128(%rbp), %rcx
	movq	%rdi, %rdx
	movq	232(%rbp), %r8                  # 8-byte Reload
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%rbp, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_149
# %bb.102:                              #   in Loop: Header=BB0_100 Depth=4
	movl	132(%rbp), %eax
	addq	%rax, 96(%rbp)
	movq	224(%rbp), %rax                 # 8-byte Reload
	jmp	.LBB0_99
.LBB0_103:                              #   in Loop: Header=BB0_83 Depth=2
	movq	__imp_GetCurrentProcess(%rip), %r13
	callq	*%r13
	leaq	248(%rbp), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	leaq	128(%rbp), %rdi
	movq	%rdi, %rdx
	leaq	32(%rbp), %r13
	movq	%r13, %r8
	leaq	240(%rbp), %r9
	movq	__imp_GetProcessTimes(%rip), %rax
	callq	*%rax
	movl	248(%rbp), %eax
	movl	252(%rbp), %ecx
	shlq	$32, %rcx
	addq	240(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	%xmm6, %xmm0            # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1]
	subpd	%xmm11, %xmm0
	movapd	%xmm0, %xmm14
	unpckhpd	%xmm0, %xmm14                   # xmm14 = xmm14[1],xmm0[1]
	addsd	%xmm0, %xmm14
	mulsd	%xmm8, %xmm14
	subsd	%xmm13, %xmm14
	movq	%rdi, %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	callq	*%rdi
	movq	%r13, %rcx
	movq	__imp_QueryPerformanceFrequency(%rip), %rbx
	callq	*%rbx
	xorps	%xmm0, %xmm0
	cvtsi2sdq	128(%rbp), %xmm0
	cvtsi2sdq	32(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	subsd	%xmm12, %xmm0
	cmpl	$-1, 216(%rbp)                  # 4-byte Folded Reload
	leaq	.str.2(%rip), %rdx
	leaq	.str.3(%rip), %rax
	cmoveq	%rax, %rdx
	movsd	%xmm14, 88(%rsp)
	movsd	%xmm0, 80(%rsp)
	movq	120(%rbp), %rax                 # 8-byte Reload
	movq	%rax, 72(%rsp)
	movq	104(%rbp), %rax                 # 8-byte Reload
	movq	%rax, 64(%rsp)
	movq	%r15, 56(%rsp)
	movl	%r14d, 48(%rsp)
	movl	%esi, 40(%rsp)
	movl	$1, 32(%rsp)
	leaq	.str.1(%rip), %rcx
	movq	232(%rbp), %r8                  # 8-byte Reload
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%r12, %r9
	callq	printf
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	248(%rbp), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	leaq	128(%rbp), %rbx
	movq	%rbx, %rdx
	movq	%r13, %r8
	leaq	240(%rbp), %r9
	callq	*__imp_GetProcessTimes(%rip)
	movl	248(%rbp), %eax
	movl	252(%rbp), %ecx
	shlq	$32, %rcx
	addq	240(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	%xmm6, %xmm0            # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1]
	subpd	%xmm11, %xmm0
	movapd	%xmm0, %xmm13
	unpckhpd	%xmm0, %xmm13                   # xmm13 = xmm13[1],xmm0[1]
	addsd	%xmm0, %xmm13
	mulsd	%xmm8, %xmm13
	movq	%rbx, %rcx
	callq	*%rdi
	movq	%r13, %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	movq	224(%rbp), %rax                 # 8-byte Reload
	cvtsi2sdq	128(%rbp), %xmm12
	xorps	%xmm0, %xmm0
	cvtsi2sdq	32(%rbp), %xmm0
	divsd	%xmm0, %xmm12
	xorl	%ebx, %ebx
	jmp	.LBB0_105
.LBB0_104:                              #   in Loop: Header=BB0_105 Depth=3
	incl	%ebx
	cmpl	%r14d, %ebx
	je	.LBB0_110
.LBB0_105:                              #   Parent Loop BB0_80 Depth=1
                                        #     Parent Loop BB0_83 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_107 Depth 4
	movq	112(%rbp), %rdi                 # 8-byte Reload
	movq	%rax, %r13
	jmp	.LBB0_107
.LBB0_106:                              #   in Loop: Header=BB0_107 Depth=4
	addq	$80, %rdi
	decq	%r13
	je	.LBB0_104
.LBB0_107:                              #   Parent Loop BB0_80 Depth=1
                                        #     Parent Loop BB0_83 Depth=2
                                        #       Parent Loop BB0_105 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	cmpq	%r12, (%rdi)
	jne	.LBB0_106
# %bb.108:                              #   in Loop: Header=BB0_107 Depth=4
	leaq	128(%rbp), %rcx
	movq	%rdi, %rdx
	movq	232(%rbp), %r8                  # 8-byte Reload
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%rbp, %r9
	callq	check
	cmpl	$0, 128(%rbp)
	je	.LBB0_149
# %bb.109:                              #   in Loop: Header=BB0_107 Depth=4
	movl	132(%rbp), %eax
	addq	%rax, 96(%rbp)
	movq	224(%rbp), %rax                 # 8-byte Reload
	jmp	.LBB0_106
.LBB0_110:                              #   in Loop: Header=BB0_83 Depth=2
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	248(%rbp), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	leaq	128(%rbp), %rdi
	movq	%rdi, %rdx
	leaq	32(%rbp), %rbx
	movq	%rbx, %r8
	leaq	240(%rbp), %r9
	callq	*__imp_GetProcessTimes(%rip)
	movl	248(%rbp), %eax
	movl	252(%rbp), %ecx
	shlq	$32, %rcx
	addq	240(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	%xmm6, %xmm0            # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1]
	subpd	%xmm7, %xmm0
	movapd	%xmm0, %xmm14
	unpckhpd	%xmm0, %xmm14                   # xmm14 = xmm14[1],xmm0[1]
	addsd	%xmm0, %xmm14
	mulsd	%xmm8, %xmm14
	subsd	%xmm13, %xmm14
	movq	%rdi, %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %r13
	callq	*%r13
	movq	%rbx, %rcx
	movq	__imp_QueryPerformanceFrequency(%rip), %r13
	callq	*%r13
	xorps	%xmm0, %xmm0
	cvtsi2sdq	128(%rbp), %xmm0
	cvtsi2sdq	32(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	subsd	%xmm12, %xmm0
	movq	216(%rbp), %rax                 # 8-byte Reload
	leal	3(%rax), %edi
	cmpl	$-2, %eax
	leaq	.str.2(%rip), %rdx
	leaq	.str.3(%rip), %rax
	cmoveq	%rax, %rdx
	movsd	%xmm14, 88(%rsp)
	movsd	%xmm0, 80(%rsp)
	movq	120(%rbp), %rax                 # 8-byte Reload
	movq	%rax, 72(%rsp)
	movq	104(%rbp), %rax                 # 8-byte Reload
	movq	%rax, 64(%rsp)
	movq	%r15, 56(%rsp)
	movq	%r13, %r15
	movl	%r14d, 48(%rsp)
	movl	%esi, 40(%rsp)
	movq	%rbx, %rsi
	movl	$2, 32(%rsp)
	leaq	.str.1(%rip), %rcx
	movq	232(%rbp), %r8                  # 8-byte Reload
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%r12, %r9
	callq	printf
	movl	%edi, %eax
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	movq	%rax, 216(%rbp)                 # 8-byte Spill
	movq	24(%rbp), %r14                  # 8-byte Reload
	movq	112(%rbp), %rbx                 # 8-byte Reload
	jmp	.LBB0_82
.LBB0_111:                              #   in Loop: Header=BB0_80 Depth=1
	movq	232(%rbp), %rax                 # 8-byte Reload
	incl	%eax
	movq	%rax, 232(%rbp)                 # 8-byte Spill
	cmpl	$10, %eax
	jne	.LBB0_80
# %bb.112:
	leaq	.str.4(%rip), %rcx
	callq	printf
	movq	$0, 232(%rbp)                   # 8-byte Folded Spill
	leaq	32(%rbp), %rdi
	leaq	.str.7(%rip), %r12
	xorl	%esi, %esi
.LBB0_113:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_114 Depth 2
                                        #       Child Loop BB0_115 Depth 3
                                        #         Child Loop BB0_129 Depth 4
	xorl	%r13d, %r13d
	movl	%esi, %eax
	movq	%rax, 216(%rbp)                 # 8-byte Spill
.LBB0_114:                              #   Parent Loop BB0_113 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_115 Depth 3
                                        #         Child Loop BB0_129 Depth 4
	movl	%r13d, 120(%rbp)                # 4-byte Spill
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	248(%rbp), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	leaq	128(%rbp), %rsi
	movq	%rsi, %rdx
	movq	%rdi, %r8
	leaq	240(%rbp), %r9
	callq	*__imp_GetProcessTimes(%rip)
	movl	248(%rbp), %eax
	movl	252(%rbp), %ecx
	shlq	$32, %rcx
	addq	240(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	%xmm6, %xmm0            # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1]
	subpd	%xmm7, %xmm0
	movapd	%xmm0, %xmm9
	unpckhpd	%xmm0, %xmm9                    # xmm9 = xmm9[1],xmm0[1]
	addsd	%xmm0, %xmm9
	mulsd	%xmm8, %xmm9
	movq	%rsi, %rcx
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%rdi, %rcx
	callq	*%r15
	cvtsi2sdq	128(%rbp), %xmm10
	xorps	%xmm0, %xmm0
	cvtsi2sdq	32(%rbp), %xmm0
	divsd	%xmm0, %xmm10
	movl	$0, 208(%rbp)                   # 4-byte Folded Spill
.LBB0_115:                              #   Parent Loop BB0_113 Depth=1
                                        #     Parent Loop BB0_114 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_129 Depth 4
	movq	8(%r14), %rcx
	movq	%r12, %rdx
	callq	fopen
	testq	%rax, %rax
	je	.LBB0_162
# %bb.116:                              #   in Loop: Header=BB0_115 Depth=3
	movq	%rax, %r12
	movl	$1, %edx
	movl	$8, %r8d
	leaq	128(%rbp), %rcx
	movq	%rax, %r9
	callq	fread
	cmpq	$8, %rax
	jne	.LBB0_162
# %bb.117:                              #   in Loop: Header=BB0_115 Depth=3
	cmpb	$66, 128(%rbp)
	jne	.LBB0_162
# %bb.118:                              #   in Loop: Header=BB0_115 Depth=3
	cmpb	$85, 129(%rbp)
	jne	.LBB0_162
# %bb.119:                              #   in Loop: Header=BB0_115 Depth=3
	cmpb	$76, 130(%rbp)
	jne	.LBB0_162
# %bb.120:                              #   in Loop: Header=BB0_115 Depth=3
	cmpb	$75, 131(%rbp)
	jne	.LBB0_162
# %bb.121:                              #   in Loop: Header=BB0_115 Depth=3
	cmpb	$67, 132(%rbp)
	jne	.LBB0_162
# %bb.122:                              #   in Loop: Header=BB0_115 Depth=3
	cmpb	$79, 133(%rbp)
	jne	.LBB0_162
# %bb.123:                              #   in Loop: Header=BB0_115 Depth=3
	cmpb	$86, 134(%rbp)
	jne	.LBB0_162
# %bb.124:                              #   in Loop: Header=BB0_115 Depth=3
	cmpb	$49, 135(%rbp)
	jne	.LBB0_162
# %bb.125:                              #   in Loop: Header=BB0_115 Depth=3
	movl	$8, %edx
	movl	$1, %r8d
	leaq	240(%rbp), %rcx
	movq	%r12, %r9
	callq	fread
	cmpq	$1, %rax
	jne	.LBB0_162
# %bb.126:                              #   in Loop: Header=BB0_115 Depth=3
	movq	240(%rbp), %rsi
	testq	%rsi, %rsi
	je	.LBB0_162
# %bb.127:                              #   in Loop: Header=BB0_115 Depth=3
	cmpq	$1024, %rsi                     # imm = 0x400
	ja	.LBB0_162
# %bb.128:                              #   in Loop: Header=BB0_115 Depth=3
	xorl	%r13d, %r13d
.LBB0_129:                              #   Parent Loop BB0_113 Depth=1
                                        #     Parent Loop BB0_114 Depth=2
                                        #       Parent Loop BB0_115 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	$8, %edx
	movl	$8, %r8d
	movq	%rdi, %rcx
	movq	%r12, %rbx
	movq	%r12, %r9
	callq	fread
	cmpq	$8, %rax
	jne	.LBB0_162
# %bb.130:                              #   in Loop: Header=BB0_129 Depth=4
	movq	32(%rbp), %rax
	leaq	-268435457(%rax), %rcx
	cmpq	$-268435456, %rcx               # imm = 0xF0000000
	jb	.LBB0_162
# %bb.131:                              #   in Loop: Header=BB0_129 Depth=4
	movq	40(%rbp), %rcx
	cmpq	%rax, %rcx
	jb	.LBB0_162
# %bb.132:                              #   in Loop: Header=BB0_129 Depth=4
	cmpq	$536870912, %rcx                # imm = 0x20000000
	ja	.LBB0_162
# %bb.133:                              #   in Loop: Header=BB0_129 Depth=4
	movq	48(%rbp), %r12
	leaq	-2049(%r12), %rdx
	cmpq	$-2048, %rdx                    # imm = 0xF800
	jb	.LBB0_162
# %bb.134:                              #   in Loop: Header=BB0_129 Depth=4
	movq	56(%rbp), %rdi
	leaq	63(%rcx), %rdx
	shrq	$6, %rdx
	cmpq	%rdx, %rdi
	jne	.LBB0_162
# %bb.135:                              #   in Loop: Header=BB0_129 Depth=4
	movq	%rax, 128(%rbp)
	movq	%rcx, 136(%rbp)
	movq	%r12, 144(%rbp)
	movq	%rdi, 152(%rbp)
	movapd	64(%rbp), %xmm0
	movapd	80(%rbp), %xmm1
	movupd	%xmm0, 160(%rbp)
	movupd	%xmm1, 176(%rbp)
	movq	%r12, %rcx
	shlq	$4, %rcx
	callq	malloc
	movq	%rax, %r14
	movq	%rax, 192(%rbp)
	leaq	8(,%rdi,8), %rcx
	callq	malloc
	movq	%rax, 200(%rbp)
	testq	%r14, %r14
	je	.LBB0_162
# %bb.136:                              #   in Loop: Header=BB0_129 Depth=4
	movq	%rax, %r15
	testq	%rax, %rax
	je	.LBB0_162
# %bb.137:                              #   in Loop: Header=BB0_129 Depth=4
	movl	$16, %edx
	movq	%r14, %rcx
	movq	%r12, %r8
	movq	%rbx, %r9
	callq	fread
	cmpq	%r12, %rax
	jne	.LBB0_160
# %bb.138:                              #   in Loop: Header=BB0_129 Depth=4
	movq	%rbx, %r12
	movl	$8, %edx
	movq	%r15, %rcx
	movq	%rdi, %r8
	movq	%rbx, %r9
	callq	fread
	cmpq	%rdi, %rax
	jne	.LBB0_160
# %bb.139:                              #   in Loop: Header=BB0_129 Depth=4
	movq	$0, (%r15,%rdi,8)
	leaq	32(%rbp), %rdi
	movq	%rdi, %rcx
	leaq	128(%rbp), %rdx
	movq	232(%rbp), %r8                  # 8-byte Reload
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%rbp, %r9
	callq	check
	movq	%r14, %rcx
	callq	free
	movq	%r15, %rcx
	callq	free
	cmpl	$0, 32(%rbp)
	je	.LBB0_162
# %bb.140:                              #   in Loop: Header=BB0_129 Depth=4
	movl	36(%rbp), %eax
	addq	%rax, %r13
	decq	%rsi
	jne	.LBB0_129
# %bb.141:                              #   in Loop: Header=BB0_115 Depth=3
	movq	%r12, %rcx
	callq	fclose
	testq	%r13, %r13
	je	.LBB0_162
# %bb.142:                              #   in Loop: Header=BB0_115 Depth=3
	addq	%r13, 96(%rbp)
	movl	208(%rbp), %eax                 # 4-byte Reload
	incl	%eax
	movl	%eax, 208(%rbp)                 # 4-byte Spill
	cmpl	$3, %eax
	movq	24(%rbp), %r14                  # 8-byte Reload
	movq	__imp_QueryPerformanceFrequency(%rip), %r15
	leaq	.str.7(%rip), %r12
	jne	.LBB0_115
# %bb.143:                              #   in Loop: Header=BB0_114 Depth=2
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	248(%rbp), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	leaq	128(%rbp), %rsi
	movq	%rsi, %rdx
	movq	%rdi, %r8
	leaq	240(%rbp), %r9
	callq	*__imp_GetProcessTimes(%rip)
	movl	248(%rbp), %eax
	movl	252(%rbp), %ecx
	shlq	$32, %rcx
	addq	240(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	%xmm6, %xmm0            # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1]
	subpd	%xmm7, %xmm0
	movapd	%xmm0, %xmm11
	unpckhpd	%xmm0, %xmm11                   # xmm11 = xmm11[1],xmm0[1]
	addsd	%xmm0, %xmm11
	mulsd	%xmm8, %xmm11
	subsd	%xmm9, %xmm11
	movq	%rsi, %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %r13
	leaq	.str.7(%rip), %r12
	callq	*%r13
	movq	%rdi, %rcx
	callq	*%r15
	xorps	%xmm0, %xmm0
	cvtsi2sdq	128(%rbp), %xmm0
	cvtsi2sdq	32(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	subsd	%xmm10, %xmm0
	movq	216(%rbp), %rax                 # 8-byte Reload
	leal	1(%rax), %esi
	testl	%eax, %eax
	leaq	.str.2(%rip), %rdx
	leaq	.str.3(%rip), %rax
	cmoveq	%rax, %rdx
	movsd	%xmm11, 56(%rsp)
	movsd	%xmm0, 48(%rsp)
	movq	-8(%rbp), %rax                  # 8-byte Reload
	movq	%rax, 40(%rsp)
	movl	$3, 32(%rsp)
	leaq	.str.5(%rip), %rcx
	movq	232(%rbp), %r8                  # 8-byte Reload
                                        # kill: def $r8d killed $r8d killed $r8
	movl	120(%rbp), %r13d                # 4-byte Reload
	movl	%r13d, %r9d
	callq	printf
	incl	%r13d
	movl	%esi, %eax
	movq	%rax, 216(%rbp)                 # 8-byte Spill
	cmpl	$3, %r13d
	jne	.LBB0_114
# %bb.144:                              #   in Loop: Header=BB0_113 Depth=1
	movq	232(%rbp), %rax                 # 8-byte Reload
	incl	%eax
	movq	%rax, 232(%rbp)                 # 8-byte Spill
	cmpl	$10, %eax
	jne	.LBB0_113
# %bb.145:
	movq	96(%rbp), %rdx
	leaq	.str.6(%rip), %rcx
	callq	printf
	cmpq	$0, 224(%rbp)                   # 8-byte Folded Reload
	je	.LBB0_148
# %bb.146:
	movq	112(%rbp), %rax                 # 8-byte Reload
	leaq	72(%rax), %rsi
.LBB0_147:                              # =>This Inner Loop Header: Depth=1
	movq	-8(%rsi), %rcx
	callq	free
	movq	(%rsi), %rcx
	callq	free
	addq	$80, %rsi
	decq	224(%rbp)                       # 8-byte Folded Spill
	jne	.LBB0_147
.LBB0_148:
	movq	112(%rbp), %rcx                 # 8-byte Reload
	callq	free
	movq	(%rbp), %rcx
	callq	free
	movq	8(%rbp), %rcx
	callq	free
	xorl	%r13d, %r13d
	jmp	.LBB0_150
.LBB0_149:
	movl	$9, %r13d
.LBB0_150:
	movl	%r13d, %eax
	movaps	256(%rbp), %xmm6                # 16-byte Reload
	movaps	272(%rbp), %xmm7                # 16-byte Reload
	movaps	288(%rbp), %xmm8                # 16-byte Reload
	movaps	304(%rbp), %xmm9                # 16-byte Reload
	movaps	320(%rbp), %xmm10               # 16-byte Reload
	movaps	336(%rbp), %xmm11               # 16-byte Reload
	movaps	352(%rbp), %xmm12               # 16-byte Reload
	movaps	368(%rbp), %xmm13               # 16-byte Reload
	movaps	384(%rbp), %xmm14               # 16-byte Reload
	.seh_startepilogue
	addq	$536, %rsp                      # imm = 0x218
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.seh_endepilogue
	retq
.LBB0_158:
	movl	$7, %r13d
	jmp	.LBB0_150
.LBB0_159:
	movl	$8, %r13d
	jmp	.LBB0_150
.LBB0_160:
	movq	%r14, %rcx
	callq	free
	movq	%r15, %rcx
	callq	free
.LBB0_162:
	movl	$10, %r13d
	jmp	.LBB0_150
	.seh_endproc
                                        # -- End function
	.def	check;
	.scl	3;
	.type	32;
	.endef
	.section	.text$check,"xr",one_only,check,unique,1
	.p2align	4                               # -- Begin function check
check:                                  # @check
.seh_proc check
# %bb.0:
	pushq	%r15
	.seh_pushreg %r15
	pushq	%r14
	.seh_pushreg %r14
	pushq	%r13
	.seh_pushreg %r13
	pushq	%r12
	.seh_pushreg %r12
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbp
	.seh_pushreg %rbp
	pushq	%rbx
	.seh_pushreg %rbx
	subq	$280, %rsp                      # imm = 0x118
	.seh_stackalloc 280
	.seh_endprologue
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rcx)
	movq	$0, 16(%rcx)
	movq	(%rdx), %rbx
	testq	%rbx, %rbx
	je	.LBB1_14
# %bb.1:
	movq	8(%rdx), %r10
	movq	%r10, %rax
	subq	%rbx, %rax
	jb	.LBB1_14
# %bb.2:
	addq	$63, %r10
	shrq	$6, %r10
	cmpq	%r10, 24(%rdx)
	jne	.LBB1_14
# %bb.3:
	movq	16(%rdx), %r10
	leaq	-2049(%r10), %r11
	cmpq	$-2048, %r11                    # imm = 0xF800
	jb	.LBB1_14
# %bb.4:
	movq	32(%rdx), %r11
	testb	$1, %r11b
	jne	.LBB1_14
# %bb.5:
	movq	40(%rdx), %rsi
	testb	$1, %sil
	jne	.LBB1_6
.LBB1_14:
	movl	$1, 16(%rcx)
.LBB1_82:
	.seh_startepilogue
	addq	$280, %rsp                      # imm = 0x118
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	.seh_endepilogue
	retq
.LBB1_6:
	movq	64(%rdx), %rdi
	addq	$8, %rdi
.LBB1_8:                                # =>This Inner Loop Header: Depth=1
	movq	-8(%rdi), %r15
	movq	%r11, %r14
	subq	%r15, %r14
	jb	.LBB1_14
# %bb.9:                                #   in Loop: Header=BB1_8 Depth=1
	cmpq	$3, %r15
	jb	.LBB1_14
# %bb.10:                               #   in Loop: Header=BB1_8 Depth=1
	andl	$1, %r15d
	je	.LBB1_14
# %bb.11:                               #   in Loop: Header=BB1_8 Depth=1
	movq	(%rdi), %r15
	cmpq	%rax, %r15
	ja	.LBB1_14
# %bb.12:                               #   in Loop: Header=BB1_8 Depth=1
	subq	%rsi, %r14
	jb	.LBB1_14
# %bb.13:                               #   in Loop: Header=BB1_8 Depth=1
	addq	%r15, %r15
	cmpq	%r15, %r14
	jne	.LBB1_14
# %bb.7:                                #   in Loop: Header=BB1_8 Depth=1
	addq	$16, %rdi
	decq	%r10
	jne	.LBB1_8
# %bb.15:
	cmpl	$8, %r8d
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	jb	.LBB1_20
# %bb.16:
	movl	$65536, %eax                    # imm = 0x10000
	movl	$262144, %r8d                   # imm = 0x40000
	cmoveq	%rax, %r8
	movl	$1, (%rcx)
	leal	(%r8,%r8), %eax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	xorl	%r13d, %r13d
	xorl	%ebp, %ebp
	xorl	%esi, %esi
	xorl	%edi, %edi
	xorl	%r14d, %r14d
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
.LBB1_17:                               # =>This Inner Loop Header: Depth=1
	movups	(%rdx), %xmm0
	movups	16(%rdx), %xmm1
	movups	32(%rdx), %xmm2
	movups	48(%rdx), %xmm3
	movaps	%xmm0, 192(%rsp)
	movaps	%xmm1, 208(%rsp)
	movups	64(%rdx), %xmm0
	movaps	%xmm0, 256(%rsp)
	movaps	%xmm2, 224(%rsp)
	movaps	%xmm3, 240(%rsp)
	addq	%rsi, %rbx
	cmpq	%r8, %rbx
	movq	%r8, %r12
	cmovaeq	%r8, %rbx
	movq	%rbx, 192(%rsp)
	movq	200(%rsp), %rax
	leaq	(%rsi,%rax), %rcx
	movq	%rcx, 200(%rsp)
	addq	%rsi, %rax
	addq	$63, %rax
	shrq	$6, %rax
	movq	%rax, 216(%rsp)
	movq	%r13, %rax
	shrq	$3, %rax
	addq	%rax, 264(%rsp)
	addq	%rbp, 232(%rsp)
	addq	%rbp, 224(%rsp)
	leaq	168(%rsp), %rcx
	leaq	192(%rsp), %rdx
	movl	$4, %r8d
	movq	%r9, %r15
	callq	check
	movq	56(%rsp), %rax                  # 8-byte Reload
	addq	176(%rsp), %r14
	movq	%r14, 8(%rax)
	cmpl	$0, 168(%rsp)
	je	.LBB1_18
# %bb.19:                               #   in Loop: Header=BB1_17 Depth=1
	movl	172(%rsp), %ecx
	cmpl	%edi, %ecx
	cmoval	%ecx, %edi
	movl	%edi, 4(%rax)
	movq	%r12, %r8
	addq	%r12, %r13
	movq	64(%rsp), %rdx                  # 8-byte Reload
	movq	(%rdx), %rbx
	subq	%r12, %rsi
	addq	40(%rsp), %rbp                  # 8-byte Folded Reload
	cmpq	%rbx, %r13
	movq	%r15, %r9
	jb	.LBB1_17
	jmp	.LBB1_82
.LBB1_20:
	movl	%r8d, %ebp
	movq	%rdx, %r14
	addq	$63, %rbx
	movq	%rbx, %rdi
	shrq	$6, %rdi
	movq	(%r9), %rcx
	cmpq	%rdi, 16(%r9)
	jae	.LBB1_21
# %bb.25:
	movq	%r9, %r15
	callq	free
	movq	8(%r15), %rcx
	callq	free
	leaq	(,%rdi,8), %rsi
	movq	%rsi, %rcx
	callq	malloc
	movq	%rdi, %r12
	movq	%rax, %rdi
	movq	%rax, (%r15)
	leaq	(,%r12,4), %rcx
	callq	malloc
	movq	%rdi, %rcx
	movq	%rax, 8(%r15)
	movq	%r12, 16(%r15)
	testq	%rdi, %rdi
	je	.LBB1_27
# %bb.26:
	movq	%r12, %rdi
	movq	%r15, %r9
	testq	%rax, %rax
	jne	.LBB1_22
.LBB1_27:
	movq	56(%rsp), %rax                  # 8-byte Reload
	movl	$1, 16(%rax)
	jmp	.LBB1_82
.LBB1_18:
	movl	$0, (%rax)
	movl	184(%rsp), %ecx
	movl	%ecx, 16(%rax)
	jmp	.LBB1_82
.LBB1_21:
	leaq	(,%rdi,8), %rsi
.LBB1_22:
	movq	%r9, 80(%rsp)                   # 8-byte Spill
	xorl	%r15d, %r15d
	xorl	%edx, %edx
	movq	%rsi, %r8
	callq	memset
	movq	%r14, 64(%rsp)                  # 8-byte Spill
	movq	(%r14), %rcx
	andl	$63, %ecx
	movq	$-1, %rax
	shlq	%cl, %rax
	cmpq	$1, %rcx
	sbbq	%r15, %r15
	movq	%r15, 88(%rsp)                  # 8-byte Spill
	xorl	%r8d, %r8d
	movl	%ebp, 76(%rsp)                  # 4-byte Spill
	cmpl	$1, %ebp
	setne	%cl
	sete	%dl
	testq	%rdi, %rdi
	sete	%r9b
	orb	%cl, %r9b
	jne	.LBB1_32
# %bb.23:
	movq	80(%rsp), %rcx                  # 8-byte Reload
	movq	8(%rcx), %rcx
	movl	%edi, %r9d
	andl	$7, %r9d
	cmpq	$512, %rbx                      # imm = 0x200
	jae	.LBB1_28
# %bb.24:
	xorl	%r10d, %r10d
	jmp	.LBB1_31
.LBB1_28:
	movq	%rdi, %r11
	andq	$-8, %r11
	xorl	%r10d, %r10d
.LBB1_29:                               # =>This Inner Loop Header: Depth=1
	movl	%r10d, (%rcx,%r10,4)
	leal	1(%r10), %esi
	movl	%esi, 4(%rcx,%r10,4)
	leal	2(%r10), %esi
	movl	%esi, 8(%rcx,%r10,4)
	leal	3(%r10), %esi
	movl	%esi, 12(%rcx,%r10,4)
	leal	4(%r10), %esi
	movl	%esi, 16(%rcx,%r10,4)
	leal	5(%r10), %esi
	movl	%esi, 20(%rcx,%r10,4)
	leal	6(%r10), %esi
	movl	%esi, 24(%rcx,%r10,4)
	leal	7(%r10), %esi
	movl	%esi, 28(%rcx,%r10,4)
	addq	$8, %r10
	cmpq	%r11, %r10
	jne	.LBB1_29
# %bb.30:
	testq	%r9, %r9
	je	.LBB1_32
.LBB1_31:                               # =>This Inner Loop Header: Depth=1
	movl	%r10d, (%rcx,%r10,4)
	incq	%r10
	decq	%r9
	jne	.LBB1_31
.LBB1_32:
	movq	64(%rsp), %rcx                  # 8-byte Reload
	cmpq	$0, 16(%rcx)
	movq	56(%rsp), %rcx                  # 8-byte Reload
	je	.LBB1_82
# %bb.33:
	notq	%rax
	orq	%rax, 88(%rsp)                  # 8-byte Folded Spill
	movb	%dl, %r8b
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	64(%rax), %rdx
	movq	%rdx, 160(%rsp)                 # 8-byte Spill
	movq	72(%rax), %rax
	movl	76(%rsp), %edx                  # 4-byte Reload
	movq	%rdx, 144(%rsp)                 # 8-byte Spill
	leaq	-1(%rdi), %r9
	leaq	-2(%rdi), %rdx
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	movq	%r9, 40(%rsp)                   # 8-byte Spill
	movq	%r9, %r13
	andq	$-2, %r13
	leaq	16(%rax), %rdx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 152(%rsp)                 # 8-byte Spill
	addq	$8, %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	xorl	%r12d, %r12d
	movq	$0, 48(%rsp)                    # 8-byte Folded Spill
	movq	%rdi, %r15
	movq	%r13, 104(%rsp)                 # 8-byte Spill
	movq	%rdi, 112(%rsp)                 # 8-byte Spill
.LBB1_34:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_84 Depth 2
                                        #     Child Loop BB1_74 Depth 2
                                        #     Child Loop BB1_43 Depth 2
                                        #     Child Loop BB1_58 Depth 2
	movq	%r12, %rax
	shlq	$4, %rax
	movq	160(%rsp), %rdx                 # 8-byte Reload
	movq	8(%rdx,%rax), %rax
	movq	%rax, %rsi
	shrq	$6, %rsi
	movl	%eax, %edx
	andl	$63, %edx
	movq	152(%rsp), %r9                  # 8-byte Reload
	leaq	(%r9,%rsi,8), %r11
	cmpl	$2, 76(%rsp)                    # 4-byte Folded Reload
	jb	.LBB1_54
# %bb.35:                               #   in Loop: Header=BB1_34 Depth=1
	movq	144(%rsp), %r9                  # 8-byte Reload
	leaq	switch_at(%rip), %r10
	movl	(%r10,%r9,4), %r9d
	cmpq	%r9, %r12
	jne	.LBB1_54
# %bb.36:                               #   in Loop: Header=BB1_34 Depth=1
	testq	%rdi, %rdi
	je	.LBB1_37
# %bb.38:                               #   in Loop: Header=BB1_34 Depth=1
	movq	80(%rsp), %r15                  # 8-byte Reload
	movq	(%r15), %r8
	cmpq	$0, 40(%rsp)                    # 8-byte Folded Reload
	je	.LBB1_39
# %bb.40:                               #   in Loop: Header=BB1_34 Depth=1
	cmpq	$0, 96(%rsp)                    # 8-byte Folded Reload
	je	.LBB1_41
# %bb.42:                               #   in Loop: Header=BB1_34 Depth=1
	xorl	%r9d, %r9d
	xorl	%r10d, %r10d
	jmp	.LBB1_43
.LBB1_47:                               #   in Loop: Header=BB1_43 Depth=2
	addq	$2, %r10
	cmpq	%r10, %r13
	je	.LBB1_48
.LBB1_43:                               #   Parent Loop BB1_34 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	$-1, (%r8,%r10,8)
	je	.LBB1_45
# %bb.44:                               #   in Loop: Header=BB1_43 Depth=2
	movq	8(%r15), %rsi
	movl	%r10d, (%rsi,%r9,4)
	incq	%r9
.LBB1_45:                               #   in Loop: Header=BB1_43 Depth=2
	cmpq	$-1, 8(%r8,%r10,8)
	je	.LBB1_47
# %bb.46:                               #   in Loop: Header=BB1_43 Depth=2
	leal	1(%r10), %esi
	movq	8(%r15), %r14
	movl	%esi, (%r14,%r9,4)
	incq	%r9
	jmp	.LBB1_47
.LBB1_54:                               #   in Loop: Header=BB1_34 Depth=1
	testl	%r8d, %r8d
	je	.LBB1_67
# %bb.55:                               #   in Loop: Header=BB1_34 Depth=1
	movq	%r15, %r9
	jmp	.LBB1_56
.LBB1_67:                               #   in Loop: Header=BB1_34 Depth=1
	movq	%r12, 136(%rsp)                 # 8-byte Spill
	movq	48(%rsp), %r9                   # 8-byte Reload
	addq	%rdi, %r9
	movq	%r9, 48(%rsp)                   # 8-byte Spill
	movq	%r9, 8(%rcx)
	movq	80(%rsp), %rcx                  # 8-byte Reload
	movq	(%rcx), %r10
	cmpq	$128, %rbx
	jb	.LBB1_78
# %bb.68:                               #   in Loop: Header=BB1_34 Depth=1
	movl	%eax, %r8d
	andl	$63, %r8d
	testl	%edx, %edx
	je	.LBB1_71
# %bb.69:                               #   in Loop: Header=BB1_34 Depth=1
	movl	$64, %r9d
	subl	%edx, %r9d
	cmpq	$0, 96(%rsp)                    # 8-byte Folded Reload
	je	.LBB1_70
# %bb.83:                               #   in Loop: Header=BB1_34 Depth=1
	movq	128(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rsi,8), %r14
	xorl	%ebp, %ebp
	xorl	%esi, %esi
.LBB1_84:                               #   Parent Loop BB1_34 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-16(%r14,%rsi,8), %r12
	movq	-8(%r14,%rsi,8), %r13
	movl	%r9d, %ecx
	shlq	%cl, %r13
	movl	%r8d, %ecx
	shrq	%cl, %r12
	orq	(%r10,%rsi,8), %r12
	orq	%r13, %r12
	movq	%r12, (%r10,%rsi,8)
	movq	-8(%r14,%rsi,8), %r13
	movq	(%r14,%rsi,8), %rdi
	movl	%r9d, %ecx
	shlq	%cl, %rdi
	movl	%r8d, %ecx
	shrq	%cl, %r13
	orq	8(%r10,%rsi,8), %r13
	orq	%rdi, %r13
	movq	%r13, 8(%r10,%rsi,8)
	andq	%r12, %r13
	notq	%r13
	orq	%r13, %rbp
	addq	$2, %rsi
	cmpq	%rsi, 104(%rsp)                 # 8-byte Folded Reload
	jne	.LBB1_84
# %bb.85:                               #   in Loop: Header=BB1_34 Depth=1
	testb	$1, 40(%rsp)                    # 1-byte Folded Reload
	jne	.LBB1_86
	jmp	.LBB1_87
.LBB1_78:                               #   in Loop: Header=BB1_34 Depth=1
	movq	40(%rsp), %rcx                  # 8-byte Reload
	leaq	(%r10,%rcx,8), %r8
	movq	-8(%r10,%rdi,8), %rsi
	movq	-8(%r11,%rdi,8), %r10
	movl	$0, %ebp
	movl	$0, %r9d
	movl	$0, %r14d
	testl	%edx, %edx
	jne	.LBB1_79
	jmp	.LBB1_80
.LBB1_48:                               #   in Loop: Header=BB1_34 Depth=1
	testb	$1, 40(%rsp)                    # 1-byte Folded Reload
	jne	.LBB1_49
	jmp	.LBB1_52
.LBB1_39:                               #   in Loop: Header=BB1_34 Depth=1
	xorl	%r9d, %r9d
	xorl	%r10d, %r10d
	jmp	.LBB1_52
.LBB1_41:                               #   in Loop: Header=BB1_34 Depth=1
	xorl	%r9d, %r9d
	xorl	%r10d, %r10d
.LBB1_49:                               #   in Loop: Header=BB1_34 Depth=1
	cmpq	$-1, (%r8,%r10,8)
	je	.LBB1_51
# %bb.50:                               #   in Loop: Header=BB1_34 Depth=1
	movq	8(%r15), %rsi
	movl	%r10d, (%rsi,%r9,4)
	incq	%r9
.LBB1_51:                               #   in Loop: Header=BB1_34 Depth=1
	incq	%r10
.LBB1_52:                               #   in Loop: Header=BB1_34 Depth=1
	movq	(%r8,%r10,8), %r8
	notq	%r8
	cmpq	40(%rsp), %r10                  # 8-byte Folded Reload
	movq	$-1, %rsi
	cmoveq	88(%rsp), %rsi                  # 8-byte Folded Reload
	testq	%rsi, %r8
	je	.LBB1_56
# %bb.53:                               #   in Loop: Header=BB1_34 Depth=1
	movq	8(%r15), %r8
	movl	%r10d, (%r8,%r9,4)
	incq	%r9
.LBB1_56:                               #   in Loop: Header=BB1_34 Depth=1
	movq	48(%rsp), %r8                   # 8-byte Reload
	addq	%r9, %r8
	movq	%r8, 48(%rsp)                   # 8-byte Spill
	movq	%r8, 8(%rcx)
	testq	%r9, %r9
	je	.LBB1_66
# %bb.57:                               #   in Loop: Header=BB1_34 Depth=1
	movq	%r12, %rdi
	movq	80(%rsp), %rcx                  # 8-byte Reload
	movq	(%rcx), %r10
	movq	8(%rcx), %rsi
	movl	$64, %r8d
	subl	%edx, %r8d
	andl	$63, %eax
	xorl	%r14d, %r14d
	xorl	%r15d, %r15d
	jmp	.LBB1_58
	.p2align	4
.LBB1_63:                               #   in Loop: Header=BB1_58 Depth=2
	movq	56(%rsp), %rcx                  # 8-byte Reload
	incq	%r14
	cmpq	%r14, %r9
	je	.LBB1_64
.LBB1_58:                               #   Parent Loop BB1_34 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%rsi,%r14,4), %ebp
	testl	%edx, %edx
	je	.LBB1_59
# %bb.60:                               #   in Loop: Header=BB1_58 Depth=2
	movq	8(%r11,%rbp,8), %r12
	movl	%r8d, %ecx
	shlq	%cl, %r12
	jmp	.LBB1_61
.LBB1_59:                               #   in Loop: Header=BB1_58 Depth=2
	xorl	%r12d, %r12d
.LBB1_61:                               #   in Loop: Header=BB1_58 Depth=2
	movq	(%r11,%rbp,8), %r13
	movl	%eax, %ecx
	shrq	%cl, %r13
	orq	(%r10,%rbp,8), %r12
	orq	%r13, %r12
	movq	%r12, (%r10,%rbp,8)
	notq	%r12
	cmpq	%rbp, 40(%rsp)                  # 8-byte Folded Reload
	movq	$-1, %rcx
	cmoveq	88(%rsp), %rcx                  # 8-byte Folded Reload
	testq	%rcx, %r12
	je	.LBB1_63
# %bb.62:                               #   in Loop: Header=BB1_58 Depth=2
	movl	%ebp, (%rsi,%r15,4)
	incq	%r15
	jmp	.LBB1_63
.LBB1_64:                               #   in Loop: Header=BB1_34 Depth=1
	movl	$1, %r8d
	testq	%r15, %r15
	movq	%rdi, %r12
	movq	112(%rsp), %rdi                 # 8-byte Reload
	jmp	.LBB1_65
.LBB1_71:                               #   in Loop: Header=BB1_34 Depth=1
	cmpq	$0, 96(%rsp)                    # 8-byte Folded Reload
	je	.LBB1_72
# %bb.73:                               #   in Loop: Header=BB1_34 Depth=1
	movq	120(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rsi,8), %rsi
	xorl	%r9d, %r9d
	xorl	%edx, %edx
.LBB1_74:                               #   Parent Loop BB1_34 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rsi,%rdx,8), %r14
	movl	%r8d, %ecx
	shrq	%cl, %r14
	orq	(%r10,%rdx,8), %r14
	movq	%r14, (%r10,%rdx,8)
	movq	(%rsi,%rdx,8), %r12
	shrq	%cl, %r12
	orq	8(%r10,%rdx,8), %r12
	movq	%r12, 8(%r10,%rdx,8)
	andq	%r14, %r12
	notq	%r12
	orq	%r12, %r9
	addq	$2, %rdx
	cmpq	%rdx, %r13
	jne	.LBB1_74
# %bb.75:                               #   in Loop: Header=BB1_34 Depth=1
	testb	$1, 40(%rsp)                    # 1-byte Folded Reload
	jne	.LBB1_76
	jmp	.LBB1_77
.LBB1_70:                               #   in Loop: Header=BB1_34 Depth=1
	xorl	%esi, %esi
	xorl	%ebp, %ebp
.LBB1_86:                               #   in Loop: Header=BB1_34 Depth=1
	movq	%rbp, %rdi
	movq	(%r11,%rsi,8), %rbp
	movq	8(%r11,%rsi,8), %r14
	movl	%r9d, %ecx
	shlq	%cl, %r14
	movl	%r8d, %ecx
	shrq	%cl, %rbp
	orq	(%r10,%rsi,8), %rbp
	orq	%r14, %rbp
	movq	%rbp, (%r10,%rsi,8)
	notq	%rbp
	orq	%rdi, %rbp
.LBB1_87:                               #   in Loop: Header=BB1_34 Depth=1
	movq	40(%rsp), %rcx                  # 8-byte Reload
	leaq	(%r10,%rcx,8), %r8
	movq	112(%rsp), %rdi                 # 8-byte Reload
	movq	-8(%r10,%rdi,8), %rsi
	movq	-8(%r11,%rdi,8), %r10
.LBB1_79:                               #   in Loop: Header=BB1_34 Depth=1
	movq	(%r11,%rdi,8), %r14
	negb	%dl
	movl	%edx, %ecx
	shlq	%cl, %r14
	movq	%rbp, %r9
	jmp	.LBB1_80
.LBB1_72:                               #   in Loop: Header=BB1_34 Depth=1
	xorl	%edx, %edx
	xorl	%r9d, %r9d
.LBB1_76:                               #   in Loop: Header=BB1_34 Depth=1
	movq	%r9, %rsi
	movq	(%r11,%rdx,8), %r9
	movl	%r8d, %ecx
	shrq	%cl, %r9
	orq	(%r10,%rdx,8), %r9
	movq	%r9, (%r10,%rdx,8)
	notq	%r9
	orq	%rsi, %r9
.LBB1_77:                               #   in Loop: Header=BB1_34 Depth=1
	movq	40(%rsp), %rcx                  # 8-byte Reload
	leaq	(%r10,%rcx,8), %r8
	movq	-8(%r10,%rdi,8), %rsi
	movq	-8(%r11,%rdi,8), %r10
	xorl	%r14d, %r14d
.LBB1_80:                               #   in Loop: Header=BB1_34 Depth=1
	movl	%eax, %ecx
	shrq	%cl, %r10
	orq	%r14, %rsi
	orq	%rsi, %r10
	movq	%r10, (%r8)
	notq	%r10
	andq	88(%rsp), %r10                  # 8-byte Folded Reload
	xorl	%r8d, %r8d
	orq	%r9, %r10
	movq	56(%rsp), %rcx                  # 8-byte Reload
	movq	136(%rsp), %r12                 # 8-byte Reload
.LBB1_65:                               #   in Loop: Header=BB1_34 Depth=1
	movq	104(%rsp), %r13                 # 8-byte Reload
	je	.LBB1_66
# %bb.81:                               #   in Loop: Header=BB1_34 Depth=1
	incq	%r12
	movq	64(%rsp), %rax                  # 8-byte Reload
	cmpq	16(%rax), %r12
	jb	.LBB1_34
	jmp	.LBB1_82
.LBB1_37:
	movq	48(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 8(%rcx)
.LBB1_66:
	movl	$1, (%rcx)
	incl	%r12d
	movl	%r12d, 4(%rcx)
	jmp	.LBB1_82
	.seh_endproc
                                        # -- End function
	.def	read_case;
	.scl	3;
	.type	32;
	.endef
	.section	.text$read_case,"xr",one_only,read_case,unique,2
	.p2align	4                               # -- Begin function read_case
read_case:                              # @read_case
.seh_proc read_case
# %bb.0:
	pushq	%r15
	.seh_pushreg %r15
	pushq	%r14
	.seh_pushreg %r14
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbx
	.seh_pushreg %rbx
	subq	$96, %rsp
	.seh_stackalloc 96
	.seh_endprologue
	movq	%rdx, %rsi
	movq	%rcx, %rdi
	leaq	32(%rsp), %rcx
	movl	$8, %edx
	movl	$8, %r8d
	movq	%rdi, %r9
	callq	fread
	movq	%rax, %rcx
	xorl	%eax, %eax
	cmpq	$8, %rcx
	jne	.LBB2_12
# %bb.1:
	movq	32(%rsp), %rcx
	leaq	-268435457(%rcx), %rdx
	cmpq	$-268435456, %rdx               # imm = 0xF0000000
	jb	.LBB2_12
# %bb.2:
	movq	40(%rsp), %rdx
	movq	48(%rsp), %rbx
	cmpq	%rcx, %rdx
	setb	%r8b
	cmpq	$536870913, %rdx                # imm = 0x20000001
	setae	%r9b
	leaq	-2049(%rbx), %r10
	cmpq	$-2048, %r10                    # imm = 0xF800
	setb	%r10b
	orb	%r8b, %r9b
	orb	%r10b, %r9b
	jne	.LBB2_12
# %bb.3:
	movq	56(%rsp), %r15
	leaq	63(%rdx), %r8
	shrq	$6, %r8
	cmpq	%r8, %r15
	jne	.LBB2_12
# %bb.4:
	movq	%rcx, (%rsi)
	movq	%rdx, 8(%rsi)
	movq	%rbx, 16(%rsi)
	movq	%r15, 24(%rsi)
	movq	64(%rsp), %rax
	movq	%rax, 32(%rsi)
	movq	72(%rsp), %rax
	movq	%rax, 40(%rsi)
	movq	80(%rsp), %rax
	movq	%rax, 48(%rsi)
	movq	88(%rsp), %rax
	movq	%rax, 56(%rsi)
	movq	%rbx, %rcx
	shlq	$4, %rcx
	callq	malloc
	movq	%rax, %r14
	movq	%rax, 64(%rsi)
	leaq	8(,%r15,8), %rcx
	callq	malloc
	movq	%rax, 72(%rsi)
	testq	%r14, %r14
	je	.LBB2_11
# %bb.5:
	testq	%rax, %rax
	je	.LBB2_11
# %bb.6:
	movl	$16, %edx
	movq	%r14, %rcx
	movq	%rbx, %r8
	movq	%rdi, %r9
	callq	fread
	cmpq	16(%rsi), %rax
	jne	.LBB2_9
# %bb.7:
	movq	24(%rsi), %r8
	movq	72(%rsi), %rcx
	movl	$8, %edx
	movq	%rdi, %r9
	callq	fread
	cmpq	24(%rsi), %rax
	jne	.LBB2_9
# %bb.8:
	movq	72(%rsi), %rcx
	movq	$0, (%rcx,%rax,8)
	movl	$1, %eax
	jmp	.LBB2_12
.LBB2_9:
	movq	64(%rsi), %rcx
	callq	free
	movq	72(%rsi), %rcx
	callq	free
.LBB2_11:
	xorl	%eax, %eax
.LBB2_12:
	.seh_startepilogue
	addq	$96, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r14
	popq	%r15
	.seh_endepilogue
	retq
	.seh_endproc
                                        # -- End function
	.section	.rdata,"dr",one_only,.str,unique,3
.str:                                   # @.str
	.asciz	"{\"cases\":%llu,\"initial_load_seconds\":%.9f,\"positive_checks\":%u,\"negative_checks\":%u,\"prime_certificates_checked\":false,\"loaded\":["

	.section	.rdata,"dr",one_only,.str.1,unique,4
.str.1:                                 # @.str.1
	.asciz	"%s{\"mode\":%u,\"width\":%llu,\"trial\":%u,\"cases\":%u,\"reps\":%u,\"bits_per_sweep\":%llu,\"updates_per_sweep\":%llu,\"prefix_sum\":%llu,\"wall_seconds\":%.9f,\"cpu_seconds\":%.9f}"

	.section	.rdata,"dr",one_only,.str.2,unique,5
.str.2:                                 # @.str.2
	.asciz	","

	.section	.rdata,"dr",one_only,.str.3,unique,6
.str.3:                                 # @.str.3
	.zero	1

	.section	.rdata,"dr",one_only,.str.4,unique,7
.str.4:                                 # @.str.4
	.asciz	"],\"stream_parse\":["

	.section	.rdata,"dr",one_only,.str.5,unique,8
.str.5:                                 # @.str.5
	.asciz	"%s{\"mode\":%u,\"trial\":%u,\"reps\":%u,\"bits_per_sweep\":%llu,\"wall_seconds\":%.9f,\"cpu_seconds\":%.9f}"

	.section	.rdata,"dr",one_only,.str.6,unique,9
.str.6:                                 # @.str.6
	.asciz	"],\"checksum\":%llu}\n"

	.section	.rdata,"dr",one_only,.str.7,unique,10
.str.7:                                 # @.str.7
	.asciz	"rb"

	.section	.rdata$switch_at,"dr",one_only,switch_at,unique,11
	.p2align	4, 0x0                          # @switch_at
switch_at:
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	32                              # 0x20
	.long	64                              # 0x40
	.long	96                              # 0x60
	.long	128                             # 0x80
	.long	192                             # 0xc0
	.long	256                             # 0x100
	.long	0                               # 0x0
	.long	0                               # 0x0

	.section	.debug$S,"dr"
	.p2align	2, 0x0
	.long	4                               # Debug section magic
	.long	241
	.long	.Ltmp1-.Ltmp0                   # Subsection size
.Ltmp0:
	.short	.Ltmp3-.Ltmp2                   # Record length
.Ltmp2:
	.short	4353                            # Record kind: S_OBJNAME
	.long	0                               # Signature
	.byte	0                               # Object name
	.p2align	2, 0x0
.Ltmp3:
	.short	.Ltmp5-.Ltmp4                   # Record length
.Ltmp4:
	.short	4412                            # Record kind: S_COMPILE3
	.long	0                               # Flags and language
	.short	208                             # CPUType
	.short	23                              # Frontend version
	.short	1
	.short	0
	.short	0
	.short	23010                           # Backend version
	.short	0
	.short	0
	.short	0
	.asciz	"clang version 23.1.0"          # Null-terminated compiler version string
	.p2align	2, 0x0
.Ltmp5:
.Ltmp1:
	.p2align	2, 0x0
	.addrsig
