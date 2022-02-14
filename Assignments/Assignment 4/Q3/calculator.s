# add a header comment block

	.globl	lessThan # Make sure you change the name of this function - see XX function below
	.globl	plus
	.globl	minus
	.globl	mul

# x in edi, y in esi

lessThan: # Returns 1 if arg 1 > arg 2 else 0
	xorl	%eax, %eax #zero out %eax register 
	cmpl	%esi, %edi #if x < y then return to 1
	setl	%al         # See Section 3.6.2 of our textbook for a description of the set* instructions
	ret

plus:  # performs integer addition
	xorl %eax, %eax # Clear return register
	lea (%edi, %esi, 1), %eax #Use lea to add x + y*1 and store in return reg
	ret



minus: # performs integer subtraction
	xorl %eax, %eax # Clear return register
	neg %esi # turn y into -y to turn into subtraction
	lea (%edi, %esi, 1), %eax #Use lea to add x + y*1 and store in return reg
	ret


mul: # performs integer multiplication - when both operands are non-negative!
	xorl %eax, %eax # Clear return register
	xorl %r8d, %r8d # Clear iteration var register
	jmp cond #start loop

	loop:
		add $1, %r8d #Add 1 to the %r8d iterator so we know when to stop
		add %edi, %eax #Add x to the return value 1 time. Multiplication = repeated addition

	cond:
		cmpl %esi, %r8d #is %r8d < %esi (y)? then keep looping 
		jl loop

	ret

# algorithm: 
# int output = 0;
# for(int i = 0; i < y; i++)
# 	output += x
# return output;