/* 汇编宏的练习 */

    .section .text
    .align 3

    .globl op_1
op_1:
    addi a0, a0, a1
    ret

    .globl op_2
op_2:
    sub a0, a0, a1
    ret

.macro op_func op, arg1, arg2
    mv a0, \arg1
    mv a1, \arg2
    call op_\()\op /* 这相当于字符串拼接，op = 1时，会调用op_1 */
.endm

    .globl main
main:
    addi sp, sp, -16
    sd ra, 8(sp)

    ld a0, #10
    ld a1, #5

    op_func 1, a0, a1
    # op_func 2, a0, a1

    ld ra, 8(sp)
    addi sp, sp, 16
    ret