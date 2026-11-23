	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
@feat.00 = 0
	.att_syntax
	.file	"native_pool_grid.c"
	.def	unused_cached_main;
	.scl	2;
	.type	32;
	.endef
	.section	.rdata,"dr"
	.p2align	3, 0x0                          # -- Begin function unused_cached_main
.LCPI0_0:
	.quad	0x3e7ad7f29abcaf48              # double 9.9999999999999995E-8
	.section	.text$unused_cached_main,"xr",one_only,unused_cached_main,unique,0
	.globl	unused_cached_main
	.p2align	4
unused_cached_main:                     # @unused_cached_main
.seh_proc unused_cached_main
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
	subq	$264, %rsp                      # imm = 0x108
	.seh_stackalloc 264
	vmovapd	%xmm9, 240(%rsp)                # 16-byte Spill
	.seh_savexmm %xmm9, 240
	vmovapd	%xmm8, 224(%rsp)                # 16-byte Spill
	.seh_savexmm %xmm8, 224
	vmovapd	%xmm7, 208(%rsp)                # 16-byte Spill
	.seh_savexmm %xmm7, 208
	vmovapd	%xmm6, 192(%rsp)                # 16-byte Spill
	.seh_savexmm %xmm6, 192
	.seh_endprologue
	movl	$2, %eax
	cmpl	$2, %ecx
	jne	.LBB0_3
# %bb.1:
	movq	8(%rdx), %rcx
	leaq	.str(%rip), %rdx
	callq	fopen
	testq	%rax, %rax
	je	.LBB0_2
# %bb.4:
	leaq	176(%rsp), %rcx
	movl	$8, %edx
	movl	$2, %r8d
	movq	%rax, %r9
	movq	%rax, %r14
	callq	fread
	movq	%rax, %rcx
	movl	$4, %eax
	cmpq	$2, %rcx
	jne	.LBB0_3
# %bb.5:
	movq	184(%rsp), %r15
	movq	176(%rsp), %rbx
	movq	%r15, 152(%rsp)                 # 8-byte Spill
	imulq	%rbx, %r15
	leaq	(,%r15,8), %rcx
	callq	malloc
	testq	%rax, %rax
	je	.LBB0_6
# %bb.7:
	movl	$8, %edx
	movq	%rax, %rdi
	movq	%rax, %rcx
	movq	%r15, %r8
	movq	%r14, %r9
	callq	fread
	movq	%rax, %rcx
	movl	$6, %eax
	cmpq	%r15, %rcx
	jne	.LBB0_3
