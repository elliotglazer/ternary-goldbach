	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
@feat.00 = 0
	.att_syntax
	.file	"native_pool_grid_simd_key.c"
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
	.quad	1023                            # 0x3ff
	.quad	1022                            # 0x3fe
	.quad	1021                            # 0x3fd
	.quad	1020                            # 0x3fc
	.quad	1019                            # 0x3fb
	.quad	1018                            # 0x3fa
	.quad	1017                            # 0x3f9
	.quad	1016                            # 0x3f8
.LCPI1_5:
	.quad	1015                            # 0x3f7
	.quad	1014                            # 0x3f6
	.quad	1013                            # 0x3f5
	.quad	1012                            # 0x3f4
	.quad	1011                            # 0x3f3
	.quad	1010                            # 0x3f2
	.quad	1009                            # 0x3f1
	.quad	1008                            # 0x3f0
.LCPI1_6:
	.quad	1007                            # 0x3ef
	.quad	1006                            # 0x3ee
	.quad	1005                            # 0x3ed
	.quad	1004                            # 0x3ec
	.quad	1003                            # 0x3eb
	.quad	1002                            # 0x3ea
	.quad	1001                            # 0x3e9
	.quad	1000                            # 0x3e8
.LCPI1_7:
	.quad	999                             # 0x3e7
	.quad	998                             # 0x3e6
	.quad	997                             # 0x3e5
	.quad	996                             # 0x3e4
	.quad	995                             # 0x3e3
	.quad	994                             # 0x3e2
	.quad	993                             # 0x3e1
	.quad	992                             # 0x3e0
.LCPI1_8:
	.quad	991                             # 0x3df
	.quad	990                             # 0x3de
	.quad	989                             # 0x3dd
	.quad	988                             # 0x3dc
	.quad	987                             # 0x3db
	.quad	986                             # 0x3da
	.quad	985                             # 0x3d9
	.quad	984                             # 0x3d8
.LCPI1_9:
	.quad	983                             # 0x3d7
	.quad	982                             # 0x3d6
	.quad	981                             # 0x3d5
	.quad	980                             # 0x3d4
	.quad	979                             # 0x3d3
	.quad	978                             # 0x3d2
	.quad	977                             # 0x3d1
	.quad	976                             # 0x3d0
.LCPI1_10:
	.quad	975                             # 0x3cf
	.quad	974                             # 0x3ce
	.quad	973                             # 0x3cd
	.quad	972                             # 0x3cc
	.quad	971                             # 0x3cb
	.quad	970                             # 0x3ca
	.quad	969                             # 0x3c9
	.quad	968                             # 0x3c8
.LCPI1_11:
	.quad	967                             # 0x3c7
	.quad	966                             # 0x3c6
	.quad	965                             # 0x3c5
	.quad	964                             # 0x3c4
	.quad	963                             # 0x3c3
	.quad	962                             # 0x3c2
	.quad	961                             # 0x3c1
	.quad	960                             # 0x3c0
.LCPI1_12:
	.quad	959                             # 0x3bf
	.quad	958                             # 0x3be
	.quad	957                             # 0x3bd
	.quad	956                             # 0x3bc
	.quad	955                             # 0x3bb
	.quad	954                             # 0x3ba
	.quad	953                             # 0x3b9
	.quad	952                             # 0x3b8
.LCPI1_13:
	.quad	951                             # 0x3b7
	.quad	950                             # 0x3b6
	.quad	949                             # 0x3b5
	.quad	948                             # 0x3b4
	.quad	947                             # 0x3b3
	.quad	946                             # 0x3b2
	.quad	945                             # 0x3b1
	.quad	944                             # 0x3b0
.LCPI1_14:
	.quad	943                             # 0x3af
	.quad	942                             # 0x3ae
	.quad	941                             # 0x3ad
	.quad	940                             # 0x3ac
	.quad	939                             # 0x3ab
	.quad	938                             # 0x3aa
	.quad	937                             # 0x3a9
	.quad	936                             # 0x3a8
.LCPI1_15:
	.quad	935                             # 0x3a7
	.quad	934                             # 0x3a6
	.quad	933                             # 0x3a5
	.quad	932                             # 0x3a4
	.quad	931                             # 0x3a3
	.quad	930                             # 0x3a2
	.quad	929                             # 0x3a1
	.quad	928                             # 0x3a0
.LCPI1_16:
	.quad	927                             # 0x39f
	.quad	926                             # 0x39e
	.quad	925                             # 0x39d
	.quad	924                             # 0x39c
	.quad	923                             # 0x39b
	.quad	922                             # 0x39a
	.quad	921                             # 0x399
	.quad	920                             # 0x398
.LCPI1_17:
	.quad	919                             # 0x397
	.quad	918                             # 0x396
	.quad	917                             # 0x395
	.quad	916                             # 0x394
	.quad	915                             # 0x393
	.quad	914                             # 0x392
	.quad	913                             # 0x391
	.quad	912                             # 0x390
.LCPI1_18:
	.quad	911                             # 0x38f
	.quad	910                             # 0x38e
	.quad	909                             # 0x38d
	.quad	908                             # 0x38c
	.quad	907                             # 0x38b
	.quad	906                             # 0x38a
	.quad	905                             # 0x389
	.quad	904                             # 0x388
.LCPI1_19:
	.quad	903                             # 0x387
	.quad	902                             # 0x386
	.quad	901                             # 0x385
	.quad	900                             # 0x384
	.quad	899                             # 0x383
	.quad	898                             # 0x382
	.quad	897                             # 0x381
	.quad	896                             # 0x380
.LCPI1_20:
	.quad	895                             # 0x37f
	.quad	894                             # 0x37e
	.quad	893                             # 0x37d
	.quad	892                             # 0x37c
	.quad	891                             # 0x37b
	.quad	890                             # 0x37a
	.quad	889                             # 0x379
	.quad	888                             # 0x378
.LCPI1_21:
	.quad	887                             # 0x377
	.quad	886                             # 0x376
	.quad	885                             # 0x375
	.quad	884                             # 0x374
	.quad	883                             # 0x373
	.quad	882                             # 0x372
	.quad	881                             # 0x371
	.quad	880                             # 0x370
.LCPI1_22:
	.quad	879                             # 0x36f
	.quad	878                             # 0x36e
	.quad	877                             # 0x36d
	.quad	876                             # 0x36c
	.quad	875                             # 0x36b
	.quad	874                             # 0x36a
	.quad	873                             # 0x369
	.quad	872                             # 0x368
.LCPI1_23:
	.quad	871                             # 0x367
	.quad	870                             # 0x366
	.quad	869                             # 0x365
	.quad	868                             # 0x364
	.quad	867                             # 0x363
	.quad	866                             # 0x362
	.quad	865                             # 0x361
	.quad	864                             # 0x360
.LCPI1_24:
	.quad	863                             # 0x35f
	.quad	862                             # 0x35e
	.quad	861                             # 0x35d
	.quad	860                             # 0x35c
	.quad	859                             # 0x35b
	.quad	858                             # 0x35a
	.quad	857                             # 0x359
	.quad	856                             # 0x358
.LCPI1_25:
	.quad	855                             # 0x357
	.quad	854                             # 0x356
	.quad	853                             # 0x355
	.quad	852                             # 0x354
	.quad	851                             # 0x353
	.quad	850                             # 0x352
	.quad	849                             # 0x351
	.quad	848                             # 0x350
.LCPI1_26:
	.quad	847                             # 0x34f
	.quad	846                             # 0x34e
	.quad	845                             # 0x34d
	.quad	844                             # 0x34c
	.quad	843                             # 0x34b
	.quad	842                             # 0x34a
	.quad	841                             # 0x349
	.quad	840                             # 0x348
.LCPI1_27:
	.quad	839                             # 0x347
	.quad	838                             # 0x346
	.quad	837                             # 0x345
	.quad	836                             # 0x344
	.quad	835                             # 0x343
	.quad	834                             # 0x342
	.quad	833                             # 0x341
	.quad	832                             # 0x340
.LCPI1_28:
	.quad	831                             # 0x33f
	.quad	830                             # 0x33e
	.quad	829                             # 0x33d
	.quad	828                             # 0x33c
	.quad	827                             # 0x33b
	.quad	826                             # 0x33a
	.quad	825                             # 0x339
	.quad	824                             # 0x338
.LCPI1_29:
	.quad	823                             # 0x337
	.quad	822                             # 0x336
	.quad	821                             # 0x335
	.quad	820                             # 0x334
	.quad	819                             # 0x333
	.quad	818                             # 0x332
	.quad	817                             # 0x331
	.quad	816                             # 0x330
.LCPI1_30:
	.quad	815                             # 0x32f
	.quad	814                             # 0x32e
	.quad	813                             # 0x32d
	.quad	812                             # 0x32c
	.quad	811                             # 0x32b
	.quad	810                             # 0x32a
	.quad	809                             # 0x329
	.quad	808                             # 0x328
.LCPI1_31:
	.quad	807                             # 0x327
	.quad	806                             # 0x326
	.quad	805                             # 0x325
	.quad	804                             # 0x324
	.quad	803                             # 0x323
	.quad	802                             # 0x322
	.quad	801                             # 0x321
	.quad	800                             # 0x320
.LCPI1_32:
	.quad	799                             # 0x31f
	.quad	798                             # 0x31e
	.quad	797                             # 0x31d
	.quad	796                             # 0x31c
	.quad	795                             # 0x31b
	.quad	794                             # 0x31a
	.quad	793                             # 0x319
	.quad	792                             # 0x318
.LCPI1_33:
	.quad	791                             # 0x317
	.quad	790                             # 0x316
	.quad	789                             # 0x315
	.quad	788                             # 0x314
	.quad	787                             # 0x313
	.quad	786                             # 0x312
	.quad	785                             # 0x311
	.quad	784                             # 0x310
.LCPI1_34:
	.quad	783                             # 0x30f
	.quad	782                             # 0x30e
	.quad	781                             # 0x30d
	.quad	780                             # 0x30c
	.quad	779                             # 0x30b
	.quad	778                             # 0x30a
	.quad	777                             # 0x309
	.quad	776                             # 0x308
.LCPI1_35:
	.quad	775                             # 0x307
	.quad	774                             # 0x306
	.quad	773                             # 0x305
	.quad	772                             # 0x304
	.quad	771                             # 0x303
	.quad	770                             # 0x302
	.quad	769                             # 0x301
	.quad	768                             # 0x300
.LCPI1_36:
	.quad	-8                              # 0xfffffffffffffff8
.LCPI1_37:
	.quad	-16                             # 0xfffffffffffffff0
.LCPI1_38:
	.quad	-24                             # 0xffffffffffffffe8
.LCPI1_39:
	.quad	-32                             # 0xffffffffffffffe0
.LCPI1_40:
	.quad	-40                             # 0xffffffffffffffd8
.LCPI1_41:
	.quad	-48                             # 0xffffffffffffffd0
.LCPI1_42:
	.quad	-56                             # 0xffffffffffffffc8
.LCPI1_43:
	.quad	-64                             # 0xffffffffffffffc0
