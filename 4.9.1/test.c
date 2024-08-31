#include <stdio.h>

static inline void my_atomic_add(unsigned long val, void *p)
{
    unsigned long tmp;
    long result;
#if 0
    asm volatile(
        "1:\n"
            "lr.d %0, (%2)              \n" /* 原子读取     tmp = p */
            "add %0, %0, %3             \n" /* 加上val      tmp += val */
            "sc.d.rl %1, %0, (%2)       \n" /* 原子写入     result = p = tmp */
            "bnez %1, 1b                \n" /* 失败则重试   if (result != 0) goto 1 */
            "fence rw, rw               \n" /* 内存屏障 */
            : "+r" (tmp), "+r" (result)     /* 输出参数 */
            : "r" (p), "r" (val)            /* 输入参数 */
            : "cc", "memory"                /* 约束条件 */
    );
#endif

#if 1
    asm volatile(
        "1:\n"
            "lr.d       %0, %2      \n" /* 原子读取     tmp = p */
            "add        %0, %0, %3  \n" /* 加上val      tmp += val */
            "sc.d.rl    %1, %0, %2  \n" /* 原子写入     result = p = tmp */
            "bnez       %1, 1b      \n" /* 失败则重试   if (result != 0) goto 1 */
            "fence      rw, rw      \n" /* 内存屏障 */
            /* 输出参数 */
            : "+r" (tmp), "+r" (result) "+A" (*(unsigned long *)p)
            /* 输入参数 */
            : "r" (val)
            /* 约束条件 */
            : "cc", "memory"
    );
#endif
}

int main() 
{
    unsigned long val = 0;

    my_atomic_add(2, &val);

    printf("p = %ld\n", val);
    
    return 0;
}

