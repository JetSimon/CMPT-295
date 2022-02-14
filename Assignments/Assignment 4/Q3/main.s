	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 12, 0	sdk_version 12, 0
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
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	cmpl	$3, %edi
	jne	LBB0_2
## %bb.1:
	movq	%rsi, %rbx
	movq	8(%rsi), %rdi
	callq	_atoi
	movl	%eax, %r15d
	movq	16(%rbx), %rdi
	callq	_atoi
	movl	%eax, %ebx
	movl	%r15d, %edi
	movl	%eax, %esi
	callq	_greaterThan
	leaq	L_.str(%rip), %rdi
	xorl	%r14d, %r14d
	movl	%r15d, %esi
	movl	%ebx, %edx
	movl	%eax, %ecx
	xorl	%eax, %eax
	callq	_printf
	movl	%r15d, %edi
	movl	%ebx, %esi
	callq	_plus
	leaq	L_.str.1(%rip), %rdi
	movl	%r15d, %esi
	movl	%ebx, %edx
	movl	%eax, %ecx
	xorl	%eax, %eax
	callq	_printf
	movl	%r15d, %edi
	movl	%ebx, %esi
	callq	_minus
	leaq	L_.str.2(%rip), %rdi
	movl	%r15d, %esi
	movl	%ebx, %edx
	movl	%eax, %ecx
	xorl	%eax, %eax
	callq	_printf
	movl	%r15d, %edi
	movl	%ebx, %esi
	callq	_mul
	leaq	L_.str.3(%rip), %rdi
	movl	%r15d, %esi
	movl	%ebx, %edx
	movl	%eax, %ecx
	xorl	%eax, %eax
	callq	_printf
	jmp	LBB0_3
LBB0_2:
	leaq	L_str(%rip), %rdi
	callq	_puts
	movl	$1, %r14d
LBB0_3:
	movl	%r14d, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%d ??? %d -> %d\n"

L_.str.1:                               ## @.str.1
	.asciz	"%d + %d = %d\n"

L_.str.2:                               ## @.str.2
	.asciz	"%d - %d = %d\n"

L_.str.3:                               ## @.str.3
	.asciz	"%d * %d = %d\n"

L_str:                                  ## @str
	.asciz	"Must supply 2 integers arguments."

.subsections_via_symbols
