0512d7f0  stp      x20, x19, [sp, #-0x20]!
0512d7f4  stp      x29, x30, [sp, #0x10]
0512d7f8  add      x29, sp, #0x10
0512d7fc  mov      x19, x0
0512d800  ldr      x8, [x0, #0x18]
0512d804  ldr      x0, [x8, #0x20]
0512d808  cbz      x0, #0x512d854
0512d80c  ldur     x8, [x19, #0x28]
0512d810  cbz      x8, #0x512d82c
0512d814  ldr      x9, [x8, #0x10]
0512d818  mov      w10, w9
0512d81c  cmp      x9, x0
0512d820  mov      w9, #-0x22222223
0512d824  ccmp     x10, x9, #4, eq
0512d828  b.ne     #0x512d844
0512d82c  bl       #0x512c6c4
0512d830  mov      x1, x0
0512d834  stur     x0, [x19, #0x28]
0512d838  add      x0, x19, #0x28
0512d83c  bl       #0x2c6afb0
0512d840  ldur     x8, [x19, #0x28]
0512d844  mov      x0, x8
0512d848  ldp      x29, x30, [sp, #0x10]
0512d84c  ldp      x20, x19, [sp], #0x20
0512d850  ret      
0512d854  stur     xzr, [x19, #0x28]
0512d858  add      x0, x19, #0x28
0512d85c  mov      x1, #0
0512d860  bl       #0x2c6afb0
0512d864  mov      x8, #0
0512d868  mov      x0, x8
0512d86c  ldp      x29, x30, [sp, #0x10]
0512d870  ldp      x20, x19, [sp], #0x20
0512d874  ret      
