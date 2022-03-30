# 1) "make" the program with -fno-stack-protector to experience 
#    "segmentation fault" when a password exceeds the size of the buffer
# 2) "make clean", comment out the SFLAGS with -fno-stack-protector 
#     and uncomment the SFLAGS without -fno-stack-protector then 
#     "make" the program again to experience gcc's protection, 
#     i.e., the detection of buffer overflow via the use of canary 
#     and the resulting 
#     *** stack smashing detected ***: ./pw terminated
#     Aborted
#     when a password when a password exceeds the size of the buffer

SFLAGS = -S -O2 -fno-stack-protector
# SFLAGS = -S -O2
OFLAGS = -g -c
CFLAGS = -o pw

all:	pw

pw:	password.o 
	gcc $(CFLAGS) password.o

password.o:	password.s
	gcc $(OFLAGS) password.s

password.s:	password.c
	gcc $(SFLAGS) password.c

clean:	
	rm -f pw *.o password.s
