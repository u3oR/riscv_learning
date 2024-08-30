
/* 对齐 */
.align 2 /* 4字节对齐 */

/* 数据定义 */
.byte /* 8位数据 */
.hword /* 16位数据 */
.word /* 32位数据 */
.int /* 32位数据 */
.quad /* 64位数据 */
.float /* 32位浮点数 */
.ascii "" /* 字符串,不包含\0 */
.asciz "" /* 字符串,包含\0 */

.rept 10 /* 重复10次 */
.endr /* 结束重复 */

.equ /* 定义常量，符号赋值操作，如.equ a = 10 */

.global /* 全局符号 */
.include /* 包含文件 */


/* 段描述 */
/* section_name: 段名，section_attributes: 段属性 */
.section <section_name>, <section_attributes>

/* 比如 */
.section ".idmap.text", "x" /* 段名为".idmap.text"，属性为"x"(可执行) */

/* 将中间包含的代码段放入指定的段中 */
pushsection < section_name > < section_attributes >
popsection 

/* 将中间包含的代码段链接到指定的段中 */
.section ".text.boot", "ax"
.previous
