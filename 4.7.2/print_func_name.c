

extern unsigned long func_addr[];
extern char func_string[];
extern unsigned long func_array_num;

static int print_func_name(unsigned long addr) 
{
    int i;
    char *p;
    char *string;
    
    for (i = 0; i < func_array_num; i++)
    {
        if (addr == func_addr[i])
        {
            goto found;
        }
    }
    return -1;

found:
    p = &func_string;

    if (i == 0)
    {
        string = p;
        goto done;
    }

    while(1) {
        p++;
        
        if (*p == '\0') 
            i--;
        
        if (i == 0)
        {
            p++;
            string = p;
            break;
        }
    }

done:
    printf("%s\n", string);
    
    return 0;

}
