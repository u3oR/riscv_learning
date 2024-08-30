


.align 3
.global func_addr
func_addr:
    .quad 0x0000000000400500  # func_addr1
    .quad 0x0000000000400800  # func_addr2
    .quad 0x0000000000400b00  # func_addr3
    .quad 0x0000000000400e00  # func_addr4

.align 3
.global func_string
func_string:
    .asciz "func_addr1"
    .asciz "func_addr2"
    .asciz "func_addr3"
    .asciz "func_addr4"

.align 3
.global func_array_num
func_array_num:
    .quad 4  # number of functions
