	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 12, 0	sdk_version 12, 0
	.globl	_decode2                        ## -- Begin function decode2
	.p2align	4, 0x90
_decode2:                               ## @decode2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rsi, %rax
	subq	%rdx, %rax
	imulq	%rax, %rdi
	andl	$1, %eax
	negq	%rax
	xorq	%rdi, %rax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$1000, %edi                     ## imm = 0x3E8
	movl	$22322, %esi                    ## imm = 0x5732
	movl	$34242, %edx                    ## imm = 0x85C2
	callq	_decode2
	leaq	L_.str(%rip), %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%ld\n"

.subsections_via_symbols
