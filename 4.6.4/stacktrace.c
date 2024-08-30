/* RISCV stack trace */


struct stackframe
{
    unsigned long s_fp; /* 父函数的栈底指针，存放到低地址，占用8字节 */
    unsigned long s_ra; /* 返回地址，存放到高地址，占用8字节 */
};

extern char _text[];    /* 程序代码段起始地址 */
extern char _etext[];   /* 程序代码段结束地址 */

/* 判断地址是否在text段 */
static int kernel_text(unsigned long addr)
{
    return (addr >= (unsigned long)_text && addr < (unsigned long)_etext);
}

/* 遍历栈帧 */
static void walk_stackframe(void)
{
    unsigned long sp;
    unsigned long fp;
    unsigned long pc;

    struct stackframe *frame;

    unsigned long low;

    /* 获取当前栈指针 */
    const register unsigned long current_sp __asm__("sp");

    sp = current_sp;
    pc = (unsigned long)walk_stackframe;
    /* 获取当前栈帧的fp */
    fp = (unsigned long)__builtin_frame_address(0);

    while (1)
    {
        /* 检查pc是否在text段 */
        if (!kernel_text(pc)) 
            break;

        /* 检查栈帧是否合法 */
        /* 栈帧的地址必须大于当前栈指针+16字节(至少存储着ra和fp) */
        /* 栈帧的地址必须是16字节对齐的 */
        low = sp + sizeof(struct stackframe);
        if (fp < low || (fp & 0xf) != 0) 
            break;

        /* fp指向当前栈帧的栈底 */
        /* 因此，fp-16正好存储当前栈帧的(ra, fp)结构 */
        /* 通过读取结构体的s_fp字段，可以获取到上一级函数的栈底地址 */
        frame = (struct stackframe *)(fp - sizeof(struct stackframe));

        /* 跳转到上一级函数的栈帧 */
        /* 这里的pc值是函数调用指令的地址，因此需要减4 */
        /* 如此便可以不断向上回溯，直到pc指向地址不属于text段为止 */
        /* 就能打印出完整的调用栈 */
        sp = fp;
        fp = frame->s_fp;
        pc = frame->s_ra - 4;

        if (kernel_text(pc))
        {
            /* 打印当前栈帧范围(自低地址到高地址)和函数地址 */
            printk("[0x%016lx - 0x%016lx] pc 0x%016lx\n", sp, fp, pc);
        }
    }
}

void dump_stack(void)
{
    printk("Stack trace:\n");
    walk_stackframe();
}

