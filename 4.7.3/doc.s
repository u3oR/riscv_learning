# macro 

/* 汇编宏 */
/* 定义一个add_data宏，用于将两个参数相加 */
.macro add_data p1=0, p2
    mv a5, \p1
    mv a6, \p2
    add a1, a5, a6
.endm

    .globl main
main:
    mv a2, #10
    mv a3, #20

    add_data a2, a3 /* 调用add_data宏，将a2和a3相加 */
    add_data , a3   /* 调用add_data宏，将a3和p1默认值0相加 */

/* :req, 用于指定某个宏的必选参数 */
.macro add_data_1 p1:req, p2
    mv a5, \p1
    mv a6, \p2
    add a1, a5, a6
.endm

    .globl main
main:
    mv a2, #10
    mv a3, #20

    add_data_1 , a3 /* 这样调用add_data_1宏会报错，因为缺少必需的p1参数 */



/* 文件相关 伪指令 */
/* 把test.bin的内容加载到内存的payload段中 */
    .section .payload, "ax", %progbits
    .globl pay_load

payload:
    .incbin "test.bin"

/* 在当前汇编代码中插入test/test.s的内容 */
.include "test/test.s"



/* RV汇编编译选项 */

# -fpic / -fpic  /* 生成位置无关代码 */
# -fno-pic /* 不生成 */
# -mabi=<ABI> /* 指定ABI 有ilp32, lp64 */
# -march=<ARCH> /* 指定架构有rv32i, rv32ima, rv64im */
# -misa-spec=<SPEC> /* 指定指令集版本 */
# -mlittle-endian /* 小端模式 */
# -mbig-endian /* 大端模式 */

