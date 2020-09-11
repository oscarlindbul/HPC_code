	.text
	.file	"benchmark.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function main
.LCPI0_0:
	.quad	4517329193108106637     # double 9.9999999999999995E-7
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	leaq	8(%rsp), %rdi
	leaq	32(%rsp), %rsi
	callq	gettimeofday            #  benchmark.c:34:7
	vcvtsi2sdq	16(%rsp), %xmm0, %xmm0 #  benchmark.c:35:33
	vmulsd	.LCPI0_0(%rip), %xmm0, %xmm0 #  benchmark.c:35:53
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm1 #  benchmark.c:35:12
	vaddsd	%xmm1, %xmm0, %xmm0     #  benchmark.c:35:31
	vmovsd	%xmm0, 24(%rsp)         # 8-byte Spill
	leaq	8(%rsp), %rdi
	leaq	32(%rsp), %rsi
	callq	gettimeofday            #  benchmark.c:34:7
	vcvtsi2sdq	8(%rsp), %xmm2, %xmm0 #  benchmark.c:35:12
	vcvtsi2sdq	16(%rsp), %xmm2, %xmm1 #  benchmark.c:35:33
	vmulsd	.LCPI0_0(%rip), %xmm1, %xmm1 #  benchmark.c:35:53
	vaddsd	%xmm0, %xmm1, %xmm0     #  benchmark.c:35:31
	vsubsd	24(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
                                        #  benchmark.c:24:44
	movl	$.L.str, %edi           #  benchmark.c:24:3
	movb	$1, %al                 #  benchmark.c:24:3
	callq	printf                  #  benchmark.c:24:3
	xorl	%eax, %eax              #  benchmark.c:25:3
	addq	$40, %rsp               #  benchmark.c:25:3
	.cfi_def_cfa_offset 8           #  benchmark.c:25:3
	retq                            #  benchmark.c:25:3
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function mysecond
.LCPI1_0:
	.quad	4517329193108106637     # double 9.9999999999999995E-7
	.text
	.globl	mysecond
	.p2align	4, 0x90
	.type	mysecond,@function
mysecond:                               # @mysecond
	.cfi_startproc
# %bb.0:                                # %entry
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsp, %rdi
	leaq	16(%rsp), %rsi
	callq	gettimeofday            #  benchmark.c:34:7
	vcvtsi2sdq	(%rsp), %xmm0, %xmm0 #  benchmark.c:35:12
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm1 #  benchmark.c:35:33
	vmulsd	.LCPI1_0(%rip), %xmm1, %xmm1 #  benchmark.c:35:53
	vaddsd	%xmm0, %xmm1, %xmm0     #  benchmark.c:35:31
	addq	$24, %rsp               #  benchmark.c:35:3
	.cfi_def_cfa_offset 8           #  benchmark.c:35:3
	retq                            #  benchmark.c:35:3
.Lfunc_end1:
	.size	mysecond, .Lfunc_end1-mysecond
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Execution time: %11.8f s\n"
	.size	.L.str, 26

	.ident	"Cray clang version 10.0.1 (caf30fcafd1021890a5ea5d98ca2f101977405d4)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
