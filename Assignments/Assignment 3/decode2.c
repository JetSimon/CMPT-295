#include <stdio.h>

//x = %rdi
//y = %rsi 
//z = %rdx
//return = %rax
long decode2(long x, long y, long z)
{
    y -= z; //subq %rdx, %rsi
    x *= y; //imulq %rsi, %rdi
    long output = y; //movq %rsi, %rax
    output = output << 63; //salq $63, %rax
    output = output >> 63; //sarq $63, %rax
    output = output ^ x; //xorq %rdi, %rax
    return output; //ret 
}

int main()
{
    printf("%ld\n", decode2(1000,22322,34242) );
    return 0;
}