# %bb.8:
	movq	%r14, %rcx
	callq	fclose
	movq	$0, 120(%rsp)
	leaq	.str.1(%rip), %rcx
	movq	%rbx, %rdx
	movq	152(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %r8
	callq	printf
	vmovsd	.LCPI0_0(%rip), %xmm7           # xmm7 = [9.9999999999999995E-8,0.0E+0]
	movq	__imp_GetCurrentProcess(%rip), %r12
	vcvtusi2sd	%rbx, %xmm5, %xmm6
	leaq	(,%rsi,8), %r15
	leaq	56(%rdi), %rax
	leaq	112(%rsp), %rsi
	leaq	144(%rsp), %r13
	xorl	%r14d, %r14d
	movq	%rax, 168(%rsp)                 # 8-byte Spill
	jmp	.LBB0_9
	.p2align	4
.LBB0_10:                               #   in Loop: Header=BB0_9 Depth=1
	movq	$0, 104(%rsp)                   # 8-byte Folded Spill
	movl	$0, 84(%rsp)                    # 4-byte Folded Spill
	movq	$0, 88(%rsp)                    # 8-byte Folded Spill
.LBB0_67:                               #   in Loop: Header=BB0_9 Depth=1
	movq	__imp_GetCurrentProcess(%rip), %r12
	vdivsd	%xmm1, %xmm0, %xmm9
	callq	*%r12
	movq	%rax, %rcx
	movq	__imp_GetProcessTimes(%rip), %rax
	leaq	112(%rsp), %r13
	leaq	136(%rsp), %r14
	leaq	128(%rsp), %r9
	movq	%r13, 32(%rsp)
	leaq	144(%rsp), %r13
	movq	%r14, %r8
	movq	%r13, %rdx
	callq	*%rax
	movl	116(%rsp), %eax
	movl	112(%rsp), %esi
	movq	%r13, %rcx
	shlq	$32, %rax
	addq	128(%rsp), %rax
	addq	%rax, %rsi
	movq	__imp_QueryPerformanceCounter(%rip), %rax
	callq	*%rax
	movq	__imp_QueryPerformanceFrequency(%rip), %rax
	movq	%r14, %rcx
	callq	*%rax
	vcvtusi2sd	%rsi, %xmm5, %xmm0
	movq	160(%rsp), %r14                 # 8-byte Reload
	leaq	.str.3(%rip), %rdx
	leaq	.str.4(%rip), %rax
	leaq	.str.6(%rip), %r8
	leaq	.str.2(%rip), %rcx
	leaq	112(%rsp), %rsi
	movl	%ebp, %r9d
	vmulsd	%xmm7, %xmm0, %xmm0
	testl	%r14d, %r14d
	cmoveq	%rax, %rdx
	cmpl	$2, %r14d
	leaq	.str.5(%rip), %rax
	vsubsd	%xmm8, %xmm0, %xmm0
	vcvtsi2sdq	136(%rsp), %xmm5, %xmm1
	vcvtsi2sdq	144(%rsp), %xmm5, %xmm2
	vcvtusi2sdq	104(%rsp), %xmm5, %xmm3 # 8-byte Folded Reload
	cmovaeq	%rax, %r8
	movq	88(%rsp), %rax                  # 8-byte Reload
	vmovsd	%xmm0, 40(%rsp)
	movl	%eax, 72(%rsp)
	movl	84(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 64(%rsp)
	movl	96(%rsp), %eax                  # 4-byte Reload
	vunpcklpd	%xmm6, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm6[0]
	vunpcklpd	%xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0]
	vdivpd	%xmm1, %xmm2, %xmm1
	movl	%eax, 32(%rsp)
	vsubsd	%xmm9, %xmm1, %xmm2
	vmovhpd	%xmm1, 56(%rsp)
	vmovsd	%xmm2, 48(%rsp)
	callq	printf
	incl	%r14d
	cmpl	$4, %r14d
	je	.LBB0_68
.LBB0_9:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_13 Depth 2
                                        #       Child Loop BB0_14 Depth 3
                                        #         Child Loop BB0_15 Depth 4
                                        #           Child Loop BB0_16 Depth 5
                                        #     Child Loop BB0_20 Depth 2
                                        #       Child Loop BB0_22 Depth 3
                                        #         Child Loop BB0_23 Depth 4
                                        #       Child Loop BB0_44 Depth 3
                                        #         Child Loop BB0_45 Depth 4
	movl	%r14d, %ebp
	andl	$1, %ebp
	movl	$20, %ecx
	movl	$200, %eax
	shll	$9, %ebp
	addl	$512, %ebp                      # imm = 0x200
	cmpl	$2, %r14d
	cmovael	%eax, %ecx
	movl	%ecx, 96(%rsp)                  # 4-byte Spill
	callq	*%r12
	leaq	136(%rsp), %r12
	leaq	128(%rsp), %r9
	movq	%rsi, 32(%rsp)
	movq	%rax, %rcx
	movq	%r13, %rdx
	movq	%r12, %r8
	callq	*__imp_GetProcessTimes(%rip)
	movl	116(%rsp), %eax
	movl	112(%rsp), %esi
	movq	%r13, %rcx
	shlq	$32, %rax
	addq	128(%rsp), %rax
	addq	%rax, %rsi
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%r12, %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	vcvtusi2sd	%rsi, %xmm5, %xmm0
	movq	%r14, 160(%rsp)                 # 8-byte Spill
	vmulsd	%xmm7, %xmm0, %xmm8
	vcvtsi2sdq	144(%rsp), %xmm5, %xmm0
	vcvtsi2sdq	136(%rsp), %xmm5, %xmm1
	testq	%rbx, %rbx
	je	.LBB0_10
# %bb.11:                               #   in Loop: Header=BB0_9 Depth=1
	cmpl	$1, %r14d
	jbe	.LBB0_12
# %bb.19:                               #   in Loop: Header=BB0_9 Depth=1
	movq	%rbp, %rax
	negq	%rax
	xorl	%ecx, %ecx
	movq	$0, 88(%rsp)                    # 8-byte Folded Spill
	movl	$0, 84(%rsp)                    # 4-byte Folded Spill
	movq	$0, 104(%rsp)                   # 8-byte Folded Spill
	jmp	.LBB0_20
	.p2align	4
.LBB0_42:                               #   in Loop: Header=BB0_20 Depth=2
	incl	%ecx
	movq	%r12, 104(%rsp)                 # 8-byte Spill
	movl	%r14d, 84(%rsp)                 # 4-byte Spill
	movq	%rsi, 88(%rsp)                  # 8-byte Spill
	cmpl	96(%rsp), %ecx                  # 4-byte Folded Reload
	je	.LBB0_67
.LBB0_20:                               #   Parent Loop BB0_9 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_22 Depth 3
                                        #         Child Loop BB0_23 Depth 4
                                        #       Child Loop BB0_44 Depth 3
                                        #         Child Loop BB0_45 Depth 4
	movq	88(%rsp), %rsi                  # 8-byte Reload
	movl	84(%rsp), %r14d                 # 4-byte Reload
	movq	104(%rsp), %r12                 # 8-byte Reload
	movq	%rdi, %rdx
	testl	%ecx, %ecx
	je	.LBB0_43
# %bb.21:                               #   in Loop: Header=BB0_20 Depth=2
	xorl	%r8d, %r8d
	jmp	.LBB0_22
.LBB0_34:                               #   in Loop: Header=BB0_22 Depth=3
	addq	$-3, %r9
	.p2align	4
.LBB0_40:                               #   in Loop: Header=BB0_22 Depth=3
	movl	%r9d, %r9d
.LBB0_41:                               #   in Loop: Header=BB0_22 Depth=3
	addq	%r9, 120(%rsp)
	incq	%r8
	addq	%r15, %rdx
	cmpq	%rbx, %r8
	je	.LBB0_42
.LBB0_22:                               #   Parent Loop BB0_9 Depth=1
                                        #     Parent Loop BB0_20 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_23 Depth 4
	movq	$-1, %r10
	movl	$4, %r9d
.LBB0_23:                               #   Parent Loop BB0_9 Depth=1
                                        #     Parent Loop BB0_20 Depth=2
                                        #       Parent Loop BB0_22 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	-32(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_34
# %bb.24:                               #   in Loop: Header=BB0_23 Depth=4
	movq	-24(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_35
# %bb.25:                               #   in Loop: Header=BB0_23 Depth=4
	movq	-16(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_36
# %bb.26:                               #   in Loop: Header=BB0_23 Depth=4
	movq	-8(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_40
# %bb.27:                               #   in Loop: Header=BB0_23 Depth=4
	movq	(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_37
# %bb.28:                               #   in Loop: Header=BB0_23 Depth=4
	movq	8(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_38
# %bb.29:                               #   in Loop: Header=BB0_23 Depth=4
	movq	16(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_39
# %bb.30:                               #   in Loop: Header=BB0_23 Depth=4
	movq	24(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_33
# %bb.31:                               #   in Loop: Header=BB0_23 Depth=4
	leaq	8(%rax,%r9), %r11
	addq	$8, %r9
	cmpq	$4, %r11
	jne	.LBB0_23
# %bb.32:                               #   in Loop: Header=BB0_22 Depth=3
	movl	$999, %r9d                      # imm = 0x3E7
	jmp	.LBB0_41
.LBB0_35:                               #   in Loop: Header=BB0_22 Depth=3
	addq	$-2, %r9
	jmp	.LBB0_40
.LBB0_36:                               #   in Loop: Header=BB0_22 Depth=3
	decq	%r9
	jmp	.LBB0_40
.LBB0_37:                               #   in Loop: Header=BB0_22 Depth=3
	incq	%r9
	jmp	.LBB0_40
.LBB0_38:                               #   in Loop: Header=BB0_22 Depth=3
	addq	$2, %r9
	jmp	.LBB0_40
.LBB0_39:                               #   in Loop: Header=BB0_22 Depth=3
	addq	$3, %r9
	jmp	.LBB0_40
.LBB0_33:                               #   in Loop: Header=BB0_22 Depth=3
	addq	$4, %r9
	jmp	.LBB0_40
	.p2align	4
.LBB0_43:                               #   in Loop: Header=BB0_20 Depth=2
	xorl	%r8d, %r8d
	jmp	.LBB0_44
.LBB0_55:                               #   in Loop: Header=BB0_44 Depth=3
	addq	$-7, %r9
	.p2align	4
.LBB0_62:                               #   in Loop: Header=BB0_44 Depth=3
	incl	%r9d
.LBB0_63:                               #   in Loop: Header=BB0_44 Depth=3
	movl	%r9d, %r10d
	addq	%r10, 120(%rsp)
	addq	%r10, %r12
	cmpl	%r14d, %r9d
	cmoval	%r9d, %r14d
	xorl	%r10d, %r10d
	cmpl	$999, %r9d                      # imm = 0x3E7
	sete	%r10b
	incq	%r8
	addq	%r15, %rdx
	addl	%r10d, %esi
	cmpq	%rbx, %r8
	je	.LBB0_42
.LBB0_44:                               #   Parent Loop BB0_9 Depth=1
                                        #     Parent Loop BB0_20 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_45 Depth 4
	movq	$-1, %r10
	movl	$7, %r9d
.LBB0_45:                               #   Parent Loop BB0_9 Depth=1
                                        #     Parent Loop BB0_20 Depth=2
                                        #       Parent Loop BB0_44 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	-56(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_55
# %bb.46:                               #   in Loop: Header=BB0_45 Depth=4
	movq	-48(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_56
# %bb.47:                               #   in Loop: Header=BB0_45 Depth=4
	movq	-40(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_57
# %bb.48:                               #   in Loop: Header=BB0_45 Depth=4
	movq	-32(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_58
# %bb.49:                               #   in Loop: Header=BB0_45 Depth=4
	movq	-24(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_59
# %bb.50:                               #   in Loop: Header=BB0_45 Depth=4
	movq	-16(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_60
# %bb.51:                               #   in Loop: Header=BB0_45 Depth=4
	movq	-8(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_61
# %bb.52:                               #   in Loop: Header=BB0_45 Depth=4
	movq	(%rdx,%r9,8), %r11
	andnq	%r10, %r11, %r10
	je	.LBB0_62
# %bb.53:                               #   in Loop: Header=BB0_45 Depth=4
	leaq	8(%rax,%r9), %r11
	addq	$8, %r9
	cmpq	$7, %r11
	jne	.LBB0_45
# %bb.54:                               #   in Loop: Header=BB0_44 Depth=3
	movl	$999, %r9d                      # imm = 0x3E7
	jmp	.LBB0_63
.LBB0_56:                               #   in Loop: Header=BB0_44 Depth=3
	addq	$-6, %r9
	jmp	.LBB0_62
.LBB0_57:                               #   in Loop: Header=BB0_44 Depth=3
	addq	$-5, %r9
	jmp	.LBB0_62
.LBB0_58:                               #   in Loop: Header=BB0_44 Depth=3
	addq	$-4, %r9
	jmp	.LBB0_62
.LBB0_59:                               #   in Loop: Header=BB0_44 Depth=3
	addq	$-3, %r9
	jmp	.LBB0_62
.LBB0_60:                               #   in Loop: Header=BB0_44 Depth=3
	addq	$-2, %r9
	jmp	.LBB0_62
.LBB0_61:                               #   in Loop: Header=BB0_44 Depth=3
	decq	%r9
	jmp	.LBB0_62
	.p2align	4
.LBB0_12:                               #   in Loop: Header=BB0_9 Depth=1
	movq	$0, 88(%rsp)                    # 8-byte Folded Spill
	movl	$0, 100(%rsp)                   # 4-byte Folded Spill
	movl	$0, 84(%rsp)                    # 4-byte Folded Spill
	movq	$0, 104(%rsp)                   # 8-byte Folded Spill
	jmp	.LBB0_13
	.p2align	4
.LBB0_66:                               #   in Loop: Header=BB0_13 Depth=2
	movl	100(%rsp), %eax                 # 4-byte Reload
	incl	%eax
	movl	%eax, 100(%rsp)                 # 4-byte Spill
	cmpl	96(%rsp), %eax                  # 4-byte Folded Reload
	je	.LBB0_67
.LBB0_13:                               #   Parent Loop BB0_9 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_14 Depth 3
                                        #         Child Loop BB0_15 Depth 4
                                        #           Child Loop BB0_16 Depth 5
	movq	168(%rsp), %rcx                 # 8-byte Reload
	xorl	%edx, %edx
	jmp	.LBB0_14
	.p2align	4
.LBB0_65:                               #   in Loop: Header=BB0_14 Depth=3
	incq	%rdx
	addq	%r14, %rcx
	movq	%r15, %rbx
	movq	%r13, %rdi
	movq	%r14, %r15
	cmpq	%rbx, %rdx
	je	.LBB0_66
.LBB0_14:                               #   Parent Loop BB0_9 Depth=1
                                        #     Parent Loop BB0_13 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_15 Depth 4
                                        #           Child Loop BB0_16 Depth 5
	movq	%rdx, %r8
	imulq	152(%rsp), %r8                  # 8-byte Folded Reload
	movq	$-1, %r10
	movq	%r15, %r14
	movq	%rbx, %r15
	movq	%rdi, %r13
	leaq	(%rdi,%r8,8), %r9
	xorl	%r8d, %r8d
	.p2align	4
.LBB0_15:                               #   Parent Loop BB0_9 Depth=1
                                        #     Parent Loop BB0_13 Depth=2
                                        #       Parent Loop BB0_14 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB0_16 Depth 5
	xorl	%r11d, %r11d
	xorl	%esi, %esi
	xorl	%r12d, %r12d
	.p2align	4
.LBB0_16:                               #   Parent Loop BB0_9 Depth=1
                                        #     Parent Loop BB0_13 Depth=2
                                        #       Parent Loop BB0_14 Depth=3
                                        #         Parent Loop BB0_15 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	-56(%rcx,%r11,8), %rbx
	leal	1(%r11), %edi
	leal	6(%r11), %eax
	andq	%r10, %rbx
	popcntq	%rbx, %rbx
	cmpl	%ebx, %r12d
	cmoval	%r12d, %ebx
	movq	-48(%rcx,%r11,8), %r12
	cmovbl	%r11d, %esi
	andq	%r10, %r12
	popcntq	%r12, %r12
	cmpl	%r12d, %ebx
	cmovael	%esi, %edi
	movq	-40(%rcx,%r11,8), %rsi
	cmovbel	%r12d, %ebx
	leal	2(%r11), %r12d
	andq	%r10, %rsi
	popcntq	%rsi, %rsi
	cmpl	%esi, %ebx
	cmovbel	%esi, %ebx
	movq	-32(%rcx,%r11,8), %rsi
	cmovael	%edi, %r12d
	leal	3(%r11), %edi
	andq	%r10, %rsi
	popcntq	%rsi, %rsi
	cmpl	%esi, %ebx
	cmovbel	%esi, %ebx
	movq	-24(%rcx,%r11,8), %rsi
	cmovael	%r12d, %edi
	leal	4(%r11), %r12d
	andq	%r10, %rsi
	popcntq	%rsi, %rsi
	cmpl	%esi, %ebx
	cmovbel	%esi, %ebx
	movq	-16(%rcx,%r11,8), %rsi
	cmovael	%edi, %r12d
	leal	5(%r11), %edi
	andq	%r10, %rsi
	popcntq	%rsi, %rsi
	cmpl	%esi, %ebx
	cmovbel	%esi, %ebx
	movq	-8(%rcx,%r11,8), %rsi
	cmovael	%r12d, %edi
	andq	%r10, %rsi
	popcntq	%rsi, %rsi
	cmpl	%esi, %ebx
	cmovbel	%esi, %ebx
	movq	(%rcx,%r11,8), %rsi
	cmovael	%edi, %eax
	movl	%ebx, %r12d
	andq	%r10, %rsi
	popcntq	%rsi, %rdi
	leal	7(%r11), %esi
	cmpl	%edi, %ebx
	cmovbel	%edi, %r12d
	cmovael	%eax, %esi
	addq	$8, %r11
	cmpq	%rbp, %r11
	jne	.LBB0_16
# %bb.17:                               #   in Loop: Header=BB0_15 Depth=4
	testl	%r12d, %r12d
	je	.LBB0_18
# %bb.69:                               #   in Loop: Header=BB0_15 Depth=4
	movl	%esi, %eax
	movq	(%r9,%rax,8), %rax
	incl	%r8d
	andnq	%r10, %rax, %r10
	jne	.LBB0_15
	jmp	.LBB0_70
	.p2align	4
.LBB0_18:                               #   in Loop: Header=BB0_14 Depth=3
	movl	$999, %r8d                      # imm = 0x3E7
.LBB0_70:                               #   in Loop: Header=BB0_14 Depth=3
	movl	%r8d, %r8d
	addq	%r8, 120(%rsp)
	cmpl	$0, 100(%rsp)                   # 4-byte Folded Reload
	jne	.LBB0_65
# %bb.64:                               #   in Loop: Header=BB0_14 Depth=3
	movl	84(%rsp), %eax                  # 4-byte Reload
	addq	%r8, 104(%rsp)                  # 8-byte Folded Spill
	cmpl	%eax, %r8d
	cmoval	%r8d, %eax
	movl	%eax, 84(%rsp)                  # 4-byte Spill
	xorl	%eax, %eax
	cmpq	$999, %r8                       # imm = 0x3E7
	movq	88(%rsp), %r8                   # 8-byte Reload
	sete	%al
	addl	%eax, %r8d
	movq	%r8, 88(%rsp)                   # 8-byte Spill
	jmp	.LBB0_65
.LBB0_2:
	movl	$3, %eax
	jmp	.LBB0_3
.LBB0_6:
	movl	$5, %eax
	jmp	.LBB0_3
.LBB0_68:
	movq	120(%rsp), %rdx
	leaq	.str.7(%rip), %rcx
	callq	printf
	movq	%rdi, %rcx
	callq	free
	xorl	%eax, %eax
.LBB0_3:
	vmovaps	192(%rsp), %xmm6                # 16-byte Reload
	vmovaps	208(%rsp), %xmm7                # 16-byte Reload
	vmovaps	224(%rsp), %xmm8                # 16-byte Reload
	vmovaps	240(%rsp), %xmm9                # 16-byte Reload
	.seh_startepilogue
	addq	$264, %rsp                      # imm = 0x108
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
	.seh_endproc
                                        # -- End function
	.def	main;
	.scl	2;
	.type	32;
	.endef
	.section	.rdata,"dr"
	.p2align	3, 0x0                          # -- Begin function main
.LCPI1_0:
	.quad	0x3e7ad7f29abcaf48              # double 9.9999999999999995E-8
.LCPI1_1:
	.long	63                              # 0x3f
	.zero	4
.LCPI1_2:
	.quad	288230376151711743              # 0x3ffffffffffffff
.LCPI1_3:
	.long	64                              # 0x40
	.zero	4
.LCPI1_4:
	.quad	63                              # 0x3f
	.section	.text$main,"xr",one_only,main,unique,1
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
	movl	$4776, %eax                     # imm = 0x12A8
	callq	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc 4776
	leaq	128(%rsp), %rbp
	.seh_setframe %rbp, 128
	vmovapd	%xmm9, 4624(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm9, 4752
	vmovapd	%xmm8, 4608(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm8, 4736
	vmovapd	%xmm7, 4592(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm7, 4720
	vmovapd	%xmm6, 4576(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm6, 4704
	.seh_endprologue
	movq	%rdx, %rsi
	movl	%ecx, %edi
	movl	$2, %r14d
	callq	__main
	cmpl	$2, %edi
	jne	.LBB1_124
# %bb.1:
	movq	8(%rsi), %rcx
	leaq	.str(%rip), %rdx
	callq	fopen
	testq	%rax, %rax
	je	.LBB1_121
# %bb.2:
	leaq	4336(%rbp), %rcx
	movl	$8, %edx
	movl	$4, %r8d
	movq	%rax, %r9
	movq	%rax, %rbx
	callq	fread
	movl	$4, %r14d
	cmpq	$4, %rax
	jne	.LBB1_124
# %bb.3:
	movq	4352(%rbp), %rcx
	movq	4360(%rbp), %rdx
	movq	4336(%rbp), %r13
	addq	%rcx, %rdx
	movq	%r13, 4528(%rbp)                # 8-byte Spill
	movq	%rcx, 4464(%rbp)                # 8-byte Spill
	imulq	%rdx, %r13
	movq	%rdx, 4496(%rbp)                # 8-byte Spill
	leaq	(,%r13,8), %rcx
	callq	malloc
	testq	%rax, %rax
	je	.LBB1_122
# %bb.4:
	movl	$8, %edx
	movq	%rax, %rcx
	movq	%r13, %r8
	movq	%rbx, %r9
	movq	%rax, %rsi
	callq	fread
	movl	$6, %r14d
	cmpq	%r13, %rax
	jne	.LBB1_124
# %bb.5:
	movq	%rbx, %rcx
	callq	fclose
	movq	$0, 4472(%rbp)
	movabsq	$-3689348814741910323, %rax     # imm = 0xCCCCCCCCCCCCCCCD
	leaq	.str.8(%rip), %rcx
	movq	4528(%rbp), %rdx                # 8-byte Reload
	mulxq	%rax, %rdx, %rdx
	movq	4344(%rbp), %rax
	shrq	$2, %rdx
	imulq	%rax, %rdx
	movq	%rax, 4520(%rbp)                # 8-byte Spill
	shlq	$2, %rdx
	callq	printf
	vmovsd	.LCPI1_0(%rip), %xmm6           # xmm6 = [9.9999999999999995E-8,0.0E+0]
	movq	4496(%rbp), %rax                # 8-byte Reload
	leaq	24(%rsi), %rcx
	movb	$58, %r12b
	movq	%rsi, 4544(%rbp)                # 8-byte Spill
	movq	$0, 4536(%rbp)                  # 8-byte Folded Spill
	movq	%rcx, 4392(%rbp)                # 8-byte Spill
	leaq	(,%rax,8), %rax
	movq	%rax, 4456(%rbp)                # 8-byte Spill
	jmp	.LBB1_7
	.p2align	4
.LBB1_6:                                #   in Loop: Header=BB1_7 Depth=1
	leaq	.str.13(%rip), %rcx
	callq	printf
	movq	4536(%rbp), %rcx                # 8-byte Reload
	incq	%rcx
	movq	%rcx, 4536(%rbp)                # 8-byte Spill
	cmpq	$5, %rcx
	je	.LBB1_123
.LBB1_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_72 Depth 2
                                        #       Child Loop BB1_74 Depth 3
                                        #         Child Loop BB1_78 Depth 4
                                        #           Child Loop BB1_79 Depth 5
                                        #           Child Loop BB1_108 Depth 5
                                        #           Child Loop BB1_83 Depth 5
                                        #             Child Loop BB1_86 Depth 6
                                        #             Child Loop BB1_88 Depth 6
                                        #             Child Loop BB1_97 Depth 6
                                        #             Child Loop BB1_103 Depth 6
                                        #     Child Loop BB1_13 Depth 2
                                        #       Child Loop BB1_16 Depth 3
                                        #         Child Loop BB1_20 Depth 4
                                        #           Child Loop BB1_21 Depth 5
                                        #       Child Loop BB1_41 Depth 3
                                        #         Child Loop BB1_45 Depth 4
                                        #           Child Loop BB1_46 Depth 5
                                        #     Child Loop BB1_119 Depth 2
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%zmm0, 4256(%rbp)
	vmovupd	%zmm0, 4192(%rbp)
	vmovupd	%zmm0, 4128(%rbp)
	vmovupd	%zmm0, 4064(%rbp)
	movl	$0, 4320(%rbp)
	vzeroupper
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	4504(%rbp), %rcx
	leaq	-32(%rbp), %rdi
	leaq	4432(%rbp), %rbx
	leaq	4440(%rbp), %r9
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rdi, %rdx
	movq	%rbx, %r8
	callq	*__imp_GetProcessTimes(%rip)
	movl	4508(%rbp), %eax
	movl	4504(%rbp), %esi
	movq	%rdi, %rcx
	shlq	$32, %rax
	addq	4440(%rbp), %rax
	addq	%rax, %rsi
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%rbx, %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	vcvtusi2sd	%rsi, %xmm5, %xmm0
	cmpq	$0, 4528(%rbp)                  # 8-byte Folded Reload
	vxorpd	%xmm2, %xmm2, %xmm2
	vmulsd	%xmm6, %xmm0, %xmm7
	vcvtsi2sdq	-32(%rbp), %xmm5, %xmm0
	vcvtsi2sdq	4432(%rbp), %xmm5, %xmm1
	je	.LBB1_69
# %bb.8:                                #   in Loop: Header=BB1_7 Depth=1
	cmpq	$0, 4520(%rbp)                  # 8-byte Folded Reload
	je	.LBB1_69
# %bb.9:                                #   in Loop: Header=BB1_7 Depth=1
	cmpq	$4, 4536(%rbp)                  # 8-byte Folded Reload
	jne	.LBB1_70
# %bb.10:                               #   in Loop: Header=BB1_7 Depth=1
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	xorl	%r13d, %r13d
	jmp	.LBB1_13
	.p2align	4
.LBB1_11:                               #   in Loop: Header=BB1_13 Depth=2
	movq	4488(%rbp), %r8                 # 8-byte Reload
.LBB1_12:                               #   in Loop: Header=BB1_13 Depth=2
	movl	4572(%rbp), %edx                # 4-byte Reload
	incl	%edx
	cmpl	$50, %edx
	je	.LBB1_115
.LBB1_13:                               #   Parent Loop BB1_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_16 Depth 3
                                        #         Child Loop BB1_20 Depth 4
                                        #           Child Loop BB1_21 Depth 5
                                        #       Child Loop BB1_41 Depth 3
                                        #         Child Loop BB1_45 Depth 4
                                        #           Child Loop BB1_46 Depth 5
	movl	%edx, 4572(%rbp)                # 4-byte Spill
	testl	%edx, %edx
	je	.LBB1_38
# %bb.14:                               #   in Loop: Header=BB1_13 Depth=2
	movq	4392(%rbp), %rdx                # 8-byte Reload
	movq	%r8, 4488(%rbp)                 # 8-byte Spill
	xorl	%r8d, %r8d
	jmp	.LBB1_16
	.p2align	4
.LBB1_15:                               #   in Loop: Header=BB1_16 Depth=3
	addq	4456(%rbp), %rdx                # 8-byte Folded Reload
	incq	%r8
	cmpq	4528(%rbp), %r8                 # 8-byte Folded Reload
	je	.LBB1_11
.LBB1_16:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_13 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_20 Depth 4
                                        #           Child Loop BB1_21 Depth 5
	movabsq	$-3689348814741910323, %r10     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%r8, %r9
	imulq	%r10, %r9
	movabsq	$3689348814741910324, %r10      # imm = 0x3333333333333334
	cmpq	%r10, %r9
	jb	.LBB1_15
# %bb.17:                               #   in Loop: Header=BB1_16 Depth=3
	movq	%r8, %r9
	imulq	4496(%rbp), %r9                 # 8-byte Folded Reload
	movq	4544(%rbp), %r10                # 8-byte Reload
	leaq	(%r10,%r9,8), %r9
	movq	4464(%rbp), %r10                # 8-byte Reload
	leaq	(%r9,%r10,8), %r9
	xorl	%r10d, %r10d
	jmp	.LBB1_20
.LBB1_18:                               #   in Loop: Header=BB1_20 Depth=4
	movl	$999, %r11d                     # imm = 0x3E7
	.p2align	4
.LBB1_19:                               #   in Loop: Header=BB1_20 Depth=4
	movl	%r11d, %r11d
	addq	%r11, 4472(%rbp)
	incq	%r10
	cmpq	4520(%rbp), %r10                # 8-byte Folded Reload
	je	.LBB1_15
.LBB1_20:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_13 Depth=2
                                        #       Parent Loop BB1_16 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_21 Depth 5
	movq	$-1, %rdi
	xorl	%r11d, %r11d
	xorl	%esi, %esi
	.p2align	4
.LBB1_21:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_13 Depth=2
                                        #       Parent Loop BB1_16 Depth=3
                                        #         Parent Loop BB1_20 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	-24(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_23
# %bb.22:                               #   in Loop: Header=BB1_21 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_24
	.p2align	4
.LBB1_23:                               #   in Loop: Header=BB1_21 Depth=5
	xorl	%r15d, %r15d
.LBB1_24:                               #   in Loop: Header=BB1_21 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_19
# %bb.25:                               #   in Loop: Header=BB1_21 Depth=5
	movq	-16(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_27
# %bb.26:                               #   in Loop: Header=BB1_21 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_28
	.p2align	4
.LBB1_27:                               #   in Loop: Header=BB1_21 Depth=5
	xorl	%r15d, %r15d
.LBB1_28:                               #   in Loop: Header=BB1_21 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_19
# %bb.29:                               #   in Loop: Header=BB1_21 Depth=5
	movq	-8(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_31
# %bb.30:                               #   in Loop: Header=BB1_21 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_32
	.p2align	4
.LBB1_31:                               #   in Loop: Header=BB1_21 Depth=5
	xorl	%r15d, %r15d
.LBB1_32:                               #   in Loop: Header=BB1_21 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_19
# %bb.33:                               #   in Loop: Header=BB1_21 Depth=5
	movq	(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_35
# %bb.34:                               #   in Loop: Header=BB1_21 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_36
	.p2align	4
.LBB1_35:                               #   in Loop: Header=BB1_21 Depth=5
	xorl	%r15d, %r15d
.LBB1_36:                               #   in Loop: Header=BB1_21 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_19
# %bb.37:                               #   in Loop: Header=BB1_21 Depth=5
	addq	$4, %rsi
	cmpq	$512, %rsi                      # imm = 0x200
	jne	.LBB1_21
	jmp	.LBB1_18
	.p2align	4
.LBB1_38:                               #   in Loop: Header=BB1_13 Depth=2
	movq	4544(%rbp), %rdx                # 8-byte Reload
	xorl	%r11d, %r11d
	jmp	.LBB1_41
	.p2align	4
.LBB1_39:                               #   in Loop: Header=BB1_41 Depth=3
	addq	4520(%rbp), %rcx                # 8-byte Folded Reload
	movq	4480(%rbp), %r11                # 8-byte Reload
.LBB1_40:                               #   in Loop: Header=BB1_41 Depth=3
	addq	4456(%rbp), %rdx                # 8-byte Folded Reload
	incq	%r11
	cmpq	4528(%rbp), %r11                # 8-byte Folded Reload
	je	.LBB1_12
.LBB1_41:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_13 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_45 Depth 4
                                        #           Child Loop BB1_46 Depth 5
	movabsq	$-3689348814741910323, %r10     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%r11, %r9
	imulq	%r10, %r9
	movabsq	$3689348814741910324, %r10      # imm = 0x3333333333333334
	cmpq	%r10, %r9
	jb	.LBB1_40
# %bb.42:                               #   in Loop: Header=BB1_41 Depth=3
	movq	%r11, %r9
	imulq	4496(%rbp), %r9                 # 8-byte Folded Reload
	movq	4544(%rbp), %r10                # 8-byte Reload
	movq	%r11, 4480(%rbp)                # 8-byte Spill
	leaq	(%r10,%r9,8), %r9
	movq	4464(%rbp), %r10                # 8-byte Reload
	leaq	(%r9,%r10,8), %r9
	xorl	%r10d, %r10d
	jmp	.LBB1_45
	.p2align	4
.LBB1_43:                               #   in Loop: Header=BB1_45 Depth=4
	incl	4064(%rbp,%rdi,4)
.LBB1_44:                               #   in Loop: Header=BB1_45 Depth=4
	movl	%r11d, %r11d
	addq	%rdi, %r8
	addq	%r11, %rax
	incq	%r10
	cmpq	4520(%rbp), %r10                # 8-byte Folded Reload
	je	.LBB1_39
.LBB1_45:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_13 Depth=2
                                        #       Parent Loop BB1_41 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_46 Depth 5
	movq	$-1, %rdi
	movl	$4, %r11d
	xorl	%esi, %esi
	.p2align	4
.LBB1_46:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_13 Depth=2
                                        #       Parent Loop BB1_41 Depth=3
                                        #         Parent Loop BB1_45 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	-32(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_48
# %bb.47:                               #   in Loop: Header=BB1_46 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_49
	.p2align	4
.LBB1_48:                               #   in Loop: Header=BB1_46 Depth=5
	xorl	%r15d, %r15d
.LBB1_49:                               #   in Loop: Header=BB1_46 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_64
# %bb.50:                               #   in Loop: Header=BB1_46 Depth=5
	movq	-24(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_52
# %bb.51:                               #   in Loop: Header=BB1_46 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_53
	.p2align	4
.LBB1_52:                               #   in Loop: Header=BB1_46 Depth=5
	xorl	%r15d, %r15d
.LBB1_53:                               #   in Loop: Header=BB1_46 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_65
# %bb.54:                               #   in Loop: Header=BB1_46 Depth=5
	movq	-16(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_56
# %bb.55:                               #   in Loop: Header=BB1_46 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_57
	.p2align	4
.LBB1_56:                               #   in Loop: Header=BB1_46 Depth=5
	xorl	%r15d, %r15d
.LBB1_57:                               #   in Loop: Header=BB1_46 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_68
# %bb.58:                               #   in Loop: Header=BB1_46 Depth=5
	movq	-8(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_60
# %bb.59:                               #   in Loop: Header=BB1_46 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_61
	.p2align	4
.LBB1_60:                               #   in Loop: Header=BB1_46 Depth=5
	xorl	%r15d, %r15d
.LBB1_61:                               #   in Loop: Header=BB1_46 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_66
# %bb.62:                               #   in Loop: Header=BB1_46 Depth=5
	addq	$4, %r11
	cmpq	$516, %r11                      # imm = 0x204
	jne	.LBB1_46
# %bb.63:                               #   in Loop: Header=BB1_45 Depth=4
	movl	$512, %r11d                     # imm = 0x200
	movl	$999, %esi                      # imm = 0x3E7
	movl	%esi, %edi
	addq	%rdi, 4472(%rbp)
	cmpl	$65, %esi
	jb	.LBB1_43
	jmp	.LBB1_67
	.p2align	4
.LBB1_64:                               #   in Loop: Header=BB1_45 Depth=4
	addq	$-3, %r11
	movl	%esi, %edi
	addq	%rdi, 4472(%rbp)
	cmpl	$65, %esi
	jae	.LBB1_67
	jmp	.LBB1_43
	.p2align	4
.LBB1_65:                               #   in Loop: Header=BB1_45 Depth=4
	addq	$-2, %r11
.LBB1_66:                               #   in Loop: Header=BB1_45 Depth=4
	movl	%esi, %edi
	addq	%rdi, 4472(%rbp)
	cmpl	$65, %esi
	jb	.LBB1_43
.LBB1_67:                               #   in Loop: Header=BB1_45 Depth=4
	incl	%r13d
	jmp	.LBB1_44
.LBB1_68:                               #   in Loop: Header=BB1_45 Depth=4
	decq	%r11
	movl	%esi, %edi
	addq	%rdi, 4472(%rbp)
	cmpl	$65, %esi
	jb	.LBB1_43
	jmp	.LBB1_67
	.p2align	4
.LBB1_69:                               #   in Loop: Header=BB1_7 Depth=1
	xorl	%r13d, %r13d
	xorl	%r15d, %r15d
	xorl	%r14d, %r14d
	movq	$0, 4560(%rbp)                  # 8-byte Folded Spill
	vxorpd	%xmm3, %xmm3, %xmm3
	jmp	.LBB1_117
.LBB1_70:                               #   in Loop: Header=BB1_7 Depth=1
	vpbroadcastd	.LCPI1_1(%rip), %ymm19  # ymm19 = [63,63,63,63,63,63,63,63]
	vpbroadcastq	.LCPI1_2(%rip), %zmm20  # zmm20 = [288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743]
	vpbroadcastd	.LCPI1_3(%rip), %ymm21  # ymm21 = [64,64,64,64,64,64,64,64]
	vpbroadcastq	.LCPI1_4(%rip), %zmm22  # zmm22 = [63,63,63,63,63,63,63,63]
	xorl	%r8d, %r8d
	movl	$0, 4556(%rbp)                  # 4-byte Folded Spill
	movq	$0, 4424(%rbp)                  # 8-byte Folded Spill
	movq	$0, 4416(%rbp)                  # 8-byte Folded Spill
	movq	$0, 4488(%rbp)                  # 8-byte Folded Spill
	movq	$0, 4448(%rbp)                  # 8-byte Folded Spill
	jmp	.LBB1_72
	.p2align	4
.LBB1_71:                               #   in Loop: Header=BB1_72 Depth=2
	movl	4556(%rbp), %eax                # 4-byte Reload
	incl	%eax
	movl	%eax, 4556(%rbp)                # 4-byte Spill
	cmpl	$50, %eax
	je	.LBB1_116
.LBB1_72:                               #   Parent Loop BB1_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_74 Depth 3
                                        #         Child Loop BB1_78 Depth 4
                                        #           Child Loop BB1_79 Depth 5
                                        #           Child Loop BB1_108 Depth 5
                                        #           Child Loop BB1_83 Depth 5
                                        #             Child Loop BB1_86 Depth 6
                                        #             Child Loop BB1_88 Depth 6
                                        #             Child Loop BB1_97 Depth 6
                                        #             Child Loop BB1_103 Depth 6
	movq	4544(%rbp), %rdx                # 8-byte Reload
	xorl	%r9d, %r9d
	jmp	.LBB1_74
	.p2align	4
.LBB1_73:                               #   in Loop: Header=BB1_74 Depth=3
	movq	4384(%rbp), %r9                 # 8-byte Reload
	addq	4456(%rbp), %rdx                # 8-byte Folded Reload
	incq	%r9
	cmpq	4528(%rbp), %r9                 # 8-byte Folded Reload
	je	.LBB1_71
.LBB1_74:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_72 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_78 Depth 4
                                        #           Child Loop BB1_79 Depth 5
                                        #           Child Loop BB1_108 Depth 5
                                        #           Child Loop BB1_83 Depth 5
                                        #             Child Loop BB1_86 Depth 6
                                        #             Child Loop BB1_88 Depth 6
                                        #             Child Loop BB1_97 Depth 6
                                        #             Child Loop BB1_103 Depth 6
	movabsq	$-3689348814741910323, %rcx     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%r9, %rax
	movq	%r9, 4384(%rbp)                 # 8-byte Spill
	imulq	%rcx, %rax
	movabsq	$3689348814741910324, %rcx      # imm = 0x3333333333333334
	cmpq	%rcx, %rax
	jb	.LBB1_73
# %bb.75:                               #   in Loop: Header=BB1_74 Depth=3
	movq	%r9, %rax
	imulq	4496(%rbp), %rax                # 8-byte Folded Reload
	movq	4544(%rbp), %rcx                # 8-byte Reload
	xorl	%esi, %esi
	leaq	(%rcx,%rax,8), %rax
	movq	4464(%rbp), %rcx                # 8-byte Reload
	leaq	(%rax,%rcx,8), %r9
	movq	4536(%rbp), %rax                # 8-byte Reload
	leaq	__const.main.pools(%rip), %rcx
	movl	(%rcx,%rax,4), %r11d
	movl	%r11d, %edi
	andl	$-8, %edi
	movq	%r11, 4400(%rbp)                # 8-byte Spill
	movq	%rdi, 4408(%rbp)                # 8-byte Spill
	jmp	.LBB1_78
	.p2align	4
.LBB1_76:                               #   in Loop: Header=BB1_78 Depth=4
	movq	4560(%rbp), %r8                 # 8-byte Reload
	movq	4400(%rbp), %r11                # 8-byte Reload
	movq	4408(%rbp), %rdi                # 8-byte Reload
.LBB1_77:                               #   in Loop: Header=BB1_78 Depth=4
	incq	%rsi
	cmpq	4520(%rbp), %rsi                # 8-byte Folded Reload
	je	.LBB1_73
.LBB1_78:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_72 Depth=2
                                        #       Parent Loop BB1_74 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_79 Depth 5
                                        #           Child Loop BB1_108 Depth 5
                                        #           Child Loop BB1_83 Depth 5
                                        #             Child Loop BB1_86 Depth 6
                                        #             Child Loop BB1_88 Depth 6
                                        #             Child Loop BB1_97 Depth 6
                                        #             Child Loop BB1_103 Depth 6
	vpbroadcastq	%rsi, %zmm3
	xorl	%eax, %eax
	.p2align	4
.LBB1_79:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_72 Depth=2
                                        #       Parent Loop BB1_74 Depth=3
                                        #         Parent Loop BB1_78 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	vmovdqu64	(%rdx,%rax,8), %zmm4
	kxnorb	%k0, %k0, %k1
	vpxord	%xmm17, %xmm17, %xmm17
	vpxord	%xmm18, %xmm18, %xmm18
	vpmovqd	%zmm4, %ymm5
	vpsrlq	$6, %zmm4, %zmm16
	vpandq	%zmm22, %zmm4, %zmm4
	vpaddq	%zmm3, %zmm16, %zmm16
	vpandq	%zmm20, %zmm16, %zmm16
	vpgatherqq	(%r9,%zmm16,8), %zmm17 {%k1}
	vpandd	%ymm19, %ymm5, %ymm5
	vptestmd	%ymm5, %ymm5, %k1
	vpsubd	%ymm5, %ymm21, %ymm5
	vpmovzxdq	%ymm5, %zmm5            # zmm5 = ymm5[0],zero,ymm5[1],zero,ymm5[2],zero,ymm5[3],zero,ymm5[4],zero,ymm5[5],zero,ymm5[6],zero,ymm5[7],zero
	vpsrlvq	%zmm4, %zmm17, %zmm4
	kmovq	%k1, %k2
	vpgatherqq	8(%r9,%zmm16,8), %zmm18 {%k2}
	vpsllvq	%zmm5, %zmm18, %zmm5
	vporq	%zmm5, %zmm4, %zmm4 {%k1}
	vmovdqu64	%zmm4, -32(%rbp,%rax,8)
	addq	$8, %rax
	cmpq	%rax, %rdi
	jne	.LBB1_79
# %bb.80:                               #   in Loop: Header=BB1_78 Depth=4
	movq	%r8, 4560(%rbp)                 # 8-byte Spill
	cmpl	%r11d, %edi
	jne	.LBB1_105
.LBB1_81:                               #   in Loop: Header=BB1_78 Depth=4
	movq	$-1, %rdi
	movq	%r11, %r10
	xorl	%r13d, %r13d
                                        # kill: def $r10d killed $r10d killed $r10 def $r10
	movl	$0, 4516(%rbp)                  # 4-byte Folded Spill
	movl	$0, 4512(%rbp)                  # 4-byte Folded Spill
	movl	$0, 4480(%rbp)                  # 4-byte Folded Spill
	movl	$0, 4572(%rbp)                  # 4-byte Folded Spill
	jmp	.LBB1_83
	.p2align	4
.LBB1_82:                               #   in Loop: Header=BB1_83 Depth=5
	movl	4480(%rbp), %ecx                # 4-byte Reload
	movl	%r14d, %eax
	movq	-32(%rbp,%rax,8), %rax
	incl	%r13d
	addl	4572(%rbp), %ecx                # 4-byte Folded Reload
	andnq	%rdi, %rax, %rdi
	movl	%ecx, 4480(%rbp)                # 4-byte Spill
	movl	%ecx, 4512(%rbp)                # 4-byte Spill
	testq	%rdi, %rdi
	je	.LBB1_111
.LBB1_83:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_72 Depth=2
                                        #       Parent Loop BB1_74 Depth=3
                                        #         Parent Loop BB1_78 Depth=4
                                        # =>        This Loop Header: Depth=5
                                        #             Child Loop BB1_86 Depth 6
                                        #             Child Loop BB1_88 Depth 6
                                        #             Child Loop BB1_97 Depth 6
                                        #             Child Loop BB1_103 Depth 6
	movl	%r10d, %eax
	movl	%eax, %r15d
	andl	$7, %r15d
	leal	-1(%r10), %r8d
	cmpl	$7, %r8d
	jae	.LBB1_85
# %bb.84:                               #   in Loop: Header=BB1_83 Depth=5
	xorl	%ebx, %ebx
	xorl	%r14d, %r14d
	xorl	%r11d, %r11d
	jmp	.LBB1_88
	.p2align	4
.LBB1_85:                               #   in Loop: Header=BB1_83 Depth=5
	movq	%r13, 4376(%rbp)                # 8-byte Spill
	movl	%eax, %r13d
	andl	$-8, %r13d
	xorl	%ebx, %ebx
	xorl	%r14d, %r14d
	xorl	%r11d, %r11d
	.p2align	4
.LBB1_86:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_72 Depth=2
                                        #       Parent Loop BB1_74 Depth=3
                                        #         Parent Loop BB1_78 Depth=4
                                        #           Parent Loop BB1_83 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	movq	-32(%rbp,%rbx,8), %r8
	leal	1(%rbx), %ecx
	leal	6(%rbx), %r12d
	andq	%rdi, %r8
	popcntq	%r8, %r8
	cmpl	%r8d, %r11d
	cmoval	%r11d, %r8d
	movq	-24(%rbp,%rbx,8), %r11
	cmovbl	%ebx, %r14d
	andq	%rdi, %r11
	popcntq	%r11, %r11
	cmpl	%r11d, %r8d
	cmovbel	%r11d, %r8d
	movq	-16(%rbp,%rbx,8), %r11
	cmovael	%r14d, %ecx
	leal	2(%rbx), %r14d
	andq	%rdi, %r11
	popcntq	%r11, %r11
	cmpl	%r11d, %r8d
	cmovael	%ecx, %r14d
	movq	-8(%rbp,%rbx,8), %rcx
	cmovbel	%r11d, %r8d
	leal	3(%rbx), %r11d
	andq	%rdi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r8d
	cmovbel	%ecx, %r8d
	movq	(%rbp,%rbx,8), %rcx
	cmovael	%r14d, %r11d
	leal	4(%rbx), %r14d
	andq	%rdi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r8d
	cmovbel	%ecx, %r8d
	movq	8(%rbp,%rbx,8), %rcx
	cmovael	%r11d, %r14d
	leal	5(%rbx), %r11d
	andq	%rdi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r8d
	cmovbel	%ecx, %r8d
	movq	16(%rbp,%rbx,8), %rcx
	cmovael	%r14d, %r11d
	leal	7(%rbx), %r14d
	andq	%rdi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r8d
	cmovael	%r11d, %r12d
	movq	24(%rbp,%rbx,8), %r11
	cmovbel	%ecx, %r8d
	andq	%rdi, %r11
	popcntq	%r11, %rcx
	movl	%r8d, %r11d
	cmpl	%ecx, %r8d
	cmovbel	%ecx, %r11d
	cmovael	%r12d, %r14d
	addq	$8, %rbx
	cmpq	%r13, %rbx
	jne	.LBB1_86
# %bb.87:                               #   in Loop: Header=BB1_83 Depth=5
	movq	4376(%rbp), %r13                # 8-byte Reload
	movb	$58, %r12b
	testq	%r15, %r15
	je	.LBB1_89
	.p2align	4
.LBB1_88:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_72 Depth=2
                                        #       Parent Loop BB1_74 Depth=3
                                        #         Parent Loop BB1_78 Depth=4
                                        #           Parent Loop BB1_83 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	movq	-32(%rbp,%rbx,8), %r8
	movl	%r11d, %ecx
	andq	%rdi, %r8
	popcntq	%r8, %r11
	cmpl	%r11d, %ecx
	cmoval	%ecx, %r11d
	cmovbl	%ebx, %r14d
	incq	%rbx
	decq	%r15
	jne	.LBB1_88
.LBB1_89:                               #   in Loop: Header=BB1_83 Depth=5
	testl	%r11d, %r11d
	jne	.LBB1_82
# %bb.90:                               #   in Loop: Header=BB1_83 Depth=5
	cmpl	$512, %r10d                     # imm = 0x200
	je	.LBB1_110
# %bb.91:                               #   in Loop: Header=BB1_83 Depth=5
	movl	$1, 4516(%rbp)                  # 4-byte Folded Spill
	jae	.LBB1_99
# %bb.92:                               #   in Loop: Header=BB1_83 Depth=5
	leal	1(%r10), %ecx
	movl	$513, %r8d                      # imm = 0x201
	subq	%rcx, %r8
	cmpq	$8, %r8
	jb	.LBB1_93
# %bb.94:                               #   in Loop: Header=BB1_83 Depth=5
	movl	$512, %r11d                     # imm = 0x200
	subq	%rcx, %r11
	movl	$-2, %ecx
	subl	%r10d, %ecx
	cmpl	%r11d, %ecx
	setb	%cl
	shrq	$32, %r11
	setne	%r10b
	orb	%cl, %r10b
	je	.LBB1_96
.LBB1_93:                               #   in Loop: Header=BB1_83 Depth=5
	movq	%rax, %rcx
.LBB1_100:                              #   in Loop: Header=BB1_83 Depth=5
	incq	%rcx
	jmp	.LBB1_103
	.p2align	4
.LBB1_101:                              #   in Loop: Header=BB1_103 Depth=6
	xorl	%r10d, %r10d
.LBB1_102:                              #   in Loop: Header=BB1_103 Depth=6
	shrxq	%rax, (%r9,%r8,8), %rax
	orq	%r10, %rax
	movq	%rax, -40(%rbp,%rcx,8)
	movl	%ecx, %eax
	incq	%rcx
	cmpl	$512, %eax                      # imm = 0x200
	je	.LBB1_99
.LBB1_103:                              #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_72 Depth=2
                                        #       Parent Loop BB1_74 Depth=3
                                        #         Parent Loop BB1_78 Depth=4
                                        #           Parent Loop BB1_83 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	movq	-8(%rdx,%rcx,8), %rax
	movq	%rax, %r8
	shrq	$6, %r8
	movl	%eax, %r10d
	addq	%rsi, %r8
	bzhiq	%r12, %r8, %r8
	andl	$63, %r10d
	je	.LBB1_101
# %bb.104:                              #   in Loop: Header=BB1_103 Depth=6
	negb	%r10b
	shlxq	%r10, 8(%r9,%r8,8), %r10
	jmp	.LBB1_102
.LBB1_96:                               #   in Loop: Header=BB1_83 Depth=5
	movq	%r8, %r10
	andq	$-8, %r10
	leaq	-32(%rbp,%rax,8), %r11
	xorl	%ebx, %ebx
	leaq	(%r10,%rax), %rcx
	leaq	(%rdx,%rax,8), %rax
	.p2align	4
.LBB1_97:                               #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_72 Depth=2
                                        #       Parent Loop BB1_74 Depth=3
                                        #         Parent Loop BB1_78 Depth=4
                                        #           Parent Loop BB1_83 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	vmovdqu64	(%rax,%rbx,8), %zmm4
	kxnorb	%k0, %k0, %k1
	vpxord	%xmm17, %xmm17, %xmm17
	vpxord	%xmm18, %xmm18, %xmm18
	vpmovqd	%zmm4, %ymm5
	vpsrlq	$6, %zmm4, %zmm16
	vpandq	%zmm22, %zmm4, %zmm4
	vpaddq	%zmm3, %zmm16, %zmm16
	vpandq	%zmm20, %zmm16, %zmm16
	vpgatherqq	(%r9,%zmm16,8), %zmm17 {%k1}
	vpandd	%ymm19, %ymm5, %ymm5
	vptestmd	%ymm5, %ymm5, %k1
	vpsubd	%ymm5, %ymm21, %ymm5
	vpmovzxdq	%ymm5, %zmm5            # zmm5 = ymm5[0],zero,ymm5[1],zero,ymm5[2],zero,ymm5[3],zero,ymm5[4],zero,ymm5[5],zero,ymm5[6],zero,ymm5[7],zero
	vpsrlvq	%zmm4, %zmm17, %zmm4
	kmovq	%k1, %k2
	vpgatherqq	8(%r9,%zmm16,8), %zmm18 {%k2}
	vpsllvq	%zmm5, %zmm18, %zmm5
	vporq	%zmm5, %zmm4, %zmm4 {%k1}
	vmovdqu64	%zmm4, (%r11,%rbx,8)
	addq	$8, %rbx
	cmpq	%rbx, %r10
	jne	.LBB1_97
# %bb.98:                               #   in Loop: Header=BB1_83 Depth=5
	cmpq	%r10, %r8
	jne	.LBB1_100
	.p2align	4
.LBB1_99:                               #   in Loop: Header=BB1_83 Depth=5
	movl	$512, %r10d                     # imm = 0x200
	movl	$1, 4572(%rbp)                  # 4-byte Folded Spill
	testq	%rdi, %rdi
	jne	.LBB1_83
.LBB1_111:                              #   in Loop: Header=BB1_78 Depth=4
	movl	%r13d, %eax
	addq	%rax, 4472(%rbp)
	cmpl	$0, 4556(%rbp)                  # 4-byte Folded Reload
	jne	.LBB1_76
	jmp	.LBB1_112
	.p2align	4
.LBB1_105:                              #   in Loop: Header=BB1_78 Depth=4
	movq	%rdi, %rax
	jmp	.LBB1_108
	.p2align	4
.LBB1_106:                              #   in Loop: Header=BB1_108 Depth=5
	negb	%r10b
	shlxq	%r10, 8(%r9,%r8,8), %r10
.LBB1_107:                              #   in Loop: Header=BB1_108 Depth=5
	shrxq	%rcx, (%r9,%r8,8), %rcx
	orq	%r10, %rcx
	movq	%rcx, -32(%rbp,%rax,8)
	incq	%rax
	cmpq	%rax, %r11
	je	.LBB1_81
.LBB1_108:                              #   Parent Loop BB1_7 Depth=1
                                        #     Parent Loop BB1_72 Depth=2
                                        #       Parent Loop BB1_74 Depth=3
                                        #         Parent Loop BB1_78 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	(%rdx,%rax,8), %rcx
	movq	%rcx, %r8
	shrq	$6, %r8
	movl	%ecx, %r10d
	addq	%rsi, %r8
	bzhiq	%r12, %r8, %r8
	andl	$63, %r10d
	jne	.LBB1_106
# %bb.109:                              #   in Loop: Header=BB1_108 Depth=5
	xorl	%r10d, %r10d
	jmp	.LBB1_107
	.p2align	4
.LBB1_110:                              #   in Loop: Header=BB1_78 Depth=4
	movl	$999, %r13d                     # imm = 0x3E7
	movl	%r13d, %eax
	addq	%rax, 4472(%rbp)
	cmpl	$0, 4556(%rbp)                  # 4-byte Folded Reload
	jne	.LBB1_76
.LBB1_112:                              #   in Loop: Header=BB1_78 Depth=4
	movl	4516(%rbp), %ecx                # 4-byte Reload
	movq	4560(%rbp), %r8                 # 8-byte Reload
	incq	4416(%rbp)                      # 8-byte Folded Spill
	addq	%rax, 4488(%rbp)                # 8-byte Folded Spill
	movq	4400(%rbp), %r11                # 8-byte Reload
	movq	4408(%rbp), %rdi                # 8-byte Reload
	addq	%rcx, %r8
	movl	4512(%rbp), %ecx                # 4-byte Reload
	addq	%rcx, 4424(%rbp)                # 8-byte Folded Spill
	cmpl	$65, %eax
	jae	.LBB1_114
# %bb.113:                              #   in Loop: Header=BB1_78 Depth=4
	incl	4064(%rbp,%rax,4)
	jmp	.LBB1_77
.LBB1_114:                              #   in Loop: Header=BB1_78 Depth=4
	movq	4448(%rbp), %rax                # 8-byte Reload
	incl	%eax
	movq	%rax, 4448(%rbp)                # 8-byte Spill
	jmp	.LBB1_77
.LBB1_115:                              #   in Loop: Header=BB1_7 Depth=1
	vcvtusi2sd	%rax, %xmm5, %xmm2
	movq	$0, 4560(%rbp)                  # 8-byte Folded Spill
	vxorpd	%xmm3, %xmm3, %xmm3
	movq	%rcx, %r14
	movq	%r8, %r15
	jmp	.LBB1_117
.LBB1_116:                              #   in Loop: Header=BB1_7 Depth=1
	vcvtusi2sdq	4424(%rbp), %xmm31, %xmm3 # 8-byte Folded Reload
	movq	4448(%rbp), %r13                # 8-byte Reload
	movq	4416(%rbp), %r14                # 8-byte Reload
	movq	4488(%rbp), %r15                # 8-byte Reload
	movq	%r8, 4560(%rbp)                 # 8-byte Spill
	.p2align	4
.LBB1_117:                              #   in Loop: Header=BB1_7 Depth=1
	vunpcklpd	%xmm2, %xmm3, %xmm8     # xmm8 = xmm3[0],xmm2[0]
	vdivsd	%xmm1, %xmm0, %xmm9
	vzeroupper
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	4504(%rbp), %rcx
	leaq	-32(%rbp), %rdi
	leaq	4432(%rbp), %rbx
	leaq	4440(%rbp), %r9
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rdi, %rdx
	movq	%rbx, %r8
	callq	*__imp_GetProcessTimes(%rip)
	movl	4508(%rbp), %eax
	movl	4504(%rbp), %esi
	movq	%rdi, %rcx
	shlq	$32, %rax
	addq	4440(%rbp), %rax
	addq	%rax, %rsi
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%rbx, %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	vcvtusi2sd	%rsi, %xmm31, %xmm0
	movq	4536(%rbp), %rax                # 8-byte Reload
	leaq	.str.3(%rip), %rbx
	leaq	__const.main.pools(%rip), %rcx
	leaq	.str.4(%rip), %rdi
	leaq	.str.10(%rip), %r8
	movl	%r13d, 88(%rsp)
	movq	%rbx, %rdx
	vmulsd	%xmm6, %xmm0, %xmm0
	testq	%rax, %rax
	movl	(%rcx,%rax,4), %r9d
	leaq	.str.9(%rip), %rcx
	cmoveq	%rdi, %rdx
	cmpq	$4, %rax
	leaq	.str.11(%rip), %rax
	vsubsd	%xmm7, %xmm0, %xmm0
	vcvtsi2sdq	-32(%rbp), %xmm31, %xmm1
	vcvtsi2sdq	4432(%rbp), %xmm31, %xmm2
	cmoveq	%rax, %r8
	vcvtusi2sd	%r15, %xmm31, %xmm3
	vunpcklpd	%xmm3, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm3[0]
	vcvtusi2sd	%r14, %xmm31, %xmm3
	vmovddup	%xmm3, %xmm3                    # xmm3 = xmm3[0,0]
	vunpcklpd	%xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0]
	vdivpd	%xmm3, %xmm8, %xmm3
	vdivpd	%xmm2, %xmm1, %xmm1
	vmovupd	%xmm3, 72(%rsp)
	vmovsd	%xmm0, 40(%rsp)
	movl	$50, 32(%rsp)
	movq	4560(%rbp), %rax                # 8-byte Reload
	vsubsd	%xmm9, %xmm1, %xmm2
	vmovhpd	%xmm1, 56(%rsp)
	vmovsd	%xmm2, 48(%rsp)
	movq	%rax, 64(%rsp)
	callq	printf
	xorl	%r13d, %r13d
	xorl	%eax, %eax
	jmp	.LBB1_119
	.p2align	4
.LBB1_118:                              #   in Loop: Header=BB1_119 Depth=2
	incq	%r13
	cmpq	$65, %r13
	je	.LBB1_6
.LBB1_119:                              #   Parent Loop BB1_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	4064(%rbp,%r13,4), %r9d
	testl	%r9d, %r9d
	je	.LBB1_118
# %bb.120:                              #   in Loop: Header=BB1_119 Depth=2
	testl	%eax, %eax
	movq	%rbx, %rdx
	leaq	.str.12(%rip), %rcx
	leal	1(%rax), %esi
	movl	%r13d, %r8d
	cmoveq	%rdi, %rdx
	callq	printf
	movl	%esi, %eax
	jmp	.LBB1_118
.LBB1_121:
	movl	$3, %r14d
	jmp	.LBB1_124
.LBB1_122:
	movl	$5, %r14d
	jmp	.LBB1_124
.LBB1_123:
	movq	4472(%rbp), %rdx
	leaq	.str.7(%rip), %rcx
	callq	printf
	movq	4544(%rbp), %rcx                # 8-byte Reload
	callq	free
	xorl	%r14d, %r14d
.LBB1_124:
	movl	%r14d, %eax
	vmovaps	4576(%rbp), %xmm6               # 16-byte Reload
	vmovaps	4592(%rbp), %xmm7               # 16-byte Reload
	vmovaps	4608(%rbp), %xmm8               # 16-byte Reload
	vmovaps	4624(%rbp), %xmm9               # 16-byte Reload
	.seh_startepilogue
	addq	$4776, %rsp                     # imm = 0x12A8
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
	.seh_endproc
                                        # -- End function
	.section	.rdata,"dr",one_only,.str,unique,2
.str:                                   # @.str
	.asciz	"rb"

	.section	.rdata,"dr",one_only,.str.1,unique,3
.str.1:                                 # @.str.1
	.asciz	"{\"rows\":%llu,\"columns\":%llu,\"cases\":["

	.section	.rdata,"dr",one_only,.str.2,unique,4
.str.2:                                 # @.str.2
	.asciz	"%s{\"method\":\"%s\",\"pool\":%u,\"repetitions\":%u,\"cpu_seconds\":%.9f,\"wall_seconds\":%.9f,\"mean_count\":%.12f,\"max_count\":%u,\"failures\":%u}"

	.section	.rdata,"dr",one_only,.str.3,unique,5
.str.3:                                 # @.str.3
	.asciz	","

	.section	.rdata,"dr",one_only,.str.4,unique,6
.str.4:                                 # @.str.4
	.zero	1

	.section	.rdata,"dr",one_only,.str.5,unique,7
.str.5:                                 # @.str.5
	.asciz	"sequential"

	.section	.rdata,"dr",one_only,.str.6,unique,8
.str.6:                                 # @.str.6
	.asciz	"greedy"

	.section	.rdata,"dr",one_only,.str.7,unique,9
.str.7:                                 # @.str.7
	.asciz	"],\"checksum\":%llu}\n"

	.section	.rdata,"dr",one_only,__const.main.pools,unique,10
	.p2align	4, 0x0                          # @__const.main.pools
__const.main.pools:
	.long	64                              # 0x40
	.long	128                             # 0x80
	.long	256                             # 0x100
	.long	512                             # 0x200
	.long	0                               # 0x0

	.section	.rdata,"dr",one_only,.str.8,unique,11
.str.8:                                 # @.str.8
	.asciz	"{\"rows\":%llu,\"includes_construction\":true,\"excludes_offset_zero\":true,\"fallback_pool\":512,\"cases\":["

	.section	.rdata,"dr",one_only,.str.9,unique,12
.str.9:                                 # @.str.9
	.asciz	"%s{\"method\":\"%s\",\"initial_pool\":%u,\"repetitions\":%u,\"cpu_seconds\":%.9f,\"wall_seconds\":%.9f,\"mean_selected\":%.12f,\"fallback_words\":%llu,\"mean_fallback_masks\":%.12f,\"mean_attempted\":%.12f,\"failed\":%u,\"histogram\":{"

	.section	.rdata,"dr",one_only,.str.10,unique,13
.str.10:                                # @.str.10
	.asciz	"greedy_then_fallback"

	.section	.rdata,"dr",one_only,.str.11,unique,14
.str.11:                                # @.str.11
	.asciz	"sequential_productive"

	.section	.rdata,"dr",one_only,.str.12,unique,15
.str.12:                                # @.str.12
	.asciz	"%s\"%u\":%u"

	.section	.rdata,"dr",one_only,.str.13,unique,16
.str.13:                                # @.str.13
	.asciz	"}}"

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
