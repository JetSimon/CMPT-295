        .file   "decode2.c"
        .text
        .globl  decode2
        .type   decode2, @function
decode2: #x = %rdi, y = %rsi, z = %rdx, return value = %rax
.LFB23:
        .cfi_startproc
        endbr64
        subq    %rdx, %rsi #y -= z
        imulq   %rsi, %rdi #x *= y
        salq    $63, %rsi #compiler optimization. y = output -> y << 63
        sarq    $63, %rsi #y >> 63
        movq    %rdi, %rax #move x to return instead of y as in our code
        xorq    %rsi, %rax #y ^ x to return
        ret #return rax
        .cfi_endproc
.LFE23:
        .size   decode2, .-decode2
        .section        .rodata.str1.1,"aMS",@progbits,1
.LC0:
        .string "%ld\n"
        .text
        .globl  main
        .type   main, @function
main:
.LFB24:
        .cfi_startproc
        endbr64
        subq    $8, %rsp
        .cfi_def_cfa_offset 16
        movl    $34242, %edx
        movl    $22322, %esi
        movl    $1000, %edi
        call    decode2
        movq    %rax, %rdx
        leaq    .LC0(%rip), %rsi
        movl    $1, %edi
        movl    $0, %eax
        call    __printf_chk@PLT
        movl    $0, %eax
        addq    $8, %rsp
        .cfi_def_cfa_offset 8
        ret
        .cfi_endproc
.LFE24:
        .size   main, .-main
        .ident  "GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
        .section        .note.GNU-stack,"",@progbits
        .section        .note.gnu.property,"a"
        .align 8
        .long    1f - 0f
        .long    4f - 1f
        .long    5
0:
        .string  "GNU"
1:
        .align 8
        .long    0xc0000002
        .long    3f - 2f
2:
        .long    0x3
3:
        .align 8
4: