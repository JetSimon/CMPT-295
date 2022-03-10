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
	push %r13
	push %r12
# A in rdi, N in rsi
	xorl %eax, %eax			# set eax to 0
# since this function is a leaf function, no need to save caller-saved registers rcx and r8
	xorl %ecx, %ecx			# row number i is in ecx -> i = 0

# For each row
rowLoop2:

	movl %esi, %r9d #temp var here
	subl $2, %r9d

	movl %ecx, %r8d			# column number j in r8d -> j = i
	cmpl %r9d, %ecx			# loop as long as i - N < 0
	jg doneWithRows2

# For each cell of this row
colLoop2:
	cmpl %esi, %r8d			# loop as long as j - N < 0
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

	movb (%r10), %r12b
	movb (%r11), %r13b
	movb %r13b, (%r10)  
	movb %r12b, (%r11)   

	incl %r8d					# column number j++ (in r8d)
	jmp colLoop2				# go to next cell

# Go to next row
doneWithCells2:
	incl %ecx				# row number i++ (in ecx)
	jmp rowLoop2				# Play it again, Sam!

doneWithRows2:				# bye! bye!
	pop %r12
	pop %r13
	ret

#####################
	.globl	reverseColumns
reverseColumns:
	push %r13
	push %r12
# A in rdi, N in rsi
	xorl %eax, %eax			# set eax to 0
# since this function is a leaf function, no need to save caller-saved registers rcx and r8
	xorl %ecx, %ecx			# row number i is in ecx -> i = 0

# For each row
rowLoop3:
	movl $0, %r8d			# column number j in r8d -> j = 0
	cmpl %esi, %ecx			# loop as long as i - N < 0
	jg doneWithRows3

# For each cell of this row
colLoop3:
	cmpl %esi, %r8d			# loop as long as j - N < 0
	jge doneWithCells3

# Compute the address of current cell that is copied from A to C
# since this function is a leaf function, no need to save caller-saved registers r10 and r11
	movl %esi, %r10d        # r10d = N 
    imull %ecx, %r10d		# r10d = i*N
	addl %r8d, %r10d        # j + i*N
	imull $1, %r10d         # r10 = L * (j + i*N) -> L is char (1Byte)
	addq %rdi, %r10			# r10 = A + L * (j + i*N)

	movl %esi, %r11d        # r10d = N 
	sub %ecx, %r11d
    imull %ecx, %r11d		# r10d = i*N
	addl %r8d, %r11d        # j + i*N
	imull $1, %r11d         # r10 = L * (j + i*N) -> L is char (1Byte)
	addq %rdi, %r11			# r10 = A + L * (j + i*N)

	movb (%r10), %r12b
	movb (%r11), %r13b
	movb %r13b, (%r10)  
	movb %r12b, (%r11)   

	incl %r8d					# column number j++ (in r8d)
	jmp colLoop3				# go to next cell

# Go to next row
doneWithCells3:
	incl %ecx				# row number i++ (in ecx)
	jmp rowLoop3				# Play it again, Sam!

doneWithRows3:				# bye! bye!
	pop %r12
	pop %r13
	ret
