	.globl	copy
copy:
# A in rdi, C in rsi, N in edx
	xorl %eax, %eax			# set eax to 0
# since this function is a leaf function, no need to save caller-saved registers rcx and r8
	xorl %ecx, %ecx			# row number i is in ecx -> i = 0

# For each row
rowLoop:
	movl $0, %r8d			# column number j in r8d -> j = 0
	cmpl %edx, %ecx			# loop as long as i - N < 0
	jge doneWithRows

# For each cell of this row
colLoop:
	cmpl %edx, %r8d			# loop as long as j - N < 0
	jge doneWithCells

# Compute the address of current cell that is copied from A to C
# since this function is a leaf function, no need to save caller-saved registers r10 and r11
	movl %edx, %r10d        # r10d = N 
    imull %ecx, %r10d		# r10d = i*N
	addl %r8d, %r10d        # j + i*N
	imull $1, %r10d         # r10 = L * (j + i*N) -> L is char (1Byte)
	movq %r10, %r11			# r11 = L * (j + i*N) 
	addq %rdi, %r10			# r10 = A + L * (j + i*N)
	addq %rsi, %r11			# r11 = C + L * (j + i*N)

# Copy A[L * (j + i*N)] to C[L * (j + i*N)]
	movb (%r10), %r9b       # temp = A[L * (j + i*N)]
	movb %r9b, (%r11)       # C[L * (j + i*N)] = temp

	incl %r8d				# column number j++ (in r8d)
	jmp colLoop				# go to next cell

# Go to next row
doneWithCells:
	incl %ecx				# row number i++ (in ecx)
	jmp rowLoop				# Play it again, Sam!

doneWithRows:				# bye! bye!
	ret



#for n = 0 to N - 2
#    for m = n + 1 to N - 1
#        swap A(n,m) with A(m,n)

#####################
	.globl	transpose
transpose:
# A in rdi, N in rsi
	xorl %eax, %eax			# set eax to 0
# since this function is a leaf function, no need to save caller-saved registers rcx and r8
	xorl %ecx, %ecx			# row number n is in ecx -> n = 0

# For each row
rowLoop2:
	movl %ecx, %r8d			# column number m in r8d -> m = n
	incl %r8d
	mov %esi, %r9d
	add $2, %r9d
	cmpl %r9d, %ecx			# loop as long as i - N < 0
	jge doneWithRows2

# For each cell of this row
colLoop2:
	mov %esi, %r9d
	sub $1, %r9d
	cmpl %r9d, %r8d			# loop as long as j - N < 0
	jge doneWithCells2

# Compute the address of current cell that is copied from A to C
# since this function is a leaf function, no need to save caller-saved registers r10 and r11
	movl %esi, %r10d        # r10d = N 
    imull %ecx, %r10d		# r10d = i*N
	addl %r8d, %r10d        # j + i*N
	imull $1, %r10d         # r10 = L * (j + i*N) -> L is char (1Byte)
	addq %rdi, %r10			# r10 = A + L * (j + i*N)

	movl %esi, %r11d        # r10d = N 
    imull %r8d, %r11d		# r10d = j*N
	addl %ecx, %r11d        # i + j*N
	imull $1, %r11d         # r10 = L * (i + j*N) -> L is char (1Byte)
	addq %rdi, %r11			# r10 = A + L * (i + j*N)

	#mov (%r10), %r8b
	#mov (%r11), %r15d
	#mov %r8b, (%r11)
	#mov %r15d, (%r10)
	movq $0, (%r10)

	incl %r8d				# column number j++ (in r8d)
	jmp colLoop2			# go to next cell

# Go to next row
doneWithCells2:
	incl %ecx				# row number i++ (in ecx)
	jmp rowLoop2			# Play it again, Sam!

doneWithRows2:				# bye! bye!
	ret


#####################
	.globl	reverseColumns
reverseColumns:


	ret
