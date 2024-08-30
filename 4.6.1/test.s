        .section .rodata
        .align 3
    
    .string_data: 
        .string "data: %d %d %d %d %d %d %d %d %d %d\n"    

    data:
        .word 1, 2, 3, 4, 5, 6, 7, 8, 9, -1


        .section .text
        .align 2 /* 对齐到4字节 */

    .globl main
    main:
        /* 扩充48个字节的栈空间 */
        addi sp, sp, -48; 
        /* 保存返回地址 */
        sd ra, 40(sp); 

        /* 前8个参数 通过寄存器传递 */
        la a0, .string_data
        li a1, 1
        li a2, 2
        li a3, 3
        li a4, 4
        li a5, 5
        li a6, 6
        li a7, 7

        /* 后续参数 通过栈传递 */
        li t0, 8
        sd t0, 0(sp) /* 参数8保存到SP+0 */

        li t0, 9
        sd t0, 8(sp) /* 参数9保存到SP+8 */

        li t0, -1
        sd t0, 16(sp) /* 参数-1保存到SP+16 */

        /* 调用 printf 函数 */
        call printf

        /* 栈向上生长，恢复调用者的栈 */
        ld ra, 40(sp)

        /* 设置main函数的返回值 */
        li a0, 0

        /* 回收调用者的栈空间 */
        addi sp, sp, 48; 

        /* 返回 */
        ret

        
