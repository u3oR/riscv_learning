
/* implementation of my_memcpy using inline assembly */

static void my_memcpy(void *dest, const void *src, unsigned long size) 
{
    unsigned long tmp = 0;
    unsigned long end_addr = (unsigned long)src + size;
#if 0
    asm volatile (
        "1: \n"
            "ld  %2, (%1)   \n" /* tmp = *(src) */
            "sd  %2, (%0)   \n" /* *(dest) = tmp */
            "add %0, %0, 8  \n" /* dest += 8 */
            "add %1, %1, 8  \n" /* src  += 8 */
            "blt %1, %3, 1b \n" /* if (src < end_addr) goto 1 */
            "fence rw, rw   \n" 
            : "+r" (dest), "+r" (src), "+r" (tmp)
            : "r" (end_addr)
            : "memory"
    );
#else
    asm volatile (
        "1: \n"
            "ld  %[tmp], (%[src])           \n" /* tmp = *(src) */
            "sd  %[tmp], (%[dest])          \n" /* *(dest) = tmp */
            "add %[dest], %[dest], 8        \n" /* dest += 8 */
            "add %[src],  %[src], 8         \n" /* src  += 8 */
            "blt %[src], %[end_addr], 1b    \n" /* if (src < end_addr) goto 1 */
            "fence rw, rw                   \n" 
            : [dest] "+r" (dest), [src] "+r" (src), [tmp] "+r" (tmp)
            : [end_addr] "r" (end_addr)
            : "memory"
    );
#endif
} 

void inline_asm_test() 
{
    my_memcpy(0x80210000, 0x80200000, 32);
}

