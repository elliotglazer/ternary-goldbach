	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
@feat.00 = 0
	.att_syntax
	.file	"native_pool_grid_simd.c"
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
	.p2align	6, 0x0                          # -- Begin function main
.LCPI1_0:
	.long	63                              # 0x3f
	.zero	4
.LCPI1_1:
	.quad	288230376151711743              # 0x3ffffffffffffff
.LCPI1_2:
	.long	64                              # 0x40
	.zero	4
.LCPI1_3:
	.quad	63                              # 0x3f
	.zero	32
.LCPI1_4:
	.quad	0                               # 0x0
	.quad	1                               # 0x1
	.quad	2                               # 0x2
	.quad	3                               # 0x3
	.quad	4                               # 0x4
	.quad	5                               # 0x5
	.quad	6                               # 0x6
	.quad	7                               # 0x7
.LCPI1_5:
	.quad	8                               # 0x8
.LCPI1_6:
	.quad	16                              # 0x10
.LCPI1_7:
	.quad	24                              # 0x18
.LCPI1_8:
	.quad	32                              # 0x20
.LCPI1_9:
	.quad	40                              # 0x28
.LCPI1_10:
	.quad	48                              # 0x30
.LCPI1_11:
	.quad	56                              # 0x38
.LCPI1_12:
	.quad	64                              # 0x40
