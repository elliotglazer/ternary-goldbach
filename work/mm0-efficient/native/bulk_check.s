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
	.p2align	3, 0x0                          # -- Begin function main
.LCPI0_0:
	.quad	0x3eb0c6f7a0b5ed8d              # double 9.9999999999999995E-7
.LCPI0_1:
	.quad	0x3fbeb851eb851eb8              # double 0.12
.LCPI0_2:
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
	subq	$488, %rsp                      # imm = 0x1E8
	.seh_stackalloc 488
	leaq	128(%rsp), %rbp
	.seh_setframe %rbp, 128
	vmovapd	%xmm10, 336(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm10, 464
	vmovapd	%xmm9, 320(%rbp)                # 16-byte Spill
	.seh_savexmm %xmm9, 448
	vmovapd	%xmm8, 304(%rbp)                # 16-byte Spill
	.seh_savexmm %xmm8, 432
	vmovapd	%xmm7, 288(%rbp)                # 16-byte Spill
	.seh_savexmm %xmm7, 416
	vmovapd	%xmm6, 272(%rbp)                # 16-byte Spill
	.seh_savexmm %xmm6, 400
	.seh_endprologue
	movq	%rdx, %r14
	movl	%ecx, %esi
	movl	$2, %r13d
	callq	__main
	cmpl	$2, %esi
	jne	.LBB0_138
# %bb.1:
	leaq	112(%rbp), %rcx
	callq	*__imp_QueryPerformanceCounter(%rip)
	leaq	32(%rbp), %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm6
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm7
	movq	8(%r14), %rcx
	leaq	.str.7(%rip), %rdx
	callq	fopen
	testq	%rax, %rax
	je	.LBB0_9
# %bb.2:
	leaq	112(%rbp), %rcx
	movl	$1, %edx
	movl	$8, %r8d
	movq	%rax, %r9
	movq	%rax, %rdi
	callq	fread
	movabsq	$3555116106300282178, %rcx      # imm = 0x31564F434B4C5542
	cmpq	%rcx, 112(%rbp)
	jne	.LBB0_9
# %bb.3:
	cmpq	$8, %rax
	jne	.LBB0_9
# %bb.4:
	leaq	-32(%rbp), %rcx
	movl	$8, %edx
	movl	$1, %r8d
	movq	%rdi, %r9
	callq	fread
	cmpq	$1, %rax
	jne	.LBB0_9
# %bb.5:
	movq	-32(%rbp), %rsi
	testq	%rsi, %rsi
	je	.LBB0_9
# %bb.6:
	cmpq	$1024, %rsi                     # imm = 0x400
	ja	.LBB0_9
# %bb.139:
	movq	%rsi, %rax
	shlq	$4, %rax
	leaq	(%rax,%rax,4), %rcx
	callq	malloc
	testq	%rax, %rax
	je	.LBB0_9
# %bb.140:
	movq	%rax, %r15
	movq	%rax, %rbx
	.p2align	4
.LBB0_141:                              # =>This Inner Loop Header: Depth=1
	movq	%rdi, %rcx
	movq	%rbx, %rdx
	callq	read_case
	testl	%eax, %eax
	je	.LBB0_9
# %bb.142:                              #   in Loop: Header=BB0_141 Depth=1
	addq	$80, %rbx
	decq	%rsi
	jne	.LBB0_141
# %bb.143:
	movq	%rdi, %rcx
	callq	fclose
	movq	%r15, %rbx
	jmp	.LBB0_10
.LBB0_9:
	xorl	%ebx, %ebx
.LBB0_10:
	leaq	112(%rbp), %rcx
	callq	*__imp_QueryPerformanceCounter(%rip)
	leaq	32(%rbp), %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	testq	%rbx, %rbx
	je	.LBB0_71
# %bb.11:
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm8
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm9
	movq	-32(%rbp), %rdx
	vxorpd	%xmm0, %xmm0, %xmm0
	movq	%r14, -24(%rbp)                 # 8-byte Spill
	vmovapd	%xmm0, (%rbp)
	movq	$0, 16(%rbp)
	movq	$0, 240(%rbp)                   # 8-byte Folded Spill
	movq	%rdx, 232(%rbp)                 # 8-byte Spill
	testq	%rdx, %rdx
	je	.LBB0_72
# %bb.12:
	leal	(%rdx,%rdx), %eax
	leaq	112(%rbp), %r12
	movq	%rbp, %r13
	movq	%rbx, %rdi
	xorl	%esi, %esi
	leal	(%rax,%rax,4), %r15d
	xorl	%eax, %eax
.LBB0_13:                               # =>This Inner Loop Header: Depth=1
	addq	(%rdi), %rax
	movq	%r12, %rcx
	movq	%rdi, %rdx
	xorl	%r8d, %r8d
	movq	%r13, %r9
	movq	%rax, -8(%rbp)                  # 8-byte Spill
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_70
# %bb.14:                               #   in Loop: Header=BB0_13 Depth=1
	movl	116(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_70
# %bb.15:                               #   in Loop: Header=BB0_13 Depth=1
	movl	$1, %r8d
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movq	%r13, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_70
# %bb.16:                               #   in Loop: Header=BB0_13 Depth=1
	movl	116(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_70
# %bb.17:                               #   in Loop: Header=BB0_13 Depth=1
	movl	$2, %r8d
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movq	%r13, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_70
# %bb.18:                               #   in Loop: Header=BB0_13 Depth=1
	movl	116(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_70
# %bb.19:                               #   in Loop: Header=BB0_13 Depth=1
	movl	$3, %r8d
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movq	%r13, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_70
# %bb.20:                               #   in Loop: Header=BB0_13 Depth=1
	movl	116(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_70
# %bb.21:                               #   in Loop: Header=BB0_13 Depth=1
	movl	$4, %r8d
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movq	%r13, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_70
# %bb.22:                               #   in Loop: Header=BB0_13 Depth=1
	movl	116(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_70
# %bb.23:                               #   in Loop: Header=BB0_13 Depth=1
	movl	$5, %r8d
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movq	%r13, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_70
# %bb.24:                               #   in Loop: Header=BB0_13 Depth=1
	movl	116(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_70
# %bb.25:                               #   in Loop: Header=BB0_13 Depth=1
	movl	$6, %r8d
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movq	%r13, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_70
# %bb.26:                               #   in Loop: Header=BB0_13 Depth=1
	movl	116(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_70
# %bb.27:                               #   in Loop: Header=BB0_13 Depth=1
	movl	$7, %r8d
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movq	%r13, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_70
# %bb.28:                               #   in Loop: Header=BB0_13 Depth=1
	movl	116(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_70
# %bb.29:                               #   in Loop: Header=BB0_13 Depth=1
	movl	$8, %r8d
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movq	%r13, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_70
# %bb.30:                               #   in Loop: Header=BB0_13 Depth=1
	movl	116(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_70
# %bb.31:                               #   in Loop: Header=BB0_13 Depth=1
	movl	$9, %r8d
	movq	%r12, %rcx
	movq	%rdi, %rdx
	movq	%r13, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_70
# %bb.32:                               #   in Loop: Header=BB0_13 Depth=1
	movl	116(%rbp), %eax
	cmpq	%rax, 48(%rdi)
	jne	.LBB0_70
# %bb.33:                               #   in Loop: Header=BB0_13 Depth=1
	movq	232(%rbp), %rdx                 # 8-byte Reload
	movq	-8(%rbp), %rax                  # 8-byte Reload
	incq	%rsi
	addq	$80, %rdi
	cmpq	%rsi, %rdx
	jne	.LBB0_13
# %bb.34:
	movl	$1048576, %r8d                  # imm = 0x100000
	leaq	32(%rbp), %r13
	leaq	112(%rbp), %rsi
	movl	%r15d, -12(%rbp)                # 4-byte Spill
	movq	%rbp, %r15
	xorl	%r9d, %r9d
	movl	$0, 224(%rbp)                   # 4-byte Folded Spill
.LBB0_35:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_51 Depth 2
                                        #     Child Loop BB0_54 Depth 2
	testq	%r9, %r9
	je	.LBB0_37
# %bb.36:                               #   in Loop: Header=BB0_35 Depth=1
	leaq	(%r9,%r9,4), %rax
	shlq	$4, %rax
	movq	(%rbx,%rax), %rcx
	cmpq	-80(%rbx,%rax), %rcx
	je	.LBB0_68
.LBB0_37:                               #   in Loop: Header=BB0_35 Depth=1
	leaq	(%r9,%r9,4), %rax
	movq	%r9, 216(%rbp)                  # 8-byte Spill
	shlq	$4, %rax
	vmovupd	(%rbx,%rax), %zmm0
	vmovupd	16(%rbx,%rax), %zmm1
	vmovupd	%zmm0, 112(%rbp)
	vmovupd	%zmm1, 128(%rbp)
	movq	112(%rbp), %rdi
	cmpq	$1048576, %rdi                  # imm = 0x100000
	cmovaeq	%r8, %rdi
	movq	%rdi, 112(%rbp)
	movq	136(%rbp), %rax
	leaq	8(,%rax,8), %r14
	movq	%r14, %rcx
	vzeroupper
	callq	malloc
	movq	184(%rbp), %r12
	movq	%rax, 248(%rbp)                 # 8-byte Spill
	movq	%rax, %rcx
	movq	%r14, %r8
	movq	%r12, %rdx
	callq	memcpy
	movq	%r12, %rcx
	xorl	%edx, %edx
	movq	%r14, %r8
	movq	%r14, 208(%rbp)                 # 8-byte Spill
	callq	memset
	movq	%r13, %rcx
	movq	%rsi, %rdx
	xorl	%r8d, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	movq	%r13, %r14
	movl	$5, %r13d
	jne	.LBB0_138
# %bb.38:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$1, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.39:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$2, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.40:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$3, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.41:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$4, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.42:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$5, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.43:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$6, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.44:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$7, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.45:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$8, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.46:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$9, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.47:                               #   in Loop: Header=BB0_35 Depth=1
	movq	248(%rbp), %rdx                 # 8-byte Reload
	movq	208(%rbp), %r8                  # 8-byte Reload
	movq	%r12, %rcx
	callq	memcpy
	movq	128(%rbp), %r9
	testq	%r9, %r9
	je	.LBB0_55
# %bb.48:                               #   in Loop: Header=BB0_35 Depth=1
	movq	176(%rbp), %r8
	movl	%r9d, %edx
	movq	%rdi, %rax
	shrq	%rax
	andl	$7, %edx
	cmpq	$8, %r9
	jae	.LBB0_50
# %bb.49:                               #   in Loop: Header=BB0_35 Depth=1
	xorl	%r10d, %r10d
	jmp	.LBB0_53
.LBB0_50:                               #   in Loop: Header=BB0_35 Depth=1
	andq	$-8, %r9
	leaq	120(%r8), %r11
	movq	%rbx, %r13
	xorl	%r10d, %r10d
.LBB0_51:                               #   Parent Loop BB0_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-112(%r11), %rcx
	movq	$-2, %rbx
	addq	$8, %r10
	addq	%rax, %rcx
	rolq	%cl, %rbx
	shrq	$6, %rcx
	andq	%rbx, (%r12,%rcx,8)
	movq	$-2, %rbx
	movq	-96(%r11), %rcx
	addq	%rax, %rcx
	rolq	%cl, %rbx
	shrq	$6, %rcx
	andq	%rbx, (%r12,%rcx,8)
	movq	$-2, %rbx
	movq	-80(%r11), %rcx
	addq	%rax, %rcx
	rolq	%cl, %rbx
	shrq	$6, %rcx
	andq	%rbx, (%r12,%rcx,8)
	movq	$-2, %rbx
	movq	-64(%r11), %rcx
	addq	%rax, %rcx
	rolq	%cl, %rbx
	shrq	$6, %rcx
	andq	%rbx, (%r12,%rcx,8)
	movq	$-2, %rbx
	movq	-48(%r11), %rcx
	addq	%rax, %rcx
	rolq	%cl, %rbx
	shrq	$6, %rcx
	andq	%rbx, (%r12,%rcx,8)
	movq	$-2, %rbx
	movq	-32(%r11), %rcx
	addq	%rax, %rcx
	rolq	%cl, %rbx
	shrq	$6, %rcx
	andq	%rbx, (%r12,%rcx,8)
	movq	$-2, %rbx
	movq	-16(%r11), %rcx
	addq	%rax, %rcx
	rolq	%cl, %rbx
	shrq	$6, %rcx
	andq	%rbx, (%r12,%rcx,8)
	movq	$-2, %rbx
	movq	(%r11), %rcx
	subq	$-128, %r11
	addq	%rax, %rcx
	rolq	%cl, %rbx
	shrq	$6, %rcx
	andq	%rbx, (%r12,%rcx,8)
	cmpq	%r10, %r9
	jne	.LBB0_51
# %bb.52:                               #   in Loop: Header=BB0_35 Depth=1
	movq	%r13, %rbx
	testq	%rdx, %rdx
	je	.LBB0_55
.LBB0_53:                               #   in Loop: Header=BB0_35 Depth=1
	shlq	$4, %r10
	shll	$4, %edx
	xorl	%r9d, %r9d
	leaq	8(%r8,%r10), %r8
.LBB0_54:                               #   Parent Loop BB0_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%r8,%r9), %rcx
	movq	$-2, %r10
	addq	$16, %r9
	addq	%rax, %rcx
	rolq	%cl, %r10
	shrq	$6, %rcx
	andq	%r10, (%r12,%rcx,8)
	cmpq	%r9, %rdx
	jne	.LBB0_54
.LBB0_55:                               #   in Loop: Header=BB0_35 Depth=1
	movq	%rbp, %r15
	movq	%r14, %rcx
	movq	%rsi, %rdx
	xorl	%r8d, %r8d
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	movl	$6, %r13d
	jne	.LBB0_138
# %bb.56:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$1, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.57:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$2, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.58:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$3, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.59:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$4, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.60:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$5, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.61:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$6, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.62:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$7, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.63:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$8, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.64:                               #   in Loop: Header=BB0_35 Depth=1
	movl	$9, %r8d
	movq	%r14, %rcx
	movq	%rsi, %rdx
	movq	%r15, %r9
	callq	check
	cmpl	$0, 32(%rbp)
	jne	.LBB0_138
# %bb.65:                               #   in Loop: Header=BB0_35 Depth=1
	movq	248(%rbp), %rdx                 # 8-byte Reload
	movq	208(%rbp), %r8                  # 8-byte Reload
	movq	%r12, %rcx
	movq	%rbx, %r13
	callq	memcpy
	movq	176(%rbp), %rbx
	movq	120(%rbp), %rax
	movq	%r14, %rcx
	movq	%rsi, %rdx
	xorl	%r8d, %r8d
	movq	%r15, %r9
	movq	8(%rbx), %r12
	subq	%rdi, %rax
	incq	%rax
	movq	%rax, 8(%rbx)
	callq	check
	cmpl	$0, 48(%rbp)
	je	.LBB0_146
# %bb.66:                               #   in Loop: Header=BB0_35 Depth=1
	movq	%r12, 8(%rbx)
	movq	%r14, %r12
	movq	%r14, %rcx
	movq	%rsi, %r14
	movq	%rsi, %rdx
	xorl	%r8d, %r8d
	movq	%r15, %r9
	movq	(%rbx), %rdi
	leaq	2(%rdi), %rax
	movq	%rax, (%rbx)
	callq	check
	cmpl	$0, 48(%rbp)
	je	.LBB0_147
# %bb.67:                               #   in Loop: Header=BB0_35 Depth=1
	addl	$22, 224(%rbp)                  # 4-byte Folded Spill
	movq	248(%rbp), %rcx                 # 8-byte Reload
	movq	%rdi, (%rbx)
	callq	free
	movq	232(%rbp), %rdx                 # 8-byte Reload
	movq	216(%rbp), %r9                  # 8-byte Reload
	movl	$1048576, %r8d                  # imm = 0x100000
	movq	%r13, %rbx
	movq	%r12, %r13
	movq	%r14, %rsi
.LBB0_68:                               #   in Loop: Header=BB0_35 Depth=1
	incq	%r9
	cmpq	%rdx, %r9
	jne	.LBB0_35
# %bb.69:
	movl	224(%rbp), %eax                 # 4-byte Reload
	movl	-12(%rbp), %r9d                 # 4-byte Reload
	jmp	.LBB0_73
.LBB0_70:
	movl	$4, %r13d
	jmp	.LBB0_138
.LBB0_71:
	movl	$3, %r13d
	jmp	.LBB0_138
.LBB0_72:
	xorl	%r9d, %r9d
	movq	$0, -8(%rbp)                    # 8-byte Folded Spill
	xorl	%eax, %eax
.LBB0_73:
	vdivsd	%xmm7, %xmm6, %xmm0
	vdivsd	%xmm9, %xmm8, %xmm1
	leaq	.str(%rip), %rcx
	movq	$0, 104(%rbp)
	movl	%eax, 32(%rsp)
	vsubsd	%xmm0, %xmm1, %xmm2
	vmovq	%xmm2, %r8
	callq	printf
	vmovsd	.LCPI0_0(%rip), %xmm7           # xmm7 = [9.9999999999999995E-7,0.0E+0]
	vmovsd	.LCPI0_1(%rip), %xmm8           # xmm8 = [1.2E-1,0.0E+0]
	vmovsd	.LCPI0_2(%rip), %xmm6           # xmm6 = [9.9999999999999995E-8,0.0E+0]
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	movq	__imp_QueryPerformanceFrequency(%rip), %r15
	leaq	32(%rbp), %rsi
	movq	$0, 216(%rbp)                   # 8-byte Folded Spill
	movq	%rbx, 200(%rbp)                 # 8-byte Spill
.LBB0_74:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_78 Depth 2
                                        #       Child Loop BB0_81 Depth 3
                                        #       Child Loop BB0_86 Depth 3
                                        #         Child Loop BB0_88 Depth 4
                                        #       Child Loop BB0_93 Depth 3
                                        #         Child Loop BB0_95 Depth 4
                                        #       Child Loop BB0_100 Depth 3
                                        #         Child Loop BB0_102 Depth 4
	xorl	%r12d, %r12d
	jmp	.LBB0_78
.LBB0_75:                               #   in Loop: Header=BB0_78 Depth=2
	movq	200(%rbp), %rbx                 # 8-byte Reload
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	movq	__imp_QueryPerformanceFrequency(%rip), %r15
	leaq	32(%rbp), %rsi
.LBB0_76:                               #   in Loop: Header=BB0_78 Depth=2
	movq	208(%rbp), %r12                 # 8-byte Reload
.LBB0_77:                               #   in Loop: Header=BB0_78 Depth=2
	incq	%r12
	cmpq	$7, %r12
	je	.LBB0_106
.LBB0_78:                               #   Parent Loop BB0_74 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_81 Depth 3
                                        #       Child Loop BB0_86 Depth 3
                                        #         Child Loop BB0_88 Depth 4
                                        #       Child Loop BB0_93 Depth 3
                                        #         Child Loop BB0_95 Depth 4
                                        #       Child Loop BB0_100 Depth 3
                                        #         Child Loop BB0_102 Depth 4
	leaq	112(%rbp), %rcx
	callq	*%rdi
	movq	%rsi, %rcx
	callq	*%r15
	movq	232(%rbp), %rcx                 # 8-byte Reload
	testq	%rcx, %rcx
	je	.LBB0_77
# %bb.79:                               #   in Loop: Header=BB0_78 Depth=2
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm0
	leal	(%r12,%r12), %eax
	movl	$65536, %edx                    # imm = 0x10000
	movq	%r12, 208(%rbp)                 # 8-byte Spill
	movq	%rbx, %rdi
	xorl	%r14d, %r14d
	xorl	%ebx, %ebx
	xorl	%esi, %esi
	xorl	%r13d, %r13d
	xorl	%r15d, %r15d
	shlxq	%rax, %rdx, %r12
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm9
	jmp	.LBB0_81
	.p2align	4
.LBB0_80:                               #   in Loop: Header=BB0_81 Depth=3
	incq	%rbx
	addq	$80, %rdi
	cmpq	%rbx, %rcx
	je	.LBB0_83
.LBB0_81:                               #   Parent Loop BB0_74 Depth=1
                                        #     Parent Loop BB0_78 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	cmpq	%r12, (%rdi)
	jne	.LBB0_80
# %bb.82:                               #   in Loop: Header=BB0_81 Depth=3
	leaq	112(%rbp), %rcx
	movq	240(%rbp), %r8                  # 8-byte Reload
	movq	%rdi, %rdx
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%rbp, %r9
	callq	check
	movl	116(%rbp), %eax
	movq	232(%rbp), %rcx                 # 8-byte Reload
	addq	%r12, %r15
	incl	%esi
	addq	%rax, 104(%rbp)
	addq	%rax, %r14
	addq	120(%rbp), %r13
	jmp	.LBB0_80
.LBB0_83:                               #   in Loop: Header=BB0_78 Depth=2
	testl	%esi, %esi
	je	.LBB0_75
# %bb.84:                               #   in Loop: Header=BB0_78 Depth=2
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	movq	%r14, 224(%rbp)                 # 8-byte Spill
	leaq	112(%rbp), %r14
	movq	%r14, %rcx
	callq	*%rdi
	movq	__imp_QueryPerformanceFrequency(%rip), %rbx
	leaq	32(%rbp), %rdi
	movq	%rdi, %rcx
	callq	*%rbx
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm0
	movl	$100, %eax
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vsubsd	%xmm9, %xmm0, %xmm0
	vmaxsd	%xmm7, %xmm0, %xmm0
	vdivsd	%xmm0, %xmm8, %xmm0
	vcvttsd2usi	%xmm0, %ecx
	cmpl	$1, %ecx
	adcl	$0, %ecx
	cmpl	$100, %ecx
	cmovael	%eax, %ecx
	movl	%ecx, 248(%rbp)                 # 4-byte Spill
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	264(%rbp), %rcx
	leaq	256(%rbp), %r9
	movq	%r14, %rdx
	movq	%rdi, %r8
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	callq	*__imp_GetProcessTimes(%rip)
	movl	268(%rbp), %ecx
	movl	264(%rbp), %eax
	shlq	$32, %rcx
	addq	256(%rbp), %rcx
	addq	%rcx, %rax
	movq	%r14, %rcx
	vcvtusi2sd	%rax, %xmm5, %xmm0
	vmulsd	%xmm6, %xmm0, %xmm10
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%rdi, %rcx
	callq	*%rbx
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm0
	movq	232(%rbp), %rax                 # 8-byte Reload
	xorl	%ebx, %ebx
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm9
	jmp	.LBB0_86
	.p2align	4
.LBB0_85:                               #   in Loop: Header=BB0_86 Depth=3
	incl	%ebx
	cmpl	248(%rbp), %ebx                 # 4-byte Folded Reload
	je	.LBB0_91
.LBB0_86:                               #   Parent Loop BB0_74 Depth=1
                                        #     Parent Loop BB0_78 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_88 Depth 4
	movq	200(%rbp), %rdi                 # 8-byte Reload
	xorl	%r14d, %r14d
	jmp	.LBB0_88
	.p2align	4
.LBB0_87:                               #   in Loop: Header=BB0_88 Depth=4
	incq	%r14
	addq	$80, %rdi
	cmpq	%r14, %rax
	je	.LBB0_85
.LBB0_88:                               #   Parent Loop BB0_74 Depth=1
                                        #     Parent Loop BB0_78 Depth=2
                                        #       Parent Loop BB0_86 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	cmpq	%r12, (%rdi)
	jne	.LBB0_87
# %bb.89:                               #   in Loop: Header=BB0_88 Depth=4
	leaq	112(%rbp), %rcx
	movq	240(%rbp), %r8                  # 8-byte Reload
	movq	%rdi, %rdx
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%rbp, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_137
# %bb.90:                               #   in Loop: Header=BB0_88 Depth=4
	movl	116(%rbp), %eax
	addq	%rax, 104(%rbp)
	movq	232(%rbp), %rax                 # 8-byte Reload
	jmp	.LBB0_87
.LBB0_91:                               #   in Loop: Header=BB0_78 Depth=2
	movq	__imp_GetCurrentProcess(%rip), %r14
	callq	*%r14
	leaq	264(%rbp), %rcx
	leaq	112(%rbp), %rdi
	leaq	32(%rbp), %r14
	leaq	256(%rbp), %r9
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	__imp_GetProcessTimes(%rip), %rax
	movq	%rdi, %rdx
	movq	%r14, %r8
	callq	*%rax
	movl	268(%rbp), %ecx
	movl	264(%rbp), %eax
	shlq	$32, %rcx
	addq	256(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rdi, %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	vcvtusi2sd	%rax, %xmm5, %xmm0
	vmulsd	%xmm6, %xmm0, %xmm0
	vsubsd	%xmm10, %xmm0, %xmm10
	callq	*%rdi
	movq	__imp_QueryPerformanceFrequency(%rip), %rbx
	movq	%r14, %rcx
	callq	*%rbx
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm0
	cmpl	$0, 216(%rbp)                   # 4-byte Folded Reload
	leaq	.str.2(%rip), %rdx
	leaq	.str.3(%rip), %rax
	leaq	.str.1(%rip), %rcx
	movq	240(%rbp), %r8                  # 8-byte Reload
	vmovsd	%xmm10, 88(%rsp)
	movq	%r13, 64(%rsp)
	movq	%r15, 56(%rsp)
	movl	%esi, 40(%rsp)
	movl	$0, 32(%rsp)
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%r12, %r9
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm1
	cmoveq	%rax, %rdx
	movq	224(%rbp), %rax                 # 8-byte Reload
	movq	%rax, 72(%rsp)
	movl	248(%rbp), %eax                 # 4-byte Reload
	vdivsd	%xmm1, %xmm0, %xmm0
	movl	%eax, 48(%rsp)
	vsubsd	%xmm9, %xmm0, %xmm0
	vmovsd	%xmm0, 80(%rsp)
	callq	printf
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	264(%rbp), %rcx
	leaq	112(%rbp), %rdi
	leaq	256(%rbp), %r9
	movq	%r14, %r8
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rdi, %rdx
	callq	*__imp_GetProcessTimes(%rip)
	movl	268(%rbp), %ecx
	movl	264(%rbp), %eax
	shlq	$32, %rcx
	addq	256(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rdi, %rcx
	vcvtusi2sd	%rax, %xmm5, %xmm0
	vmulsd	%xmm6, %xmm0, %xmm10
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%r14, %rcx
	callq	*%rbx
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm0
	movq	232(%rbp), %rax                 # 8-byte Reload
	xorl	%ebx, %ebx
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm9
	jmp	.LBB0_93
.LBB0_92:                               #   in Loop: Header=BB0_93 Depth=3
	incl	%ebx
	cmpl	248(%rbp), %ebx                 # 4-byte Folded Reload
	je	.LBB0_98
.LBB0_93:                               #   Parent Loop BB0_74 Depth=1
                                        #     Parent Loop BB0_78 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_95 Depth 4
	movq	200(%rbp), %rdi                 # 8-byte Reload
	xorl	%r14d, %r14d
	jmp	.LBB0_95
	.p2align	4
.LBB0_94:                               #   in Loop: Header=BB0_95 Depth=4
	incq	%r14
	addq	$80, %rdi
	cmpq	%r14, %rax
	je	.LBB0_92
.LBB0_95:                               #   Parent Loop BB0_74 Depth=1
                                        #     Parent Loop BB0_78 Depth=2
                                        #       Parent Loop BB0_93 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	cmpq	%r12, (%rdi)
	jne	.LBB0_94
# %bb.96:                               #   in Loop: Header=BB0_95 Depth=4
	leaq	112(%rbp), %rcx
	movq	240(%rbp), %r8                  # 8-byte Reload
	movq	%rdi, %rdx
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%rbp, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_137
# %bb.97:                               #   in Loop: Header=BB0_95 Depth=4
	movl	116(%rbp), %eax
	addq	%rax, 104(%rbp)
	movq	232(%rbp), %rax                 # 8-byte Reload
	jmp	.LBB0_94
.LBB0_98:                               #   in Loop: Header=BB0_78 Depth=2
	movq	__imp_GetCurrentProcess(%rip), %r14
	callq	*%r14
	leaq	264(%rbp), %rcx
	leaq	112(%rbp), %rdi
	leaq	32(%rbp), %r14
	leaq	256(%rbp), %r9
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	__imp_GetProcessTimes(%rip), %rax
	movq	%rdi, %rdx
	movq	%r14, %r8
	callq	*%rax
	movl	268(%rbp), %ecx
	movl	264(%rbp), %eax
	shlq	$32, %rcx
	addq	256(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rdi, %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	vcvtusi2sd	%rax, %xmm5, %xmm0
	vmulsd	%xmm6, %xmm0, %xmm0
	vsubsd	%xmm10, %xmm0, %xmm10
	callq	*%rdi
	movq	__imp_QueryPerformanceFrequency(%rip), %rbx
	movq	%r14, %rcx
	callq	*%rbx
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm0
	cmpl	$-1, 216(%rbp)                  # 4-byte Folded Reload
	leaq	.str.2(%rip), %rdx
	leaq	.str.3(%rip), %rax
	leaq	.str.1(%rip), %rcx
	movq	240(%rbp), %r8                  # 8-byte Reload
	vmovsd	%xmm10, 88(%rsp)
	movq	%r13, 64(%rsp)
	movq	%r15, 56(%rsp)
	movl	%esi, 40(%rsp)
	movl	$1, 32(%rsp)
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%r12, %r9
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm1
	cmoveq	%rax, %rdx
	movq	224(%rbp), %rax                 # 8-byte Reload
	movq	%rax, 72(%rsp)
	movl	248(%rbp), %eax                 # 4-byte Reload
	vdivsd	%xmm1, %xmm0, %xmm0
	movl	%eax, 48(%rsp)
	vsubsd	%xmm9, %xmm0, %xmm0
	vmovsd	%xmm0, 80(%rsp)
	callq	printf
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	264(%rbp), %rcx
	leaq	112(%rbp), %rdi
	leaq	256(%rbp), %r9
	movq	%r14, %r8
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rdi, %rdx
	callq	*__imp_GetProcessTimes(%rip)
	movl	268(%rbp), %ecx
	movl	264(%rbp), %eax
	shlq	$32, %rcx
	addq	256(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rdi, %rcx
	vcvtusi2sd	%rax, %xmm5, %xmm0
	vmulsd	%xmm6, %xmm0, %xmm10
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%r14, %rcx
	callq	*%rbx
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm0
	movq	232(%rbp), %rax                 # 8-byte Reload
	xorl	%ebx, %ebx
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm9
	jmp	.LBB0_100
.LBB0_99:                               #   in Loop: Header=BB0_100 Depth=3
	incl	%ebx
	cmpl	248(%rbp), %ebx                 # 4-byte Folded Reload
	je	.LBB0_105
.LBB0_100:                              #   Parent Loop BB0_74 Depth=1
                                        #     Parent Loop BB0_78 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_102 Depth 4
	movq	200(%rbp), %rdi                 # 8-byte Reload
	movq	%rax, %r14
	jmp	.LBB0_102
.LBB0_101:                              #   in Loop: Header=BB0_102 Depth=4
	addq	$80, %rdi
	decq	%r14
	je	.LBB0_99
.LBB0_102:                              #   Parent Loop BB0_74 Depth=1
                                        #     Parent Loop BB0_78 Depth=2
                                        #       Parent Loop BB0_100 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	cmpq	%r12, (%rdi)
	jne	.LBB0_101
# %bb.103:                              #   in Loop: Header=BB0_102 Depth=4
	leaq	112(%rbp), %rcx
	movq	240(%rbp), %r8                  # 8-byte Reload
	movq	%rdi, %rdx
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%rbp, %r9
	callq	check
	cmpl	$0, 112(%rbp)
	je	.LBB0_137
# %bb.104:                              #   in Loop: Header=BB0_102 Depth=4
	movl	116(%rbp), %eax
	addq	%rax, 104(%rbp)
	movq	232(%rbp), %rax                 # 8-byte Reload
	jmp	.LBB0_101
.LBB0_105:                              #   in Loop: Header=BB0_78 Depth=2
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	264(%rbp), %rcx
	leaq	112(%rbp), %rdi
	leaq	32(%rbp), %r14
	leaq	256(%rbp), %r9
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rdi, %rdx
	movq	%r14, %r8
	callq	*__imp_GetProcessTimes(%rip)
	movl	268(%rbp), %ecx
	movl	264(%rbp), %eax
	movq	__imp_QueryPerformanceCounter(%rip), %rbx
	shlq	$32, %rcx
	addq	256(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rdi, %rcx
	vcvtusi2sd	%rax, %xmm5, %xmm0
	vmulsd	%xmm6, %xmm0, %xmm0
	vsubsd	%xmm10, %xmm0, %xmm10
	callq	*%rbx
	movq	__imp_QueryPerformanceFrequency(%rip), %rbx
	movq	%r14, %rcx
	callq	*%rbx
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm0
	movq	216(%rbp), %rax                 # 8-byte Reload
	leaq	.str.2(%rip), %rdx
	leaq	.str.1(%rip), %rcx
	movq	240(%rbp), %r8                  # 8-byte Reload
	movq	%r15, 56(%rsp)
	movl	%esi, 40(%rsp)
	vmovsd	%xmm10, 88(%rsp)
	movq	%r13, 64(%rsp)
	movq	%rbx, %r15
	movq	%r14, %rsi
	movl	$2, 32(%rsp)
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%r12, %r9
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm1
	leal	3(%rax), %edi
	cmpl	$-2, %eax
	leaq	.str.3(%rip), %rax
	cmoveq	%rax, %rdx
	movq	224(%rbp), %rax                 # 8-byte Reload
	movq	%rax, 72(%rsp)
	movl	248(%rbp), %eax                 # 4-byte Reload
	vdivsd	%xmm1, %xmm0, %xmm0
	movl	%eax, 48(%rsp)
	vsubsd	%xmm9, %xmm0, %xmm0
	vmovsd	%xmm0, 80(%rsp)
	callq	printf
	movl	%edi, %eax
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	movq	200(%rbp), %rbx                 # 8-byte Reload
	movq	%rax, 216(%rbp)                 # 8-byte Spill
	jmp	.LBB0_76
.LBB0_106:                              #   in Loop: Header=BB0_74 Depth=1
	movq	240(%rbp), %rax                 # 8-byte Reload
	incl	%eax
	movq	%rax, 240(%rbp)                 # 8-byte Spill
	cmpl	$10, %eax
	jne	.LBB0_74
# %bb.107:
	leaq	.str.4(%rip), %rcx
	callq	printf
	leaq	32(%rbp), %r12
	leaq	.str.7(%rip), %r13
	xorl	%esi, %esi
	movq	$0, 248(%rbp)                   # 8-byte Folded Spill
.LBB0_108:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_109 Depth 2
                                        #       Child Loop BB0_110 Depth 3
                                        #         Child Loop BB0_117 Depth 4
	movq	-24(%rbp), %r14                 # 8-byte Reload
	movl	%esi, %eax
	movl	$0, 216(%rbp)                   # 4-byte Folded Spill
	movq	%rax, 224(%rbp)                 # 8-byte Spill
.LBB0_109:                              #   Parent Loop BB0_108 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_110 Depth 3
                                        #         Child Loop BB0_117 Depth 4
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	264(%rbp), %rcx
	leaq	112(%rbp), %rsi
	leaq	256(%rbp), %r9
	movq	%r12, %r8
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rsi, %rdx
	callq	*__imp_GetProcessTimes(%rip)
	movl	268(%rbp), %ecx
	movl	264(%rbp), %eax
	shlq	$32, %rcx
	addq	256(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rsi, %rcx
	vcvtusi2sd	%rax, %xmm5, %xmm0
	vmulsd	%xmm6, %xmm0, %xmm8
	callq	*%rdi
	movq	%r12, %rcx
	callq	*%r15
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm0
	movl	$0, 208(%rbp)                   # 4-byte Folded Spill
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm7
.LBB0_110:                              #   Parent Loop BB0_108 Depth=1
                                        #     Parent Loop BB0_109 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_117 Depth 4
	movq	8(%r14), %rcx
	movq	%r13, %rdx
	callq	fopen
	testq	%rax, %rax
	je	.LBB0_150
# %bb.111:                              #   in Loop: Header=BB0_110 Depth=3
	movl	$1, %edx
	movl	$8, %r8d
	leaq	112(%rbp), %rcx
	movq	%rax, %r9
	movq	%rax, %r14
	callq	fread
	movabsq	$3555116106300282178, %rcx      # imm = 0x31564F434B4C5542
	cmpq	%rcx, 112(%rbp)
	jne	.LBB0_150
# %bb.112:                              #   in Loop: Header=BB0_110 Depth=3
	cmpq	$8, %rax
	jne	.LBB0_150
# %bb.113:                              #   in Loop: Header=BB0_110 Depth=3
	movl	$8, %edx
	movl	$1, %r8d
	leaq	256(%rbp), %rcx
	movq	%r14, %r9
	callq	fread
	cmpq	$1, %rax
	jne	.LBB0_150
# %bb.114:                              #   in Loop: Header=BB0_110 Depth=3
	movq	256(%rbp), %rsi
	testq	%rsi, %rsi
	je	.LBB0_150
# %bb.115:                              #   in Loop: Header=BB0_110 Depth=3
	cmpq	$1024, %rsi                     # imm = 0x400
	ja	.LBB0_150
# %bb.116:                              #   in Loop: Header=BB0_110 Depth=3
	movq	$0, 240(%rbp)                   # 8-byte Folded Spill
.LBB0_117:                              #   Parent Loop BB0_108 Depth=1
                                        #     Parent Loop BB0_109 Depth=2
                                        #       Parent Loop BB0_110 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	$8, %edx
	movl	$8, %r8d
	movq	%r12, %rcx
	movq	%r14, %r9
	movq	%r14, %rdi
	callq	fread
	cmpq	$8, %rax
	jne	.LBB0_150
# %bb.118:                              #   in Loop: Header=BB0_117 Depth=4
	movq	32(%rbp), %rax
	leaq	-268435457(%rax), %rcx
	cmpq	$-268435456, %rcx               # imm = 0xF0000000
	jb	.LBB0_150
# %bb.119:                              #   in Loop: Header=BB0_117 Depth=4
	movq	40(%rbp), %rcx
	cmpq	%rax, %rcx
	jb	.LBB0_150
# %bb.120:                              #   in Loop: Header=BB0_117 Depth=4
	cmpq	$536870912, %rcx                # imm = 0x20000000
	ja	.LBB0_150
# %bb.121:                              #   in Loop: Header=BB0_117 Depth=4
	movq	48(%rbp), %r12
	leaq	-2049(%r12), %rdx
	cmpq	$-2048, %rdx                    # imm = 0xF800
	jb	.LBB0_150
# %bb.122:                              #   in Loop: Header=BB0_117 Depth=4
	movq	56(%rbp), %r13
	leaq	63(%rcx), %rdx
	shrq	$6, %rdx
	cmpq	%rdx, %r13
	jne	.LBB0_150
# %bb.123:                              #   in Loop: Header=BB0_117 Depth=4
	vmovupd	64(%rbp), %ymm0
	movq	%rax, 112(%rbp)
	movq	%rcx, 120(%rbp)
	movq	%r12, %rcx
	shlq	$4, %rcx
	movq	%r12, 128(%rbp)
	movq	%r13, 136(%rbp)
	vmovupd	%ymm0, 144(%rbp)
	vzeroupper
	callq	malloc
	leaq	8(,%r13,8), %rcx
	movq	%rax, %rbx
	movq	%rax, 176(%rbp)
	callq	malloc
	movq	%rax, 184(%rbp)
	testq	%rbx, %rbx
	je	.LBB0_150
# %bb.124:                              #   in Loop: Header=BB0_117 Depth=4
	movq	%rax, %r15
	testq	%rax, %rax
	je	.LBB0_150
# %bb.125:                              #   in Loop: Header=BB0_117 Depth=4
	movl	$16, %edx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%rdi, %r9
	callq	fread
	cmpq	%r12, %rax
	jne	.LBB0_148
# %bb.126:                              #   in Loop: Header=BB0_117 Depth=4
	movl	$8, %edx
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%rdi, %r9
	callq	fread
	cmpq	%r13, %rax
	jne	.LBB0_148
# %bb.127:                              #   in Loop: Header=BB0_117 Depth=4
	leaq	32(%rbp), %r12
	leaq	112(%rbp), %rdx
	movq	248(%rbp), %r8                  # 8-byte Reload
	movq	$0, (%r15,%r13,8)
                                        # kill: def $r8d killed $r8d killed $r8
	movq	%rbp, %r9
	movq	%r12, %rcx
	callq	check
	movq	%rbx, %rcx
	callq	free
	movq	%r15, %rcx
	callq	free
	cmpl	$0, 32(%rbp)
	je	.LBB0_150
# %bb.128:                              #   in Loop: Header=BB0_117 Depth=4
	movl	36(%rbp), %eax
	movq	%rdi, %r14
	addq	%rax, 240(%rbp)                 # 8-byte Folded Spill
	decq	%rsi
	jne	.LBB0_117
# %bb.129:                              #   in Loop: Header=BB0_110 Depth=3
	movq	%r14, %rcx
	callq	fclose
	cmpq	$0, 240(%rbp)                   # 8-byte Folded Reload
	je	.LBB0_150
# %bb.130:                              #   in Loop: Header=BB0_110 Depth=3
	movq	240(%rbp), %rax                 # 8-byte Reload
	movq	__imp_QueryPerformanceFrequency(%rip), %r15
	leaq	.str.7(%rip), %r13
	addq	%rax, 104(%rbp)
	movl	208(%rbp), %eax                 # 4-byte Reload
	movq	-24(%rbp), %r14                 # 8-byte Reload
	incl	%eax
	movl	%eax, 208(%rbp)                 # 4-byte Spill
	cmpl	$3, %eax
	jne	.LBB0_110
# %bb.131:                              #   in Loop: Header=BB0_109 Depth=2
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	264(%rbp), %rcx
	leaq	112(%rbp), %rsi
	leaq	256(%rbp), %r9
	movq	%r12, %r8
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rsi, %rdx
	callq	*__imp_GetProcessTimes(%rip)
	movl	268(%rbp), %ecx
	movl	264(%rbp), %eax
	movq	__imp_QueryPerformanceCounter(%rip), %rdi
	shlq	$32, %rcx
	addq	256(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rsi, %rcx
	vcvtusi2sd	%rax, %xmm5, %xmm0
	vmulsd	%xmm6, %xmm0, %xmm0
	vsubsd	%xmm8, %xmm0, %xmm8
	callq	*%rdi
	movq	%r12, %rcx
	callq	*%r15
	vcvtsi2sdq	112(%rbp), %xmm5, %xmm0
	movq	224(%rbp), %rax                 # 8-byte Reload
	leaq	.str.2(%rip), %rdx
	movl	216(%rbp), %ebx                 # 4-byte Reload
	leaq	.str.5(%rip), %rcx
	movq	248(%rbp), %r8                  # 8-byte Reload
	vmovsd	%xmm8, 56(%rsp)
	movl	$3, 32(%rsp)
                                        # kill: def $r8d killed $r8d killed $r8
	vcvtsi2sdq	32(%rbp), %xmm5, %xmm1
	leal	1(%rax), %esi
	testl	%eax, %eax
	leaq	.str.3(%rip), %rax
	movl	%ebx, %r9d
	cmoveq	%rax, %rdx
	movq	-8(%rbp), %rax                  # 8-byte Reload
	movq	%rax, 40(%rsp)
	vdivsd	%xmm1, %xmm0, %xmm0
	vsubsd	%xmm7, %xmm0, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	callq	printf
	incl	%ebx
	movl	%esi, %eax
	movq	%rax, 224(%rbp)                 # 8-byte Spill
	movl	%ebx, 216(%rbp)                 # 4-byte Spill
	cmpl	$3, %ebx
	jne	.LBB0_109
# %bb.132:                              #   in Loop: Header=BB0_108 Depth=1
	movq	248(%rbp), %rax                 # 8-byte Reload
	incl	%eax
	movq	%rax, 248(%rbp)                 # 8-byte Spill
	cmpl	$10, %eax
	jne	.LBB0_108
# %bb.133:
	movq	104(%rbp), %rdx
	leaq	.str.6(%rip), %rcx
	callq	printf
	cmpq	$0, 232(%rbp)                   # 8-byte Folded Reload
	je	.LBB0_136
# %bb.134:
	movq	200(%rbp), %rax                 # 8-byte Reload
	leaq	72(%rax), %rsi
.LBB0_135:                              # =>This Inner Loop Header: Depth=1
	movq	-8(%rsi), %rcx
	callq	free
	movq	(%rsi), %rcx
	callq	free
	addq	$80, %rsi
	decq	232(%rbp)                       # 8-byte Folded Spill
	jne	.LBB0_135
.LBB0_136:
	movq	200(%rbp), %rcx                 # 8-byte Reload
	callq	free
	movq	(%rbp), %rcx
	callq	free
	movq	8(%rbp), %rcx
	callq	free
	xorl	%r13d, %r13d
	jmp	.LBB0_138
.LBB0_137:
	movl	$9, %r13d
.LBB0_138:
	movl	%r13d, %eax
	vmovaps	272(%rbp), %xmm6                # 16-byte Reload
	vmovaps	288(%rbp), %xmm7                # 16-byte Reload
	vmovaps	304(%rbp), %xmm8                # 16-byte Reload
	vmovaps	320(%rbp), %xmm9                # 16-byte Reload
	vmovaps	336(%rbp), %xmm10               # 16-byte Reload
	.seh_startepilogue
	addq	$488, %rsp                      # imm = 0x1E8
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
.LBB0_146:
	movl	$7, %r13d
	jmp	.LBB0_138
.LBB0_147:
	movl	$8, %r13d
	jmp	.LBB0_138
.LBB0_148:
	movq	%rbx, %rcx
	callq	free
	movq	%r15, %rcx
	callq	free
.LBB0_150:
	movl	$10, %r13d
	jmp	.LBB0_138
	.seh_endproc
                                        # -- End function
	.def	check;
	.scl	3;
	.type	32;
	.endef
	.section	.rdata,"dr"
	.p2align	6, 0x0                          # -- Begin function check
.LCPI1_0:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
	.long	8                               # 0x8
	.long	9                               # 0x9
	.long	10                              # 0xa
	.long	11                              # 0xb
	.long	12                              # 0xc
	.long	13                              # 0xd
	.long	14                              # 0xe
	.long	15                              # 0xf
.LCPI1_1:
	.long	16                              # 0x10
.LCPI1_2:
	.long	32                              # 0x20
.LCPI1_3:
	.long	48                              # 0x30
.LCPI1_4:
	.long	64                              # 0x40
	.zero	16
.LCPI1_5:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
.LCPI1_6:
	.long	8                               # 0x8
	.section	.text$check,"xr",one_only,check,unique,1
	.p2align	4
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
	subq	$344, %rsp                      # imm = 0x158
	.seh_stackalloc 344
	.seh_endprologue
	vpxor	%xmm0, %xmm0, %xmm0
	vmovdqu	%xmm0, (%rcx)
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
.LBB1_158:
	.seh_startepilogue
	addq	$344, %rsp                      # imm = 0x158
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	.seh_endepilogue
	vzeroupper
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
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	cmpl	$8, %r8d
	jb	.LBB1_20
# %bb.16:
	movl	$65536, %eax                    # imm = 0x10000
	movl	$262144, %r8d                   # imm = 0x40000
	movl	$1, (%rcx)
	cmoveq	%rax, %r8
	xorl	%r12d, %r12d
	xorl	%r13d, %r13d
	xorl	%ebp, %ebp
	xorl	%esi, %esi
	xorl	%edi, %edi
	leal	(%r8,%r8), %eax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
.LBB1_17:                               # =>This Inner Loop Header: Depth=1
	vmovups	(%rdx), %zmm0
	vmovdqu64	16(%rdx), %zmm1
	addq	%rbp, %rbx
	movq	%r8, %r15
	movq	%r9, %r14
	cmpq	%r8, %rbx
	cmovaeq	%r8, %rbx
	movl	$4, %r8d
	vmovups	%zmm0, 256(%rsp)
	movq	%rbx, 256(%rsp)
	vmovdqu64	%zmm1, 272(%rsp)
	vpbroadcastq	%r13, %xmm0
	movq	%rcx, %rbx
	leaq	232(%rsp), %rcx
	movq	264(%rsp), %rax
	leaq	(%rbp,%rax), %rdx
	leaq	63(%rbp,%rax), %rax
	movq	%rdx, 264(%rsp)
	movq	%r12, %rdx
	shrq	$3, %rdx
	shrq	$6, %rax
	movq	%rax, 280(%rsp)
	addq	%rdx, 328(%rsp)
	leaq	256(%rsp), %rdx
	vpaddq	288(%rsp), %xmm0, %xmm0
	vmovdqa	%xmm0, 288(%rsp)
	vzeroupper
	callq	check
	addq	240(%rsp), %rdi
	cmpl	$0, 232(%rsp)
	movq	%rbx, %rcx
	movq	%rdi, 8(%rbx)
	je	.LBB1_18
# %bb.19:                               #   in Loop: Header=BB1_17 Depth=1
	movl	236(%rsp), %eax
	movq	80(%rsp), %rdx                  # 8-byte Reload
	movq	%r15, %r8
	movq	%r14, %r9
	cmpl	%esi, %eax
	cmoval	%eax, %esi
	addq	32(%rsp), %r13                  # 8-byte Folded Reload
	addq	%r15, %r12
	subq	%r15, %rbp
	movl	%esi, 4(%rcx)
	movq	(%rdx), %rbx
	cmpq	%rbx, %r12
	jb	.LBB1_17
	jmp	.LBB1_158
.LBB1_20:
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	movq	(%r9), %rcx
	addq	$63, %rbx
	movl	%r8d, 60(%rsp)                  # 4-byte Spill
	movq	%rbx, %r12
	shrq	$6, %r12
	cmpq	%r12, 16(%r9)
	jae	.LBB1_21
# %bb.26:
	movq	%r9, %r14
	callq	free
	movq	8(%r14), %rcx
	callq	free
	leaq	(,%r12,8), %rsi
	movq	%rsi, %rcx
	callq	malloc
	leaq	(,%r12,4), %rcx
	movq	%rax, %rdi
	movq	%rax, (%r14)
	callq	malloc
	movq	%rax, 8(%r14)
	movq	%r12, 16(%r14)
	testq	%rdi, %rdi
	je	.LBB1_28
# %bb.27:
	movq	%rdi, %rcx
	movq	%r14, %r9
	testq	%rax, %rax
	jne	.LBB1_22
.LBB1_28:
	movq	64(%rsp), %rax                  # 8-byte Reload
	movl	$1, 16(%rax)
	jmp	.LBB1_158
.LBB1_18:
	movl	248(%rsp), %eax
	movl	$0, (%rcx)
	movl	%eax, 16(%rcx)
	jmp	.LBB1_158
.LBB1_21:
	leaq	(,%r12,8), %rsi
.LBB1_22:
	movq	%r9, 104(%rsp)                  # 8-byte Spill
	xorl	%edx, %edx
	movq	%rsi, %r8
	callq	memset
	movq	80(%rsp), %rax                  # 8-byte Reload
	movq	104(%rsp), %r14                 # 8-byte Reload
	movq	(%rax), %rcx
	andl	$63, %ecx
	cmpq	$1, %rcx
	sbbq	%rbp, %rbp
	xorl	%edx, %edx
	cmpl	$1, 60(%rsp)                    # 4-byte Folded Reload
	setne	%al
	sete	%r8b
	testq	%r12, %r12
	sete	%r9b
	orb	%al, %r9b
	jne	.LBB1_38
# %bb.23:
	movq	8(%r14), %r9
	cmpq	$512, %rbx                      # imm = 0x200
	jae	.LBB1_29
# %bb.24:
	xorl	%r10d, %r10d
	jmp	.LBB1_25
.LBB1_29:
	movabsq	$288230376151711680, %r11       # imm = 0x3FFFFFFFFFFFFC0
	cmpq	$4096, %rbx                     # imm = 0x1000
	jae	.LBB1_31
# %bb.30:
	xorl	%r10d, %r10d
	jmp	.LBB1_35
.LBB1_31:
	vmovdqa64	.LCPI1_0(%rip), %zmm0   # zmm0 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
	vpbroadcastd	.LCPI1_1(%rip), %zmm1   # zmm1 = [16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16]
	vpbroadcastd	.LCPI1_2(%rip), %zmm2   # zmm2 = [32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32]
	vpbroadcastd	.LCPI1_3(%rip), %zmm3   # zmm3 = [48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48]
	vpbroadcastd	.LCPI1_4(%rip), %zmm4   # zmm4 = [64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64]
	movq	%rbx, %rsi
	shrq	$12, %rsi
	movq	%r12, %r10
	andq	%r11, %r10
	xorl	%edi, %edi
	shlq	$8, %rsi
.LBB1_32:                               # =>This Inner Loop Header: Depth=1
	vpaddd	%zmm1, %zmm0, %zmm5
	vpaddd	%zmm2, %zmm0, %zmm16
	vpaddd	%zmm3, %zmm0, %zmm17
	vmovdqu64	%zmm0, (%r9,%rdi)
	vpaddd	%zmm4, %zmm0, %zmm0
	vmovdqu64	%zmm5, 64(%r9,%rdi)
	vmovdqu64	%zmm16, 128(%r9,%rdi)
	vmovdqu64	%zmm17, 192(%r9,%rdi)
	addq	$256, %rdi                      # imm = 0x100
	cmpq	%rdi, %rsi
	jne	.LBB1_32
# %bb.33:
	cmpq	%r10, %r12
	je	.LBB1_38
# %bb.34:
	testl	$3584, %ebx                     # imm = 0xE00
	je	.LBB1_25
.LBB1_35:
	movq	%r10, %rsi
	vpbroadcastd	%esi, %ymm0
	vpor	.LCPI1_5(%rip), %ymm0, %ymm0
	vpbroadcastd	.LCPI1_6(%rip), %ymm1   # ymm1 = [8,8,8,8,8,8,8,8]
	addq	$56, %r11
	movq	%r11, %r10
	andq	%r12, %r10
.LBB1_36:                               # =>This Inner Loop Header: Depth=1
	vmovdqu	%ymm0, (%r9,%rsi,4)
	addq	$8, %rsi
	vpaddd	%ymm1, %ymm0, %ymm0
	cmpq	%rsi, %r10
	jne	.LBB1_36
	jmp	.LBB1_37
.LBB1_25:
	movl	%r10d, (%r9,%r10,4)
	incq	%r10
.LBB1_37:
	cmpq	%r10, %r12
	jne	.LBB1_25
.LBB1_38:
	movq	80(%rsp), %rax                  # 8-byte Reload
	cmpq	$0, 16(%rax)
	je	.LBB1_158
# %bb.39:
	movq	$-1, %rax
	movb	%r8b, %dl
	leaq	-1(%r12), %r8
	movq	%r12, %r9
	negq	%r9
	vpcmpeqd	%ymm0, %ymm0, %ymm0
	vpternlogd	$255, %zmm1, %zmm1, %zmm1 # zmm1 = -1
	xorl	%r15d, %r15d
	movq	$0, 48(%rsp)                    # 8-byte Folded Spill
	movq	%r12, %r11
	movq	%r12, 40(%rsp)                  # 8-byte Spill
	shlxq	%rcx, %rax, %rax
	movq	80(%rsp), %rcx                  # 8-byte Reload
	movq	%r8, 32(%rsp)                   # 8-byte Spill
	movq	%r9, 88(%rsp)                   # 8-byte Spill
	notq	%rax
	orq	%rax, %rbp
	movq	%rbp, 72(%rsp)                  # 8-byte Spill
	movq	64(%rcx), %rax
	movq	72(%rcx), %r10
	movl	60(%rsp), %ecx                  # 4-byte Reload
	movq	%rcx, 208(%rsp)                 # 8-byte Spill
	leaq	-8(,%r12,8), %rcx
	movq	%rax, 224(%rsp)                 # 8-byte Spill
	leaq	192(%r10), %rax
	movq	%r10, 216(%rsp)                 # 8-byte Spill
	movq	%rax, 168(%rsp)                 # 8-byte Spill
	movq	%rcx, 136(%rsp)                 # 8-byte Spill
	leaq	-2(%r12), %rcx
	movq	%rcx, 192(%rsp)                 # 8-byte Spill
	leaq	-8(%r10,%r12,8), %rcx
	movq	%rcx, 144(%rsp)                 # 8-byte Spill
	movq	%r8, %rcx
	andq	$-32, %rcx
	movq	%rcx, 96(%rsp)                  # 8-byte Spill
	incq	%rcx
	movq	%rcx, 112(%rsp)                 # 8-byte Spill
	movq	%r8, %rcx
	andq	$-4, %rcx
	movq	%rcx, 128(%rsp)                 # 8-byte Spill
	incq	%rcx
	movq	%rcx, 120(%rsp)                 # 8-byte Spill
	movl	%r8d, %ecx
	andq	$-8, %r8
	andl	$7, %ecx
	movq	%r8, 200(%rsp)                  # 8-byte Spill
	leaq	200(%r10), %r8
	movq	%rcx, 152(%rsp)                 # 8-byte Spill
	movq	%r8, 176(%rsp)                  # 8-byte Spill
	leaq	8(%r10), %r8
	movq	%r8, 184(%rsp)                  # 8-byte Spill
.LBB1_40:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_119 Depth 2
                                        #     Child Loop BB1_123 Depth 2
                                        #     Child Loop BB1_126 Depth 2
                                        #     Child Loop BB1_130 Depth 2
                                        #     Child Loop BB1_140 Depth 2
                                        #     Child Loop BB1_145 Depth 2
                                        #     Child Loop BB1_148 Depth 2
                                        #     Child Loop BB1_152 Depth 2
                                        #     Child Loop BB1_49 Depth 2
                                        #     Child Loop BB1_68 Depth 2
                                        #     Child Loop BB1_89 Depth 2
                                        #     Child Loop BB1_79 Depth 2
	movq	224(%rsp), %rcx                 # 8-byte Reload
	movq	%r15, %rax
	shlq	$4, %rax
	movq	%r15, 160(%rsp)                 # 8-byte Spill
	movq	8(%rcx,%rax), %r8
	movq	216(%rsp), %rax                 # 8-byte Reload
	movl	%r8d, %r13d
	movq	%r8, %rdi
	shrq	$6, %rdi
	andl	$63, %r13d
	cmpl	$2, 60(%rsp)                    # 4-byte Folded Reload
	leaq	(%rax,%rdi,8), %rcx
	jb	.LBB1_73
# %bb.41:                               #   in Loop: Header=BB1_40 Depth=1
	movq	208(%rsp), %rax                 # 8-byte Reload
	leaq	switch_at(%rip), %r9
	movl	(%r9,%rax,4), %eax
	cmpq	%rax, %r15
	jne	.LBB1_73
# %bb.42:                               #   in Loop: Header=BB1_40 Depth=1
	testq	%r12, %r12
	je	.LBB1_43
# %bb.44:                               #   in Loop: Header=BB1_40 Depth=1
	movq	(%r14), %rdx
	cmpq	$0, 32(%rsp)                    # 8-byte Folded Reload
	movq	200(%rsp), %rsi                 # 8-byte Reload
	je	.LBB1_45
# %bb.46:                               #   in Loop: Header=BB1_40 Depth=1
	cmpq	$7, 192(%rsp)                   # 8-byte Folded Reload
	jae	.LBB1_48
# %bb.47:                               #   in Loop: Header=BB1_40 Depth=1
	xorl	%r11d, %r11d
	xorl	%r10d, %r10d
	jmp	.LBB1_67
.LBB1_73:                               #   in Loop: Header=BB1_40 Depth=1
	testl	%edx, %edx
	jne	.LBB1_74
# %bb.110:                              #   in Loop: Header=BB1_40 Depth=1
	movq	48(%rsp), %rdx                  # 8-byte Reload
	movq	64(%rsp), %rax                  # 8-byte Reload
	addq	%r12, %rdx
	movq	%rdx, 8(%rax)
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	(%r14), %rdx
	cmpq	$128, %rbx
	jb	.LBB1_154
# %bb.111:                              #   in Loop: Header=BB1_40 Depth=1
	movl	%r8d, %r14d
	andl	$63, %r14d
	testl	%r13d, %r13d
	je	.LBB1_132
# %bb.112:                              #   in Loop: Header=BB1_40 Depth=1
	movl	$64, %r10d
	movl	$1, %ebp
	subl	%r13d, %r10d
	cmpq	$4, 32(%rsp)                    # 8-byte Folded Reload
	jb	.LBB1_113
# %bb.114:                              #   in Loop: Header=BB1_40 Depth=1
	movq	144(%rsp), %rax                 # 8-byte Reload
	leaq	8(%rax,%rdi,8), %rax
	cmpq	%rax, %rdx
	jae	.LBB1_116
# %bb.115:                              #   in Loop: Header=BB1_40 Depth=1
	movq	136(%rsp), %rax                 # 8-byte Reload
	addq	%rdx, %rax
	cmpq	%rax, %rcx
	jae	.LBB1_116
.LBB1_113:                              #   in Loop: Header=BB1_40 Depth=1
	xorl	%r12d, %r12d
	xorl	%r15d, %r15d
.LBB1_125:                              #   in Loop: Header=BB1_40 Depth=1
	movq	40(%rsp), %rsi                  # 8-byte Reload
                                        # kill: def $esi killed $esi killed $rsi def $rsi
	subl	%ebp, %esi
	movq	%rbp, %rdi
	andl	$7, %esi
	je	.LBB1_128
.LBB1_126:                              #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	shrxq	%r14, (%rcx,%r12,8), %r9
	shlxq	%r10, 8(%rcx,%r12,8), %rax
	orq	(%rdx,%r12,8), %r9
	orq	%rax, %r9
	movq	%r9, (%rdx,%r12,8)
	notq	%r9
	movq	%rdi, %r12
	incq	%rdi
	orq	%r9, %r15
	decq	%rsi
	jne	.LBB1_126
# %bb.127:                              #   in Loop: Header=BB1_40 Depth=1
	leaq	-1(%rdi), %r12
.LBB1_128:                              #   in Loop: Header=BB1_40 Depth=1
	subq	40(%rsp), %rbp                  # 8-byte Folded Reload
	cmpq	$-8, %rbp
	ja	.LBB1_131
# %bb.129:                              #   in Loop: Header=BB1_40 Depth=1
	addq	$7, %rdi
.LBB1_130:                              #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	shrxq	%r14, (%rcx,%r12,8), %r9
	shlxq	%r10, 8(%rcx,%r12,8), %rax
	orq	(%rdx,%r12,8), %r9
	orq	%rax, %r9
	movq	%r9, (%rdx,%r12,8)
	movq	%rdi, %r12
	shrxq	%r14, -56(%rcx,%rdi,8), %rdi
	shlxq	%r10, -48(%rcx,%r12,8), %rax
	orq	-56(%rdx,%r12,8), %rdi
	orq	%rax, %rdi
	movq	%rdi, -56(%rdx,%r12,8)
	andq	%r9, %rdi
	shrxq	%r14, -48(%rcx,%r12,8), %rbp
	shlxq	%r10, -40(%rcx,%r12,8), %rax
	orq	-48(%rdx,%r12,8), %rbp
	orq	%rax, %rbp
	movq	%rbp, -48(%rdx,%r12,8)
	shrxq	%r14, -40(%rcx,%r12,8), %rsi
	shlxq	%r10, -32(%rcx,%r12,8), %rax
	orq	-40(%rdx,%r12,8), %rsi
	orq	%rax, %rsi
	movq	%rsi, -40(%rdx,%r12,8)
	andq	%rbp, %rsi
	shrxq	%r14, -32(%rcx,%r12,8), %rax
	shlxq	%r10, -24(%rcx,%r12,8), %r9
	andq	%rdi, %rsi
	orq	-32(%rdx,%r12,8), %rax
	orq	%r9, %rax
	movq	%rax, -32(%rdx,%r12,8)
	shrxq	%r14, -24(%rcx,%r12,8), %rbp
	shlxq	%r10, -16(%rcx,%r12,8), %r9
	orq	-24(%rdx,%r12,8), %rbp
	orq	%r9, %rbp
	movq	%rbp, -24(%rdx,%r12,8)
	andq	%rax, %rbp
	shrxq	%r14, -16(%rcx,%r12,8), %rdi
	shlxq	%r10, -8(%rcx,%r12,8), %r9
	orq	-16(%rdx,%r12,8), %rdi
	orq	%r9, %rdi
	movq	%rdi, -16(%rdx,%r12,8)
	andq	%rbp, %rdi
	shrxq	%r14, -8(%rcx,%r12,8), %r9
	shlxq	%r10, (%rcx,%r12,8), %rax
	andq	%rsi, %rdi
	orq	-8(%rdx,%r12,8), %r9
	orq	%rax, %r9
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	%r9, -8(%rdx,%r12,8)
	andq	%rdi, %r9
	leaq	8(%r12), %rdi
	notq	%r9
	orq	%r9, %r15
	leaq	8(%rax,%r12), %rax
	cmpq	$7, %rax
	jne	.LBB1_130
.LBB1_131:                              #   in Loop: Header=BB1_40 Depth=1
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	movq	72(%rsp), %rbp                  # 8-byte Reload
	leaq	(%rdx,%rax,8), %rdi
	movq	-8(%rdx,%r12,8), %rdx
	movq	-8(%rcx,%r12,8), %r14
	jmp	.LBB1_155
.LBB1_154:                              #   in Loop: Header=BB1_40 Depth=1
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	-8(%rcx,%r12,8), %r14
	movl	$0, %r15d
	movl	$0, %r10d
	movl	$0, %esi
	leaq	(%rdx,%rax,8), %rdi
	movq	-8(%rdx,%r12,8), %rdx
	testl	%r13d, %r13d
	je	.LBB1_156
.LBB1_155:                              #   in Loop: Header=BB1_40 Depth=1
	negb	%r13b
	movq	%r15, %r10
	shlxq	%r13, (%rcx,%r12,8), %rsi
	jmp	.LBB1_156
.LBB1_45:                               #   in Loop: Header=BB1_40 Depth=1
	xorl	%r11d, %r11d
	xorl	%r10d, %r10d
	jmp	.LBB1_71
.LBB1_48:                               #   in Loop: Header=BB1_40 Depth=1
	xorl	%r11d, %r11d
	xorl	%r10d, %r10d
	jmp	.LBB1_49
.LBB1_65:                               #   in Loop: Header=BB1_49 Depth=2
	addq	$8, %r10
	cmpq	%r10, %rsi
	je	.LBB1_66
.LBB1_49:                               #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	$-1, (%rdx,%r10,8)
	je	.LBB1_51
# %bb.50:                               #   in Loop: Header=BB1_49 Depth=2
	movq	8(%r14), %rax
	movl	%r10d, (%rax,%r11,4)
	incq	%r11
.LBB1_51:                               #   in Loop: Header=BB1_49 Depth=2
	cmpq	$-1, 8(%rdx,%r10,8)
	je	.LBB1_53
# %bb.52:                               #   in Loop: Header=BB1_49 Depth=2
	movq	8(%r14), %r9
	leal	1(%r10), %eax
	movl	%eax, (%r9,%r11,4)
	incq	%r11
.LBB1_53:                               #   in Loop: Header=BB1_49 Depth=2
	cmpq	$-1, 16(%rdx,%r10,8)
	je	.LBB1_55
# %bb.54:                               #   in Loop: Header=BB1_49 Depth=2
	movq	8(%r14), %r9
	leal	2(%r10), %eax
	movl	%eax, (%r9,%r11,4)
	incq	%r11
.LBB1_55:                               #   in Loop: Header=BB1_49 Depth=2
	cmpq	$-1, 24(%rdx,%r10,8)
	je	.LBB1_57
# %bb.56:                               #   in Loop: Header=BB1_49 Depth=2
	movq	8(%r14), %r9
	leal	3(%r10), %eax
	movl	%eax, (%r9,%r11,4)
	incq	%r11
.LBB1_57:                               #   in Loop: Header=BB1_49 Depth=2
	cmpq	$-1, 32(%rdx,%r10,8)
	je	.LBB1_59
# %bb.58:                               #   in Loop: Header=BB1_49 Depth=2
	movq	8(%r14), %r9
	leal	4(%r10), %eax
	movl	%eax, (%r9,%r11,4)
	incq	%r11
.LBB1_59:                               #   in Loop: Header=BB1_49 Depth=2
	cmpq	$-1, 40(%rdx,%r10,8)
	je	.LBB1_61
# %bb.60:                               #   in Loop: Header=BB1_49 Depth=2
	movq	8(%r14), %r9
	leal	5(%r10), %eax
	movl	%eax, (%r9,%r11,4)
	incq	%r11
.LBB1_61:                               #   in Loop: Header=BB1_49 Depth=2
	cmpq	$-1, 48(%rdx,%r10,8)
	je	.LBB1_63
# %bb.62:                               #   in Loop: Header=BB1_49 Depth=2
	movq	8(%r14), %r9
	leal	6(%r10), %eax
	movl	%eax, (%r9,%r11,4)
	incq	%r11
.LBB1_63:                               #   in Loop: Header=BB1_49 Depth=2
	cmpq	$-1, 56(%rdx,%r10,8)
	je	.LBB1_65
# %bb.64:                               #   in Loop: Header=BB1_49 Depth=2
	movq	8(%r14), %r9
	leal	7(%r10), %eax
	movl	%eax, (%r9,%r11,4)
	incq	%r11
	jmp	.LBB1_65
.LBB1_66:                               #   in Loop: Header=BB1_40 Depth=1
	cmpq	$0, 152(%rsp)                   # 8-byte Folded Reload
	je	.LBB1_71
.LBB1_67:                               #   in Loop: Header=BB1_40 Depth=1
	movq	152(%rsp), %rsi                 # 8-byte Reload
	jmp	.LBB1_68
.LBB1_70:                               #   in Loop: Header=BB1_68 Depth=2
	incq	%r10
	decq	%rsi
	je	.LBB1_71
.LBB1_68:                               #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	$-1, (%rdx,%r10,8)
	je	.LBB1_70
# %bb.69:                               #   in Loop: Header=BB1_68 Depth=2
	movq	8(%r14), %rax
	movl	%r10d, (%rax,%r11,4)
	incq	%r11
	jmp	.LBB1_70
.LBB1_71:                               #   in Loop: Header=BB1_40 Depth=1
	cmpq	32(%rsp), %r10                  # 8-byte Folded Reload
	movq	(%rdx,%r10,8), %rax
	movq	$-1, %rdx
	cmoveq	%rbp, %rdx
	andnq	%rdx, %rax, %rax
	je	.LBB1_74
# %bb.72:                               #   in Loop: Header=BB1_40 Depth=1
	movq	8(%r14), %rax
	movl	%r10d, (%rax,%r11,4)
	incq	%r11
.LBB1_74:                               #   in Loop: Header=BB1_40 Depth=1
	movq	48(%rsp), %rax                  # 8-byte Reload
	movq	64(%rsp), %rdx                  # 8-byte Reload
	addq	%r11, %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 8(%rdx)
	testq	%r11, %r11
	je	.LBB1_87
# %bb.75:                               #   in Loop: Header=BB1_40 Depth=1
	movq	(%r14), %rdx
	movq	8(%r14), %r10
	movl	$64, %r14d
	movl	%r11d, %r12d
	andl	$63, %r8d
	andl	$3, %r12d
	subl	%r13d, %r14d
	cmpq	$4, %r11
	jae	.LBB1_88
# %bb.76:                               #   in Loop: Header=BB1_40 Depth=1
	xorl	%edi, %edi
	xorl	%r15d, %r15d
	jmp	.LBB1_78
.LBB1_88:                               #   in Loop: Header=BB1_40 Depth=1
	andq	$-4, %r11
	xorl	%edi, %edi
	xorl	%r15d, %r15d
	jmp	.LBB1_89
.LBB1_109:                              #   in Loop: Header=BB1_89 Depth=2
	addq	$4, %rdi
	cmpq	%rdi, %r11
	je	.LBB1_77
.LBB1_89:                               #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%r10,%rdi,4), %esi
	testl	%r13d, %r13d
	je	.LBB1_90
# %bb.91:                               #   in Loop: Header=BB1_89 Depth=2
	shlxq	%r14, 8(%rcx,%rsi,8), %r9
	jmp	.LBB1_92
.LBB1_90:                               #   in Loop: Header=BB1_89 Depth=2
	xorl	%r9d, %r9d
.LBB1_92:                               #   in Loop: Header=BB1_89 Depth=2
	shrxq	%r8, (%rcx,%rsi,8), %rax
	orq	(%rdx,%rsi,8), %r9
	orq	%rax, %r9
	cmpq	%rsi, 32(%rsp)                  # 8-byte Folded Reload
	movq	$-1, %rax
	movq	%r9, (%rdx,%rsi,8)
	cmoveq	%rbp, %rax
	andnq	%rax, %r9, %rax
	je	.LBB1_94
# %bb.93:                               #   in Loop: Header=BB1_89 Depth=2
	movl	%esi, (%r10,%r15,4)
	incq	%r15
.LBB1_94:                               #   in Loop: Header=BB1_89 Depth=2
	movl	4(%r10,%rdi,4), %esi
	movq	(%rdx,%rsi,8), %rbp
	movq	(%rcx,%rsi,8), %r9
	testl	%r13d, %r13d
	je	.LBB1_95
# %bb.96:                               #   in Loop: Header=BB1_89 Depth=2
	shlxq	%r14, 8(%rcx,%rsi,8), %rax
	jmp	.LBB1_97
.LBB1_95:                               #   in Loop: Header=BB1_89 Depth=2
	xorl	%eax, %eax
.LBB1_97:                               #   in Loop: Header=BB1_89 Depth=2
	orq	%rax, %rbp
	shrxq	%r8, %r9, %rax
	movq	$-1, %r9
	orq	%rbp, %rax
	cmpq	%rsi, 32(%rsp)                  # 8-byte Folded Reload
	movq	%rax, (%rdx,%rsi,8)
	cmoveq	72(%rsp), %r9                   # 8-byte Folded Reload
	andnq	%r9, %rax, %rax
	je	.LBB1_99
# %bb.98:                               #   in Loop: Header=BB1_89 Depth=2
	movl	%esi, (%r10,%r15,4)
	incq	%r15
.LBB1_99:                               #   in Loop: Header=BB1_89 Depth=2
	movl	8(%r10,%rdi,4), %esi
	movq	(%rdx,%rsi,8), %rbp
	movq	(%rcx,%rsi,8), %r9
	testl	%r13d, %r13d
	je	.LBB1_100
# %bb.101:                              #   in Loop: Header=BB1_89 Depth=2
	shlxq	%r14, 8(%rcx,%rsi,8), %rax
	jmp	.LBB1_102
.LBB1_100:                              #   in Loop: Header=BB1_89 Depth=2
	xorl	%eax, %eax
.LBB1_102:                              #   in Loop: Header=BB1_89 Depth=2
	orq	%rax, %rbp
	shrxq	%r8, %r9, %rax
	movq	$-1, %r9
	orq	%rbp, %rax
	cmpq	%rsi, 32(%rsp)                  # 8-byte Folded Reload
	movq	%rax, (%rdx,%rsi,8)
	cmoveq	72(%rsp), %r9                   # 8-byte Folded Reload
	andnq	%r9, %rax, %rax
	je	.LBB1_104
# %bb.103:                              #   in Loop: Header=BB1_89 Depth=2
	movl	%esi, (%r10,%r15,4)
	incq	%r15
.LBB1_104:                              #   in Loop: Header=BB1_89 Depth=2
	movl	12(%r10,%rdi,4), %esi
	movq	(%rdx,%rsi,8), %rbp
	movq	(%rcx,%rsi,8), %r9
	testl	%r13d, %r13d
	je	.LBB1_105
# %bb.106:                              #   in Loop: Header=BB1_89 Depth=2
	shlxq	%r14, 8(%rcx,%rsi,8), %rax
	jmp	.LBB1_107
.LBB1_105:                              #   in Loop: Header=BB1_89 Depth=2
	xorl	%eax, %eax
.LBB1_107:                              #   in Loop: Header=BB1_89 Depth=2
	orq	%rax, %rbp
	shrxq	%r8, %r9, %rax
	movq	$-1, %r9
	orq	%rbp, %rax
	cmpq	%rsi, 32(%rsp)                  # 8-byte Folded Reload
	movq	72(%rsp), %rbp                  # 8-byte Reload
	movq	%rax, (%rdx,%rsi,8)
	cmoveq	%rbp, %r9
	andnq	%r9, %rax, %rax
	je	.LBB1_109
# %bb.108:                              #   in Loop: Header=BB1_89 Depth=2
	movl	%esi, (%r10,%r15,4)
	incq	%r15
	jmp	.LBB1_109
.LBB1_77:                               #   in Loop: Header=BB1_40 Depth=1
	testq	%r12, %r12
	je	.LBB1_85
.LBB1_78:                               #   in Loop: Header=BB1_40 Depth=1
	leaq	(%r10,%rdi,4), %r11
	xorl	%edi, %edi
	jmp	.LBB1_79
.LBB1_84:                               #   in Loop: Header=BB1_79 Depth=2
	incq	%rdi
	cmpq	%rdi, %r12
	je	.LBB1_85
.LBB1_79:                               #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%r11,%rdi,4), %esi
	testl	%r13d, %r13d
	je	.LBB1_80
# %bb.81:                               #   in Loop: Header=BB1_79 Depth=2
	shlxq	%r14, 8(%rcx,%rsi,8), %r9
	jmp	.LBB1_82
.LBB1_80:                               #   in Loop: Header=BB1_79 Depth=2
	xorl	%r9d, %r9d
.LBB1_82:                               #   in Loop: Header=BB1_79 Depth=2
	shrxq	%r8, (%rcx,%rsi,8), %rax
	orq	(%rdx,%rsi,8), %r9
	orq	%rax, %r9
	cmpq	%rsi, 32(%rsp)                  # 8-byte Folded Reload
	movq	$-1, %rax
	movq	%r9, (%rdx,%rsi,8)
	cmoveq	%rbp, %rax
	andnq	%rax, %r9, %rax
	je	.LBB1_84
# %bb.83:                               #   in Loop: Header=BB1_79 Depth=2
	movl	%esi, (%r10,%r15,4)
	incq	%r15
	jmp	.LBB1_84
.LBB1_85:                               #   in Loop: Header=BB1_40 Depth=1
	movq	40(%rsp), %r12                  # 8-byte Reload
	movl	$1, %edx
	testq	%r15, %r15
	movq	%r15, %r11
	jmp	.LBB1_86
.LBB1_132:                              #   in Loop: Header=BB1_40 Depth=1
	cmpq	$4, 32(%rsp)                    # 8-byte Folded Reload
	movl	$1, %r15d
	jae	.LBB1_134
# %bb.133:                              #   in Loop: Header=BB1_40 Depth=1
	movq	88(%rsp), %r13                  # 8-byte Reload
	xorl	%edi, %edi
	xorl	%r10d, %r10d
	jmp	.LBB1_147
.LBB1_134:                              #   in Loop: Header=BB1_40 Depth=1
	movq	144(%rsp), %rax                 # 8-byte Reload
	movq	88(%rsp), %r13                  # 8-byte Reload
	leaq	(%rax,%rdi,8), %rax
	cmpq	%rax, %rdx
	jae	.LBB1_137
# %bb.135:                              #   in Loop: Header=BB1_40 Depth=1
	movq	136(%rsp), %rax                 # 8-byte Reload
	addq	%rdx, %rax
	cmpq	%rax, %rcx
	jae	.LBB1_137
# %bb.136:                              #   in Loop: Header=BB1_40 Depth=1
	xorl	%edi, %edi
	xorl	%r10d, %r10d
	jmp	.LBB1_147
.LBB1_116:                              #   in Loop: Header=BB1_40 Depth=1
	cmpq	$32, 32(%rsp)                   # 8-byte Folded Reload
	jae	.LBB1_118
# %bb.117:                              #   in Loop: Header=BB1_40 Depth=1
	xorl	%esi, %esi
	xorl	%r15d, %r15d
	jmp	.LBB1_122
.LBB1_137:                              #   in Loop: Header=BB1_40 Depth=1
	cmpq	$32, 32(%rsp)                   # 8-byte Folded Reload
	jae	.LBB1_139
# %bb.138:                              #   in Loop: Header=BB1_40 Depth=1
	xorl	%esi, %esi
	xorl	%r10d, %r10d
	jmp	.LBB1_144
.LBB1_118:                              #   in Loop: Header=BB1_40 Depth=1
	movq	176(%rsp), %rax                 # 8-byte Reload
	vpbroadcastq	%r10, %zmm3
	vpbroadcastq	%r14, %zmm4
	vpxor	%xmm2, %xmm2, %xmm2
	xorl	%r12d, %r12d
	vpxor	%xmm5, %xmm5, %xmm5
	vpxord	%xmm17, %xmm17, %xmm17
	vpxord	%xmm16, %xmm16, %xmm16
	leaq	(%rax,%rdi,8), %r15
	movq	96(%rsp), %rax                  # 8-byte Reload
.LBB1_119:                              #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovdqu64	-192(%r15,%r12,8), %zmm21
	vmovdqu64	-128(%r15,%r12,8), %zmm23
	vmovdqu64	-64(%r15,%r12,8), %zmm24
	vmovdqu64	(%r15,%r12,8), %zmm25
	vmovdqu64	-72(%r15,%r12,8), %zmm18
	vmovdqu64	-8(%r15,%r12,8), %zmm19
	vmovdqu64	-200(%r15,%r12,8), %zmm20
	vmovdqu64	-136(%r15,%r12,8), %zmm22
	vpsllvq	%zmm3, %zmm21, %zmm21
	vpsllvq	%zmm3, %zmm23, %zmm23
	vpsllvq	%zmm3, %zmm24, %zmm24
	vpsllvq	%zmm3, %zmm25, %zmm25
	vpsrlvq	%zmm4, %zmm20, %zmm20
	vpsrlvq	%zmm4, %zmm22, %zmm22
	vpsrlvq	%zmm4, %zmm18, %zmm18
	vpsrlvq	%zmm4, %zmm19, %zmm19
	vpternlogq	$254, (%rdx,%r12,8), %zmm21, %zmm20 # zmm20 = zmm20 | zmm21 | mem
	vpternlogq	$254, 64(%rdx,%r12,8), %zmm23, %zmm22 # zmm22 = zmm22 | zmm23 | mem
	vpternlogq	$254, 128(%rdx,%r12,8), %zmm24, %zmm18 # zmm18 = zmm18 | zmm24 | mem
	vpternlogq	$254, 192(%rdx,%r12,8), %zmm25, %zmm19 # zmm19 = zmm19 | zmm25 | mem
	vmovdqu64	%zmm20, (%rdx,%r12,8)
	vmovdqu64	%zmm22, 64(%rdx,%r12,8)
	vmovdqu64	%zmm18, 128(%rdx,%r12,8)
	vmovdqu64	%zmm19, 192(%rdx,%r12,8)
	vpternlogq	$246, %zmm1, %zmm20, %zmm5 # zmm5 = zmm5 | (zmm20 ^ zmm1)
	vpternlogq	$246, %zmm1, %zmm22, %zmm17 # zmm17 = zmm17 | (zmm22 ^ zmm1)
	vpternlogq	$246, %zmm1, %zmm18, %zmm16 # zmm16 = zmm16 | (zmm18 ^ zmm1)
	vpternlogq	$246, %zmm1, %zmm19, %zmm2 # zmm2 = zmm2 | (zmm19 ^ zmm1)
	addq	$32, %r12
	cmpq	%r12, %rax
	jne	.LBB1_119
# %bb.120:                              #   in Loop: Header=BB1_40 Depth=1
	vporq	%zmm5, %zmm17, %zmm3
	vpternlogq	$254, %zmm3, %zmm16, %zmm2 # zmm2 = zmm2 | zmm16 | zmm3
	vextracti64x4	$1, %zmm2, %ymm3
	vporq	%zmm3, %zmm2, %zmm2
	vextracti128	$1, %ymm2, %xmm3
	vpor	%xmm3, %xmm2, %xmm2
	vpshufd	$238, %xmm2, %xmm3              # xmm3 = xmm2[2,3,2,3]
	vpor	%xmm3, %xmm2, %xmm2
	vmovq	%xmm2, %r15
	cmpq	%rax, 32(%rsp)                  # 8-byte Folded Reload
	je	.LBB1_131
# %bb.121:                              #   in Loop: Header=BB1_40 Depth=1
	movq	112(%rsp), %rbp                 # 8-byte Reload
	testb	$28, 32(%rsp)                   # 1-byte Folded Reload
	movq	%rax, %rsi
	movq	%rax, %r12
	je	.LBB1_125
.LBB1_122:                              #   in Loop: Header=BB1_40 Depth=1
	movq	184(%rsp), %rax                 # 8-byte Reload
	vmovq	%r15, %xmm2
	vpbroadcastq	%r10, %ymm3
	vpbroadcastq	%r14, %ymm4
	leaq	(%rax,%rdi,8), %rdi
	movq	128(%rsp), %rax                 # 8-byte Reload
.LBB1_123:                              #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovdqu	-8(%rdi,%rsi,8), %ymm5
	vmovdqu64	(%rdi,%rsi,8), %ymm16
	vpsrlvq	%ymm4, %ymm5, %ymm5
	vpsllvq	%ymm3, %ymm16, %ymm16
	vpternlogq	$254, (%rdx,%rsi,8), %ymm5, %ymm16 # ymm16 = ymm16 | ymm5 | mem
	vmovdqu64	%ymm16, (%rdx,%rsi,8)
	vpternlogq	$246, %ymm0, %ymm16, %ymm2 # ymm2 = ymm2 | (ymm16 ^ ymm0)
	addq	$4, %rsi
	cmpq	%rsi, %rax
	jne	.LBB1_123
# %bb.124:                              #   in Loop: Header=BB1_40 Depth=1
	vextracti128	$1, %ymm2, %xmm3
	movq	120(%rsp), %rbp                 # 8-byte Reload
	movq	%rax, %r12
	vpor	%xmm3, %xmm2, %xmm2
	vpshufd	$238, %xmm2, %xmm3              # xmm3 = xmm2[2,3,2,3]
	vpor	%xmm3, %xmm2, %xmm2
	vmovq	%xmm2, %r15
	cmpq	%rax, 32(%rsp)                  # 8-byte Folded Reload
	jne	.LBB1_125
	jmp	.LBB1_131
.LBB1_139:                              #   in Loop: Header=BB1_40 Depth=1
	movq	168(%rsp), %rax                 # 8-byte Reload
	vpbroadcastq	%r14, %zmm3
	vpxor	%xmm2, %xmm2, %xmm2
	vpxor	%xmm4, %xmm4, %xmm4
	vpxord	%xmm16, %xmm16, %xmm16
	vpxor	%xmm5, %xmm5, %xmm5
	leaq	(%rax,%rdi,8), %r10
	movq	96(%rsp), %rax                  # 8-byte Reload
	xorl	%edi, %edi
.LBB1_140:                              #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovdqu64	-192(%r10,%rdi,8), %zmm17
	vmovdqu64	-128(%r10,%rdi,8), %zmm18
	vmovdqu64	-64(%r10,%rdi,8), %zmm19
	vmovdqu64	(%r10,%rdi,8), %zmm20
	vpsrlvq	%zmm3, %zmm17, %zmm17
	vpsrlvq	%zmm3, %zmm18, %zmm18
	vpsrlvq	%zmm3, %zmm19, %zmm19
	vpsrlvq	%zmm3, %zmm20, %zmm20
	vporq	(%rdx,%rdi,8), %zmm17, %zmm17
	vporq	64(%rdx,%rdi,8), %zmm18, %zmm18
	vporq	128(%rdx,%rdi,8), %zmm19, %zmm19
	vporq	192(%rdx,%rdi,8), %zmm20, %zmm20
	vmovdqu64	%zmm17, (%rdx,%rdi,8)
	vmovdqu64	%zmm18, 64(%rdx,%rdi,8)
	vmovdqu64	%zmm19, 128(%rdx,%rdi,8)
	vmovdqu64	%zmm20, 192(%rdx,%rdi,8)
	vpternlogq	$246, %zmm1, %zmm17, %zmm4 # zmm4 = zmm4 | (zmm17 ^ zmm1)
	vpternlogq	$246, %zmm1, %zmm18, %zmm16 # zmm16 = zmm16 | (zmm18 ^ zmm1)
	vpternlogq	$246, %zmm1, %zmm19, %zmm5 # zmm5 = zmm5 | (zmm19 ^ zmm1)
	vpternlogq	$246, %zmm1, %zmm20, %zmm2 # zmm2 = zmm2 | (zmm20 ^ zmm1)
	addq	$32, %rdi
	cmpq	%rdi, %rax
	jne	.LBB1_140
# %bb.141:                              #   in Loop: Header=BB1_40 Depth=1
	vporq	%zmm4, %zmm16, %zmm3
	vpternlogq	$254, %zmm3, %zmm5, %zmm2 # zmm2 = zmm2 | zmm5 | zmm3
	vextracti64x4	$1, %zmm2, %ymm3
	vporq	%zmm3, %zmm2, %zmm2
	vextracti128	$1, %ymm2, %xmm3
	vpor	%xmm3, %xmm2, %xmm2
	vpshufd	$238, %xmm2, %xmm3              # xmm3 = xmm2[2,3,2,3]
	vpor	%xmm3, %xmm2, %xmm2
	vmovq	%xmm2, %r10
	cmpq	%rax, 32(%rsp)                  # 8-byte Folded Reload
	jne	.LBB1_143
# %bb.142:                              #   in Loop: Header=BB1_40 Depth=1
	movq	72(%rsp), %rbp                  # 8-byte Reload
	jmp	.LBB1_153
.LBB1_143:                              #   in Loop: Header=BB1_40 Depth=1
	movq	96(%rsp), %rdi                  # 8-byte Reload
	movq	112(%rsp), %r15                 # 8-byte Reload
	testb	$28, 32(%rsp)                   # 1-byte Folded Reload
	movq	72(%rsp), %rbp                  # 8-byte Reload
	movq	88(%rsp), %r13                  # 8-byte Reload
	movq	%rdi, %rsi
	je	.LBB1_147
.LBB1_144:                              #   in Loop: Header=BB1_40 Depth=1
	movq	128(%rsp), %rax                 # 8-byte Reload
	vmovq	%r10, %xmm2
	vpbroadcastq	%r14, %ymm3
.LBB1_145:                              #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovdqu	(%rcx,%rsi,8), %ymm4
	vpsrlvq	%ymm3, %ymm4, %ymm4
	vpor	(%rdx,%rsi,8), %ymm4, %ymm4
	vmovdqu	%ymm4, (%rdx,%rsi,8)
	vpternlogq	$246, %ymm0, %ymm4, %ymm2 # ymm2 = ymm2 | (ymm4 ^ ymm0)
	addq	$4, %rsi
	cmpq	%rsi, %rax
	jne	.LBB1_145
# %bb.146:                              #   in Loop: Header=BB1_40 Depth=1
	vextracti128	$1, %ymm2, %xmm3
	movq	120(%rsp), %r15                 # 8-byte Reload
	movq	%rax, %rdi
	vpor	%xmm3, %xmm2, %xmm2
	vpshufd	$238, %xmm2, %xmm3              # xmm3 = xmm2[2,3,2,3]
	vpor	%xmm3, %xmm2, %xmm2
	vmovq	%xmm2, %r10
	cmpq	%rax, 32(%rsp)                  # 8-byte Folded Reload
	je	.LBB1_153
.LBB1_147:                              #   in Loop: Header=BB1_40 Depth=1
	movq	40(%rsp), %rsi                  # 8-byte Reload
                                        # kill: def $esi killed $esi killed $rsi def $rsi
	subl	%r15d, %esi
	movq	%r15, %r12
	andl	$7, %esi
	je	.LBB1_150
.LBB1_148:                              #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	shrxq	%r14, (%rcx,%rdi,8), %rax
	orq	(%rdx,%rdi,8), %rax
	movq	%rax, (%rdx,%rdi,8)
	notq	%rax
	movq	%r12, %rdi
	incq	%r12
	orq	%rax, %r10
	decq	%rsi
	jne	.LBB1_148
# %bb.149:                              #   in Loop: Header=BB1_40 Depth=1
	leaq	-1(%r12), %rdi
.LBB1_150:                              #   in Loop: Header=BB1_40 Depth=1
	subq	40(%rsp), %r15                  # 8-byte Folded Reload
	cmpq	$-8, %r15
	ja	.LBB1_153
# %bb.151:                              #   in Loop: Header=BB1_40 Depth=1
	addq	$7, %r12
.LBB1_152:                              #   Parent Loop BB1_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	shrxq	%r14, (%rcx,%rdi,8), %rax
	orq	(%rdx,%rdi,8), %rax
	movq	%rax, (%rdx,%rdi,8)
	movq	%r12, %rdi
	shrxq	%r14, -56(%rcx,%r12,8), %r9
	orq	-56(%rdx,%r12,8), %r9
	movq	%r9, -56(%rdx,%r12,8)
	andq	%rax, %r9
	shrxq	%r14, -48(%rcx,%r12,8), %rsi
	orq	-48(%rdx,%r12,8), %rsi
	movq	%rsi, -48(%rdx,%r12,8)
	shrxq	%r14, -40(%rcx,%r12,8), %r15
	orq	-40(%rdx,%r12,8), %r15
	movq	%r15, -40(%rdx,%r12,8)
	andq	%rsi, %r15
	shrxq	%r14, -32(%rcx,%r12,8), %rax
	andq	%r9, %r15
	orq	-32(%rdx,%r12,8), %rax
	movq	%rax, -32(%rdx,%r12,8)
	shrxq	%r14, -24(%rcx,%r12,8), %rsi
	orq	-24(%rdx,%r12,8), %rsi
	movq	%rsi, -24(%rdx,%r12,8)
	andq	%rax, %rsi
	shrxq	%r14, -16(%rcx,%r12,8), %rax
	orq	-16(%rdx,%r12,8), %rax
	movq	%rax, -16(%rdx,%r12,8)
	andq	%rsi, %rax
	shrxq	%r14, -8(%rcx,%r12,8), %r9
	andq	%r15, %rax
	orq	-8(%rdx,%r12,8), %r9
	movq	%r9, -8(%rdx,%r12,8)
	andq	%rax, %r9
	leaq	8(%r13,%rdi), %rax
	addq	$8, %r12
	notq	%r9
	orq	%r9, %r10
	cmpq	$7, %rax
	jne	.LBB1_152
.LBB1_153:                              #   in Loop: Header=BB1_40 Depth=1
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	xorl	%esi, %esi
	leaq	(%rdx,%rax,8), %rdi
	movq	-8(%rdx,%r12,8), %rdx
	movq	-8(%rcx,%r12,8), %r14
.LBB1_156:                              #   in Loop: Header=BB1_40 Depth=1
	orq	%rsi, %rdx
	shrxq	%r8, %r14, %rax
	orq	%rdx, %rax
	xorl	%edx, %edx
	movq	%rax, (%rdi)
	andnq	%rbp, %rax, %rax
	orq	%r10, %rax
.LBB1_86:                               #   in Loop: Header=BB1_40 Depth=1
	movq	160(%rsp), %r15                 # 8-byte Reload
	movq	104(%rsp), %r14                 # 8-byte Reload
	je	.LBB1_87
# %bb.157:                              #   in Loop: Header=BB1_40 Depth=1
	movq	80(%rsp), %rax                  # 8-byte Reload
	incq	%r15
	cmpq	16(%rax), %r15
	jb	.LBB1_40
	jmp	.LBB1_158
.LBB1_43:
	movq	48(%rsp), %rax                  # 8-byte Reload
	movq	64(%rsp), %rcx                  # 8-byte Reload
	movq	%rax, 8(%rcx)
.LBB1_87:
	movq	64(%rsp), %rax                  # 8-byte Reload
	incl	%r15d
	movl	$1, (%rax)
	movl	%r15d, 4(%rax)
	jmp	.LBB1_158
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
	movq	%rcx, %rdi
	movq	%rdx, %rsi
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
	leaq	-2049(%rbx), %r10
	setb	%r8b
	cmpq	$536870913, %rdx                # imm = 0x20000001
	setae	%r9b
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
	movq	%rbx, %rcx
	shlq	$4, %rcx
	vmovups	64(%rsp), %ymm0
	vmovups	%ymm0, 32(%rsi)
	vzeroupper
	callq	malloc
	leaq	8(,%r15,8), %rcx
	movq	%rax, %r14
	movq	%rax, 64(%rsi)
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
