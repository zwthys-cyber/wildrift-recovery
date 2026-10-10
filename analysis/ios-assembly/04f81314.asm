04f81314  stp      x20, x19, [sp, #-0x20]!
04f81318  stp      x29, x30, [sp, #0x10]
04f8131c  add      x29, sp, #0x10
04f81320  mov      x19, x0
04f81324  ldr      x8, [x0, #0x18]
04f81328  ldr      x0, [x8, #0x20]
04f8132c  cbz      x0, #0x4f8137c
04f81330  ldur     x8, [x19, #0x20]
04f81334  cbz      x8, #0x4f81350
04f81338  ldr      x9, [x8, #0x10]
04f8133c  mov      w10, w9
04f81340  cmp      x9, x0
04f81344  mov      w9, #-0x22222223
04f81348  ccmp     x10, x9, #4, eq
04f8134c  b.ne     #0x4f8136c
04f81350  mov      x1, #0
04f81354  bl       #0x4f82050
04f81358  mov      x1, x0
04f8135c  stur     x0, [x19, #0x20]
04f81360  add      x0, x19, #0x20
04f81364  bl       #0x2c6afb0
04f81368  ldur     x8, [x19, #0x20]
04f8136c  mov      x0, x8
04f81370  ldp      x29, x30, [sp, #0x10]
04f81374  ldp      x20, x19, [sp], #0x20
04f81378  ret      
04f8137c  stur     xzr, [x19, #0x20]
04f81380  add      x0, x19, #0x20
04f81384  mov      x1, #0
04f81388  bl       #0x2c6afb0
04f8138c  mov      x8, #0
04f81390  mov      x0, x8
04f81394  ldp      x29, x30, [sp, #0x10]
04f81398  ldp      x20, x19, [sp], #0x20
04f8139c  ret      
