## Filename: calculator.s
## Purpose: Assignment 6 Question 1 (Adapted from Assignment 4 Question 3)
## Author: Jet Simon
## Date: March 8 2022

	.globl	lessThan
	.globl	plus
	.globl	minus
	.globl	mul

# x in edi, y in esi

lessThan: # Returns 1 if arg 1 < arg 2 else 0
	    
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

# performs integer multiplication - when both operands are non-negative!
# You can assume that both parameters are non-negative.
# Requirements:
# - you cannot use imul* instruction
#   (or any kind of instruction that multiplies such as mul)
# - you must use recursion (no loop) and the stack

#algorithm
#   1. Take in your numbers x and y. 
#   2. Is y > 0? If so then subtract 1 from y and go to step 1
#   3. If y == 0 then stop calling self.
#   4. As the stack frames unwind then you will add x to the return value y times. 
#   5. You are now returning x * y

#x = %edi, y = %esi
mul: # performs integer multiplication - when both operands are non-negative!
    xorl %eax, %eax #zero out %eax register
    pushq %rdi
    pushq %rsi

    cmpl $0, %esi #compare if the times added > 0, else jump to done ie dont add more
    je done

    subl $1, %esi #subtract 1 from your y variable, using y as a counter
    call mul #call adding function recursively 
    addl %edi, %eax #add our x variable to return value, we do this here to avoid the zeroed out %eax

    done:
    popq %rsi
    popq %rdi
	ret


