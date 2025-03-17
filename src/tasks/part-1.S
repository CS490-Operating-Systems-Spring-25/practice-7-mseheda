.section .data
dir_buffer:
    .fill 256, 1, 0      // 256 bytes filled with zeros

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

    mov x0, #1           // return 1
    mov x8, #93          // exit (93) copy to sys call
    svc #0               // sys call