.LCPI1_13:
	.quad	0x3e7ad7f29abcaf48              # double 9.9999999999999995E-8
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
	movl	$4744, %eax                     # imm = 0x1288
	callq	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc 4744
	leaq	128(%rsp), %rbp
	.seh_setframe %rbp, 128
	vmovapd	%xmm9, 4592(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm9, 4720
	vmovapd	%xmm8, 4576(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm8, 4704
	vmovapd	%xmm7, 4560(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm7, 4688
	vmovapd	%xmm6, 4544(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm6, 4672
	.seh_endprologue
	movq	%rdx, %rsi
	movl	%ecx, %edi
	movl	$2, %r13d
	callq	__main
	cmpl	$2, %edi
	jne	.LBB1_217
# %bb.1:
	movq	8(%rsi), %rcx
	leaq	.str(%rip), %rdx
	callq	fopen
	testq	%rax, %rax
	je	.LBB1_65
# %bb.2:
	leaq	4336(%rbp), %rcx
	movl	$8, %edx
	movl	$4, %r8d
	movq	%rax, %r9
	movq	%rax, %r14
	callq	fread
	movl	$4, %r13d
	cmpq	$4, %rax
	jne	.LBB1_217
# %bb.3:
	movq	4352(%rbp), %rcx
	movq	4360(%rbp), %rdx
	movq	4336(%rbp), %r15
	addq	%rcx, %rdx
	movq	%r15, 4520(%rbp)                # 8-byte Spill
	movq	%rcx, 4456(%rbp)                # 8-byte Spill
	imulq	%rdx, %r15
	movq	%rdx, 4504(%rbp)                # 8-byte Spill
	leaq	(,%r15,8), %rcx
	callq	malloc
	testq	%rax, %rax
	je	.LBB1_66
# %bb.4:
	movl	$8, %edx
	movq	%rax, 4536(%rbp)                # 8-byte Spill
	movq	%rax, %rcx
	movq	%r15, %r8
	movq	%r14, %r9
	callq	fread
	movl	$6, %r13d
	cmpq	%r15, %rax
	jne	.LBB1_217
# %bb.5:
	movq	%r14, %rcx
	callq	fclose
	movq	4344(%rbp), %rbx
	cmpq	$0, 4520(%rbp)                  # 8-byte Folded Reload
	je	.LBB1_68
# %bb.6:
	testq	%rbx, %rbx
	je	.LBB1_67
# %bb.7:
	movq	4536(%rbp), %rax                # 8-byte Reload
	vpbroadcastd	.LCPI1_0(%rip), %ymm0   # ymm0 = [63,63,63,63,63,63,63,63]
	vpbroadcastq	.LCPI1_1(%rip), %zmm1   # zmm1 = [288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743]
	vpbroadcastd	.LCPI1_2(%rip), %ymm2   # ymm2 = [64,64,64,64,64,64,64,64]
	vpbroadcastq	.LCPI1_3(%rip), %zmm3   # zmm3 = [63,63,63,63,63,63,63,63]
	vmovdqa64	.LCPI1_4(%rip), %zmm4   # zmm4 = [0,1,2,3,4,5,6,7]
	vpbroadcastq	.LCPI1_5(%rip), %zmm5   # zmm5 = [8,8,8,8,8,8,8,8]
	vpbroadcastq	.LCPI1_6(%rip), %zmm16  # zmm16 = [16,16,16,16,16,16,16,16]
	vpbroadcastq	.LCPI1_7(%rip), %zmm17  # zmm17 = [24,24,24,24,24,24,24,24]
	vpbroadcastq	.LCPI1_8(%rip), %zmm18  # zmm18 = [32,32,32,32,32,32,32,32]
	vpbroadcastq	.LCPI1_9(%rip), %zmm19  # zmm19 = [40,40,40,40,40,40,40,40]
	vpbroadcastq	.LCPI1_10(%rip), %zmm20 # zmm20 = [48,48,48,48,48,48,48,48]
	vpbroadcastq	.LCPI1_11(%rip), %zmm21 # zmm21 = [56,56,56,56,56,56,56,56]
	vpbroadcastq	.LCPI1_12(%rip), %zmm22 # zmm22 = [64,64,64,64,64,64,64,64]
	xorl	%r13d, %r13d
	xorl	%r9d, %r9d
	leaq	192(%rax), %rcx
	movq	4504(%rbp), %rax                # 8-byte Reload
	leaq	(,%rax,8), %r8
.LBB1_8:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_10 Depth 2
                                        #       Child Loop BB1_11 Depth 3
                                        #       Child Loop BB1_13 Depth 3
                                        #         Child Loop BB1_16 Depth 4
                                        #           Child Loop BB1_18 Depth 5
                                        #           Child Loop BB1_55 Depth 5
	movabsq	$-3689348814741910323, %rax     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%r9, %rdx
	imulq	%rax, %rdx
	movabsq	$3689348814741910324, %rax      # imm = 0x3333333333333334
	cmpq	%rax, %rdx
	jb	.LBB1_64
# %bb.9:                                #   in Loop: Header=BB1_8 Depth=1
	movq	%r9, %rdx
	imulq	4504(%rbp), %rdx                # 8-byte Folded Reload
	movq	4536(%rbp), %rax                # 8-byte Reload
	movq	%rbx, 4488(%rbp)                # 8-byte Spill
	movq	%r8, 4432(%rbp)                 # 8-byte Spill
	movq	%r9, 4528(%rbp)                 # 8-byte Spill
	leaq	(%rax,%rdx,8), %rdx
	movq	4456(%rbp), %rax                # 8-byte Reload
	leaq	(%rdx,%rax,8), %rdi
	xorl	%eax, %eax
.LBB1_10:                               #   Parent Loop BB1_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_11 Depth 3
                                        #       Child Loop BB1_13 Depth 3
                                        #         Child Loop BB1_16 Depth 4
                                        #           Child Loop BB1_18 Depth 5
                                        #           Child Loop BB1_55 Depth 5
	vpbroadcastq	%rax, %zmm23
	xorl	%edx, %edx
	movq	%rax, 4480(%rbp)                # 8-byte Spill
	.p2align	4
.LBB1_11:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovdqu64	-192(%rcx,%rdx,8), %zmm24
	kxnorb	%k0, %k0, %k1
	vpxord	%xmm27, %xmm27, %xmm27
	vmovdqu64	-128(%rcx,%rdx,8), %zmm29
	vpxord	%xmm28, %xmm28, %xmm28
	vmovdqu64	-64(%rcx,%rdx,8), %zmm30
	vpmovqd	%zmm24, %ymm25
	vpsrlq	$6, %zmm24, %zmm26
	vpandq	%zmm3, %zmm24, %zmm24
	vpaddq	%zmm23, %zmm26, %zmm26
	vpandq	%zmm1, %zmm26, %zmm26
	vpgatherqq	(%rdi,%zmm26,8), %zmm27 {%k1}
	vpandd	%ymm0, %ymm25, %ymm25
	vptestmd	%ymm25, %ymm25, %k1
	vpsubd	%ymm25, %ymm2, %ymm25
	vpmovzxdq	%ymm25, %zmm25          # zmm25 = ymm25[0],zero,ymm25[1],zero,ymm25[2],zero,ymm25[3],zero,ymm25[4],zero,ymm25[5],zero,ymm25[6],zero,ymm25[7],zero
	vpsrlvq	%zmm24, %zmm27, %zmm24
	vpxord	%xmm27, %xmm27, %xmm27
	kmovq	%k1, %k2
	vpgatherqq	8(%rdi,%zmm26,8), %zmm28 {%k2}
	vpsrlq	$6, %zmm29, %zmm26
	vpaddq	%zmm23, %zmm26, %zmm26
	vpandq	%zmm1, %zmm26, %zmm26
	vpsllvq	%zmm25, %zmm28, %zmm25
	vpxord	%xmm28, %xmm28, %xmm28
	vporq	%zmm25, %zmm24, %zmm24 {%k1}
	vpmovqd	%zmm29, %ymm25
	kxnorb	%k0, %k0, %k1
	vmovdqu64	%zmm24, -32(%rbp,%rdx,8)
	vpandq	%zmm3, %zmm29, %zmm24
	vmovdqu64	(%rcx,%rdx,8), %zmm29
	vpgatherqq	(%rdi,%zmm26,8), %zmm27 {%k1}
	vpandd	%ymm0, %ymm25, %ymm25
	vptestmd	%ymm25, %ymm25, %k1
	vpsubd	%ymm25, %ymm2, %ymm25
	vpmovzxdq	%ymm25, %zmm25          # zmm25 = ymm25[0],zero,ymm25[1],zero,ymm25[2],zero,ymm25[3],zero,ymm25[4],zero,ymm25[5],zero,ymm25[6],zero,ymm25[7],zero
	vpsrlvq	%zmm24, %zmm27, %zmm24
	vpxord	%xmm27, %xmm27, %xmm27
	kmovq	%k1, %k2
	vpgatherqq	8(%rdi,%zmm26,8), %zmm28 {%k2}
	vpsrlq	$6, %zmm30, %zmm26
	vpaddq	%zmm23, %zmm26, %zmm26
	vpandq	%zmm1, %zmm26, %zmm26
	vpsllvq	%zmm25, %zmm28, %zmm25
	vpxord	%xmm28, %xmm28, %xmm28
	vporq	%zmm25, %zmm24, %zmm24 {%k1}
	vpmovqd	%zmm30, %ymm25
	vmovdqu64	%zmm24, 32(%rbp,%rdx,8)
	vpandq	%zmm3, %zmm30, %zmm24
	vpandd	%ymm0, %ymm25, %ymm25
	vptestmd	%ymm25, %ymm25, %k1
	vpsubd	%ymm25, %ymm2, %ymm25
	vpmovzxdq	%ymm25, %zmm25          # zmm25 = ymm25[0],zero,ymm25[1],zero,ymm25[2],zero,ymm25[3],zero,ymm25[4],zero,ymm25[5],zero,ymm25[6],zero,ymm25[7],zero
	kmovq	%k1, %k2
	vpgatherqq	8(%rdi,%zmm26,8), %zmm28 {%k2}
	kxnorb	%k0, %k0, %k2
	vpgatherqq	(%rdi,%zmm26,8), %zmm27 {%k2}
	vpsrlq	$6, %zmm29, %zmm26
	vpaddq	%zmm23, %zmm26, %zmm26
	vpandq	%zmm1, %zmm26, %zmm26
	vpsllvq	%zmm25, %zmm28, %zmm25
	vpxord	%xmm28, %xmm28, %xmm28
	vpsrlvq	%zmm24, %zmm27, %zmm24
	vpxord	%xmm27, %xmm27, %xmm27
	vporq	%zmm25, %zmm24, %zmm24 {%k1}
	vpmovqd	%zmm29, %ymm25
	kxnorb	%k0, %k0, %k1
	vmovdqu64	%zmm24, 96(%rbp,%rdx,8)
	vpandq	%zmm3, %zmm29, %zmm24
	vpgatherqq	(%rdi,%zmm26,8), %zmm27 {%k1}
	vpandd	%ymm0, %ymm25, %ymm25
	vptestmd	%ymm25, %ymm25, %k1
	vpsubd	%ymm25, %ymm2, %ymm25
	vpmovzxdq	%ymm25, %zmm25          # zmm25 = ymm25[0],zero,ymm25[1],zero,ymm25[2],zero,ymm25[3],zero,ymm25[4],zero,ymm25[5],zero,ymm25[6],zero,ymm25[7],zero
	vpsrlvq	%zmm24, %zmm27, %zmm24
	kmovq	%k1, %k2
	vpgatherqq	8(%rdi,%zmm26,8), %zmm28 {%k2}
	vpsllvq	%zmm25, %zmm28, %zmm25
	vporq	%zmm25, %zmm24, %zmm24 {%k1}
	vmovdqu64	%zmm24, 160(%rbp,%rdx,8)
	addq	$32, %rdx
	cmpq	$512, %rdx                      # imm = 0x200
	jne	.LBB1_11
# %bb.12:                               #   in Loop: Header=BB1_10 Depth=2
	movl	$64, %edx
.LBB1_13:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_16 Depth 4
                                        #           Child Loop BB1_18 Depth 5
                                        #           Child Loop BB1_55 Depth 5
	movl	%edx, %r14d
	leaq	-8(%r14), %r15
	movq	$-1, %r12
	shrq	$3, %r15
	shlq	$6, %r15
	jmp	.LBB1_16
.LBB1_60:                               #   in Loop: Header=BB1_16 Depth=4
	movl	%esi, %r13d
	testl	%r11d, %r11d
	je	.LBB1_16
	jmp	.LBB1_61
.LBB1_14:                               #   in Loop: Header=BB1_16 Depth=4
	movl	%r9d, %edx
	movq	-32(%rbp,%rdx,8), %rdx
	xorl	%r11d, %r11d
	andnq	%r12, %rdx, %r12
	testl	%r11d, %r11d
	jne	.LBB1_61
.LBB1_16:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        #       Parent Loop BB1_13 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_18 Depth 5
                                        #           Child Loop BB1_55 Depth 5
	testq	%r12, %r12
	je	.LBB1_62
# %bb.17:                               #   in Loop: Header=BB1_16 Depth=4
	vpbroadcastq	%r12, %zmm25
	vpternlogd	$255, %zmm23, %zmm23, %zmm23 # zmm23 = -1
	movq	$-64, %rdx
	vpxord	%xmm24, %xmm24, %xmm24
	vmovdqa64	%zmm4, %zmm26
	.p2align	4
.LBB1_18:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        #       Parent Loop BB1_13 Depth=3
                                        #         Parent Loop BB1_16 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	vpandq	32(%rbp,%rdx), %zmm25, %zmm27
	vpandq	96(%rbp,%rdx), %zmm25, %zmm28
	vpandq	160(%rbp,%rdx), %zmm25, %zmm29
	vpopcntq	%zmm27, %zmm27
	vpcmpnleuq	%zmm24, %zmm27, %k1
	vpmaxuq	%zmm24, %zmm27, %zmm24
	vpopcntq	%zmm28, %zmm27
	vpandq	224(%rbp,%rdx), %zmm25, %zmm28
	vmovdqa64	%zmm26, %zmm23 {%k1}
	vpcmpnleuq	%zmm24, %zmm27, %k1
	vpmaxuq	%zmm24, %zmm27, %zmm24
	vpopcntq	%zmm29, %zmm27
	vpandq	288(%rbp,%rdx), %zmm25, %zmm29
	vpaddq	%zmm5, %zmm26, %zmm23 {%k1}
	vpcmpnleuq	%zmm24, %zmm27, %k1
	vpmaxuq	%zmm24, %zmm27, %zmm24
	vpaddq	%zmm16, %zmm26, %zmm23 {%k1}
	vpopcntq	%zmm28, %zmm27
	vpandq	352(%rbp,%rdx), %zmm25, %zmm28
	vpcmpnleuq	%zmm24, %zmm27, %k1
	vpmaxuq	%zmm24, %zmm27, %zmm24
	vpopcntq	%zmm29, %zmm27
	vpandq	416(%rbp,%rdx), %zmm25, %zmm29
	vpaddq	%zmm17, %zmm26, %zmm23 {%k1}
	vpcmpnleuq	%zmm24, %zmm27, %k1
	vpmaxuq	%zmm24, %zmm27, %zmm24
	vpaddq	%zmm18, %zmm26, %zmm23 {%k1}
	vpopcntq	%zmm28, %zmm27
	vpandq	480(%rbp,%rdx), %zmm25, %zmm28
	addq	$512, %rdx                      # imm = 0x200
	vpcmpnleuq	%zmm24, %zmm27, %k1
	vpmaxuq	%zmm24, %zmm27, %zmm24
	vpopcntq	%zmm29, %zmm27
	vpaddq	%zmm19, %zmm26, %zmm23 {%k1}
	vpcmpnleuq	%zmm24, %zmm27, %k1
	vpmaxuq	%zmm24, %zmm27, %zmm24
	vpaddq	%zmm20, %zmm26, %zmm23 {%k1}
	vpopcntq	%zmm28, %zmm27
	vpcmpnleuq	%zmm24, %zmm27, %k1
	vpmaxuq	%zmm24, %zmm27, %zmm24
	vpaddq	%zmm21, %zmm26, %zmm23 {%k1}
	vpaddq	%zmm22, %zmm26, %zmm26
	cmpq	%rdx, %r15
	jne	.LBB1_18
# %bb.19:                               #   in Loop: Header=BB1_16 Depth=4
	vmovq	%xmm24, %r9
	vmovq	%xmm23, %rdx
	movl	$4294967295, %eax               # imm = 0xFFFFFFFF
	testq	%r9, %r9
	movl	%r9d, %ebx
	vpextrq	$1, %xmm24, %r9
	setne	%r11b
	cmpq	%rax, %rdx
	movl	$0, %eax
	setb	%r10b
	orb	%r11b, %r10b
	cmoveq	%rax, %rbx
	cmpq	%rbx, %r9
	jbe	.LBB1_21
# %bb.20:                               #   in Loop: Header=BB1_16 Depth=4
	vpextrq	$1, %xmm23, %r10
	jmp	.LBB1_23
.LBB1_21:                               #   in Loop: Header=BB1_16 Depth=4
	testb	%r10b, %r10b
	movl	$-1, %eax
	cmovel	%eax, %edx
	cmpq	%rbx, %r9
	jne	.LBB1_24
# %bb.22:                               #   in Loop: Header=BB1_16 Depth=4
	vpextrq	$1, %xmm23, %r10
	cmpq	%rdx, %r10
	jae	.LBB1_24
.LBB1_23:                               #   in Loop: Header=BB1_16 Depth=4
	movl	%r9d, %ebx
	movl	%r10d, %edx
.LBB1_24:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$1, %ymm24, %xmm25
	vmovq	%xmm25, %r9
	cmpq	%rbx, %r9
	jbe	.LBB1_26
# %bb.25:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$1, %ymm23, %xmm25
	vmovq	%xmm25, %r10
	jmp	.LBB1_28
.LBB1_26:                               #   in Loop: Header=BB1_16 Depth=4
	jne	.LBB1_29
# %bb.27:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$1, %ymm23, %xmm25
	movl	%edx, %r11d
	vmovq	%xmm25, %r10
	cmpq	%r11, %r10
	jae	.LBB1_29
.LBB1_28:                               #   in Loop: Header=BB1_16 Depth=4
	movl	%r9d, %ebx
	movl	%r10d, %edx
.LBB1_29:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$1, %ymm24, %xmm25
	vpextrq	$1, %xmm25, %r9
	cmpq	%rbx, %r9
	jbe	.LBB1_31
# %bb.30:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$1, %ymm23, %xmm25
	vpextrq	$1, %xmm25, %r10
	jmp	.LBB1_33
.LBB1_31:                               #   in Loop: Header=BB1_16 Depth=4
	jne	.LBB1_34
# %bb.32:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$1, %ymm23, %xmm25
	movl	%edx, %r11d
	vpextrq	$1, %xmm25, %r10
	cmpq	%r11, %r10
	jae	.LBB1_34
.LBB1_33:                               #   in Loop: Header=BB1_16 Depth=4
	movl	%r9d, %ebx
	movl	%r10d, %edx
.LBB1_34:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$2, %zmm24, %xmm25
	vmovq	%xmm25, %r9
	cmpq	%rbx, %r9
	jbe	.LBB1_36
# %bb.35:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$2, %zmm23, %xmm26
	vmovq	%xmm26, %r10
	jmp	.LBB1_38
.LBB1_36:                               #   in Loop: Header=BB1_16 Depth=4
	jne	.LBB1_39
# %bb.37:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$2, %zmm23, %xmm26
	movl	%edx, %r11d
	vmovq	%xmm26, %r10
	cmpq	%r11, %r10
	jae	.LBB1_39
.LBB1_38:                               #   in Loop: Header=BB1_16 Depth=4
	movl	%r9d, %ebx
	movl	%r10d, %edx
.LBB1_39:                               #   in Loop: Header=BB1_16 Depth=4
	vpextrq	$1, %xmm25, %r9
	cmpq	%rbx, %r9
	jbe	.LBB1_41
# %bb.40:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$2, %zmm23, %xmm25
	vpextrq	$1, %xmm25, %r10
	jmp	.LBB1_43
.LBB1_41:                               #   in Loop: Header=BB1_16 Depth=4
	jne	.LBB1_44
# %bb.42:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$2, %zmm23, %xmm25
	movl	%edx, %r11d
	vpextrq	$1, %xmm25, %r10
	cmpq	%r11, %r10
	jae	.LBB1_44
.LBB1_43:                               #   in Loop: Header=BB1_16 Depth=4
	movl	%r9d, %ebx
	movl	%r10d, %edx
.LBB1_44:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$3, %zmm24, %xmm24
	vmovq	%xmm24, %r9
	cmpq	%rbx, %r9
	jbe	.LBB1_46
# %bb.45:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$3, %zmm23, %xmm25
	vmovq	%xmm25, %r10
	jmp	.LBB1_48
.LBB1_46:                               #   in Loop: Header=BB1_16 Depth=4
	jne	.LBB1_49
# %bb.47:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$3, %zmm23, %xmm25
	movl	%edx, %r11d
	vmovq	%xmm25, %r10
	cmpq	%r11, %r10
	jae	.LBB1_49
.LBB1_48:                               #   in Loop: Header=BB1_16 Depth=4
	movl	%r9d, %ebx
	movl	%r10d, %edx
.LBB1_49:                               #   in Loop: Header=BB1_16 Depth=4
	vpextrq	$1, %xmm24, %r9
	cmpq	%rbx, %r9
	jbe	.LBB1_51
# %bb.50:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$3, %zmm23, %xmm23
	vpextrq	$1, %xmm23, %r10
	jmp	.LBB1_53
.LBB1_51:                               #   in Loop: Header=BB1_16 Depth=4
	jne	.LBB1_54
# %bb.52:                               #   in Loop: Header=BB1_16 Depth=4
	vextracti32x4	$3, %zmm23, %xmm23
	movl	%edx, %r11d
	vpextrq	$1, %xmm23, %r10
	cmpq	%r11, %r10
	jae	.LBB1_54
.LBB1_53:                               #   in Loop: Header=BB1_16 Depth=4
	movq	%r9, %rbx
	movl	%r10d, %edx
.LBB1_54:                               #   in Loop: Header=BB1_16 Depth=4
	movl	$-1, %r9d
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	.p2align	4
.LBB1_55:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        #       Parent Loop BB1_13 Depth=3
                                        #         Parent Loop BB1_16 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	-32(%rbp,%r11,8), %rsi
	leal	1(%r11), %r8d
	leal	6(%r11), %eax
	andq	%r12, %rsi
	popcntq	%rsi, %rsi
	cmpl	%esi, %r10d
	cmoval	%r10d, %esi
	movq	-24(%rbp,%r11,8), %r10
	cmovbl	%r11d, %r9d
	andq	%r12, %r10
	popcntq	%r10, %r10
	cmpl	%r10d, %esi
	cmovael	%r9d, %r8d
	movq	-16(%rbp,%r11,8), %r9
	cmovbel	%r10d, %esi
	leal	2(%r11), %r10d
	andq	%r12, %r9
	popcntq	%r9, %r9
	cmpl	%r9d, %esi
	cmovael	%r8d, %r10d
	movq	-8(%rbp,%r11,8), %r8
	cmovbel	%r9d, %esi
	leal	3(%r11), %r9d
	andq	%r12, %r8
	popcntq	%r8, %r8
	cmpl	%r8d, %esi
	cmovbel	%r8d, %esi
	movq	(%rbp,%r11,8), %r8
	cmovael	%r10d, %r9d
	leal	4(%r11), %r10d
	andq	%r12, %r8
	popcntq	%r8, %r8
	cmpl	%r8d, %esi
	cmovbel	%r8d, %esi
	movq	8(%rbp,%r11,8), %r8
	cmovael	%r9d, %r10d
	leal	5(%r11), %r9d
	andq	%r12, %r8
	popcntq	%r8, %r8
	cmpl	%r8d, %esi
	cmovbel	%r8d, %esi
	movq	16(%rbp,%r11,8), %r8
	cmovael	%r10d, %r9d
	movq	24(%rbp,%r11,8), %r10
	andq	%r12, %r8
	popcntq	%r8, %r8
	cmpl	%r8d, %esi
	cmovael	%r9d, %eax
	cmovbel	%r8d, %esi
	andq	%r12, %r10
	leal	7(%r11), %r9d
	popcntq	%r10, %r8
	movl	%esi, %r10d
	cmpl	%r8d, %esi
	cmovbel	%r8d, %r10d
	cmovael	%eax, %r9d
	addq	$8, %r11
	cmpq	%r14, %r11
	jne	.LBB1_55
# %bb.56:                               #   in Loop: Header=BB1_16 Depth=4
	cmpl	%ebx, %r10d
	jne	.LBB1_216
# %bb.57:                               #   in Loop: Header=BB1_16 Depth=4
	testl	%r10d, %r10d
	movl	$1, %eax
	movl	$11, %r8d
	movl	%r13d, %esi
	setne	%r11b
	cmpl	%edx, %r9d
	setne	%bl
	testb	%bl, %r11b
	movl	$15, %r11d
	cmovnel	%eax, %r11d
	cmovnel	%r8d, %esi
	testl	%r10d, %r10d
	je	.LBB1_60
# %bb.58:                               #   in Loop: Header=BB1_16 Depth=4
	cmpl	%edx, %r9d
	je	.LBB1_14
	jmp	.LBB1_60
.LBB1_61:                               #   in Loop: Header=BB1_13 Depth=3
	cmpl	$15, %r11d
	jne	.LBB1_217
.LBB1_62:                               #   in Loop: Header=BB1_13 Depth=3
	leal	(%r14,%r14), %edx
	cmpl	$257, %r14d                     # imm = 0x101
	jb	.LBB1_13
# %bb.63:                               #   in Loop: Header=BB1_10 Depth=2
	movq	4480(%rbp), %rax                # 8-byte Reload
	movq	4488(%rbp), %rbx                # 8-byte Reload
	movq	4432(%rbp), %r8                 # 8-byte Reload
	movq	4528(%rbp), %r9                 # 8-byte Reload
	incq	%rax
	cmpq	%rbx, %rax
	jne	.LBB1_10
.LBB1_64:                               #   in Loop: Header=BB1_8 Depth=1
	incq	%r9
	addq	%r8, %rcx
	cmpq	4520(%rbp), %r9                 # 8-byte Folded Reload
	jne	.LBB1_8
	jmp	.LBB1_68
.LBB1_65:
	movl	$3, %r13d
	jmp	.LBB1_217
.LBB1_66:
	movl	$5, %r13d
	jmp	.LBB1_217
.LBB1_67:
	xorl	%ebx, %ebx
.LBB1_68:
	movq	$0, 4424(%rbp)
	movabsq	$-3689348814741910323, %rax     # imm = 0xCCCCCCCCCCCCCCCD
	leaq	.str.8(%rip), %rcx
	movq	4520(%rbp), %rdx                # 8-byte Reload
	mulxq	%rax, %rdx, %rdx
	shrq	$2, %rdx
	imulq	%rbx, %rdx
	shlq	$2, %rdx
	vzeroupper
	callq	printf
	movq	4504(%rbp), %rax                # 8-byte Reload
	vmovsd	.LCPI1_13(%rip), %xmm6          # xmm6 = [9.9999999999999995E-8,0.0E+0]
	movq	4536(%rbp), %rcx                # 8-byte Reload
	movb	$58, %r12b
	movq	$0, 4472(%rbp)                  # 8-byte Folded Spill
	movq	%rbx, 4488(%rbp)                # 8-byte Spill
	leaq	(,%rax,8), %rax
	movq	%rax, 4416(%rbp)                # 8-byte Spill
	leaq	24(%rcx), %rax
	movq	%rax, 4384(%rbp)                # 8-byte Spill
	jmp	.LBB1_70
	.p2align	4
.LBB1_69:                               #   in Loop: Header=BB1_70 Depth=1
	leaq	.str.13(%rip), %rcx
	callq	printf
	movq	4472(%rbp), %rcx                # 8-byte Reload
	incq	%rcx
	movq	%rcx, 4472(%rbp)                # 8-byte Spill
	cmpq	$5, %rcx
	je	.LBB1_215
.LBB1_70:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_135 Depth 2
                                        #       Child Loop BB1_137 Depth 3
                                        #         Child Loop BB1_141 Depth 4
                                        #           Child Loop BB1_142 Depth 5
                                        #           Child Loop BB1_202 Depth 5
                                        #           Child Loop BB1_146 Depth 5
                                        #             Child Loop BB1_147 Depth 6
                                        #             Child Loop BB1_191 Depth 6
                                        #             Child Loop BB1_197 Depth 6
                                        #     Child Loop BB1_76 Depth 2
                                        #       Child Loop BB1_79 Depth 3
                                        #         Child Loop BB1_83 Depth 4
                                        #           Child Loop BB1_84 Depth 5
                                        #       Child Loop BB1_104 Depth 3
                                        #         Child Loop BB1_108 Depth 4
                                        #           Child Loop BB1_109 Depth 5
                                        #     Child Loop BB1_213 Depth 2
	vpxor	%xmm0, %xmm0, %xmm0
	vmovdqu64	%zmm0, 4256(%rbp)
	vmovdqu64	%zmm0, 4192(%rbp)
	vmovdqu64	%zmm0, 4128(%rbp)
	vmovdqu64	%zmm0, 4064(%rbp)
	movl	$0, 4320(%rbp)
	vzeroupper
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	4464(%rbp), %rcx
	leaq	-32(%rbp), %rdi
	leaq	4400(%rbp), %r14
	leaq	4408(%rbp), %r9
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rdi, %rdx
	movq	%r14, %r8
	callq	*__imp_GetProcessTimes(%rip)
	movl	4468(%rbp), %eax
	movl	4464(%rbp), %esi
	movq	%rdi, %rcx
	shlq	$32, %rax
	addq	4408(%rbp), %rax
	addq	%rax, %rsi
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%r14, %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	vcvtusi2sd	%rsi, %xmm31, %xmm0
	cmpq	$0, 4520(%rbp)                  # 8-byte Folded Reload
	vpxor	%xmm2, %xmm2, %xmm2
	vmulsd	%xmm6, %xmm0, %xmm7
	vcvtsi2sdq	-32(%rbp), %xmm31, %xmm0
	vcvtsi2sdq	4400(%rbp), %xmm31, %xmm1
	je	.LBB1_132
# %bb.71:                               #   in Loop: Header=BB1_70 Depth=1
	testq	%rbx, %rbx
	je	.LBB1_132
# %bb.72:                               #   in Loop: Header=BB1_70 Depth=1
	cmpq	$4, 4472(%rbp)                  # 8-byte Folded Reload
	jne	.LBB1_133
# %bb.73:                               #   in Loop: Header=BB1_70 Depth=1
	xorl	%r15d, %r15d
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	xorl	%r13d, %r13d
	jmp	.LBB1_76
	.p2align	4
.LBB1_74:                               #   in Loop: Header=BB1_76 Depth=2
	movq	4448(%rbp), %r8                 # 8-byte Reload
	movq	%rcx, %r15
.LBB1_75:                               #   in Loop: Header=BB1_76 Depth=2
	movl	4480(%rbp), %ecx                # 4-byte Reload
	incl	%ecx
	cmpl	$100, %ecx
	je	.LBB1_209
.LBB1_76:                               #   Parent Loop BB1_70 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_79 Depth 3
                                        #         Child Loop BB1_83 Depth 4
                                        #           Child Loop BB1_84 Depth 5
                                        #       Child Loop BB1_104 Depth 3
                                        #         Child Loop BB1_108 Depth 4
                                        #           Child Loop BB1_109 Depth 5
	movl	%ecx, 4480(%rbp)                # 4-byte Spill
	testl	%ecx, %ecx
	je	.LBB1_101
# %bb.77:                               #   in Loop: Header=BB1_76 Depth=2
	movq	4384(%rbp), %rdx                # 8-byte Reload
	movq	%r8, 4448(%rbp)                 # 8-byte Spill
	movq	%r15, %rcx
	xorl	%r8d, %r8d
	jmp	.LBB1_79
	.p2align	4
.LBB1_78:                               #   in Loop: Header=BB1_79 Depth=3
	addq	4416(%rbp), %rdx                # 8-byte Folded Reload
	incq	%r8
	cmpq	4520(%rbp), %r8                 # 8-byte Folded Reload
	je	.LBB1_74
.LBB1_79:                               #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_76 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_83 Depth 4
                                        #           Child Loop BB1_84 Depth 5
	movabsq	$-3689348814741910323, %r10     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%r8, %r9
	imulq	%r10, %r9
	movabsq	$3689348814741910324, %r10      # imm = 0x3333333333333334
	cmpq	%r10, %r9
	jb	.LBB1_78
# %bb.80:                               #   in Loop: Header=BB1_79 Depth=3
	movq	%r8, %r9
	imulq	4504(%rbp), %r9                 # 8-byte Folded Reload
	movq	4536(%rbp), %r10                # 8-byte Reload
	leaq	(%r10,%r9,8), %r9
	movq	4456(%rbp), %r10                # 8-byte Reload
	leaq	(%r9,%r10,8), %r9
	xorl	%r10d, %r10d
	jmp	.LBB1_83
.LBB1_81:                               #   in Loop: Header=BB1_83 Depth=4
	movl	$999, %r11d                     # imm = 0x3E7
	.p2align	4
.LBB1_82:                               #   in Loop: Header=BB1_83 Depth=4
	movl	%r11d, %r11d
	addq	%r11, 4424(%rbp)
	incq	%r10
	movq	4488(%rbp), %rbx                # 8-byte Reload
	cmpq	%rbx, %r10
	je	.LBB1_78
.LBB1_83:                               #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_76 Depth=2
                                        #       Parent Loop BB1_79 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_84 Depth 5
	movq	$-1, %rdi
	xorl	%r11d, %r11d
	xorl	%esi, %esi
	.p2align	4
.LBB1_84:                               #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_76 Depth=2
                                        #       Parent Loop BB1_79 Depth=3
                                        #         Parent Loop BB1_83 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	-24(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_86
# %bb.85:                               #   in Loop: Header=BB1_84 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_87
	.p2align	4
.LBB1_86:                               #   in Loop: Header=BB1_84 Depth=5
	xorl	%r15d, %r15d
.LBB1_87:                               #   in Loop: Header=BB1_84 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_82
# %bb.88:                               #   in Loop: Header=BB1_84 Depth=5
	movq	-16(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_90
# %bb.89:                               #   in Loop: Header=BB1_84 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_91
	.p2align	4
.LBB1_90:                               #   in Loop: Header=BB1_84 Depth=5
	xorl	%r15d, %r15d
.LBB1_91:                               #   in Loop: Header=BB1_84 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_82
# %bb.92:                               #   in Loop: Header=BB1_84 Depth=5
	movq	-8(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_94
# %bb.93:                               #   in Loop: Header=BB1_84 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_95
	.p2align	4
.LBB1_94:                               #   in Loop: Header=BB1_84 Depth=5
	xorl	%r15d, %r15d
.LBB1_95:                               #   in Loop: Header=BB1_84 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_82
# %bb.96:                               #   in Loop: Header=BB1_84 Depth=5
	movq	(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_98
# %bb.97:                               #   in Loop: Header=BB1_84 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_99
	.p2align	4
.LBB1_98:                               #   in Loop: Header=BB1_84 Depth=5
	xorl	%r15d, %r15d
.LBB1_99:                               #   in Loop: Header=BB1_84 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_82
# %bb.100:                              #   in Loop: Header=BB1_84 Depth=5
	addq	$4, %rsi
	cmpq	$512, %rsi                      # imm = 0x200
	jne	.LBB1_84
	jmp	.LBB1_81
	.p2align	4
.LBB1_101:                              #   in Loop: Header=BB1_76 Depth=2
	movq	4536(%rbp), %rdx                # 8-byte Reload
	xorl	%ecx, %ecx
	jmp	.LBB1_104
	.p2align	4
.LBB1_102:                              #   in Loop: Header=BB1_104 Depth=3
	movq	4440(%rbp), %r15                # 8-byte Reload
	addq	%rbx, %r15
.LBB1_103:                              #   in Loop: Header=BB1_104 Depth=3
	addq	4416(%rbp), %rdx                # 8-byte Folded Reload
	incq	%rcx
	cmpq	4520(%rbp), %rcx                # 8-byte Folded Reload
	je	.LBB1_75
.LBB1_104:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_76 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_108 Depth 4
                                        #           Child Loop BB1_109 Depth 5
	movabsq	$-3689348814741910323, %r10     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%rcx, %r9
	imulq	%r10, %r9
	movabsq	$3689348814741910324, %r10      # imm = 0x3333333333333334
	cmpq	%r10, %r9
	jb	.LBB1_103
# %bb.105:                              #   in Loop: Header=BB1_104 Depth=3
	movq	%rcx, %r9
	imulq	4504(%rbp), %r9                 # 8-byte Folded Reload
	movq	4536(%rbp), %r10                # 8-byte Reload
	movq	%r15, 4440(%rbp)                # 8-byte Spill
	leaq	(%r10,%r9,8), %r9
	movq	4456(%rbp), %r10                # 8-byte Reload
	leaq	(%r9,%r10,8), %r9
	xorl	%r10d, %r10d
	jmp	.LBB1_108
	.p2align	4
.LBB1_106:                              #   in Loop: Header=BB1_108 Depth=4
	incl	4064(%rbp,%rdi,4)
.LBB1_107:                              #   in Loop: Header=BB1_108 Depth=4
	movl	%r11d, %r11d
	addq	%rdi, %r8
	addq	%r11, %rax
	incq	%r10
	cmpq	%rbx, %r10
	je	.LBB1_102
.LBB1_108:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_76 Depth=2
                                        #       Parent Loop BB1_104 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_109 Depth 5
	movq	$-1, %rdi
	movl	$4, %r11d
	xorl	%esi, %esi
	.p2align	4
.LBB1_109:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_76 Depth=2
                                        #       Parent Loop BB1_104 Depth=3
                                        #         Parent Loop BB1_108 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	-32(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_111
# %bb.110:                              #   in Loop: Header=BB1_109 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_112
	.p2align	4
.LBB1_111:                              #   in Loop: Header=BB1_109 Depth=5
	xorl	%r15d, %r15d
.LBB1_112:                              #   in Loop: Header=BB1_109 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_127
# %bb.113:                              #   in Loop: Header=BB1_109 Depth=5
	movq	-24(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_115
# %bb.114:                              #   in Loop: Header=BB1_109 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_116
	.p2align	4
.LBB1_115:                              #   in Loop: Header=BB1_109 Depth=5
	xorl	%r15d, %r15d
.LBB1_116:                              #   in Loop: Header=BB1_109 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_128
# %bb.117:                              #   in Loop: Header=BB1_109 Depth=5
	movq	-16(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_119
# %bb.118:                              #   in Loop: Header=BB1_109 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_120
	.p2align	4
.LBB1_119:                              #   in Loop: Header=BB1_109 Depth=5
	xorl	%r15d, %r15d
.LBB1_120:                              #   in Loop: Header=BB1_109 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_129
# %bb.121:                              #   in Loop: Header=BB1_109 Depth=5
	movq	-8(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_123
# %bb.122:                              #   in Loop: Header=BB1_109 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_124
	.p2align	4
.LBB1_123:                              #   in Loop: Header=BB1_109 Depth=5
	xorl	%r15d, %r15d
.LBB1_124:                              #   in Loop: Header=BB1_109 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_130
# %bb.125:                              #   in Loop: Header=BB1_109 Depth=5
	addq	$4, %r11
	cmpq	$516, %r11                      # imm = 0x204
	jne	.LBB1_109
# %bb.126:                              #   in Loop: Header=BB1_108 Depth=4
	movl	$512, %r11d                     # imm = 0x200
	movl	$999, %esi                      # imm = 0x3E7
	jmp	.LBB1_130
	.p2align	4
.LBB1_127:                              #   in Loop: Header=BB1_108 Depth=4
	addq	$-3, %r11
	jmp	.LBB1_130
	.p2align	4
.LBB1_128:                              #   in Loop: Header=BB1_108 Depth=4
	addq	$-2, %r11
	jmp	.LBB1_130
.LBB1_129:                              #   in Loop: Header=BB1_108 Depth=4
	decq	%r11
	.p2align	4
.LBB1_130:                              #   in Loop: Header=BB1_108 Depth=4
	movl	%esi, %edi
	addq	%rdi, 4424(%rbp)
	movq	4488(%rbp), %rbx                # 8-byte Reload
	cmpl	$65, %esi
	jb	.LBB1_106
# %bb.131:                              #   in Loop: Header=BB1_108 Depth=4
	incl	%r13d
	jmp	.LBB1_107
	.p2align	4
.LBB1_132:                              #   in Loop: Header=BB1_70 Depth=1
	movq	$0, 4496(%rbp)                  # 8-byte Folded Spill
	xorl	%r13d, %r13d
	xorl	%r15d, %r15d
	movq	$0, 4528(%rbp)                  # 8-byte Folded Spill
	vpxor	%xmm3, %xmm3, %xmm3
	jmp	.LBB1_211
.LBB1_133:                              #   in Loop: Header=BB1_70 Depth=1
	vpbroadcastd	.LCPI1_0(%rip), %ymm19  # ymm19 = [63,63,63,63,63,63,63,63]
	vpbroadcastq	.LCPI1_1(%rip), %zmm20  # zmm20 = [288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743]
	vpbroadcastd	.LCPI1_2(%rip), %ymm21  # ymm21 = [64,64,64,64,64,64,64,64]
	vpbroadcastq	.LCPI1_3(%rip), %zmm22  # zmm22 = [63,63,63,63,63,63,63,63]
	vmovdqa64	.LCPI1_4(%rip), %zmm23  # zmm23 = [0,1,2,3,4,5,6,7]
	vpbroadcastq	.LCPI1_5(%rip), %zmm24  # zmm24 = [8,8,8,8,8,8,8,8]
	xorl	%r10d, %r10d
	movl	$0, 4516(%rbp)                  # 4-byte Folded Spill
	movq	$0, 4392(%rbp)                  # 8-byte Folded Spill
	movq	$0, 4440(%rbp)                  # 8-byte Folded Spill
	movq	$0, 4448(%rbp)                  # 8-byte Folded Spill
	movq	$0, 4496(%rbp)                  # 8-byte Folded Spill
	jmp	.LBB1_135
	.p2align	4
.LBB1_134:                              #   in Loop: Header=BB1_135 Depth=2
	movl	4516(%rbp), %eax                # 4-byte Reload
	incl	%eax
	movl	%eax, 4516(%rbp)                # 4-byte Spill
	cmpl	$100, %eax
	je	.LBB1_210
.LBB1_135:                              #   Parent Loop BB1_70 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_137 Depth 3
                                        #         Child Loop BB1_141 Depth 4
                                        #           Child Loop BB1_142 Depth 5
                                        #           Child Loop BB1_202 Depth 5
                                        #           Child Loop BB1_146 Depth 5
                                        #             Child Loop BB1_147 Depth 6
                                        #             Child Loop BB1_191 Depth 6
                                        #             Child Loop BB1_197 Depth 6
	movq	4536(%rbp), %rdx                # 8-byte Reload
	xorl	%r8d, %r8d
	jmp	.LBB1_137
	.p2align	4
.LBB1_136:                              #   in Loop: Header=BB1_137 Depth=3
	movq	4376(%rbp), %r8                 # 8-byte Reload
	addq	4416(%rbp), %rdx                # 8-byte Folded Reload
	incq	%r8
	cmpq	4520(%rbp), %r8                 # 8-byte Folded Reload
	je	.LBB1_134
.LBB1_137:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_135 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_141 Depth 4
                                        #           Child Loop BB1_142 Depth 5
                                        #           Child Loop BB1_202 Depth 5
                                        #           Child Loop BB1_146 Depth 5
                                        #             Child Loop BB1_147 Depth 6
                                        #             Child Loop BB1_191 Depth 6
                                        #             Child Loop BB1_197 Depth 6
	movabsq	$-3689348814741910323, %rcx     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%r8, %rax
	movq	%r8, 4376(%rbp)                 # 8-byte Spill
	imulq	%rcx, %rax
	movabsq	$3689348814741910324, %rcx      # imm = 0x3333333333333334
	cmpq	%rcx, %rax
	jb	.LBB1_136
# %bb.138:                              #   in Loop: Header=BB1_137 Depth=3
	movq	%r8, %rax
	imulq	4504(%rbp), %rax                # 8-byte Folded Reload
	movq	4536(%rbp), %rcx                # 8-byte Reload
	xorl	%r8d, %r8d
	leaq	(%rcx,%rax,8), %rax
	movq	4456(%rbp), %rcx                # 8-byte Reload
	leaq	(%rax,%rcx,8), %r9
	movq	4472(%rbp), %rcx                # 8-byte Reload
	leaq	__const.main.pools(%rip), %rax
	movl	(%rax,%rcx,4), %r11d
	movq	%r11, 4368(%rbp)                # 8-byte Spill
                                        # kill: def $r11d killed $r11d killed $r11 def $r11
	andl	$-8, %r11d
	jmp	.LBB1_141
	.p2align	4
.LBB1_139:                              #   in Loop: Header=BB1_141 Depth=4
	movq	4488(%rbp), %rbx                # 8-byte Reload
	movq	4528(%rbp), %r10                # 8-byte Reload
.LBB1_140:                              #   in Loop: Header=BB1_141 Depth=4
	incq	%r8
	cmpq	%rbx, %r8
	je	.LBB1_136
.LBB1_141:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_135 Depth=2
                                        #       Parent Loop BB1_137 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_142 Depth 5
                                        #           Child Loop BB1_202 Depth 5
                                        #           Child Loop BB1_146 Depth 5
                                        #             Child Loop BB1_147 Depth 6
                                        #             Child Loop BB1_191 Depth 6
                                        #             Child Loop BB1_197 Depth 6
	vpbroadcastq	%r8, %zmm3
	xorl	%eax, %eax
	.p2align	4
.LBB1_142:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_135 Depth=2
                                        #       Parent Loop BB1_137 Depth=3
                                        #         Parent Loop BB1_141 Depth=4
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
	cmpq	%rax, %r11
	jne	.LBB1_142
# %bb.143:                              #   in Loop: Header=BB1_141 Depth=4
	movq	4368(%rbp), %rdi                # 8-byte Reload
	movq	%r10, 4528(%rbp)                # 8-byte Spill
	cmpl	%edi, %r11d
	jne	.LBB1_199
.LBB1_144:                              #   in Loop: Header=BB1_141 Depth=4
	movq	$-1, %rcx
	xorl	%eax, %eax
	movl	$0, 4432(%rbp)                  # 4-byte Folded Spill
	movl	$0, 4480(%rbp)                  # 4-byte Folded Spill
	xorl	%r14d, %r14d
	movl	%edi, %r10d
	jmp	.LBB1_146
	.p2align	4
.LBB1_145:                              #   in Loop: Header=BB1_146 Depth=5
	movq	-32(%rbp,%rsi,8), %rsi
	addl	%r14d, 4480(%rbp)               # 4-byte Folded Spill
	incl	%eax
	movb	$58, %r12b
	andnq	%rcx, %rsi, %rcx
	testq	%rcx, %rcx
	je	.LBB1_205
.LBB1_146:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_135 Depth=2
                                        #       Parent Loop BB1_137 Depth=3
                                        #         Parent Loop BB1_141 Depth=4
                                        # =>        This Loop Header: Depth=5
                                        #             Child Loop BB1_147 Depth 6
                                        #             Child Loop BB1_191 Depth 6
                                        #             Child Loop BB1_197 Depth 6
	vpbroadcastq	%rcx, %zmm16
	vpternlogd	$255, %zmm4, %zmm4, %zmm4 # zmm4 = -1
	movl	%r10d, %ebx
	vpxor	%xmm5, %xmm5, %xmm5
	xorl	%esi, %esi
	vmovdqa64	%zmm23, %zmm17
	.p2align	4
.LBB1_147:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_135 Depth=2
                                        #       Parent Loop BB1_137 Depth=3
                                        #         Parent Loop BB1_141 Depth=4
                                        #           Parent Loop BB1_146 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	vpandq	-32(%rbp,%rsi,8), %zmm16, %zmm18
	addq	$8, %rsi
	vpopcntq	%zmm18, %zmm18
	vpcmpnleuq	%zmm5, %zmm18, %k1
	vpmaxuq	%zmm5, %zmm18, %zmm5
	vmovdqa64	%zmm17, %zmm4 {%k1}
	vpaddq	%zmm24, %zmm17, %zmm17
	cmpq	%rbx, %rsi
	jb	.LBB1_147
# %bb.148:                              #   in Loop: Header=BB1_146 Depth=5
	vmovq	%xmm5, %rdi
	vmovq	%xmm4, %rsi
	movl	$4294967295, %r15d              # imm = 0xFFFFFFFF
	testq	%rdi, %rdi
	movl	%edi, %edi
	setne	%r13b
	cmpq	%r15, %rsi
	movl	$0, %r15d
	setb	%r12b
	orb	%r13b, %r12b
	vpextrq	$1, %xmm5, %r13
	cmoveq	%r15, %rdi
	cmpq	%rdi, %r13
	jbe	.LBB1_150
# %bb.149:                              #   in Loop: Header=BB1_146 Depth=5
	vpextrq	$1, %xmm4, %r12
	jmp	.LBB1_152
	.p2align	4
.LBB1_150:                              #   in Loop: Header=BB1_146 Depth=5
	testb	%r12b, %r12b
	movl	$-1, %r15d
	cmovel	%r15d, %esi
	cmpq	%rdi, %r13
	jne	.LBB1_153
# %bb.151:                              #   in Loop: Header=BB1_146 Depth=5
	vpextrq	$1, %xmm4, %r12
	cmpq	%rsi, %r12
	jae	.LBB1_153
.LBB1_152:                              #   in Loop: Header=BB1_146 Depth=5
	movl	%r13d, %edi
	movl	%r12d, %esi
.LBB1_153:                              #   in Loop: Header=BB1_146 Depth=5
	vextracti32x4	$1, %ymm5, %xmm16
	vmovq	%xmm16, %r13
	cmpq	%rdi, %r13
	jbe	.LBB1_155
# %bb.154:                              #   in Loop: Header=BB1_146 Depth=5
	vextracti32x4	$1, %ymm4, %xmm16
	vmovq	%xmm16, %r12
	jmp	.LBB1_157
	.p2align	4
.LBB1_155:                              #   in Loop: Header=BB1_146 Depth=5
	jne	.LBB1_158
# %bb.156:                              #   in Loop: Header=BB1_146 Depth=5
	vextracti32x4	$1, %ymm4, %xmm16
	movl	%esi, %r15d
	vmovq	%xmm16, %r12
	cmpq	%r15, %r12
	jae	.LBB1_158
.LBB1_157:                              #   in Loop: Header=BB1_146 Depth=5
	movl	%r13d, %edi
	movl	%r12d, %esi
.LBB1_158:                              #   in Loop: Header=BB1_146 Depth=5
	vextracti32x4	$1, %ymm5, %xmm16
	vpextrq	$1, %xmm16, %r13
	cmpq	%rdi, %r13
	jbe	.LBB1_160
# %bb.159:                              #   in Loop: Header=BB1_146 Depth=5
	vextracti32x4	$1, %ymm4, %xmm16
	vpextrq	$1, %xmm16, %r12
	jmp	.LBB1_162
	.p2align	4
.LBB1_160:                              #   in Loop: Header=BB1_146 Depth=5
	jne	.LBB1_163
# %bb.161:                              #   in Loop: Header=BB1_146 Depth=5
	vextracti32x4	$1, %ymm4, %xmm16
	movl	%esi, %r15d
	vpextrq	$1, %xmm16, %r12
	cmpq	%r15, %r12
	jae	.LBB1_163
.LBB1_162:                              #   in Loop: Header=BB1_146 Depth=5
	movl	%r13d, %edi
	movl	%r12d, %esi
.LBB1_163:                              #   in Loop: Header=BB1_146 Depth=5
	vextracti32x4	$2, %zmm5, %xmm17
	vextracti32x4	$2, %zmm4, %xmm16
	vmovq	%xmm17, %r13
	cmpq	%rdi, %r13
	jbe	.LBB1_165
# %bb.164:                              #   in Loop: Header=BB1_146 Depth=5
	vmovq	%xmm16, %r12
	jmp	.LBB1_167
	.p2align	4
.LBB1_165:                              #   in Loop: Header=BB1_146 Depth=5
	jne	.LBB1_168
# %bb.166:                              #   in Loop: Header=BB1_146 Depth=5
	vmovq	%xmm16, %r12
	movl	%esi, %r15d
	cmpq	%r15, %r12
	jae	.LBB1_168
.LBB1_167:                              #   in Loop: Header=BB1_146 Depth=5
	movl	%r13d, %edi
	movl	%r12d, %esi
.LBB1_168:                              #   in Loop: Header=BB1_146 Depth=5
	vpextrq	$1, %xmm17, %r13
	cmpq	%rdi, %r13
	jbe	.LBB1_170
# %bb.169:                              #   in Loop: Header=BB1_146 Depth=5
	vpextrq	$1, %xmm16, %r12
	jmp	.LBB1_172
	.p2align	4
.LBB1_170:                              #   in Loop: Header=BB1_146 Depth=5
	jne	.LBB1_173
# %bb.171:                              #   in Loop: Header=BB1_146 Depth=5
	vpextrq	$1, %xmm16, %r12
	movl	%esi, %r15d
	cmpq	%r15, %r12
	jae	.LBB1_173
.LBB1_172:                              #   in Loop: Header=BB1_146 Depth=5
	movl	%r13d, %edi
	movl	%r12d, %esi
.LBB1_173:                              #   in Loop: Header=BB1_146 Depth=5
	vextracti32x4	$3, %zmm5, %xmm5
	vextracti32x4	$3, %zmm4, %xmm4
	vmovq	%xmm5, %r13
	cmpq	%rdi, %r13
	jbe	.LBB1_175
# %bb.174:                              #   in Loop: Header=BB1_146 Depth=5
	vmovq	%xmm4, %r12
	jmp	.LBB1_177
	.p2align	4
.LBB1_175:                              #   in Loop: Header=BB1_146 Depth=5
	jne	.LBB1_178
# %bb.176:                              #   in Loop: Header=BB1_146 Depth=5
	vmovq	%xmm4, %r12
	movl	%esi, %r15d
	cmpq	%r15, %r12
	jae	.LBB1_178
.LBB1_177:                              #   in Loop: Header=BB1_146 Depth=5
	movl	%r13d, %edi
	movl	%r12d, %esi
.LBB1_178:                              #   in Loop: Header=BB1_146 Depth=5
	vpextrq	$1, %xmm5, %r13
	cmpq	%rdi, %r13
	jbe	.LBB1_180
# %bb.179:                              #   in Loop: Header=BB1_146 Depth=5
	vpextrq	$1, %xmm4, %r12
	jmp	.LBB1_182
	.p2align	4
.LBB1_180:                              #   in Loop: Header=BB1_146 Depth=5
	movl	%esi, %esi
	jne	.LBB1_183
# %bb.181:                              #   in Loop: Header=BB1_146 Depth=5
	vpextrq	$1, %xmm4, %r12
	cmpq	%rsi, %r12
	jae	.LBB1_183
.LBB1_182:                              #   in Loop: Header=BB1_146 Depth=5
	movl	%r12d, %esi
	movl	%r13d, %edi
.LBB1_183:                              #   in Loop: Header=BB1_146 Depth=5
	testq	%rdi, %rdi
	jne	.LBB1_145
# %bb.184:                              #   in Loop: Header=BB1_146 Depth=5
	movb	$58, %r12b
	cmpl	$512, %r10d                     # imm = 0x200
	je	.LBB1_204
# %bb.185:                              #   in Loop: Header=BB1_146 Depth=5
	movl	$1, 4432(%rbp)                  # 4-byte Folded Spill
	jae	.LBB1_193
# %bb.186:                              #   in Loop: Header=BB1_146 Depth=5
	leal	1(%r10), %edi
	movl	$513, %esi                      # imm = 0x201
	subq	%rdi, %rsi
	cmpq	$8, %rsi
	jb	.LBB1_187
# %bb.188:                              #   in Loop: Header=BB1_146 Depth=5
	movl	$512, %r14d                     # imm = 0x200
	subq	%rdi, %r14
	movl	$-2, %edi
	subl	%r10d, %edi
	cmpl	%r14d, %edi
	setb	%r10b
	shrq	$32, %r14
	setne	%dil
	orb	%r10b, %dil
	je	.LBB1_190
.LBB1_187:                              #   in Loop: Header=BB1_146 Depth=5
	movq	%rbx, %r10
.LBB1_194:                              #   in Loop: Header=BB1_146 Depth=5
	incq	%r10
	jmp	.LBB1_197
	.p2align	4
.LBB1_195:                              #   in Loop: Header=BB1_197 Depth=6
	negb	%bl
	shlxq	%rbx, 8(%r9,%rdi,8), %rbx
.LBB1_196:                              #   in Loop: Header=BB1_197 Depth=6
	shrxq	%rsi, (%r9,%rdi,8), %rsi
	orq	%rbx, %rsi
	movq	%rsi, -40(%rbp,%r10,8)
	movl	%r10d, %esi
	incq	%r10
	cmpl	$512, %esi                      # imm = 0x200
	je	.LBB1_193
.LBB1_197:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_135 Depth=2
                                        #       Parent Loop BB1_137 Depth=3
                                        #         Parent Loop BB1_141 Depth=4
                                        #           Parent Loop BB1_146 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	movq	-8(%rdx,%r10,8), %rsi
	movq	%rsi, %rdi
	shrq	$6, %rdi
	movl	%esi, %ebx
	addq	%r8, %rdi
	bzhiq	%r12, %rdi, %rdi
	andl	$63, %ebx
	jne	.LBB1_195
# %bb.198:                              #   in Loop: Header=BB1_197 Depth=6
	xorl	%ebx, %ebx
	jmp	.LBB1_196
.LBB1_190:                              #   in Loop: Header=BB1_146 Depth=5
	movq	%rsi, %rdi
	andq	$-8, %rdi
	leaq	-32(%rbp,%rbx,8), %r14
	xorl	%r13d, %r13d
	leaq	(%rdi,%rbx), %r10
	leaq	(%rdx,%rbx,8), %rbx
	.p2align	4
.LBB1_191:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_135 Depth=2
                                        #       Parent Loop BB1_137 Depth=3
                                        #         Parent Loop BB1_141 Depth=4
                                        #           Parent Loop BB1_146 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	vmovdqu64	(%rbx,%r13,8), %zmm4
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
	vmovdqu64	%zmm4, (%r14,%r13,8)
	addq	$8, %r13
	cmpq	%r13, %rdi
	jne	.LBB1_191
# %bb.192:                              #   in Loop: Header=BB1_146 Depth=5
	cmpq	%rdi, %rsi
	jne	.LBB1_194
	.p2align	4
.LBB1_193:                              #   in Loop: Header=BB1_146 Depth=5
	movl	$1, %r14d
	movl	$512, %r10d                     # imm = 0x200
	testq	%rcx, %rcx
	jne	.LBB1_146
.LBB1_205:                              #   in Loop: Header=BB1_141 Depth=4
	movl	%eax, %eax
	addq	%rax, 4424(%rbp)
	cmpl	$0, 4516(%rbp)                  # 4-byte Folded Reload
	jne	.LBB1_139
	jmp	.LBB1_206
	.p2align	4
.LBB1_199:                              #   in Loop: Header=BB1_141 Depth=4
	movq	%r11, %rax
	jmp	.LBB1_202
	.p2align	4
.LBB1_200:                              #   in Loop: Header=BB1_202 Depth=5
	negb	%sil
	shlxq	%rsi, 8(%r9,%r10,8), %rsi
.LBB1_201:                              #   in Loop: Header=BB1_202 Depth=5
	shrxq	%rcx, (%r9,%r10,8), %rcx
	orq	%rsi, %rcx
	movq	%rcx, -32(%rbp,%rax,8)
	incq	%rax
	cmpq	%rax, %rdi
	je	.LBB1_144
.LBB1_202:                              #   Parent Loop BB1_70 Depth=1
                                        #     Parent Loop BB1_135 Depth=2
                                        #       Parent Loop BB1_137 Depth=3
                                        #         Parent Loop BB1_141 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	(%rdx,%rax,8), %rcx
	movq	%rcx, %r10
	shrq	$6, %r10
	movl	%ecx, %esi
	addq	%r8, %r10
	bzhiq	%r12, %r10, %r10
	andl	$63, %esi
	jne	.LBB1_200
# %bb.203:                              #   in Loop: Header=BB1_202 Depth=5
	xorl	%esi, %esi
	jmp	.LBB1_201
	.p2align	4
.LBB1_204:                              #   in Loop: Header=BB1_141 Depth=4
	movl	$999, %eax                      # imm = 0x3E7
	movl	%eax, %eax
	addq	%rax, 4424(%rbp)
	cmpl	$0, 4516(%rbp)                  # 4-byte Folded Reload
	jne	.LBB1_139
.LBB1_206:                              #   in Loop: Header=BB1_141 Depth=4
	movl	4432(%rbp), %ecx                # 4-byte Reload
	movq	4528(%rbp), %r10                # 8-byte Reload
	incq	4440(%rbp)                      # 8-byte Folded Spill
	addq	%rax, 4448(%rbp)                # 8-byte Folded Spill
	movq	4488(%rbp), %rbx                # 8-byte Reload
	addq	%rcx, %r10
	movl	4480(%rbp), %ecx                # 4-byte Reload
	addq	%rcx, 4392(%rbp)                # 8-byte Folded Spill
	cmpl	$65, %eax
	jae	.LBB1_208
# %bb.207:                              #   in Loop: Header=BB1_141 Depth=4
	incl	4064(%rbp,%rax,4)
	jmp	.LBB1_140
.LBB1_208:                              #   in Loop: Header=BB1_141 Depth=4
	movq	4496(%rbp), %rax                # 8-byte Reload
	incl	%eax
	movq	%rax, 4496(%rbp)                # 8-byte Spill
	jmp	.LBB1_140
.LBB1_209:                              #   in Loop: Header=BB1_70 Depth=1
	movq	%r13, 4496(%rbp)                # 8-byte Spill
	vcvtusi2sd	%rax, %xmm31, %xmm2
	movq	$0, 4528(%rbp)                  # 8-byte Folded Spill
	vpxor	%xmm3, %xmm3, %xmm3
	movq	%r8, %r13
	jmp	.LBB1_211
.LBB1_210:                              #   in Loop: Header=BB1_70 Depth=1
	vcvtusi2sdq	4392(%rbp), %xmm31, %xmm3 # 8-byte Folded Reload
	movq	4440(%rbp), %r15                # 8-byte Reload
	movq	4448(%rbp), %r13                # 8-byte Reload
	movq	%r10, 4528(%rbp)                # 8-byte Spill
	.p2align	4
.LBB1_211:                              #   in Loop: Header=BB1_70 Depth=1
	vunpcklpd	%xmm2, %xmm3, %xmm8     # xmm8 = xmm3[0],xmm2[0]
	vdivsd	%xmm1, %xmm0, %xmm9
	vzeroupper
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	4464(%rbp), %rcx
	leaq	-32(%rbp), %rdi
	leaq	4400(%rbp), %r14
	leaq	4408(%rbp), %r9
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rdi, %rdx
	movq	%r14, %r8
	callq	*__imp_GetProcessTimes(%rip)
	movl	4468(%rbp), %eax
	movl	4464(%rbp), %esi
	movq	%rdi, %rcx
	shlq	$32, %rax
	addq	4408(%rbp), %rax
	addq	%rax, %rsi
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%r14, %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	vcvtusi2sd	%rsi, %xmm31, %xmm0
	movq	4472(%rbp), %rcx                # 8-byte Reload
	leaq	.str.3(%rip), %r14
	leaq	__const.main.pools(%rip), %rax
	leaq	.str.4(%rip), %rdi
	leaq	.str.10(%rip), %r8
	movq	%r14, %rdx
	vmulsd	%xmm6, %xmm0, %xmm0
	testq	%rcx, %rcx
	movl	(%rax,%rcx,4), %r9d
	leaq	.str.11(%rip), %rax
	cmoveq	%rdi, %rdx
	cmpq	$4, %rcx
	leaq	.str.9(%rip), %rcx
	vsubsd	%xmm7, %xmm0, %xmm0
	vcvtsi2sdq	-32(%rbp), %xmm31, %xmm1
	vcvtsi2sdq	4400(%rbp), %xmm31, %xmm2
	cmoveq	%rax, %r8
	movq	4496(%rbp), %rax                # 8-byte Reload
	vcvtusi2sd	%r13, %xmm31, %xmm3
	movl	%eax, 88(%rsp)
	vunpcklpd	%xmm3, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm3[0]
	vcvtusi2sd	%r15, %xmm31, %xmm3
	vmovddup	%xmm3, %xmm3                    # xmm3 = xmm3[0,0]
	vunpcklpd	%xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0]
	vdivpd	%xmm3, %xmm8, %xmm3
	vdivpd	%xmm2, %xmm1, %xmm1
	vmovupd	%xmm3, 72(%rsp)
	vmovsd	%xmm0, 40(%rsp)
	movl	$100, 32(%rsp)
	movq	4528(%rbp), %rax                # 8-byte Reload
	vsubsd	%xmm9, %xmm1, %xmm2
	vmovhpd	%xmm1, 56(%rsp)
	vmovsd	%xmm2, 48(%rsp)
	movq	%rax, 64(%rsp)
	callq	printf
	xorl	%r13d, %r13d
	xorl	%eax, %eax
	jmp	.LBB1_213
	.p2align	4
.LBB1_212:                              #   in Loop: Header=BB1_213 Depth=2
	incq	%r13
	cmpq	$65, %r13
	je	.LBB1_69
.LBB1_213:                              #   Parent Loop BB1_70 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	4064(%rbp,%r13,4), %r9d
	testl	%r9d, %r9d
	je	.LBB1_212
# %bb.214:                              #   in Loop: Header=BB1_213 Depth=2
	testl	%eax, %eax
	movq	%r14, %rdx
	leaq	.str.12(%rip), %rcx
	leal	1(%rax), %esi
	movl	%r13d, %r8d
	cmoveq	%rdi, %rdx
	callq	printf
	movl	%esi, %eax
	jmp	.LBB1_212
.LBB1_215:
	movq	4424(%rbp), %rdx
	leaq	.str.7(%rip), %rcx
	callq	printf
	movq	4536(%rbp), %rcx                # 8-byte Reload
	callq	free
	xorl	%r13d, %r13d
	jmp	.LBB1_217
.LBB1_216:
	movl	$11, %r13d
.LBB1_217:
	movl	%r13d, %eax
	vmovaps	4544(%rbp), %xmm6               # 16-byte Reload
	vmovaps	4560(%rbp), %xmm7               # 16-byte Reload
	vmovaps	4576(%rbp), %xmm8               # 16-byte Reload
	vmovaps	4592(%rbp), %xmm9               # 16-byte Reload
	.seh_startepilogue
	addq	$4744, %rsp                     # imm = 0x1288
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.seh_endepilogue
	vzeroupper
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
	.asciz	"{\"variant\":\"simd8_popcount\",\"exact_choice_selfcheck\":true,\"rows\":%llu,\"includes_construction\":true,\"excludes_offset_zero\":true,\"fallback_pool\":512,\"cases\":["

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
