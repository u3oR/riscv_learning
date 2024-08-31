/* 这是一个简单的linker script，用于描述程序的内存布局 */
SECTIONS
{
	. = 0x80020000,         /* 指向开始的地址空间 */
	.text : { *(.text) }    /* 从该地址开始存储代码(text)段 */
    . = 0x80021000,         /* 指向下一个地址空间 */
    .data : { *(.data) }    /* 从该地址开始存储数据(data)段 */
    .bss : { *(.bss) }      /* 在data段之后，紧接着开始存储未初始化的全局变量(bss) */
}


ENTRY(_start): /* 设置程序入口点 */

INCLUDE "file.ld" /* 包含其他的linker script文件 */

