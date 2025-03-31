.section .data
dir_buffer:
    .fill 256, 1, 0      // 256 bytes filled with zeros
file_name:
    .asciz "testfile777.txt"
file_text:
    .asciz "Hello from low level programming world\n"

.section .text
.global _start

_start:
    ldr x0, =dir_buffer  // buffer adress to reg x0
    mov x1, #256         // buffer size 256 bytes
    mov x8, #17          // getcwd (17) copy to sys call
    svc #0               // sys call

    // stdout
    mov x0, #1           // stdout (1)
    ldr x1, =dir_buffer  // load to buffer
    mov x2, #256         // output size
    mov x8, #64          // write (64) copy to sys call
    svc #0               // sys call

    mov x0, #-100
    ldr x1, =file_name
    mov x2, #577
    mov x3, #420           
    mov x8, #56
    svc #0

    mov x19, x0

    mov x0, x19
    ldr x1, =file_text
    mov x2, #39
    mov x8, #64
    svc #0

    mov x0, x19
    mov x2, #493
    mov x8, #52
    svc #0

    mov x0, #-100
    ldr x1, =file_name
    mov x2, #511
    mov x3, #0
    mov x8, #53
    svc #0

    mov x0, #-100
    ldr x1, =file_name
    mov x2, #1000
    mov x3, #1000
    mov x4, #0
    mov x8, #54
    svc #0

    mov x0, x19
    mov x2, #1000
    mov x3, #1000
    mov x8, #55
    svc #0

    mov x0, #1           // return 1
    mov x8, #93          // exit (93) copy to sys call
    svc #0               // sys call
