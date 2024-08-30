# 数据段，8字节对齐
.section .data
.align 3 # 8-byte alignment

# 定义32位整数变量my_data1
my_data1:
    .word 100

# 定义32位整数变量my_data2
my_data2:
    .word 50

# 定义字符串变量print_data
print_data:
    .string: "data: %d\n"

# 代码段
.section .text
.align 3

# global 定义全局函数main
.globl main
main:
    addi sp, sp, -16;
    sd ra, 0(sp);

    lw t0, my_data1
    lw t1, my_data2
    /* 计算t0+t1，并作为参数1 */

    add a1, t0, t1
    /* 载入print_data的地址到a0，并作为参数0 */
    la a0, print_data

    # 调用printf函数
    call printf

    li a0, 0
    ld ra, 0(sp)
    addi sp, sp, 16; # sp = sp + 16

    ret
