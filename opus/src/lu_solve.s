	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0	sdk_version 11, 3
	.globl	_lu_solve                       ## -- Begin function lu_solve
	.p2align	4, 0x90
_lu_solve:                              ## @lu_solve
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdx
	callq	_lu_solve_6
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function lu_solve_6
LCPI1_0:
	.quad	0xbff0000000000000              ## double -1
LCPI1_1:
	.quad	0x3ff0000000000000              ## double 1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_lu_solve_6
	.p2align	4, 0x90
_lu_solve_6:                            ## @lu_solve_6
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	andq	$-32, %rsp
	subq	$800, %rsp                      ## imm = 0x320
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movl	%edi, 268(%rsp)
	movq	%rsi, 256(%rsp)
	movq	%rdx, 248(%rsp)
	movq	_scratch_ipiv(%rip), %rax
	movq	%rax, 224(%rsp)
	movl	268(%rsp), %ecx
	movl	268(%rsp), %edi
	movl	%ecx, 280(%rsp)
	movl	%edi, 276(%rsp)
	movl	$64, 220(%rsp)
	movl	268(%rsp), %ecx
	movl	%ecx, 216(%rsp)
	movl	268(%rsp), %ecx
	movl	%ecx, 212(%rsp)
	movl	268(%rsp), %ecx
	movl	%ecx, 208(%rsp)
	cmpl	$1, 220(%rsp)
	jle	LBB1_2
## %bb.1:
	movl	220(%rsp), %eax
	cmpl	208(%rsp), %eax
	jl	LBB1_5
LBB1_2:
	movl	216(%rsp), %edi
	movl	268(%rsp), %esi
	movq	256(%rsp), %rdx
	movl	212(%rsp), %ecx
	movq	224(%rsp), %r8
	callq	_dgetf2_6
	movl	%eax, 244(%rsp)
	cmpl	$0, 244(%rsp)
	je	LBB1_4
## %bb.3:
	movl	244(%rsp), %eax
	movl	%eax, 272(%rsp)
	jmp	LBB1_39
LBB1_4:
	jmp	LBB1_38
LBB1_5:
	movl	$0, 240(%rsp)
LBB1_6:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB1_13 Depth 2
                                        ##     Child Loop BB1_20 Depth 2
                                        ##     Child Loop BB1_27 Depth 2
	movl	240(%rsp), %eax
	cmpl	208(%rsp), %eax
	jge	LBB1_37
## %bb.7:                               ##   in Loop: Header=BB1_6 Depth=1
	movl	208(%rsp), %eax
	subl	240(%rsp), %eax
	cmpl	220(%rsp), %eax
	jge	LBB1_9
## %bb.8:                               ##   in Loop: Header=BB1_6 Depth=1
	movl	208(%rsp), %eax
	subl	240(%rsp), %eax
	movl	%eax, 92(%rsp)                  ## 4-byte Spill
	jmp	LBB1_10
LBB1_9:                                 ##   in Loop: Header=BB1_6 Depth=1
	movl	220(%rsp), %eax
	movl	%eax, 92(%rsp)                  ## 4-byte Spill
LBB1_10:                                ##   in Loop: Header=BB1_6 Depth=1
	movl	92(%rsp), %eax                  ## 4-byte Reload
	movl	%eax, 236(%rsp)
	movl	216(%rsp), %eax
	subl	240(%rsp), %eax
	movl	236(%rsp), %esi
	movq	256(%rsp), %rcx
	movl	212(%rsp), %edx
	imull	240(%rsp), %edx
	addl	240(%rsp), %edx
	movslq	%edx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rcx
	movl	212(%rsp), %edx
	movq	224(%rsp), %rdi
	movslq	240(%rsp), %r8
	shlq	$2, %r8
	addq	%r8, %rdi
	movq	%rdi, 80(%rsp)                  ## 8-byte Spill
	movl	%eax, %edi
	movl	%edx, 76(%rsp)                  ## 4-byte Spill
	movq	%rcx, %rdx
	movl	76(%rsp), %ecx                  ## 4-byte Reload
	movq	80(%rsp), %r8                   ## 8-byte Reload
	callq	_dgetf2_6
	movl	%eax, 244(%rsp)
	cmpl	$0, 244(%rsp)
	je	LBB1_12
## %bb.11:
	movl	244(%rsp), %eax
	movl	%eax, 272(%rsp)
	jmp	LBB1_39
LBB1_12:                                ##   in Loop: Header=BB1_6 Depth=1
	movl	240(%rsp), %eax
	movl	%eax, 284(%rsp)
	movl	284(%rsp), %eax
	movl	%eax, 372(%rsp)
	movl	%eax, 368(%rsp)
	movl	%eax, 364(%rsp)
	movl	%eax, 360(%rsp)
	movl	%eax, 356(%rsp)
	movl	%eax, 352(%rsp)
	movl	%eax, 348(%rsp)
	movl	%eax, 344(%rsp)
	movl	348(%rsp), %eax
	movl	352(%rsp), %ecx
	movl	356(%rsp), %edx
	movl	364(%rsp), %esi
	movl	368(%rsp), %edi
	movl	372(%rsp), %r8d
	vmovd	360(%rsp), %xmm0                ## xmm0 = mem[0],zero,zero,zero
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpinsrd	$2, %edi, %xmm0, %xmm0
	vpinsrd	$3, %r8d, %xmm0, %xmm0
	vmovd	344(%rsp), %xmm1                ## xmm1 = mem[0],zero,zero,zero
	vpinsrd	$1, %eax, %xmm1, %xmm1
	vpinsrd	$2, %ecx, %xmm1, %xmm1
	vpinsrd	$3, %edx, %xmm1, %xmm1
                                        ## implicit-def: $ymm2
	vmovaps	%xmm1, %xmm2
	vinserti128	$1, %xmm0, %ymm2, %ymm2
	vmovdqa	%ymm2, 288(%rsp)
	vmovdqa	288(%rsp), %ymm2
	vmovdqa	%ymm2, 96(%rsp)
	movl	240(%rsp), %eax
	movl	%eax, 232(%rsp)
LBB1_13:                                ##   Parent Loop BB1_6 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	232(%rsp), %eax
	movl	216(%rsp), %ecx
	movl	240(%rsp), %edx
	addl	236(%rsp), %edx
	cmpl	%edx, %ecx
	movl	%eax, 72(%rsp)                  ## 4-byte Spill
	jge	LBB1_15
## %bb.14:                              ##   in Loop: Header=BB1_13 Depth=2
	movl	216(%rsp), %eax
	movl	%eax, 68(%rsp)                  ## 4-byte Spill
	jmp	LBB1_16
LBB1_15:                                ##   in Loop: Header=BB1_13 Depth=2
	movl	240(%rsp), %eax
	addl	236(%rsp), %eax
	movl	%eax, 68(%rsp)                  ## 4-byte Spill
LBB1_16:                                ##   in Loop: Header=BB1_13 Depth=2
	movl	68(%rsp), %eax                  ## 4-byte Reload
	subl	$15, %eax
	movl	72(%rsp), %ecx                  ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB1_19
## %bb.17:                              ##   in Loop: Header=BB1_13 Depth=2
	movq	224(%rsp), %rax
	movslq	232(%rsp), %rcx
	shlq	$2, %rcx
	addq	%rcx, %rax
	movq	%rax, 376(%rsp)
	movq	376(%rsp), %rax
	vmovdqu	(%rax), %ymm0
	vmovdqa	%ymm0, 160(%rsp)
	movq	224(%rsp), %rax
	movslq	232(%rsp), %rcx
	shlq	$2, %rcx
	addq	%rcx, %rax
	vmovdqa	160(%rsp), %ymm0
	vmovdqa	96(%rsp), %ymm1
	vmovdqa	%ymm0, 416(%rsp)
	vmovdqa	%ymm1, 384(%rsp)
	vmovdqa	416(%rsp), %ymm0
	vmovdqa	384(%rsp), %ymm1
	vpaddd	%ymm1, %ymm0, %ymm0
	movq	%rax, 496(%rsp)
	vmovdqa	%ymm0, 448(%rsp)
	vmovdqa	448(%rsp), %ymm0
	movq	496(%rsp), %rax
	vmovdqu	%ymm0, (%rax)
	movq	224(%rsp), %rax
	movslq	232(%rsp), %rcx
	shlq	$2, %rcx
	addq	%rcx, %rax
	addq	$32, %rax
	movq	%rax, 504(%rsp)
	movq	504(%rsp), %rax
	vmovdqu	(%rax), %ymm0
	vmovdqa	%ymm0, 160(%rsp)
	movq	224(%rsp), %rax
	movslq	232(%rsp), %rcx
	shlq	$2, %rcx
	addq	%rcx, %rax
	addq	$32, %rax
	vmovdqa	160(%rsp), %ymm0
	vmovdqa	96(%rsp), %ymm1
	vmovdqa	%ymm0, 768(%rsp)
	vmovdqa	%ymm1, 736(%rsp)
	vmovdqa	768(%rsp), %ymm0
	vmovdqa	736(%rsp), %ymm1
	vpaddd	%ymm1, %ymm0, %ymm0
	movq	%rax, 728(%rsp)
	vmovdqa	%ymm0, 672(%rsp)
	vmovdqa	672(%rsp), %ymm0
	movq	728(%rsp), %rax
	vmovdqu	%ymm0, (%rax)
## %bb.18:                              ##   in Loop: Header=BB1_13 Depth=2
	movl	232(%rsp), %eax
	addl	$16, %eax
	movl	%eax, 232(%rsp)
	jmp	LBB1_13
LBB1_19:                                ##   in Loop: Header=BB1_6 Depth=1
	jmp	LBB1_20
LBB1_20:                                ##   Parent Loop BB1_6 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	232(%rsp), %eax
	movl	216(%rsp), %ecx
	movl	240(%rsp), %edx
	addl	236(%rsp), %edx
	cmpl	%edx, %ecx
	movl	%eax, 64(%rsp)                  ## 4-byte Spill
	jge	LBB1_22
## %bb.21:                              ##   in Loop: Header=BB1_20 Depth=2
	movl	216(%rsp), %eax
	movl	%eax, 60(%rsp)                  ## 4-byte Spill
	jmp	LBB1_23
LBB1_22:                                ##   in Loop: Header=BB1_20 Depth=2
	movl	240(%rsp), %eax
	addl	236(%rsp), %eax
	movl	%eax, 60(%rsp)                  ## 4-byte Spill
LBB1_23:                                ##   in Loop: Header=BB1_20 Depth=2
	movl	60(%rsp), %eax                  ## 4-byte Reload
	subl	$7, %eax
	movl	64(%rsp), %ecx                  ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB1_26
## %bb.24:                              ##   in Loop: Header=BB1_20 Depth=2
	movq	224(%rsp), %rax
	movslq	232(%rsp), %rcx
	shlq	$2, %rcx
	addq	%rcx, %rax
	movq	%rax, 664(%rsp)
	movq	664(%rsp), %rax
	vmovdqu	(%rax), %ymm0
	vmovdqa	%ymm0, 160(%rsp)
	movq	224(%rsp), %rax
	movslq	232(%rsp), %rcx
	shlq	$2, %rcx
	addq	%rcx, %rax
	vmovdqa	160(%rsp), %ymm0
	vmovdqa	96(%rsp), %ymm1
	vmovdqa	%ymm0, 608(%rsp)
	vmovdqa	%ymm1, 576(%rsp)
	vmovdqa	608(%rsp), %ymm0
	vmovdqa	576(%rsp), %ymm1
	vpaddd	%ymm1, %ymm0, %ymm0
	movq	%rax, 568(%rsp)
	vmovdqa	%ymm0, 512(%rsp)
	vmovdqa	512(%rsp), %ymm0
	movq	568(%rsp), %rax
	vmovdqu	%ymm0, (%rax)
## %bb.25:                              ##   in Loop: Header=BB1_20 Depth=2
	movl	232(%rsp), %eax
	addl	$8, %eax
	movl	%eax, 232(%rsp)
	jmp	LBB1_20
LBB1_26:                                ##   in Loop: Header=BB1_6 Depth=1
	jmp	LBB1_27
LBB1_27:                                ##   Parent Loop BB1_6 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	232(%rsp), %eax
	movl	216(%rsp), %ecx
	movl	240(%rsp), %edx
	addl	236(%rsp), %edx
	cmpl	%edx, %ecx
	movl	%eax, 56(%rsp)                  ## 4-byte Spill
	jge	LBB1_29
## %bb.28:                              ##   in Loop: Header=BB1_27 Depth=2
	movl	216(%rsp), %eax
	movl	%eax, 52(%rsp)                  ## 4-byte Spill
	jmp	LBB1_30
LBB1_29:                                ##   in Loop: Header=BB1_27 Depth=2
	movl	240(%rsp), %eax
	addl	236(%rsp), %eax
	movl	%eax, 52(%rsp)                  ## 4-byte Spill
LBB1_30:                                ##   in Loop: Header=BB1_27 Depth=2
	movl	52(%rsp), %eax                  ## 4-byte Reload
	movl	56(%rsp), %ecx                  ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB1_33
## %bb.31:                              ##   in Loop: Header=BB1_27 Depth=2
	movl	240(%rsp), %eax
	movq	224(%rsp), %rcx
	movl	232(%rsp), %edx
	addl	$0, %edx
	movslq	%edx, %rsi
	addl	(%rcx,%rsi,4), %eax
	movl	%eax, (%rcx,%rsi,4)
## %bb.32:                              ##   in Loop: Header=BB1_27 Depth=2
	movl	232(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 232(%rsp)
	jmp	LBB1_27
LBB1_33:                                ##   in Loop: Header=BB1_6 Depth=1
	movl	240(%rsp), %edi
	movq	256(%rsp), %rsi
	movl	212(%rsp), %edx
	movl	240(%rsp), %ecx
	movl	240(%rsp), %eax
	addl	236(%rsp), %eax
	movq	224(%rsp), %r9
	movl	%eax, %r8d
	movl	$1, (%rsp)
	vzeroupper
	callq	_dlaswp_6
	movl	240(%rsp), %eax
	addl	236(%rsp), %eax
	cmpl	268(%rsp), %eax
	jge	LBB1_35
## %bb.34:                              ##   in Loop: Header=BB1_6 Depth=1
	movl	268(%rsp), %eax
	subl	240(%rsp), %eax
	subl	236(%rsp), %eax
	movq	256(%rsp), %rcx
	movl	212(%rsp), %edx
	movl	240(%rsp), %esi
	addl	236(%rsp), %esi
	imull	%esi, %edx
	addl	$0, %edx
	movslq	%edx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rcx
	movl	212(%rsp), %edx
	movl	240(%rsp), %esi
	movl	240(%rsp), %r8d
	addl	236(%rsp), %r8d
	movq	224(%rsp), %r9
	movl	%eax, %edi
	movl	%esi, 48(%rsp)                  ## 4-byte Spill
	movq	%rcx, %rsi
	movl	48(%rsp), %ecx                  ## 4-byte Reload
	movl	$1, (%rsp)
	callq	_dlaswp_6
	movl	236(%rsp), %edi
	movl	268(%rsp), %eax
	subl	240(%rsp), %eax
	subl	236(%rsp), %eax
	movq	256(%rsp), %rsi
	movl	212(%rsp), %ecx
	imull	240(%rsp), %ecx
	addl	240(%rsp), %ecx
	movslq	%ecx, %r9
	shlq	$3, %r9
	addq	%r9, %rsi
	movl	212(%rsp), %ecx
	movq	256(%rsp), %r9
	movl	212(%rsp), %edx
	movl	240(%rsp), %r8d
	addl	236(%rsp), %r8d
	imull	%r8d, %edx
	addl	240(%rsp), %edx
	movslq	%edx, %r10
	shlq	$3, %r10
	addq	%r10, %r9
	movl	212(%rsp), %edx
	movq	%rsi, 40(%rsp)                  ## 8-byte Spill
	movl	%eax, %esi
	movq	40(%rsp), %r10                  ## 8-byte Reload
	movl	%edx, 36(%rsp)                  ## 4-byte Spill
	movq	%r10, %rdx
	movq	%r9, %r8
	movl	36(%rsp), %r9d                  ## 4-byte Reload
	callq	_dtrsm_L_6
	vmovsd	LCPI1_0(%rip), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	LCPI1_1(%rip), %xmm1            ## xmm1 = mem[0],zero
	movl	216(%rsp), %eax
	subl	240(%rsp), %eax
	subl	236(%rsp), %eax
	movl	268(%rsp), %ecx
	subl	240(%rsp), %ecx
	subl	236(%rsp), %ecx
	movl	236(%rsp), %edx
	movq	256(%rsp), %r8
	movl	212(%rsp), %esi
	imull	240(%rsp), %esi
	movl	240(%rsp), %edi
	addl	236(%rsp), %edi
	addl	%edi, %esi
	movslq	%esi, %r10
	shlq	$3, %r10
	addq	%r10, %r8
	movl	212(%rsp), %esi
	movq	256(%rsp), %r10
	movl	212(%rsp), %edi
	movl	240(%rsp), %r9d
	addl	236(%rsp), %r9d
	imull	%r9d, %edi
	addl	240(%rsp), %edi
	movslq	%edi, %r11
	shlq	$3, %r11
	addq	%r11, %r10
	movl	212(%rsp), %edi
	movq	256(%rsp), %r11
	movl	212(%rsp), %r9d
	movl	240(%rsp), %ebx
	addl	236(%rsp), %ebx
	imull	%ebx, %r9d
	movl	240(%rsp), %ebx
	addl	236(%rsp), %ebx
	addl	%ebx, %r9d
	movslq	%r9d, %r14
	shlq	$3, %r14
	addq	%r14, %r11
	movl	212(%rsp), %r9d
	movl	%edi, 32(%rsp)                  ## 4-byte Spill
	movl	%eax, %edi
	movl	%esi, 28(%rsp)                  ## 4-byte Spill
	movl	%ecx, %esi
	movq	%r8, %rcx
	movl	28(%rsp), %r8d                  ## 4-byte Reload
	movl	%r9d, 24(%rsp)                  ## 4-byte Spill
	movq	%r10, %r9
	movl	32(%rsp), %eax                  ## 4-byte Reload
	movl	%eax, (%rsp)
	movq	%r11, 8(%rsp)
	movl	24(%rsp), %eax                  ## 4-byte Reload
	movl	%eax, 16(%rsp)
	callq	_dgemm_5
LBB1_35:                                ##   in Loop: Header=BB1_6 Depth=1
	jmp	LBB1_36
LBB1_36:                                ##   in Loop: Header=BB1_6 Depth=1
	movl	220(%rsp), %eax
	addl	240(%rsp), %eax
	movl	%eax, 240(%rsp)
	jmp	LBB1_6
LBB1_37:
	jmp	LBB1_38
LBB1_38:
	movl	268(%rsp), %edi
	movq	256(%rsp), %rsi
	movq	224(%rsp), %rdx
	movq	248(%rsp), %rcx
	callq	_dgetrs_6
	movl	%eax, 244(%rsp)
	movl	244(%rsp), %eax
	movl	%eax, 272(%rsp)
LBB1_39:
	movl	272(%rsp), %eax
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_lu_initialize_memory           ## -- Begin function lu_initialize_memory
	.p2align	4, 0x90
_lu_initialize_memory:                  ## @lu_initialize_memory
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	$4096, %edi                     ## imm = 0x1000
	movl	$589824, %esi                   ## imm = 0x90000
	callq	_aligned_alloc
	movq	%rax, _scratch_a(%rip)
	movl	$4096, %edi                     ## imm = 0x1000
	movl	$6291456, %esi                  ## imm = 0x600000
	callq	_aligned_alloc
	movq	%rax, _scratch_b(%rip)
	movslq	-4(%rbp), %rax
	shlq	$2, %rax
	addq	$31, %rax
	andq	$-32, %rax
	movl	$32, %edi
	movq	%rax, %rsi
	callq	_aligned_alloc
	movq	%rax, _scratch_ipiv(%rip)
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_lu_free_memory                 ## -- Begin function lu_free_memory
	.p2align	4, 0x90
_lu_free_memory:                        ## @lu_free_memory
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	_scratch_a(%rip), %rax
	movq	%rax, %rdi
	callq	_free
	movq	_scratch_b(%rip), %rax
	movq	%rax, %rdi
	callq	_free
	movq	_scratch_ipiv(%rip), %rax
	movq	%rax, %rdi
	callq	_free
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function lu_solve_0
LCPI4_0:
	.quad	0x3bc79ca10c924223              ## double 9.9999999999999995E-21
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI4_1:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_lu_solve_0
	.p2align	4, 0x90
_lu_solve_0:                            ## @lu_solve_0
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movl	%edi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	_scratch_ipiv(%rip), %rax
	movq	%rax, -48(%rbp)
	movl	$0, -28(%rbp)
LBB4_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB4_3 Depth 2
                                        ##     Child Loop BB4_12 Depth 2
                                        ##     Child Loop BB4_17 Depth 2
                                        ##     Child Loop BB4_21 Depth 2
                                        ##       Child Loop BB4_23 Depth 3
	movl	-28(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB4_30
## %bb.2:                               ##   in Loop: Header=BB4_1 Depth=1
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %ecx
	imull	-28(%rbp), %ecx
	addl	-28(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovdqa	LCPI4_1(%rip), %xmm1            ## xmm1 = [NaN,NaN]
	vpand	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, -64(%rbp)
	movl	-28(%rbp), %ecx
	movl	%ecx, -68(%rbp)
	movl	-28(%rbp), %ecx
	addl	$1, %ecx
	movl	%ecx, -36(%rbp)
LBB4_3:                                 ##   Parent Loop BB4_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-36(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB4_8
## %bb.4:                               ##   in Loop: Header=BB4_3 Depth=2
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %ecx
	imull	-36(%rbp), %ecx
	addl	-28(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovdqa	LCPI4_1(%rip), %xmm1            ## xmm1 = [NaN,NaN]
	vpand	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, -56(%rbp)
	vmovsd	-56(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vucomisd	-64(%rbp), %xmm0
	jbe	LBB4_6
## %bb.5:                               ##   in Loop: Header=BB4_3 Depth=2
	vmovsd	-56(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -64(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -68(%rbp)
LBB4_6:                                 ##   in Loop: Header=BB4_3 Depth=2
	jmp	LBB4_7
LBB4_7:                                 ##   in Loop: Header=BB4_3 Depth=2
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	LBB4_3
LBB4_8:                                 ##   in Loop: Header=BB4_1 Depth=1
	vmovsd	LCPI4_0(%rip), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	-64(%rbp), %xmm1                ## xmm1 = mem[0],zero
	vxorps	%xmm2, %xmm2, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovdqa	LCPI4_1(%rip), %xmm2            ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	jb	LBB4_10
## %bb.9:
	movq	___stderrp@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	L_.str(%rip), %rsi
	movb	$0, %al
	callq	_fprintf
	movl	$-1, -4(%rbp)
	jmp	LBB4_51
LBB4_10:                                ##   in Loop: Header=BB4_1 Depth=1
	movl	-28(%rbp), %eax
	cmpl	-68(%rbp), %eax
	je	LBB4_16
## %bb.11:                              ##   in Loop: Header=BB4_1 Depth=1
	movq	-24(%rbp), %rdi
	movl	-28(%rbp), %esi
	movl	-68(%rbp), %edx
	callq	_swapd
	movl	$0, -32(%rbp)
LBB4_12:                                ##   Parent Loop BB4_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB4_15
## %bb.13:                              ##   in Loop: Header=BB4_12 Depth=2
	movq	-16(%rbp), %rdi
	movl	-8(%rbp), %eax
	imull	-28(%rbp), %eax
	addl	-32(%rbp), %eax
	movl	-8(%rbp), %ecx
	imull	-68(%rbp), %ecx
	addl	-32(%rbp), %ecx
	movl	%eax, %esi
	movl	%ecx, %edx
	callq	_swapd
## %bb.14:                              ##   in Loop: Header=BB4_12 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	LBB4_12
LBB4_15:                                ##   in Loop: Header=BB4_1 Depth=1
	jmp	LBB4_16
LBB4_16:                                ##   in Loop: Header=BB4_1 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
LBB4_17:                                ##   Parent Loop BB4_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB4_20
## %bb.18:                              ##   in Loop: Header=BB4_17 Depth=2
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %ecx
	imull	-32(%rbp), %ecx
	addl	-28(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %ecx
	imull	-28(%rbp), %ecx
	addl	-28(%rbp), %ecx
	movslq	%ecx, %rdx
	vdivsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %ecx
	imull	-32(%rbp), %ecx
	addl	-28(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.19:                              ##   in Loop: Header=BB4_17 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	LBB4_17
LBB4_20:                                ##   in Loop: Header=BB4_1 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
LBB4_21:                                ##   Parent Loop BB4_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB4_23 Depth 3
	movl	-32(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB4_28
## %bb.22:                              ##   in Loop: Header=BB4_21 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -72(%rbp)
LBB4_23:                                ##   Parent Loop BB4_1 Depth=1
                                        ##     Parent Loop BB4_21 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-72(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB4_26
## %bb.24:                              ##   in Loop: Header=BB4_23 Depth=3
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %ecx
	imull	-32(%rbp), %ecx
	addl	-72(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %ecx
	imull	-32(%rbp), %ecx
	addl	-28(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %ecx
	imull	-28(%rbp), %ecx
	addl	-72(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %ecx
	imull	-32(%rbp), %ecx
	addl	-72(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.25:                              ##   in Loop: Header=BB4_23 Depth=3
	movl	-72(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -72(%rbp)
	jmp	LBB4_23
LBB4_26:                                ##   in Loop: Header=BB4_21 Depth=2
	jmp	LBB4_27
LBB4_27:                                ##   in Loop: Header=BB4_21 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	LBB4_21
LBB4_28:                                ##   in Loop: Header=BB4_1 Depth=1
	jmp	LBB4_29
LBB4_29:                                ##   in Loop: Header=BB4_1 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	LBB4_1
LBB4_30:
	movl	$0, -36(%rbp)
LBB4_31:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB4_34 Depth 2
	movl	-36(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB4_40
## %bb.32:                              ##   in Loop: Header=BB4_31 Depth=1
	vmovsd	LCPI4_0(%rip), %xmm0            ## xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	movslq	-36(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm1            ## xmm1 = mem[0],zero
	vxorps	%xmm2, %xmm2, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovdqa	LCPI4_1(%rip), %xmm2            ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	jae	LBB4_38
## %bb.33:                              ##   in Loop: Header=BB4_31 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
LBB4_34:                                ##   Parent Loop BB4_31 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB4_37
## %bb.35:                              ##   in Loop: Header=BB4_34 Depth=2
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	movslq	-36(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %edx
	imull	-28(%rbp), %edx
	addl	-36(%rbp), %edx
	movslq	%edx, %rcx
	vmulsd	(%rax,%rcx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
## %bb.36:                              ##   in Loop: Header=BB4_34 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	LBB4_34
LBB4_37:                                ##   in Loop: Header=BB4_31 Depth=1
	jmp	LBB4_38
LBB4_38:                                ##   in Loop: Header=BB4_31 Depth=1
	jmp	LBB4_39
LBB4_39:                                ##   in Loop: Header=BB4_31 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	LBB4_31
LBB4_40:
	movl	-8(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -36(%rbp)
LBB4_41:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB4_44 Depth 2
	cmpl	$0, -36(%rbp)
	jl	LBB4_50
## %bb.42:                              ##   in Loop: Header=BB4_41 Depth=1
	vmovsd	LCPI4_0(%rip), %xmm0            ## xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	movslq	-36(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm1            ## xmm1 = mem[0],zero
	vxorps	%xmm2, %xmm2, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovdqa	LCPI4_1(%rip), %xmm2            ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	jae	LBB4_48
## %bb.43:                              ##   in Loop: Header=BB4_41 Depth=1
	movq	-24(%rbp), %rax
	movslq	-36(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %edx
	imull	-36(%rbp), %edx
	addl	-36(%rbp), %edx
	movslq	%edx, %rcx
	vdivsd	(%rax,%rcx,8), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movslq	-36(%rbp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
	movl	$0, -28(%rbp)
LBB4_44:                                ##   Parent Loop BB4_41 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jge	LBB4_47
## %bb.45:                              ##   in Loop: Header=BB4_44 Depth=2
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	movslq	-36(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %edx
	imull	-28(%rbp), %edx
	addl	-36(%rbp), %edx
	movslq	%edx, %rcx
	vmulsd	(%rax,%rcx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
## %bb.46:                              ##   in Loop: Header=BB4_44 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	LBB4_44
LBB4_47:                                ##   in Loop: Header=BB4_41 Depth=1
	jmp	LBB4_48
LBB4_48:                                ##   in Loop: Header=BB4_41 Depth=1
	jmp	LBB4_49
LBB4_49:                                ##   in Loop: Header=BB4_41 Depth=1
	movl	-36(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -36(%rbp)
	jmp	LBB4_41
LBB4_50:
	movl	$0, -4(%rbp)
LBB4_51:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function swapd
_swapd:                                 ## @swapd
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -24(%rbp)
	movq	-8(%rbp), %rax
	movslq	-16(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
	vmovsd	-24(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-8(%rbp), %rax
	movslq	-16(%rbp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function dgemm_1T
LCPI6_0:
	.quad	0x3bc79ca10c924223              ## double 9.9999999999999995E-21
LCPI6_2:
	.quad	0x3ff0000000000000              ## double 1
LCPI6_3:
	.quad	0xbff0000000000000              ## double -1
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI6_1:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_dgemm_1T
	.p2align	4, 0x90
_dgemm_1T:                              ## @dgemm_1T
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$88, %rsp
	.cfi_offset %rbx, -24
	movl	32(%rbp), %eax
	movq	24(%rbp), %r10
	movl	16(%rbp), %r11d
	vmovsd	LCPI6_0(%rip), %xmm2            ## xmm2 = mem[0],zero
	vmovsd	LCPI6_2(%rip), %xmm3            ## xmm3 = mem[0],zero
	movl	%edi, -12(%rbp)
	movl	%esi, -16(%rbp)
	movl	%edx, -20(%rbp)
	vmovsd	%xmm0, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	%r8d, -44(%rbp)
	movq	%r9, -56(%rbp)
	vmovsd	%xmm1, -64(%rbp)
	vmovsd	-64(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vsubsd	%xmm3, %xmm0, %xmm0
	vmovdqa	LCPI6_1(%rip), %xmm1            ## xmm1 = [NaN,NaN]
	vpand	%xmm1, %xmm0, %xmm0
	vucomisd	%xmm0, %xmm2
	setae	%bl
	xorb	$-1, %bl
	andb	$1, %bl
	movzbl	%bl, %edx
	movslq	%edx, %rcx
	cmpq	$0, %rcx
	je	LBB6_2
## %bb.1:
	leaq	L___func__.dgemm_1T(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.2(%rip), %rcx
	movl	$476, %edx                      ## imm = 0x1DC
	callq	___assert_rtn
LBB6_2:
	jmp	LBB6_3
LBB6_3:
	vmovsd	LCPI6_0(%rip), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	LCPI6_3(%rip), %xmm1            ## xmm1 = mem[0],zero
	vmovsd	-32(%rbp), %xmm2                ## xmm2 = mem[0],zero
	vsubsd	%xmm1, %xmm2, %xmm1
	vmovdqa	LCPI6_1(%rip), %xmm2            ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	setae	%al
	xorb	$-1, %al
	andb	$1, %al
	movzbl	%al, %ecx
	movslq	%ecx, %rdx
	cmpq	$0, %rdx
	je	LBB6_5
## %bb.4:
	leaq	L___func__.dgemm_1T(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.3(%rip), %rcx
	movl	$477, %edx                      ## imm = 0x1DD
	callq	___assert_rtn
LBB6_5:
	jmp	LBB6_6
LBB6_6:
	movl	$0, -68(%rbp)
LBB6_7:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB6_9 Depth 2
                                        ##       Child Loop BB6_11 Depth 3
	movl	-68(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB6_18
## %bb.8:                               ##   in Loop: Header=BB6_7 Depth=1
	movl	$0, -72(%rbp)
LBB6_9:                                 ##   Parent Loop BB6_7 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB6_11 Depth 3
	movl	-72(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	LBB6_16
## %bb.10:                              ##   in Loop: Header=BB6_9 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	imull	-72(%rbp), %ecx
	addl	-68(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movl	$0, -76(%rbp)
LBB6_11:                                ##   Parent Loop BB6_7 Depth=1
                                        ##     Parent Loop BB6_9 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-76(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	LBB6_14
## %bb.12:                              ##   in Loop: Header=BB6_11 Depth=3
	vmovsd	-32(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	imull	-76(%rbp), %ecx
	addl	-68(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	imull	-72(%rbp), %ecx
	addl	-76(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm0, %xmm0
	vaddsd	-88(%rbp), %xmm0, %xmm0
	vmovsd	%xmm0, -88(%rbp)
## %bb.13:                              ##   in Loop: Header=BB6_11 Depth=3
	movl	-76(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -76(%rbp)
	jmp	LBB6_11
LBB6_14:                                ##   in Loop: Header=BB6_9 Depth=2
	vmovsd	-88(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	imull	-72(%rbp), %ecx
	addl	-68(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.15:                              ##   in Loop: Header=BB6_9 Depth=2
	movl	-72(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -72(%rbp)
	jmp	LBB6_9
LBB6_16:                                ##   in Loop: Header=BB6_7 Depth=1
	jmp	LBB6_17
LBB6_17:                                ##   in Loop: Header=BB6_7 Depth=1
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -68(%rbp)
	jmp	LBB6_7
LBB6_18:
	addq	$88, %rsp
	popq	%rbx
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function dgetf2_1
LCPI7_0:
	.quad	0x3bc79ca10c924223              ## double 9.9999999999999995E-21
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI7_1:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_dgetf2_1
	.p2align	4, 0x90
_dgetf2_1:                              ## @dgetf2_1
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movq	%r8, -40(%rbp)
	movl	$0, -44(%rbp)
LBB7_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB7_10 Depth 2
                                        ##     Child Loop BB7_18 Depth 2
                                        ##       Child Loop BB7_20 Depth 3
	movl	-44(%rbp), %eax
	movl	-8(%rbp), %ecx
	cmpl	-12(%rbp), %ecx
	movl	%eax, -68(%rbp)                 ## 4-byte Spill
	jge	LBB7_3
## %bb.2:                               ##   in Loop: Header=BB7_1 Depth=1
	movl	-8(%rbp), %eax
	movl	%eax, -72(%rbp)                 ## 4-byte Spill
	jmp	LBB7_4
LBB7_3:                                 ##   in Loop: Header=BB7_1 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -72(%rbp)                 ## 4-byte Spill
LBB7_4:                                 ##   in Loop: Header=BB7_1 Depth=1
	movl	-72(%rbp), %eax                 ## 4-byte Reload
	movl	-68(%rbp), %ecx                 ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB7_28
## %bb.5:                               ##   in Loop: Header=BB7_1 Depth=1
	movl	-44(%rbp), %eax
	movl	-8(%rbp), %ecx
	subl	-44(%rbp), %ecx
	movq	-24(%rbp), %rdx
	movl	-28(%rbp), %esi
	imull	-44(%rbp), %esi
	addl	-44(%rbp), %esi
	movslq	%esi, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rdx
	movl	-28(%rbp), %esi
	movl	%ecx, %edi
	movl	%esi, -76(%rbp)                 ## 4-byte Spill
	movq	%rdx, %rsi
	movl	-76(%rbp), %edx                 ## 4-byte Reload
	movl	%eax, -80(%rbp)                 ## 4-byte Spill
	callq	_isamax_1
	vmovsd	LCPI7_0(%rip), %xmm0            ## xmm0 = mem[0],zero
	movl	-80(%rbp), %ecx                 ## 4-byte Reload
	addl	%eax, %ecx
	movl	%ecx, -60(%rbp)
	movq	-24(%rbp), %rsi
	movl	-28(%rbp), %eax
	imull	-60(%rbp), %eax
	addl	-44(%rbp), %eax
	movslq	%eax, %r8
	vmovsd	(%rsi,%r8,8), %xmm1             ## xmm1 = mem[0],zero
	vmovsd	%xmm1, -56(%rbp)
	vmovsd	-56(%rbp), %xmm1                ## xmm1 = mem[0],zero
	vxorps	%xmm2, %xmm2, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovdqa	LCPI7_1(%rip), %xmm2            ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	jb	LBB7_7
## %bb.6:
	movq	___stderrp@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	L_.str(%rip), %rsi
	movb	$0, %al
	callq	_fprintf
	movl	$-1, -4(%rbp)
	jmp	LBB7_29
LBB7_7:                                 ##   in Loop: Header=BB7_1 Depth=1
	movl	-60(%rbp), %eax
	movq	-40(%rbp), %rcx
	movslq	-44(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movl	-44(%rbp), %eax
	cmpl	-60(%rbp), %eax
	je	LBB7_9
## %bb.8:                               ##   in Loop: Header=BB7_1 Depth=1
	movl	-12(%rbp), %edi
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	-24(%rbp), %rdx
	movl	-28(%rbp), %ecx
	imull	-60(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$1, %ecx
	movq	%rdx, -88(%rbp)                 ## 8-byte Spill
	movl	%ecx, %edx
	movq	-88(%rbp), %rax                 ## 8-byte Reload
	movl	%ecx, -92(%rbp)                 ## 4-byte Spill
	movq	%rax, %rcx
	movl	-92(%rbp), %r8d                 ## 4-byte Reload
	callq	_dswap_1
LBB7_9:                                 ##   in Loop: Header=BB7_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
LBB7_10:                                ##   Parent Loop BB7_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-48(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB7_13
## %bb.11:                              ##   in Loop: Header=BB7_10 Depth=2
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vdivsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.12:                              ##   in Loop: Header=BB7_10 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB7_10
LBB7_13:                                ##   in Loop: Header=BB7_1 Depth=1
	movl	-44(%rbp), %eax
	movl	-8(%rbp), %ecx
	cmpl	-12(%rbp), %ecx
	movl	%eax, -96(%rbp)                 ## 4-byte Spill
	jge	LBB7_15
## %bb.14:                              ##   in Loop: Header=BB7_1 Depth=1
	movl	-8(%rbp), %eax
	movl	%eax, -100(%rbp)                ## 4-byte Spill
	jmp	LBB7_16
LBB7_15:                                ##   in Loop: Header=BB7_1 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -100(%rbp)                ## 4-byte Spill
LBB7_16:                                ##   in Loop: Header=BB7_1 Depth=1
	movl	-100(%rbp), %eax                ## 4-byte Reload
	movl	-96(%rbp), %ecx                 ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB7_26
## %bb.17:                              ##   in Loop: Header=BB7_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
LBB7_18:                                ##   Parent Loop BB7_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB7_20 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB7_25
## %bb.19:                              ##   in Loop: Header=BB7_18 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -64(%rbp)
LBB7_20:                                ##   Parent Loop BB7_1 Depth=1
                                        ##     Parent Loop BB7_18 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-64(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB7_23
## %bb.21:                              ##   in Loop: Header=BB7_20 Depth=3
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-64(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-64(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-64(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.22:                              ##   in Loop: Header=BB7_20 Depth=3
	movl	-64(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -64(%rbp)
	jmp	LBB7_20
LBB7_23:                                ##   in Loop: Header=BB7_18 Depth=2
	jmp	LBB7_24
LBB7_24:                                ##   in Loop: Header=BB7_18 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB7_18
LBB7_25:                                ##   in Loop: Header=BB7_1 Depth=1
	jmp	LBB7_26
LBB7_26:                                ##   in Loop: Header=BB7_1 Depth=1
	jmp	LBB7_27
LBB7_27:                                ##   in Loop: Header=BB7_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB7_1
LBB7_28:
	movl	$0, -4(%rbp)
LBB7_29:
	movl	-4(%rbp), %eax
	addq	$112, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4                               ## -- Begin function isamax_1
LCPI8_0:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	4, 0x90
_isamax_1:                              ## @isamax_1
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	xorl	%eax, %eax
	movl	%edi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	cmpl	-8(%rbp), %eax
	jne	LBB8_2
## %bb.1:
	movl	$0, -4(%rbp)
	jmp	LBB8_15
LBB8_2:
	xorl	%eax, %eax
	cmpl	-20(%rbp), %eax
	setl	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB8_4
## %bb.3:
	leaq	L___func__.isamax_1(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.5(%rip), %rcx
	movl	$333, %edx                      ## imm = 0x14D
	callq	___assert_rtn
LBB8_4:
	jmp	LBB8_5
LBB8_5:
	movq	-16(%rbp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovdqa	LCPI8_0(%rip), %xmm1            ## xmm1 = [NaN,NaN]
	vpand	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, -32(%rbp)
	movl	$0, -48(%rbp)
	movl	-20(%rbp), %ecx
	addl	$0, %ecx
	movl	%ecx, -52(%rbp)
	movl	$1, -44(%rbp)
LBB8_6:                                 ## =>This Inner Loop Header: Depth=1
	movl	-44(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB8_14
## %bb.7:                               ##   in Loop: Header=BB8_6 Depth=1
	movl	-52(%rbp), %eax
	movl	-44(%rbp), %ecx
	imull	-20(%rbp), %ecx
	cmpl	%ecx, %eax
	sete	%dl
	xorb	$-1, %dl
	andb	$1, %dl
	movzbl	%dl, %eax
	movslq	%eax, %rsi
	cmpq	$0, %rsi
	je	LBB8_9
## %bb.8:
	leaq	L___func__.isamax_1(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.6(%rip), %rcx
	movl	$346, %edx                      ## imm = 0x15A
	callq	___assert_rtn
LBB8_9:                                 ##   in Loop: Header=BB8_6 Depth=1
	jmp	LBB8_10
LBB8_10:                                ##   in Loop: Header=BB8_6 Depth=1
	movq	-16(%rbp), %rax
	movslq	-52(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovdqa	LCPI8_0(%rip), %xmm1            ## xmm1 = [NaN,NaN]
	vpand	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, -40(%rbp)
	vmovsd	-40(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vucomisd	-32(%rbp), %xmm0
	jbe	LBB8_12
## %bb.11:                              ##   in Loop: Header=BB8_6 Depth=1
	vmovsd	-40(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -32(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, -48(%rbp)
LBB8_12:                                ##   in Loop: Header=BB8_6 Depth=1
	jmp	LBB8_13
LBB8_13:                                ##   in Loop: Header=BB8_6 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	movl	-20(%rbp), %eax
	addl	-52(%rbp), %eax
	movl	%eax, -52(%rbp)
	jmp	LBB8_6
LBB8_14:
	movl	-48(%rbp), %eax
	movl	%eax, -4(%rbp)
LBB8_15:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dswap_1
_dswap_1:                               ## @dswap_1
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	xorl	%eax, %eax
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	cmpl	-4(%rbp), %eax
	setl	%r9b
	xorb	$-1, %r9b
	andb	$1, %r9b
	movzbl	%r9b, %eax
	movslq	%eax, %rcx
	cmpq	$0, %rcx
	je	LBB9_2
## %bb.1:
	leaq	L___func__.dswap_1(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.7(%rip), %rcx
	movl	$363, %edx                      ## imm = 0x16B
	callq	___assert_rtn
LBB9_2:
	jmp	LBB9_3
LBB9_3:
	xorl	%eax, %eax
	cmpl	-20(%rbp), %eax
	setl	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB9_5
## %bb.4:
	leaq	L___func__.dswap_1(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.8(%rip), %rcx
	movl	$364, %edx                      ## imm = 0x16C
	callq	___assert_rtn
LBB9_5:
	jmp	LBB9_6
LBB9_6:
	xorl	%eax, %eax
	cmpl	-36(%rbp), %eax
	setl	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB9_8
## %bb.7:
	leaq	L___func__.dswap_1(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.9(%rip), %rcx
	movl	$365, %edx                      ## imm = 0x16D
	callq	___assert_rtn
LBB9_8:
	jmp	LBB9_9
LBB9_9:
	movl	$0, -52(%rbp)
	movl	$0, -56(%rbp)
	movl	$0, -60(%rbp)
LBB9_10:                                ## =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB9_13
## %bb.11:                              ##   in Loop: Header=BB9_10 Depth=1
	movq	-16(%rbp), %rax
	movslq	-56(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -48(%rbp)
	movq	-32(%rbp), %rax
	movslq	-60(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movslq	-56(%rbp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
	vmovsd	-48(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movslq	-60(%rbp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
## %bb.12:                              ##   in Loop: Header=BB9_10 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	movl	-20(%rbp), %eax
	addl	-56(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-36(%rbp), %eax
	addl	-60(%rbp), %eax
	movl	%eax, -60(%rbp)
	jmp	LBB9_10
LBB9_13:
	addq	$64, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function lu_solve_1
LCPI10_0:
	.quad	0xbff0000000000000              ## double -1
LCPI10_1:
	.quad	0x3ff0000000000000              ## double 1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_lu_solve_1
	.p2align	4, 0x90
_lu_solve_1:                            ## @lu_solve_1
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$160, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movl	%edi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	_scratch_ipiv(%rip), %rax
	movq	%rax, -48(%rbp)
	movl	$32, -52(%rbp)
	movl	-24(%rbp), %ecx
	movl	%ecx, -60(%rbp)
	movl	-24(%rbp), %ecx
	movl	%ecx, -64(%rbp)
	movl	-24(%rbp), %ecx
	cmpl	-52(%rbp), %ecx
	jge	LBB10_4
## %bb.1:
	movl	-60(%rbp), %edi
	movl	-24(%rbp), %esi
	movq	-32(%rbp), %rdx
	movl	-64(%rbp), %ecx
	movq	-48(%rbp), %r8
	callq	_dgetf2_1
	movl	%eax, -56(%rbp)
	cmpl	$0, -56(%rbp)
	je	LBB10_3
## %bb.2:
	movl	-56(%rbp), %eax
	movl	%eax, -20(%rbp)
	jmp	LBB10_35
LBB10_3:
	jmp	LBB10_34
LBB10_4:
	movl	$0, -68(%rbp)
LBB10_5:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB10_21 Depth 2
	movl	-68(%rbp), %eax
	movl	-60(%rbp), %ecx
	cmpl	-24(%rbp), %ecx
	movl	%eax, -80(%rbp)                 ## 4-byte Spill
	jge	LBB10_7
## %bb.6:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-60(%rbp), %eax
	movl	%eax, -84(%rbp)                 ## 4-byte Spill
	jmp	LBB10_8
LBB10_7:                                ##   in Loop: Header=BB10_5 Depth=1
	movl	-24(%rbp), %eax
	movl	%eax, -84(%rbp)                 ## 4-byte Spill
LBB10_8:                                ##   in Loop: Header=BB10_5 Depth=1
	movl	-84(%rbp), %eax                 ## 4-byte Reload
	movl	-80(%rbp), %ecx                 ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB10_33
## %bb.9:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-60(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	LBB10_11
## %bb.10:                              ##   in Loop: Header=BB10_5 Depth=1
	movl	-60(%rbp), %eax
	movl	%eax, -88(%rbp)                 ## 4-byte Spill
	jmp	LBB10_12
LBB10_11:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-24(%rbp), %eax
	movl	%eax, -88(%rbp)                 ## 4-byte Spill
LBB10_12:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-88(%rbp), %eax                 ## 4-byte Reload
	subl	-68(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jge	LBB10_17
## %bb.13:                              ##   in Loop: Header=BB10_5 Depth=1
	movl	-60(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	LBB10_15
## %bb.14:                              ##   in Loop: Header=BB10_5 Depth=1
	movl	-60(%rbp), %eax
	movl	%eax, -92(%rbp)                 ## 4-byte Spill
	jmp	LBB10_16
LBB10_15:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-24(%rbp), %eax
	movl	%eax, -92(%rbp)                 ## 4-byte Spill
LBB10_16:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-92(%rbp), %eax                 ## 4-byte Reload
	subl	-68(%rbp), %eax
	movl	%eax, -96(%rbp)                 ## 4-byte Spill
	jmp	LBB10_18
LBB10_17:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-52(%rbp), %eax
	movl	%eax, -96(%rbp)                 ## 4-byte Spill
LBB10_18:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-96(%rbp), %eax                 ## 4-byte Reload
	movl	%eax, -72(%rbp)
	movl	-60(%rbp), %eax
	subl	-68(%rbp), %eax
	movl	-72(%rbp), %esi
	movq	-32(%rbp), %rcx
	movl	-24(%rbp), %edx
	imull	-68(%rbp), %edx
	addl	-68(%rbp), %edx
	movslq	%edx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rcx
	movl	-64(%rbp), %edx
	movq	-48(%rbp), %rdi
	movslq	-68(%rbp), %r8
	shlq	$2, %r8
	addq	%r8, %rdi
	movq	%rdi, -104(%rbp)                ## 8-byte Spill
	movl	%eax, %edi
	movl	%edx, -108(%rbp)                ## 4-byte Spill
	movq	%rcx, %rdx
	movl	-108(%rbp), %ecx                ## 4-byte Reload
	movq	-104(%rbp), %r8                 ## 8-byte Reload
	callq	_dgetf2_1
	movl	%eax, -56(%rbp)
	cmpl	$0, -56(%rbp)
	je	LBB10_20
## %bb.19:
	movl	-56(%rbp), %eax
	movl	%eax, -20(%rbp)
	jmp	LBB10_35
LBB10_20:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-68(%rbp), %eax
	movl	%eax, -76(%rbp)
LBB10_21:                               ##   Parent Loop BB10_5 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-76(%rbp), %eax
	movl	-60(%rbp), %ecx
	movl	-68(%rbp), %edx
	addl	-72(%rbp), %edx
	cmpl	%edx, %ecx
	movl	%eax, -112(%rbp)                ## 4-byte Spill
	jge	LBB10_23
## %bb.22:                              ##   in Loop: Header=BB10_21 Depth=2
	movl	-60(%rbp), %eax
	movl	%eax, -116(%rbp)                ## 4-byte Spill
	jmp	LBB10_24
LBB10_23:                               ##   in Loop: Header=BB10_21 Depth=2
	movl	-68(%rbp), %eax
	addl	-72(%rbp), %eax
	movl	%eax, -116(%rbp)                ## 4-byte Spill
LBB10_24:                               ##   in Loop: Header=BB10_21 Depth=2
	movl	-116(%rbp), %eax                ## 4-byte Reload
	movl	-112(%rbp), %ecx                ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB10_27
## %bb.25:                              ##   in Loop: Header=BB10_21 Depth=2
	movq	-48(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	addl	-68(%rbp), %edx
	movq	-48(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
## %bb.26:                              ##   in Loop: Header=BB10_21 Depth=2
	movl	-76(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -76(%rbp)
	jmp	LBB10_21
LBB10_27:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-68(%rbp), %edi
	movq	-32(%rbp), %rsi
	movl	-64(%rbp), %edx
	movl	-68(%rbp), %ecx
	movl	-68(%rbp), %eax
	addl	-72(%rbp), %eax
	movq	-48(%rbp), %r9
	movl	%eax, %r8d
	movl	$1, (%rsp)
	callq	_dlaswp_1
	movl	-68(%rbp), %eax
	addl	-72(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	LBB10_31
## %bb.28:                              ##   in Loop: Header=BB10_5 Depth=1
	movl	-24(%rbp), %eax
	subl	-68(%rbp), %eax
	subl	-72(%rbp), %eax
	movq	-32(%rbp), %rcx
	imull	$0, -24(%rbp), %edx
	movl	-68(%rbp), %esi
	addl	-72(%rbp), %esi
	addl	%esi, %edx
	movslq	%edx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rcx
	movl	-64(%rbp), %edx
	movl	-68(%rbp), %esi
	movl	-68(%rbp), %r8d
	addl	-72(%rbp), %r8d
	movq	-48(%rbp), %r9
	movl	%eax, %edi
	movl	%esi, -120(%rbp)                ## 4-byte Spill
	movq	%rcx, %rsi
	movl	-120(%rbp), %ecx                ## 4-byte Reload
	movl	$1, (%rsp)
	callq	_dlaswp_1
	movl	-72(%rbp), %edi
	movl	-24(%rbp), %eax
	subl	-68(%rbp), %eax
	subl	-72(%rbp), %eax
	movq	-32(%rbp), %rsi
	movl	-24(%rbp), %ecx
	imull	-68(%rbp), %ecx
	addl	-68(%rbp), %ecx
	movslq	%ecx, %r9
	shlq	$3, %r9
	addq	%r9, %rsi
	movl	-64(%rbp), %ecx
	movq	-32(%rbp), %r9
	movl	-24(%rbp), %edx
	imull	-68(%rbp), %edx
	movl	-68(%rbp), %r8d
	addl	-72(%rbp), %r8d
	addl	%r8d, %edx
	movslq	%edx, %r10
	shlq	$3, %r10
	addq	%r10, %r9
	movl	-64(%rbp), %edx
	movq	%rsi, -128(%rbp)                ## 8-byte Spill
	movl	%eax, %esi
	movq	-128(%rbp), %r10                ## 8-byte Reload
	movl	%edx, -132(%rbp)                ## 4-byte Spill
	movq	%r10, %rdx
	movq	%r9, %r8
	movl	-132(%rbp), %r9d                ## 4-byte Reload
	callq	_dtrsm_L_1
	movl	-68(%rbp), %eax
	addl	-72(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jge	LBB10_30
## %bb.29:                              ##   in Loop: Header=BB10_5 Depth=1
	vmovsd	LCPI10_0(%rip), %xmm0           ## xmm0 = mem[0],zero
	vmovsd	LCPI10_1(%rip), %xmm1           ## xmm1 = mem[0],zero
	movl	-60(%rbp), %eax
	subl	-68(%rbp), %eax
	subl	-72(%rbp), %eax
	movl	-24(%rbp), %ecx
	subl	-68(%rbp), %ecx
	subl	-72(%rbp), %ecx
	movl	-72(%rbp), %edx
	movq	-32(%rbp), %rsi
	movl	-24(%rbp), %edi
	movl	-68(%rbp), %r8d
	addl	-72(%rbp), %r8d
	imull	%r8d, %edi
	addl	-68(%rbp), %edi
	movslq	%edi, %r9
	shlq	$3, %r9
	addq	%r9, %rsi
	movl	-64(%rbp), %r8d
	movq	-32(%rbp), %r9
	movl	-24(%rbp), %edi
	imull	-68(%rbp), %edi
	movl	-68(%rbp), %r10d
	addl	-72(%rbp), %r10d
	addl	%r10d, %edi
	movslq	%edi, %r11
	shlq	$3, %r11
	addq	%r11, %r9
	movl	-64(%rbp), %edi
	movq	-32(%rbp), %r11
	movl	-24(%rbp), %r10d
	movl	-68(%rbp), %ebx
	addl	-72(%rbp), %ebx
	imull	%ebx, %r10d
	movl	-68(%rbp), %ebx
	addl	-72(%rbp), %ebx
	addl	%ebx, %r10d
	movslq	%r10d, %r14
	shlq	$3, %r14
	addq	%r14, %r11
	movl	-64(%rbp), %r10d
	movl	%edi, -136(%rbp)                ## 4-byte Spill
	movl	%eax, %edi
	movq	%rsi, -144(%rbp)                ## 8-byte Spill
	movl	%ecx, %esi
	movq	-144(%rbp), %rcx                ## 8-byte Reload
	movl	-136(%rbp), %eax                ## 4-byte Reload
	movl	%eax, (%rsp)
	movq	%r11, 8(%rsp)
	movl	%r10d, 16(%rsp)
	callq	_dgemm_1
LBB10_30:                               ##   in Loop: Header=BB10_5 Depth=1
	jmp	LBB10_31
LBB10_31:                               ##   in Loop: Header=BB10_5 Depth=1
	jmp	LBB10_32
LBB10_32:                               ##   in Loop: Header=BB10_5 Depth=1
	movl	-52(%rbp), %eax
	addl	-68(%rbp), %eax
	movl	%eax, -68(%rbp)
	jmp	LBB10_5
LBB10_33:
	jmp	LBB10_34
LBB10_34:
	movl	-24(%rbp), %edi
	movq	-32(%rbp), %rsi
	movq	-48(%rbp), %rdx
	movq	-40(%rbp), %rcx
	callq	_dgetrs_1
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -20(%rbp)
LBB10_35:
	movl	-20(%rbp), %eax
	addq	$160, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dlaswp_1
_dlaswp_1:                              ## @dlaswp_1
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movl	16(%rbp), %eax
	xorl	%r10d, %r10d
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movq	%r9, -40(%rbp)
	cmpl	16(%rbp), %r10d
	setl	%r11b
	xorb	$-1, %r11b
	andb	$1, %r11b
	movzbl	%r11b, %ecx
	movslq	%ecx, %rsi
	cmpq	$0, %rsi
	je	LBB11_2
## %bb.1:
	leaq	L___func__.dlaswp_1(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.8(%rip), %rcx
	movl	$385, %edx                      ## imm = 0x181
	callq	___assert_rtn
LBB11_2:
	jmp	LBB11_3
LBB11_3:
	movl	-24(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-48(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -52(%rbp)
LBB11_4:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB11_7 Depth 2
	movl	-52(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	LBB11_13
## %bb.5:                               ##   in Loop: Header=BB11_4 Depth=1
	movq	-40(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movl	%edx, -60(%rbp)
	movl	-60(%rbp), %edx
	cmpl	-52(%rbp), %edx
	je	LBB11_11
## %bb.6:                               ##   in Loop: Header=BB11_4 Depth=1
	movl	$0, -56(%rbp)
LBB11_7:                                ##   Parent Loop BB11_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-56(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB11_10
## %bb.8:                               ##   in Loop: Header=BB11_7 Depth=2
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-52(%rbp), %ecx
	addl	-56(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -72(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	addl	-56(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-52(%rbp), %ecx
	addl	-56(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	addl	-56(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.9:                               ##   in Loop: Header=BB11_7 Depth=2
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB11_7
LBB11_10:                               ##   in Loop: Header=BB11_4 Depth=1
	jmp	LBB11_11
LBB11_11:                               ##   in Loop: Header=BB11_4 Depth=1
	jmp	LBB11_12
LBB11_12:                               ##   in Loop: Header=BB11_4 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	movl	16(%rbp), %eax
	addl	-44(%rbp), %eax
	movl	%eax, -44(%rbp)
	jmp	LBB11_4
LBB11_13:
	addq	$80, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function dtrsm_L_1
LCPI12_0:
	.quad	0x3bc79ca10c924223              ## double 9.9999999999999995E-21
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI12_1:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	4, 0x90
_dtrsm_L_1:                             ## @dtrsm_L_1
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movq	%rdx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movl	$0, -44(%rbp)
LBB12_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB12_3 Depth 2
                                        ##       Child Loop BB12_6 Depth 3
	movl	-44(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB12_14
## %bb.2:                               ##   in Loop: Header=BB12_1 Depth=1
	movl	$0, -48(%rbp)
LBB12_3:                                ##   Parent Loop BB12_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB12_6 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB12_12
## %bb.4:                               ##   in Loop: Header=BB12_3 Depth=2
	vmovsd	LCPI12_0(%rip), %xmm0           ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	vxorps	%xmm2, %xmm2, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovdqa	LCPI12_1(%rip), %xmm2           ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	jae	LBB12_10
## %bb.5:                               ##   in Loop: Header=BB12_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
LBB12_6:                                ##   Parent Loop BB12_1 Depth=1
                                        ##     Parent Loop BB12_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-40(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB12_9
## %bb.7:                               ##   in Loop: Header=BB12_6 Depth=3
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.8:                               ##   in Loop: Header=BB12_6 Depth=3
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	LBB12_6
LBB12_9:                                ##   in Loop: Header=BB12_3 Depth=2
	jmp	LBB12_10
LBB12_10:                               ##   in Loop: Header=BB12_3 Depth=2
	jmp	LBB12_11
LBB12_11:                               ##   in Loop: Header=BB12_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB12_3
LBB12_12:                               ##   in Loop: Header=BB12_1 Depth=1
	jmp	LBB12_13
LBB12_13:                               ##   in Loop: Header=BB12_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB12_1
LBB12_14:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function dgemm_1
LCPI13_0:
	.quad	0x3bc79ca10c924223              ## double 9.9999999999999995E-21
LCPI13_2:
	.quad	0x3ff0000000000000              ## double 1
LCPI13_3:
	.quad	0xbff0000000000000              ## double -1
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI13_1:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	4, 0x90
_dgemm_1:                               ## @dgemm_1
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$88, %rsp
	.cfi_offset %rbx, -24
	movl	32(%rbp), %eax
	movq	24(%rbp), %r10
	movl	16(%rbp), %r11d
	vmovsd	LCPI13_0(%rip), %xmm2           ## xmm2 = mem[0],zero
	vmovsd	LCPI13_2(%rip), %xmm3           ## xmm3 = mem[0],zero
	movl	%edi, -12(%rbp)
	movl	%esi, -16(%rbp)
	movl	%edx, -20(%rbp)
	vmovsd	%xmm0, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	%r8d, -44(%rbp)
	movq	%r9, -56(%rbp)
	vmovsd	%xmm1, -64(%rbp)
	vmovsd	-64(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vsubsd	%xmm3, %xmm0, %xmm0
	vmovdqa	LCPI13_1(%rip), %xmm1           ## xmm1 = [NaN,NaN]
	vpand	%xmm1, %xmm0, %xmm0
	vucomisd	%xmm0, %xmm2
	setae	%bl
	xorb	$-1, %bl
	andb	$1, %bl
	movzbl	%bl, %edx
	movslq	%edx, %rcx
	cmpq	$0, %rcx
	je	LBB13_2
## %bb.1:
	leaq	L___func__.dgemm_1(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.2(%rip), %rcx
	movl	$454, %edx                      ## imm = 0x1C6
	callq	___assert_rtn
LBB13_2:
	jmp	LBB13_3
LBB13_3:
	vmovsd	LCPI13_0(%rip), %xmm0           ## xmm0 = mem[0],zero
	vmovsd	LCPI13_3(%rip), %xmm1           ## xmm1 = mem[0],zero
	vmovsd	-32(%rbp), %xmm2                ## xmm2 = mem[0],zero
	vsubsd	%xmm1, %xmm2, %xmm1
	vmovdqa	LCPI13_1(%rip), %xmm2           ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	setae	%al
	xorb	$-1, %al
	andb	$1, %al
	movzbl	%al, %ecx
	movslq	%ecx, %rdx
	cmpq	$0, %rdx
	je	LBB13_5
## %bb.4:
	leaq	L___func__.dgemm_1(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.3(%rip), %rcx
	movl	$455, %edx                      ## imm = 0x1C7
	callq	___assert_rtn
LBB13_5:
	jmp	LBB13_6
LBB13_6:
	movl	$0, -68(%rbp)
LBB13_7:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB13_9 Depth 2
                                        ##       Child Loop BB13_11 Depth 3
	movl	-68(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB13_18
## %bb.8:                               ##   in Loop: Header=BB13_7 Depth=1
	movl	$0, -72(%rbp)
LBB13_9:                                ##   Parent Loop BB13_7 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB13_11 Depth 3
	movl	-72(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	LBB13_16
## %bb.10:                              ##   in Loop: Header=BB13_9 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	imull	-68(%rbp), %ecx
	addl	-72(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movl	$0, -76(%rbp)
LBB13_11:                               ##   Parent Loop BB13_7 Depth=1
                                        ##     Parent Loop BB13_9 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-76(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	LBB13_14
## %bb.12:                              ##   in Loop: Header=BB13_11 Depth=3
	vmovsd	-32(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	imull	-68(%rbp), %ecx
	addl	-76(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	imull	-76(%rbp), %ecx
	addl	-72(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm0, %xmm0
	vaddsd	-88(%rbp), %xmm0, %xmm0
	vmovsd	%xmm0, -88(%rbp)
## %bb.13:                              ##   in Loop: Header=BB13_11 Depth=3
	movl	-76(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -76(%rbp)
	jmp	LBB13_11
LBB13_14:                               ##   in Loop: Header=BB13_9 Depth=2
	vmovsd	-88(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	imull	-68(%rbp), %ecx
	addl	-72(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.15:                              ##   in Loop: Header=BB13_9 Depth=2
	movl	-72(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -72(%rbp)
	jmp	LBB13_9
LBB13_16:                               ##   in Loop: Header=BB13_7 Depth=1
	jmp	LBB13_17
LBB13_17:                               ##   in Loop: Header=BB13_7 Depth=1
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -68(%rbp)
	jmp	LBB13_7
LBB13_18:
	addq	$88, %rsp
	popq	%rbx
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dgetrs_1
_dgetrs_1:                              ## @dgetrs_1
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	xorl	%eax, %eax
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	-32(%rbp), %rsi
	movl	-4(%rbp), %r8d
	movq	-24(%rbp), %r9
	movl	$1, %edi
	movl	%edi, -36(%rbp)                 ## 4-byte Spill
	movl	-36(%rbp), %edx                 ## 4-byte Reload
	movl	%eax, %ecx
	movl	$1, (%rsp)
	callq	_dlaswp_1
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %ecx
	movq	-32(%rbp), %r8
	movl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %r9d
	callq	_dtrsm_L_1
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %ecx
	movq	-32(%rbp), %r8
	movl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %r9d
	callq	_dtrsm_U_1
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function dgetf2_2
LCPI15_0:
	.quad	0x3bc79ca10c924223              ## double 9.9999999999999995E-21
LCPI15_2:
	.quad	0x3ff0000000000000              ## double 1
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI15_1:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_dgetf2_2
	.p2align	4, 0x90
_dgetf2_2:                              ## @dgetf2_2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$240, %rsp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movq	%r8, -40(%rbp)
	cmpl	$0, -8(%rbp)
	je	LBB15_2
## %bb.1:
	cmpl	$0, -12(%rbp)
	jne	LBB15_3
LBB15_2:
	movl	$0, -4(%rbp)
	jmp	LBB15_36
LBB15_3:
	movl	$0, -44(%rbp)
LBB15_4:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB15_13 Depth 2
                                        ##     Child Loop BB15_21 Depth 2
                                        ##       Child Loop BB15_23 Depth 3
                                        ##       Child Loop BB15_27 Depth 3
	movl	-44(%rbp), %eax
	movl	-8(%rbp), %ecx
	cmpl	-12(%rbp), %ecx
	movl	%eax, -204(%rbp)                ## 4-byte Spill
	jge	LBB15_6
## %bb.5:                               ##   in Loop: Header=BB15_4 Depth=1
	movl	-8(%rbp), %eax
	movl	%eax, -208(%rbp)                ## 4-byte Spill
	jmp	LBB15_7
LBB15_6:                                ##   in Loop: Header=BB15_4 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -208(%rbp)                ## 4-byte Spill
LBB15_7:                                ##   in Loop: Header=BB15_4 Depth=1
	movl	-208(%rbp), %eax                ## 4-byte Reload
	movl	-204(%rbp), %ecx                ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB15_35
## %bb.8:                               ##   in Loop: Header=BB15_4 Depth=1
	movl	-44(%rbp), %eax
	movl	-8(%rbp), %ecx
	subl	-44(%rbp), %ecx
	movq	-24(%rbp), %rdx
	movl	-28(%rbp), %esi
	imull	-44(%rbp), %esi
	addl	-44(%rbp), %esi
	movslq	%esi, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rdx
	movl	-28(%rbp), %esi
	movl	%ecx, %edi
	movl	%esi, -212(%rbp)                ## 4-byte Spill
	movq	%rdx, %rsi
	movl	-212(%rbp), %edx                ## 4-byte Reload
	movl	%eax, -216(%rbp)                ## 4-byte Spill
	callq	_isamax_2
	vmovsd	LCPI15_0(%rip), %xmm0           ## xmm0 = mem[0],zero
	movl	-216(%rbp), %ecx                ## 4-byte Reload
	addl	%eax, %ecx
	movl	%ecx, -56(%rbp)
	movq	-24(%rbp), %rsi
	movl	-28(%rbp), %eax
	imull	-56(%rbp), %eax
	addl	-44(%rbp), %eax
	movslq	%eax, %r8
	vmovsd	(%rsi,%r8,8), %xmm1             ## xmm1 = mem[0],zero
	vmovsd	%xmm1, -64(%rbp)
	vmovsd	-64(%rbp), %xmm1                ## xmm1 = mem[0],zero
	vxorps	%xmm2, %xmm2, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovdqa	LCPI15_1(%rip), %xmm2           ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	jb	LBB15_10
## %bb.9:
	movq	___stderrp@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	L_.str(%rip), %rsi
	movb	$0, %al
	callq	_fprintf
	movl	$-1, -4(%rbp)
	jmp	LBB15_36
LBB15_10:                               ##   in Loop: Header=BB15_4 Depth=1
	movl	-56(%rbp), %eax
	movq	-40(%rbp), %rcx
	movslq	-44(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movl	-44(%rbp), %eax
	cmpl	-56(%rbp), %eax
	je	LBB15_12
## %bb.11:                              ##   in Loop: Header=BB15_4 Depth=1
	movl	-12(%rbp), %edi
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	-24(%rbp), %rdx
	movl	-28(%rbp), %ecx
	imull	-56(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$1, %ecx
	movq	%rdx, -224(%rbp)                ## 8-byte Spill
	movl	%ecx, %edx
	movq	-224(%rbp), %rax                ## 8-byte Reload
	movl	%ecx, -228(%rbp)                ## 4-byte Spill
	movq	%rax, %rcx
	movl	-228(%rbp), %r8d                ## 4-byte Reload
	callq	_dswap_2
LBB15_12:                               ##   in Loop: Header=BB15_4 Depth=1
	vmovsd	LCPI15_2(%rip), %xmm0           ## xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vdivsd	(%rax,%rdx,8), %xmm0, %xmm0
	vmovsd	%xmm0, -72(%rbp)
	movl	-44(%rbp), %ecx
	addl	$1, %ecx
	movl	%ecx, -48(%rbp)
LBB15_13:                               ##   Parent Loop BB15_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-48(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB15_16
## %bb.14:                              ##   in Loop: Header=BB15_13 Depth=2
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.15:                              ##   in Loop: Header=BB15_13 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB15_13
LBB15_16:                               ##   in Loop: Header=BB15_4 Depth=1
	movl	-44(%rbp), %eax
	movl	-8(%rbp), %ecx
	cmpl	-12(%rbp), %ecx
	movl	%eax, -232(%rbp)                ## 4-byte Spill
	jge	LBB15_18
## %bb.17:                              ##   in Loop: Header=BB15_4 Depth=1
	movl	-8(%rbp), %eax
	movl	%eax, -236(%rbp)                ## 4-byte Spill
	jmp	LBB15_19
LBB15_18:                               ##   in Loop: Header=BB15_4 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -236(%rbp)                ## 4-byte Spill
LBB15_19:                               ##   in Loop: Header=BB15_4 Depth=1
	movl	-236(%rbp), %eax                ## 4-byte Reload
	movl	-232(%rbp), %ecx                ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB15_33
## %bb.20:                              ##   in Loop: Header=BB15_4 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
LBB15_21:                               ##   Parent Loop BB15_4 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB15_23 Depth 3
                                        ##       Child Loop BB15_27 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB15_32
## %bb.22:                              ##   in Loop: Header=BB15_21 Depth=2
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx     ## imm = 0x8000000000000000
	xorq	%rdx, %rax
	vmovq	%rax, %xmm0
	vmovsd	%xmm0, -72(%rbp)
	movl	-44(%rbp), %ecx
	addl	$1, %ecx
	movl	%ecx, -52(%rbp)
LBB15_23:                               ##   Parent Loop BB15_4 Depth=1
                                        ##     Parent Loop BB15_21 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-52(%rbp), %eax
	movl	-12(%rbp), %ecx
	subl	$7, %ecx
	cmpl	%ecx, %eax
	jge	LBB15_26
## %bb.24:                              ##   in Loop: Header=BB15_23 Depth=3
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -96(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -104(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -112(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -120(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -128(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-144(%rbp), %xmm0, %xmm0
	vaddsd	-80(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-152(%rbp), %xmm0, %xmm0
	vaddsd	-88(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-160(%rbp), %xmm0, %xmm0
	vaddsd	-96(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-168(%rbp), %xmm0, %xmm0
	vaddsd	-104(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-176(%rbp), %xmm0, %xmm0
	vaddsd	-112(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-184(%rbp), %xmm0, %xmm0
	vaddsd	-120(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-192(%rbp), %xmm0, %xmm0
	vaddsd	-128(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-200(%rbp), %xmm0, %xmm0
	vaddsd	-136(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.25:                              ##   in Loop: Header=BB15_23 Depth=3
	movl	-52(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -52(%rbp)
	jmp	LBB15_23
LBB15_26:                               ##   in Loop: Header=BB15_21 Depth=2
	jmp	LBB15_27
LBB15_27:                               ##   Parent Loop BB15_4 Depth=1
                                        ##     Parent Loop BB15_21 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-52(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB15_30
## %bb.28:                              ##   in Loop: Header=BB15_27 Depth=3
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-144(%rbp), %xmm0, %xmm0
	vaddsd	-80(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.29:                              ##   in Loop: Header=BB15_27 Depth=3
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	LBB15_27
LBB15_30:                               ##   in Loop: Header=BB15_21 Depth=2
	jmp	LBB15_31
LBB15_31:                               ##   in Loop: Header=BB15_21 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB15_21
LBB15_32:                               ##   in Loop: Header=BB15_4 Depth=1
	jmp	LBB15_33
LBB15_33:                               ##   in Loop: Header=BB15_4 Depth=1
	jmp	LBB15_34
LBB15_34:                               ##   in Loop: Header=BB15_4 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB15_4
LBB15_35:
	movl	$0, -4(%rbp)
LBB15_36:
	movl	-4(%rbp), %eax
	addq	$240, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4                               ## -- Begin function isamax_2
LCPI16_0:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	4, 0x90
_isamax_2:                              ## @isamax_2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	xorl	%eax, %eax
	movl	%edi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	cmpl	-8(%rbp), %eax
	setle	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rsi
	cmpq	$0, %rsi
	je	LBB16_2
## %bb.1:
	leaq	L___func__.isamax_2(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.10(%rip), %rcx
	movl	$665, %edx                      ## imm = 0x299
	callq	___assert_rtn
LBB16_2:
	jmp	LBB16_3
LBB16_3:
	cmpl	$1, -8(%rbp)
	jl	LBB16_5
## %bb.4:
	cmpl	$0, -20(%rbp)
	jne	LBB16_6
LBB16_5:
	movl	$0, -4(%rbp)
	jmp	LBB16_19
LBB16_6:
	xorl	%eax, %eax
	cmpl	-20(%rbp), %eax
	setl	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB16_8
## %bb.7:
	leaq	L___func__.isamax_2(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.5(%rip), %rcx
	movl	$671, %edx                      ## imm = 0x29F
	callq	___assert_rtn
LBB16_8:
	jmp	LBB16_9
LBB16_9:
	movq	-16(%rbp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovdqa	LCPI16_0(%rip), %xmm1           ## xmm1 = [NaN,NaN]
	vpand	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, -32(%rbp)
	movl	$0, -48(%rbp)
	movl	-20(%rbp), %ecx
	addl	$0, %ecx
	movl	%ecx, -52(%rbp)
	movl	$1, -44(%rbp)
LBB16_10:                               ## =>This Inner Loop Header: Depth=1
	movl	-44(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB16_18
## %bb.11:                              ##   in Loop: Header=BB16_10 Depth=1
	movl	-52(%rbp), %eax
	movl	-44(%rbp), %ecx
	imull	-20(%rbp), %ecx
	cmpl	%ecx, %eax
	sete	%dl
	xorb	$-1, %dl
	andb	$1, %dl
	movzbl	%dl, %eax
	movslq	%eax, %rsi
	cmpq	$0, %rsi
	je	LBB16_13
## %bb.12:
	leaq	L___func__.isamax_2(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.6(%rip), %rcx
	movl	$684, %edx                      ## imm = 0x2AC
	callq	___assert_rtn
LBB16_13:                               ##   in Loop: Header=BB16_10 Depth=1
	jmp	LBB16_14
LBB16_14:                               ##   in Loop: Header=BB16_10 Depth=1
	movq	-16(%rbp), %rax
	movslq	-52(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovdqa	LCPI16_0(%rip), %xmm1           ## xmm1 = [NaN,NaN]
	vpand	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, -40(%rbp)
	vmovsd	-40(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vucomisd	-32(%rbp), %xmm0
	jbe	LBB16_16
## %bb.15:                              ##   in Loop: Header=BB16_10 Depth=1
	vmovsd	-40(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -32(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, -48(%rbp)
LBB16_16:                               ##   in Loop: Header=BB16_10 Depth=1
	jmp	LBB16_17
LBB16_17:                               ##   in Loop: Header=BB16_10 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	movl	-20(%rbp), %eax
	addl	-52(%rbp), %eax
	movl	%eax, -52(%rbp)
	jmp	LBB16_10
LBB16_18:
	movl	-48(%rbp), %eax
	movl	%eax, -4(%rbp)
LBB16_19:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dswap_2
_dswap_2:                               ## @dswap_2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$256, %rsp                      ## imm = 0x100
	xorl	%eax, %eax
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	cmpl	-4(%rbp), %eax
	setl	%r9b
	xorb	$-1, %r9b
	andb	$1, %r9b
	movzbl	%r9b, %eax
	movslq	%eax, %rcx
	cmpq	$0, %rcx
	je	LBB17_2
## %bb.1:
	leaq	L___func__.dswap_2(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.7(%rip), %rcx
	movl	$699, %edx                      ## imm = 0x2BB
	callq	___assert_rtn
LBB17_2:
	jmp	LBB17_3
LBB17_3:
	xorl	%eax, %eax
	cmpl	-20(%rbp), %eax
	setl	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB17_5
## %bb.4:
	leaq	L___func__.dswap_2(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.8(%rip), %rcx
	movl	$700, %edx                      ## imm = 0x2BC
	callq	___assert_rtn
LBB17_5:
	jmp	LBB17_6
LBB17_6:
	xorl	%eax, %eax
	cmpl	-36(%rbp), %eax
	setl	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB17_8
## %bb.7:
	leaq	L___func__.dswap_2(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.9(%rip), %rcx
	movl	$701, %edx                      ## imm = 0x2BD
	callq	___assert_rtn
LBB17_8:
	jmp	LBB17_9
LBB17_9:
	cmpl	$1, -20(%rbp)
	jne	LBB17_20
## %bb.10:
	cmpl	$1, -36(%rbp)
	jne	LBB17_20
## %bb.11:
	movl	$0, -244(%rbp)
LBB17_12:                               ## =>This Inner Loop Header: Depth=1
	movl	-244(%rbp), %eax
	movl	-4(%rbp), %ecx
	subl	$7, %ecx
	cmpl	%ecx, %eax
	jge	LBB17_15
## %bb.13:                              ##   in Loop: Header=BB17_12 Depth=1
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -120(%rbp)
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$1, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -128(%rbp)
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$2, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$3, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$4, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$5, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$6, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$7, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$1, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$2, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$3, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -208(%rbp)
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$4, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -216(%rbp)
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$5, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -224(%rbp)
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$6, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -232(%rbp)
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$7, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -240(%rbp)
	vmovsd	-184(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-192(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$1, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-200(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$2, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-208(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$3, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-216(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$4, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-224(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$5, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-232(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$6, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-240(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$7, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-120(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-128(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$1, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-136(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$2, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-144(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$3, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-152(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$4, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-160(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$5, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-168(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$6, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-176(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$7, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.14:                              ##   in Loop: Header=BB17_12 Depth=1
	movl	-244(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -244(%rbp)
	jmp	LBB17_12
LBB17_15:
	jmp	LBB17_16
LBB17_16:                               ## =>This Inner Loop Header: Depth=1
	movl	-244(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB17_19
## %bb.17:                              ##   in Loop: Header=BB17_16 Depth=1
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -56(%rbp)
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	-56(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-244(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.18:                              ##   in Loop: Header=BB17_16 Depth=1
	movl	-244(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -244(%rbp)
	jmp	LBB17_16
LBB17_19:
	jmp	LBB17_25
LBB17_20:
	movl	$0, -244(%rbp)
	movl	$0, -248(%rbp)
	movl	$0, -252(%rbp)
LBB17_21:                               ## =>This Inner Loop Header: Depth=1
	movl	-244(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB17_24
## %bb.22:                              ##   in Loop: Header=BB17_21 Depth=1
	movq	-16(%rbp), %rax
	movslq	-248(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -48(%rbp)
	movq	-32(%rbp), %rax
	movslq	-252(%rbp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movslq	-248(%rbp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
	vmovsd	-48(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movslq	-252(%rbp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
## %bb.23:                              ##   in Loop: Header=BB17_21 Depth=1
	movl	-244(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -244(%rbp)
	movl	-20(%rbp), %eax
	addl	-248(%rbp), %eax
	movl	%eax, -248(%rbp)
	movl	-36(%rbp), %eax
	addl	-252(%rbp), %eax
	movl	%eax, -252(%rbp)
	jmp	LBB17_21
LBB17_24:
	jmp	LBB17_25
LBB17_25:
	addq	$256, %rsp                      ## imm = 0x100
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function lu_solve_2
LCPI18_0:
	.quad	0xbff0000000000000              ## double -1
LCPI18_1:
	.quad	0x3ff0000000000000              ## double 1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_lu_solve_2
	.p2align	4, 0x90
_lu_solve_2:                            ## @lu_solve_2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$160, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movl	%edi, -32(%rbp)
	movq	%rsi, -40(%rbp)
	movq	%rdx, -48(%rbp)
	movq	_scratch_ipiv(%rip), %rax
	movq	%rax, -72(%rbp)
	movl	-32(%rbp), %ecx
	movl	-32(%rbp), %edi
	movl	%ecx, -20(%rbp)
	movl	%edi, -24(%rbp)
	movl	$64, -76(%rbp)
	movl	-32(%rbp), %ecx
	movl	%ecx, -80(%rbp)
	movl	-32(%rbp), %ecx
	movl	%ecx, -84(%rbp)
	movl	-32(%rbp), %ecx
	movl	%ecx, -88(%rbp)
	cmpl	$1, -76(%rbp)
	jle	LBB18_2
## %bb.1:
	movl	-76(%rbp), %eax
	cmpl	-88(%rbp), %eax
	jl	LBB18_5
LBB18_2:
	movl	-80(%rbp), %edi
	movl	-32(%rbp), %esi
	movq	-40(%rbp), %rdx
	movl	-84(%rbp), %ecx
	movq	-72(%rbp), %r8
	callq	_dgetf2_2
	movl	%eax, -52(%rbp)
	cmpl	$0, -52(%rbp)
	je	LBB18_4
## %bb.3:
	movl	-52(%rbp), %eax
	movl	%eax, -28(%rbp)
	jmp	LBB18_32
LBB18_4:
	jmp	LBB18_31
LBB18_5:
	movl	$0, -56(%rbp)
LBB18_6:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB18_13 Depth 2
                                        ##     Child Loop BB18_20 Depth 2
	movl	-56(%rbp), %eax
	cmpl	-88(%rbp), %eax
	jge	LBB18_30
## %bb.7:                               ##   in Loop: Header=BB18_6 Depth=1
	movl	-88(%rbp), %eax
	subl	-56(%rbp), %eax
	cmpl	-76(%rbp), %eax
	jge	LBB18_9
## %bb.8:                               ##   in Loop: Header=BB18_6 Depth=1
	movl	-88(%rbp), %eax
	subl	-56(%rbp), %eax
	movl	%eax, -92(%rbp)                 ## 4-byte Spill
	jmp	LBB18_10
LBB18_9:                                ##   in Loop: Header=BB18_6 Depth=1
	movl	-76(%rbp), %eax
	movl	%eax, -92(%rbp)                 ## 4-byte Spill
LBB18_10:                               ##   in Loop: Header=BB18_6 Depth=1
	movl	-92(%rbp), %eax                 ## 4-byte Reload
	movl	%eax, -60(%rbp)
	movl	-80(%rbp), %eax
	subl	-56(%rbp), %eax
	movl	-60(%rbp), %esi
	movq	-40(%rbp), %rcx
	movl	-32(%rbp), %edx
	imull	-56(%rbp), %edx
	addl	-56(%rbp), %edx
	movslq	%edx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rcx
	movl	-84(%rbp), %edx
	movq	-72(%rbp), %rdi
	movslq	-56(%rbp), %r8
	shlq	$2, %r8
	addq	%r8, %rdi
	movq	%rdi, -104(%rbp)                ## 8-byte Spill
	movl	%eax, %edi
	movl	%edx, -108(%rbp)                ## 4-byte Spill
	movq	%rcx, %rdx
	movl	-108(%rbp), %ecx                ## 4-byte Reload
	movq	-104(%rbp), %r8                 ## 8-byte Reload
	callq	_dgetf2_2
	movl	%eax, -52(%rbp)
	cmpl	$0, -52(%rbp)
	je	LBB18_12
## %bb.11:
	movl	-52(%rbp), %eax
	movl	%eax, -28(%rbp)
	jmp	LBB18_32
LBB18_12:                               ##   in Loop: Header=BB18_6 Depth=1
	movl	-56(%rbp), %eax
	movl	%eax, -64(%rbp)
LBB18_13:                               ##   Parent Loop BB18_6 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-64(%rbp), %eax
	movl	-80(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	-60(%rbp), %edx
	cmpl	%edx, %ecx
	movl	%eax, -112(%rbp)                ## 4-byte Spill
	jge	LBB18_15
## %bb.14:                              ##   in Loop: Header=BB18_13 Depth=2
	movl	-80(%rbp), %eax
	movl	%eax, -116(%rbp)                ## 4-byte Spill
	jmp	LBB18_16
LBB18_15:                               ##   in Loop: Header=BB18_13 Depth=2
	movl	-56(%rbp), %eax
	addl	-60(%rbp), %eax
	movl	%eax, -116(%rbp)                ## 4-byte Spill
LBB18_16:                               ##   in Loop: Header=BB18_13 Depth=2
	movl	-116(%rbp), %eax                ## 4-byte Reload
	subl	$7, %eax
	movl	-112(%rbp), %ecx                ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB18_19
## %bb.17:                              ##   in Loop: Header=BB18_13 Depth=2
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$0, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$1, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$1, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$2, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$2, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$3, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$3, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$4, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$4, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$5, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$5, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$6, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$6, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$7, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$7, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
## %bb.18:                              ##   in Loop: Header=BB18_13 Depth=2
	movl	-64(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -64(%rbp)
	jmp	LBB18_13
LBB18_19:                               ##   in Loop: Header=BB18_6 Depth=1
	jmp	LBB18_20
LBB18_20:                               ##   Parent Loop BB18_6 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-64(%rbp), %eax
	movl	-80(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	-60(%rbp), %edx
	cmpl	%edx, %ecx
	movl	%eax, -120(%rbp)                ## 4-byte Spill
	jge	LBB18_22
## %bb.21:                              ##   in Loop: Header=BB18_20 Depth=2
	movl	-80(%rbp), %eax
	movl	%eax, -124(%rbp)                ## 4-byte Spill
	jmp	LBB18_23
LBB18_22:                               ##   in Loop: Header=BB18_20 Depth=2
	movl	-56(%rbp), %eax
	addl	-60(%rbp), %eax
	movl	%eax, -124(%rbp)                ## 4-byte Spill
LBB18_23:                               ##   in Loop: Header=BB18_20 Depth=2
	movl	-124(%rbp), %eax                ## 4-byte Reload
	movl	-120(%rbp), %ecx                ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB18_26
## %bb.24:                              ##   in Loop: Header=BB18_20 Depth=2
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$0, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
## %bb.25:                              ##   in Loop: Header=BB18_20 Depth=2
	movl	-64(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -64(%rbp)
	jmp	LBB18_20
LBB18_26:                               ##   in Loop: Header=BB18_6 Depth=1
	movl	-56(%rbp), %edi
	movq	-40(%rbp), %rsi
	movl	-84(%rbp), %edx
	movl	-56(%rbp), %ecx
	movl	-56(%rbp), %eax
	addl	-60(%rbp), %eax
	movq	-72(%rbp), %r9
	movl	%eax, %r8d
	movl	$1, (%rsp)
	callq	_dlaswp_2
	movl	-56(%rbp), %eax
	addl	-60(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jge	LBB18_28
## %bb.27:                              ##   in Loop: Header=BB18_6 Depth=1
	movl	-32(%rbp), %eax
	subl	-56(%rbp), %eax
	subl	-60(%rbp), %eax
	movq	-40(%rbp), %rcx
	imull	$0, -32(%rbp), %edx
	movl	-56(%rbp), %esi
	addl	-60(%rbp), %esi
	addl	%esi, %edx
	movslq	%edx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rcx
	movl	-84(%rbp), %edx
	movl	-56(%rbp), %esi
	movl	-56(%rbp), %r8d
	addl	-60(%rbp), %r8d
	movq	-72(%rbp), %r9
	movl	%eax, %edi
	movl	%esi, -128(%rbp)                ## 4-byte Spill
	movq	%rcx, %rsi
	movl	-128(%rbp), %ecx                ## 4-byte Reload
	movl	$1, (%rsp)
	callq	_dlaswp_2
	movl	-60(%rbp), %edi
	movl	-32(%rbp), %eax
	subl	-56(%rbp), %eax
	subl	-60(%rbp), %eax
	movq	-40(%rbp), %rsi
	movl	-32(%rbp), %ecx
	imull	-56(%rbp), %ecx
	addl	-56(%rbp), %ecx
	movslq	%ecx, %r9
	shlq	$3, %r9
	addq	%r9, %rsi
	movl	-84(%rbp), %ecx
	movq	-40(%rbp), %r9
	movl	-32(%rbp), %edx
	imull	-56(%rbp), %edx
	movl	-56(%rbp), %r8d
	addl	-60(%rbp), %r8d
	addl	%r8d, %edx
	movslq	%edx, %r10
	shlq	$3, %r10
	addq	%r10, %r9
	movl	-84(%rbp), %edx
	movq	%rsi, -136(%rbp)                ## 8-byte Spill
	movl	%eax, %esi
	movq	-136(%rbp), %r10                ## 8-byte Reload
	movl	%edx, -140(%rbp)                ## 4-byte Spill
	movq	%r10, %rdx
	movq	%r9, %r8
	movl	-140(%rbp), %r9d                ## 4-byte Reload
	callq	_dtrsm_L_2
	vmovsd	LCPI18_0(%rip), %xmm0           ## xmm0 = mem[0],zero
	vmovsd	LCPI18_1(%rip), %xmm1           ## xmm1 = mem[0],zero
	movl	-80(%rbp), %eax
	subl	-56(%rbp), %eax
	subl	-60(%rbp), %eax
	movl	-32(%rbp), %ecx
	subl	-56(%rbp), %ecx
	subl	-60(%rbp), %ecx
	movl	-60(%rbp), %edx
	movq	-40(%rbp), %r8
	movl	-32(%rbp), %esi
	movl	-56(%rbp), %edi
	addl	-60(%rbp), %edi
	imull	%edi, %esi
	addl	-56(%rbp), %esi
	movslq	%esi, %r10
	shlq	$3, %r10
	addq	%r10, %r8
	movl	-84(%rbp), %esi
	movq	-40(%rbp), %r10
	movl	-32(%rbp), %edi
	imull	-56(%rbp), %edi
	movl	-56(%rbp), %r9d
	addl	-60(%rbp), %r9d
	addl	%r9d, %edi
	movslq	%edi, %r11
	shlq	$3, %r11
	addq	%r11, %r10
	movl	-84(%rbp), %edi
	movq	-40(%rbp), %r11
	movl	-32(%rbp), %r9d
	movl	-56(%rbp), %ebx
	addl	-60(%rbp), %ebx
	imull	%ebx, %r9d
	movl	-56(%rbp), %ebx
	addl	-60(%rbp), %ebx
	addl	%ebx, %r9d
	movslq	%r9d, %r14
	shlq	$3, %r14
	addq	%r14, %r11
	movl	-84(%rbp), %r9d
	movl	%edi, -144(%rbp)                ## 4-byte Spill
	movl	%eax, %edi
	movl	%esi, -148(%rbp)                ## 4-byte Spill
	movl	%ecx, %esi
	movq	%r8, %rcx
	movl	-148(%rbp), %r8d                ## 4-byte Reload
	movl	%r9d, -152(%rbp)                ## 4-byte Spill
	movq	%r10, %r9
	movl	-144(%rbp), %eax                ## 4-byte Reload
	movl	%eax, (%rsp)
	movq	%r11, 8(%rsp)
	movl	-152(%rbp), %eax                ## 4-byte Reload
	movl	%eax, 16(%rsp)
	callq	_dgemm_2
LBB18_28:                               ##   in Loop: Header=BB18_6 Depth=1
	jmp	LBB18_29
LBB18_29:                               ##   in Loop: Header=BB18_6 Depth=1
	movl	-76(%rbp), %eax
	addl	-56(%rbp), %eax
	movl	%eax, -56(%rbp)
	jmp	LBB18_6
LBB18_30:
	jmp	LBB18_31
LBB18_31:
	movl	-32(%rbp), %edi
	movq	-40(%rbp), %rsi
	movq	-72(%rbp), %rdx
	movq	-48(%rbp), %rcx
	callq	_dgetrs_2
	movl	%eax, -52(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -28(%rbp)
LBB18_32:
	movl	-28(%rbp), %eax
	addq	$160, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dlaswp_2
_dlaswp_2:                              ## @dlaswp_2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$208, %rsp
	movl	16(%rbp), %eax
	xorl	%r10d, %r10d
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movq	%r9, -40(%rbp)
	cmpl	16(%rbp), %r10d
	setl	%r11b
	xorb	$-1, %r11b
	andb	$1, %r11b
	movzbl	%r11b, %ecx
	movslq	%ecx, %rsi
	cmpq	$0, %rsi
	je	LBB19_2
## %bb.1:
	leaq	L___func__.dlaswp_2(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.8(%rip), %rcx
	movl	$799, %edx                      ## imm = 0x31F
	callq	___assert_rtn
LBB19_2:
	jmp	LBB19_3
LBB19_3:
	movl	$1, %eax
	cmpl	16(%rbp), %eax
	sete	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB19_5
## %bb.4:
	leaq	L___func__.dlaswp_2(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.11(%rip), %rcx
	movl	$800, %edx                      ## imm = 0x320
	callq	___assert_rtn
LBB19_5:
	jmp	LBB19_6
LBB19_6:
	xorl	%eax, %eax
	movl	-4(%rbp), %ecx
	movl	%eax, -204(%rbp)                ## 4-byte Spill
	movl	%ecx, %eax
	cltd
	movl	$32, %ecx
	idivl	%ecx
	shll	$5, %eax
	movl	%eax, -44(%rbp)
	movl	-204(%rbp), %eax                ## 4-byte Reload
	cmpl	-44(%rbp), %eax
	jge	LBB19_22
## %bb.7:
	movl	$0, -52(%rbp)
LBB19_8:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB19_10 Depth 2
                                        ##       Child Loop BB19_13 Depth 3
	movl	-52(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	LBB19_21
## %bb.9:                               ##   in Loop: Header=BB19_8 Depth=1
	movl	-24(%rbp), %eax
	movl	%eax, -48(%rbp)
LBB19_10:                               ##   Parent Loop BB19_8 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB19_13 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	LBB19_19
## %bb.11:                              ##   in Loop: Header=BB19_10 Depth=2
	movq	-40(%rbp), %rax
	movslq	-48(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movl	%edx, -60(%rbp)
	movl	-60(%rbp), %edx
	cmpl	-48(%rbp), %edx
	je	LBB19_17
## %bb.12:                              ##   in Loop: Header=BB19_10 Depth=2
	movl	-52(%rbp), %eax
	movl	%eax, -56(%rbp)
LBB19_13:                               ##   Parent Loop BB19_8 Depth=1
                                        ##     Parent Loop BB19_10 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-56(%rbp), %eax
	movl	-52(%rbp), %ecx
	addl	$32, %ecx
	subl	$7, %ecx
	cmpl	%ecx, %eax
	jge	LBB19_16
## %bb.14:                              ##   in Loop: Header=BB19_13 Depth=3
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -96(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -104(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -112(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -120(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -128(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	vmovsd	-144(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-152(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-160(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-168(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-176(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-184(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-192(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-200(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-80(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-88(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-96(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-104(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-112(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-120(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-128(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-136(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.15:                              ##   in Loop: Header=BB19_13 Depth=3
	movl	-56(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB19_13
LBB19_16:                               ##   in Loop: Header=BB19_10 Depth=2
	jmp	LBB19_17
LBB19_17:                               ##   in Loop: Header=BB19_10 Depth=2
	jmp	LBB19_18
LBB19_18:                               ##   in Loop: Header=BB19_10 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB19_10
LBB19_19:                               ##   in Loop: Header=BB19_8 Depth=1
	jmp	LBB19_20
LBB19_20:                               ##   in Loop: Header=BB19_8 Depth=1
	movl	-52(%rbp), %eax
	addl	$32, %eax
	movl	%eax, -52(%rbp)
	jmp	LBB19_8
LBB19_21:
	jmp	LBB19_22
LBB19_22:
	movl	-44(%rbp), %eax
	cmpl	-4(%rbp), %eax
	je	LBB19_38
## %bb.23:
	movl	-24(%rbp), %eax
	movl	%eax, -48(%rbp)
LBB19_24:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB19_27 Depth 2
                                        ##     Child Loop BB19_31 Depth 2
	movl	-48(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	LBB19_37
## %bb.25:                              ##   in Loop: Header=BB19_24 Depth=1
	movq	-40(%rbp), %rax
	movslq	-48(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movl	%edx, -60(%rbp)
	movl	-48(%rbp), %edx
	cmpl	-60(%rbp), %edx
	je	LBB19_35
## %bb.26:                              ##   in Loop: Header=BB19_24 Depth=1
	movl	-44(%rbp), %eax
	movl	%eax, -56(%rbp)
LBB19_27:                               ##   Parent Loop BB19_24 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-56(%rbp), %eax
	movl	-4(%rbp), %ecx
	subl	$7, %ecx
	cmpl	%ecx, %eax
	jge	LBB19_30
## %bb.28:                              ##   in Loop: Header=BB19_27 Depth=2
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -96(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -104(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -112(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -120(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -128(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	vmovsd	-144(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-152(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-160(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-168(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-176(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-184(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-192(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-200(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-80(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-88(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-96(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-104(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-112(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-120(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-128(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-136(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.29:                              ##   in Loop: Header=BB19_27 Depth=2
	movl	-56(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB19_27
LBB19_30:                               ##   in Loop: Header=BB19_24 Depth=1
	jmp	LBB19_31
LBB19_31:                               ##   Parent Loop BB19_24 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-56(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB19_34
## %bb.32:                              ##   in Loop: Header=BB19_31 Depth=2
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	vmovsd	-80(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-60(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-144(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.33:                              ##   in Loop: Header=BB19_31 Depth=2
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB19_31
LBB19_34:                               ##   in Loop: Header=BB19_24 Depth=1
	jmp	LBB19_35
LBB19_35:                               ##   in Loop: Header=BB19_24 Depth=1
	jmp	LBB19_36
LBB19_36:                               ##   in Loop: Header=BB19_24 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB19_24
LBB19_37:
	jmp	LBB19_38
LBB19_38:
	addq	$208, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dtrsm_L_2
_dtrsm_L_2:                             ## @dtrsm_L_2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movq	%rdx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movl	$0, -44(%rbp)
LBB20_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB20_3 Depth 2
                                        ##       Child Loop BB20_5 Depth 3
	movl	-44(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB20_12
## %bb.2:                               ##   in Loop: Header=BB20_1 Depth=1
	movl	$0, -48(%rbp)
LBB20_3:                                ##   Parent Loop BB20_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB20_5 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB20_10
## %bb.4:                               ##   in Loop: Header=BB20_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
LBB20_5:                                ##   Parent Loop BB20_1 Depth=1
                                        ##     Parent Loop BB20_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-40(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB20_8
## %bb.6:                               ##   in Loop: Header=BB20_5 Depth=3
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.7:                               ##   in Loop: Header=BB20_5 Depth=3
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	LBB20_5
LBB20_8:                                ##   in Loop: Header=BB20_3 Depth=2
	jmp	LBB20_9
LBB20_9:                                ##   in Loop: Header=BB20_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB20_3
LBB20_10:                               ##   in Loop: Header=BB20_1 Depth=1
	jmp	LBB20_11
LBB20_11:                               ##   in Loop: Header=BB20_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB20_1
LBB20_12:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function dgemm_2
LCPI21_0:
	.quad	0x3bc79ca10c924223              ## double 9.9999999999999995E-21
LCPI21_2:
	.quad	0x3ff0000000000000              ## double 1
LCPI21_3:
	.quad	0xbff0000000000000              ## double -1
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI21_1:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	4, 0x90
_dgemm_2:                               ## @dgemm_2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$584, %rsp                      ## imm = 0x248
	.cfi_offset %rbx, -24
	movl	32(%rbp), %eax
	movq	24(%rbp), %r10
	movl	16(%rbp), %r11d
	vmovsd	LCPI21_0(%rip), %xmm2           ## xmm2 = mem[0],zero
	vmovsd	LCPI21_2(%rip), %xmm3           ## xmm3 = mem[0],zero
	movl	%edi, -12(%rbp)
	movl	%esi, -16(%rbp)
	movl	%edx, -20(%rbp)
	vmovsd	%xmm0, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	%r8d, -44(%rbp)
	movq	%r9, -56(%rbp)
	vmovsd	%xmm1, -64(%rbp)
	vmovsd	-64(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vsubsd	%xmm3, %xmm0, %xmm0
	vmovdqa	LCPI21_1(%rip), %xmm1           ## xmm1 = [NaN,NaN]
	vpand	%xmm1, %xmm0, %xmm0
	vucomisd	%xmm0, %xmm2
	setae	%bl
	xorb	$-1, %bl
	andb	$1, %bl
	movzbl	%bl, %edx
	movslq	%edx, %rcx
	cmpq	$0, %rcx
	je	LBB21_2
## %bb.1:
	leaq	L___func__.dgemm_2(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.2(%rip), %rcx
	movl	$985, %edx                      ## imm = 0x3D9
	callq	___assert_rtn
LBB21_2:
	jmp	LBB21_3
LBB21_3:
	vmovsd	LCPI21_0(%rip), %xmm0           ## xmm0 = mem[0],zero
	vmovsd	LCPI21_3(%rip), %xmm1           ## xmm1 = mem[0],zero
	vmovsd	-32(%rbp), %xmm2                ## xmm2 = mem[0],zero
	vsubsd	%xmm1, %xmm2, %xmm1
	vmovdqa	LCPI21_1(%rip), %xmm2           ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	setae	%al
	xorb	$-1, %al
	andb	$1, %al
	movzbl	%al, %ecx
	movslq	%ecx, %rdx
	cmpq	$0, %rdx
	je	LBB21_5
## %bb.4:
	leaq	L___func__.dgemm_2(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.3(%rip), %rcx
	movl	$986, %edx                      ## imm = 0x3DA
	callq	___assert_rtn
LBB21_5:
	jmp	LBB21_6
LBB21_6:
	movl	$56, -68(%rbp)
	movl	$56, -72(%rbp)
	movl	$56, -76(%rbp)
	movl	$4, -80(%rbp)
	movl	$2, -84(%rbp)
	movl	$8, -88(%rbp)
	movl	$0, -92(%rbp)
	movl	$0, -104(%rbp)
	movl	$0, -116(%rbp)
	movl	$0, -96(%rbp)
	movl	$0, -108(%rbp)
	movl	$0, -120(%rbp)
	movl	$0, -100(%rbp)
	movl	$0, -112(%rbp)
	movl	$0, -124(%rbp)
	movl	$0, -92(%rbp)
LBB21_7:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB21_9 Depth 2
                                        ##       Child Loop BB21_11 Depth 3
                                        ##         Child Loop BB21_13 Depth 4
                                        ##           Child Loop BB21_15 Depth 5
                                        ##             Child Loop BB21_17 Depth 6
                                        ##       Child Loop BB21_27 Depth 3
                                        ##         Child Loop BB21_29 Depth 4
                                        ##           Child Loop BB21_31 Depth 5
                                        ##     Child Loop BB21_41 Depth 2
                                        ##       Child Loop BB21_43 Depth 3
                                        ##         Child Loop BB21_45 Depth 4
                                        ##           Child Loop BB21_47 Depth 5
                                        ##       Child Loop BB21_55 Depth 3
                                        ##         Child Loop BB21_57 Depth 4
	movl	-92(%rbp), %eax
	movl	-12(%rbp), %ecx
	subl	$56, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_66
## %bb.8:                               ##   in Loop: Header=BB21_7 Depth=1
	movl	$0, -96(%rbp)
LBB21_9:                                ##   Parent Loop BB21_7 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB21_11 Depth 3
                                        ##         Child Loop BB21_13 Depth 4
                                        ##           Child Loop BB21_15 Depth 5
                                        ##             Child Loop BB21_17 Depth 6
                                        ##       Child Loop BB21_27 Depth 3
                                        ##         Child Loop BB21_29 Depth 4
                                        ##           Child Loop BB21_31 Depth 5
	movl	-96(%rbp), %eax
	movl	-16(%rbp), %ecx
	subl	$56, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_40
## %bb.10:                              ##   in Loop: Header=BB21_9 Depth=2
	movl	$0, -100(%rbp)
LBB21_11:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_9 Depth=2
                                        ## =>    This Loop Header: Depth=3
                                        ##         Child Loop BB21_13 Depth 4
                                        ##           Child Loop BB21_15 Depth 5
                                        ##             Child Loop BB21_17 Depth 6
	movl	-100(%rbp), %eax
	movl	-20(%rbp), %ecx
	subl	$56, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_26
## %bb.12:                              ##   in Loop: Header=BB21_11 Depth=3
	movl	-92(%rbp), %eax
	movl	%eax, -104(%rbp)
LBB21_13:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_9 Depth=2
                                        ##       Parent Loop BB21_11 Depth=3
                                        ## =>      This Loop Header: Depth=4
                                        ##           Child Loop BB21_15 Depth 5
                                        ##             Child Loop BB21_17 Depth 6
	movl	-104(%rbp), %eax
	movl	-92(%rbp), %ecx
	addl	$56, %ecx
	subl	$4, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_24
## %bb.14:                              ##   in Loop: Header=BB21_13 Depth=4
	movl	-96(%rbp), %eax
	movl	%eax, -108(%rbp)
LBB21_15:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_9 Depth=2
                                        ##       Parent Loop BB21_11 Depth=3
                                        ##         Parent Loop BB21_13 Depth=4
                                        ## =>        This Loop Header: Depth=5
                                        ##             Child Loop BB21_17 Depth 6
	movl	-108(%rbp), %eax
	movl	-96(%rbp), %ecx
	addl	$56, %ecx
	subl	$2, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_22
## %bb.16:                              ##   in Loop: Header=BB21_15 Depth=5
	movl	-100(%rbp), %eax
	movl	%eax, -112(%rbp)
LBB21_17:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_9 Depth=2
                                        ##       Parent Loop BB21_11 Depth=3
                                        ##         Parent Loop BB21_13 Depth=4
                                        ##           Parent Loop BB21_15 Depth=5
                                        ## =>          This Inner Loop Header: Depth=6
	movl	-112(%rbp), %eax
	movl	-100(%rbp), %ecx
	addl	$56, %ecx
	subl	$8, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_20
## %bb.18:                              ##   in Loop: Header=BB21_17 Depth=6
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -400(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -408(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -416(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -424(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -432(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -440(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -448(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -456(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -464(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -480(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -496(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -512(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -528(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -544(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -560(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -576(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -472(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -488(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -504(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -520(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -536(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -552(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -568(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -584(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -208(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -216(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -224(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -232(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -240(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -248(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -256(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -264(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -272(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -280(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -288(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -296(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -304(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -312(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -320(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -328(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -336(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -344(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -352(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -360(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -368(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -376(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -384(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$8, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -392(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-472(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-200(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-472(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-200(%rbp), %xmm0, %xmm0
	vmovsd	-424(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -424(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-264(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-472(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-264(%rbp), %xmm0, %xmm0
	vmovsd	-440(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -440(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-328(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-472(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-328(%rbp), %xmm0, %xmm0
	vmovsd	-456(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -456(%rbp)
	vmovsd	-480(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-144(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-488(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-144(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-480(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-208(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-488(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-208(%rbp), %xmm0, %xmm0
	vmovsd	-424(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -424(%rbp)
	vmovsd	-480(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-272(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-488(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-272(%rbp), %xmm0, %xmm0
	vmovsd	-440(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -440(%rbp)
	vmovsd	-480(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-336(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-488(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-336(%rbp), %xmm0, %xmm0
	vmovsd	-456(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -456(%rbp)
	vmovsd	-496(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-152(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-504(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-152(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-496(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-216(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-504(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-216(%rbp), %xmm0, %xmm0
	vmovsd	-424(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -424(%rbp)
	vmovsd	-496(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-280(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-504(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-280(%rbp), %xmm0, %xmm0
	vmovsd	-440(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -440(%rbp)
	vmovsd	-496(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-344(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-504(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-344(%rbp), %xmm0, %xmm0
	vmovsd	-456(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -456(%rbp)
	vmovsd	-512(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-160(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-520(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-160(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-512(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-224(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-520(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-224(%rbp), %xmm0, %xmm0
	vmovsd	-424(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -424(%rbp)
	vmovsd	-512(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-288(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-520(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-288(%rbp), %xmm0, %xmm0
	vmovsd	-440(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -440(%rbp)
	vmovsd	-512(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-352(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-520(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-352(%rbp), %xmm0, %xmm0
	vmovsd	-456(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -456(%rbp)
	vmovsd	-528(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-168(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-536(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-168(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-528(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-232(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-536(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-232(%rbp), %xmm0, %xmm0
	vmovsd	-424(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -424(%rbp)
	vmovsd	-528(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-296(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-536(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-296(%rbp), %xmm0, %xmm0
	vmovsd	-440(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -440(%rbp)
	vmovsd	-528(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-360(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-536(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-360(%rbp), %xmm0, %xmm0
	vmovsd	-456(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -456(%rbp)
	vmovsd	-544(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-176(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-552(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-176(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-544(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-240(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-552(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-240(%rbp), %xmm0, %xmm0
	vmovsd	-424(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -424(%rbp)
	vmovsd	-544(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-304(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-552(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-304(%rbp), %xmm0, %xmm0
	vmovsd	-440(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -440(%rbp)
	vmovsd	-544(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-368(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-552(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-368(%rbp), %xmm0, %xmm0
	vmovsd	-456(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -456(%rbp)
	vmovsd	-560(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-184(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-568(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-184(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-560(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-248(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-568(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-248(%rbp), %xmm0, %xmm0
	vmovsd	-424(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -424(%rbp)
	vmovsd	-560(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-312(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-568(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-312(%rbp), %xmm0, %xmm0
	vmovsd	-440(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -440(%rbp)
	vmovsd	-560(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-376(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-568(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-376(%rbp), %xmm0, %xmm0
	vmovsd	-456(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -456(%rbp)
	vmovsd	-584(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-192(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-576(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-192(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-584(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-256(%rbp), %xmm0, %xmm0
	vmovsd	-424(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -424(%rbp)
	vmovsd	-576(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-256(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-576(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-320(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-584(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-320(%rbp), %xmm0, %xmm0
	vmovsd	-440(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -440(%rbp)
	vmovsd	-576(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-384(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-584(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-384(%rbp), %xmm0, %xmm0
	vmovsd	-456(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -456(%rbp)
	vmovsd	-400(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-408(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-416(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-424(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-432(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-440(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-448(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-456(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.19:                              ##   in Loop: Header=BB21_17 Depth=6
	movl	-112(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -112(%rbp)
	jmp	LBB21_17
LBB21_20:                               ##   in Loop: Header=BB21_15 Depth=5
	jmp	LBB21_21
LBB21_21:                               ##   in Loop: Header=BB21_15 Depth=5
	movl	-108(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -108(%rbp)
	jmp	LBB21_15
LBB21_22:                               ##   in Loop: Header=BB21_13 Depth=4
	jmp	LBB21_23
LBB21_23:                               ##   in Loop: Header=BB21_13 Depth=4
	movl	-104(%rbp), %eax
	addl	$4, %eax
	movl	%eax, -104(%rbp)
	jmp	LBB21_13
LBB21_24:                               ##   in Loop: Header=BB21_11 Depth=3
	jmp	LBB21_25
LBB21_25:                               ##   in Loop: Header=BB21_11 Depth=3
	movl	-100(%rbp), %eax
	addl	$56, %eax
	movl	%eax, -100(%rbp)
	jmp	LBB21_11
LBB21_26:                               ##   in Loop: Header=BB21_9 Depth=2
	jmp	LBB21_27
LBB21_27:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_9 Depth=2
                                        ## =>    This Loop Header: Depth=3
                                        ##         Child Loop BB21_29 Depth 4
                                        ##           Child Loop BB21_31 Depth 5
	movl	-100(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	LBB21_38
## %bb.28:                              ##   in Loop: Header=BB21_27 Depth=3
	movl	-92(%rbp), %eax
	movl	%eax, -104(%rbp)
LBB21_29:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_9 Depth=2
                                        ##       Parent Loop BB21_27 Depth=3
                                        ## =>      This Loop Header: Depth=4
                                        ##           Child Loop BB21_31 Depth 5
	movl	-104(%rbp), %eax
	movl	-92(%rbp), %ecx
	addl	$56, %ecx
	subl	$4, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_36
## %bb.30:                              ##   in Loop: Header=BB21_29 Depth=4
	movl	-96(%rbp), %eax
	movl	%eax, -108(%rbp)
LBB21_31:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_9 Depth=2
                                        ##       Parent Loop BB21_27 Depth=3
                                        ##         Parent Loop BB21_29 Depth=4
                                        ## =>        This Inner Loop Header: Depth=5
	movl	-108(%rbp), %eax
	movl	-96(%rbp), %ecx
	addl	$56, %ecx
	subl	$2, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_34
## %bb.32:                              ##   in Loop: Header=BB21_31 Depth=5
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -400(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -408(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -416(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -424(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -432(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -440(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -448(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -456(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -464(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -472(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -264(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -328(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-472(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-200(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-472(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-200(%rbp), %xmm0, %xmm0
	vmovsd	-424(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -424(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-264(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-472(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-264(%rbp), %xmm0, %xmm0
	vmovsd	-440(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -440(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-328(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-472(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-328(%rbp), %xmm0, %xmm0
	vmovsd	-456(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -456(%rbp)
	vmovsd	-400(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-408(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-416(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-424(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-432(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-440(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-448(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-456(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.33:                              ##   in Loop: Header=BB21_31 Depth=5
	movl	-108(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -108(%rbp)
	jmp	LBB21_31
LBB21_34:                               ##   in Loop: Header=BB21_29 Depth=4
	jmp	LBB21_35
LBB21_35:                               ##   in Loop: Header=BB21_29 Depth=4
	movl	-104(%rbp), %eax
	addl	$4, %eax
	movl	%eax, -104(%rbp)
	jmp	LBB21_29
LBB21_36:                               ##   in Loop: Header=BB21_27 Depth=3
	jmp	LBB21_37
LBB21_37:                               ##   in Loop: Header=BB21_27 Depth=3
	movl	-100(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -100(%rbp)
	jmp	LBB21_27
LBB21_38:                               ##   in Loop: Header=BB21_9 Depth=2
	jmp	LBB21_39
LBB21_39:                               ##   in Loop: Header=BB21_9 Depth=2
	movl	-96(%rbp), %eax
	addl	$56, %eax
	movl	%eax, -96(%rbp)
	jmp	LBB21_9
LBB21_40:                               ##   in Loop: Header=BB21_7 Depth=1
	jmp	LBB21_41
LBB21_41:                               ##   Parent Loop BB21_7 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB21_43 Depth 3
                                        ##         Child Loop BB21_45 Depth 4
                                        ##           Child Loop BB21_47 Depth 5
                                        ##       Child Loop BB21_55 Depth 3
                                        ##         Child Loop BB21_57 Depth 4
	movl	-96(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	LBB21_64
## %bb.42:                              ##   in Loop: Header=BB21_41 Depth=2
	movl	$0, -100(%rbp)
LBB21_43:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_41 Depth=2
                                        ## =>    This Loop Header: Depth=3
                                        ##         Child Loop BB21_45 Depth 4
                                        ##           Child Loop BB21_47 Depth 5
	movl	-100(%rbp), %eax
	movl	-20(%rbp), %ecx
	subl	$56, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_54
## %bb.44:                              ##   in Loop: Header=BB21_43 Depth=3
	movl	-92(%rbp), %eax
	movl	%eax, -104(%rbp)
LBB21_45:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_41 Depth=2
                                        ##       Parent Loop BB21_43 Depth=3
                                        ## =>      This Loop Header: Depth=4
                                        ##           Child Loop BB21_47 Depth 5
	movl	-104(%rbp), %eax
	movl	-92(%rbp), %ecx
	addl	$56, %ecx
	subl	$4, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_52
## %bb.46:                              ##   in Loop: Header=BB21_45 Depth=4
	movl	-100(%rbp), %eax
	movl	%eax, -112(%rbp)
LBB21_47:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_41 Depth=2
                                        ##       Parent Loop BB21_43 Depth=3
                                        ##         Parent Loop BB21_45 Depth=4
                                        ## =>        This Inner Loop Header: Depth=5
	movl	-112(%rbp), %eax
	movl	-100(%rbp), %ecx
	addl	$56, %ecx
	subl	$8, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_50
## %bb.48:                              ##   in Loop: Header=BB21_47 Depth=5
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -400(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -416(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -432(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -448(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -464(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -480(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -496(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -512(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -528(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -544(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -560(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -576(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -208(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -216(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -224(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -232(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -240(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -248(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -256(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -264(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -272(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -280(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -288(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -296(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -304(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -312(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -320(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -328(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -336(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -344(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -352(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -360(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -368(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -376(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -384(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$8, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -392(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-200(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-264(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-328(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-480(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-144(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-480(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-208(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-480(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-272(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-480(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-336(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-496(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-152(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-496(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-216(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-496(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-280(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-496(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-344(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-512(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-160(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-512(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-224(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-512(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-288(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-512(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-352(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-528(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-168(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-528(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-232(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-528(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-296(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-528(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-360(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-544(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-176(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-544(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-240(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-544(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-304(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-544(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-368(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-560(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-184(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-560(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-248(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-560(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-312(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-560(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-376(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-576(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-192(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-576(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-256(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-576(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-320(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-576(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-384(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-400(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-416(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-432(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-448(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.49:                              ##   in Loop: Header=BB21_47 Depth=5
	movl	-112(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -112(%rbp)
	jmp	LBB21_47
LBB21_50:                               ##   in Loop: Header=BB21_45 Depth=4
	jmp	LBB21_51
LBB21_51:                               ##   in Loop: Header=BB21_45 Depth=4
	movl	-104(%rbp), %eax
	addl	$4, %eax
	movl	%eax, -104(%rbp)
	jmp	LBB21_45
LBB21_52:                               ##   in Loop: Header=BB21_43 Depth=3
	jmp	LBB21_53
LBB21_53:                               ##   in Loop: Header=BB21_43 Depth=3
	movl	-100(%rbp), %eax
	addl	$56, %eax
	movl	%eax, -100(%rbp)
	jmp	LBB21_43
LBB21_54:                               ##   in Loop: Header=BB21_41 Depth=2
	jmp	LBB21_55
LBB21_55:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_41 Depth=2
                                        ## =>    This Loop Header: Depth=3
                                        ##         Child Loop BB21_57 Depth 4
	movl	-100(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	LBB21_62
## %bb.56:                              ##   in Loop: Header=BB21_55 Depth=3
	movl	-92(%rbp), %eax
	movl	%eax, -104(%rbp)
LBB21_57:                               ##   Parent Loop BB21_7 Depth=1
                                        ##     Parent Loop BB21_41 Depth=2
                                        ##       Parent Loop BB21_55 Depth=3
                                        ## =>      This Inner Loop Header: Depth=4
	movl	-104(%rbp), %eax
	movl	-92(%rbp), %ecx
	addl	$56, %ecx
	subl	$4, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_60
## %bb.58:                              ##   in Loop: Header=BB21_57 Depth=4
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -400(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -416(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -432(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -448(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -464(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -264(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -328(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-200(%rbp), %xmm0, %xmm0
	vmovsd	-416(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -416(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-264(%rbp), %xmm0, %xmm0
	vmovsd	-432(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -432(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-328(%rbp), %xmm0, %xmm0
	vmovsd	-448(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -448(%rbp)
	vmovsd	-400(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-416(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-432(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-448(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-104(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.59:                              ##   in Loop: Header=BB21_57 Depth=4
	movl	-104(%rbp), %eax
	addl	$4, %eax
	movl	%eax, -104(%rbp)
	jmp	LBB21_57
LBB21_60:                               ##   in Loop: Header=BB21_55 Depth=3
	jmp	LBB21_61
LBB21_61:                               ##   in Loop: Header=BB21_55 Depth=3
	movl	-100(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -100(%rbp)
	jmp	LBB21_55
LBB21_62:                               ##   in Loop: Header=BB21_41 Depth=2
	jmp	LBB21_63
LBB21_63:                               ##   in Loop: Header=BB21_41 Depth=2
	movl	-96(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -96(%rbp)
	jmp	LBB21_41
LBB21_64:                               ##   in Loop: Header=BB21_7 Depth=1
	jmp	LBB21_65
LBB21_65:                               ##   in Loop: Header=BB21_7 Depth=1
	movl	-92(%rbp), %eax
	addl	$56, %eax
	movl	%eax, -92(%rbp)
	jmp	LBB21_7
LBB21_66:
	jmp	LBB21_67
LBB21_67:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB21_69 Depth 2
                                        ##       Child Loop BB21_71 Depth 3
                                        ##         Child Loop BB21_73 Depth 4
                                        ##           Child Loop BB21_75 Depth 5
                                        ##       Child Loop BB21_83 Depth 3
                                        ##         Child Loop BB21_85 Depth 4
                                        ##     Child Loop BB21_93 Depth 2
                                        ##       Child Loop BB21_95 Depth 3
                                        ##         Child Loop BB21_97 Depth 4
                                        ##       Child Loop BB21_103 Depth 3
	movl	-92(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB21_110
## %bb.68:                              ##   in Loop: Header=BB21_67 Depth=1
	movl	$0, -96(%rbp)
LBB21_69:                               ##   Parent Loop BB21_67 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB21_71 Depth 3
                                        ##         Child Loop BB21_73 Depth 4
                                        ##           Child Loop BB21_75 Depth 5
                                        ##       Child Loop BB21_83 Depth 3
                                        ##         Child Loop BB21_85 Depth 4
	movl	-96(%rbp), %eax
	movl	-16(%rbp), %ecx
	subl	$56, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_92
## %bb.70:                              ##   in Loop: Header=BB21_69 Depth=2
	movl	$0, -100(%rbp)
LBB21_71:                               ##   Parent Loop BB21_67 Depth=1
                                        ##     Parent Loop BB21_69 Depth=2
                                        ## =>    This Loop Header: Depth=3
                                        ##         Child Loop BB21_73 Depth 4
                                        ##           Child Loop BB21_75 Depth 5
	movl	-100(%rbp), %eax
	movl	-20(%rbp), %ecx
	subl	$56, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_82
## %bb.72:                              ##   in Loop: Header=BB21_71 Depth=3
	movl	-96(%rbp), %eax
	movl	%eax, -108(%rbp)
LBB21_73:                               ##   Parent Loop BB21_67 Depth=1
                                        ##     Parent Loop BB21_69 Depth=2
                                        ##       Parent Loop BB21_71 Depth=3
                                        ## =>      This Loop Header: Depth=4
                                        ##           Child Loop BB21_75 Depth 5
	movl	-108(%rbp), %eax
	movl	-96(%rbp), %ecx
	addl	$56, %ecx
	subl	$2, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_80
## %bb.74:                              ##   in Loop: Header=BB21_73 Depth=4
	movl	-100(%rbp), %eax
	movl	%eax, -112(%rbp)
LBB21_75:                               ##   Parent Loop BB21_67 Depth=1
                                        ##     Parent Loop BB21_69 Depth=2
                                        ##       Parent Loop BB21_71 Depth=3
                                        ##         Parent Loop BB21_73 Depth=4
                                        ## =>        This Inner Loop Header: Depth=5
	movl	-112(%rbp), %eax
	movl	-100(%rbp), %ecx
	addl	$56, %ecx
	subl	$8, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_78
## %bb.76:                              ##   in Loop: Header=BB21_75 Depth=5
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -400(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -408(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -464(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -472(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -480(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -488(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -496(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -504(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -512(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -520(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -528(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -536(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -544(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -552(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -560(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -568(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -576(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -584(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-472(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-480(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-144(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-488(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-144(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-496(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-152(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-504(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-152(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-512(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-160(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-520(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-160(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-528(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-168(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-536(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-168(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-544(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-176(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-552(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-176(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-560(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-184(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-568(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-184(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-576(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-192(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-584(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-192(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-400(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-408(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.77:                              ##   in Loop: Header=BB21_75 Depth=5
	movl	-112(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -112(%rbp)
	jmp	LBB21_75
LBB21_78:                               ##   in Loop: Header=BB21_73 Depth=4
	jmp	LBB21_79
LBB21_79:                               ##   in Loop: Header=BB21_73 Depth=4
	movl	-108(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -108(%rbp)
	jmp	LBB21_73
LBB21_80:                               ##   in Loop: Header=BB21_71 Depth=3
	jmp	LBB21_81
LBB21_81:                               ##   in Loop: Header=BB21_71 Depth=3
	movl	-100(%rbp), %eax
	addl	$56, %eax
	movl	%eax, -100(%rbp)
	jmp	LBB21_71
LBB21_82:                               ##   in Loop: Header=BB21_69 Depth=2
	jmp	LBB21_83
LBB21_83:                               ##   Parent Loop BB21_67 Depth=1
                                        ##     Parent Loop BB21_69 Depth=2
                                        ## =>    This Loop Header: Depth=3
                                        ##         Child Loop BB21_85 Depth 4
	movl	-100(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	LBB21_90
## %bb.84:                              ##   in Loop: Header=BB21_83 Depth=3
	movl	-96(%rbp), %eax
	movl	%eax, -108(%rbp)
LBB21_85:                               ##   Parent Loop BB21_67 Depth=1
                                        ##     Parent Loop BB21_69 Depth=2
                                        ##       Parent Loop BB21_83 Depth=3
                                        ## =>      This Inner Loop Header: Depth=4
	movl	-108(%rbp), %eax
	movl	-96(%rbp), %ecx
	addl	$56, %ecx
	subl	$2, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_88
## %bb.86:                              ##   in Loop: Header=BB21_85 Depth=4
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -400(%rbp)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -408(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -464(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -472(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-100(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-472(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-408(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -408(%rbp)
	vmovsd	-400(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-408(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-108(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.87:                              ##   in Loop: Header=BB21_85 Depth=4
	movl	-108(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -108(%rbp)
	jmp	LBB21_85
LBB21_88:                               ##   in Loop: Header=BB21_83 Depth=3
	jmp	LBB21_89
LBB21_89:                               ##   in Loop: Header=BB21_83 Depth=3
	movl	-100(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -100(%rbp)
	jmp	LBB21_83
LBB21_90:                               ##   in Loop: Header=BB21_69 Depth=2
	jmp	LBB21_91
LBB21_91:                               ##   in Loop: Header=BB21_69 Depth=2
	movl	-96(%rbp), %eax
	addl	$56, %eax
	movl	%eax, -96(%rbp)
	jmp	LBB21_69
LBB21_92:                               ##   in Loop: Header=BB21_67 Depth=1
	jmp	LBB21_93
LBB21_93:                               ##   Parent Loop BB21_67 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB21_95 Depth 3
                                        ##         Child Loop BB21_97 Depth 4
                                        ##       Child Loop BB21_103 Depth 3
	movl	-96(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	LBB21_108
## %bb.94:                              ##   in Loop: Header=BB21_93 Depth=2
	movl	$0, -100(%rbp)
LBB21_95:                               ##   Parent Loop BB21_67 Depth=1
                                        ##     Parent Loop BB21_93 Depth=2
                                        ## =>    This Loop Header: Depth=3
                                        ##         Child Loop BB21_97 Depth 4
	movl	-100(%rbp), %eax
	movl	-20(%rbp), %ecx
	subl	$56, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_102
## %bb.96:                              ##   in Loop: Header=BB21_95 Depth=3
	movl	-100(%rbp), %eax
	movl	%eax, -112(%rbp)
LBB21_97:                               ##   Parent Loop BB21_67 Depth=1
                                        ##     Parent Loop BB21_93 Depth=2
                                        ##       Parent Loop BB21_95 Depth=3
                                        ## =>      This Inner Loop Header: Depth=4
	movl	-112(%rbp), %eax
	movl	-100(%rbp), %ecx
	addl	$56, %ecx
	subl	$8, %ecx
	cmpl	%ecx, %eax
	jg	LBB21_100
## %bb.98:                              ##   in Loop: Header=BB21_97 Depth=4
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -400(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -464(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -480(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -496(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -512(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -528(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -544(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -560(%rbp)
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -576(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-112(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	vmovsd	-464(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-480(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-144(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-496(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-152(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-512(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-160(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-528(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-168(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-544(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-176(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-560(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-184(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-576(%rbp), %xmm0               ## xmm0 = mem[0],zero
	vmulsd	-192(%rbp), %xmm0, %xmm0
	vmovsd	-400(%rbp), %xmm1               ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -400(%rbp)
	vmovsd	-400(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	-92(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	-96(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.99:                              ##   in Loop: Header=BB21_97 Depth=4
	movl	-112(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -112(%rbp)
	jmp	LBB21_97
LBB21_100:                              ##   in Loop: Header=BB21_95 Depth=3
	jmp	LBB21_101
LBB21_101:                              ##   in Loop: Header=BB21_95 Depth=3
	movl	-100(%rbp), %eax
	addl	$56, %eax
	movl	%eax, -100(%rbp)
	jmp	LBB21_95
LBB21_102:                              ##   in Loop: Header=BB21_93 Depth=2
	jmp	LBB21_103
LBB21_103:                              ##   Parent Loop BB21_67 Depth=1
                                        ##     Parent Loop BB21_93 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-100(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	LBB21_106
## %bb.104:                             ##   in Loop: Header=BB21_103 Depth=3
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	imull	-92(%rbp), %ecx
	addl	-96(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-56(%rbp), %rax
	movl	16(%rbp), %ecx
	imull	-100(%rbp), %ecx
	addl	-96(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-40(%rbp), %rax
	movl	-44(%rbp), %ecx
	imull	-92(%rbp), %ecx
	addl	-100(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	imull	-92(%rbp), %ecx
	addl	-96(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.105:                             ##   in Loop: Header=BB21_103 Depth=3
	movl	-100(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -100(%rbp)
	jmp	LBB21_103
LBB21_106:                              ##   in Loop: Header=BB21_93 Depth=2
	jmp	LBB21_107
LBB21_107:                              ##   in Loop: Header=BB21_93 Depth=2
	movl	-96(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -96(%rbp)
	jmp	LBB21_93
LBB21_108:                              ##   in Loop: Header=BB21_67 Depth=1
	jmp	LBB21_109
LBB21_109:                              ##   in Loop: Header=BB21_67 Depth=1
	movl	-92(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -92(%rbp)
	jmp	LBB21_67
LBB21_110:
	addq	$584, %rsp                      ## imm = 0x248
	popq	%rbx
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dgetrs_2
_dgetrs_2:                              ## @dgetrs_2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	xorl	%eax, %eax
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	-32(%rbp), %rsi
	movl	-4(%rbp), %r8d
	movq	-24(%rbp), %r9
	movl	$1, %edi
	movl	%edi, -36(%rbp)                 ## 4-byte Spill
	movl	-36(%rbp), %edx                 ## 4-byte Reload
	movl	%eax, %ecx
	movl	$1, (%rsp)
	callq	_dlaswp_2
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %ecx
	movq	-32(%rbp), %r8
	movl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %r9d
	callq	_dtrsm_L_2
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %ecx
	movq	-32(%rbp), %r8
	movl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %r9d
	callq	_dtrsm_U_2
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_dgemm_5                        ## -- Begin function dgemm_5
	.p2align	4, 0x90
_dgemm_5:                               ## @dgemm_5
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$144, %rsp
	movl	32(%rbp), %eax
	movq	24(%rbp), %r10
	movl	16(%rbp), %r11d
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	vmovsd	%xmm0, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	movq	%r9, -48(%rbp)
	vmovsd	%xmm1, -56(%rbp)
	movq	_scratch_a(%rip), %rcx
	movq	%rcx, -64(%rbp)
	movq	_scratch_b(%rip), %rcx
	movq	%rcx, -72(%rbp)
	movl	$0, -80(%rbp)
LBB23_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB23_6 Depth 2
                                        ##       Child Loop BB23_11 Depth 3
	movl	-80(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB23_21
## %bb.2:                               ##   in Loop: Header=BB23_1 Depth=1
	movl	-8(%rbp), %eax
	subl	-80(%rbp), %eax
	cmpl	$2048, %eax                     ## imm = 0x800
	jge	LBB23_4
## %bb.3:                               ##   in Loop: Header=BB23_1 Depth=1
	movl	-8(%rbp), %eax
	subl	-80(%rbp), %eax
	movl	%eax, -100(%rbp)                ## 4-byte Spill
	jmp	LBB23_5
LBB23_4:                                ##   in Loop: Header=BB23_1 Depth=1
	movl	$2048, %eax                     ## imm = 0x800
	movl	%eax, -100(%rbp)                ## 4-byte Spill
	jmp	LBB23_5
LBB23_5:                                ##   in Loop: Header=BB23_1 Depth=1
	movl	-100(%rbp), %eax                ## 4-byte Reload
	movl	%eax, -92(%rbp)
	movl	$0, -84(%rbp)
LBB23_6:                                ##   Parent Loop BB23_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB23_11 Depth 3
	movl	-84(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB23_19
## %bb.7:                               ##   in Loop: Header=BB23_6 Depth=2
	movl	-12(%rbp), %eax
	subl	-84(%rbp), %eax
	cmpl	$384, %eax                      ## imm = 0x180
	jge	LBB23_9
## %bb.8:                               ##   in Loop: Header=BB23_6 Depth=2
	movl	-12(%rbp), %eax
	subl	-84(%rbp), %eax
	movl	%eax, -104(%rbp)                ## 4-byte Spill
	jmp	LBB23_10
LBB23_9:                                ##   in Loop: Header=BB23_6 Depth=2
	movl	$384, %eax                      ## imm = 0x180
	movl	%eax, -104(%rbp)                ## 4-byte Spill
	jmp	LBB23_10
LBB23_10:                               ##   in Loop: Header=BB23_6 Depth=2
	movl	-104(%rbp), %eax                ## 4-byte Reload
	movl	%eax, -96(%rbp)
	movq	-72(%rbp), %rdi
	movq	-48(%rbp), %rcx
	movl	16(%rbp), %eax
	imull	-80(%rbp), %eax
	addl	-84(%rbp), %eax
	movslq	%eax, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rcx
	movl	16(%rbp), %edx
	movl	-96(%rbp), %eax
	movl	-92(%rbp), %r8d
	movq	%rcx, %rsi
	movl	%eax, %ecx
	callq	_pack_b
	movl	$0, -76(%rbp)
LBB23_11:                               ##   Parent Loop BB23_1 Depth=1
                                        ##     Parent Loop BB23_6 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-76(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB23_17
## %bb.12:                              ##   in Loop: Header=BB23_11 Depth=3
	movl	-4(%rbp), %eax
	subl	-76(%rbp), %eax
	cmpl	$192, %eax
	jge	LBB23_14
## %bb.13:                              ##   in Loop: Header=BB23_11 Depth=3
	movl	-4(%rbp), %eax
	subl	-76(%rbp), %eax
	movl	%eax, -108(%rbp)                ## 4-byte Spill
	jmp	LBB23_15
LBB23_14:                               ##   in Loop: Header=BB23_11 Depth=3
	movl	$192, %eax
	movl	%eax, -108(%rbp)                ## 4-byte Spill
	jmp	LBB23_15
LBB23_15:                               ##   in Loop: Header=BB23_11 Depth=3
	movl	-108(%rbp), %eax                ## 4-byte Reload
	movl	%eax, -88(%rbp)
	movq	-64(%rbp), %rdi
	movq	-32(%rbp), %rcx
	movl	-36(%rbp), %eax
	imull	-84(%rbp), %eax
	addl	-76(%rbp), %eax
	movslq	%eax, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rcx
	movl	-36(%rbp), %edx
	movl	-88(%rbp), %eax
	movl	-96(%rbp), %r8d
	movq	%rcx, %rsi
	movl	%eax, %ecx
	callq	_pack_a
	movl	-88(%rbp), %edi
	movl	-92(%rbp), %esi
	movl	-96(%rbp), %edx
	movq	-64(%rbp), %rcx
	movq	-72(%rbp), %r9
	movq	24(%rbp), %r10
	movl	32(%rbp), %eax
	imull	-80(%rbp), %eax
	addl	-76(%rbp), %eax
	movslq	%eax, %r11
	shlq	$3, %r11
	addq	%r11, %r10
	movl	32(%rbp), %eax
	movl	$4293967296, %r8d               ## imm = 0xFFF0BDC0
	movl	$-1000000, (%rsp)               ## imm = 0xFFF0BDC0
	movq	%r10, 8(%rsp)
	movl	%eax, 16(%rsp)
	callq	_dgemm_5_mini
## %bb.16:                              ##   in Loop: Header=BB23_11 Depth=3
	movl	-88(%rbp), %eax
	addl	-76(%rbp), %eax
	movl	%eax, -76(%rbp)
	jmp	LBB23_11
LBB23_17:                               ##   in Loop: Header=BB23_6 Depth=2
	jmp	LBB23_18
LBB23_18:                               ##   in Loop: Header=BB23_6 Depth=2
	movl	-96(%rbp), %eax
	addl	-84(%rbp), %eax
	movl	%eax, -84(%rbp)
	jmp	LBB23_6
LBB23_19:                               ##   in Loop: Header=BB23_1 Depth=1
	jmp	LBB23_20
LBB23_20:                               ##   in Loop: Header=BB23_1 Depth=1
	movl	-92(%rbp), %eax
	addl	-80(%rbp), %eax
	movl	%eax, -80(%rbp)
	jmp	LBB23_1
LBB23_21:
	addq	$144, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function pack_b
_pack_b:                                ## @pack_b
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movl	$0, -36(%rbp)
LBB24_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB24_3 Depth 2
	movl	-36(%rbp), %eax
	movl	-28(%rbp), %ecx
	subl	$3, %ecx
	cmpl	%ecx, %eax
	jge	LBB24_8
## %bb.2:                               ##   in Loop: Header=BB24_1 Depth=1
	movq	-16(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-20(%rbp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movslq	-20(%rbp), %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movslq	-20(%rbp), %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movslq	-20(%rbp), %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	movl	$0, -32(%rbp)
LBB24_3:                                ##   Parent Loop BB24_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	LBB24_6
## %bb.4:                               ##   in Loop: Header=BB24_3 Depth=2
	movq	-48(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -48(%rbp)
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -8(%rbp)
	vmovsd	%xmm0, (%rax)
	movq	-56(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -56(%rbp)
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -8(%rbp)
	vmovsd	%xmm0, (%rax)
	movq	-64(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -64(%rbp)
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -8(%rbp)
	vmovsd	%xmm0, (%rax)
	movq	-72(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -72(%rbp)
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -8(%rbp)
	vmovsd	%xmm0, (%rax)
## %bb.5:                               ##   in Loop: Header=BB24_3 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	LBB24_3
LBB24_6:                                ##   in Loop: Header=BB24_1 Depth=1
	jmp	LBB24_7
LBB24_7:                                ##   in Loop: Header=BB24_1 Depth=1
	movl	-36(%rbp), %eax
	addl	$4, %eax
	movl	%eax, -36(%rbp)
	jmp	LBB24_1
LBB24_8:
	jmp	LBB24_9
LBB24_9:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB24_11 Depth 2
	movl	-36(%rbp), %eax
	movl	-28(%rbp), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jge	LBB24_16
## %bb.10:                              ##   in Loop: Header=BB24_9 Depth=1
	movq	-16(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-20(%rbp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movslq	-20(%rbp), %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	movl	$0, -32(%rbp)
LBB24_11:                               ##   Parent Loop BB24_9 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	LBB24_14
## %bb.12:                              ##   in Loop: Header=BB24_11 Depth=2
	movq	-48(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -48(%rbp)
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -8(%rbp)
	vmovsd	%xmm0, (%rax)
	movq	-56(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -56(%rbp)
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$8, %rcx
	movq	%rcx, -8(%rbp)
	vmovsd	%xmm0, (%rax)
## %bb.13:                              ##   in Loop: Header=BB24_11 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	LBB24_11
LBB24_14:                               ##   in Loop: Header=BB24_9 Depth=1
	jmp	LBB24_15
LBB24_15:                               ##   in Loop: Header=BB24_9 Depth=1
	movl	-36(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -36(%rbp)
	jmp	LBB24_9
LBB24_16:
	jmp	LBB24_17
LBB24_17:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB24_19 Depth 2
	movl	-36(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	LBB24_24
## %bb.18:                              ##   in Loop: Header=BB24_17 Depth=1
	movq	-16(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-20(%rbp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movl	$0, -32(%rbp)
LBB24_19:                               ##   Parent Loop BB24_17 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	LBB24_22
## %bb.20:                              ##   in Loop: Header=BB24_19 Depth=2
	movq	-48(%rbp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	movq	-8(%rbp), %rax
	vmovsd	%xmm0, (%rax)
## %bb.21:                              ##   in Loop: Header=BB24_19 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	movq	-8(%rbp), %rcx
	addq	$8, %rcx
	movq	%rcx, -8(%rbp)
	movq	-48(%rbp), %rcx
	addq	$8, %rcx
	movq	%rcx, -48(%rbp)
	jmp	LBB24_19
LBB24_22:                               ##   in Loop: Header=BB24_17 Depth=1
	jmp	LBB24_23
LBB24_23:                               ##   in Loop: Header=BB24_17 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	LBB24_17
LBB24_24:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function pack_a
_pack_a:                                ## @pack_a
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	andq	$-32, %rsp
	subq	$320, %rsp                      ## imm = 0x140
	movq	%rdi, 112(%rsp)
	movq	%rsi, 104(%rsp)
	movl	%edx, 100(%rsp)
	movl	%ecx, 96(%rsp)
	movl	%r8d, 92(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 64(%rsp)
	movl	$0, 88(%rsp)
LBB25_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB25_3 Depth 2
	movl	88(%rsp), %eax
	movl	96(%rsp), %ecx
	subl	$7, %ecx
	cmpl	%ecx, %eax
	jge	LBB25_8
## %bb.2:                               ##   in Loop: Header=BB25_1 Depth=1
	movq	104(%rsp), %rax
	movslq	88(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	movq	%rax, 72(%rsp)
	movl	$0, 84(%rsp)
LBB25_3:                                ##   Parent Loop BB25_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	84(%rsp), %eax
	cmpl	92(%rsp), %eax
	jge	LBB25_6
## %bb.4:                               ##   in Loop: Header=BB25_3 Depth=2
	movq	72(%rsp), %rax
	movq	%rax, 120(%rsp)
	movq	120(%rsp), %rax
	vmovupd	(%rax), %ymm0
	vmovapd	%ymm0, 32(%rsp)
	movq	72(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 296(%rsp)
	movq	296(%rsp), %rax
	vmovupd	(%rax), %ymm0
	vmovapd	%ymm0, (%rsp)
	movq	112(%rsp), %rax
	vmovapd	32(%rsp), %ymm0
	movq	%rax, 288(%rsp)
	vmovapd	%ymm0, 256(%rsp)
	vmovapd	256(%rsp), %ymm0
	movq	288(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	112(%rsp), %rax
	addq	$32, %rax
	vmovapd	(%rsp), %ymm0
	movq	%rax, 248(%rsp)
	vmovapd	%ymm0, 192(%rsp)
	vmovapd	192(%rsp), %ymm0
	movq	248(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.5:                               ##   in Loop: Header=BB25_3 Depth=2
	movl	84(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 84(%rsp)
	movq	112(%rsp), %rcx
	addq	$64, %rcx
	movq	%rcx, 112(%rsp)
	movl	100(%rsp), %eax
	movq	72(%rsp), %rcx
	movslq	%eax, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rcx
	movq	%rcx, 72(%rsp)
	jmp	LBB25_3
LBB25_6:                                ##   in Loop: Header=BB25_1 Depth=1
	jmp	LBB25_7
LBB25_7:                                ##   in Loop: Header=BB25_1 Depth=1
	movl	88(%rsp), %eax
	addl	$8, %eax
	movl	%eax, 88(%rsp)
	jmp	LBB25_1
LBB25_8:
	jmp	LBB25_9
LBB25_9:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB25_11 Depth 2
	movl	88(%rsp), %eax
	movl	96(%rsp), %ecx
	subl	$3, %ecx
	cmpl	%ecx, %eax
	jge	LBB25_16
## %bb.10:                              ##   in Loop: Header=BB25_9 Depth=1
	movq	104(%rsp), %rax
	movslq	88(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	movq	%rax, 72(%rsp)
	movl	$0, 84(%rsp)
LBB25_11:                               ##   Parent Loop BB25_9 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	84(%rsp), %eax
	cmpl	92(%rsp), %eax
	jge	LBB25_14
## %bb.12:                              ##   in Loop: Header=BB25_11 Depth=2
	movq	72(%rsp), %rax
	movq	%rax, 184(%rsp)
	movq	184(%rsp), %rax
	vmovupd	(%rax), %ymm0
	vmovapd	%ymm0, 32(%rsp)
	movq	112(%rsp), %rax
	vmovapd	32(%rsp), %ymm0
	movq	%rax, 176(%rsp)
	vmovapd	%ymm0, 128(%rsp)
	vmovapd	128(%rsp), %ymm0
	movq	176(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.13:                              ##   in Loop: Header=BB25_11 Depth=2
	movl	84(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 84(%rsp)
	movq	112(%rsp), %rcx
	addq	$32, %rcx
	movq	%rcx, 112(%rsp)
	movl	100(%rsp), %eax
	movq	72(%rsp), %rcx
	movslq	%eax, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rcx
	movq	%rcx, 72(%rsp)
	jmp	LBB25_11
LBB25_14:                               ##   in Loop: Header=BB25_9 Depth=1
	jmp	LBB25_15
LBB25_15:                               ##   in Loop: Header=BB25_9 Depth=1
	movl	88(%rsp), %eax
	addl	$4, %eax
	movl	%eax, 88(%rsp)
	jmp	LBB25_9
LBB25_16:
	jmp	LBB25_17
LBB25_17:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB25_19 Depth 2
	movl	88(%rsp), %eax
	movl	96(%rsp), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jge	LBB25_24
## %bb.18:                              ##   in Loop: Header=BB25_17 Depth=1
	movq	104(%rsp), %rax
	movslq	88(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	movq	%rax, 72(%rsp)
	movl	$0, 84(%rsp)
LBB25_19:                               ##   Parent Loop BB25_17 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	84(%rsp), %eax
	cmpl	92(%rsp), %eax
	jge	LBB25_22
## %bb.20:                              ##   in Loop: Header=BB25_19 Depth=2
	movq	72(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	movq	112(%rsp), %rax
	vmovsd	%xmm0, (%rax)
	movq	72(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	movq	112(%rsp), %rax
	vmovsd	%xmm0, 8(%rax)
## %bb.21:                              ##   in Loop: Header=BB25_19 Depth=2
	movl	84(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 84(%rsp)
	movq	112(%rsp), %rcx
	addq	$16, %rcx
	movq	%rcx, 112(%rsp)
	movl	100(%rsp), %eax
	movq	72(%rsp), %rcx
	movslq	%eax, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rcx
	movq	%rcx, 72(%rsp)
	jmp	LBB25_19
LBB25_22:                               ##   in Loop: Header=BB25_17 Depth=1
	jmp	LBB25_23
LBB25_23:                               ##   in Loop: Header=BB25_17 Depth=1
	movl	88(%rsp), %eax
	addl	$2, %eax
	movl	%eax, 88(%rsp)
	jmp	LBB25_17
LBB25_24:
	jmp	LBB25_25
LBB25_25:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB25_27 Depth 2
	movl	88(%rsp), %eax
	cmpl	96(%rsp), %eax
	jge	LBB25_32
## %bb.26:                              ##   in Loop: Header=BB25_25 Depth=1
	movq	104(%rsp), %rax
	movslq	88(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	movq	%rax, 72(%rsp)
	movl	$0, 84(%rsp)
LBB25_27:                               ##   Parent Loop BB25_25 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	84(%rsp), %eax
	cmpl	92(%rsp), %eax
	jge	LBB25_30
## %bb.28:                              ##   in Loop: Header=BB25_27 Depth=2
	movq	72(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	movq	112(%rsp), %rax
	vmovsd	%xmm0, (%rax)
## %bb.29:                              ##   in Loop: Header=BB25_27 Depth=2
	movl	84(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 84(%rsp)
	movl	100(%rsp), %eax
	movq	72(%rsp), %rcx
	movslq	%eax, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rcx
	movq	%rcx, 72(%rsp)
	movq	112(%rsp), %rcx
	addq	$8, %rcx
	movq	%rcx, 112(%rsp)
	jmp	LBB25_27
LBB25_30:                               ##   in Loop: Header=BB25_25 Depth=1
	jmp	LBB25_31
LBB25_31:                               ##   in Loop: Header=BB25_25 Depth=1
	movl	88(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 88(%rsp)
	jmp	LBB25_25
LBB25_32:
	movq	%rbp, %rsp
	popq	%rbp
	vzeroupper
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dgemm_5_mini
_dgemm_5_mini:                          ## @dgemm_5_mini
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	andq	$-32, %rsp
	movl	$30560, %eax                    ## imm = 0x7760
	callq	____chkstk_darwin
	subq	%rax, %rsp
	movl	32(%rbp), %eax
	movq	24(%rbp), %r10
	movl	16(%rbp), %r11d
	movl	%edi, 1012(%rsp)
	movl	%esi, 1008(%rsp)
	movl	%edx, 1004(%rsp)
	movq	%rcx, 992(%rsp)
	movl	%r8d, 988(%rsp)
	movq	%r9, 976(%rsp)
	movl	1012(%rsp), %edx
	andl	$-24, %edx
	movl	%edx, 940(%rsp)
	movl	1012(%rsp), %edx
	andl	$-8, %edx
	movl	%edx, 936(%rsp)
	movl	1012(%rsp), %edx
	andl	$-4, %edx
	movl	%edx, 932(%rsp)
	movl	1012(%rsp), %edx
	andl	$-2, %edx
	movl	%edx, 928(%rsp)
	movl	1008(%rsp), %edx
	andl	$-4, %edx
	movl	%edx, 924(%rsp)
	movl	1008(%rsp), %edx
	andl	$-2, %edx
	movl	%edx, 920(%rsp)
	movl	1004(%rsp), %edx
	andl	$-4, %edx
	movl	%edx, 916(%rsp)
	movabsq	$-4616189618054758400, %rcx     ## imm = 0xBFF0000000000000
	movq	%rcx, 1016(%rsp)
	vmovsd	1016(%rsp), %xmm0               ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 1096(%rsp)
	vmovsd	%xmm0, 1088(%rsp)
	vmovsd	%xmm0, 1080(%rsp)
	vmovsd	%xmm0, 1072(%rsp)
	vmovsd	1080(%rsp), %xmm0               ## xmm0 = mem[0],zero
	vmovsd	1072(%rsp), %xmm1               ## xmm1 = mem[0],zero
	vunpcklpd	%xmm0, %xmm1, %xmm0     ## xmm0 = xmm1[0],xmm0[0]
	vmovsd	1096(%rsp), %xmm1               ## xmm1 = mem[0],zero
	vmovsd	1088(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vunpcklpd	%xmm1, %xmm2, %xmm1     ## xmm1 = xmm2[0],xmm1[0]
	vmovapd	%xmm1, 1040(%rsp)
	vmovapd	%xmm0, 1024(%rsp)
	vmovapd	1024(%rsp), %ymm3
	vmovapd	%ymm3, 864(%rsp)
	movq	%rcx, 30536(%rsp)
	vmovddup	30536(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 30512(%rsp)
	vmovapd	30512(%rsp), %xmm0
	vmovapd	%xmm0, 848(%rsp)
	movl	$0, 968(%rsp)
	movl	$0, 972(%rsp)
LBB26_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB26_3 Depth 2
                                        ##       Child Loop BB26_5 Depth 3
                                        ##       Child Loop BB26_8 Depth 3
                                        ##     Child Loop BB26_13 Depth 2
                                        ##       Child Loop BB26_15 Depth 3
                                        ##       Child Loop BB26_18 Depth 3
                                        ##     Child Loop BB26_23 Depth 2
                                        ##       Child Loop BB26_25 Depth 3
                                        ##       Child Loop BB26_28 Depth 3
                                        ##     Child Loop BB26_33 Depth 2
                                        ##       Child Loop BB26_35 Depth 3
                                        ##       Child Loop BB26_38 Depth 3
	movl	968(%rsp), %eax
	cmpl	924(%rsp), %eax
	jge	LBB26_44
## %bb.2:                               ##   in Loop: Header=BB26_1 Depth=1
	movl	$0, 972(%rsp)
LBB26_3:                                ##   Parent Loop BB26_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_5 Depth 3
                                        ##       Child Loop BB26_8 Depth 3
	movl	972(%rsp), %eax
	cmpl	936(%rsp), %eax
	jge	LBB26_12
## %bb.4:                               ##   in Loop: Header=BB26_3 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovapd	%ymm0, 30464(%rsp)
	vmovapd	30464(%rsp), %ymm1
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	%ymm0, 30432(%rsp)
	vmovapd	30432(%rsp), %ymm1
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	%ymm0, 30400(%rsp)
	vmovapd	30400(%rsp), %ymm1
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	%ymm0, 30368(%rsp)
	vmovapd	30368(%rsp), %ymm1
	vmovapd	%ymm1, 224(%rsp)
	vmovapd	%ymm0, 30336(%rsp)
	vmovapd	30336(%rsp), %ymm1
	vmovapd	%ymm1, 192(%rsp)
	vmovapd	%ymm0, 30304(%rsp)
	vmovapd	30304(%rsp), %ymm1
	vmovapd	%ymm1, 160(%rsp)
	vmovapd	%ymm0, 30272(%rsp)
	vmovapd	30272(%rsp), %ymm1
	vmovapd	%ymm1, 128(%rsp)
	vmovapd	%ymm0, 30240(%rsp)
	vmovapd	30240(%rsp), %ymm0
	vmovapd	%ymm0, 96(%rsp)
	movl	$0, 964(%rsp)
LBB26_5:                                ##   Parent Loop BB26_1 Depth=1
                                        ##     Parent Loop BB26_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_7
## %bb.6:                               ##   in Loop: Header=BB26_5 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 30232(%rsp)
	movq	30232(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 30176(%rsp)
	vmovapd	%ymm1, 30144(%rsp)
	vmovapd	30176(%rsp), %ymm0
	vmovapd	30144(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 30136(%rsp)
	movq	30136(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 30080(%rsp)
	vmovapd	%ymm1, 30048(%rsp)
	vmovapd	30080(%rsp), %ymm0
	vmovapd	30048(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 29976(%rsp)
	vmovsd	29976(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 30040(%rsp)
	vmovsd	%xmm2, 30032(%rsp)
	vmovsd	%xmm2, 30024(%rsp)
	vmovsd	%xmm2, 30016(%rsp)
	vmovsd	30024(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	30016(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	30040(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	30032(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 30000(%rsp)
	vmovapd	%xmm2, 29984(%rsp)
	vmovapd	29984(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 29880(%rsp)
	vmovsd	29880(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 29968(%rsp)
	vmovsd	%xmm2, 29960(%rsp)
	vmovsd	%xmm2, 29952(%rsp)
	vmovsd	%xmm2, 29944(%rsp)
	vmovsd	29952(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	29944(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	29968(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	29960(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 29904(%rsp)
	vmovapd	%xmm2, 29888(%rsp)
	vmovapd	29888(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 29824(%rsp)
	vmovapd	%ymm1, 29792(%rsp)
	vmovapd	%ymm5, 29760(%rsp)
	vmovapd	29824(%rsp), %ymm0
	vmovapd	29792(%rsp), %ymm1
	vmovapd	29760(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 29728(%rsp)
	vmovapd	%ymm1, 29696(%rsp)
	vmovapd	%ymm5, 29664(%rsp)
	vmovapd	29728(%rsp), %ymm0
	vmovapd	29696(%rsp), %ymm1
	vmovapd	29664(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 29632(%rsp)
	vmovapd	%ymm1, 29600(%rsp)
	vmovapd	%ymm5, 29568(%rsp)
	vmovapd	29632(%rsp), %ymm0
	vmovapd	29600(%rsp), %ymm1
	vmovapd	29568(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	160(%rsp), %ymm5
	vmovapd	%ymm0, 29536(%rsp)
	vmovapd	%ymm1, 29504(%rsp)
	vmovapd	%ymm5, 29472(%rsp)
	vmovapd	29536(%rsp), %ymm0
	vmovapd	29504(%rsp), %ymm1
	vmovapd	29472(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 160(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 29400(%rsp)
	vmovsd	29400(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 29464(%rsp)
	vmovsd	%xmm2, 29456(%rsp)
	vmovsd	%xmm2, 29448(%rsp)
	vmovsd	%xmm2, 29440(%rsp)
	vmovsd	29448(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	29440(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	29464(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	29456(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 29424(%rsp)
	vmovapd	%xmm2, 29408(%rsp)
	vmovapd	29408(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 29304(%rsp)
	vmovsd	29304(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 29392(%rsp)
	vmovsd	%xmm2, 29384(%rsp)
	vmovsd	%xmm2, 29376(%rsp)
	vmovsd	%xmm2, 29368(%rsp)
	vmovsd	29376(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	29368(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	29392(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	29384(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 29328(%rsp)
	vmovapd	%xmm2, 29312(%rsp)
	vmovapd	29312(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	256(%rsp), %ymm5
	vmovapd	%ymm0, 29248(%rsp)
	vmovapd	%ymm1, 29216(%rsp)
	vmovapd	%ymm5, 29184(%rsp)
	vmovapd	29248(%rsp), %ymm0
	vmovapd	29216(%rsp), %ymm1
	vmovapd	29184(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	128(%rsp), %ymm5
	vmovapd	%ymm0, 29152(%rsp)
	vmovapd	%ymm1, 29120(%rsp)
	vmovapd	%ymm5, 29088(%rsp)
	vmovapd	29152(%rsp), %ymm0
	vmovapd	29120(%rsp), %ymm1
	vmovapd	29088(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 128(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	224(%rsp), %ymm5
	vmovapd	%ymm0, 29056(%rsp)
	vmovapd	%ymm1, 29024(%rsp)
	vmovapd	%ymm5, 28992(%rsp)
	vmovapd	29056(%rsp), %ymm0
	vmovapd	29024(%rsp), %ymm1
	vmovapd	28992(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 224(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	96(%rsp), %ymm5
	vmovapd	%ymm0, 28960(%rsp)
	vmovapd	%ymm1, 28928(%rsp)
	vmovapd	%ymm5, 28896(%rsp)
	vmovapd	28960(%rsp), %ymm0
	vmovapd	28928(%rsp), %ymm1
	vmovapd	28896(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 96(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 28888(%rsp)
	movq	28888(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 28832(%rsp)
	vmovapd	%ymm1, 28800(%rsp)
	vmovapd	28832(%rsp), %ymm0
	vmovapd	28800(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 28792(%rsp)
	movq	28792(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 28736(%rsp)
	vmovapd	%ymm1, 28704(%rsp)
	vmovapd	28736(%rsp), %ymm0
	vmovapd	28704(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 28632(%rsp)
	vmovsd	28632(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 28696(%rsp)
	vmovsd	%xmm2, 28688(%rsp)
	vmovsd	%xmm2, 28680(%rsp)
	vmovsd	%xmm2, 28672(%rsp)
	vmovsd	28680(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	28672(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	28696(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	28688(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 28656(%rsp)
	vmovapd	%xmm2, 28640(%rsp)
	vmovapd	28640(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 28536(%rsp)
	vmovsd	28536(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 28624(%rsp)
	vmovsd	%xmm2, 28616(%rsp)
	vmovsd	%xmm2, 28608(%rsp)
	vmovsd	%xmm2, 28600(%rsp)
	vmovsd	28608(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	28600(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	28624(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	28616(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 28560(%rsp)
	vmovapd	%xmm2, 28544(%rsp)
	vmovapd	28544(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 28480(%rsp)
	vmovapd	%ymm1, 28448(%rsp)
	vmovapd	%ymm5, 28416(%rsp)
	vmovapd	28480(%rsp), %ymm0
	vmovapd	28448(%rsp), %ymm1
	vmovapd	28416(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 28384(%rsp)
	vmovapd	%ymm1, 28352(%rsp)
	vmovapd	%ymm5, 28320(%rsp)
	vmovapd	28384(%rsp), %ymm0
	vmovapd	28352(%rsp), %ymm1
	vmovapd	28320(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 28288(%rsp)
	vmovapd	%ymm1, 28256(%rsp)
	vmovapd	%ymm5, 28224(%rsp)
	vmovapd	28288(%rsp), %ymm0
	vmovapd	28256(%rsp), %ymm1
	vmovapd	28224(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	160(%rsp), %ymm5
	vmovapd	%ymm0, 28192(%rsp)
	vmovapd	%ymm1, 28160(%rsp)
	vmovapd	%ymm5, 28128(%rsp)
	vmovapd	28192(%rsp), %ymm0
	vmovapd	28160(%rsp), %ymm1
	vmovapd	28128(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 160(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 28056(%rsp)
	vmovsd	28056(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 28120(%rsp)
	vmovsd	%xmm2, 28112(%rsp)
	vmovsd	%xmm2, 28104(%rsp)
	vmovsd	%xmm2, 28096(%rsp)
	vmovsd	28104(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	28096(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	28120(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	28112(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 28080(%rsp)
	vmovapd	%xmm2, 28064(%rsp)
	vmovapd	28064(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 27960(%rsp)
	vmovsd	27960(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 28048(%rsp)
	vmovsd	%xmm2, 28040(%rsp)
	vmovsd	%xmm2, 28032(%rsp)
	vmovsd	%xmm2, 28024(%rsp)
	vmovsd	28032(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	28024(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	28048(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	28040(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 27984(%rsp)
	vmovapd	%xmm2, 27968(%rsp)
	vmovapd	27968(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	256(%rsp), %ymm5
	vmovapd	%ymm0, 27904(%rsp)
	vmovapd	%ymm1, 27872(%rsp)
	vmovapd	%ymm5, 27840(%rsp)
	vmovapd	27904(%rsp), %ymm0
	vmovapd	27872(%rsp), %ymm1
	vmovapd	27840(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	128(%rsp), %ymm5
	vmovapd	%ymm0, 27808(%rsp)
	vmovapd	%ymm1, 27776(%rsp)
	vmovapd	%ymm5, 27744(%rsp)
	vmovapd	27808(%rsp), %ymm0
	vmovapd	27776(%rsp), %ymm1
	vmovapd	27744(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 128(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	224(%rsp), %ymm5
	vmovapd	%ymm0, 27712(%rsp)
	vmovapd	%ymm1, 27680(%rsp)
	vmovapd	%ymm5, 27648(%rsp)
	vmovapd	27712(%rsp), %ymm0
	vmovapd	27680(%rsp), %ymm1
	vmovapd	27648(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 224(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	96(%rsp), %ymm5
	vmovapd	%ymm0, 27616(%rsp)
	vmovapd	%ymm1, 27584(%rsp)
	vmovapd	%ymm5, 27552(%rsp)
	vmovapd	27616(%rsp), %ymm0
	vmovapd	27584(%rsp), %ymm1
	vmovapd	27552(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 96(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 27544(%rsp)
	movq	27544(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 27488(%rsp)
	vmovapd	%ymm1, 27456(%rsp)
	vmovapd	27488(%rsp), %ymm0
	vmovapd	27456(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 27448(%rsp)
	movq	27448(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 27392(%rsp)
	vmovapd	%ymm1, 27360(%rsp)
	vmovapd	27392(%rsp), %ymm0
	vmovapd	27360(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 27288(%rsp)
	vmovsd	27288(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 27352(%rsp)
	vmovsd	%xmm2, 27344(%rsp)
	vmovsd	%xmm2, 27336(%rsp)
	vmovsd	%xmm2, 27328(%rsp)
	vmovsd	27336(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	27328(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	27352(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	27344(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 27312(%rsp)
	vmovapd	%xmm2, 27296(%rsp)
	vmovapd	27296(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 27192(%rsp)
	vmovsd	27192(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 27280(%rsp)
	vmovsd	%xmm2, 27272(%rsp)
	vmovsd	%xmm2, 27264(%rsp)
	vmovsd	%xmm2, 27256(%rsp)
	vmovsd	27264(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	27256(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	27280(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	27272(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 27216(%rsp)
	vmovapd	%xmm2, 27200(%rsp)
	vmovapd	27200(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 27136(%rsp)
	vmovapd	%ymm1, 27104(%rsp)
	vmovapd	%ymm5, 27072(%rsp)
	vmovapd	27136(%rsp), %ymm0
	vmovapd	27104(%rsp), %ymm1
	vmovapd	27072(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 27040(%rsp)
	vmovapd	%ymm1, 27008(%rsp)
	vmovapd	%ymm5, 26976(%rsp)
	vmovapd	27040(%rsp), %ymm0
	vmovapd	27008(%rsp), %ymm1
	vmovapd	26976(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 26944(%rsp)
	vmovapd	%ymm1, 26912(%rsp)
	vmovapd	%ymm5, 26880(%rsp)
	vmovapd	26944(%rsp), %ymm0
	vmovapd	26912(%rsp), %ymm1
	vmovapd	26880(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	160(%rsp), %ymm5
	vmovapd	%ymm0, 26848(%rsp)
	vmovapd	%ymm1, 26816(%rsp)
	vmovapd	%ymm5, 26784(%rsp)
	vmovapd	26848(%rsp), %ymm0
	vmovapd	26816(%rsp), %ymm1
	vmovapd	26784(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 160(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 26712(%rsp)
	vmovsd	26712(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 26776(%rsp)
	vmovsd	%xmm2, 26768(%rsp)
	vmovsd	%xmm2, 26760(%rsp)
	vmovsd	%xmm2, 26752(%rsp)
	vmovsd	26760(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	26752(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	26776(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	26768(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 26736(%rsp)
	vmovapd	%xmm2, 26720(%rsp)
	vmovapd	26720(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 26616(%rsp)
	vmovsd	26616(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 26704(%rsp)
	vmovsd	%xmm2, 26696(%rsp)
	vmovsd	%xmm2, 26688(%rsp)
	vmovsd	%xmm2, 26680(%rsp)
	vmovsd	26688(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	26680(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	26704(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	26696(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 26640(%rsp)
	vmovapd	%xmm2, 26624(%rsp)
	vmovapd	26624(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	256(%rsp), %ymm5
	vmovapd	%ymm0, 26560(%rsp)
	vmovapd	%ymm1, 26528(%rsp)
	vmovapd	%ymm5, 26496(%rsp)
	vmovapd	26560(%rsp), %ymm0
	vmovapd	26528(%rsp), %ymm1
	vmovapd	26496(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	128(%rsp), %ymm5
	vmovapd	%ymm0, 26464(%rsp)
	vmovapd	%ymm1, 26432(%rsp)
	vmovapd	%ymm5, 26400(%rsp)
	vmovapd	26464(%rsp), %ymm0
	vmovapd	26432(%rsp), %ymm1
	vmovapd	26400(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 128(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	224(%rsp), %ymm5
	vmovapd	%ymm0, 26368(%rsp)
	vmovapd	%ymm1, 26336(%rsp)
	vmovapd	%ymm5, 26304(%rsp)
	vmovapd	26368(%rsp), %ymm0
	vmovapd	26336(%rsp), %ymm1
	vmovapd	26304(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 224(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	96(%rsp), %ymm5
	vmovapd	%ymm0, 26272(%rsp)
	vmovapd	%ymm1, 26240(%rsp)
	vmovapd	%ymm5, 26208(%rsp)
	vmovapd	26272(%rsp), %ymm0
	vmovapd	26240(%rsp), %ymm1
	vmovapd	26208(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 96(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 26200(%rsp)
	movq	26200(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 26144(%rsp)
	vmovapd	%ymm1, 26112(%rsp)
	vmovapd	26144(%rsp), %ymm0
	vmovapd	26112(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 26104(%rsp)
	movq	26104(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 26048(%rsp)
	vmovapd	%ymm1, 26016(%rsp)
	vmovapd	26048(%rsp), %ymm0
	vmovapd	26016(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 25944(%rsp)
	vmovsd	25944(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 26008(%rsp)
	vmovsd	%xmm2, 26000(%rsp)
	vmovsd	%xmm2, 25992(%rsp)
	vmovsd	%xmm2, 25984(%rsp)
	vmovsd	25992(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	25984(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	26008(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	26000(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 25968(%rsp)
	vmovapd	%xmm2, 25952(%rsp)
	vmovapd	25952(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 25848(%rsp)
	vmovsd	25848(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 25936(%rsp)
	vmovsd	%xmm2, 25928(%rsp)
	vmovsd	%xmm2, 25920(%rsp)
	vmovsd	%xmm2, 25912(%rsp)
	vmovsd	25920(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	25912(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	25936(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	25928(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 25872(%rsp)
	vmovapd	%xmm2, 25856(%rsp)
	vmovapd	25856(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 25792(%rsp)
	vmovapd	%ymm1, 25760(%rsp)
	vmovapd	%ymm5, 25728(%rsp)
	vmovapd	25792(%rsp), %ymm0
	vmovapd	25760(%rsp), %ymm1
	vmovapd	25728(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 25696(%rsp)
	vmovapd	%ymm1, 25664(%rsp)
	vmovapd	%ymm5, 25632(%rsp)
	vmovapd	25696(%rsp), %ymm0
	vmovapd	25664(%rsp), %ymm1
	vmovapd	25632(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 25600(%rsp)
	vmovapd	%ymm1, 25568(%rsp)
	vmovapd	%ymm5, 25536(%rsp)
	vmovapd	25600(%rsp), %ymm0
	vmovapd	25568(%rsp), %ymm1
	vmovapd	25536(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	160(%rsp), %ymm5
	vmovapd	%ymm0, 25504(%rsp)
	vmovapd	%ymm1, 25472(%rsp)
	vmovapd	%ymm5, 25440(%rsp)
	vmovapd	25504(%rsp), %ymm0
	vmovapd	25472(%rsp), %ymm1
	vmovapd	25440(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 160(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 25368(%rsp)
	vmovsd	25368(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 25432(%rsp)
	vmovsd	%xmm2, 25424(%rsp)
	vmovsd	%xmm2, 25416(%rsp)
	vmovsd	%xmm2, 25408(%rsp)
	vmovsd	25416(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	25408(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	25432(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	25424(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 25392(%rsp)
	vmovapd	%xmm2, 25376(%rsp)
	vmovapd	25376(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 25272(%rsp)
	vmovsd	25272(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 25360(%rsp)
	vmovsd	%xmm2, 25352(%rsp)
	vmovsd	%xmm2, 25344(%rsp)
	vmovsd	%xmm2, 25336(%rsp)
	vmovsd	25360(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	25352(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	25344(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	25336(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 25280(%rsp)
	vmovapd	25280(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	256(%rsp), %ymm5
	vmovapd	%ymm0, 25216(%rsp)
	vmovapd	%ymm1, 25184(%rsp)
	vmovapd	%ymm5, 25152(%rsp)
	vmovapd	25216(%rsp), %ymm0
	vmovapd	25184(%rsp), %ymm1
	vmovapd	25152(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	128(%rsp), %ymm5
	vmovapd	%ymm0, 25120(%rsp)
	vmovapd	%ymm1, 25088(%rsp)
	vmovapd	%ymm5, 25056(%rsp)
	vmovapd	25120(%rsp), %ymm0
	vmovapd	25088(%rsp), %ymm1
	vmovapd	25056(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 128(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	224(%rsp), %ymm5
	vmovapd	%ymm0, 25024(%rsp)
	vmovapd	%ymm1, 24992(%rsp)
	vmovapd	%ymm5, 24960(%rsp)
	vmovapd	25024(%rsp), %ymm0
	vmovapd	24992(%rsp), %ymm1
	vmovapd	24960(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 224(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	96(%rsp), %ymm5
	vmovapd	%ymm0, 24928(%rsp)
	vmovapd	%ymm1, 24896(%rsp)
	vmovapd	%ymm5, 24864(%rsp)
	vmovapd	24928(%rsp), %ymm0
	vmovapd	24896(%rsp), %ymm1
	vmovapd	24864(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 96(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_5
LBB26_7:                                ##   in Loop: Header=BB26_3 Depth=2
	jmp	LBB26_8
LBB26_8:                                ##   Parent Loop BB26_1 Depth=1
                                        ##     Parent Loop BB26_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_10
## %bb.9:                               ##   in Loop: Header=BB26_8 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 24856(%rsp)
	movq	24856(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 24800(%rsp)
	vmovapd	%ymm1, 24768(%rsp)
	vmovapd	24800(%rsp), %ymm0
	vmovapd	24768(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 24760(%rsp)
	movq	24760(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 24704(%rsp)
	vmovapd	%ymm1, 24672(%rsp)
	vmovapd	24704(%rsp), %ymm0
	vmovapd	24672(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 24600(%rsp)
	vmovsd	24600(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 24664(%rsp)
	vmovsd	%xmm2, 24656(%rsp)
	vmovsd	%xmm2, 24648(%rsp)
	vmovsd	%xmm2, 24640(%rsp)
	vmovsd	24648(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	24640(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	24664(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	24656(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 24624(%rsp)
	vmovapd	%xmm2, 24608(%rsp)
	vmovapd	24608(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 24504(%rsp)
	vmovsd	24504(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 24592(%rsp)
	vmovsd	%xmm2, 24584(%rsp)
	vmovsd	%xmm2, 24576(%rsp)
	vmovsd	%xmm2, 24568(%rsp)
	vmovsd	24576(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	24568(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	24592(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	24584(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 24528(%rsp)
	vmovapd	%xmm2, 24512(%rsp)
	vmovapd	24512(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 24448(%rsp)
	vmovapd	%ymm1, 24416(%rsp)
	vmovapd	%ymm5, 24384(%rsp)
	vmovapd	24448(%rsp), %ymm0
	vmovapd	24416(%rsp), %ymm1
	vmovapd	24384(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 24352(%rsp)
	vmovapd	%ymm1, 24320(%rsp)
	vmovapd	%ymm5, 24288(%rsp)
	vmovapd	24352(%rsp), %ymm0
	vmovapd	24320(%rsp), %ymm1
	vmovapd	24288(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 24256(%rsp)
	vmovapd	%ymm1, 24224(%rsp)
	vmovapd	%ymm5, 24192(%rsp)
	vmovapd	24256(%rsp), %ymm0
	vmovapd	24224(%rsp), %ymm1
	vmovapd	24192(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	160(%rsp), %ymm5
	vmovapd	%ymm0, 24160(%rsp)
	vmovapd	%ymm1, 24128(%rsp)
	vmovapd	%ymm5, 24096(%rsp)
	vmovapd	24160(%rsp), %ymm0
	vmovapd	24128(%rsp), %ymm1
	vmovapd	24096(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 160(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 24024(%rsp)
	vmovsd	24024(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 24088(%rsp)
	vmovsd	%xmm2, 24080(%rsp)
	vmovsd	%xmm2, 24072(%rsp)
	vmovsd	%xmm2, 24064(%rsp)
	vmovsd	24072(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	24064(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	24088(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	24080(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 24048(%rsp)
	vmovapd	%xmm2, 24032(%rsp)
	vmovapd	24032(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 23928(%rsp)
	vmovsd	23928(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 24016(%rsp)
	vmovsd	%xmm2, 24008(%rsp)
	vmovsd	%xmm2, 24000(%rsp)
	vmovsd	%xmm2, 23992(%rsp)
	vmovsd	24016(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	24008(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	24000(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	23992(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 23936(%rsp)
	vmovapd	23936(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	256(%rsp), %ymm5
	vmovapd	%ymm0, 23872(%rsp)
	vmovapd	%ymm1, 23840(%rsp)
	vmovapd	%ymm5, 23808(%rsp)
	vmovapd	23872(%rsp), %ymm0
	vmovapd	23840(%rsp), %ymm1
	vmovapd	23808(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	128(%rsp), %ymm5
	vmovapd	%ymm0, 23776(%rsp)
	vmovapd	%ymm1, 23744(%rsp)
	vmovapd	%ymm5, 23712(%rsp)
	vmovapd	23776(%rsp), %ymm0
	vmovapd	23744(%rsp), %ymm1
	vmovapd	23712(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 128(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	224(%rsp), %ymm5
	vmovapd	%ymm0, 23680(%rsp)
	vmovapd	%ymm1, 23648(%rsp)
	vmovapd	%ymm5, 23616(%rsp)
	vmovapd	23680(%rsp), %ymm0
	vmovapd	23648(%rsp), %ymm1
	vmovapd	23616(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 224(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	96(%rsp), %ymm5
	vmovapd	%ymm0, 23584(%rsp)
	vmovapd	%ymm1, 23552(%rsp)
	vmovapd	%ymm5, 23520(%rsp)
	vmovapd	23584(%rsp), %ymm0
	vmovapd	23552(%rsp), %ymm1
	vmovapd	23520(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 96(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_8
LBB26_10:                               ##   in Loop: Header=BB26_3 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	320(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 23512(%rsp)
	movq	23512(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 23456(%rsp)
	vmovapd	%ymm1, 23424(%rsp)
	vmovapd	23456(%rsp), %ymm0
	vaddpd	23424(%rsp), %ymm0, %ymm0
	movq	%rax, 23416(%rsp)
	vmovapd	%ymm0, 23360(%rsp)
	vmovapd	23360(%rsp), %ymm0
	movq	23416(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	192(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 23352(%rsp)
	movq	23352(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 23296(%rsp)
	vmovapd	%ymm1, 23264(%rsp)
	vmovapd	23296(%rsp), %ymm0
	vaddpd	23264(%rsp), %ymm0, %ymm0
	movq	%rax, 23256(%rsp)
	vmovapd	%ymm0, 23200(%rsp)
	vmovapd	23200(%rsp), %ymm0
	movq	23256(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	288(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 23192(%rsp)
	movq	23192(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 23136(%rsp)
	vmovapd	%ymm1, 23104(%rsp)
	vmovapd	23136(%rsp), %ymm0
	vaddpd	23104(%rsp), %ymm0, %ymm0
	movq	%rax, 23096(%rsp)
	vmovapd	%ymm0, 23040(%rsp)
	vmovapd	23040(%rsp), %ymm0
	movq	23096(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	160(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 23032(%rsp)
	movq	23032(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 22976(%rsp)
	vmovapd	%ymm1, 22944(%rsp)
	vmovapd	22976(%rsp), %ymm0
	vaddpd	22944(%rsp), %ymm0, %ymm0
	movq	%rax, 22936(%rsp)
	vmovapd	%ymm0, 22880(%rsp)
	vmovapd	22880(%rsp), %ymm0
	movq	22936(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	256(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 22872(%rsp)
	movq	22872(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 22816(%rsp)
	vmovapd	%ymm1, 22784(%rsp)
	vmovapd	22816(%rsp), %ymm0
	vaddpd	22784(%rsp), %ymm0, %ymm0
	movq	%rax, 22776(%rsp)
	vmovapd	%ymm0, 22720(%rsp)
	vmovapd	22720(%rsp), %ymm0
	movq	22776(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	128(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 22712(%rsp)
	movq	22712(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 22656(%rsp)
	vmovapd	%ymm1, 22624(%rsp)
	vmovapd	22656(%rsp), %ymm0
	vaddpd	22624(%rsp), %ymm0, %ymm0
	movq	%rax, 22616(%rsp)
	vmovapd	%ymm0, 22560(%rsp)
	vmovapd	22560(%rsp), %ymm0
	movq	22616(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	224(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 22552(%rsp)
	movq	22552(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 22496(%rsp)
	vmovapd	%ymm1, 22464(%rsp)
	vmovapd	22496(%rsp), %ymm0
	vaddpd	22464(%rsp), %ymm0, %ymm0
	movq	%rax, 22456(%rsp)
	vmovapd	%ymm0, 22400(%rsp)
	vmovapd	22400(%rsp), %ymm0
	movq	22456(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	96(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 22392(%rsp)
	movq	22392(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 22336(%rsp)
	vmovapd	%ymm1, 22304(%rsp)
	vmovapd	22336(%rsp), %ymm0
	vaddpd	22304(%rsp), %ymm0, %ymm0
	movq	%rax, 22296(%rsp)
	vmovapd	%ymm0, 22240(%rsp)
	vmovapd	22240(%rsp), %ymm0
	movq	22296(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.11:                              ##   in Loop: Header=BB26_3 Depth=2
	movl	972(%rsp), %eax
	addl	$8, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_3
LBB26_12:                               ##   in Loop: Header=BB26_1 Depth=1
	jmp	LBB26_13
LBB26_13:                               ##   Parent Loop BB26_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_15 Depth 3
                                        ##       Child Loop BB26_18 Depth 3
	movl	972(%rsp), %eax
	cmpl	932(%rsp), %eax
	jge	LBB26_22
## %bb.14:                              ##   in Loop: Header=BB26_13 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovapd	%ymm0, 22208(%rsp)
	vmovapd	22208(%rsp), %ymm1
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	%ymm0, 22176(%rsp)
	vmovapd	22176(%rsp), %ymm1
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	%ymm0, 22144(%rsp)
	vmovapd	22144(%rsp), %ymm1
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	%ymm0, 22112(%rsp)
	vmovapd	22112(%rsp), %ymm0
	vmovapd	%ymm0, 224(%rsp)
	movl	$0, 964(%rsp)
LBB26_15:                               ##   Parent Loop BB26_1 Depth=1
                                        ##     Parent Loop BB26_13 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_17
## %bb.16:                              ##   in Loop: Header=BB26_15 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 22104(%rsp)
	movq	22104(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 22048(%rsp)
	vmovapd	%ymm1, 22016(%rsp)
	vmovapd	22048(%rsp), %ymm0
	vmovapd	22016(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 21944(%rsp)
	vmovsd	21944(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 22008(%rsp)
	vmovsd	%xmm2, 22000(%rsp)
	vmovsd	%xmm2, 21992(%rsp)
	vmovsd	%xmm2, 21984(%rsp)
	vmovsd	21992(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	21984(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	22008(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	22000(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 21968(%rsp)
	vmovapd	%xmm2, 21952(%rsp)
	vmovapd	21952(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 21848(%rsp)
	vmovsd	21848(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 21936(%rsp)
	vmovsd	%xmm2, 21928(%rsp)
	vmovsd	%xmm2, 21920(%rsp)
	vmovsd	%xmm2, 21912(%rsp)
	vmovsd	21920(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	21912(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	21936(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	21928(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 21872(%rsp)
	vmovapd	%xmm2, 21856(%rsp)
	vmovapd	21856(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 21792(%rsp)
	vmovapd	%ymm1, 21760(%rsp)
	vmovapd	%ymm5, 21728(%rsp)
	vmovapd	21792(%rsp), %ymm0
	vmovapd	21760(%rsp), %ymm1
	vmovapd	21728(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 21696(%rsp)
	vmovapd	%ymm1, 21664(%rsp)
	vmovapd	%ymm5, 21632(%rsp)
	vmovapd	21696(%rsp), %ymm0
	vmovapd	21664(%rsp), %ymm1
	vmovapd	21632(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 21560(%rsp)
	vmovsd	21560(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 21624(%rsp)
	vmovsd	%xmm2, 21616(%rsp)
	vmovsd	%xmm2, 21608(%rsp)
	vmovsd	%xmm2, 21600(%rsp)
	vmovsd	21608(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	21600(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	21624(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	21616(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 21584(%rsp)
	vmovapd	%xmm2, 21568(%rsp)
	vmovapd	21568(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 21464(%rsp)
	vmovsd	21464(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 21552(%rsp)
	vmovsd	%xmm2, 21544(%rsp)
	vmovsd	%xmm2, 21536(%rsp)
	vmovsd	%xmm2, 21528(%rsp)
	vmovsd	21536(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	21528(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	21552(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	21544(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 21488(%rsp)
	vmovapd	%xmm2, 21472(%rsp)
	vmovapd	21472(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	256(%rsp), %ymm5
	vmovapd	%ymm0, 21408(%rsp)
	vmovapd	%ymm1, 21376(%rsp)
	vmovapd	%ymm5, 21344(%rsp)
	vmovapd	21408(%rsp), %ymm0
	vmovapd	21376(%rsp), %ymm1
	vmovapd	21344(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	224(%rsp), %ymm5
	vmovapd	%ymm0, 21312(%rsp)
	vmovapd	%ymm1, 21280(%rsp)
	vmovapd	%ymm5, 21248(%rsp)
	vmovapd	21312(%rsp), %ymm0
	vmovapd	21280(%rsp), %ymm1
	vmovapd	21248(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 224(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 21240(%rsp)
	movq	21240(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 21184(%rsp)
	vmovapd	%ymm1, 21152(%rsp)
	vmovapd	21184(%rsp), %ymm0
	vmovapd	21152(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 21080(%rsp)
	vmovsd	21080(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 21144(%rsp)
	vmovsd	%xmm2, 21136(%rsp)
	vmovsd	%xmm2, 21128(%rsp)
	vmovsd	%xmm2, 21120(%rsp)
	vmovsd	21128(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	21120(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	21144(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	21136(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 21104(%rsp)
	vmovapd	%xmm2, 21088(%rsp)
	vmovapd	21088(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 20984(%rsp)
	vmovsd	20984(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 21072(%rsp)
	vmovsd	%xmm2, 21064(%rsp)
	vmovsd	%xmm2, 21056(%rsp)
	vmovsd	%xmm2, 21048(%rsp)
	vmovsd	21056(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	21048(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	21072(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	21064(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 21008(%rsp)
	vmovapd	%xmm2, 20992(%rsp)
	vmovapd	20992(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 20928(%rsp)
	vmovapd	%ymm1, 20896(%rsp)
	vmovapd	%ymm5, 20864(%rsp)
	vmovapd	20928(%rsp), %ymm0
	vmovapd	20896(%rsp), %ymm1
	vmovapd	20864(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 20832(%rsp)
	vmovapd	%ymm1, 20800(%rsp)
	vmovapd	%ymm5, 20768(%rsp)
	vmovapd	20832(%rsp), %ymm0
	vmovapd	20800(%rsp), %ymm1
	vmovapd	20768(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 20696(%rsp)
	vmovsd	20696(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 20760(%rsp)
	vmovsd	%xmm2, 20752(%rsp)
	vmovsd	%xmm2, 20744(%rsp)
	vmovsd	%xmm2, 20736(%rsp)
	vmovsd	20744(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	20736(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	20760(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	20752(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 20720(%rsp)
	vmovapd	%xmm2, 20704(%rsp)
	vmovapd	20704(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 20600(%rsp)
	vmovsd	20600(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 20688(%rsp)
	vmovsd	%xmm2, 20680(%rsp)
	vmovsd	%xmm2, 20672(%rsp)
	vmovsd	%xmm2, 20664(%rsp)
	vmovsd	20672(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	20664(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	20688(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	20680(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 20624(%rsp)
	vmovapd	%xmm2, 20608(%rsp)
	vmovapd	20608(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	256(%rsp), %ymm5
	vmovapd	%ymm0, 20544(%rsp)
	vmovapd	%ymm1, 20512(%rsp)
	vmovapd	%ymm5, 20480(%rsp)
	vmovapd	20544(%rsp), %ymm0
	vmovapd	20512(%rsp), %ymm1
	vmovapd	20480(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	224(%rsp), %ymm5
	vmovapd	%ymm0, 20448(%rsp)
	vmovapd	%ymm1, 20416(%rsp)
	vmovapd	%ymm5, 20384(%rsp)
	vmovapd	20448(%rsp), %ymm0
	vmovapd	20416(%rsp), %ymm1
	vmovapd	20384(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 224(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 20376(%rsp)
	movq	20376(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 20320(%rsp)
	vmovapd	%ymm1, 20288(%rsp)
	vmovapd	20320(%rsp), %ymm0
	vmovapd	20288(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 20216(%rsp)
	vmovsd	20216(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 20280(%rsp)
	vmovsd	%xmm2, 20272(%rsp)
	vmovsd	%xmm2, 20264(%rsp)
	vmovsd	%xmm2, 20256(%rsp)
	vmovsd	20264(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	20256(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	20280(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	20272(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 20240(%rsp)
	vmovapd	%xmm2, 20224(%rsp)
	vmovapd	20224(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 20120(%rsp)
	vmovsd	20120(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 20208(%rsp)
	vmovsd	%xmm2, 20200(%rsp)
	vmovsd	%xmm2, 20192(%rsp)
	vmovsd	%xmm2, 20184(%rsp)
	vmovsd	20192(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	20184(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	20208(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	20200(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 20144(%rsp)
	vmovapd	%xmm2, 20128(%rsp)
	vmovapd	20128(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 20064(%rsp)
	vmovapd	%ymm1, 20032(%rsp)
	vmovapd	%ymm5, 20000(%rsp)
	vmovapd	20064(%rsp), %ymm0
	vmovapd	20032(%rsp), %ymm1
	vmovapd	20000(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 19968(%rsp)
	vmovapd	%ymm1, 19936(%rsp)
	vmovapd	%ymm5, 19904(%rsp)
	vmovapd	19968(%rsp), %ymm0
	vmovapd	19936(%rsp), %ymm1
	vmovapd	19904(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 19832(%rsp)
	vmovsd	19832(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 19896(%rsp)
	vmovsd	%xmm2, 19888(%rsp)
	vmovsd	%xmm2, 19880(%rsp)
	vmovsd	%xmm2, 19872(%rsp)
	vmovsd	19880(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	19872(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	19896(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	19888(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 19856(%rsp)
	vmovapd	%xmm2, 19840(%rsp)
	vmovapd	19840(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 19736(%rsp)
	vmovsd	19736(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 19824(%rsp)
	vmovsd	%xmm2, 19816(%rsp)
	vmovsd	%xmm2, 19808(%rsp)
	vmovsd	%xmm2, 19800(%rsp)
	vmovsd	19808(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	19800(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	19824(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	19816(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 19760(%rsp)
	vmovapd	%xmm2, 19744(%rsp)
	vmovapd	19744(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	256(%rsp), %ymm5
	vmovapd	%ymm0, 19680(%rsp)
	vmovapd	%ymm1, 19648(%rsp)
	vmovapd	%ymm5, 19616(%rsp)
	vmovapd	19680(%rsp), %ymm0
	vmovapd	19648(%rsp), %ymm1
	vmovapd	19616(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	224(%rsp), %ymm5
	vmovapd	%ymm0, 19584(%rsp)
	vmovapd	%ymm1, 19552(%rsp)
	vmovapd	%ymm5, 19520(%rsp)
	vmovapd	19584(%rsp), %ymm0
	vmovapd	19552(%rsp), %ymm1
	vmovapd	19520(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 224(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 19512(%rsp)
	movq	19512(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 19456(%rsp)
	vmovapd	%ymm1, 19424(%rsp)
	vmovapd	19456(%rsp), %ymm0
	vmovapd	19424(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 19352(%rsp)
	vmovsd	19352(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 19416(%rsp)
	vmovsd	%xmm2, 19408(%rsp)
	vmovsd	%xmm2, 19400(%rsp)
	vmovsd	%xmm2, 19392(%rsp)
	vmovsd	19400(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	19392(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	19416(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	19408(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 19376(%rsp)
	vmovapd	%xmm2, 19360(%rsp)
	vmovapd	19360(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 19256(%rsp)
	vmovsd	19256(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 19344(%rsp)
	vmovsd	%xmm2, 19336(%rsp)
	vmovsd	%xmm2, 19328(%rsp)
	vmovsd	%xmm2, 19320(%rsp)
	vmovsd	19328(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	19320(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	19344(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	19336(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 19280(%rsp)
	vmovapd	%xmm2, 19264(%rsp)
	vmovapd	19264(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 19200(%rsp)
	vmovapd	%ymm1, 19168(%rsp)
	vmovapd	%ymm5, 19136(%rsp)
	vmovapd	19200(%rsp), %ymm0
	vmovapd	19168(%rsp), %ymm1
	vmovapd	19136(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 19104(%rsp)
	vmovapd	%ymm1, 19072(%rsp)
	vmovapd	%ymm5, 19040(%rsp)
	vmovapd	19104(%rsp), %ymm0
	vmovapd	19072(%rsp), %ymm1
	vmovapd	19040(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18968(%rsp)
	vmovsd	18968(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 19032(%rsp)
	vmovsd	%xmm2, 19024(%rsp)
	vmovsd	%xmm2, 19016(%rsp)
	vmovsd	%xmm2, 19008(%rsp)
	vmovsd	19016(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	19008(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	19032(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	19024(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 18992(%rsp)
	vmovapd	%xmm2, 18976(%rsp)
	vmovapd	18976(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18872(%rsp)
	vmovsd	18872(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18960(%rsp)
	vmovsd	%xmm2, 18952(%rsp)
	vmovsd	%xmm2, 18944(%rsp)
	vmovsd	%xmm2, 18936(%rsp)
	vmovsd	18960(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	18952(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	18944(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	18936(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 18880(%rsp)
	vmovapd	18880(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	256(%rsp), %ymm5
	vmovapd	%ymm0, 18816(%rsp)
	vmovapd	%ymm1, 18784(%rsp)
	vmovapd	%ymm5, 18752(%rsp)
	vmovapd	18816(%rsp), %ymm0
	vmovapd	18784(%rsp), %ymm1
	vmovapd	18752(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	224(%rsp), %ymm5
	vmovapd	%ymm0, 18720(%rsp)
	vmovapd	%ymm1, 18688(%rsp)
	vmovapd	%ymm5, 18656(%rsp)
	vmovapd	18720(%rsp), %ymm0
	vmovapd	18688(%rsp), %ymm1
	vmovapd	18656(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 224(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_15
LBB26_17:                               ##   in Loop: Header=BB26_13 Depth=2
	movl	916(%rsp), %eax
	movl	%eax, 964(%rsp)
LBB26_18:                               ##   Parent Loop BB26_1 Depth=1
                                        ##     Parent Loop BB26_13 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_20
## %bb.19:                              ##   in Loop: Header=BB26_18 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 18648(%rsp)
	movq	18648(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 18592(%rsp)
	vmovapd	%ymm1, 18560(%rsp)
	vmovapd	18592(%rsp), %ymm0
	vmovapd	18560(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18488(%rsp)
	vmovsd	18488(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18552(%rsp)
	vmovsd	%xmm2, 18544(%rsp)
	vmovsd	%xmm2, 18536(%rsp)
	vmovsd	%xmm2, 18528(%rsp)
	vmovsd	18536(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	18528(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	18552(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	18544(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 18512(%rsp)
	vmovapd	%xmm2, 18496(%rsp)
	vmovapd	18496(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18392(%rsp)
	vmovsd	18392(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18480(%rsp)
	vmovsd	%xmm2, 18472(%rsp)
	vmovsd	%xmm2, 18464(%rsp)
	vmovsd	%xmm2, 18456(%rsp)
	vmovsd	18464(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	18456(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	18480(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	18472(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 18416(%rsp)
	vmovapd	%xmm2, 18400(%rsp)
	vmovapd	18400(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 18336(%rsp)
	vmovapd	%ymm1, 18304(%rsp)
	vmovapd	%ymm5, 18272(%rsp)
	vmovapd	18336(%rsp), %ymm0
	vmovapd	18304(%rsp), %ymm1
	vmovapd	18272(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 18240(%rsp)
	vmovapd	%ymm1, 18208(%rsp)
	vmovapd	%ymm5, 18176(%rsp)
	vmovapd	18240(%rsp), %ymm0
	vmovapd	18208(%rsp), %ymm1
	vmovapd	18176(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18104(%rsp)
	vmovsd	18104(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18168(%rsp)
	vmovsd	%xmm2, 18160(%rsp)
	vmovsd	%xmm2, 18152(%rsp)
	vmovsd	%xmm2, 18144(%rsp)
	vmovsd	18152(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	18144(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	18168(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	18160(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 18128(%rsp)
	vmovapd	%xmm2, 18112(%rsp)
	vmovapd	18112(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm2                 ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18008(%rsp)
	vmovsd	18008(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 18096(%rsp)
	vmovsd	%xmm2, 18088(%rsp)
	vmovsd	%xmm2, 18080(%rsp)
	vmovsd	%xmm2, 18072(%rsp)
	vmovsd	18096(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	18088(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	18080(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	18072(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 18016(%rsp)
	vmovapd	18016(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	256(%rsp), %ymm5
	vmovapd	%ymm0, 17952(%rsp)
	vmovapd	%ymm1, 17920(%rsp)
	vmovapd	%ymm5, 17888(%rsp)
	vmovapd	17952(%rsp), %ymm0
	vmovapd	17920(%rsp), %ymm1
	vmovapd	17888(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 256(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	224(%rsp), %ymm5
	vmovapd	%ymm0, 17856(%rsp)
	vmovapd	%ymm1, 17824(%rsp)
	vmovapd	%ymm5, 17792(%rsp)
	vmovapd	17856(%rsp), %ymm0
	vmovapd	17824(%rsp), %ymm1
	vmovapd	17792(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 224(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_18
LBB26_20:                               ##   in Loop: Header=BB26_13 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	320(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 17784(%rsp)
	movq	17784(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 17728(%rsp)
	vmovapd	%ymm1, 17696(%rsp)
	vmovapd	17728(%rsp), %ymm0
	vaddpd	17696(%rsp), %ymm0, %ymm0
	movq	%rax, 17688(%rsp)
	vmovapd	%ymm0, 17632(%rsp)
	vmovapd	17632(%rsp), %ymm0
	movq	17688(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	288(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 17624(%rsp)
	movq	17624(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 17568(%rsp)
	vmovapd	%ymm1, 17536(%rsp)
	vmovapd	17568(%rsp), %ymm0
	vaddpd	17536(%rsp), %ymm0, %ymm0
	movq	%rax, 17528(%rsp)
	vmovapd	%ymm0, 17472(%rsp)
	vmovapd	17472(%rsp), %ymm0
	movq	17528(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	256(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 17464(%rsp)
	movq	17464(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 17408(%rsp)
	vmovapd	%ymm1, 17376(%rsp)
	vmovapd	17408(%rsp), %ymm0
	vaddpd	17376(%rsp), %ymm0, %ymm0
	movq	%rax, 17368(%rsp)
	vmovapd	%ymm0, 17312(%rsp)
	vmovapd	17312(%rsp), %ymm0
	movq	17368(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	224(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 17304(%rsp)
	movq	17304(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 17248(%rsp)
	vmovapd	%ymm1, 17216(%rsp)
	vmovapd	17248(%rsp), %ymm0
	vaddpd	17216(%rsp), %ymm0, %ymm0
	movq	%rax, 17208(%rsp)
	vmovapd	%ymm0, 17152(%rsp)
	vmovapd	17152(%rsp), %ymm0
	movq	17208(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.21:                              ##   in Loop: Header=BB26_13 Depth=2
	movl	972(%rsp), %eax
	addl	$4, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_13
LBB26_22:                               ##   in Loop: Header=BB26_1 Depth=1
	jmp	LBB26_23
LBB26_23:                               ##   Parent Loop BB26_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_25 Depth 3
                                        ##       Child Loop BB26_28 Depth 3
	movl	972(%rsp), %eax
	cmpl	928(%rsp), %eax
	jge	LBB26_32
## %bb.24:                              ##   in Loop: Header=BB26_23 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovapd	%xmm0, 17136(%rsp)
	vmovapd	17136(%rsp), %xmm1
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	%xmm0, 17120(%rsp)
	vmovapd	17120(%rsp), %xmm1
	vmovapd	%xmm1, 720(%rsp)
	vmovapd	%xmm0, 17104(%rsp)
	vmovapd	17104(%rsp), %xmm1
	vmovapd	%xmm1, 704(%rsp)
	vmovapd	%xmm0, 17088(%rsp)
	vmovapd	17088(%rsp), %xmm0
	vmovapd	%xmm0, 688(%rsp)
	movl	$0, 964(%rsp)
LBB26_25:                               ##   Parent Loop BB26_1 Depth=1
                                        ##     Parent Loop BB26_23 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_27
## %bb.26:                              ##   in Loop: Header=BB26_25 Depth=3
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 17080(%rsp)
	movq	17080(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 17056(%rsp)
	vmovapd	%xmm1, 17040(%rsp)
	vmovapd	17056(%rsp), %xmm0
	vmovapd	17040(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 17032(%rsp)
	vmovddup	17032(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 17008(%rsp)
	vmovapd	17008(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 17000(%rsp)
	vmovddup	17000(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16976(%rsp)
	vmovapd	16976(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 16960(%rsp)
	vmovapd	%xmm1, 16944(%rsp)
	vmovapd	%xmm2, 16928(%rsp)
	vmovapd	16960(%rsp), %xmm0
	vmovapd	16944(%rsp), %xmm1
	vmovapd	16928(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	720(%rsp), %xmm2
	vmovapd	%xmm0, 16912(%rsp)
	vmovapd	%xmm1, 16896(%rsp)
	vmovapd	%xmm2, 16880(%rsp)
	vmovapd	16912(%rsp), %xmm0
	vmovapd	16896(%rsp), %xmm1
	vmovapd	16880(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 720(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 16872(%rsp)
	vmovddup	16872(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16848(%rsp)
	vmovapd	16848(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 16840(%rsp)
	vmovddup	16840(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16816(%rsp)
	vmovapd	16816(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	704(%rsp), %xmm2
	vmovapd	%xmm0, 16800(%rsp)
	vmovapd	%xmm1, 16784(%rsp)
	vmovapd	%xmm2, 16768(%rsp)
	vmovapd	16800(%rsp), %xmm0
	vmovapd	16784(%rsp), %xmm1
	vmovapd	16768(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 704(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	688(%rsp), %xmm2
	vmovapd	%xmm0, 16752(%rsp)
	vmovapd	%xmm1, 16736(%rsp)
	vmovapd	%xmm2, 16720(%rsp)
	vmovapd	16752(%rsp), %xmm0
	vmovapd	16736(%rsp), %xmm1
	vmovapd	16720(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 688(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 16712(%rsp)
	movq	16712(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 16688(%rsp)
	vmovapd	%xmm1, 16672(%rsp)
	vmovapd	16688(%rsp), %xmm0
	vmovapd	16672(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 16664(%rsp)
	vmovddup	16664(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16640(%rsp)
	vmovapd	16640(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 16632(%rsp)
	vmovddup	16632(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16608(%rsp)
	vmovapd	16608(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 16592(%rsp)
	vmovapd	%xmm1, 16576(%rsp)
	vmovapd	%xmm2, 16560(%rsp)
	vmovapd	16592(%rsp), %xmm0
	vmovapd	16576(%rsp), %xmm1
	vmovapd	16560(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	720(%rsp), %xmm2
	vmovapd	%xmm0, 16544(%rsp)
	vmovapd	%xmm1, 16528(%rsp)
	vmovapd	%xmm2, 16512(%rsp)
	vmovapd	16544(%rsp), %xmm0
	vmovapd	16528(%rsp), %xmm1
	vmovapd	16512(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 720(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 16504(%rsp)
	vmovddup	16504(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16480(%rsp)
	vmovapd	16480(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 16472(%rsp)
	vmovddup	16472(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16448(%rsp)
	vmovapd	16448(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	704(%rsp), %xmm2
	vmovapd	%xmm0, 16432(%rsp)
	vmovapd	%xmm1, 16416(%rsp)
	vmovapd	%xmm2, 16400(%rsp)
	vmovapd	16432(%rsp), %xmm0
	vmovapd	16416(%rsp), %xmm1
	vmovapd	16400(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 704(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	688(%rsp), %xmm2
	vmovapd	%xmm0, 16384(%rsp)
	vmovapd	%xmm1, 16368(%rsp)
	vmovapd	%xmm2, 16352(%rsp)
	vmovapd	16384(%rsp), %xmm0
	vmovapd	16368(%rsp), %xmm1
	vmovapd	16352(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 688(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 16344(%rsp)
	movq	16344(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 16320(%rsp)
	vmovapd	%xmm1, 16304(%rsp)
	vmovapd	16320(%rsp), %xmm0
	vmovapd	16304(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 16296(%rsp)
	vmovddup	16296(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16272(%rsp)
	vmovapd	16272(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 16264(%rsp)
	vmovddup	16264(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16240(%rsp)
	vmovapd	16240(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 16224(%rsp)
	vmovapd	%xmm1, 16208(%rsp)
	vmovapd	%xmm2, 16192(%rsp)
	vmovapd	16224(%rsp), %xmm0
	vmovapd	16208(%rsp), %xmm1
	vmovapd	16192(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	720(%rsp), %xmm2
	vmovapd	%xmm0, 16176(%rsp)
	vmovapd	%xmm1, 16160(%rsp)
	vmovapd	%xmm2, 16144(%rsp)
	vmovapd	16176(%rsp), %xmm0
	vmovapd	16160(%rsp), %xmm1
	vmovapd	16144(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 720(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 16136(%rsp)
	vmovddup	16136(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16112(%rsp)
	vmovapd	16112(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 16104(%rsp)
	vmovddup	16104(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 16080(%rsp)
	vmovapd	16080(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	704(%rsp), %xmm2
	vmovapd	%xmm0, 16064(%rsp)
	vmovapd	%xmm1, 16048(%rsp)
	vmovapd	%xmm2, 16032(%rsp)
	vmovapd	16064(%rsp), %xmm0
	vmovapd	16048(%rsp), %xmm1
	vmovapd	16032(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 704(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	688(%rsp), %xmm2
	vmovapd	%xmm0, 16016(%rsp)
	vmovapd	%xmm1, 16000(%rsp)
	vmovapd	%xmm2, 15984(%rsp)
	vmovapd	16016(%rsp), %xmm0
	vmovapd	16000(%rsp), %xmm1
	vmovapd	15984(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 688(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 15976(%rsp)
	movq	15976(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 15952(%rsp)
	vmovapd	%xmm1, 15936(%rsp)
	vmovapd	15952(%rsp), %xmm0
	vmovapd	15936(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 15928(%rsp)
	vmovddup	15928(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 15904(%rsp)
	vmovapd	15904(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 15896(%rsp)
	vmovddup	15896(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 15872(%rsp)
	vmovapd	15872(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 15856(%rsp)
	vmovapd	%xmm1, 15840(%rsp)
	vmovapd	%xmm2, 15824(%rsp)
	vmovapd	15856(%rsp), %xmm0
	vmovapd	15840(%rsp), %xmm1
	vmovapd	15824(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	720(%rsp), %xmm2
	vmovapd	%xmm0, 15808(%rsp)
	vmovapd	%xmm1, 15792(%rsp)
	vmovapd	%xmm2, 15776(%rsp)
	vmovapd	15808(%rsp), %xmm0
	vmovapd	15792(%rsp), %xmm1
	vmovapd	15776(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 720(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 15768(%rsp)
	vmovddup	15768(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 15744(%rsp)
	vmovapd	15744(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 15736(%rsp)
	vmovddup	15736(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 15712(%rsp)
	vmovapd	15712(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	704(%rsp), %xmm2
	vmovapd	%xmm0, 15696(%rsp)
	vmovapd	%xmm1, 15680(%rsp)
	vmovapd	%xmm2, 15664(%rsp)
	vmovapd	15696(%rsp), %xmm0
	vmovapd	15680(%rsp), %xmm1
	vmovapd	15664(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 704(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	688(%rsp), %xmm2
	vmovapd	%xmm0, 15648(%rsp)
	vmovapd	%xmm1, 15632(%rsp)
	vmovapd	%xmm2, 15616(%rsp)
	vmovapd	15648(%rsp), %xmm0
	vmovapd	15632(%rsp), %xmm1
	vmovapd	15616(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 688(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_25
LBB26_27:                               ##   in Loop: Header=BB26_23 Depth=2
	movl	916(%rsp), %eax
	movl	%eax, 964(%rsp)
LBB26_28:                               ##   Parent Loop BB26_1 Depth=1
                                        ##     Parent Loop BB26_23 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_30
## %bb.29:                              ##   in Loop: Header=BB26_28 Depth=3
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 15608(%rsp)
	movq	15608(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 15584(%rsp)
	vmovapd	%xmm1, 15568(%rsp)
	vmovapd	15584(%rsp), %xmm0
	vmovapd	15568(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 15560(%rsp)
	vmovddup	15560(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 15536(%rsp)
	vmovapd	15536(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 15528(%rsp)
	vmovddup	15528(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 15504(%rsp)
	vmovapd	15504(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 15488(%rsp)
	vmovapd	%xmm1, 15472(%rsp)
	vmovapd	%xmm2, 15456(%rsp)
	vmovapd	15488(%rsp), %xmm0
	vmovapd	15472(%rsp), %xmm1
	vmovapd	15456(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	720(%rsp), %xmm2
	vmovapd	%xmm0, 15440(%rsp)
	vmovapd	%xmm1, 15424(%rsp)
	vmovapd	%xmm2, 15408(%rsp)
	vmovapd	15440(%rsp), %xmm0
	vmovapd	15424(%rsp), %xmm1
	vmovapd	15408(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 720(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 15400(%rsp)
	vmovddup	15400(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 15376(%rsp)
	vmovapd	15376(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 15368(%rsp)
	vmovddup	15368(%rsp), %xmm0              ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 15344(%rsp)
	vmovapd	15344(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	704(%rsp), %xmm2
	vmovapd	%xmm0, 15328(%rsp)
	vmovapd	%xmm1, 15312(%rsp)
	vmovapd	%xmm2, 15296(%rsp)
	vmovapd	15328(%rsp), %xmm0
	vmovapd	15312(%rsp), %xmm1
	vmovapd	15296(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 704(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	688(%rsp), %xmm2
	vmovapd	%xmm0, 15280(%rsp)
	vmovapd	%xmm1, 15264(%rsp)
	vmovapd	%xmm2, 15248(%rsp)
	vmovapd	15280(%rsp), %xmm0
	vmovapd	15264(%rsp), %xmm1
	vmovapd	15248(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 688(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_28
LBB26_30:                               ##   in Loop: Header=BB26_23 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	736(%rsp), %xmm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 15240(%rsp)
	movq	15240(%rsp), %rsi
	vmovupd	(%rsi), %xmm1
	vmovapd	%xmm0, 15216(%rsp)
	vmovapd	%xmm1, 15200(%rsp)
	vmovapd	15216(%rsp), %xmm0
	vaddpd	15200(%rsp), %xmm0, %xmm0
	movq	%rax, 15192(%rsp)
	vmovapd	%xmm0, 15168(%rsp)
	vmovapd	15168(%rsp), %xmm0
	movq	15192(%rsp), %rax
	vmovupd	%xmm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	720(%rsp), %xmm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 15160(%rsp)
	movq	15160(%rsp), %rsi
	vmovupd	(%rsi), %xmm1
	vmovapd	%xmm0, 15136(%rsp)
	vmovapd	%xmm1, 15120(%rsp)
	vmovapd	15136(%rsp), %xmm0
	vaddpd	15120(%rsp), %xmm0, %xmm0
	movq	%rax, 15112(%rsp)
	vmovapd	%xmm0, 15088(%rsp)
	vmovapd	15088(%rsp), %xmm0
	movq	15112(%rsp), %rax
	vmovupd	%xmm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	704(%rsp), %xmm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 15080(%rsp)
	movq	15080(%rsp), %rsi
	vmovupd	(%rsi), %xmm1
	vmovapd	%xmm0, 15056(%rsp)
	vmovapd	%xmm1, 15040(%rsp)
	vmovapd	15056(%rsp), %xmm0
	vaddpd	15040(%rsp), %xmm0, %xmm0
	movq	%rax, 15032(%rsp)
	vmovapd	%xmm0, 15008(%rsp)
	vmovapd	15008(%rsp), %xmm0
	movq	15032(%rsp), %rax
	vmovupd	%xmm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	688(%rsp), %xmm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 15000(%rsp)
	movq	15000(%rsp), %rsi
	vmovupd	(%rsi), %xmm1
	vmovapd	%xmm0, 14976(%rsp)
	vmovapd	%xmm1, 14960(%rsp)
	vmovapd	14976(%rsp), %xmm0
	vaddpd	14960(%rsp), %xmm0, %xmm0
	movq	%rax, 14952(%rsp)
	vmovapd	%xmm0, 14928(%rsp)
	vmovapd	14928(%rsp), %xmm0
	movq	14952(%rsp), %rax
	vmovupd	%xmm0, (%rax)
## %bb.31:                              ##   in Loop: Header=BB26_23 Depth=2
	movl	972(%rsp), %eax
	addl	$2, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_23
LBB26_32:                               ##   in Loop: Header=BB26_1 Depth=1
	jmp	LBB26_33
LBB26_33:                               ##   Parent Loop BB26_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_35 Depth 3
                                        ##       Child Loop BB26_38 Depth 3
	movl	972(%rsp), %eax
	cmpl	1012(%rsp), %eax
	jge	LBB26_42
## %bb.34:                              ##   in Loop: Header=BB26_33 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	imull	1004(%rsp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	imull	1004(%rsp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovsd	%xmm0, 24(%rsp)
	vmovsd	%xmm0, 32(%rsp)
	vmovsd	%xmm0, 40(%rsp)
	vmovsd	%xmm0, 48(%rsp)
	movl	$0, 964(%rsp)
LBB26_35:                               ##   Parent Loop BB26_1 Depth=1
                                        ##     Parent Loop BB26_33 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_37
## %bb.36:                              ##   in Loop: Header=BB26_35 Depth=3
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	40(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	32(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 32(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	24(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 24(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	40(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	32(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 32(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	24(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 24(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	40(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	32(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 32(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	24(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 24(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	40(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	32(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 32(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	24(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 24(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_35
LBB26_37:                               ##   in Loop: Header=BB26_33 Depth=2
	movl	916(%rsp), %eax
	movl	%eax, 964(%rsp)
LBB26_38:                               ##   Parent Loop BB26_1 Depth=1
                                        ##     Parent Loop BB26_33 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_40
## %bb.39:                              ##   in Loop: Header=BB26_38 Depth=3
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	40(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	movq	944(%rsp), %rax
	vmovsd	16(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	24(%rax), %xmm0                 ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	32(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 32(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	24(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 24(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_38
LBB26_40:                               ##   in Loop: Header=BB26_33 Depth=2
	vmovsd	48(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vaddsd	(%rax,%rsi,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	40(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vaddsd	(%rax,%rsi,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	32(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vaddsd	(%rax,%rsi,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	24(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vaddsd	(%rax,%rsi,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.41:                              ##   in Loop: Header=BB26_33 Depth=2
	movl	972(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_33
LBB26_42:                               ##   in Loop: Header=BB26_1 Depth=1
	jmp	LBB26_43
LBB26_43:                               ##   in Loop: Header=BB26_1 Depth=1
	movl	968(%rsp), %eax
	addl	$4, %eax
	movl	%eax, 968(%rsp)
	jmp	LBB26_1
LBB26_44:
	jmp	LBB26_45
LBB26_45:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB26_47 Depth 2
                                        ##       Child Loop BB26_49 Depth 3
                                        ##       Child Loop BB26_52 Depth 3
                                        ##     Child Loop BB26_57 Depth 2
                                        ##       Child Loop BB26_59 Depth 3
                                        ##       Child Loop BB26_62 Depth 3
                                        ##     Child Loop BB26_67 Depth 2
                                        ##       Child Loop BB26_69 Depth 3
                                        ##       Child Loop BB26_72 Depth 3
                                        ##     Child Loop BB26_77 Depth 2
                                        ##       Child Loop BB26_79 Depth 3
                                        ##       Child Loop BB26_82 Depth 3
	movl	968(%rsp), %eax
	cmpl	920(%rsp), %eax
	jge	LBB26_88
## %bb.46:                              ##   in Loop: Header=BB26_45 Depth=1
	movl	$0, 972(%rsp)
LBB26_47:                               ##   Parent Loop BB26_45 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_49 Depth 3
                                        ##       Child Loop BB26_52 Depth 3
	movl	972(%rsp), %eax
	cmpl	936(%rsp), %eax
	jge	LBB26_56
## %bb.48:                              ##   in Loop: Header=BB26_47 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovapd	%ymm0, 14880(%rsp)
	vmovapd	14880(%rsp), %ymm1
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	%ymm0, 14848(%rsp)
	vmovapd	14848(%rsp), %ymm1
	vmovapd	%ymm1, 192(%rsp)
	vmovapd	%ymm0, 14816(%rsp)
	vmovapd	14816(%rsp), %ymm1
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	%ymm0, 14784(%rsp)
	vmovapd	14784(%rsp), %ymm0
	vmovapd	%ymm0, 160(%rsp)
	movl	$0, 964(%rsp)
LBB26_49:                               ##   Parent Loop BB26_45 Depth=1
                                        ##     Parent Loop BB26_47 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_51
## %bb.50:                              ##   in Loop: Header=BB26_49 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 14776(%rsp)
	movq	14776(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 14720(%rsp)
	vmovapd	%ymm1, 14688(%rsp)
	vmovapd	14720(%rsp), %ymm0
	vmovapd	14688(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 14680(%rsp)
	movq	14680(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 14624(%rsp)
	vmovapd	%ymm1, 14592(%rsp)
	vmovapd	14624(%rsp), %ymm0
	vmovapd	14592(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 14520(%rsp)
	vmovsd	14520(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 14584(%rsp)
	vmovsd	%xmm2, 14576(%rsp)
	vmovsd	%xmm2, 14568(%rsp)
	vmovsd	%xmm2, 14560(%rsp)
	vmovsd	14568(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	14560(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	14584(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	14576(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 14544(%rsp)
	vmovapd	%xmm2, 14528(%rsp)
	vmovapd	14528(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 14464(%rsp)
	vmovapd	%ymm1, 14432(%rsp)
	vmovapd	%ymm5, 14400(%rsp)
	vmovapd	14464(%rsp), %ymm0
	vmovapd	14432(%rsp), %ymm1
	vmovapd	14400(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 14368(%rsp)
	vmovapd	%ymm1, 14336(%rsp)
	vmovapd	%ymm5, 14304(%rsp)
	vmovapd	14368(%rsp), %ymm0
	vmovapd	14336(%rsp), %ymm1
	vmovapd	14304(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 14232(%rsp)
	vmovsd	14232(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 14296(%rsp)
	vmovsd	%xmm2, 14288(%rsp)
	vmovsd	%xmm2, 14280(%rsp)
	vmovsd	%xmm2, 14272(%rsp)
	vmovsd	14280(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	14272(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	14296(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	14288(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 14256(%rsp)
	vmovapd	%xmm2, 14240(%rsp)
	vmovapd	14240(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 14176(%rsp)
	vmovapd	%ymm1, 14144(%rsp)
	vmovapd	%ymm5, 14112(%rsp)
	vmovapd	14176(%rsp), %ymm0
	vmovapd	14144(%rsp), %ymm1
	vmovapd	14112(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	160(%rsp), %ymm5
	vmovapd	%ymm0, 14080(%rsp)
	vmovapd	%ymm1, 14048(%rsp)
	vmovapd	%ymm5, 14016(%rsp)
	vmovapd	14080(%rsp), %ymm0
	vmovapd	14048(%rsp), %ymm1
	vmovapd	14016(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 160(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 14008(%rsp)
	movq	14008(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 13952(%rsp)
	vmovapd	%ymm1, 13920(%rsp)
	vmovapd	13952(%rsp), %ymm0
	vmovapd	13920(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 13912(%rsp)
	movq	13912(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 13856(%rsp)
	vmovapd	%ymm1, 13824(%rsp)
	vmovapd	13856(%rsp), %ymm0
	vmovapd	13824(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 13752(%rsp)
	vmovsd	13752(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 13816(%rsp)
	vmovsd	%xmm2, 13808(%rsp)
	vmovsd	%xmm2, 13800(%rsp)
	vmovsd	%xmm2, 13792(%rsp)
	vmovsd	13800(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	13792(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	13816(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	13808(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 13776(%rsp)
	vmovapd	%xmm2, 13760(%rsp)
	vmovapd	13760(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 13696(%rsp)
	vmovapd	%ymm1, 13664(%rsp)
	vmovapd	%ymm5, 13632(%rsp)
	vmovapd	13696(%rsp), %ymm0
	vmovapd	13664(%rsp), %ymm1
	vmovapd	13632(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 13600(%rsp)
	vmovapd	%ymm1, 13568(%rsp)
	vmovapd	%ymm5, 13536(%rsp)
	vmovapd	13600(%rsp), %ymm0
	vmovapd	13568(%rsp), %ymm1
	vmovapd	13536(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 13464(%rsp)
	vmovsd	13464(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 13528(%rsp)
	vmovsd	%xmm2, 13520(%rsp)
	vmovsd	%xmm2, 13512(%rsp)
	vmovsd	%xmm2, 13504(%rsp)
	vmovsd	13512(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	13504(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	13528(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	13520(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 13488(%rsp)
	vmovapd	%xmm2, 13472(%rsp)
	vmovapd	13472(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 13408(%rsp)
	vmovapd	%ymm1, 13376(%rsp)
	vmovapd	%ymm5, 13344(%rsp)
	vmovapd	13408(%rsp), %ymm0
	vmovapd	13376(%rsp), %ymm1
	vmovapd	13344(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	160(%rsp), %ymm5
	vmovapd	%ymm0, 13312(%rsp)
	vmovapd	%ymm1, 13280(%rsp)
	vmovapd	%ymm5, 13248(%rsp)
	vmovapd	13312(%rsp), %ymm0
	vmovapd	13280(%rsp), %ymm1
	vmovapd	13248(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 160(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 13240(%rsp)
	movq	13240(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 13184(%rsp)
	vmovapd	%ymm1, 13152(%rsp)
	vmovapd	13184(%rsp), %ymm0
	vmovapd	13152(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 13144(%rsp)
	movq	13144(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 13088(%rsp)
	vmovapd	%ymm1, 13056(%rsp)
	vmovapd	13088(%rsp), %ymm0
	vmovapd	13056(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 12984(%rsp)
	vmovsd	12984(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 13048(%rsp)
	vmovsd	%xmm2, 13040(%rsp)
	vmovsd	%xmm2, 13032(%rsp)
	vmovsd	%xmm2, 13024(%rsp)
	vmovsd	13032(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	13024(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	13048(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	13040(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 13008(%rsp)
	vmovapd	%xmm2, 12992(%rsp)
	vmovapd	12992(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 12928(%rsp)
	vmovapd	%ymm1, 12896(%rsp)
	vmovapd	%ymm5, 12864(%rsp)
	vmovapd	12928(%rsp), %ymm0
	vmovapd	12896(%rsp), %ymm1
	vmovapd	12864(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 12832(%rsp)
	vmovapd	%ymm1, 12800(%rsp)
	vmovapd	%ymm5, 12768(%rsp)
	vmovapd	12832(%rsp), %ymm0
	vmovapd	12800(%rsp), %ymm1
	vmovapd	12768(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 12696(%rsp)
	vmovsd	12696(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 12760(%rsp)
	vmovsd	%xmm2, 12752(%rsp)
	vmovsd	%xmm2, 12744(%rsp)
	vmovsd	%xmm2, 12736(%rsp)
	vmovsd	12744(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	12736(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	12760(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	12752(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 12720(%rsp)
	vmovapd	%xmm2, 12704(%rsp)
	vmovapd	12704(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 12640(%rsp)
	vmovapd	%ymm1, 12608(%rsp)
	vmovapd	%ymm5, 12576(%rsp)
	vmovapd	12640(%rsp), %ymm0
	vmovapd	12608(%rsp), %ymm1
	vmovapd	12576(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	160(%rsp), %ymm5
	vmovapd	%ymm0, 12544(%rsp)
	vmovapd	%ymm1, 12512(%rsp)
	vmovapd	%ymm5, 12480(%rsp)
	vmovapd	12544(%rsp), %ymm0
	vmovapd	12512(%rsp), %ymm1
	vmovapd	12480(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 160(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 12472(%rsp)
	movq	12472(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 12416(%rsp)
	vmovapd	%ymm1, 12384(%rsp)
	vmovapd	12416(%rsp), %ymm0
	vmovapd	12384(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 12376(%rsp)
	movq	12376(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 12320(%rsp)
	vmovapd	%ymm1, 12288(%rsp)
	vmovapd	12320(%rsp), %ymm0
	vmovapd	12288(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 12216(%rsp)
	vmovsd	12216(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 12280(%rsp)
	vmovsd	%xmm2, 12272(%rsp)
	vmovsd	%xmm2, 12264(%rsp)
	vmovsd	%xmm2, 12256(%rsp)
	vmovsd	12264(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	12256(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	12280(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	12272(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 12240(%rsp)
	vmovapd	%xmm2, 12224(%rsp)
	vmovapd	12224(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 12160(%rsp)
	vmovapd	%ymm1, 12128(%rsp)
	vmovapd	%ymm5, 12096(%rsp)
	vmovapd	12160(%rsp), %ymm0
	vmovapd	12128(%rsp), %ymm1
	vmovapd	12096(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 12064(%rsp)
	vmovapd	%ymm1, 12032(%rsp)
	vmovapd	%ymm5, 12000(%rsp)
	vmovapd	12064(%rsp), %ymm0
	vmovapd	12032(%rsp), %ymm1
	vmovapd	12000(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 11928(%rsp)
	vmovsd	11928(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 11992(%rsp)
	vmovsd	%xmm2, 11984(%rsp)
	vmovsd	%xmm2, 11976(%rsp)
	vmovsd	%xmm2, 11968(%rsp)
	vmovsd	11992(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	11984(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	11976(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	11968(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 11936(%rsp)
	vmovapd	11936(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 11872(%rsp)
	vmovapd	%ymm1, 11840(%rsp)
	vmovapd	%ymm5, 11808(%rsp)
	vmovapd	11872(%rsp), %ymm0
	vmovapd	11840(%rsp), %ymm1
	vmovapd	11808(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	160(%rsp), %ymm5
	vmovapd	%ymm0, 11776(%rsp)
	vmovapd	%ymm1, 11744(%rsp)
	vmovapd	%ymm5, 11712(%rsp)
	vmovapd	11776(%rsp), %ymm0
	vmovapd	11744(%rsp), %ymm1
	vmovapd	11712(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 160(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_49
LBB26_51:                               ##   in Loop: Header=BB26_47 Depth=2
	jmp	LBB26_52
LBB26_52:                               ##   Parent Loop BB26_45 Depth=1
                                        ##     Parent Loop BB26_47 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_54
## %bb.53:                              ##   in Loop: Header=BB26_52 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 11704(%rsp)
	movq	11704(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 11648(%rsp)
	vmovapd	%ymm1, 11616(%rsp)
	vmovapd	11648(%rsp), %ymm0
	vmovapd	11616(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 11608(%rsp)
	movq	11608(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 11552(%rsp)
	vmovapd	%ymm1, 11520(%rsp)
	vmovapd	11552(%rsp), %ymm0
	vmovapd	11520(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 11448(%rsp)
	vmovsd	11448(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 11512(%rsp)
	vmovsd	%xmm2, 11504(%rsp)
	vmovsd	%xmm2, 11496(%rsp)
	vmovsd	%xmm2, 11488(%rsp)
	vmovsd	11496(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	11488(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	11512(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	11504(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 11472(%rsp)
	vmovapd	%xmm2, 11456(%rsp)
	vmovapd	11456(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 11392(%rsp)
	vmovapd	%ymm1, 11360(%rsp)
	vmovapd	%ymm5, 11328(%rsp)
	vmovapd	11392(%rsp), %ymm0
	vmovapd	11360(%rsp), %ymm1
	vmovapd	11328(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 11296(%rsp)
	vmovapd	%ymm1, 11264(%rsp)
	vmovapd	%ymm5, 11232(%rsp)
	vmovapd	11296(%rsp), %ymm0
	vmovapd	11264(%rsp), %ymm1
	vmovapd	11232(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 11160(%rsp)
	vmovsd	11160(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 11224(%rsp)
	vmovsd	%xmm2, 11216(%rsp)
	vmovsd	%xmm2, 11208(%rsp)
	vmovsd	%xmm2, 11200(%rsp)
	vmovsd	11224(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	11216(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	11208(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	11200(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 11168(%rsp)
	vmovapd	11168(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 11104(%rsp)
	vmovapd	%ymm1, 11072(%rsp)
	vmovapd	%ymm5, 11040(%rsp)
	vmovapd	11104(%rsp), %ymm0
	vmovapd	11072(%rsp), %ymm1
	vmovapd	11040(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	160(%rsp), %ymm5
	vmovapd	%ymm0, 11008(%rsp)
	vmovapd	%ymm1, 10976(%rsp)
	vmovapd	%ymm5, 10944(%rsp)
	vmovapd	11008(%rsp), %ymm0
	vmovapd	10976(%rsp), %ymm1
	vmovapd	10944(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 160(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_52
LBB26_54:                               ##   in Loop: Header=BB26_47 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	320(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 10936(%rsp)
	movq	10936(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 10880(%rsp)
	vmovapd	%ymm1, 10848(%rsp)
	vmovapd	10880(%rsp), %ymm0
	vaddpd	10848(%rsp), %ymm0, %ymm0
	movq	%rax, 10840(%rsp)
	vmovapd	%ymm0, 10784(%rsp)
	vmovapd	10784(%rsp), %ymm0
	movq	10840(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	192(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 10776(%rsp)
	movq	10776(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 10720(%rsp)
	vmovapd	%ymm1, 10688(%rsp)
	vmovapd	10720(%rsp), %ymm0
	vaddpd	10688(%rsp), %ymm0, %ymm0
	movq	%rax, 10680(%rsp)
	vmovapd	%ymm0, 10624(%rsp)
	vmovapd	10624(%rsp), %ymm0
	movq	10680(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	288(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 10616(%rsp)
	movq	10616(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 10560(%rsp)
	vmovapd	%ymm1, 10528(%rsp)
	vmovapd	10560(%rsp), %ymm0
	vaddpd	10528(%rsp), %ymm0, %ymm0
	movq	%rax, 10520(%rsp)
	vmovapd	%ymm0, 10464(%rsp)
	vmovapd	10464(%rsp), %ymm0
	movq	10520(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	160(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 10456(%rsp)
	movq	10456(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 10400(%rsp)
	vmovapd	%ymm1, 10368(%rsp)
	vmovapd	10400(%rsp), %ymm0
	vaddpd	10368(%rsp), %ymm0, %ymm0
	movq	%rax, 10360(%rsp)
	vmovapd	%ymm0, 10304(%rsp)
	vmovapd	10304(%rsp), %ymm0
	movq	10360(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.55:                              ##   in Loop: Header=BB26_47 Depth=2
	movl	972(%rsp), %eax
	addl	$8, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_47
LBB26_56:                               ##   in Loop: Header=BB26_45 Depth=1
	jmp	LBB26_57
LBB26_57:                               ##   Parent Loop BB26_45 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_59 Depth 3
                                        ##       Child Loop BB26_62 Depth 3
	movl	972(%rsp), %eax
	cmpl	932(%rsp), %eax
	jge	LBB26_66
## %bb.58:                              ##   in Loop: Header=BB26_57 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovapd	%ymm0, 10272(%rsp)
	vmovapd	10272(%rsp), %ymm1
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	%ymm0, 10240(%rsp)
	vmovapd	10240(%rsp), %ymm0
	vmovapd	%ymm0, 288(%rsp)
	movl	$0, 964(%rsp)
LBB26_59:                               ##   Parent Loop BB26_45 Depth=1
                                        ##     Parent Loop BB26_57 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_61
## %bb.60:                              ##   in Loop: Header=BB26_59 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 10232(%rsp)
	movq	10232(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 10176(%rsp)
	vmovapd	%ymm1, 10144(%rsp)
	vmovapd	10176(%rsp), %ymm0
	vmovapd	10144(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 10072(%rsp)
	vmovsd	10072(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 10136(%rsp)
	vmovsd	%xmm2, 10128(%rsp)
	vmovsd	%xmm2, 10120(%rsp)
	vmovsd	%xmm2, 10112(%rsp)
	vmovsd	10120(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	10112(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	10136(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	10128(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 10096(%rsp)
	vmovapd	%xmm2, 10080(%rsp)
	vmovapd	10080(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 9976(%rsp)
	vmovsd	9976(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 10064(%rsp)
	vmovsd	%xmm2, 10056(%rsp)
	vmovsd	%xmm2, 10048(%rsp)
	vmovsd	%xmm2, 10040(%rsp)
	vmovsd	10048(%rsp), %xmm2              ## xmm2 = mem[0],zero
	vmovsd	10040(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	10064(%rsp), %xmm3              ## xmm3 = mem[0],zero
	vmovsd	10056(%rsp), %xmm4              ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 10000(%rsp)
	vmovapd	%xmm2, 9984(%rsp)
	vmovapd	9984(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 9920(%rsp)
	vmovapd	%ymm1, 9888(%rsp)
	vmovapd	%ymm5, 9856(%rsp)
	vmovapd	9920(%rsp), %ymm0
	vmovapd	9888(%rsp), %ymm1
	vmovapd	9856(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 9824(%rsp)
	vmovapd	%ymm1, 9792(%rsp)
	vmovapd	%ymm5, 9760(%rsp)
	vmovapd	9824(%rsp), %ymm0
	vmovapd	9792(%rsp), %ymm1
	vmovapd	9760(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 9752(%rsp)
	movq	9752(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 9696(%rsp)
	vmovapd	%ymm1, 9664(%rsp)
	vmovapd	9696(%rsp), %ymm0
	vmovapd	9664(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 9592(%rsp)
	vmovsd	9592(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 9656(%rsp)
	vmovsd	%xmm2, 9648(%rsp)
	vmovsd	%xmm2, 9640(%rsp)
	vmovsd	%xmm2, 9632(%rsp)
	vmovsd	9640(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	9632(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	9656(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	9648(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 9616(%rsp)
	vmovapd	%xmm2, 9600(%rsp)
	vmovapd	9600(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 9496(%rsp)
	vmovsd	9496(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 9584(%rsp)
	vmovsd	%xmm2, 9576(%rsp)
	vmovsd	%xmm2, 9568(%rsp)
	vmovsd	%xmm2, 9560(%rsp)
	vmovsd	9568(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	9560(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	9584(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	9576(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 9520(%rsp)
	vmovapd	%xmm2, 9504(%rsp)
	vmovapd	9504(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 9440(%rsp)
	vmovapd	%ymm1, 9408(%rsp)
	vmovapd	%ymm5, 9376(%rsp)
	vmovapd	9440(%rsp), %ymm0
	vmovapd	9408(%rsp), %ymm1
	vmovapd	9376(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 9344(%rsp)
	vmovapd	%ymm1, 9312(%rsp)
	vmovapd	%ymm5, 9280(%rsp)
	vmovapd	9344(%rsp), %ymm0
	vmovapd	9312(%rsp), %ymm1
	vmovapd	9280(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 9272(%rsp)
	movq	9272(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 9216(%rsp)
	vmovapd	%ymm1, 9184(%rsp)
	vmovapd	9216(%rsp), %ymm0
	vmovapd	9184(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 9112(%rsp)
	vmovsd	9112(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 9176(%rsp)
	vmovsd	%xmm2, 9168(%rsp)
	vmovsd	%xmm2, 9160(%rsp)
	vmovsd	%xmm2, 9152(%rsp)
	vmovsd	9160(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	9152(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	9176(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	9168(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 9136(%rsp)
	vmovapd	%xmm2, 9120(%rsp)
	vmovapd	9120(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 9016(%rsp)
	vmovsd	9016(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 9104(%rsp)
	vmovsd	%xmm2, 9096(%rsp)
	vmovsd	%xmm2, 9088(%rsp)
	vmovsd	%xmm2, 9080(%rsp)
	vmovsd	9088(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	9080(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	9104(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	9096(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 9040(%rsp)
	vmovapd	%xmm2, 9024(%rsp)
	vmovapd	9024(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 8960(%rsp)
	vmovapd	%ymm1, 8928(%rsp)
	vmovapd	%ymm5, 8896(%rsp)
	vmovapd	8960(%rsp), %ymm0
	vmovapd	8928(%rsp), %ymm1
	vmovapd	8896(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 8864(%rsp)
	vmovapd	%ymm1, 8832(%rsp)
	vmovapd	%ymm5, 8800(%rsp)
	vmovapd	8864(%rsp), %ymm0
	vmovapd	8832(%rsp), %ymm1
	vmovapd	8800(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 8792(%rsp)
	movq	8792(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 8736(%rsp)
	vmovapd	%ymm1, 8704(%rsp)
	vmovapd	8736(%rsp), %ymm0
	vmovapd	8704(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 8632(%rsp)
	vmovsd	8632(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 8696(%rsp)
	vmovsd	%xmm2, 8688(%rsp)
	vmovsd	%xmm2, 8680(%rsp)
	vmovsd	%xmm2, 8672(%rsp)
	vmovsd	8680(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	8672(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	8696(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	8688(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 8656(%rsp)
	vmovapd	%xmm2, 8640(%rsp)
	vmovapd	8640(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 8536(%rsp)
	vmovsd	8536(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 8624(%rsp)
	vmovsd	%xmm2, 8616(%rsp)
	vmovsd	%xmm2, 8608(%rsp)
	vmovsd	%xmm2, 8600(%rsp)
	vmovsd	8624(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	8616(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	8608(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	8600(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 8544(%rsp)
	vmovapd	8544(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 8480(%rsp)
	vmovapd	%ymm1, 8448(%rsp)
	vmovapd	%ymm5, 8416(%rsp)
	vmovapd	8480(%rsp), %ymm0
	vmovapd	8448(%rsp), %ymm1
	vmovapd	8416(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 8384(%rsp)
	vmovapd	%ymm1, 8352(%rsp)
	vmovapd	%ymm5, 8320(%rsp)
	vmovapd	8384(%rsp), %ymm0
	vmovapd	8352(%rsp), %ymm1
	vmovapd	8320(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_59
LBB26_61:                               ##   in Loop: Header=BB26_57 Depth=2
	movl	916(%rsp), %eax
	movl	%eax, 964(%rsp)
LBB26_62:                               ##   Parent Loop BB26_45 Depth=1
                                        ##     Parent Loop BB26_57 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_64
## %bb.63:                              ##   in Loop: Header=BB26_62 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 8312(%rsp)
	movq	8312(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 8256(%rsp)
	vmovapd	%ymm1, 8224(%rsp)
	vmovapd	8256(%rsp), %ymm0
	vmovapd	8224(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 8152(%rsp)
	vmovsd	8152(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 8216(%rsp)
	vmovsd	%xmm2, 8208(%rsp)
	vmovsd	%xmm2, 8200(%rsp)
	vmovsd	%xmm2, 8192(%rsp)
	vmovsd	8200(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	8192(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	8216(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	8208(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 8176(%rsp)
	vmovapd	%xmm2, 8160(%rsp)
	vmovapd	8160(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm2                  ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 8056(%rsp)
	vmovsd	8056(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 8144(%rsp)
	vmovsd	%xmm2, 8136(%rsp)
	vmovsd	%xmm2, 8128(%rsp)
	vmovsd	%xmm2, 8120(%rsp)
	vmovsd	8144(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	8136(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	8128(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	8120(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 8064(%rsp)
	vmovapd	8064(%rsp), %ymm0
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 8000(%rsp)
	vmovapd	%ymm1, 7968(%rsp)
	vmovapd	%ymm5, 7936(%rsp)
	vmovapd	8000(%rsp), %ymm0
	vmovapd	7968(%rsp), %ymm1
	vmovapd	7936(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	352(%rsp), %ymm1
	vmovapd	288(%rsp), %ymm5
	vmovapd	%ymm0, 7904(%rsp)
	vmovapd	%ymm1, 7872(%rsp)
	vmovapd	%ymm5, 7840(%rsp)
	vmovapd	7904(%rsp), %ymm0
	vmovapd	7872(%rsp), %ymm1
	vmovapd	7840(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 288(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_62
LBB26_64:                               ##   in Loop: Header=BB26_57 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	320(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 7832(%rsp)
	movq	7832(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 7776(%rsp)
	vmovapd	%ymm1, 7744(%rsp)
	vmovapd	7776(%rsp), %ymm0
	vaddpd	7744(%rsp), %ymm0, %ymm0
	movq	%rax, 7736(%rsp)
	vmovapd	%ymm0, 7680(%rsp)
	vmovapd	7680(%rsp), %ymm0
	movq	7736(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	288(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 7672(%rsp)
	movq	7672(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 7616(%rsp)
	vmovapd	%ymm1, 7584(%rsp)
	vmovapd	7616(%rsp), %ymm0
	vaddpd	7584(%rsp), %ymm0, %ymm0
	movq	%rax, 7576(%rsp)
	vmovapd	%ymm0, 7520(%rsp)
	vmovapd	7520(%rsp), %ymm0
	movq	7576(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.65:                              ##   in Loop: Header=BB26_57 Depth=2
	movl	972(%rsp), %eax
	addl	$4, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_57
LBB26_66:                               ##   in Loop: Header=BB26_45 Depth=1
	jmp	LBB26_67
LBB26_67:                               ##   Parent Loop BB26_45 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_69 Depth 3
                                        ##       Child Loop BB26_72 Depth 3
	movl	972(%rsp), %eax
	cmpl	928(%rsp), %eax
	jge	LBB26_76
## %bb.68:                              ##   in Loop: Header=BB26_67 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovapd	%xmm0, 7504(%rsp)
	vmovapd	7504(%rsp), %xmm1
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	%xmm0, 7488(%rsp)
	vmovapd	7488(%rsp), %xmm0
	vmovapd	%xmm0, 720(%rsp)
	movl	$0, 964(%rsp)
LBB26_69:                               ##   Parent Loop BB26_45 Depth=1
                                        ##     Parent Loop BB26_67 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_71
## %bb.70:                              ##   in Loop: Header=BB26_69 Depth=3
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 7480(%rsp)
	movq	7480(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 7456(%rsp)
	vmovapd	%xmm1, 7440(%rsp)
	vmovapd	7456(%rsp), %xmm0
	vmovapd	7440(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 7432(%rsp)
	vmovddup	7432(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 7408(%rsp)
	vmovapd	7408(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 7400(%rsp)
	vmovddup	7400(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 7376(%rsp)
	vmovapd	7376(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 7360(%rsp)
	vmovapd	%xmm1, 7344(%rsp)
	vmovapd	%xmm2, 7328(%rsp)
	vmovapd	7360(%rsp), %xmm0
	vmovapd	7344(%rsp), %xmm1
	vmovapd	7328(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	720(%rsp), %xmm2
	vmovapd	%xmm0, 7312(%rsp)
	vmovapd	%xmm1, 7296(%rsp)
	vmovapd	%xmm2, 7280(%rsp)
	vmovapd	7312(%rsp), %xmm0
	vmovapd	7296(%rsp), %xmm1
	vmovapd	7280(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 720(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 7272(%rsp)
	movq	7272(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 7248(%rsp)
	vmovapd	%xmm1, 7232(%rsp)
	vmovapd	7248(%rsp), %xmm0
	vmovapd	7232(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 7224(%rsp)
	vmovddup	7224(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 7200(%rsp)
	vmovapd	7200(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 7192(%rsp)
	vmovddup	7192(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 7168(%rsp)
	vmovapd	7168(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 7152(%rsp)
	vmovapd	%xmm1, 7136(%rsp)
	vmovapd	%xmm2, 7120(%rsp)
	vmovapd	7152(%rsp), %xmm0
	vmovapd	7136(%rsp), %xmm1
	vmovapd	7120(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	720(%rsp), %xmm2
	vmovapd	%xmm0, 7104(%rsp)
	vmovapd	%xmm1, 7088(%rsp)
	vmovapd	%xmm2, 7072(%rsp)
	vmovapd	7104(%rsp), %xmm0
	vmovapd	7088(%rsp), %xmm1
	vmovapd	7072(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 720(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 7064(%rsp)
	movq	7064(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 7040(%rsp)
	vmovapd	%xmm1, 7024(%rsp)
	vmovapd	7040(%rsp), %xmm0
	vmovapd	7024(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 7016(%rsp)
	vmovddup	7016(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 6992(%rsp)
	vmovapd	6992(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 6984(%rsp)
	vmovddup	6984(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 6960(%rsp)
	vmovapd	6960(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 6944(%rsp)
	vmovapd	%xmm1, 6928(%rsp)
	vmovapd	%xmm2, 6912(%rsp)
	vmovapd	6944(%rsp), %xmm0
	vmovapd	6928(%rsp), %xmm1
	vmovapd	6912(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	720(%rsp), %xmm2
	vmovapd	%xmm0, 6896(%rsp)
	vmovapd	%xmm1, 6880(%rsp)
	vmovapd	%xmm2, 6864(%rsp)
	vmovapd	6896(%rsp), %xmm0
	vmovapd	6880(%rsp), %xmm1
	vmovapd	6864(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 720(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 6856(%rsp)
	movq	6856(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 6832(%rsp)
	vmovapd	%xmm1, 6816(%rsp)
	vmovapd	6832(%rsp), %xmm0
	vmovapd	6816(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 6808(%rsp)
	vmovddup	6808(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 6784(%rsp)
	vmovapd	6784(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 6776(%rsp)
	vmovddup	6776(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 6752(%rsp)
	vmovapd	6752(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 6736(%rsp)
	vmovapd	%xmm1, 6720(%rsp)
	vmovapd	%xmm2, 6704(%rsp)
	vmovapd	6736(%rsp), %xmm0
	vmovapd	6720(%rsp), %xmm1
	vmovapd	6704(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	720(%rsp), %xmm2
	vmovapd	%xmm0, 6688(%rsp)
	vmovapd	%xmm1, 6672(%rsp)
	vmovapd	%xmm2, 6656(%rsp)
	vmovapd	6688(%rsp), %xmm0
	vmovapd	6672(%rsp), %xmm1
	vmovapd	6656(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 720(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_69
LBB26_71:                               ##   in Loop: Header=BB26_67 Depth=2
	movl	916(%rsp), %eax
	movl	%eax, 964(%rsp)
LBB26_72:                               ##   Parent Loop BB26_45 Depth=1
                                        ##     Parent Loop BB26_67 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_74
## %bb.73:                              ##   in Loop: Header=BB26_72 Depth=3
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 6648(%rsp)
	movq	6648(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 6624(%rsp)
	vmovapd	%xmm1, 6608(%rsp)
	vmovapd	6624(%rsp), %xmm0
	vmovapd	6608(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 6600(%rsp)
	vmovddup	6600(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 6576(%rsp)
	vmovapd	6576(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 6568(%rsp)
	vmovddup	6568(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 6544(%rsp)
	vmovapd	6544(%rsp), %xmm0
	vmovapd	%xmm0, 784(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 6528(%rsp)
	vmovapd	%xmm1, 6512(%rsp)
	vmovapd	%xmm2, 6496(%rsp)
	vmovapd	6528(%rsp), %xmm0
	vmovapd	6512(%rsp), %xmm1
	vmovapd	6496(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	784(%rsp), %xmm1
	vmovapd	720(%rsp), %xmm2
	vmovapd	%xmm0, 6480(%rsp)
	vmovapd	%xmm1, 6464(%rsp)
	vmovapd	%xmm2, 6448(%rsp)
	vmovapd	6480(%rsp), %xmm0
	vmovapd	6464(%rsp), %xmm1
	vmovapd	6448(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 720(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_72
LBB26_74:                               ##   in Loop: Header=BB26_67 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	736(%rsp), %xmm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 6440(%rsp)
	movq	6440(%rsp), %rsi
	vmovupd	(%rsi), %xmm1
	vmovapd	%xmm0, 6416(%rsp)
	vmovapd	%xmm1, 6400(%rsp)
	vmovapd	6416(%rsp), %xmm0
	vaddpd	6400(%rsp), %xmm0, %xmm0
	movq	%rax, 6392(%rsp)
	vmovapd	%xmm0, 6368(%rsp)
	vmovapd	6368(%rsp), %xmm0
	movq	6392(%rsp), %rax
	vmovupd	%xmm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	720(%rsp), %xmm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 6360(%rsp)
	movq	6360(%rsp), %rsi
	vmovupd	(%rsi), %xmm1
	vmovapd	%xmm0, 6336(%rsp)
	vmovapd	%xmm1, 6320(%rsp)
	vmovapd	6336(%rsp), %xmm0
	vaddpd	6320(%rsp), %xmm0, %xmm0
	movq	%rax, 6312(%rsp)
	vmovapd	%xmm0, 6288(%rsp)
	vmovapd	6288(%rsp), %xmm0
	movq	6312(%rsp), %rax
	vmovupd	%xmm0, (%rax)
## %bb.75:                              ##   in Loop: Header=BB26_67 Depth=2
	movl	972(%rsp), %eax
	addl	$2, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_67
LBB26_76:                               ##   in Loop: Header=BB26_45 Depth=1
	jmp	LBB26_77
LBB26_77:                               ##   Parent Loop BB26_45 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_79 Depth 3
                                        ##       Child Loop BB26_82 Depth 3
	movl	972(%rsp), %eax
	cmpl	1012(%rsp), %eax
	jge	LBB26_86
## %bb.78:                              ##   in Loop: Header=BB26_77 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	imull	1004(%rsp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	imull	1004(%rsp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	vmovsd	%xmm0, 48(%rsp)
	movl	$0, 964(%rsp)
LBB26_79:                               ##   Parent Loop BB26_45 Depth=1
                                        ##     Parent Loop BB26_77 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_81
## %bb.80:                              ##   in Loop: Header=BB26_79 Depth=3
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	40(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	40(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	40(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	40(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_79
LBB26_81:                               ##   in Loop: Header=BB26_77 Depth=2
	movl	916(%rsp), %eax
	movl	%eax, 964(%rsp)
LBB26_82:                               ##   Parent Loop BB26_45 Depth=1
                                        ##     Parent Loop BB26_77 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_84
## %bb.83:                              ##   in Loop: Header=BB26_82 Depth=3
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	movq	944(%rsp), %rax
	vmovsd	8(%rax), %xmm0                  ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 72(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	72(%rsp), %xmm0, %xmm0
	vmovsd	40(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_82
LBB26_84:                               ##   in Loop: Header=BB26_77 Depth=2
	vmovsd	48(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vaddsd	(%rax,%rsi,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	40(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vaddsd	(%rax,%rsi,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.85:                              ##   in Loop: Header=BB26_77 Depth=2
	movl	972(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_77
LBB26_86:                               ##   in Loop: Header=BB26_45 Depth=1
	jmp	LBB26_87
LBB26_87:                               ##   in Loop: Header=BB26_45 Depth=1
	movl	968(%rsp), %eax
	addl	$2, %eax
	movl	%eax, 968(%rsp)
	jmp	LBB26_45
LBB26_88:
	jmp	LBB26_89
LBB26_89:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB26_91 Depth 2
                                        ##       Child Loop BB26_93 Depth 3
                                        ##       Child Loop BB26_96 Depth 3
                                        ##     Child Loop BB26_101 Depth 2
                                        ##       Child Loop BB26_103 Depth 3
                                        ##       Child Loop BB26_106 Depth 3
                                        ##     Child Loop BB26_111 Depth 2
                                        ##       Child Loop BB26_113 Depth 3
                                        ##       Child Loop BB26_116 Depth 3
                                        ##     Child Loop BB26_121 Depth 2
                                        ##       Child Loop BB26_123 Depth 3
                                        ##       Child Loop BB26_126 Depth 3
	movl	968(%rsp), %eax
	cmpl	1008(%rsp), %eax
	jge	LBB26_132
## %bb.90:                              ##   in Loop: Header=BB26_89 Depth=1
	movl	$0, 972(%rsp)
LBB26_91:                               ##   Parent Loop BB26_89 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_93 Depth 3
                                        ##       Child Loop BB26_96 Depth 3
	movl	972(%rsp), %eax
	cmpl	936(%rsp), %eax
	jge	LBB26_100
## %bb.92:                              ##   in Loop: Header=BB26_91 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovapd	%ymm0, 6240(%rsp)
	vmovapd	6240(%rsp), %ymm1
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	%ymm0, 6208(%rsp)
	vmovapd	6208(%rsp), %ymm0
	vmovapd	%ymm0, 192(%rsp)
	movl	$0, 964(%rsp)
LBB26_93:                               ##   Parent Loop BB26_89 Depth=1
                                        ##     Parent Loop BB26_91 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_95
## %bb.94:                              ##   in Loop: Header=BB26_93 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 6200(%rsp)
	movq	6200(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 6144(%rsp)
	vmovapd	%ymm1, 6112(%rsp)
	vmovapd	6144(%rsp), %ymm0
	vmovapd	6112(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 6104(%rsp)
	movq	6104(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 6048(%rsp)
	vmovapd	%ymm1, 6016(%rsp)
	vmovapd	6048(%rsp), %ymm0
	vmovapd	6016(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 5944(%rsp)
	vmovsd	5944(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 6008(%rsp)
	vmovsd	%xmm2, 6000(%rsp)
	vmovsd	%xmm2, 5992(%rsp)
	vmovsd	%xmm2, 5984(%rsp)
	vmovsd	5992(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	5984(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	6008(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	6000(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 5968(%rsp)
	vmovapd	%xmm2, 5952(%rsp)
	vmovapd	5952(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 5888(%rsp)
	vmovapd	%ymm1, 5856(%rsp)
	vmovapd	%ymm5, 5824(%rsp)
	vmovapd	5888(%rsp), %ymm0
	vmovapd	5856(%rsp), %ymm1
	vmovapd	5824(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 5792(%rsp)
	vmovapd	%ymm1, 5760(%rsp)
	vmovapd	%ymm5, 5728(%rsp)
	vmovapd	5792(%rsp), %ymm0
	vmovapd	5760(%rsp), %ymm1
	vmovapd	5728(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 5720(%rsp)
	movq	5720(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 5664(%rsp)
	vmovapd	%ymm1, 5632(%rsp)
	vmovapd	5664(%rsp), %ymm0
	vmovapd	5632(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 5624(%rsp)
	movq	5624(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 5568(%rsp)
	vmovapd	%ymm1, 5536(%rsp)
	vmovapd	5568(%rsp), %ymm0
	vmovapd	5536(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 5464(%rsp)
	vmovsd	5464(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 5528(%rsp)
	vmovsd	%xmm2, 5520(%rsp)
	vmovsd	%xmm2, 5512(%rsp)
	vmovsd	%xmm2, 5504(%rsp)
	vmovsd	5512(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	5504(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	5528(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	5520(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 5488(%rsp)
	vmovapd	%xmm2, 5472(%rsp)
	vmovapd	5472(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 5408(%rsp)
	vmovapd	%ymm1, 5376(%rsp)
	vmovapd	%ymm5, 5344(%rsp)
	vmovapd	5408(%rsp), %ymm0
	vmovapd	5376(%rsp), %ymm1
	vmovapd	5344(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 5312(%rsp)
	vmovapd	%ymm1, 5280(%rsp)
	vmovapd	%ymm5, 5248(%rsp)
	vmovapd	5312(%rsp), %ymm0
	vmovapd	5280(%rsp), %ymm1
	vmovapd	5248(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 5240(%rsp)
	movq	5240(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 5184(%rsp)
	vmovapd	%ymm1, 5152(%rsp)
	vmovapd	5184(%rsp), %ymm0
	vmovapd	5152(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 5144(%rsp)
	movq	5144(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 5088(%rsp)
	vmovapd	%ymm1, 5056(%rsp)
	vmovapd	5088(%rsp), %ymm0
	vmovapd	5056(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 4984(%rsp)
	vmovsd	4984(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 5048(%rsp)
	vmovsd	%xmm2, 5040(%rsp)
	vmovsd	%xmm2, 5032(%rsp)
	vmovsd	%xmm2, 5024(%rsp)
	vmovsd	5032(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	5024(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	5048(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	5040(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 5008(%rsp)
	vmovapd	%xmm2, 4992(%rsp)
	vmovapd	4992(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 4928(%rsp)
	vmovapd	%ymm1, 4896(%rsp)
	vmovapd	%ymm5, 4864(%rsp)
	vmovapd	4928(%rsp), %ymm0
	vmovapd	4896(%rsp), %ymm1
	vmovapd	4864(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 4832(%rsp)
	vmovapd	%ymm1, 4800(%rsp)
	vmovapd	%ymm5, 4768(%rsp)
	vmovapd	4832(%rsp), %ymm0
	vmovapd	4800(%rsp), %ymm1
	vmovapd	4768(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 4760(%rsp)
	movq	4760(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 4704(%rsp)
	vmovapd	%ymm1, 4672(%rsp)
	vmovapd	4704(%rsp), %ymm0
	vmovapd	4672(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 4664(%rsp)
	movq	4664(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 4608(%rsp)
	vmovapd	%ymm1, 4576(%rsp)
	vmovapd	4608(%rsp), %ymm0
	vmovapd	4576(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 4504(%rsp)
	vmovsd	4504(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 4568(%rsp)
	vmovsd	%xmm2, 4560(%rsp)
	vmovsd	%xmm2, 4552(%rsp)
	vmovsd	%xmm2, 4544(%rsp)
	vmovsd	4568(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	4560(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	4552(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	4544(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 4512(%rsp)
	vmovapd	4512(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 4448(%rsp)
	vmovapd	%ymm1, 4416(%rsp)
	vmovapd	%ymm5, 4384(%rsp)
	vmovapd	4448(%rsp), %ymm0
	vmovapd	4416(%rsp), %ymm1
	vmovapd	4384(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 4352(%rsp)
	vmovapd	%ymm1, 4320(%rsp)
	vmovapd	%ymm5, 4288(%rsp)
	vmovapd	4352(%rsp), %ymm0
	vmovapd	4320(%rsp), %ymm1
	vmovapd	4288(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_93
LBB26_95:                               ##   in Loop: Header=BB26_91 Depth=2
	movl	916(%rsp), %eax
	movl	%eax, 964(%rsp)
LBB26_96:                               ##   Parent Loop BB26_89 Depth=1
                                        ##     Parent Loop BB26_91 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_98
## %bb.97:                              ##   in Loop: Header=BB26_96 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 4280(%rsp)
	movq	4280(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 4224(%rsp)
	vmovapd	%ymm1, 4192(%rsp)
	vmovapd	4224(%rsp), %ymm0
	vmovapd	4192(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 4184(%rsp)
	movq	4184(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 4128(%rsp)
	vmovapd	%ymm1, 4096(%rsp)
	vmovapd	4128(%rsp), %ymm0
	vmovapd	4096(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 544(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 4024(%rsp)
	vmovsd	4024(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 4088(%rsp)
	vmovsd	%xmm2, 4080(%rsp)
	vmovsd	%xmm2, 4072(%rsp)
	vmovsd	%xmm2, 4064(%rsp)
	vmovsd	4088(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	4080(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	4072(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	4064(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 4032(%rsp)
	vmovapd	4032(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 3968(%rsp)
	vmovapd	%ymm1, 3936(%rsp)
	vmovapd	%ymm5, 3904(%rsp)
	vmovapd	3968(%rsp), %ymm0
	vmovapd	3936(%rsp), %ymm1
	vmovapd	3904(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	vmovapd	544(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	192(%rsp), %ymm5
	vmovapd	%ymm0, 3872(%rsp)
	vmovapd	%ymm1, 3840(%rsp)
	vmovapd	%ymm5, 3808(%rsp)
	vmovapd	3872(%rsp), %ymm0
	vmovapd	3840(%rsp), %ymm1
	vmovapd	3808(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 192(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$64, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_96
LBB26_98:                               ##   in Loop: Header=BB26_91 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	320(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 3800(%rsp)
	movq	3800(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 3744(%rsp)
	vmovapd	%ymm1, 3712(%rsp)
	vmovapd	3744(%rsp), %ymm0
	vaddpd	3712(%rsp), %ymm0, %ymm0
	movq	%rax, 3704(%rsp)
	vmovapd	%ymm0, 3648(%rsp)
	vmovapd	3648(%rsp), %ymm0
	movq	3704(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	192(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 3640(%rsp)
	movq	3640(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 3584(%rsp)
	vmovapd	%ymm1, 3552(%rsp)
	vmovapd	3584(%rsp), %ymm0
	vaddpd	3552(%rsp), %ymm0, %ymm0
	movq	%rax, 3544(%rsp)
	vmovapd	%ymm0, 3488(%rsp)
	vmovapd	3488(%rsp), %ymm0
	movq	3544(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.99:                              ##   in Loop: Header=BB26_91 Depth=2
	movl	972(%rsp), %eax
	addl	$8, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_91
LBB26_100:                              ##   in Loop: Header=BB26_89 Depth=1
	jmp	LBB26_101
LBB26_101:                              ##   Parent Loop BB26_89 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_103 Depth 3
                                        ##       Child Loop BB26_106 Depth 3
	movl	972(%rsp), %eax
	cmpl	932(%rsp), %eax
	jge	LBB26_110
## %bb.102:                             ##   in Loop: Header=BB26_101 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovapd	%ymm0, 3456(%rsp)
	vmovapd	3456(%rsp), %ymm0
	vmovapd	%ymm0, 320(%rsp)
	movl	$0, 964(%rsp)
LBB26_103:                              ##   Parent Loop BB26_89 Depth=1
                                        ##     Parent Loop BB26_101 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_105
## %bb.104:                             ##   in Loop: Header=BB26_103 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 3448(%rsp)
	movq	3448(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 3392(%rsp)
	vmovapd	%ymm1, 3360(%rsp)
	vmovapd	3392(%rsp), %ymm0
	vmovapd	3360(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 3288(%rsp)
	vmovsd	3288(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 3352(%rsp)
	vmovsd	%xmm2, 3344(%rsp)
	vmovsd	%xmm2, 3336(%rsp)
	vmovsd	%xmm2, 3328(%rsp)
	vmovsd	3336(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	3328(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	3352(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	3344(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 3312(%rsp)
	vmovapd	%xmm2, 3296(%rsp)
	vmovapd	3296(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 3232(%rsp)
	vmovapd	%ymm1, 3200(%rsp)
	vmovapd	%ymm5, 3168(%rsp)
	vmovapd	3232(%rsp), %ymm0
	vmovapd	3200(%rsp), %ymm1
	vmovapd	3168(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 3160(%rsp)
	movq	3160(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 3104(%rsp)
	vmovapd	%ymm1, 3072(%rsp)
	vmovapd	3104(%rsp), %ymm0
	vmovapd	3072(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 3000(%rsp)
	vmovsd	3000(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 3064(%rsp)
	vmovsd	%xmm2, 3056(%rsp)
	vmovsd	%xmm2, 3048(%rsp)
	vmovsd	%xmm2, 3040(%rsp)
	vmovsd	3048(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	3040(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	3064(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	3056(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 3024(%rsp)
	vmovapd	%xmm2, 3008(%rsp)
	vmovapd	3008(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 2944(%rsp)
	vmovapd	%ymm1, 2912(%rsp)
	vmovapd	%ymm5, 2880(%rsp)
	vmovapd	2944(%rsp), %ymm0
	vmovapd	2912(%rsp), %ymm1
	vmovapd	2880(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 2872(%rsp)
	movq	2872(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 2816(%rsp)
	vmovapd	%ymm1, 2784(%rsp)
	vmovapd	2816(%rsp), %ymm0
	vmovapd	2784(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 2712(%rsp)
	vmovsd	2712(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 2776(%rsp)
	vmovsd	%xmm2, 2768(%rsp)
	vmovsd	%xmm2, 2760(%rsp)
	vmovsd	%xmm2, 2752(%rsp)
	vmovsd	2760(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	2752(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	2776(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	2768(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
	vmovapd	%xmm3, 2736(%rsp)
	vmovapd	%xmm2, 2720(%rsp)
	vmovapd	2720(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 2656(%rsp)
	vmovapd	%ymm1, 2624(%rsp)
	vmovapd	%ymm5, 2592(%rsp)
	vmovapd	2656(%rsp), %ymm0
	vmovapd	2624(%rsp), %ymm1
	vmovapd	2592(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 2584(%rsp)
	movq	2584(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 2528(%rsp)
	vmovapd	%ymm1, 2496(%rsp)
	vmovapd	2528(%rsp), %ymm0
	vmovapd	2496(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 2424(%rsp)
	vmovsd	2424(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 2488(%rsp)
	vmovsd	%xmm2, 2480(%rsp)
	vmovsd	%xmm2, 2472(%rsp)
	vmovsd	%xmm2, 2464(%rsp)
	vmovsd	2488(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	2480(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	2472(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	2464(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 2432(%rsp)
	vmovapd	2432(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 2368(%rsp)
	vmovapd	%ymm1, 2336(%rsp)
	vmovapd	%ymm5, 2304(%rsp)
	vmovapd	2368(%rsp), %ymm0
	vmovapd	2336(%rsp), %ymm1
	vmovapd	2304(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_103
LBB26_105:                              ##   in Loop: Header=BB26_101 Depth=2
	movl	916(%rsp), %eax
	movl	%eax, 964(%rsp)
LBB26_106:                              ##   Parent Loop BB26_89 Depth=1
                                        ##     Parent Loop BB26_101 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_108
## %bb.107:                             ##   in Loop: Header=BB26_106 Depth=3
	vmovapd	864(%rsp), %ymm0
	movq	952(%rsp), %rax
	movq	%rax, 2296(%rsp)
	movq	2296(%rsp), %rax
	vmovupd	(%rax), %ymm1
	vmovapd	%ymm0, 2240(%rsp)
	vmovapd	%ymm1, 2208(%rsp)
	vmovapd	2240(%rsp), %ymm0
	vmovapd	2208(%rsp), %ymm1
	vmulpd	%ymm1, %ymm0, %ymm0
	vmovapd	%ymm0, 576(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm2                   ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 2136(%rsp)
	vmovsd	2136(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	%xmm2, 2200(%rsp)
	vmovsd	%xmm2, 2192(%rsp)
	vmovsd	%xmm2, 2184(%rsp)
	vmovsd	%xmm2, 2176(%rsp)
	vmovsd	2200(%rsp), %xmm2               ## xmm2 = mem[0],zero
	vmovsd	2192(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vunpcklpd	%xmm2, %xmm3, %xmm2     ## xmm2 = xmm3[0],xmm2[0]
	vmovsd	2184(%rsp), %xmm3               ## xmm3 = mem[0],zero
	vmovsd	2176(%rsp), %xmm4               ## xmm4 = mem[0],zero
	vunpcklpd	%xmm3, %xmm4, %xmm3     ## xmm3 = xmm4[0],xmm3[0]
                                        ## implicit-def: $ymm0
	vmovaps	%xmm3, %xmm0
	vinsertf128	$1, %xmm2, %ymm0, %ymm0
	vmovapd	%ymm0, 2144(%rsp)
	vmovapd	2144(%rsp), %ymm0
	vmovapd	%ymm0, 384(%rsp)
	vmovapd	576(%rsp), %ymm0
	vmovapd	384(%rsp), %ymm1
	vmovapd	320(%rsp), %ymm5
	vmovapd	%ymm0, 2080(%rsp)
	vmovapd	%ymm1, 2048(%rsp)
	vmovapd	%ymm5, 2016(%rsp)
	vmovapd	2080(%rsp), %ymm0
	vmovapd	2048(%rsp), %ymm1
	vmovapd	2016(%rsp), %ymm5
	vfmadd213pd	%ymm5, %ymm0, %ymm1     ## ymm1 = (ymm0 * ymm1) + ymm5
	vmovapd	%ymm1, 320(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$32, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_106
LBB26_108:                              ##   in Loop: Header=BB26_101 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	320(%rsp), %ymm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 2008(%rsp)
	movq	2008(%rsp), %rsi
	vmovupd	(%rsi), %ymm1
	vmovapd	%ymm0, 1952(%rsp)
	vmovapd	%ymm1, 1920(%rsp)
	vmovapd	1952(%rsp), %ymm0
	vaddpd	1920(%rsp), %ymm0, %ymm0
	movq	%rax, 1912(%rsp)
	vmovapd	%ymm0, 1856(%rsp)
	vmovapd	1856(%rsp), %ymm0
	movq	1912(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.109:                             ##   in Loop: Header=BB26_101 Depth=2
	movl	972(%rsp), %eax
	addl	$4, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_101
LBB26_110:                              ##   in Loop: Header=BB26_89 Depth=1
	jmp	LBB26_111
LBB26_111:                              ##   Parent Loop BB26_89 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_113 Depth 3
                                        ##       Child Loop BB26_116 Depth 3
	movl	972(%rsp), %eax
	cmpl	928(%rsp), %eax
	jge	LBB26_120
## %bb.112:                             ##   in Loop: Header=BB26_111 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	movl	1004(%rsp), %edx
	imull	%edx, %ecx
	movslq	%ecx, %rsi
	leaq	(%rax,%rsi,8), %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovapd	%xmm0, 1840(%rsp)
	vmovapd	1840(%rsp), %xmm1
	vmovapd	%xmm1, 736(%rsp)
	vmovapd	%xmm0, 1824(%rsp)
	vmovapd	1824(%rsp), %xmm0
	vmovapd	%xmm0, 720(%rsp)
	movl	$0, 964(%rsp)
LBB26_113:                              ##   Parent Loop BB26_89 Depth=1
                                        ##     Parent Loop BB26_111 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	916(%rsp), %eax
	jge	LBB26_115
## %bb.114:                             ##   in Loop: Header=BB26_113 Depth=3
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 1816(%rsp)
	movq	1816(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 1792(%rsp)
	vmovapd	%xmm1, 1776(%rsp)
	vmovapd	1792(%rsp), %xmm0
	vmovapd	1776(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 1768(%rsp)
	vmovddup	1768(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 1744(%rsp)
	vmovapd	1744(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 1728(%rsp)
	vmovapd	%xmm1, 1712(%rsp)
	vmovapd	%xmm2, 1696(%rsp)
	vmovapd	1728(%rsp), %xmm0
	vmovapd	1712(%rsp), %xmm1
	vmovapd	1696(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 1688(%rsp)
	movq	1688(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 1664(%rsp)
	vmovapd	%xmm1, 1648(%rsp)
	vmovapd	1664(%rsp), %xmm0
	vmovapd	1648(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 1640(%rsp)
	vmovddup	1640(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 1616(%rsp)
	vmovapd	1616(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 1600(%rsp)
	vmovapd	%xmm1, 1584(%rsp)
	vmovapd	%xmm2, 1568(%rsp)
	vmovapd	1600(%rsp), %xmm0
	vmovapd	1584(%rsp), %xmm1
	vmovapd	1568(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 1560(%rsp)
	movq	1560(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 1536(%rsp)
	vmovapd	%xmm1, 1520(%rsp)
	vmovapd	1536(%rsp), %xmm0
	vmovapd	1520(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 1512(%rsp)
	vmovddup	1512(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 1488(%rsp)
	vmovapd	1488(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 1472(%rsp)
	vmovapd	%xmm1, 1456(%rsp)
	vmovapd	%xmm2, 1440(%rsp)
	vmovapd	1472(%rsp), %xmm0
	vmovapd	1456(%rsp), %xmm1
	vmovapd	1440(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	movl	964(%rsp), %ecx
	incl	%ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 1432(%rsp)
	movq	1432(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 1408(%rsp)
	vmovapd	%xmm1, 1392(%rsp)
	vmovapd	1408(%rsp), %xmm0
	vmovapd	1392(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 1384(%rsp)
	vmovddup	1384(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 1360(%rsp)
	vmovapd	1360(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 1344(%rsp)
	vmovapd	%xmm1, 1328(%rsp)
	vmovapd	%xmm2, 1312(%rsp)
	vmovapd	1344(%rsp), %xmm0
	vmovapd	1328(%rsp), %xmm1
	vmovapd	1312(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_113
LBB26_115:                              ##   in Loop: Header=BB26_111 Depth=2
	movl	916(%rsp), %eax
	movl	%eax, 964(%rsp)
LBB26_116:                              ##   Parent Loop BB26_89 Depth=1
                                        ##     Parent Loop BB26_111 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_118
## %bb.117:                             ##   in Loop: Header=BB26_116 Depth=3
	vmovapd	848(%rsp), %xmm0
	movq	952(%rsp), %rax
	movq	%rax, 1304(%rsp)
	movq	1304(%rsp), %rax
	vmovapd	(%rax), %xmm1
	vmovapd	%xmm0, 1280(%rsp)
	vmovapd	%xmm1, 1264(%rsp)
	vmovapd	1280(%rsp), %xmm0
	vmovapd	1264(%rsp), %xmm1
	vmulpd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, 832(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 1256(%rsp)
	vmovddup	1256(%rsp), %xmm0               ## xmm0 = mem[0,0]
	vmovapd	%xmm0, 1232(%rsp)
	vmovapd	1232(%rsp), %xmm0
	vmovapd	%xmm0, 800(%rsp)
	vmovapd	832(%rsp), %xmm0
	vmovapd	800(%rsp), %xmm1
	vmovapd	736(%rsp), %xmm2
	vmovapd	%xmm0, 1216(%rsp)
	vmovapd	%xmm1, 1200(%rsp)
	vmovapd	%xmm2, 1184(%rsp)
	vmovapd	1216(%rsp), %xmm0
	vmovapd	1200(%rsp), %xmm1
	vmovapd	1184(%rsp), %xmm2
	vfmadd213pd	%xmm2, %xmm0, %xmm1     ## xmm1 = (xmm0 * xmm1) + xmm2
	vmovapd	%xmm1, 736(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$16, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_116
LBB26_118:                              ##   in Loop: Header=BB26_111 Depth=2
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	736(%rsp), %xmm0
	movq	24(%rbp), %rsi
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rsi
	movq	%rsi, 1176(%rsp)
	movq	1176(%rsp), %rsi
	vmovupd	(%rsi), %xmm1
	vmovapd	%xmm0, 1152(%rsp)
	vmovapd	%xmm1, 1136(%rsp)
	vmovapd	1152(%rsp), %xmm0
	vaddpd	1136(%rsp), %xmm0, %xmm0
	movq	%rax, 1128(%rsp)
	vmovapd	%xmm0, 1104(%rsp)
	vmovapd	1104(%rsp), %xmm0
	movq	1128(%rsp), %rax
	vmovupd	%xmm0, (%rax)
## %bb.119:                             ##   in Loop: Header=BB26_111 Depth=2
	movl	972(%rsp), %eax
	addl	$2, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_111
LBB26_120:                              ##   in Loop: Header=BB26_89 Depth=1
	jmp	LBB26_121
LBB26_121:                              ##   Parent Loop BB26_89 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB26_123 Depth 3
                                        ##       Child Loop BB26_126 Depth 3
	movl	972(%rsp), %eax
	cmpl	1012(%rsp), %eax
	jge	LBB26_130
## %bb.122:                             ##   in Loop: Header=BB26_121 Depth=2
	movq	992(%rsp), %rax
	movl	972(%rsp), %ecx
	imull	1004(%rsp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, 952(%rsp)
	movq	976(%rsp), %rax
	movl	968(%rsp), %ecx
	imull	1004(%rsp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, 944(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	movl	$0, 964(%rsp)
LBB26_123:                              ##   Parent Loop BB26_89 Depth=1
                                        ##     Parent Loop BB26_121 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	xorl	%eax, %eax
                                        ## kill: def $al killed $al killed $eax
	testb	$1, %al
	jne	LBB26_124
	jmp	LBB26_125
LBB26_124:                              ##   in Loop: Header=BB26_123 Depth=3
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_123
LBB26_125:                              ##   in Loop: Header=BB26_121 Depth=2
	jmp	LBB26_126
LBB26_126:                              ##   Parent Loop BB26_89 Depth=1
                                        ##     Parent Loop BB26_121 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	964(%rsp), %eax
	cmpl	1004(%rsp), %eax
	jge	LBB26_128
## %bb.127:                             ##   in Loop: Header=BB26_126 Depth=3
	movq	952(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 88(%rsp)
	movq	944(%rsp), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 80(%rsp)
	vmovsd	88(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	vmulsd	80(%rsp), %xmm0, %xmm0
	vmovsd	48(%rsp), %xmm1                 ## xmm1 = mem[0],zero
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 48(%rsp)
	movl	964(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 964(%rsp)
	movq	952(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 952(%rsp)
	movq	944(%rsp), %rax
	addq	$8, %rax
	movq	%rax, 944(%rsp)
	jmp	LBB26_126
LBB26_128:                              ##   in Loop: Header=BB26_121 Depth=2
	vmovsd	48(%rsp), %xmm0                 ## xmm0 = mem[0],zero
	movq	24(%rbp), %rax
	movl	32(%rbp), %ecx
	movl	968(%rsp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	movl	972(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vaddsd	(%rax,%rsi,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.129:                             ##   in Loop: Header=BB26_121 Depth=2
	movl	972(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 972(%rsp)
	jmp	LBB26_121
LBB26_130:                              ##   in Loop: Header=BB26_89 Depth=1
	jmp	LBB26_131
LBB26_131:                              ##   in Loop: Header=BB26_89 Depth=1
	movl	968(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 968(%rsp)
	jmp	LBB26_89
LBB26_132:
	movq	%rbp, %rsp
	popq	%rbp
	vzeroupper
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function dgetf2_5
LCPI27_0:
	.quad	0x3bc79ca10c924223              ## double 9.9999999999999995E-21
LCPI27_2:
	.quad	0x3ff0000000000000              ## double 1
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI27_1:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_dgetf2_5
	.p2align	4, 0x90
_dgetf2_5:                              ## @dgetf2_5
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$304, %rsp                      ## imm = 0x130
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movq	%r8, -40(%rbp)
	cmpl	$0, -8(%rbp)
	je	LBB27_2
## %bb.1:
	cmpl	$0, -12(%rbp)
	jne	LBB27_3
LBB27_2:
	movl	$0, -4(%rbp)
	jmp	LBB27_40
LBB27_3:
	movl	$0, -44(%rbp)
LBB27_4:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB27_13 Depth 2
                                        ##     Child Loop BB27_17 Depth 2
                                        ##     Child Loop BB27_21 Depth 2
                                        ##     Child Loop BB27_29 Depth 2
                                        ##       Child Loop BB27_31 Depth 3
	movl	-44(%rbp), %eax
	movl	-8(%rbp), %ecx
	cmpl	-12(%rbp), %ecx
	movl	%eax, -268(%rbp)                ## 4-byte Spill
	jge	LBB27_6
## %bb.5:                               ##   in Loop: Header=BB27_4 Depth=1
	movl	-8(%rbp), %eax
	movl	%eax, -272(%rbp)                ## 4-byte Spill
	jmp	LBB27_7
LBB27_6:                                ##   in Loop: Header=BB27_4 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -272(%rbp)                ## 4-byte Spill
LBB27_7:                                ##   in Loop: Header=BB27_4 Depth=1
	movl	-272(%rbp), %eax                ## 4-byte Reload
	movl	-268(%rbp), %ecx                ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB27_39
## %bb.8:                               ##   in Loop: Header=BB27_4 Depth=1
	movl	-44(%rbp), %eax
	movl	-8(%rbp), %ecx
	subl	-44(%rbp), %ecx
	movq	-24(%rbp), %rdx
	movl	-28(%rbp), %esi
	imull	-44(%rbp), %esi
	addl	-44(%rbp), %esi
	movslq	%esi, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rdx
	movl	%ecx, %edi
	movq	%rdx, %rsi
	movl	$1, %edx
	movl	%eax, -276(%rbp)                ## 4-byte Spill
	callq	_isamax_2
	vmovsd	LCPI27_0(%rip), %xmm0           ## xmm0 = mem[0],zero
	movl	-276(%rbp), %ecx                ## 4-byte Reload
	addl	%eax, %ecx
	movl	%ecx, -56(%rbp)
	movq	-24(%rbp), %rsi
	movl	-28(%rbp), %eax
	imull	-44(%rbp), %eax
	addl	-56(%rbp), %eax
	movslq	%eax, %r8
	vmovsd	(%rsi,%r8,8), %xmm1             ## xmm1 = mem[0],zero
	vmovsd	%xmm1, -64(%rbp)
	vmovsd	-64(%rbp), %xmm1                ## xmm1 = mem[0],zero
	vxorps	%xmm2, %xmm2, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovdqa	LCPI27_1(%rip), %xmm2           ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	jb	LBB27_10
## %bb.9:
	movq	___stderrp@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	L_.str(%rip), %rsi
	movb	$0, %al
	callq	_fprintf
	movq	___stderrp@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rdi
	movl	-8(%rbp), %edx
	movl	-12(%rbp), %ecx
	leaq	L_.str.4(%rip), %rsi
	movl	%eax, -280(%rbp)                ## 4-byte Spill
	movb	$0, %al
	callq	_fprintf
	movl	$-1, -4(%rbp)
	jmp	LBB27_40
LBB27_10:                               ##   in Loop: Header=BB27_4 Depth=1
	movl	-56(%rbp), %eax
	movq	-40(%rbp), %rcx
	movslq	-44(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movl	-44(%rbp), %eax
	cmpl	-56(%rbp), %eax
	je	LBB27_12
## %bb.11:                              ##   in Loop: Header=BB27_4 Depth=1
	movl	-12(%rbp), %edi
	movq	-24(%rbp), %rax
	imull	$0, -28(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rsi
	imull	$0, -28(%rbp), %ecx
	addl	-56(%rbp), %ecx
	movslq	%ecx, %r8
	shlq	$3, %r8
	addq	%r8, %rsi
	movl	-28(%rbp), %r8d
	movq	%rsi, -288(%rbp)                ## 8-byte Spill
	movq	%rax, %rsi
	movq	-288(%rbp), %rcx                ## 8-byte Reload
	callq	_dswap_2
LBB27_12:                               ##   in Loop: Header=BB27_4 Depth=1
	vmovsd	LCPI27_2(%rip), %xmm0           ## xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vdivsd	(%rax,%rdx,8), %xmm0, %xmm0
	vmovsd	%xmm0, -72(%rbp)
	movl	-44(%rbp), %ecx
	addl	$1, %ecx
	movl	%ecx, -48(%rbp)
LBB27_13:                               ##   Parent Loop BB27_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-48(%rbp), %eax
	movl	-8(%rbp), %ecx
	subl	$8, %ecx
	cmpl	%ecx, %eax
	jg	LBB27_16
## %bb.14:                              ##   in Loop: Header=BB27_13 Depth=2
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -96(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -104(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -112(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -120(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -128(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-80(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-88(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-96(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-104(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-112(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-120(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$5, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-128(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$6, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-136(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$7, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.15:                              ##   in Loop: Header=BB27_13 Depth=2
	movl	-48(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB27_13
LBB27_16:                               ##   in Loop: Header=BB27_4 Depth=1
	jmp	LBB27_17
LBB27_17:                               ##   Parent Loop BB27_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-48(%rbp), %eax
	movl	-8(%rbp), %ecx
	subl	$4, %ecx
	cmpl	%ecx, %eax
	jg	LBB27_20
## %bb.18:                              ##   in Loop: Header=BB27_17 Depth=2
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -96(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -104(%rbp)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-80(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-88(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$1, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-96(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$2, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-104(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	movl	-48(%rbp), %edx
	addl	$3, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.19:                              ##   in Loop: Header=BB27_17 Depth=2
	movl	-48(%rbp), %eax
	addl	$4, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB27_17
LBB27_20:                               ##   in Loop: Header=BB27_4 Depth=1
	jmp	LBB27_21
LBB27_21:                               ##   Parent Loop BB27_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-48(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB27_24
## %bb.22:                              ##   in Loop: Header=BB27_21 Depth=2
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.23:                              ##   in Loop: Header=BB27_21 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB27_21
LBB27_24:                               ##   in Loop: Header=BB27_4 Depth=1
	movl	-44(%rbp), %eax
	movl	-8(%rbp), %ecx
	cmpl	-12(%rbp), %ecx
	movl	%eax, -292(%rbp)                ## 4-byte Spill
	jge	LBB27_26
## %bb.25:                              ##   in Loop: Header=BB27_4 Depth=1
	movl	-8(%rbp), %eax
	movl	%eax, -296(%rbp)                ## 4-byte Spill
	jmp	LBB27_27
LBB27_26:                               ##   in Loop: Header=BB27_4 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -296(%rbp)                ## 4-byte Spill
LBB27_27:                               ##   in Loop: Header=BB27_4 Depth=1
	movl	-296(%rbp), %eax                ## 4-byte Reload
	movl	-292(%rbp), %ecx                ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB27_37
## %bb.28:                              ##   in Loop: Header=BB27_4 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
LBB27_29:                               ##   Parent Loop BB27_4 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB27_31 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB27_36
## %bb.30:                              ##   in Loop: Header=BB27_29 Depth=2
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx     ## imm = 0x8000000000000000
	xorq	%rdx, %rax
	vmovq	%rax, %xmm0
	vmovsd	%xmm0, -72(%rbp)
	movl	-44(%rbp), %ecx
	addl	$1, %ecx
	movl	%ecx, -52(%rbp)
LBB27_31:                               ##   Parent Loop BB27_4 Depth=1
                                        ##     Parent Loop BB27_29 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-52(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB27_34
## %bb.32:                              ##   in Loop: Header=BB27_31 Depth=3
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -208(%rbp)
	vmovsd	-72(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	-208(%rbp), %xmm0, %xmm0
	vaddsd	-144(%rbp), %xmm0, %xmm0
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
	movl	-52(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.33:                              ##   in Loop: Header=BB27_31 Depth=3
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	LBB27_31
LBB27_34:                               ##   in Loop: Header=BB27_29 Depth=2
	jmp	LBB27_35
LBB27_35:                               ##   in Loop: Header=BB27_29 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB27_29
LBB27_36:                               ##   in Loop: Header=BB27_4 Depth=1
	jmp	LBB27_37
LBB27_37:                               ##   in Loop: Header=BB27_4 Depth=1
	jmp	LBB27_38
LBB27_38:                               ##   in Loop: Header=BB27_4 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB27_4
LBB27_39:
	movl	$0, -4(%rbp)
LBB27_40:
	movl	-4(%rbp), %eax
	addq	$304, %rsp                      ## imm = 0x130
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function lu_solve_5
LCPI28_0:
	.quad	0xbff0000000000000              ## double -1
LCPI28_1:
	.quad	0x3ff0000000000000              ## double 1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_lu_solve_5
	.p2align	4, 0x90
_lu_solve_5:                            ## @lu_solve_5
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$160, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movl	%edi, -32(%rbp)
	movq	%rsi, -40(%rbp)
	movq	%rdx, -48(%rbp)
	movq	_scratch_ipiv(%rip), %rax
	movq	%rax, -72(%rbp)
	movl	-32(%rbp), %ecx
	movl	-32(%rbp), %edi
	movl	%ecx, -20(%rbp)
	movl	%edi, -24(%rbp)
	movl	$64, -76(%rbp)
	movl	-32(%rbp), %ecx
	movl	%ecx, -80(%rbp)
	movl	-32(%rbp), %ecx
	movl	%ecx, -84(%rbp)
	movl	-32(%rbp), %ecx
	movl	%ecx, -88(%rbp)
	cmpl	$1, -76(%rbp)
	jle	LBB28_2
## %bb.1:
	movl	-76(%rbp), %eax
	cmpl	-88(%rbp), %eax
	jl	LBB28_5
LBB28_2:
	movl	-80(%rbp), %edi
	movl	-32(%rbp), %esi
	movq	-40(%rbp), %rdx
	movl	-84(%rbp), %ecx
	movq	-72(%rbp), %r8
	callq	_dgetf2_5
	movl	%eax, -52(%rbp)
	cmpl	$0, -52(%rbp)
	je	LBB28_4
## %bb.3:
	movl	-52(%rbp), %eax
	movl	%eax, -28(%rbp)
	jmp	LBB28_32
LBB28_4:
	jmp	LBB28_31
LBB28_5:
	movl	$0, -56(%rbp)
LBB28_6:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB28_13 Depth 2
                                        ##     Child Loop BB28_20 Depth 2
	movl	-56(%rbp), %eax
	cmpl	-88(%rbp), %eax
	jge	LBB28_30
## %bb.7:                               ##   in Loop: Header=BB28_6 Depth=1
	movl	-88(%rbp), %eax
	subl	-56(%rbp), %eax
	cmpl	-76(%rbp), %eax
	jge	LBB28_9
## %bb.8:                               ##   in Loop: Header=BB28_6 Depth=1
	movl	-88(%rbp), %eax
	subl	-56(%rbp), %eax
	movl	%eax, -92(%rbp)                 ## 4-byte Spill
	jmp	LBB28_10
LBB28_9:                                ##   in Loop: Header=BB28_6 Depth=1
	movl	-76(%rbp), %eax
	movl	%eax, -92(%rbp)                 ## 4-byte Spill
LBB28_10:                               ##   in Loop: Header=BB28_6 Depth=1
	movl	-92(%rbp), %eax                 ## 4-byte Reload
	movl	%eax, -60(%rbp)
	movl	-80(%rbp), %eax
	subl	-56(%rbp), %eax
	movl	-60(%rbp), %esi
	movq	-40(%rbp), %rcx
	movl	-84(%rbp), %edx
	imull	-56(%rbp), %edx
	addl	-56(%rbp), %edx
	movslq	%edx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rcx
	movl	-84(%rbp), %edx
	movq	-72(%rbp), %rdi
	movslq	-56(%rbp), %r8
	shlq	$2, %r8
	addq	%r8, %rdi
	movq	%rdi, -104(%rbp)                ## 8-byte Spill
	movl	%eax, %edi
	movl	%edx, -108(%rbp)                ## 4-byte Spill
	movq	%rcx, %rdx
	movl	-108(%rbp), %ecx                ## 4-byte Reload
	movq	-104(%rbp), %r8                 ## 8-byte Reload
	callq	_dgetf2_5
	movl	%eax, -52(%rbp)
	cmpl	$0, -52(%rbp)
	je	LBB28_12
## %bb.11:
	movl	-52(%rbp), %eax
	movl	%eax, -28(%rbp)
	jmp	LBB28_32
LBB28_12:                               ##   in Loop: Header=BB28_6 Depth=1
	movl	-56(%rbp), %eax
	movl	%eax, -64(%rbp)
LBB28_13:                               ##   Parent Loop BB28_6 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-64(%rbp), %eax
	movl	-80(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	-60(%rbp), %edx
	cmpl	%edx, %ecx
	movl	%eax, -112(%rbp)                ## 4-byte Spill
	jge	LBB28_15
## %bb.14:                              ##   in Loop: Header=BB28_13 Depth=2
	movl	-80(%rbp), %eax
	movl	%eax, -116(%rbp)                ## 4-byte Spill
	jmp	LBB28_16
LBB28_15:                               ##   in Loop: Header=BB28_13 Depth=2
	movl	-56(%rbp), %eax
	addl	-60(%rbp), %eax
	movl	%eax, -116(%rbp)                ## 4-byte Spill
LBB28_16:                               ##   in Loop: Header=BB28_13 Depth=2
	movl	-116(%rbp), %eax                ## 4-byte Reload
	subl	$7, %eax
	movl	-112(%rbp), %ecx                ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB28_19
## %bb.17:                              ##   in Loop: Header=BB28_13 Depth=2
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$0, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$1, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$1, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$2, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$2, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$3, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$3, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$4, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$4, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$5, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$5, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$6, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$6, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$7, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$7, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
## %bb.18:                              ##   in Loop: Header=BB28_13 Depth=2
	movl	-64(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -64(%rbp)
	jmp	LBB28_13
LBB28_19:                               ##   in Loop: Header=BB28_6 Depth=1
	jmp	LBB28_20
LBB28_20:                               ##   Parent Loop BB28_6 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-64(%rbp), %eax
	movl	-80(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	-60(%rbp), %edx
	cmpl	%edx, %ecx
	movl	%eax, -120(%rbp)                ## 4-byte Spill
	jge	LBB28_22
## %bb.21:                              ##   in Loop: Header=BB28_20 Depth=2
	movl	-80(%rbp), %eax
	movl	%eax, -124(%rbp)                ## 4-byte Spill
	jmp	LBB28_23
LBB28_22:                               ##   in Loop: Header=BB28_20 Depth=2
	movl	-56(%rbp), %eax
	addl	-60(%rbp), %eax
	movl	%eax, -124(%rbp)                ## 4-byte Spill
LBB28_23:                               ##   in Loop: Header=BB28_20 Depth=2
	movl	-124(%rbp), %eax                ## 4-byte Reload
	movl	-120(%rbp), %ecx                ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB28_26
## %bb.24:                              ##   in Loop: Header=BB28_20 Depth=2
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	movl	(%rax,%rdx,4), %ecx
	addl	-56(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	-64(%rbp), %esi
	addl	$0, %esi
	movslq	%esi, %rdx
	movl	%ecx, (%rax,%rdx,4)
## %bb.25:                              ##   in Loop: Header=BB28_20 Depth=2
	movl	-64(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -64(%rbp)
	jmp	LBB28_20
LBB28_26:                               ##   in Loop: Header=BB28_6 Depth=1
	movl	-56(%rbp), %edi
	movq	-40(%rbp), %rsi
	movl	-84(%rbp), %edx
	movl	-56(%rbp), %ecx
	movl	-56(%rbp), %eax
	addl	-60(%rbp), %eax
	movq	-72(%rbp), %r9
	movl	%eax, %r8d
	movl	$1, (%rsp)
	callq	_dlaswp_5
	movl	-56(%rbp), %eax
	addl	-60(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jge	LBB28_28
## %bb.27:                              ##   in Loop: Header=BB28_6 Depth=1
	movl	-32(%rbp), %eax
	subl	-56(%rbp), %eax
	subl	-60(%rbp), %eax
	movq	-40(%rbp), %rcx
	movl	-84(%rbp), %edx
	movl	-56(%rbp), %esi
	addl	-60(%rbp), %esi
	imull	%esi, %edx
	addl	$0, %edx
	movslq	%edx, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rcx
	movl	-84(%rbp), %edx
	movl	-56(%rbp), %esi
	movl	-56(%rbp), %r8d
	addl	-60(%rbp), %r8d
	movq	-72(%rbp), %r9
	movl	%eax, %edi
	movl	%esi, -128(%rbp)                ## 4-byte Spill
	movq	%rcx, %rsi
	movl	-128(%rbp), %ecx                ## 4-byte Reload
	movl	$1, (%rsp)
	callq	_dlaswp_5
	movl	-60(%rbp), %edi
	movl	-32(%rbp), %eax
	subl	-56(%rbp), %eax
	subl	-60(%rbp), %eax
	movq	-40(%rbp), %rsi
	movl	-84(%rbp), %ecx
	imull	-56(%rbp), %ecx
	addl	-56(%rbp), %ecx
	movslq	%ecx, %r9
	shlq	$3, %r9
	addq	%r9, %rsi
	movl	-84(%rbp), %ecx
	movq	-40(%rbp), %r9
	movl	-84(%rbp), %edx
	movl	-56(%rbp), %r8d
	addl	-60(%rbp), %r8d
	imull	%r8d, %edx
	addl	-56(%rbp), %edx
	movslq	%edx, %r10
	shlq	$3, %r10
	addq	%r10, %r9
	movl	-84(%rbp), %edx
	movq	%rsi, -136(%rbp)                ## 8-byte Spill
	movl	%eax, %esi
	movq	-136(%rbp), %r10                ## 8-byte Reload
	movl	%edx, -140(%rbp)                ## 4-byte Spill
	movq	%r10, %rdx
	movq	%r9, %r8
	movl	-140(%rbp), %r9d                ## 4-byte Reload
	callq	_dtrsm_L_5
	vmovsd	LCPI28_0(%rip), %xmm0           ## xmm0 = mem[0],zero
	vmovsd	LCPI28_1(%rip), %xmm1           ## xmm1 = mem[0],zero
	movl	-80(%rbp), %eax
	subl	-56(%rbp), %eax
	subl	-60(%rbp), %eax
	movl	-32(%rbp), %ecx
	subl	-56(%rbp), %ecx
	subl	-60(%rbp), %ecx
	movl	-60(%rbp), %edx
	movq	-40(%rbp), %r8
	movl	-84(%rbp), %esi
	imull	-56(%rbp), %esi
	movl	-56(%rbp), %edi
	addl	-60(%rbp), %edi
	addl	%edi, %esi
	movslq	%esi, %r10
	shlq	$3, %r10
	addq	%r10, %r8
	movl	-84(%rbp), %esi
	movq	-40(%rbp), %r10
	movl	-84(%rbp), %edi
	movl	-56(%rbp), %r9d
	addl	-60(%rbp), %r9d
	imull	%r9d, %edi
	addl	-56(%rbp), %edi
	movslq	%edi, %r11
	shlq	$3, %r11
	addq	%r11, %r10
	movl	-84(%rbp), %edi
	movq	-40(%rbp), %r11
	movl	-84(%rbp), %r9d
	movl	-56(%rbp), %ebx
	addl	-60(%rbp), %ebx
	imull	%ebx, %r9d
	movl	-56(%rbp), %ebx
	addl	-60(%rbp), %ebx
	addl	%ebx, %r9d
	movslq	%r9d, %r14
	shlq	$3, %r14
	addq	%r14, %r11
	movl	-84(%rbp), %r9d
	movl	%edi, -144(%rbp)                ## 4-byte Spill
	movl	%eax, %edi
	movl	%esi, -148(%rbp)                ## 4-byte Spill
	movl	%ecx, %esi
	movq	%r8, %rcx
	movl	-148(%rbp), %r8d                ## 4-byte Reload
	movl	%r9d, -152(%rbp)                ## 4-byte Spill
	movq	%r10, %r9
	movl	-144(%rbp), %eax                ## 4-byte Reload
	movl	%eax, (%rsp)
	movq	%r11, 8(%rsp)
	movl	-152(%rbp), %eax                ## 4-byte Reload
	movl	%eax, 16(%rsp)
	callq	_dgemm_5
LBB28_28:                               ##   in Loop: Header=BB28_6 Depth=1
	jmp	LBB28_29
LBB28_29:                               ##   in Loop: Header=BB28_6 Depth=1
	movl	-76(%rbp), %eax
	addl	-56(%rbp), %eax
	movl	%eax, -56(%rbp)
	jmp	LBB28_6
LBB28_30:
	jmp	LBB28_31
LBB28_31:
	movl	-32(%rbp), %edi
	movq	-40(%rbp), %rsi
	movq	-72(%rbp), %rdx
	movq	-48(%rbp), %rcx
	callq	_dgetrs_5
	movl	%eax, -52(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -28(%rbp)
LBB28_32:
	movl	-28(%rbp), %eax
	addq	$160, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dlaswp_5
_dlaswp_5:                              ## @dlaswp_5
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$208, %rsp
	movl	16(%rbp), %eax
	xorl	%r10d, %r10d
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movq	%r9, -40(%rbp)
	cmpl	16(%rbp), %r10d
	setl	%r11b
	xorb	$-1, %r11b
	andb	$1, %r11b
	movzbl	%r11b, %ecx
	movslq	%ecx, %rsi
	cmpq	$0, %rsi
	je	LBB29_2
## %bb.1:
	leaq	L___func__.dlaswp_5(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.8(%rip), %rcx
	movl	$2005, %edx                     ## imm = 0x7D5
	callq	___assert_rtn
LBB29_2:
	jmp	LBB29_3
LBB29_3:
	movl	$1, %eax
	cmpl	16(%rbp), %eax
	sete	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB29_5
## %bb.4:
	leaq	L___func__.dlaswp_5(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.11(%rip), %rcx
	movl	$2006, %edx                     ## imm = 0x7D6
	callq	___assert_rtn
LBB29_5:
	jmp	LBB29_6
LBB29_6:
	xorl	%eax, %eax
	movl	-4(%rbp), %ecx
	movl	%eax, -204(%rbp)                ## 4-byte Spill
	movl	%ecx, %eax
	cltd
	movl	$32, %ecx
	idivl	%ecx
	shll	$5, %eax
	movl	%eax, -44(%rbp)
	movl	-204(%rbp), %eax                ## 4-byte Reload
	cmpl	-44(%rbp), %eax
	jge	LBB29_22
## %bb.7:
	movl	$0, -52(%rbp)
LBB29_8:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB29_10 Depth 2
                                        ##       Child Loop BB29_13 Depth 3
	movl	-52(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	LBB29_21
## %bb.9:                               ##   in Loop: Header=BB29_8 Depth=1
	movl	-24(%rbp), %eax
	movl	%eax, -48(%rbp)
LBB29_10:                               ##   Parent Loop BB29_8 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB29_13 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	LBB29_19
## %bb.11:                              ##   in Loop: Header=BB29_10 Depth=2
	movq	-40(%rbp), %rax
	movslq	-48(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movl	%edx, -60(%rbp)
	movl	-60(%rbp), %edx
	cmpl	-48(%rbp), %edx
	je	LBB29_17
## %bb.12:                              ##   in Loop: Header=BB29_10 Depth=2
	movl	-52(%rbp), %eax
	movl	%eax, -56(%rbp)
LBB29_13:                               ##   Parent Loop BB29_8 Depth=1
                                        ##     Parent Loop BB29_10 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-56(%rbp), %eax
	movl	-52(%rbp), %ecx
	addl	$32, %ecx
	subl	$7, %ecx
	cmpl	%ecx, %eax
	jge	LBB29_16
## %bb.14:                              ##   in Loop: Header=BB29_13 Depth=3
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -96(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -104(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -112(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -120(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -128(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	vmovsd	-144(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-152(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-160(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-168(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-176(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-184(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-192(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-200(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-80(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-88(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-96(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-104(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-112(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-120(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-128(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-136(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.15:                              ##   in Loop: Header=BB29_13 Depth=3
	movl	-56(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB29_13
LBB29_16:                               ##   in Loop: Header=BB29_10 Depth=2
	jmp	LBB29_17
LBB29_17:                               ##   in Loop: Header=BB29_10 Depth=2
	jmp	LBB29_18
LBB29_18:                               ##   in Loop: Header=BB29_10 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB29_10
LBB29_19:                               ##   in Loop: Header=BB29_8 Depth=1
	jmp	LBB29_20
LBB29_20:                               ##   in Loop: Header=BB29_8 Depth=1
	movl	-52(%rbp), %eax
	addl	$32, %eax
	movl	%eax, -52(%rbp)
	jmp	LBB29_8
LBB29_21:
	jmp	LBB29_22
LBB29_22:
	movl	-44(%rbp), %eax
	cmpl	-4(%rbp), %eax
	je	LBB29_38
## %bb.23:
	movl	-24(%rbp), %eax
	movl	%eax, -48(%rbp)
LBB29_24:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB29_27 Depth 2
                                        ##     Child Loop BB29_31 Depth 2
	movl	-48(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	LBB29_37
## %bb.25:                              ##   in Loop: Header=BB29_24 Depth=1
	movq	-40(%rbp), %rax
	movslq	-48(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movl	%edx, -60(%rbp)
	movl	-48(%rbp), %edx
	cmpl	-60(%rbp), %edx
	je	LBB29_35
## %bb.26:                              ##   in Loop: Header=BB29_24 Depth=1
	movl	-44(%rbp), %eax
	movl	%eax, -56(%rbp)
LBB29_27:                               ##   Parent Loop BB29_24 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-56(%rbp), %eax
	movl	-4(%rbp), %ecx
	subl	$7, %ecx
	cmpl	%ecx, %eax
	jge	LBB29_30
## %bb.28:                              ##   in Loop: Header=BB29_27 Depth=2
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -96(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -104(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -112(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -120(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -128(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	vmovsd	-144(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-152(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-160(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-168(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-176(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-184(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-192(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-200(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-80(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-88(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-96(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-104(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-112(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-120(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-128(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-136(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.29:                              ##   in Loop: Header=BB29_27 Depth=2
	movl	-56(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB29_27
LBB29_30:                               ##   in Loop: Header=BB29_24 Depth=1
	jmp	LBB29_31
LBB29_31:                               ##   Parent Loop BB29_24 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-56(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB29_34
## %bb.32:                              ##   in Loop: Header=BB29_31 Depth=2
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	vmovsd	-80(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-144(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.33:                              ##   in Loop: Header=BB29_31 Depth=2
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB29_31
LBB29_34:                               ##   in Loop: Header=BB29_24 Depth=1
	jmp	LBB29_35
LBB29_35:                               ##   in Loop: Header=BB29_24 Depth=1
	jmp	LBB29_36
LBB29_36:                               ##   in Loop: Header=BB29_24 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB29_24
LBB29_37:
	jmp	LBB29_38
LBB29_38:
	addq	$208, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dtrsm_L_5
_dtrsm_L_5:                             ## @dtrsm_L_5
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movq	%rdx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movl	$0, -44(%rbp)
LBB30_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB30_3 Depth 2
                                        ##       Child Loop BB30_5 Depth 3
	movl	-44(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB30_12
## %bb.2:                               ##   in Loop: Header=BB30_1 Depth=1
	movl	$0, -48(%rbp)
LBB30_3:                                ##   Parent Loop BB30_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB30_5 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB30_10
## %bb.4:                               ##   in Loop: Header=BB30_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
LBB30_5:                                ##   Parent Loop BB30_1 Depth=1
                                        ##     Parent Loop BB30_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-40(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB30_8
## %bb.6:                               ##   in Loop: Header=BB30_5 Depth=3
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.7:                               ##   in Loop: Header=BB30_5 Depth=3
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	LBB30_5
LBB30_8:                                ##   in Loop: Header=BB30_3 Depth=2
	jmp	LBB30_9
LBB30_9:                                ##   in Loop: Header=BB30_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB30_3
LBB30_10:                               ##   in Loop: Header=BB30_1 Depth=1
	jmp	LBB30_11
LBB30_11:                               ##   in Loop: Header=BB30_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB30_1
LBB30_12:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dgetrs_5
_dgetrs_5:                              ## @dgetrs_5
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	xorl	%eax, %eax
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	-32(%rbp), %rsi
	movl	-4(%rbp), %r8d
	movq	-24(%rbp), %r9
	movl	$1, %edi
	movl	%edi, -36(%rbp)                 ## 4-byte Spill
	movl	-36(%rbp), %edx                 ## 4-byte Reload
	movl	%eax, %ecx
	movl	$1, (%rsp)
	callq	_dlaswp_5
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %ecx
	movq	-32(%rbp), %r8
	movl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %r9d
	callq	_dtrsm_L_5
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %ecx
	movq	-32(%rbp), %r8
	movl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %r9d
	callq	_dtrsm_U_5
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function dgetf2_6
LCPI32_0:
	.quad	0x3bc79ca10c924223              ## double 9.9999999999999995E-21
LCPI32_2:
	.quad	0x3ff0000000000000              ## double 1
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI32_1:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_dgetf2_6
	.p2align	4, 0x90
_dgetf2_6:                              ## @dgetf2_6
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	andq	$-32, %rsp
	subq	$896, %rsp                      ## imm = 0x380
	movl	%edi, 336(%rsp)
	movl	%esi, 332(%rsp)
	movq	%rdx, 320(%rsp)
	movl	%ecx, 316(%rsp)
	movq	%r8, 304(%rsp)
	cmpl	$0, 336(%rsp)
	je	LBB32_2
## %bb.1:
	cmpl	$0, 332(%rsp)
	jne	LBB32_3
LBB32_2:
	movl	$0, 340(%rsp)
	jmp	LBB32_40
LBB32_3:
	movl	$0, 300(%rsp)
LBB32_4:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB32_13 Depth 2
                                        ##     Child Loop BB32_17 Depth 2
                                        ##     Child Loop BB32_21 Depth 2
                                        ##     Child Loop BB32_29 Depth 2
                                        ##       Child Loop BB32_31 Depth 3
	movl	300(%rsp), %eax
	movl	336(%rsp), %ecx
	cmpl	332(%rsp), %ecx
	movl	%eax, 28(%rsp)                  ## 4-byte Spill
	jge	LBB32_6
## %bb.5:                               ##   in Loop: Header=BB32_4 Depth=1
	movl	336(%rsp), %eax
	movl	%eax, 24(%rsp)                  ## 4-byte Spill
	jmp	LBB32_7
LBB32_6:                                ##   in Loop: Header=BB32_4 Depth=1
	movl	332(%rsp), %eax
	movl	%eax, 24(%rsp)                  ## 4-byte Spill
LBB32_7:                                ##   in Loop: Header=BB32_4 Depth=1
	movl	24(%rsp), %eax                  ## 4-byte Reload
	movl	28(%rsp), %ecx                  ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB32_39
## %bb.8:                               ##   in Loop: Header=BB32_4 Depth=1
	movl	300(%rsp), %eax
	movl	336(%rsp), %ecx
	subl	300(%rsp), %ecx
	movq	320(%rsp), %rdx
	movl	316(%rsp), %esi
	imull	300(%rsp), %esi
	addl	300(%rsp), %esi
	movslq	%esi, %rdi
	shlq	$3, %rdi
	addq	%rdi, %rdx
	movl	%ecx, %edi
	movq	%rdx, %rsi
	movl	$1, %edx
	movl	%eax, 20(%rsp)                  ## 4-byte Spill
	vzeroupper
	callq	_isamax_2
	vmovsd	LCPI32_0(%rip), %xmm0           ## xmm0 = mem[0],zero
	movl	20(%rsp), %ecx                  ## 4-byte Reload
	addl	%eax, %ecx
	movl	%ecx, 288(%rsp)
	movq	320(%rsp), %rsi
	movl	316(%rsp), %eax
	imull	300(%rsp), %eax
	addl	288(%rsp), %eax
	movslq	%eax, %r8
	vmovsd	(%rsi,%r8,8), %xmm1             ## xmm1 = mem[0],zero
	vmovsd	%xmm1, 280(%rsp)
	vmovsd	280(%rsp), %xmm1                ## xmm1 = mem[0],zero
	vxorps	%xmm2, %xmm2, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovdqa	LCPI32_1(%rip), %xmm2           ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	jb	LBB32_10
## %bb.9:
	movq	___stderrp@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	L_.str(%rip), %rsi
	movb	$0, %al
	callq	_fprintf
	movq	___stderrp@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rdi
	movl	336(%rsp), %edx
	movl	332(%rsp), %ecx
	leaq	L_.str.4(%rip), %rsi
	movl	%eax, 16(%rsp)                  ## 4-byte Spill
	movb	$0, %al
	callq	_fprintf
	movl	$-1, 340(%rsp)
	jmp	LBB32_40
LBB32_10:                               ##   in Loop: Header=BB32_4 Depth=1
	movl	288(%rsp), %eax
	movq	304(%rsp), %rcx
	movslq	300(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movl	300(%rsp), %eax
	cmpl	288(%rsp), %eax
	je	LBB32_12
## %bb.11:                              ##   in Loop: Header=BB32_4 Depth=1
	movl	332(%rsp), %edi
	movq	320(%rsp), %rax
	imull	$0, 316(%rsp), %ecx
	addl	300(%rsp), %ecx
	movslq	%ecx, %rdx
	shlq	$3, %rdx
	addq	%rdx, %rax
	movl	316(%rsp), %edx
	movq	320(%rsp), %rsi
	imull	$0, 316(%rsp), %ecx
	addl	288(%rsp), %ecx
	movslq	%ecx, %r8
	shlq	$3, %r8
	addq	%r8, %rsi
	movl	316(%rsp), %r8d
	movq	%rsi, 8(%rsp)                   ## 8-byte Spill
	movq	%rax, %rsi
	movq	8(%rsp), %rcx                   ## 8-byte Reload
	callq	_dswap_6
LBB32_12:                               ##   in Loop: Header=BB32_4 Depth=1
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	movl	300(%rsp), %edx
	imull	%edx, %ecx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	LCPI32_2(%rip), %xmm1           ## xmm1 = mem[0],zero
	vdivsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 272(%rsp)
	vmovsd	272(%rsp), %xmm0                ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 344(%rsp)
	vmovsd	344(%rsp), %xmm0                ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 408(%rsp)
	vmovsd	%xmm0, 400(%rsp)
	vmovsd	%xmm0, 392(%rsp)
	vmovsd	%xmm0, 384(%rsp)
	vmovsd	408(%rsp), %xmm0                ## xmm0 = mem[0],zero
	vmovsd	400(%rsp), %xmm1                ## xmm1 = mem[0],zero
	vunpcklpd	%xmm0, %xmm1, %xmm0     ## xmm0 = xmm1[0],xmm0[0]
	vmovsd	392(%rsp), %xmm1                ## xmm1 = mem[0],zero
	vmovsd	384(%rsp), %xmm2                ## xmm2 = mem[0],zero
	vunpcklpd	%xmm1, %xmm2, %xmm1     ## xmm1 = xmm2[0],xmm1[0]
                                        ## implicit-def: $ymm3
	vmovaps	%xmm1, %xmm3
	vinsertf128	$1, %xmm0, %ymm3, %ymm3
	vmovapd	%ymm3, 352(%rsp)
	vmovapd	352(%rsp), %ymm3
	vmovapd	%ymm3, 96(%rsp)
	movl	300(%rsp), %ecx
	addl	$1, %ecx
	movl	%ecx, 296(%rsp)
LBB32_13:                               ##   Parent Loop BB32_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	296(%rsp), %eax
	movl	336(%rsp), %ecx
	subl	$8, %ecx
	cmpl	%ecx, %eax
	jg	LBB32_16
## %bb.14:                              ##   in Loop: Header=BB32_13 Depth=2
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	imull	300(%rsp), %ecx
	movl	296(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	movq	%rax, 872(%rsp)
	movq	872(%rsp), %rax
	vmovupd	(%rax), %ymm0
	vmovapd	%ymm0, 64(%rsp)
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	imull	300(%rsp), %ecx
	movl	296(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	96(%rsp), %ymm0
	vmovapd	64(%rsp), %ymm1
	vmovapd	%ymm0, 832(%rsp)
	vmovapd	%ymm1, 800(%rsp)
	vmovapd	832(%rsp), %ymm0
	vmulpd	800(%rsp), %ymm0, %ymm0
	movq	%rax, 792(%rsp)
	vmovapd	%ymm0, 736(%rsp)
	vmovapd	736(%rsp), %ymm0
	movq	792(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	imull	300(%rsp), %ecx
	movl	296(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	movq	%rax, 728(%rsp)
	movq	728(%rsp), %rax
	vmovupd	(%rax), %ymm0
	vmovapd	%ymm0, 64(%rsp)
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	imull	300(%rsp), %ecx
	movl	296(%rsp), %edx
	addl	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	96(%rsp), %ymm0
	vmovapd	64(%rsp), %ymm1
	vmovapd	%ymm0, 672(%rsp)
	vmovapd	%ymm1, 640(%rsp)
	vmovapd	672(%rsp), %ymm0
	vmulpd	640(%rsp), %ymm0, %ymm0
	movq	%rax, 632(%rsp)
	vmovapd	%ymm0, 576(%rsp)
	vmovapd	576(%rsp), %ymm0
	movq	632(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.15:                              ##   in Loop: Header=BB32_13 Depth=2
	movl	296(%rsp), %eax
	addl	$8, %eax
	movl	%eax, 296(%rsp)
	jmp	LBB32_13
LBB32_16:                               ##   in Loop: Header=BB32_4 Depth=1
	jmp	LBB32_17
LBB32_17:                               ##   Parent Loop BB32_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	296(%rsp), %eax
	movl	336(%rsp), %ecx
	subl	$4, %ecx
	cmpl	%ecx, %eax
	jg	LBB32_20
## %bb.18:                              ##   in Loop: Header=BB32_17 Depth=2
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	imull	300(%rsp), %ecx
	movl	296(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	movq	%rax, 568(%rsp)
	movq	568(%rsp), %rax
	vmovupd	(%rax), %ymm0
	vmovapd	%ymm0, 64(%rsp)
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	imull	300(%rsp), %ecx
	movl	296(%rsp), %edx
	addl	$0, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rsi
	shlq	$3, %rsi
	addq	%rsi, %rax
	vmovapd	96(%rsp), %ymm0
	vmovapd	64(%rsp), %ymm1
	vmovapd	%ymm0, 512(%rsp)
	vmovapd	%ymm1, 480(%rsp)
	vmovapd	512(%rsp), %ymm0
	vmulpd	480(%rsp), %ymm0, %ymm0
	movq	%rax, 472(%rsp)
	vmovapd	%ymm0, 416(%rsp)
	vmovapd	416(%rsp), %ymm0
	movq	472(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.19:                              ##   in Loop: Header=BB32_17 Depth=2
	movl	296(%rsp), %eax
	addl	$4, %eax
	movl	%eax, 296(%rsp)
	jmp	LBB32_17
LBB32_20:                               ##   in Loop: Header=BB32_4 Depth=1
	jmp	LBB32_21
LBB32_21:                               ##   Parent Loop BB32_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	296(%rsp), %eax
	cmpl	336(%rsp), %eax
	jge	LBB32_24
## %bb.22:                              ##   in Loop: Header=BB32_21 Depth=2
	vmovsd	272(%rsp), %xmm0                ## xmm0 = mem[0],zero
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	imull	300(%rsp), %ecx
	addl	296(%rsp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	imull	300(%rsp), %ecx
	addl	296(%rsp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.23:                              ##   in Loop: Header=BB32_21 Depth=2
	movl	296(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 296(%rsp)
	jmp	LBB32_21
LBB32_24:                               ##   in Loop: Header=BB32_4 Depth=1
	movl	300(%rsp), %eax
	movl	336(%rsp), %ecx
	cmpl	332(%rsp), %ecx
	movl	%eax, 4(%rsp)                   ## 4-byte Spill
	jge	LBB32_26
## %bb.25:                              ##   in Loop: Header=BB32_4 Depth=1
	movl	336(%rsp), %eax
	movl	%eax, (%rsp)                    ## 4-byte Spill
	jmp	LBB32_27
LBB32_26:                               ##   in Loop: Header=BB32_4 Depth=1
	movl	332(%rsp), %eax
	movl	%eax, (%rsp)                    ## 4-byte Spill
LBB32_27:                               ##   in Loop: Header=BB32_4 Depth=1
	movl	(%rsp), %eax                    ## 4-byte Reload
	movl	4(%rsp), %ecx                   ## 4-byte Reload
	cmpl	%eax, %ecx
	jge	LBB32_37
## %bb.28:                              ##   in Loop: Header=BB32_4 Depth=1
	movl	300(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 292(%rsp)
LBB32_29:                               ##   Parent Loop BB32_4 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB32_31 Depth 3
	movl	292(%rsp), %eax
	cmpl	332(%rsp), %eax
	jge	LBB32_36
## %bb.30:                              ##   in Loop: Header=BB32_29 Depth=2
	movl	300(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 296(%rsp)
LBB32_31:                               ##   Parent Loop BB32_4 Depth=1
                                        ##     Parent Loop BB32_29 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	296(%rsp), %eax
	cmpl	336(%rsp), %eax
	jge	LBB32_34
## %bb.32:                              ##   in Loop: Header=BB32_31 Depth=3
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	imull	300(%rsp), %ecx
	addl	296(%rsp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx     ## imm = 0x8000000000000000
	xorq	%rdx, %rax
	vmovq	%rax, %xmm0
	vmovsd	%xmm0, 272(%rsp)
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	movl	292(%rsp), %esi
	addl	$0, %esi
	imull	%esi, %ecx
	addl	296(%rsp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 264(%rsp)
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	movl	292(%rsp), %esi
	addl	$0, %esi
	imull	%esi, %ecx
	addl	300(%rsp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 200(%rsp)
	vmovsd	272(%rsp), %xmm0                ## xmm0 = mem[0],zero
	vmulsd	200(%rsp), %xmm0, %xmm0
	vaddsd	264(%rsp), %xmm0, %xmm0
	movq	320(%rsp), %rax
	movl	316(%rsp), %ecx
	movl	292(%rsp), %esi
	addl	$0, %esi
	imull	%esi, %ecx
	addl	296(%rsp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.33:                              ##   in Loop: Header=BB32_31 Depth=3
	movl	296(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 296(%rsp)
	jmp	LBB32_31
LBB32_34:                               ##   in Loop: Header=BB32_29 Depth=2
	jmp	LBB32_35
LBB32_35:                               ##   in Loop: Header=BB32_29 Depth=2
	movl	292(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 292(%rsp)
	jmp	LBB32_29
LBB32_36:                               ##   in Loop: Header=BB32_4 Depth=1
	jmp	LBB32_37
LBB32_37:                               ##   in Loop: Header=BB32_4 Depth=1
	jmp	LBB32_38
LBB32_38:                               ##   in Loop: Header=BB32_4 Depth=1
	movl	300(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 300(%rsp)
	jmp	LBB32_4
LBB32_39:
	movl	$0, 340(%rsp)
LBB32_40:
	movl	340(%rsp), %eax
	movq	%rbp, %rsp
	popq	%rbp
	vzeroupper
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dswap_6
_dswap_6:                               ## @dswap_6
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	andq	$-32, %rsp
	subq	$480, %rsp                      ## imm = 0x1E0
	xorl	%eax, %eax
	movl	%edi, 212(%rsp)
	movq	%rsi, 200(%rsp)
	movl	%edx, 196(%rsp)
	movq	%rcx, 184(%rsp)
	movl	%r8d, 180(%rsp)
	cmpl	212(%rsp), %eax
	setl	%r9b
	xorb	$-1, %r9b
	andb	$1, %r9b
	movzbl	%r9b, %eax
	movslq	%eax, %rcx
	cmpq	$0, %rcx
	je	LBB33_2
## %bb.1:
	leaq	L___func__.dswap_6(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.7(%rip), %rcx
	movl	$3187, %edx                     ## imm = 0xC73
	callq	___assert_rtn
LBB33_2:
	jmp	LBB33_3
LBB33_3:
	xorl	%eax, %eax
	cmpl	196(%rsp), %eax
	setl	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB33_5
## %bb.4:
	leaq	L___func__.dswap_6(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.8(%rip), %rcx
	movl	$3188, %edx                     ## imm = 0xC74
	callq	___assert_rtn
LBB33_5:
	jmp	LBB33_6
LBB33_6:
	xorl	%eax, %eax
	cmpl	180(%rsp), %eax
	setl	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB33_8
## %bb.7:
	leaq	L___func__.dswap_6(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.9(%rip), %rcx
	movl	$3189, %edx                     ## imm = 0xC75
	callq	___assert_rtn
LBB33_8:
	jmp	LBB33_9
LBB33_9:
	cmpl	$1, 196(%rsp)
	jne	LBB33_20
## %bb.10:
	cmpl	$1, 180(%rsp)
	jne	LBB33_20
## %bb.11:
	movl	$0, 28(%rsp)
LBB33_12:                               ## =>This Inner Loop Header: Depth=1
	movl	28(%rsp), %eax
	movl	212(%rsp), %ecx
	subl	$7, %ecx
	cmpl	%ecx, %eax
	jge	LBB33_15
## %bb.13:                              ##   in Loop: Header=BB33_12 Depth=1
	movq	200(%rsp), %rax
	movslq	28(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	movq	%rax, 216(%rsp)
	movq	216(%rsp), %rax
	vmovupd	(%rax), %ymm0
	vmovapd	%ymm0, 128(%rsp)
	movq	184(%rsp), %rax
	movslq	28(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	movq	%rax, 456(%rsp)
	movq	456(%rsp), %rax
	vmovupd	(%rax), %ymm0
	vmovapd	%ymm0, 64(%rsp)
	movq	200(%rsp), %rax
	movslq	28(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	vmovapd	64(%rsp), %ymm0
	movq	%rax, 448(%rsp)
	vmovapd	%ymm0, 416(%rsp)
	vmovapd	416(%rsp), %ymm0
	movq	448(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	184(%rsp), %rax
	movslq	28(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	vmovapd	128(%rsp), %ymm0
	movq	%rax, 408(%rsp)
	vmovapd	%ymm0, 352(%rsp)
	vmovapd	352(%rsp), %ymm0
	movq	408(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	200(%rsp), %rax
	movslq	28(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	addq	$32, %rax
	movq	%rax, 344(%rsp)
	movq	344(%rsp), %rax
	vmovupd	(%rax), %ymm0
	vmovapd	%ymm0, 96(%rsp)
	movq	184(%rsp), %rax
	movslq	28(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	addq	$32, %rax
	movq	%rax, 336(%rsp)
	movq	336(%rsp), %rax
	vmovupd	(%rax), %ymm0
	vmovapd	%ymm0, 32(%rsp)
	movq	200(%rsp), %rax
	movslq	28(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	addq	$32, %rax
	vmovapd	32(%rsp), %ymm0
	movq	%rax, 328(%rsp)
	vmovapd	%ymm0, 288(%rsp)
	vmovapd	288(%rsp), %ymm0
	movq	328(%rsp), %rax
	vmovupd	%ymm0, (%rax)
	movq	184(%rsp), %rax
	movslq	28(%rsp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	addq	$32, %rax
	vmovapd	96(%rsp), %ymm0
	movq	%rax, 280(%rsp)
	vmovapd	%ymm0, 224(%rsp)
	vmovapd	224(%rsp), %ymm0
	movq	280(%rsp), %rax
	vmovupd	%ymm0, (%rax)
## %bb.14:                              ##   in Loop: Header=BB33_12 Depth=1
	movl	28(%rsp), %eax
	addl	$8, %eax
	movl	%eax, 28(%rsp)
	jmp	LBB33_12
LBB33_15:
	jmp	LBB33_16
LBB33_16:                               ## =>This Inner Loop Header: Depth=1
	movl	28(%rsp), %eax
	cmpl	212(%rsp), %eax
	jge	LBB33_19
## %bb.17:                              ##   in Loop: Header=BB33_16 Depth=1
	movq	200(%rsp), %rax
	movl	28(%rsp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 168(%rsp)
	movq	184(%rsp), %rax
	movl	28(%rsp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	200(%rsp), %rax
	movl	28(%rsp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	vmovsd	168(%rsp), %xmm0                ## xmm0 = mem[0],zero
	movq	184(%rsp), %rax
	movl	28(%rsp), %ecx
	addl	$0, %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.18:                              ##   in Loop: Header=BB33_16 Depth=1
	movl	28(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rsp)
	jmp	LBB33_16
LBB33_19:
	jmp	LBB33_25
LBB33_20:
	movl	$0, 28(%rsp)
	movl	$0, 24(%rsp)
	movl	$0, 20(%rsp)
LBB33_21:                               ## =>This Inner Loop Header: Depth=1
	movl	28(%rsp), %eax
	cmpl	212(%rsp), %eax
	jge	LBB33_24
## %bb.22:                              ##   in Loop: Header=BB33_21 Depth=1
	movq	200(%rsp), %rax
	movslq	24(%rsp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, 168(%rsp)
	movq	184(%rsp), %rax
	movslq	20(%rsp), %rcx
	vmovsd	(%rax,%rcx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	200(%rsp), %rax
	movslq	24(%rsp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
	vmovsd	168(%rsp), %xmm0                ## xmm0 = mem[0],zero
	movq	184(%rsp), %rax
	movslq	20(%rsp), %rcx
	vmovsd	%xmm0, (%rax,%rcx,8)
## %bb.23:                              ##   in Loop: Header=BB33_21 Depth=1
	movl	28(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 28(%rsp)
	movl	196(%rsp), %eax
	addl	24(%rsp), %eax
	movl	%eax, 24(%rsp)
	movl	180(%rsp), %eax
	addl	20(%rsp), %eax
	movl	%eax, 20(%rsp)
	jmp	LBB33_21
LBB33_24:
	jmp	LBB33_25
LBB33_25:
	movq	%rbp, %rsp
	popq	%rbp
	vzeroupper
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dlaswp_6
_dlaswp_6:                              ## @dlaswp_6
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$208, %rsp
	movl	16(%rbp), %eax
	xorl	%r10d, %r10d
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movq	%r9, -40(%rbp)
	cmpl	16(%rbp), %r10d
	setl	%r11b
	xorb	$-1, %r11b
	andb	$1, %r11b
	movzbl	%r11b, %ecx
	movslq	%ecx, %rsi
	cmpq	$0, %rsi
	je	LBB34_2
## %bb.1:
	leaq	L___func__.dlaswp_6(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.8(%rip), %rcx
	movl	$3241, %edx                     ## imm = 0xCA9
	callq	___assert_rtn
LBB34_2:
	jmp	LBB34_3
LBB34_3:
	movl	$1, %eax
	cmpl	16(%rbp), %eax
	sete	%cl
	xorb	$-1, %cl
	andb	$1, %cl
	movzbl	%cl, %eax
	movslq	%eax, %rdx
	cmpq	$0, %rdx
	je	LBB34_5
## %bb.4:
	leaq	L___func__.dlaswp_6(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	leaq	L_.str.11(%rip), %rcx
	movl	$3242, %edx                     ## imm = 0xCAA
	callq	___assert_rtn
LBB34_5:
	jmp	LBB34_6
LBB34_6:
	xorl	%eax, %eax
	movl	-4(%rbp), %ecx
	movl	%eax, -204(%rbp)                ## 4-byte Spill
	movl	%ecx, %eax
	cltd
	movl	$32, %ecx
	idivl	%ecx
	shll	$5, %eax
	movl	%eax, -44(%rbp)
	movl	-204(%rbp), %eax                ## 4-byte Reload
	cmpl	-44(%rbp), %eax
	jge	LBB34_22
## %bb.7:
	movl	$0, -52(%rbp)
LBB34_8:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB34_10 Depth 2
                                        ##       Child Loop BB34_13 Depth 3
	movl	-52(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	LBB34_21
## %bb.9:                               ##   in Loop: Header=BB34_8 Depth=1
	movl	-24(%rbp), %eax
	movl	%eax, -48(%rbp)
LBB34_10:                               ##   Parent Loop BB34_8 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB34_13 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	LBB34_19
## %bb.11:                              ##   in Loop: Header=BB34_10 Depth=2
	movq	-40(%rbp), %rax
	movslq	-48(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movl	%edx, -60(%rbp)
	movl	-60(%rbp), %edx
	cmpl	-48(%rbp), %edx
	je	LBB34_17
## %bb.12:                              ##   in Loop: Header=BB34_10 Depth=2
	movl	-52(%rbp), %eax
	movl	%eax, -56(%rbp)
LBB34_13:                               ##   Parent Loop BB34_8 Depth=1
                                        ##     Parent Loop BB34_10 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-56(%rbp), %eax
	movl	-52(%rbp), %ecx
	addl	$32, %ecx
	subl	$7, %ecx
	cmpl	%ecx, %eax
	jge	LBB34_16
## %bb.14:                              ##   in Loop: Header=BB34_13 Depth=3
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -96(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -104(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -112(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -120(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -128(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	vmovsd	-144(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-152(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-160(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-168(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-176(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-184(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-192(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-200(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-80(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-88(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-96(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-104(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-112(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-120(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-128(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-136(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.15:                              ##   in Loop: Header=BB34_13 Depth=3
	movl	-56(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB34_13
LBB34_16:                               ##   in Loop: Header=BB34_10 Depth=2
	jmp	LBB34_17
LBB34_17:                               ##   in Loop: Header=BB34_10 Depth=2
	jmp	LBB34_18
LBB34_18:                               ##   in Loop: Header=BB34_10 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB34_10
LBB34_19:                               ##   in Loop: Header=BB34_8 Depth=1
	jmp	LBB34_20
LBB34_20:                               ##   in Loop: Header=BB34_8 Depth=1
	movl	-52(%rbp), %eax
	addl	$32, %eax
	movl	%eax, -52(%rbp)
	jmp	LBB34_8
LBB34_21:
	jmp	LBB34_22
LBB34_22:
	movl	-44(%rbp), %eax
	cmpl	-4(%rbp), %eax
	je	LBB34_38
## %bb.23:
	movl	-24(%rbp), %eax
	movl	%eax, -48(%rbp)
LBB34_24:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB34_27 Depth 2
                                        ##     Child Loop BB34_31 Depth 2
	movl	-48(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	LBB34_37
## %bb.25:                              ##   in Loop: Header=BB34_24 Depth=1
	movq	-40(%rbp), %rax
	movslq	-48(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movl	%edx, -60(%rbp)
	movl	-48(%rbp), %edx
	cmpl	-60(%rbp), %edx
	je	LBB34_35
## %bb.26:                              ##   in Loop: Header=BB34_24 Depth=1
	movl	-44(%rbp), %eax
	movl	%eax, -56(%rbp)
LBB34_27:                               ##   Parent Loop BB34_24 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-56(%rbp), %eax
	movl	-4(%rbp), %ecx
	subl	$7, %ecx
	cmpl	%ecx, %eax
	jge	LBB34_30
## %bb.28:                              ##   in Loop: Header=BB34_27 Depth=2
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -88(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -96(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -104(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -112(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -120(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -128(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -136(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -152(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -160(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -168(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -176(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -184(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -192(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -200(%rbp)
	vmovsd	-144(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-152(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-160(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-168(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-176(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-184(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-192(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-200(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-80(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-88(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$1, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-96(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$2, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-104(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$3, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-112(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$4, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-120(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$5, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-128(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$6, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-136(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$7, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.29:                              ##   in Loop: Header=BB34_27 Depth=2
	movl	-56(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB34_27
LBB34_30:                               ##   in Loop: Header=BB34_24 Depth=1
	jmp	LBB34_31
LBB34_31:                               ##   Parent Loop BB34_24 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-56(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB34_34
## %bb.32:                              ##   in Loop: Header=BB34_31 Depth=2
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -80(%rbp)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	(%rax,%rsi,8), %xmm0            ## xmm0 = mem[0],zero
	vmovsd	%xmm0, -144(%rbp)
	vmovsd	-80(%rbp), %xmm0                ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-60(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
	vmovsd	-144(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	movl	-56(%rbp), %edx
	addl	$0, %edx
	imull	%edx, %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rsi
	vmovsd	%xmm0, (%rax,%rsi,8)
## %bb.33:                              ##   in Loop: Header=BB34_31 Depth=2
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB34_31
LBB34_34:                               ##   in Loop: Header=BB34_24 Depth=1
	jmp	LBB34_35
LBB34_35:                               ##   in Loop: Header=BB34_24 Depth=1
	jmp	LBB34_36
LBB34_36:                               ##   in Loop: Header=BB34_24 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB34_24
LBB34_37:
	jmp	LBB34_38
LBB34_38:
	addq	$208, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dtrsm_L_6
_dtrsm_L_6:                             ## @dtrsm_L_6
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movq	%rdx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movl	$0, -44(%rbp)
LBB35_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB35_3 Depth 2
                                        ##       Child Loop BB35_5 Depth 3
	movl	-44(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB35_12
## %bb.2:                               ##   in Loop: Header=BB35_1 Depth=1
	movl	$0, -48(%rbp)
LBB35_3:                                ##   Parent Loop BB35_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB35_5 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB35_10
## %bb.4:                               ##   in Loop: Header=BB35_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
LBB35_5:                                ##   Parent Loop BB35_1 Depth=1
                                        ##     Parent Loop BB35_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-40(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB35_8
## %bb.6:                               ##   in Loop: Header=BB35_5 Depth=3
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.7:                               ##   in Loop: Header=BB35_5 Depth=3
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	LBB35_5
LBB35_8:                                ##   in Loop: Header=BB35_3 Depth=2
	jmp	LBB35_9
LBB35_9:                                ##   in Loop: Header=BB35_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB35_3
LBB35_10:                               ##   in Loop: Header=BB35_1 Depth=1
	jmp	LBB35_11
LBB35_11:                               ##   in Loop: Header=BB35_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB35_1
LBB35_12:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dgetrs_6
_dgetrs_6:                              ## @dgetrs_6
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	xorl	%eax, %eax
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	-32(%rbp), %rsi
	movl	-4(%rbp), %r8d
	movq	-24(%rbp), %r9
	movl	$1, %edi
	movl	%edi, -36(%rbp)                 ## 4-byte Spill
	movl	-36(%rbp), %edx                 ## 4-byte Reload
	movl	%eax, %ecx
	movl	$1, (%rsp)
	callq	_dlaswp_6
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %ecx
	movq	-32(%rbp), %r8
	movl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %r9d
	callq	_dtrsm_L_6
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %ecx
	movq	-32(%rbp), %r8
	movl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %r9d
	callq	_dtrsm_U_6
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function dtrsm_U_1
LCPI37_0:
	.quad	0x3bc79ca10c924223              ## double 9.9999999999999995E-21
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI37_1:
	.quad	0x7fffffffffffffff              ## double NaN
	.quad	0x7fffffffffffffff              ## double NaN
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	4, 0x90
_dtrsm_U_1:                             ## @dtrsm_U_1
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movq	%rdx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movl	$0, -44(%rbp)
LBB37_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB37_3 Depth 2
                                        ##       Child Loop BB37_6 Depth 3
	movl	-44(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB37_14
## %bb.2:                               ##   in Loop: Header=BB37_1 Depth=1
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -48(%rbp)
LBB37_3:                                ##   Parent Loop BB37_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB37_6 Depth 3
	cmpl	$0, -48(%rbp)
	jl	LBB37_12
## %bb.4:                               ##   in Loop: Header=BB37_3 Depth=2
	vmovsd	LCPI37_0(%rip), %xmm0           ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	vxorps	%xmm2, %xmm2, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovdqa	LCPI37_1(%rip), %xmm2           ## xmm2 = [NaN,NaN]
	vpand	%xmm2, %xmm1, %xmm1
	vucomisd	%xmm1, %xmm0
	jae	LBB37_10
## %bb.5:                               ##   in Loop: Header=BB37_3 Depth=2
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vdivsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	movl	$0, -40(%rbp)
LBB37_6:                                ##   Parent Loop BB37_1 Depth=1
                                        ##     Parent Loop BB37_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-40(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	LBB37_9
## %bb.7:                               ##   in Loop: Header=BB37_6 Depth=3
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.8:                               ##   in Loop: Header=BB37_6 Depth=3
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	LBB37_6
LBB37_9:                                ##   in Loop: Header=BB37_3 Depth=2
	jmp	LBB37_10
LBB37_10:                               ##   in Loop: Header=BB37_3 Depth=2
	jmp	LBB37_11
LBB37_11:                               ##   in Loop: Header=BB37_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB37_3
LBB37_12:                               ##   in Loop: Header=BB37_1 Depth=1
	jmp	LBB37_13
LBB37_13:                               ##   in Loop: Header=BB37_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB37_1
LBB37_14:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dtrsm_U_2
_dtrsm_U_2:                             ## @dtrsm_U_2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movq	%rdx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movl	$0, -44(%rbp)
LBB38_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB38_3 Depth 2
                                        ##       Child Loop BB38_5 Depth 3
	movl	-44(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB38_12
## %bb.2:                               ##   in Loop: Header=BB38_1 Depth=1
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -48(%rbp)
LBB38_3:                                ##   Parent Loop BB38_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB38_5 Depth 3
	cmpl	$0, -48(%rbp)
	jl	LBB38_10
## %bb.4:                               ##   in Loop: Header=BB38_3 Depth=2
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vdivsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	movl	$0, -40(%rbp)
LBB38_5:                                ##   Parent Loop BB38_1 Depth=1
                                        ##     Parent Loop BB38_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-40(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	LBB38_8
## %bb.6:                               ##   in Loop: Header=BB38_5 Depth=3
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-40(%rbp), %ecx
	addl	-44(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.7:                               ##   in Loop: Header=BB38_5 Depth=3
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	LBB38_5
LBB38_8:                                ##   in Loop: Header=BB38_3 Depth=2
	jmp	LBB38_9
LBB38_9:                                ##   in Loop: Header=BB38_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB38_3
LBB38_10:                               ##   in Loop: Header=BB38_1 Depth=1
	jmp	LBB38_11
LBB38_11:                               ##   in Loop: Header=BB38_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB38_1
LBB38_12:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dtrsm_U_5
_dtrsm_U_5:                             ## @dtrsm_U_5
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movq	%rdx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movl	$0, -44(%rbp)
LBB39_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB39_3 Depth 2
                                        ##       Child Loop BB39_5 Depth 3
	movl	-44(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB39_12
## %bb.2:                               ##   in Loop: Header=BB39_1 Depth=1
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -48(%rbp)
LBB39_3:                                ##   Parent Loop BB39_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB39_5 Depth 3
	cmpl	$0, -48(%rbp)
	jl	LBB39_10
## %bb.4:                               ##   in Loop: Header=BB39_3 Depth=2
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vdivsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	movl	$0, -40(%rbp)
LBB39_5:                                ##   Parent Loop BB39_1 Depth=1
                                        ##     Parent Loop BB39_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-40(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	LBB39_8
## %bb.6:                               ##   in Loop: Header=BB39_5 Depth=3
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.7:                               ##   in Loop: Header=BB39_5 Depth=3
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	LBB39_5
LBB39_8:                                ##   in Loop: Header=BB39_3 Depth=2
	jmp	LBB39_9
LBB39_9:                                ##   in Loop: Header=BB39_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB39_3
LBB39_10:                               ##   in Loop: Header=BB39_1 Depth=1
	jmp	LBB39_11
LBB39_11:                               ##   in Loop: Header=BB39_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB39_1
LBB39_12:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function dtrsm_U_6
_dtrsm_U_6:                             ## @dtrsm_U_6
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movq	%rdx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movl	$0, -44(%rbp)
LBB40_1:                                ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB40_3 Depth 2
                                        ##       Child Loop BB40_5 Depth 3
	movl	-44(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB40_12
## %bb.2:                               ##   in Loop: Header=BB40_1 Depth=1
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -48(%rbp)
LBB40_3:                                ##   Parent Loop BB40_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB40_5 Depth 3
	cmpl	$0, -48(%rbp)
	jl	LBB40_10
## %bb.4:                               ##   in Loop: Header=BB40_3 Depth=2
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vdivsd	(%rax,%rdx,8), %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
	movl	$0, -40(%rbp)
LBB40_5:                                ##   Parent Loop BB40_1 Depth=1
                                        ##     Parent Loop BB40_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-40(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	LBB40_8
## %bb.6:                               ##   in Loop: Header=BB40_5 Depth=3
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm0            ## xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	(%rax,%rdx,8), %xmm1            ## xmm1 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmulsd	(%rax,%rdx,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm0
	movq	-32(%rbp), %rax
	movl	-36(%rbp), %ecx
	imull	-44(%rbp), %ecx
	addl	-40(%rbp), %ecx
	movslq	%ecx, %rdx
	vmovsd	%xmm0, (%rax,%rdx,8)
## %bb.7:                               ##   in Loop: Header=BB40_5 Depth=3
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	LBB40_5
LBB40_8:                                ##   in Loop: Header=BB40_3 Depth=2
	jmp	LBB40_9
LBB40_9:                                ##   in Loop: Header=BB40_3 Depth=2
	movl	-48(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB40_3
LBB40_10:                               ##   in Loop: Header=BB40_1 Depth=1
	jmp	LBB40_11
LBB40_11:                               ##   in Loop: Header=BB40_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB40_1
LBB40_12:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
.zerofill __DATA,__bss,_scratch_a,8,3   ## @scratch_a
.zerofill __DATA,__bss,_scratch_b,8,3   ## @scratch_b
.zerofill __DATA,__bss,_scratch_ipiv,8,3 ## @scratch_ipiv
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"ERROR: LU Solve singular matrix\n"

L___func__.dgemm_1T:                    ## @__func__.dgemm_1T
	.asciz	"dgemm_1T"

L_.str.1:                               ## @.str.1
	.asciz	"lu_solve.c"

L_.str.2:                               ## @.str.2
	.asciz	"APPROX_EQUAL(beta, ONE)"

L_.str.3:                               ## @.str.3
	.asciz	"APPROX_EQUAL(alpha, -ONE)"

L_.str.4:                               ## @.str.4
	.asciz	"LU Solving failed with A[%d x %d]"

L___func__.isamax_1:                    ## @__func__.isamax_1
	.asciz	"isamax_1"

L_.str.5:                               ## @.str.5
	.asciz	"0 < stride"

L_.str.6:                               ## @.str.6
	.asciz	"ix == i * stride"

L___func__.dswap_1:                     ## @__func__.dswap_1
	.asciz	"dswap_1"

L_.str.7:                               ## @.str.7
	.asciz	"0 < N"

L_.str.8:                               ## @.str.8
	.asciz	"0 < incx"

L_.str.9:                               ## @.str.9
	.asciz	"0 < incy"

L___func__.dlaswp_1:                    ## @__func__.dlaswp_1
	.asciz	"dlaswp_1"

L___func__.dgemm_1:                     ## @__func__.dgemm_1
	.asciz	"dgemm_1"

L___func__.isamax_2:                    ## @__func__.isamax_2
	.asciz	"isamax_2"

L_.str.10:                              ## @.str.10
	.asciz	"0 <= N"

L___func__.dswap_2:                     ## @__func__.dswap_2
	.asciz	"dswap_2"

L___func__.dlaswp_2:                    ## @__func__.dlaswp_2
	.asciz	"dlaswp_2"

L_.str.11:                              ## @.str.11
	.asciz	"1 == incx"

L___func__.dgemm_2:                     ## @__func__.dgemm_2
	.asciz	"dgemm_2"

L___func__.dlaswp_5:                    ## @__func__.dlaswp_5
	.asciz	"dlaswp_5"

L___func__.dswap_6:                     ## @__func__.dswap_6
	.asciz	"dswap_6"

L___func__.dlaswp_6:                    ## @__func__.dlaswp_6
	.asciz	"dlaswp_6"

.subsections_via_symbols
