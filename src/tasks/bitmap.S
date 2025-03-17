    .section .data
prompt:
    .asciz "Enter up to 16 symbols (B, r, g, b, y, w, c, m): "
    
inputBuffer:
    .space 17                    // буфер для введення 

black:
    .asciz "\033[40m"            // black
red:
    .asciz "\033[41m"            // red
green:
    .asciz "\033[42m"            // green
yellow:
    .asciz "\033[43m"            // yellow
blue:
    .asciz "\033[44m"            // blue
magenta:
    .asciz "\033[45m"            // magenta
cyan:
    .asciz "\033[46m"            // cyan
white:
    .asciz "\033[47m"            // white
reset:
    .asciz "\033[0m"             // default

spaces:
    .asciz "  "                 // spaces

newline:
    .asciz "\n"                 // newline

    .section .text
    .global _start

_start:
    mov x0, #1                  // stdout
    ldr x1, =prompt
    mov x2, #49                 // line prompt
    mov x8, #64                // syscall write
    svc #0

    mov x0, #0                  // stdin
    ldr x1, =inputBuffer
    mov x2, #16
    mov x8, #63                // syscall read
    svc #0
    mov x4, x0

    mov x3, #0                 // index init

loop_char:
    cmp x3, x4
    bge end_loop

    ldr x7, =inputBuffer
    add x7, x7, x3
    ldrb w6, [x7]             // w6 = curr char

    cmp w6, #10               // cmp_eq to '\n'
    beq end_loop

    cmp w6, #'B'              // 'B'
    beq set_black
    cmp w6, #'r'              // 'r'
    beq set_red
    cmp w6, #'g'              // 'g'
    beq set_green
    cmp w6, #'y'              // 'y'
    beq set_yellow
    cmp w6, #'b'              // 'b'
    beq set_blue
    cmp w6, #'m'              // 'm'
    beq set_magenta
    cmp w6, #'c'              // 'c'
    beq set_cyan
    cmp w6, #'w'              // 'w'
    beq set_white

    b next_char               // skip if none is found

set_black:
    ldr x5, =black
    b print_cell
set_red:
    ldr x5, =red
    b print_cell
set_green:
    ldr x5, =green
    b print_cell
set_yellow:
    ldr x5, =yellow
    b print_cell
set_blue:
    ldr x5, =blue
    b print_cell
set_magenta:
    ldr x5, =magenta
    b print_cell
set_cyan:
    ldr x5, =cyan
    b print_cell
set_white:
    ldr x5, =white
    b print_cell

print_cell:
    mov x0, #1               // stdout
    mov x1, x5               // ptr to escape-code
    mov x2, #5
    mov x8, #64              // write
    svc #0

    mov x0, #1
    ldr x1, =spaces
    mov x2, #2
    mov x8, #64
    svc #0

    mov x0, #1
    ldr x1, =reset
    mov x2, #4
    mov x8, #64
    svc #0

next_char:
    add x3, x3, #1         // incr idx
    b loop_char

end_loop:
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0

    mov x0, #0
    mov x8, #93             // syscall exit
    svc #0