.LCPI1_44:
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
	movl	$5816, %eax                     # imm = 0x16B8
	callq	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc 5816
	leaq	128(%rsp), %rbp
	.seh_setframe %rbp, 128
	vmovdqa	%xmm15, 5664(%rbp)              # 16-byte Spill
	.seh_savexmm %xmm15, 5792
	vmovdqa	%xmm14, 5648(%rbp)              # 16-byte Spill
	.seh_savexmm %xmm14, 5776
	vmovdqa	%xmm13, 5632(%rbp)              # 16-byte Spill
	.seh_savexmm %xmm13, 5760
	vmovdqa	%xmm12, 5616(%rbp)              # 16-byte Spill
	.seh_savexmm %xmm12, 5744
	vmovdqa	%xmm11, 5600(%rbp)              # 16-byte Spill
	.seh_savexmm %xmm11, 5728
	vmovdqa	%xmm10, 5584(%rbp)              # 16-byte Spill
	.seh_savexmm %xmm10, 5712
	vmovdqa	%xmm9, 5568(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm9, 5696
	vmovdqa	%xmm8, 5552(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm8, 5680
	vmovdqa	%xmm7, 5536(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm7, 5664
	vmovdqa	%xmm6, 5520(%rbp)               # 16-byte Spill
	.seh_savexmm %xmm6, 5648
	.seh_endprologue
	andq	$-64, %rsp
	movq	%rdx, %rsi
	movl	%ecx, %edi
	movl	$2, %r13d
	callq	__main
	cmpl	$2, %edi
	jne	.LBB1_181
# %bb.1:
	movq	8(%rsi), %rcx
	leaq	.str(%rip), %rdx
	callq	fopen
	testq	%rax, %rax
	je	.LBB1_178
# %bb.2:
	leaq	224(%rsp), %rcx
	movl	$8, %edx
	movl	$4, %r8d
	movq	%rax, %r9
	movq	%rax, %r14
	callq	fread
	movl	$4, %r13d
	cmpq	$4, %rax
	jne	.LBB1_181
# %bb.3:
	movq	240(%rsp), %rcx
	movq	248(%rsp), %rdx
	movq	224(%rsp), %r15
	addq	%rcx, %rdx
	movq	%r15, 144(%rsp)                 # 8-byte Spill
	movq	%rcx, 168(%rsp)                 # 8-byte Spill
	imulq	%rdx, %r15
	movq	%rdx, 152(%rsp)                 # 8-byte Spill
	leaq	(,%r15,8), %rcx
	callq	malloc
	testq	%rax, %rax
	je	.LBB1_179
# %bb.4:
	movl	$8, %edx
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rcx
	movq	%r15, %r8
	movq	%r14, %r9
	callq	fread
	movl	$6, %r13d
	cmpq	%r15, %rax
	jne	.LBB1_181
# %bb.5:
	movq	%r14, %rcx
	callq	fclose
	cmpq	$0, 144(%rsp)                   # 8-byte Folded Reload
	je	.LBB1_65
# %bb.6:
	movq	232(%rsp), %rsi
	testq	%rsi, %rsi
	je	.LBB1_65
# %bb.7:
	vpbroadcastd	.LCPI1_0(%rip), %ymm0   # ymm0 = [63,63,63,63,63,63,63,63]
	vpbroadcastq	.LCPI1_1(%rip), %zmm1   # zmm1 = [288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743]
	vpbroadcastd	.LCPI1_2(%rip), %ymm2   # ymm2 = [64,64,64,64,64,64,64,64]
	vpbroadcastq	.LCPI1_3(%rip), %zmm3   # zmm3 = [63,63,63,63,63,63,63,63]
	vpbroadcastq	.LCPI1_38(%rip), %zmm17 # zmm17 = [18446744073709551592,18446744073709551592,18446744073709551592,18446744073709551592,18446744073709551592,18446744073709551592,18446744073709551592,18446744073709551592]
	vpbroadcastq	.LCPI1_39(%rip), %zmm18 # zmm18 = [18446744073709551584,18446744073709551584,18446744073709551584,18446744073709551584,18446744073709551584,18446744073709551584,18446744073709551584,18446744073709551584]
	vpbroadcastq	.LCPI1_40(%rip), %zmm19 # zmm19 = [18446744073709551576,18446744073709551576,18446744073709551576,18446744073709551576,18446744073709551576,18446744073709551576,18446744073709551576,18446744073709551576]
	vpbroadcastq	.LCPI1_41(%rip), %zmm20 # zmm20 = [18446744073709551568,18446744073709551568,18446744073709551568,18446744073709551568,18446744073709551568,18446744073709551568,18446744073709551568,18446744073709551568]
	vpbroadcastq	.LCPI1_42(%rip), %zmm21 # zmm21 = [18446744073709551560,18446744073709551560,18446744073709551560,18446744073709551560,18446744073709551560,18446744073709551560,18446744073709551560,18446744073709551560]
	vpbroadcastq	.LCPI1_43(%rip), %zmm22 # zmm22 = [18446744073709551552,18446744073709551552,18446744073709551552,18446744073709551552,18446744073709551552,18446744073709551552,18446744073709551552,18446744073709551552]
	vmovdqa64	.LCPI1_4(%rip), %zmm14  # zmm14 = [1023,1022,1021,1020,1019,1018,1017,1016]
	vmovdqa64	.LCPI1_5(%rip), %zmm15  # zmm15 = [1015,1014,1013,1012,1011,1010,1009,1008]
	vmovdqa64	.LCPI1_6(%rip), %zmm5   # zmm5 = [1007,1006,1005,1004,1003,1002,1001,1000]
	vmovdqa64	.LCPI1_7(%rip), %zmm16  # zmm16 = [999,998,997,996,995,994,993,992]
	vmovdqa64	.LCPI1_8(%rip), %zmm8   # zmm8 = [991,990,989,988,987,986,985,984]
	vmovdqa64	.LCPI1_9(%rip), %zmm9   # zmm9 = [983,982,981,980,979,978,977,976]
	vmovdqa64	.LCPI1_10(%rip), %zmm10 # zmm10 = [975,974,973,972,971,970,969,968]
	vmovdqa64	.LCPI1_11(%rip), %zmm11 # zmm11 = [967,966,965,964,963,962,961,960]
	movq	152(%rsp), %rax                 # 8-byte Reload
	movq	136(%rsp), %r9                  # 8-byte Reload
	movl	$1, %edx
	movl	$11, %r8d
	xorl	%r13d, %r13d
	xorl	%r10d, %r10d
	leaq	(,%rax,8), %rdi
.LBB1_8:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_10 Depth 2
                                        #       Child Loop BB1_11 Depth 3
                                        #       Child Loop BB1_15 Depth 3
                                        #         Child Loop BB1_17 Depth 4
                                        #       Child Loop BB1_27 Depth 3
                                        #         Child Loop BB1_29 Depth 4
                                        #       Child Loop BB1_39 Depth 3
                                        #         Child Loop BB1_41 Depth 4
                                        #       Child Loop BB1_52 Depth 3
                                        #         Child Loop BB1_54 Depth 4
                                        #         Child Loop BB1_56 Depth 4
	movabsq	$-3689348814741910323, %rax     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%r10, %rcx
	imulq	%rax, %rcx
	movabsq	$3689348814741910324, %rax      # imm = 0x3333333333333334
	cmpq	%rax, %rcx
	jb	.LBB1_64
# %bb.9:                                #   in Loop: Header=BB1_8 Depth=1
	movq	%r10, %rcx
	imulq	152(%rsp), %rcx                 # 8-byte Folded Reload
	movq	136(%rsp), %rax                 # 8-byte Reload
	movq	%rsi, 216(%rsp)                 # 8-byte Spill
	movq	%rdi, 208(%rsp)                 # 8-byte Spill
	movq	%r10, 200(%rsp)                 # 8-byte Spill
	leaq	(%rax,%rcx,8), %rcx
	movq	168(%rsp), %rax                 # 8-byte Reload
	leaq	(%rcx,%rax,8), %r11
	xorl	%eax, %eax
.LBB1_10:                               #   Parent Loop BB1_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_11 Depth 3
                                        #       Child Loop BB1_15 Depth 3
                                        #         Child Loop BB1_17 Depth 4
                                        #       Child Loop BB1_27 Depth 3
                                        #         Child Loop BB1_29 Depth 4
                                        #       Child Loop BB1_39 Depth 3
                                        #         Child Loop BB1_41 Depth 4
                                        #       Child Loop BB1_52 Depth 3
                                        #         Child Loop BB1_54 Depth 4
                                        #         Child Loop BB1_56 Depth 4
	vpbroadcastq	%rax, %zmm4
	movl	$24, %esi
	.p2align	4
.LBB1_11:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovdqu64	-192(%r9,%rsi,8), %zmm23
	kxnorb	%k0, %k0, %k1
	vpxord	%xmm26, %xmm26, %xmm26
	vmovdqu64	-128(%r9,%rsi,8), %zmm28
	vpxord	%xmm27, %xmm27, %xmm27
	vmovdqu64	-64(%r9,%rsi,8), %zmm29
	vpmovqd	%zmm23, %ymm24
	vpsrlq	$6, %zmm23, %zmm25
	vpandq	%zmm3, %zmm23, %zmm23
	vpaddq	%zmm4, %zmm25, %zmm25
	vpandq	%zmm1, %zmm25, %zmm25
	vpgatherqq	(%r11,%zmm25,8), %zmm26 {%k1}
	vpandd	%ymm0, %ymm24, %ymm24
	vptestmd	%ymm24, %ymm24, %k1
	vpsubd	%ymm24, %ymm2, %ymm24
	vpmovzxdq	%ymm24, %zmm24          # zmm24 = ymm24[0],zero,ymm24[1],zero,ymm24[2],zero,ymm24[3],zero,ymm24[4],zero,ymm24[5],zero,ymm24[6],zero,ymm24[7],zero
	vpsrlvq	%zmm23, %zmm26, %zmm23
	vpxord	%xmm26, %xmm26, %xmm26
	kmovq	%k1, %k2
	vpgatherqq	8(%r11,%zmm25,8), %zmm27 {%k2}
	vpsrlq	$6, %zmm28, %zmm25
	vpaddq	%zmm4, %zmm25, %zmm25
	vpandq	%zmm1, %zmm25, %zmm25
	vpsllvq	%zmm24, %zmm27, %zmm24
	vpxord	%xmm27, %xmm27, %xmm27
	vporq	%zmm24, %zmm23, %zmm23 {%k1}
	vpmovqd	%zmm28, %ymm24
	kxnorb	%k0, %k0, %k1
	vmovdqu64	%zmm23, 1360(%rsp,%rsi,8)
	vpandq	%zmm3, %zmm28, %zmm23
	vmovdqu64	(%r9,%rsi,8), %zmm28
	vpgatherqq	(%r11,%zmm25,8), %zmm26 {%k1}
	vpandd	%ymm0, %ymm24, %ymm24
	vptestmd	%ymm24, %ymm24, %k1
	vpsubd	%ymm24, %ymm2, %ymm24
	vpmovzxdq	%ymm24, %zmm24          # zmm24 = ymm24[0],zero,ymm24[1],zero,ymm24[2],zero,ymm24[3],zero,ymm24[4],zero,ymm24[5],zero,ymm24[6],zero,ymm24[7],zero
	vpsrlvq	%zmm23, %zmm26, %zmm23
	vpxord	%xmm26, %xmm26, %xmm26
	kmovq	%k1, %k2
	vpgatherqq	8(%r11,%zmm25,8), %zmm27 {%k2}
	vpsrlq	$6, %zmm29, %zmm25
	vpaddq	%zmm4, %zmm25, %zmm25
	vpandq	%zmm1, %zmm25, %zmm25
	vpsllvq	%zmm24, %zmm27, %zmm24
	vpxord	%xmm27, %xmm27, %xmm27
	vporq	%zmm24, %zmm23, %zmm23 {%k1}
	vpmovqd	%zmm29, %ymm24
	vmovdqu64	%zmm23, 1424(%rsp,%rsi,8)
	vpandq	%zmm3, %zmm29, %zmm23
	vpandd	%ymm0, %ymm24, %ymm24
	vptestmd	%ymm24, %ymm24, %k1
	vpsubd	%ymm24, %ymm2, %ymm24
	vpmovzxdq	%ymm24, %zmm24          # zmm24 = ymm24[0],zero,ymm24[1],zero,ymm24[2],zero,ymm24[3],zero,ymm24[4],zero,ymm24[5],zero,ymm24[6],zero,ymm24[7],zero
	kmovq	%k1, %k2
	vpgatherqq	8(%r11,%zmm25,8), %zmm27 {%k2}
	kxnorb	%k0, %k0, %k2
	vpgatherqq	(%r11,%zmm25,8), %zmm26 {%k2}
	vpsrlq	$6, %zmm28, %zmm25
	vpaddq	%zmm4, %zmm25, %zmm25
	vpandq	%zmm1, %zmm25, %zmm25
	vpsllvq	%zmm24, %zmm27, %zmm24
	vpxord	%xmm27, %xmm27, %xmm27
	vpsrlvq	%zmm23, %zmm26, %zmm23
	vpxord	%xmm26, %xmm26, %xmm26
	vporq	%zmm24, %zmm23, %zmm23 {%k1}
	vpmovqd	%zmm28, %ymm24
	kxnorb	%k0, %k0, %k1
	vmovdqu64	%zmm23, 1488(%rsp,%rsi,8)
	vpandq	%zmm3, %zmm28, %zmm23
	vpgatherqq	(%r11,%zmm25,8), %zmm26 {%k1}
	vpandd	%ymm0, %ymm24, %ymm24
	vptestmd	%ymm24, %ymm24, %k1
	vpsubd	%ymm24, %ymm2, %ymm24
	vpmovzxdq	%ymm24, %zmm24          # zmm24 = ymm24[0],zero,ymm24[1],zero,ymm24[2],zero,ymm24[3],zero,ymm24[4],zero,ymm24[5],zero,ymm24[6],zero,ymm24[7],zero
	vpsrlvq	%zmm23, %zmm26, %zmm23
	kmovq	%k1, %k2
	vpgatherqq	8(%r11,%zmm25,8), %zmm27 {%k2}
	vpsllvq	%zmm24, %zmm27, %zmm24
	vporq	%zmm24, %zmm23, %zmm23 {%k1}
	vmovdqu64	%zmm23, 1552(%rsp,%rsi,8)
	addq	$32, %rsi
	cmpq	$536, %rsi                      # imm = 0x218
	jne	.LBB1_11
# %bb.12:                               #   in Loop: Header=BB1_10 Depth=2
	vmovdqu64	1552(%rsp), %zmm4
	vmovdqu64	1616(%rsp), %zmm23
	vmovdqu64	1680(%rsp), %zmm24
	vmovdqu64	1744(%rsp), %zmm25
	vmovdqu64	1808(%rsp), %zmm26
	vmovdqu64	1872(%rsp), %zmm27
	vmovdqu64	1936(%rsp), %zmm28
	vmovdqu64	2000(%rsp), %zmm29
	movq	$-1, %rsi
	jmp	.LBB1_15
.LBB1_22:                               #   in Loop: Header=BB1_15 Depth=3
	movl	%ecx, %r13d
	testl	%r14d, %r14d
	je	.LBB1_15
	jmp	.LBB1_23
.LBB1_13:                               #   in Loop: Header=BB1_15 Depth=3
	movl	%edi, %ecx
	movq	1552(%rsp,%rcx,8), %rcx
	xorl	%r14d, %r14d
	andnq	%rsi, %rcx, %rsi
	testl	%r14d, %r14d
	jne	.LBB1_23
.LBB1_15:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_17 Depth 4
	testq	%rsi, %rsi
	je	.LBB1_24
# %bb.16:                               #   in Loop: Header=BB1_15 Depth=3
	vpbroadcastq	%rsi, %zmm30
	movl	$-1, %edi
	xorl	%r15d, %r15d
	xorl	%r14d, %r14d
	.p2align	4
.LBB1_17:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        #       Parent Loop BB1_15 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	1552(%rsp,%r14,8), %rcx
	movq	1608(%rsp,%r14,8), %r10
	leal	6(%r14), %ebx
	andq	%rsi, %rcx
	popcntq	%rcx, %r12
	movq	1560(%rsp,%r14,8), %rcx
	cmpl	%r12d, %r15d
	cmoval	%r15d, %r12d
	cmovbl	%r14d, %edi
	leal	1(%r14), %r15d
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r12d
	movq	1568(%rsp,%r14,8), %rcx
	cmovael	%edi, %r15d
	leal	2(%r14), %edi
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r12d
	movq	1576(%rsp,%r14,8), %rcx
	cmovael	%r15d, %edi
	leal	3(%r14), %r15d
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r12d
	movq	1584(%rsp,%r14,8), %rcx
	cmovael	%edi, %r15d
	leal	4(%r14), %edi
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r12d
	movq	1592(%rsp,%r14,8), %rcx
	cmovael	%r15d, %edi
	leal	5(%r14), %r15d
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r12d
	movq	1600(%rsp,%r14,8), %rcx
	cmovael	%edi, %r15d
	leal	7(%r14), %edi
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r12d
	cmovael	%r15d, %ebx
	andq	%rsi, %r10
	popcntq	%r10, %rcx
	movl	%r12d, %r15d
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r15d
	cmovael	%ebx, %edi
	addq	$8, %r14
	cmpq	$64, %r14
	jne	.LBB1_17
# %bb.18:                               #   in Loop: Header=BB1_15 Depth=3
	vpandq	%zmm30, %zmm4, %zmm31
	vpandq	%zmm30, %zmm23, %zmm6
	vpandq	%zmm30, %zmm25, %zmm7
	vpandq	%zmm30, %zmm24, %zmm12
	vpopcntq	%zmm31, %zmm31
	vpopcntq	%zmm6, %zmm6
	vpopcntq	%zmm7, %zmm7
	vpsllq	$10, %zmm31, %zmm31
	vpsllq	$10, %zmm6, %zmm6
	vpsllq	$10, %zmm7, %zmm7
	vporq	%zmm14, %zmm31, %zmm31
	vporq	%zmm15, %zmm6, %zmm6
	vporq	%zmm16, %zmm7, %zmm7
	vpmaxuq	%zmm6, %zmm31, %zmm31
	vpopcntq	%zmm12, %zmm6
	vpandq	%zmm30, %zmm28, %zmm12
	vpsllq	$10, %zmm6, %zmm6
	vporq	%zmm5, %zmm6, %zmm6
	vpmaxuq	%zmm7, %zmm6, %zmm6
	vpandq	%zmm30, %zmm26, %zmm7
	vpmaxuq	%zmm6, %zmm31, %zmm31
	vpopcntq	%zmm7, %zmm6
	vpandq	%zmm30, %zmm27, %zmm7
	vpandq	%zmm30, %zmm29, %zmm30
	vpopcntq	%zmm7, %zmm7
	vpsllq	$10, %zmm6, %zmm6
	vpopcntq	%zmm30, %zmm30
	vpsllq	$10, %zmm7, %zmm7
	vporq	%zmm8, %zmm6, %zmm6
	vpsllq	$10, %zmm30, %zmm30
	vporq	%zmm9, %zmm7, %zmm7
	vporq	%zmm11, %zmm30, %zmm30
	vpmaxuq	%zmm7, %zmm6, %zmm6
	vpopcntq	%zmm12, %zmm7
	vpsllq	$10, %zmm7, %zmm7
	vporq	%zmm10, %zmm7, %zmm7
	vpmaxuq	%zmm7, %zmm6, %zmm6
	vpmaxuq	%zmm6, %zmm31, %zmm31
	vpmaxuq	%zmm30, %zmm31, %zmm30
	vextracti64x4	$1, %zmm30, %ymm31
	vpmaxuq	%ymm31, %ymm30, %ymm30
	vextracti32x4	$1, %ymm30, %xmm31
	vpmaxuq	%xmm31, %xmm30, %xmm30
	vpshufd	$238, %xmm30, %xmm31            # xmm31 = xmm30[2,3,2,3]
	vpmaxuq	%xmm31, %xmm30, %xmm30
	vmovq	%xmm30, %r12
	movq	%r12, %rcx
	shrq	$10, %rcx
	cmpl	%ecx, %r15d
	jne	.LBB1_182
# %bb.19:                               #   in Loop: Header=BB1_15 Depth=3
	andl	$1023, %r12d                    # imm = 0x3FF
	testl	%r15d, %r15d
	setne	%cl
	xorl	%edi, %r12d
	cmpl	$1023, %r12d                    # imm = 0x3FF
	setne	%r14b
	testb	%r14b, %cl
	movl	$15, %r14d
	movl	%r13d, %ecx
	cmovnel	%edx, %r14d
	cmovnel	%r8d, %ecx
	testl	%r15d, %r15d
	je	.LBB1_22
# %bb.20:                               #   in Loop: Header=BB1_15 Depth=3
	cmpl	$1023, %r12d                    # imm = 0x3FF
	je	.LBB1_13
	jmp	.LBB1_22
.LBB1_23:                               #   in Loop: Header=BB1_10 Depth=2
	cmpl	$15, %r14d
	jne	.LBB1_181
.LBB1_24:                               #   in Loop: Header=BB1_10 Depth=2
	vmovdqu64	1552(%rsp), %zmm4
	vmovdqu64	1616(%rsp), %zmm23
	vmovdqu64	1680(%rsp), %zmm24
	vmovdqu64	1744(%rsp), %zmm25
	vmovdqu64	1808(%rsp), %zmm26
	vmovdqu64	1872(%rsp), %zmm27
	vmovdqu64	1936(%rsp), %zmm28
	vmovdqu64	2000(%rsp), %zmm29
	vmovdqu64	2064(%rsp), %zmm30
	vmovdqu64	2128(%rsp), %zmm31
	vmovdqu64	2192(%rsp), %zmm6
	vmovdqu64	2256(%rsp), %zmm7
	vmovdqu64	2320(%rsp), %zmm8
	vmovdqu64	2384(%rsp), %zmm9
	vmovdqu64	2448(%rsp), %zmm10
	vmovdqu64	2512(%rsp), %zmm11
	movq	$-1, %rsi
	movq	%rax, %r10
	jmp	.LBB1_27
.LBB1_25:                               #   in Loop: Header=BB1_27 Depth=3
	movl	%edi, %eax
	movq	1552(%rsp,%rax,8), %rax
	xorl	%r15d, %r15d
	andnq	%rsi, %rax, %rsi
.LBB1_26:                               #   in Loop: Header=BB1_27 Depth=3
	movq	%r10, %rax
	testl	%r15d, %r15d
	jne	.LBB1_35
.LBB1_27:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_29 Depth 4
	testq	%rsi, %rsi
	je	.LBB1_36
# %bb.28:                               #   in Loop: Header=BB1_27 Depth=3
	vpbroadcastq	%rsi, %zmm12
	movl	$-1, %edi
	xorl	%r14d, %r14d
	xorl	%r15d, %r15d
	.p2align	4
.LBB1_29:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        #       Parent Loop BB1_27 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	1552(%rsp,%r15,8), %rcx
	leal	1(%r15), %ebx
	leal	6(%r15), %eax
	andq	%rsi, %rcx
	popcntq	%rcx, %r12
	movq	1560(%rsp,%r15,8), %rcx
	cmpl	%r12d, %r14d
	cmoval	%r14d, %r12d
	cmovbl	%r15d, %edi
	movq	1600(%rsp,%r15,8), %r14
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r12d
	movq	1568(%rsp,%r15,8), %rcx
	cmovael	%edi, %ebx
	leal	2(%r15), %edi
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r12d
	movq	1576(%rsp,%r15,8), %rcx
	cmovael	%ebx, %edi
	leal	3(%r15), %ebx
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r12d
	movq	1584(%rsp,%r15,8), %rcx
	cmovael	%edi, %ebx
	leal	4(%r15), %edi
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r12d
	movq	1592(%rsp,%r15,8), %rcx
	cmovael	%ebx, %edi
	leal	5(%r15), %ebx
	andq	%rsi, %rcx
	popcntq	%rcx, %rcx
	cmpl	%ecx, %r12d
	cmovael	%edi, %ebx
	cmovbel	%ecx, %r12d
	andq	%rsi, %r14
	leal	7(%r15), %edi
	popcntq	%r14, %rcx
	cmpl	%ecx, %r12d
	cmovael	%ebx, %eax
	movq	1608(%rsp,%r15,8), %rbx
	cmovbel	%ecx, %r12d
	movl	%r12d, %r14d
	andq	%rsi, %rbx
	popcntq	%rbx, %rcx
	cmpl	%ecx, %r12d
	cmovbel	%ecx, %r14d
	cmovael	%eax, %edi
	addq	$8, %r15
	cmpq	$128, %r15
	jne	.LBB1_29
# %bb.30:                               #   in Loop: Header=BB1_27 Depth=3
	vpandq	%zmm12, %zmm4, %zmm13
	vpandq	%zmm12, %zmm23, %zmm16
	vmovdqa64	%zmm14, %zmm5
	vpopcntq	%zmm13, %zmm13
	vpsllq	$10, %zmm13, %zmm13
	vporq	%zmm14, %zmm13, %zmm13
	vpopcntq	%zmm16, %zmm14
	vmovdqa64	%zmm15, %zmm16
	vpsllq	$10, %zmm14, %zmm14
	vporq	%zmm15, %zmm14, %zmm14
	vpandq	%zmm12, %zmm25, %zmm15
	vpmaxuq	%zmm14, %zmm13, %zmm13
	vpandq	%zmm12, %zmm24, %zmm14
	vpopcntq	%zmm15, %zmm15
	vpopcntq	%zmm14, %zmm14
	vpsllq	$10, %zmm15, %zmm15
	vporq	.LCPI1_7(%rip), %zmm15, %zmm15
	vpsllq	$10, %zmm14, %zmm14
	vporq	.LCPI1_6(%rip), %zmm14, %zmm14
	vpmaxuq	%zmm15, %zmm14, %zmm14
	vpandq	%zmm12, %zmm27, %zmm15
	vpopcntq	%zmm15, %zmm15
	vpmaxuq	%zmm14, %zmm13, %zmm13
	vpandq	%zmm12, %zmm26, %zmm14
	vpsllq	$10, %zmm15, %zmm15
	vporq	.LCPI1_9(%rip), %zmm15, %zmm15
	vpopcntq	%zmm14, %zmm14
	vpsllq	$10, %zmm14, %zmm14
	vporq	.LCPI1_8(%rip), %zmm14, %zmm14
	vpmaxuq	%zmm15, %zmm14, %zmm14
	vpandq	%zmm12, %zmm28, %zmm15
	vpopcntq	%zmm15, %zmm15
	vpsllq	$10, %zmm15, %zmm15
	vporq	.LCPI1_10(%rip), %zmm15, %zmm15
	vpmaxuq	%zmm15, %zmm14, %zmm14
	vpandq	%zmm12, %zmm30, %zmm15
	vpopcntq	%zmm15, %zmm15
	vpmaxuq	%zmm14, %zmm13, %zmm13
	vpandq	%zmm12, %zmm29, %zmm14
	vpsllq	$10, %zmm15, %zmm15
	vporq	.LCPI1_12(%rip), %zmm15, %zmm15
	vpopcntq	%zmm14, %zmm14
	vpsllq	$10, %zmm14, %zmm14
	vporq	.LCPI1_11(%rip), %zmm14, %zmm14
	vpmaxuq	%zmm15, %zmm14, %zmm14
	vpandq	%zmm12, %zmm31, %zmm15
	vpopcntq	%zmm15, %zmm15
	vpsllq	$10, %zmm15, %zmm15
	vporq	.LCPI1_13(%rip), %zmm15, %zmm15
	vpmaxuq	%zmm15, %zmm14, %zmm14
	vpandq	%zmm12, %zmm6, %zmm15
	vpopcntq	%zmm15, %zmm15
	vpsllq	$10, %zmm15, %zmm15
	vporq	.LCPI1_14(%rip), %zmm15, %zmm15
	vpmaxuq	%zmm15, %zmm14, %zmm14
	vpandq	%zmm12, %zmm7, %zmm15
	vpmaxuq	%zmm14, %zmm13, %zmm13
	vpopcntq	%zmm15, %zmm14
	vpandq	%zmm12, %zmm8, %zmm15
	vpopcntq	%zmm15, %zmm15
	vpsllq	$10, %zmm14, %zmm14
	vporq	.LCPI1_15(%rip), %zmm14, %zmm14
	vpsllq	$10, %zmm15, %zmm15
	vporq	.LCPI1_16(%rip), %zmm15, %zmm15
	vpmaxuq	%zmm15, %zmm14, %zmm14
	vpandq	%zmm12, %zmm9, %zmm15
	vpopcntq	%zmm15, %zmm15
	vpsllq	$10, %zmm15, %zmm15
	vporq	.LCPI1_17(%rip), %zmm15, %zmm15
	vpmaxuq	%zmm15, %zmm14, %zmm14
	vpandq	%zmm12, %zmm10, %zmm15
	vpandq	%zmm12, %zmm11, %zmm12
	vpopcntq	%zmm15, %zmm15
	vpopcntq	%zmm12, %zmm12
	vpsllq	$10, %zmm15, %zmm15
	vporq	.LCPI1_18(%rip), %zmm15, %zmm15
	vpsllq	$10, %zmm12, %zmm12
	vporq	.LCPI1_19(%rip), %zmm12, %zmm12
	vpmaxuq	%zmm15, %zmm14, %zmm14
	vpmaxuq	%zmm12, %zmm14, %zmm12
	vpmaxuq	%zmm12, %zmm13, %zmm12
	vextracti64x4	$1, %zmm12, %ymm13
	vpmaxuq	%ymm13, %ymm12, %ymm12
	vextracti128	$1, %ymm12, %xmm13
	vpmaxuq	%xmm13, %xmm12, %xmm12
	vpshufd	$238, %xmm12, %xmm13            # xmm13 = xmm12[2,3,2,3]
	vpmaxuq	%xmm13, %xmm12, %xmm12
	vmovq	%xmm12, %r12
	movq	%r12, %rax
	shrq	$10, %rax
	cmpl	%eax, %r14d
	jne	.LBB1_182
# %bb.31:                               #   in Loop: Header=BB1_27 Depth=3
	andl	$1023, %r12d                    # imm = 0x3FF
	testl	%r14d, %r14d
	movl	$15, %r15d
	setne	%al
	xorl	%edi, %r12d
	cmpl	$1023, %r12d                    # imm = 0x3FF
	setne	%cl
	testb	%cl, %al
	movl	%r13d, %ecx
	cmovnel	%edx, %r15d
	cmovnel	%r8d, %ecx
	testl	%r14d, %r14d
	je	.LBB1_34
# %bb.32:                               #   in Loop: Header=BB1_27 Depth=3
	vmovdqa64	%zmm5, %zmm14
	vmovdqa64	%zmm16, %zmm15
	cmpl	$1023, %r12d                    # imm = 0x3FF
	je	.LBB1_25
# %bb.33:                               #   in Loop: Header=BB1_27 Depth=3
	movl	%ecx, %r13d
	jmp	.LBB1_26
.LBB1_34:                               #   in Loop: Header=BB1_27 Depth=3
	movl	%ecx, %r13d
	vmovdqa64	%zmm5, %zmm14
	vmovdqa64	%zmm16, %zmm15
	jmp	.LBB1_26
.LBB1_35:                               #   in Loop: Header=BB1_10 Depth=2
	cmpl	$15, %r15d
	jne	.LBB1_181
.LBB1_36:                               #   in Loop: Header=BB1_10 Depth=2
	vmovups	1680(%rsp), %zmm23
	vmovups	1744(%rsp), %zmm24
	vmovups	1616(%rsp), %zmm4
	vmovdqa64	%zmm15, %zmm5
	vmovdqu64	1552(%rsp), %zmm16
	vmovdqu64	2640(%rsp), %zmm28
	vmovdqu64	2704(%rsp), %zmm29
	vmovdqu64	2768(%rsp), %zmm30
	vmovdqu64	2832(%rsp), %zmm13
	vmovdqu64	2896(%rsp), %zmm27
	vmovdqu64	2960(%rsp), %zmm15
	vmovdqu64	3088(%rsp), %zmm31
	vmovdqu64	3152(%rsp), %zmm6
	vmovdqu64	3216(%rsp), %zmm7
	vmovdqu64	3280(%rsp), %zmm8
	vmovdqu64	3344(%rsp), %zmm9
	vmovdqu64	3408(%rsp), %zmm10
	vmovdqu64	3472(%rsp), %zmm11
	vmovdqu64	3536(%rsp), %zmm12
	movq	$-1, %rsi
	vmovaps	%zmm23, 576(%rsp)               # 64-byte Spill
	vmovups	1808(%rsp), %zmm23
	vmovaps	%zmm24, 768(%rsp)               # 64-byte Spill
	vmovups	1872(%rsp), %zmm24
	vmovaps	%zmm4, 640(%rsp)                # 64-byte Spill
	vmovdqu64	3024(%rsp), %zmm4
	vmovaps	%zmm23, 512(%rsp)               # 64-byte Spill
	vmovups	1936(%rsp), %zmm23
	vmovaps	%zmm24, 320(%rsp)               # 64-byte Spill
	vmovups	2000(%rsp), %zmm24
	vmovaps	%zmm23, 448(%rsp)               # 64-byte Spill
	vmovups	2064(%rsp), %zmm23
	vmovaps	%zmm24, 256(%rsp)               # 64-byte Spill
	vmovups	2128(%rsp), %zmm24
	vmovaps	%zmm23, 832(%rsp)               # 64-byte Spill
	vmovups	2192(%rsp), %zmm23
	vmovaps	%zmm24, 704(%rsp)               # 64-byte Spill
	vmovups	2256(%rsp), %zmm24
	vmovaps	%zmm23, 960(%rsp)               # 64-byte Spill
	vmovups	2320(%rsp), %zmm23
	vmovaps	%zmm24, 384(%rsp)               # 64-byte Spill
	vmovups	2384(%rsp), %zmm24
	vmovaps	%zmm23, 896(%rsp)               # 64-byte Spill
	vmovups	2448(%rsp), %zmm23
	vmovaps	%zmm24, 1216(%rsp)              # 64-byte Spill
	vmovdqu64	2512(%rsp), %zmm24
	vmovaps	%zmm23, 1152(%rsp)              # 64-byte Spill
	vmovdqu64	2576(%rsp), %zmm23
	vmovdqa64	%zmm24, 1088(%rsp)      # 64-byte Spill
	vmovdqa64	%zmm23, 1024(%rsp)      # 64-byte Spill
	jmp	.LBB1_39
.LBB1_46:                               #   in Loop: Header=BB1_39 Depth=3
	movl	%ecx, %r13d
	movq	%r10, %rax
	testl	%r15d, %r15d
	je	.LBB1_39
	jmp	.LBB1_47
.LBB1_37:                               #   in Loop: Header=BB1_39 Depth=3
	movl	%edi, %eax
	movq	1552(%rsp,%rax,8), %rax
	xorl	%r15d, %r15d
	andnq	%rsi, %rax, %rsi
	movq	%r10, %rax
	testl	%r15d, %r15d
	jne	.LBB1_47
.LBB1_39:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_41 Depth 4
	testq	%rsi, %rsi
	je	.LBB1_48
# %bb.40:                               #   in Loop: Header=BB1_39 Depth=3
	vpbroadcastq	%rsi, %zmm23
	movl	$-1, %edi
	xorl	%r14d, %r14d
	xorl	%r15d, %r15d
	.p2align	4
.LBB1_41:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        #       Parent Loop BB1_39 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	1552(%rsp,%r15,8), %rax
	leal	1(%r15), %ecx
	leal	6(%r15), %ebx
	andq	%rsi, %rax
	popcntq	%rax, %r12
	movq	1560(%rsp,%r15,8), %rax
	cmpl	%r12d, %r14d
	cmoval	%r14d, %r12d
	cmovbl	%r15d, %edi
	movq	1600(%rsp,%r15,8), %r14
	andq	%rsi, %rax
	popcntq	%rax, %rax
	cmpl	%eax, %r12d
	cmovbel	%eax, %r12d
	movq	1568(%rsp,%r15,8), %rax
	cmovael	%edi, %ecx
	leal	2(%r15), %edi
	andq	%rsi, %rax
	popcntq	%rax, %rax
	cmpl	%eax, %r12d
	cmovbel	%eax, %r12d
	movq	1576(%rsp,%r15,8), %rax
	cmovael	%ecx, %edi
	leal	3(%r15), %ecx
	andq	%rsi, %rax
	popcntq	%rax, %rax
	cmpl	%eax, %r12d
	cmovbel	%eax, %r12d
	movq	1584(%rsp,%r15,8), %rax
	cmovael	%edi, %ecx
	leal	4(%r15), %edi
	andq	%rsi, %rax
	popcntq	%rax, %rax
	cmpl	%eax, %r12d
	cmovbel	%eax, %r12d
	movq	1592(%rsp,%r15,8), %rax
	cmovael	%ecx, %edi
	leal	5(%r15), %ecx
	andq	%rsi, %rax
	popcntq	%rax, %rax
	cmpl	%eax, %r12d
	cmovael	%edi, %ecx
	cmovbel	%eax, %r12d
	andq	%rsi, %r14
	leal	7(%r15), %edi
	popcntq	%r14, %rax
	cmpl	%eax, %r12d
	cmovael	%ecx, %ebx
	movq	1608(%rsp,%r15,8), %rcx
	cmovbel	%eax, %r12d
	movl	%r12d, %r14d
	andq	%rsi, %rcx
	popcntq	%rcx, %rax
	cmpl	%eax, %r12d
	cmovbel	%eax, %r14d
	cmovael	%ebx, %edi
	addq	$8, %r15
	cmpq	$256, %r15                      # imm = 0x100
	jne	.LBB1_41
# %bb.42:                               #   in Loop: Header=BB1_39 Depth=3
	vpandq	640(%rsp), %zmm23, %zmm25       # 64-byte Folded Reload
	vpandq	%zmm23, %zmm16, %zmm24
	vpandq	768(%rsp), %zmm23, %zmm26       # 64-byte Folded Reload
	vpopcntq	%zmm24, %zmm24
	vpsllq	$10, %zmm24, %zmm24
	vporq	%zmm14, %zmm24, %zmm24
	vpopcntq	%zmm25, %zmm25
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm25, %zmm25
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_7(%rip), %zmm26, %zmm26
	vporq	%zmm5, %zmm25, %zmm25
	vpmaxuq	%zmm25, %zmm24, %zmm24
	vpandq	576(%rsp), %zmm23, %zmm25       # 64-byte Folded Reload
	vpopcntq	%zmm25, %zmm25
	vpsllq	$10, %zmm25, %zmm25
	vporq	.LCPI1_6(%rip), %zmm25, %zmm25
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	320(%rsp), %zmm23, %zmm26       # 64-byte Folded Reload
	vpmaxuq	%zmm25, %zmm24, %zmm24
	vpandq	512(%rsp), %zmm23, %zmm25       # 64-byte Folded Reload
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_9(%rip), %zmm26, %zmm26
	vpopcntq	%zmm25, %zmm25
	vpsllq	$10, %zmm25, %zmm25
	vporq	.LCPI1_8(%rip), %zmm25, %zmm25
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	448(%rsp), %zmm23, %zmm26       # 64-byte Folded Reload
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_10(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	832(%rsp), %zmm23, %zmm26       # 64-byte Folded Reload
	vpmaxuq	%zmm25, %zmm24, %zmm24
	vpandq	256(%rsp), %zmm23, %zmm25       # 64-byte Folded Reload
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_12(%rip), %zmm26, %zmm26
	vpopcntq	%zmm25, %zmm25
	vpsllq	$10, %zmm25, %zmm25
	vporq	.LCPI1_11(%rip), %zmm25, %zmm25
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	704(%rsp), %zmm23, %zmm26       # 64-byte Folded Reload
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_13(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	960(%rsp), %zmm23, %zmm26       # 64-byte Folded Reload
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_14(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	896(%rsp), %zmm23, %zmm26       # 64-byte Folded Reload
	vpmaxuq	%zmm25, %zmm24, %zmm24
	vpandq	384(%rsp), %zmm23, %zmm25       # 64-byte Folded Reload
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_16(%rip), %zmm26, %zmm26
	vpopcntq	%zmm25, %zmm25
	vpsllq	$10, %zmm25, %zmm25
	vporq	.LCPI1_15(%rip), %zmm25, %zmm25
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	1216(%rsp), %zmm23, %zmm26      # 64-byte Folded Reload
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_17(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	1152(%rsp), %zmm23, %zmm26      # 64-byte Folded Reload
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_18(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	1088(%rsp), %zmm23, %zmm26      # 64-byte Folded Reload
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_19(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm28, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpmaxuq	%zmm25, %zmm24, %zmm24
	vpandq	1024(%rsp), %zmm23, %zmm25      # 64-byte Folded Reload
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_21(%rip), %zmm26, %zmm26
	vpopcntq	%zmm25, %zmm25
	vpsllq	$10, %zmm25, %zmm25
	vporq	.LCPI1_20(%rip), %zmm25, %zmm25
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm29, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_22(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm30, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_23(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm13, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_24(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm27, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_25(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm4, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpmaxuq	%zmm25, %zmm24, %zmm24
	vpandq	%zmm23, %zmm15, %zmm25
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_27(%rip), %zmm26, %zmm26
	vpopcntq	%zmm25, %zmm25
	vpsllq	$10, %zmm25, %zmm25
	vporq	.LCPI1_26(%rip), %zmm25, %zmm25
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm31, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_28(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm6, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_29(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm7, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_30(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm8, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_31(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm9, %zmm26
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_32(%rip), %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	%zmm23, %zmm10, %zmm26
	vpmaxuq	%zmm25, %zmm24, %zmm24
	vpopcntq	%zmm26, %zmm25
	vpandq	%zmm23, %zmm11, %zmm26
	vpandq	%zmm23, %zmm12, %zmm23
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm25, %zmm25
	vporq	.LCPI1_33(%rip), %zmm25, %zmm25
	vpopcntq	%zmm23, %zmm23
	vpsllq	$10, %zmm26, %zmm26
	vporq	.LCPI1_34(%rip), %zmm26, %zmm26
	vpsllq	$10, %zmm23, %zmm23
	vporq	.LCPI1_35(%rip), %zmm23, %zmm23
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpmaxuq	%zmm23, %zmm25, %zmm23
	vpmaxuq	%zmm23, %zmm24, %zmm23
	vextracti64x4	$1, %zmm23, %ymm24
	vpmaxuq	%ymm24, %ymm23, %ymm23
	vextracti32x4	$1, %ymm23, %xmm24
	vpmaxuq	%xmm24, %xmm23, %xmm23
	vpshufd	$238, %xmm23, %xmm24            # xmm24 = xmm23[2,3,2,3]
	vpmaxuq	%xmm24, %xmm23, %xmm23
	vmovq	%xmm23, %r12
	movq	%r12, %rax
	shrq	$10, %rax
	cmpl	%eax, %r14d
	jne	.LBB1_182
# %bb.43:                               #   in Loop: Header=BB1_39 Depth=3
	andl	$1023, %r12d                    # imm = 0x3FF
	testl	%r14d, %r14d
	movl	$15, %r15d
	setne	%al
	xorl	%edi, %r12d
	cmpl	$1023, %r12d                    # imm = 0x3FF
	setne	%cl
	testb	%cl, %al
	movl	%r13d, %ecx
	cmovnel	%edx, %r15d
	cmovnel	%r8d, %ecx
	testl	%r14d, %r14d
	je	.LBB1_46
# %bb.44:                               #   in Loop: Header=BB1_39 Depth=3
	cmpl	$1023, %r12d                    # imm = 0x3FF
	je	.LBB1_37
	jmp	.LBB1_46
.LBB1_47:                               #   in Loop: Header=BB1_10 Depth=2
	vmovdqa64	%zmm5, %zmm15
	cmpl	$15, %r15d
	jne	.LBB1_181
	jmp	.LBB1_49
.LBB1_48:                               #   in Loop: Header=BB1_10 Depth=2
	vmovdqa64	%zmm5, %zmm15
.LBB1_49:                               #   in Loop: Header=BB1_10 Depth=2
	vmovdqa64	.LCPI1_4(%rip), %zmm27  # zmm27 = [1023,1022,1021,1020,1019,1018,1017,1016]
	vpbroadcastq	.LCPI1_36(%rip), %zmm5  # zmm5 = [18446744073709551608,18446744073709551608,18446744073709551608,18446744073709551608,18446744073709551608,18446744073709551608,18446744073709551608,18446744073709551608]
	vpbroadcastq	.LCPI1_37(%rip), %zmm16 # zmm16 = [18446744073709551600,18446744073709551600,18446744073709551600,18446744073709551600,18446744073709551600,18446744073709551600,18446744073709551600,18446744073709551600]
	vmovdqa64	.LCPI1_6(%rip), %zmm28  # zmm28 = [1007,1006,1005,1004,1003,1002,1001,1000]
	vmovdqa64	.LCPI1_7(%rip), %zmm29  # zmm29 = [999,998,997,996,995,994,993,992]
	vmovdqa64	.LCPI1_8(%rip), %zmm30  # zmm30 = [991,990,989,988,987,986,985,984]
	vmovdqa64	.LCPI1_9(%rip), %zmm31  # zmm31 = [983,982,981,980,979,978,977,976]
	vmovdqa64	.LCPI1_10(%rip), %zmm6  # zmm6 = [975,974,973,972,971,970,969,968]
	vmovdqa64	.LCPI1_11(%rip), %zmm7  # zmm7 = [967,966,965,964,963,962,961,960]
	movq	$-1, %rsi
	jmp	.LBB1_52
.LBB1_61:                               #   in Loop: Header=BB1_52 Depth=3
	movl	%ecx, %r13d
	movq	%r10, %rax
	testl	%edi, %edi
	je	.LBB1_52
	jmp	.LBB1_62
.LBB1_50:                               #   in Loop: Header=BB1_52 Depth=3
	movl	%r15d, %eax
	movq	1552(%rsp,%rax,8), %rax
	xorl	%edi, %edi
	andnq	%rsi, %rax, %rsi
	movq	%r10, %rax
	testl	%edi, %edi
	jne	.LBB1_62
.LBB1_52:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_54 Depth 4
                                        #         Child Loop BB1_56 Depth 4
	testq	%rsi, %rsi
	je	.LBB1_63
# %bb.53:                               #   in Loop: Header=BB1_52 Depth=3
	vpbroadcastq	%rsi, %zmm23
	movq	$-8, %rdi
	vpxor	%xmm4, %xmm4, %xmm4
	vmovdqa64	%zmm27, %zmm24
	.p2align	4
.LBB1_54:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        #       Parent Loop BB1_52 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	vpandq	1616(%rsp,%rdi,8), %zmm23, %zmm25
	vpandq	1680(%rsp,%rdi,8), %zmm23, %zmm8
	vpandq	1744(%rsp,%rdi,8), %zmm23, %zmm26
	vpopcntq	%zmm25, %zmm25
	vpsllq	$10, %zmm25, %zmm25
	vpaddq	%zmm24, %zmm25, %zmm25
	vpmaxuq	%zmm25, %zmm4, %zmm4
	vpopcntq	%zmm8, %zmm25
	vpandq	1872(%rsp,%rdi,8), %zmm23, %zmm8
	vpsllq	$10, %zmm25, %zmm25
	vpaddq	%zmm25, %zmm24, %zmm25
	vpaddq	%zmm5, %zmm25, %zmm25
	vpmaxuq	%zmm25, %zmm4, %zmm4
	vpopcntq	%zmm26, %zmm25
	vpandq	1808(%rsp,%rdi,8), %zmm23, %zmm26
	vpsllq	$10, %zmm25, %zmm25
	vpaddq	%zmm25, %zmm24, %zmm25
	vpaddq	%zmm16, %zmm25, %zmm25
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vpaddq	%zmm26, %zmm24, %zmm26
	vpaddq	%zmm17, %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	1936(%rsp,%rdi,8), %zmm23, %zmm26
	vpmaxuq	%zmm25, %zmm4, %zmm4
	vpopcntq	%zmm8, %zmm25
	vpandq	2000(%rsp,%rdi,8), %zmm23, %zmm8
	vpsllq	$10, %zmm25, %zmm25
	vpaddq	%zmm25, %zmm24, %zmm25
	vpaddq	%zmm18, %zmm25, %zmm25
	vpopcntq	%zmm26, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vpaddq	%zmm26, %zmm24, %zmm26
	vpaddq	%zmm19, %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpopcntq	%zmm8, %zmm26
	vpsllq	$10, %zmm26, %zmm26
	vpaddq	%zmm26, %zmm24, %zmm26
	vpaddq	%zmm20, %zmm26, %zmm26
	vpmaxuq	%zmm26, %zmm25, %zmm25
	vpandq	2064(%rsp,%rdi,8), %zmm23, %zmm26
	addq	$64, %rdi
	vpmaxuq	%zmm25, %zmm4, %zmm4
	vpopcntq	%zmm26, %zmm25
	vpsllq	$10, %zmm25, %zmm25
	vpaddq	%zmm25, %zmm24, %zmm25
	vpaddq	%zmm22, %zmm24, %zmm24
	vpaddq	%zmm21, %zmm25, %zmm25
	vpmaxuq	%zmm25, %zmm4, %zmm4
	cmpq	$504, %rdi                      # imm = 0x1F8
	jb	.LBB1_54
# %bb.55:                               #   in Loop: Header=BB1_52 Depth=3
	movl	$-1, %r15d
	xorl	%r12d, %r12d
	xorl	%edi, %edi
	.p2align	4
.LBB1_56:                               #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_10 Depth=2
                                        #       Parent Loop BB1_52 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	1552(%rsp,%rdi,8), %rax
	leal	1(%rdi), %ecx
	leal	2(%rdi), %ebx
	andq	%rsi, %rax
	popcntq	%rax, %r14
	movq	1560(%rsp,%rdi,8), %rax
	cmpl	%r14d, %r12d
	cmoval	%r12d, %r14d
	cmovbl	%edi, %r15d
	movq	1600(%rsp,%rdi,8), %r12
	andq	%rsi, %rax
	popcntq	%rax, %rax
	cmpl	%eax, %r14d
	cmovbel	%eax, %r14d
	movq	1568(%rsp,%rdi,8), %rax
	cmovael	%r15d, %ecx
	leal	7(%rdi), %r15d
	andq	%rsi, %rax
	popcntq	%rax, %rax
	cmpl	%eax, %r14d
	cmovbel	%eax, %r14d
	movq	1576(%rsp,%rdi,8), %rax
	cmovael	%ecx, %ebx
	leal	3(%rdi), %ecx
	andq	%rsi, %rax
	popcntq	%rax, %rax
	cmpl	%eax, %r14d
	cmovbel	%eax, %r14d
	movq	1584(%rsp,%rdi,8), %rax
	cmovael	%ebx, %ecx
	leal	4(%rdi), %ebx
	andq	%rsi, %rax
	popcntq	%rax, %rax
	cmpl	%eax, %r14d
	cmovbel	%eax, %r14d
	movq	1592(%rsp,%rdi,8), %rax
	cmovael	%ecx, %ebx
	leal	5(%rdi), %ecx
	andq	%rsi, %rax
	popcntq	%rax, %rax
	cmpl	%eax, %r14d
	cmovael	%ebx, %ecx
	cmovbel	%eax, %r14d
	andq	%rsi, %r12
	leal	6(%rdi), %ebx
	popcntq	%r12, %rax
	cmpl	%eax, %r14d
	cmovael	%ecx, %ebx
	movq	1608(%rsp,%rdi,8), %rcx
	cmovbel	%eax, %r14d
	movl	%r14d, %r12d
	andq	%rsi, %rcx
	popcntq	%rcx, %rax
	cmpl	%eax, %r14d
	cmovbel	%eax, %r12d
	cmovael	%ebx, %r15d
	addq	$8, %rdi
	cmpq	$512, %rdi                      # imm = 0x200
	jne	.LBB1_56
# %bb.57:                               #   in Loop: Header=BB1_52 Depth=3
	vextracti64x4	$1, %zmm4, %ymm23
	vpmaxuq	%ymm23, %ymm4, %ymm4
	vextracti32x4	$1, %ymm4, %xmm23
	vpmaxuq	%xmm23, %xmm4, %xmm4
	vpshufd	$238, %xmm4, %xmm23             # xmm23 = xmm4[2,3,2,3]
	vpmaxuq	%xmm23, %xmm4, %xmm4
	vmovq	%xmm4, %r14
	movq	%r14, %rax
	shrq	$10, %rax
	cmpl	%eax, %r12d
	jne	.LBB1_182
# %bb.58:                               #   in Loop: Header=BB1_52 Depth=3
	andl	$1023, %r14d                    # imm = 0x3FF
	testl	%r12d, %r12d
	movl	$15, %edi
	setne	%al
	xorl	%r15d, %r14d
	cmpl	$1023, %r14d                    # imm = 0x3FF
	setne	%cl
	testb	%cl, %al
	movl	%r13d, %ecx
	cmovnel	%edx, %edi
	cmovnel	%r8d, %ecx
	testl	%r12d, %r12d
	je	.LBB1_61
# %bb.59:                               #   in Loop: Header=BB1_52 Depth=3
	cmpl	$1023, %r14d                    # imm = 0x3FF
	je	.LBB1_50
	jmp	.LBB1_61
.LBB1_62:                               #   in Loop: Header=BB1_10 Depth=2
	cmpl	$15, %edi
	jne	.LBB1_181
.LBB1_63:                               #   in Loop: Header=BB1_10 Depth=2
	movq	216(%rsp), %rsi                 # 8-byte Reload
	movq	208(%rsp), %rdi                 # 8-byte Reload
	movq	200(%rsp), %r10                 # 8-byte Reload
	incq	%rax
	vmovdqa64	%zmm28, %zmm5
	vmovdqa64	%zmm29, %zmm16
	vmovdqa64	%zmm30, %zmm8
	vmovdqa64	%zmm31, %zmm9
	vmovdqa64	%zmm6, %zmm10
	vmovdqa64	%zmm7, %zmm11
	cmpq	%rsi, %rax
	jne	.LBB1_10
.LBB1_64:                               #   in Loop: Header=BB1_8 Depth=1
	incq	%r10
	addq	%rdi, %r9
	cmpq	144(%rsp), %r10                 # 8-byte Folded Reload
	jne	.LBB1_8
.LBB1_65:
	movq	$0, 176(%rsp)
	movabsq	$-3689348814741910323, %rax     # imm = 0xCCCCCCCCCCCCCCCD
	leaq	.str.8(%rip), %rcx
	movq	144(%rsp), %rdx                 # 8-byte Reload
	mulxq	%rax, %rdx, %rdx
	movq	232(%rsp), %r13
	shrq	$2, %rdx
	imulq	%r13, %rdx
	shlq	$2, %rdx
	vzeroupper
	callq	printf
	movq	152(%rsp), %rax                 # 8-byte Reload
	vmovsd	.LCPI1_44(%rip), %xmm6          # xmm6 = [9.9999999999999995E-8,0.0E+0]
	movq	136(%rsp), %rcx                 # 8-byte Reload
	movb	$58, %r12b
	movq	$0, 384(%rsp)                   # 8-byte Folded Spill
	movq	%r13, 512(%rsp)                 # 8-byte Spill
	leaq	(,%rax,8), %rax
	movq	%rax, 704(%rsp)                 # 8-byte Spill
	leaq	24(%rcx), %rax
	movq	%rax, 896(%rsp)                 # 8-byte Spill
	jmp	.LBB1_67
	.p2align	4
.LBB1_66:                               #   in Loop: Header=BB1_67 Depth=1
	leaq	.str.13(%rip), %rcx
	callq	printf
	movq	384(%rsp), %rcx                 # 8-byte Reload
	movq	512(%rsp), %r13                 # 8-byte Reload
	incq	%rcx
	movq	%rcx, 384(%rsp)                 # 8-byte Spill
	cmpq	$5, %rcx
	je	.LBB1_180
.LBB1_67:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_132 Depth 2
                                        #       Child Loop BB1_134 Depth 3
                                        #         Child Loop BB1_137 Depth 4
                                        #           Child Loop BB1_138 Depth 5
                                        #           Child Loop BB1_164 Depth 5
                                        #           Child Loop BB1_143 Depth 5
                                        #             Child Loop BB1_144 Depth 6
                                        #             Child Loop BB1_158 Depth 6
                                        #             Child Loop BB1_154 Depth 6
                                        #     Child Loop BB1_73 Depth 2
                                        #       Child Loop BB1_76 Depth 3
                                        #         Child Loop BB1_80 Depth 4
                                        #           Child Loop BB1_81 Depth 5
                                        #       Child Loop BB1_101 Depth 3
                                        #         Child Loop BB1_105 Depth 4
                                        #           Child Loop BB1_106 Depth 5
                                        #     Child Loop BB1_176 Depth 2
	vpxor	%xmm0, %xmm0, %xmm0
	vmovdqu64	%zmm0, 1472(%rsp)
	vmovdqu64	%zmm0, 1408(%rsp)
	vmovdqu64	%zmm0, 1344(%rsp)
	vmovdqu64	%zmm0, 1280(%rsp)
	movl	$0, 1536(%rsp)
	vzeroupper
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	160(%rsp), %rcx
	leaq	1552(%rsp), %rdi
	leaq	192(%rsp), %rbx
	leaq	184(%rsp), %r9
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rdi, %rdx
	movq	%rbx, %r8
	callq	*__imp_GetProcessTimes(%rip)
	movl	164(%rsp), %eax
	movl	160(%rsp), %esi
	movq	%rdi, %rcx
	shlq	$32, %rax
	addq	184(%rsp), %rax
	addq	%rax, %rsi
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%rbx, %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	vxorps	%xmm13, %xmm13, %xmm13
	vcvtusi2sd	%rsi, %xmm13, %xmm0
	cmpq	$0, 144(%rsp)                   # 8-byte Folded Reload
	vpxor	%xmm2, %xmm2, %xmm2
	vmulsd	%xmm6, %xmm0, %xmm7
	vxorps	%xmm13, %xmm13, %xmm13
	vcvtsi2sdq	1552(%rsp), %xmm13, %xmm0
	vxorps	%xmm13, %xmm13, %xmm13
	vcvtsi2sdq	192(%rsp), %xmm13, %xmm1
	je	.LBB1_129
# %bb.68:                               #   in Loop: Header=BB1_67 Depth=1
	testq	%r13, %r13
	je	.LBB1_129
# %bb.69:                               #   in Loop: Header=BB1_67 Depth=1
	cmpq	$4, 384(%rsp)                   # 8-byte Folded Reload
	jne	.LBB1_130
# %bb.70:                               #   in Loop: Header=BB1_67 Depth=1
	xorl	%r11d, %r11d
	xorl	%edx, %edx
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
	jmp	.LBB1_73
	.p2align	4
.LBB1_71:                               #   in Loop: Header=BB1_73 Depth=2
	movq	320(%rsp), %r11                 # 8-byte Reload
	movq	448(%rsp), %r8                  # 8-byte Reload
.LBB1_72:                               #   in Loop: Header=BB1_73 Depth=2
	movl	576(%rsp), %edx                 # 4-byte Reload
	incl	%edx
	cmpl	$100, %edx
	je	.LBB1_172
.LBB1_73:                               #   Parent Loop BB1_67 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_76 Depth 3
                                        #         Child Loop BB1_80 Depth 4
                                        #           Child Loop BB1_81 Depth 5
                                        #       Child Loop BB1_101 Depth 3
                                        #         Child Loop BB1_105 Depth 4
                                        #           Child Loop BB1_106 Depth 5
	movl	%edx, 576(%rsp)                 # 4-byte Spill
	testl	%edx, %edx
	je	.LBB1_98
# %bb.74:                               #   in Loop: Header=BB1_73 Depth=2
	movq	896(%rsp), %rdx                 # 8-byte Reload
	movq	%r8, 448(%rsp)                  # 8-byte Spill
	xorl	%r8d, %r8d
	movq	%r11, 320(%rsp)                 # 8-byte Spill
	jmp	.LBB1_76
	.p2align	4
.LBB1_75:                               #   in Loop: Header=BB1_76 Depth=3
	addq	704(%rsp), %rdx                 # 8-byte Folded Reload
	incq	%r8
	cmpq	144(%rsp), %r8                  # 8-byte Folded Reload
	je	.LBB1_71
.LBB1_76:                               #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_73 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_80 Depth 4
                                        #           Child Loop BB1_81 Depth 5
	movabsq	$-3689348814741910323, %r10     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%r8, %r9
	imulq	%r10, %r9
	movabsq	$3689348814741910324, %r10      # imm = 0x3333333333333334
	cmpq	%r10, %r9
	jb	.LBB1_75
# %bb.77:                               #   in Loop: Header=BB1_76 Depth=3
	movq	%r8, %r9
	imulq	152(%rsp), %r9                  # 8-byte Folded Reload
	movq	136(%rsp), %r10                 # 8-byte Reload
	leaq	(%r10,%r9,8), %r9
	movq	168(%rsp), %r10                 # 8-byte Reload
	leaq	(%r9,%r10,8), %r9
	xorl	%r10d, %r10d
	jmp	.LBB1_80
.LBB1_78:                               #   in Loop: Header=BB1_80 Depth=4
	movl	$999, %r11d                     # imm = 0x3E7
	.p2align	4
.LBB1_79:                               #   in Loop: Header=BB1_80 Depth=4
	movl	%r11d, %r11d
	addq	%r11, 176(%rsp)
	incq	%r10
	cmpq	%r13, %r10
	je	.LBB1_75
.LBB1_80:                               #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_73 Depth=2
                                        #       Parent Loop BB1_76 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_81 Depth 5
	movq	$-1, %rdi
	xorl	%r11d, %r11d
	xorl	%esi, %esi
	.p2align	4
.LBB1_81:                               #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_73 Depth=2
                                        #       Parent Loop BB1_76 Depth=3
                                        #         Parent Loop BB1_80 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	-24(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_83
# %bb.82:                               #   in Loop: Header=BB1_81 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_84
	.p2align	4
.LBB1_83:                               #   in Loop: Header=BB1_81 Depth=5
	xorl	%r15d, %r15d
.LBB1_84:                               #   in Loop: Header=BB1_81 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_79
# %bb.85:                               #   in Loop: Header=BB1_81 Depth=5
	movq	-16(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_87
# %bb.86:                               #   in Loop: Header=BB1_81 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_88
	.p2align	4
.LBB1_87:                               #   in Loop: Header=BB1_81 Depth=5
	xorl	%r15d, %r15d
.LBB1_88:                               #   in Loop: Header=BB1_81 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_79
# %bb.89:                               #   in Loop: Header=BB1_81 Depth=5
	movq	-8(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_91
# %bb.90:                               #   in Loop: Header=BB1_81 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_92
	.p2align	4
.LBB1_91:                               #   in Loop: Header=BB1_81 Depth=5
	xorl	%r15d, %r15d
.LBB1_92:                               #   in Loop: Header=BB1_81 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_79
# %bb.93:                               #   in Loop: Header=BB1_81 Depth=5
	movq	(%rdx,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_95
# %bb.94:                               #   in Loop: Header=BB1_81 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_96
	.p2align	4
.LBB1_95:                               #   in Loop: Header=BB1_81 Depth=5
	xorl	%r15d, %r15d
.LBB1_96:                               #   in Loop: Header=BB1_81 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %r11d
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_79
# %bb.97:                               #   in Loop: Header=BB1_81 Depth=5
	addq	$4, %rsi
	cmpq	$512, %rsi                      # imm = 0x200
	jne	.LBB1_81
	jmp	.LBB1_78
	.p2align	4
.LBB1_98:                               #   in Loop: Header=BB1_73 Depth=2
	movq	136(%rsp), %rdx                 # 8-byte Reload
	xorl	%esi, %esi
	jmp	.LBB1_101
	.p2align	4
.LBB1_99:                               #   in Loop: Header=BB1_101 Depth=3
	movq	320(%rsp), %r11                 # 8-byte Reload
	movq	640(%rsp), %rsi                 # 8-byte Reload
	addq	%r13, %r11
.LBB1_100:                              #   in Loop: Header=BB1_101 Depth=3
	addq	704(%rsp), %rdx                 # 8-byte Folded Reload
	incq	%rsi
	cmpq	144(%rsp), %rsi                 # 8-byte Folded Reload
	je	.LBB1_72
.LBB1_101:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_73 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_105 Depth 4
                                        #           Child Loop BB1_106 Depth 5
	movabsq	$-3689348814741910323, %r10     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%rsi, %r9
	imulq	%r10, %r9
	movabsq	$3689348814741910324, %r10      # imm = 0x3333333333333334
	cmpq	%r10, %r9
	jb	.LBB1_100
# %bb.102:                              #   in Loop: Header=BB1_101 Depth=3
	movq	%rsi, %r9
	imulq	152(%rsp), %r9                  # 8-byte Folded Reload
	movq	136(%rsp), %r10                 # 8-byte Reload
	movq	%r11, 320(%rsp)                 # 8-byte Spill
	movq	%rsi, 640(%rsp)                 # 8-byte Spill
	leaq	(%r10,%r9,8), %r9
	movq	168(%rsp), %r10                 # 8-byte Reload
	leaq	(%r9,%r10,8), %r9
	xorl	%r10d, %r10d
	jmp	.LBB1_105
	.p2align	4
.LBB1_103:                              #   in Loop: Header=BB1_105 Depth=4
	incl	1280(%rsp,%rdi,4)
.LBB1_104:                              #   in Loop: Header=BB1_105 Depth=4
	movl	%r11d, %r11d
	addq	%rdi, %r8
	addq	%r11, %rax
	incq	%r10
	cmpq	%r13, %r10
	je	.LBB1_99
.LBB1_105:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_73 Depth=2
                                        #       Parent Loop BB1_101 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_106 Depth 5
	movq	$-1, %rdi
	movl	$4, %r11d
	xorl	%esi, %esi
	.p2align	4
.LBB1_106:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_73 Depth=2
                                        #       Parent Loop BB1_101 Depth=3
                                        #         Parent Loop BB1_105 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	-32(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_108
# %bb.107:                              #   in Loop: Header=BB1_106 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_109
	.p2align	4
.LBB1_108:                              #   in Loop: Header=BB1_106 Depth=5
	xorl	%r15d, %r15d
.LBB1_109:                              #   in Loop: Header=BB1_106 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_124
# %bb.110:                              #   in Loop: Header=BB1_106 Depth=5
	movq	-24(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_112
# %bb.111:                              #   in Loop: Header=BB1_106 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_113
	.p2align	4
.LBB1_112:                              #   in Loop: Header=BB1_106 Depth=5
	xorl	%r15d, %r15d
.LBB1_113:                              #   in Loop: Header=BB1_106 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_125
# %bb.114:                              #   in Loop: Header=BB1_106 Depth=5
	movq	-16(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_116
# %bb.115:                              #   in Loop: Header=BB1_106 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_117
	.p2align	4
.LBB1_116:                              #   in Loop: Header=BB1_106 Depth=5
	xorl	%r15d, %r15d
.LBB1_117:                              #   in Loop: Header=BB1_106 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_128
# %bb.118:                              #   in Loop: Header=BB1_106 Depth=5
	movq	-8(%rdx,%r11,8), %rbx
	movq	%rbx, %r14
	shrq	$6, %r14
	movl	%ebx, %r15d
	addq	%r10, %r14
	bzhiq	%r12, %r14, %r14
	andl	$63, %r15d
	je	.LBB1_120
# %bb.119:                              #   in Loop: Header=BB1_106 Depth=5
	negb	%r15b
	shlxq	%r15, 8(%r9,%r14,8), %r15
	jmp	.LBB1_121
	.p2align	4
.LBB1_120:                              #   in Loop: Header=BB1_106 Depth=5
	xorl	%r15d, %r15d
.LBB1_121:                              #   in Loop: Header=BB1_106 Depth=5
	shrxq	%rbx, (%r9,%r14,8), %rbx
	orq	%r15, %rbx
	xorl	%r15d, %r15d
	andnq	%rdi, %rbx, %r14
	cmpq	%rdi, %r14
	setne	%r15b
	addl	%r15d, %esi
	andnq	%rdi, %rbx, %rdi
	je	.LBB1_126
# %bb.122:                              #   in Loop: Header=BB1_106 Depth=5
	addq	$4, %r11
	cmpq	$516, %r11                      # imm = 0x204
	jne	.LBB1_106
# %bb.123:                              #   in Loop: Header=BB1_105 Depth=4
	movl	$512, %r11d                     # imm = 0x200
	movl	$999, %esi                      # imm = 0x3E7
	movl	%esi, %edi
	addq	%rdi, 176(%rsp)
	cmpl	$65, %esi
	jb	.LBB1_103
	jmp	.LBB1_127
	.p2align	4
.LBB1_124:                              #   in Loop: Header=BB1_105 Depth=4
	addq	$-3, %r11
	movl	%esi, %edi
	addq	%rdi, 176(%rsp)
	cmpl	$65, %esi
	jae	.LBB1_127
	jmp	.LBB1_103
	.p2align	4
.LBB1_125:                              #   in Loop: Header=BB1_105 Depth=4
	addq	$-2, %r11
.LBB1_126:                              #   in Loop: Header=BB1_105 Depth=4
	movl	%esi, %edi
	addq	%rdi, 176(%rsp)
	cmpl	$65, %esi
	jb	.LBB1_103
.LBB1_127:                              #   in Loop: Header=BB1_105 Depth=4
	incl	%ecx
	jmp	.LBB1_104
.LBB1_128:                              #   in Loop: Header=BB1_105 Depth=4
	decq	%r11
	movl	%esi, %edi
	addq	%rdi, 176(%rsp)
	cmpl	$65, %esi
	jb	.LBB1_103
	jmp	.LBB1_127
	.p2align	4
.LBB1_129:                              #   in Loop: Header=BB1_67 Depth=1
	movq	$0, 256(%rsp)                   # 8-byte Folded Spill
	xorl	%r13d, %r13d
	xorl	%r15d, %r15d
	xorl	%r14d, %r14d
	vpxor	%xmm3, %xmm3, %xmm3
	jmp	.LBB1_174
.LBB1_130:                              #   in Loop: Header=BB1_67 Depth=1
	vpbroadcastd	.LCPI1_0(%rip), %ymm19  # ymm19 = [63,63,63,63,63,63,63,63]
	vpbroadcastq	.LCPI1_1(%rip), %zmm20  # zmm20 = [288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743,288230376151711743]
	vpbroadcastd	.LCPI1_2(%rip), %ymm21  # ymm21 = [64,64,64,64,64,64,64,64]
	vpbroadcastq	.LCPI1_3(%rip), %zmm22  # zmm22 = [63,63,63,63,63,63,63,63]
	vmovdqa64	.LCPI1_4(%rip), %zmm23  # zmm23 = [1023,1022,1021,1020,1019,1018,1017,1016]
	vpbroadcastq	.LCPI1_36(%rip), %zmm24 # zmm24 = [18446744073709551608,18446744073709551608,18446744073709551608,18446744073709551608,18446744073709551608,18446744073709551608,18446744073709551608,18446744073709551608]
	xorl	%r14d, %r14d
	movl	$0, 768(%rsp)                   # 4-byte Folded Spill
	movq	$0, 832(%rsp)                   # 8-byte Folded Spill
	movq	$0, 320(%rsp)                   # 8-byte Folded Spill
	movq	$0, 448(%rsp)                   # 8-byte Folded Spill
	movq	$0, 256(%rsp)                   # 8-byte Folded Spill
	jmp	.LBB1_132
	.p2align	4
.LBB1_131:                              #   in Loop: Header=BB1_132 Depth=2
	movl	768(%rsp), %eax                 # 4-byte Reload
	incl	%eax
	movl	%eax, 768(%rsp)                 # 4-byte Spill
	cmpl	$100, %eax
	je	.LBB1_173
.LBB1_132:                              #   Parent Loop BB1_67 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_134 Depth 3
                                        #         Child Loop BB1_137 Depth 4
                                        #           Child Loop BB1_138 Depth 5
                                        #           Child Loop BB1_164 Depth 5
                                        #           Child Loop BB1_143 Depth 5
                                        #             Child Loop BB1_144 Depth 6
                                        #             Child Loop BB1_158 Depth 6
                                        #             Child Loop BB1_154 Depth 6
	movq	136(%rsp), %rdx                 # 8-byte Reload
	xorl	%r9d, %r9d
	jmp	.LBB1_134
	.p2align	4
.LBB1_133:                              #   in Loop: Header=BB1_134 Depth=3
	movq	960(%rsp), %r9                  # 8-byte Reload
	addq	704(%rsp), %rdx                 # 8-byte Folded Reload
	incq	%r9
	cmpq	144(%rsp), %r9                  # 8-byte Folded Reload
	je	.LBB1_131
.LBB1_134:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_132 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_137 Depth 4
                                        #           Child Loop BB1_138 Depth 5
                                        #           Child Loop BB1_164 Depth 5
                                        #           Child Loop BB1_143 Depth 5
                                        #             Child Loop BB1_144 Depth 6
                                        #             Child Loop BB1_158 Depth 6
                                        #             Child Loop BB1_154 Depth 6
	movabsq	$-3689348814741910323, %rcx     # imm = 0xCCCCCCCCCCCCCCCD
	movq	%r9, %rax
	movq	%r9, 960(%rsp)                  # 8-byte Spill
	imulq	%rcx, %rax
	movabsq	$3689348814741910324, %rcx      # imm = 0x3333333333333334
	cmpq	%rcx, %rax
	jb	.LBB1_133
# %bb.135:                              #   in Loop: Header=BB1_134 Depth=3
	movq	%r9, %rax
	imulq	152(%rsp), %rax                 # 8-byte Folded Reload
	movq	136(%rsp), %rcx                 # 8-byte Reload
	xorl	%r15d, %r15d
	leaq	(%rcx,%rax,8), %rax
	movq	168(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rax,%rcx,8), %r9
	movq	384(%rsp), %rax                 # 8-byte Reload
	leaq	__const.main.pools(%rip), %rcx
	movl	(%rcx,%rax,4), %esi
	movl	%esi, %r11d
	andl	$-8, %r11d
	movq	%rsi, 576(%rsp)                 # 8-byte Spill
	jmp	.LBB1_137
	.p2align	4
.LBB1_136:                              #   in Loop: Header=BB1_137 Depth=4
	movq	512(%rsp), %rax                 # 8-byte Reload
	movq	640(%rsp), %r14                 # 8-byte Reload
	movq	576(%rsp), %rsi                 # 8-byte Reload
	incq	%r15
	cmpq	%rax, %r15
	je	.LBB1_133
.LBB1_137:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_132 Depth=2
                                        #       Parent Loop BB1_134 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_138 Depth 5
                                        #           Child Loop BB1_164 Depth 5
                                        #           Child Loop BB1_143 Depth 5
                                        #             Child Loop BB1_144 Depth 6
                                        #             Child Loop BB1_158 Depth 6
                                        #             Child Loop BB1_154 Depth 6
	vpbroadcastq	%r15, %zmm3
	xorl	%ecx, %ecx
	movq	%r14, 640(%rsp)                 # 8-byte Spill
	.p2align	4
.LBB1_138:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_132 Depth=2
                                        #       Parent Loop BB1_134 Depth=3
                                        #         Parent Loop BB1_137 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	vmovdqu64	(%rdx,%rcx,8), %zmm4
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
	vmovdqu64	%zmm4, 1552(%rsp,%rcx,8)
	addq	$8, %rcx
	cmpq	%rcx, %r11
	jne	.LBB1_138
# %bb.139:                              #   in Loop: Header=BB1_137 Depth=4
	cmpl	%esi, %r11d
	jne	.LBB1_161
.LBB1_140:                              #   in Loop: Header=BB1_137 Depth=4
	movq	%rsi, %r10
	movq	$-1, %rsi
	xorl	%r8d, %r8d
	xorl	%ebx, %ebx
	xorl	%r13d, %r13d
	xorl	%r14d, %r14d
                                        # kill: def $r10d killed $r10d killed $r10 def $r10
	jmp	.LBB1_143
	.p2align	4
.LBB1_141:                              #   in Loop: Header=BB1_143 Depth=5
	notl	%eax
	incl	%r8d
	addl	%r14d, %r13d
	andl	$1023, %eax                     # imm = 0x3FF
	movq	1552(%rsp,%rax,8), %rax
	andnq	%rsi, %rax, %rsi
.LBB1_142:                              #   in Loop: Header=BB1_143 Depth=5
	testq	%rsi, %rsi
	je	.LBB1_167
.LBB1_143:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_132 Depth=2
                                        #       Parent Loop BB1_134 Depth=3
                                        #         Parent Loop BB1_137 Depth=4
                                        # =>        This Loop Header: Depth=5
                                        #             Child Loop BB1_144 Depth 6
                                        #             Child Loop BB1_158 Depth 6
                                        #             Child Loop BB1_154 Depth 6
	vpbroadcastq	%rsi, %zmm5
	movl	%r10d, %ecx
	vpxor	%xmm4, %xmm4, %xmm4
	xorl	%eax, %eax
	vmovdqa64	%zmm23, %zmm16
	.p2align	4
.LBB1_144:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_132 Depth=2
                                        #       Parent Loop BB1_134 Depth=3
                                        #         Parent Loop BB1_137 Depth=4
                                        #           Parent Loop BB1_143 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	vpandq	1552(%rsp,%rax,8), %zmm5, %zmm17
	addq	$8, %rax
	vpopcntq	%zmm17, %zmm17
	vpsllq	$10, %zmm17, %zmm17
	vpaddq	%zmm16, %zmm17, %zmm17
	vpaddq	%zmm24, %zmm16, %zmm16
	vpmaxuq	%zmm17, %zmm4, %zmm4
	cmpq	%rcx, %rax
	jb	.LBB1_144
# %bb.145:                              #   in Loop: Header=BB1_143 Depth=5
	vextracti64x4	$1, %zmm4, %ymm5
	vpmaxuq	%ymm5, %ymm4, %ymm4
	vextracti128	$1, %ymm4, %xmm5
	vpmaxuq	%xmm5, %xmm4, %xmm4
	vpshufd	$238, %xmm4, %xmm5              # xmm5 = xmm4[2,3,2,3]
	vpmaxuq	%xmm5, %xmm4, %xmm4
	vmovq	%xmm4, %rax
	movq	%rax, %rdi
	shrq	$10, %rdi
	testl	%edi, %edi
	jne	.LBB1_141
# %bb.146:                              #   in Loop: Header=BB1_143 Depth=5
	cmpl	$512, %r10d                     # imm = 0x200
	je	.LBB1_166
# %bb.147:                              #   in Loop: Header=BB1_143 Depth=5
	movl	$1, %ebx
	jae	.LBB1_156
# %bb.148:                              #   in Loop: Header=BB1_143 Depth=5
	leal	1(%r10), %eax
	movl	$513, %ebx                      # imm = 0x201
	subq	%rax, %rbx
	cmpq	$8, %rbx
	jb	.LBB1_150
# %bb.149:                              #   in Loop: Header=BB1_143 Depth=5
	movl	$512, %edi                      # imm = 0x200
	subq	%rax, %rdi
	movl	$-2, %eax
	subl	%r10d, %eax
	cmpl	%edi, %eax
	setb	%al
	shrq	$32, %rdi
	setne	%r10b
	orb	%al, %r10b
	je	.LBB1_157
.LBB1_150:                              #   in Loop: Header=BB1_143 Depth=5
	movq	%rcx, %r10
.LBB1_151:                              #   in Loop: Header=BB1_143 Depth=5
	incq	%r10
	movl	$1, %ebx
	jmp	.LBB1_154
	.p2align	4
.LBB1_152:                              #   in Loop: Header=BB1_154 Depth=6
	negb	%dil
	shlxq	%rdi, 8(%r9,%rcx,8), %rdi
.LBB1_153:                              #   in Loop: Header=BB1_154 Depth=6
	shrxq	%rax, (%r9,%rcx,8), %rax
	orq	%rdi, %rax
	movq	%rax, 1544(%rsp,%r10,8)
	movl	%r10d, %eax
	incq	%r10
	cmpl	$512, %eax                      # imm = 0x200
	je	.LBB1_156
.LBB1_154:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_132 Depth=2
                                        #       Parent Loop BB1_134 Depth=3
                                        #         Parent Loop BB1_137 Depth=4
                                        #           Parent Loop BB1_143 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	movq	-8(%rdx,%r10,8), %rax
	movq	%rax, %rcx
	shrq	$6, %rcx
	movl	%eax, %edi
	addq	%r15, %rcx
	bzhiq	%r12, %rcx, %rcx
	andl	$63, %edi
	jne	.LBB1_152
# %bb.155:                              #   in Loop: Header=BB1_154 Depth=6
	xorl	%edi, %edi
	jmp	.LBB1_153
	.p2align	4
.LBB1_156:                              #   in Loop: Header=BB1_143 Depth=5
	movl	$1, %r14d
	movl	$512, %r10d                     # imm = 0x200
	jmp	.LBB1_142
.LBB1_157:                              #   in Loop: Header=BB1_143 Depth=5
	movq	%rbx, %r14
	andq	$-8, %r14
	leaq	1552(%rsp,%rcx,8), %rdi
	xorl	%eax, %eax
	leaq	(%r14,%rcx), %r10
	leaq	(%rdx,%rcx,8), %rcx
	.p2align	4
.LBB1_158:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_132 Depth=2
                                        #       Parent Loop BB1_134 Depth=3
                                        #         Parent Loop BB1_137 Depth=4
                                        #           Parent Loop BB1_143 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	vmovdqu64	(%rcx,%rax,8), %zmm4
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
	vmovdqu64	%zmm4, (%rdi,%rax,8)
	addq	$8, %rax
	cmpq	%rax, %r14
	jne	.LBB1_158
# %bb.159:                              #   in Loop: Header=BB1_143 Depth=5
	cmpq	%r14, %rbx
	jne	.LBB1_151
# %bb.160:                              #   in Loop: Header=BB1_143 Depth=5
	movl	$1, %r14d
	movl	$512, %r10d                     # imm = 0x200
	movl	$1, %ebx
	jmp	.LBB1_142
	.p2align	4
.LBB1_161:                              #   in Loop: Header=BB1_137 Depth=4
	movq	%r11, %rcx
	jmp	.LBB1_164
	.p2align	4
.LBB1_162:                              #   in Loop: Header=BB1_164 Depth=5
	negb	%r10b
	shlxq	%r10, 8(%r9,%r8,8), %r10
.LBB1_163:                              #   in Loop: Header=BB1_164 Depth=5
	shrxq	%rax, (%r9,%r8,8), %rax
	orq	%r10, %rax
	movq	%rax, 1552(%rsp,%rcx,8)
	incq	%rcx
	cmpq	%rcx, %rsi
	je	.LBB1_140
.LBB1_164:                              #   Parent Loop BB1_67 Depth=1
                                        #     Parent Loop BB1_132 Depth=2
                                        #       Parent Loop BB1_134 Depth=3
                                        #         Parent Loop BB1_137 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movq	(%rdx,%rcx,8), %rax
	movq	%rax, %r8
	shrq	$6, %r8
	movl	%eax, %r10d
	addq	%r15, %r8
	bzhiq	%r12, %r8, %r8
	andl	$63, %r10d
	jne	.LBB1_162
# %bb.165:                              #   in Loop: Header=BB1_164 Depth=5
	xorl	%r10d, %r10d
	jmp	.LBB1_163
	.p2align	4
.LBB1_166:                              #   in Loop: Header=BB1_137 Depth=4
	movl	$999, %r8d                      # imm = 0x3E7
.LBB1_167:                              #   in Loop: Header=BB1_137 Depth=4
	movl	%r8d, %eax
	addq	%rax, 176(%rsp)
	cmpl	$0, 768(%rsp)                   # 4-byte Folded Reload
	jne	.LBB1_136
# %bb.168:                              #   in Loop: Header=BB1_137 Depth=4
	movq	640(%rsp), %r14                 # 8-byte Reload
	movl	%ebx, %ecx
	incq	320(%rsp)                       # 8-byte Folded Spill
	addq	%rax, 448(%rsp)                 # 8-byte Folded Spill
	movq	576(%rsp), %rsi                 # 8-byte Reload
	addq	%rcx, %r14
	movl	%r13d, %ecx
	addq	%rcx, 832(%rsp)                 # 8-byte Folded Spill
	cmpl	$65, %eax
	jae	.LBB1_170
# %bb.169:                              #   in Loop: Header=BB1_137 Depth=4
	incl	1280(%rsp,%rax,4)
	jmp	.LBB1_171
.LBB1_170:                              #   in Loop: Header=BB1_137 Depth=4
	movq	256(%rsp), %rax                 # 8-byte Reload
	incl	%eax
	movq	%rax, 256(%rsp)                 # 8-byte Spill
.LBB1_171:                              #   in Loop: Header=BB1_137 Depth=4
	movq	512(%rsp), %rax                 # 8-byte Reload
	incq	%r15
	cmpq	%rax, %r15
	jne	.LBB1_137
	jmp	.LBB1_133
.LBB1_172:                              #   in Loop: Header=BB1_67 Depth=1
	vcvtusi2sd	%rax, %xmm26, %xmm2
	xorl	%r14d, %r14d
	vpxor	%xmm3, %xmm3, %xmm3
	movq	%rcx, 256(%rsp)                 # 8-byte Spill
	movq	%r8, %r13
	movq	%r11, %r15
	jmp	.LBB1_174
.LBB1_173:                              #   in Loop: Header=BB1_67 Depth=1
	vcvtusi2sdq	832(%rsp), %xmm26, %xmm3 # 8-byte Folded Reload
	movq	320(%rsp), %r15                 # 8-byte Reload
	movq	448(%rsp), %r13                 # 8-byte Reload
	.p2align	4
.LBB1_174:                              #   in Loop: Header=BB1_67 Depth=1
	vunpcklpd	%xmm2, %xmm3, %xmm8     # xmm8 = xmm3[0],xmm2[0]
	vdivsd	%xmm1, %xmm0, %xmm9
	vzeroupper
	callq	*__imp_GetCurrentProcess(%rip)
	leaq	160(%rsp), %rcx
	leaq	1552(%rsp), %rdi
	leaq	192(%rsp), %rbx
	leaq	184(%rsp), %r9
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	movq	%rdi, %rdx
	movq	%rbx, %r8
	callq	*__imp_GetProcessTimes(%rip)
	movl	164(%rsp), %eax
	movl	160(%rsp), %esi
	movq	%rdi, %rcx
	shlq	$32, %rax
	addq	184(%rsp), %rax
	addq	%rax, %rsi
	callq	*__imp_QueryPerformanceCounter(%rip)
	movq	%rbx, %rcx
	callq	*__imp_QueryPerformanceFrequency(%rip)
	vcvtusi2sd	%rsi, %xmm26, %xmm0
	movq	384(%rsp), %rax                 # 8-byte Reload
	leaq	.str.3(%rip), %rbx
	leaq	__const.main.pools(%rip), %rcx
	leaq	.str.4(%rip), %rdi
	leaq	.str.10(%rip), %r8
	movq	%rbx, %rdx
	vmulsd	%xmm6, %xmm0, %xmm0
	testq	%rax, %rax
	movl	(%rcx,%rax,4), %r9d
	leaq	.str.9(%rip), %rcx
	cmoveq	%rdi, %rdx
	cmpq	$4, %rax
	leaq	.str.11(%rip), %rax
	vsubsd	%xmm7, %xmm0, %xmm0
	vcvtsi2sdq	1552(%rsp), %xmm26, %xmm1
	vcvtsi2sdq	192(%rsp), %xmm26, %xmm2
	cmoveq	%rax, %r8
	movq	256(%rsp), %rax                 # 8-byte Reload
	vcvtusi2sd	%r13, %xmm26, %xmm3
	movl	%eax, 88(%rsp)
	vunpcklpd	%xmm3, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm3[0]
	vcvtusi2sd	%r15, %xmm27, %xmm3
	vmovddup	%xmm3, %xmm3                    # xmm3 = xmm3[0,0]
	vunpcklpd	%xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0]
	vdivpd	%xmm3, %xmm8, %xmm3
	vdivpd	%xmm2, %xmm1, %xmm1
	vmovupd	%xmm3, 72(%rsp)
	movq	%r14, 64(%rsp)
	vmovsd	%xmm0, 40(%rsp)
	movl	$100, 32(%rsp)
	vsubsd	%xmm9, %xmm1, %xmm2
	vmovhpd	%xmm1, 56(%rsp)
	vmovsd	%xmm2, 48(%rsp)
	callq	printf
	xorl	%r13d, %r13d
	xorl	%eax, %eax
	jmp	.LBB1_176
	.p2align	4
.LBB1_175:                              #   in Loop: Header=BB1_176 Depth=2
	incq	%r13
	cmpq	$65, %r13
	je	.LBB1_66
.LBB1_176:                              #   Parent Loop BB1_67 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	1280(%rsp,%r13,4), %r9d
	testl	%r9d, %r9d
	je	.LBB1_175
# %bb.177:                              #   in Loop: Header=BB1_176 Depth=2
	testl	%eax, %eax
	movq	%rbx, %rdx
	leaq	.str.12(%rip), %rcx
	leal	1(%rax), %esi
	movl	%r13d, %r8d
	cmoveq	%rdi, %rdx
	callq	printf
	movl	%esi, %eax
	jmp	.LBB1_175
.LBB1_178:
	movl	$3, %r13d
	jmp	.LBB1_181
.LBB1_179:
	movl	$5, %r13d
	jmp	.LBB1_181
.LBB1_180:
	movq	176(%rsp), %rdx
	leaq	.str.7(%rip), %rcx
	callq	printf
	movq	136(%rsp), %rcx                 # 8-byte Reload
	callq	free
	xorl	%r13d, %r13d
	jmp	.LBB1_181
.LBB1_182:
	movl	$11, %r13d
.LBB1_181:
	movl	%r13d, %eax
	vmovaps	5520(%rbp), %xmm6               # 16-byte Reload
	vmovaps	5536(%rbp), %xmm7               # 16-byte Reload
	vmovaps	5552(%rbp), %xmm8               # 16-byte Reload
	vmovaps	5568(%rbp), %xmm9               # 16-byte Reload
	vmovaps	5584(%rbp), %xmm10              # 16-byte Reload
	vmovaps	5600(%rbp), %xmm11              # 16-byte Reload
	vmovaps	5616(%rbp), %xmm12              # 16-byte Reload
	vmovaps	5632(%rbp), %xmm13              # 16-byte Reload
	vmovaps	5648(%rbp), %xmm14              # 16-byte Reload
	vmovaps	5664(%rbp), %xmm15              # 16-byte Reload
	.seh_startepilogue
	leaq	5688(%rbp), %rsp
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
	.asciz	"{\"variant\":\"simd8_key_popcount\",\"exact_choice_selfcheck\":true,\"rows\":%llu,\"includes_construction\":true,\"excludes_offset_zero\":true,\"fallback_pool\":512,\"cases\":["

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
