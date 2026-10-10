04eba794  stp      x20, x19, [sp, #-0x20]!
04eba798  stp      x29, x30, [sp, #0x10]
04eba79c  add      x29, sp, #0x10
04eba7a0  mov      x19, x0
04eba7a4  ldr      x8, [x0, #0x18]
04eba7a8  ldr      x0, [x8, #0x140]
04eba7ac  cbz      x0, #0x4eba7fc
04eba7b0  ldur     x8, [x19, #0x60]
04eba7b4  cbz      x8, #0x4eba7d0
04eba7b8  ldr      x9, [x8, #0x10]
04eba7bc  mov      w10, w9
04eba7c0  cmp      x9, x0
04eba7c4  mov      w9, #-0x22222223
04eba7c8  ccmp     x10, x9, #4, eq
04eba7cc  b.ne     #0x4eba7ec
04eba7d0  mov      x1, #0
04eba7d4  bl       #0x515d0c0
04eba7d8  mov      x1, x0
04eba7dc  stur     x0, [x19, #0x60]
04eba7e0  add      x0, x19, #0x60
04eba7e4  bl       #0x2c6afb0
04eba7e8  ldur     x8, [x19, #0x60]
04eba7ec  mov      x0, x8
04eba7f0  ldp      x29, x30, [sp, #0x10]
04eba7f4  ldp      x20, x19, [sp], #0x20
04eba7f8  ret      
04eba7fc  stur     xzr, [x19, #0x60]
04eba800  add      x0, x19, #0x60
04eba804  mov      x1, #0
04eba808  bl       #0x2c6afb0
04eba80c  mov      x8, #0
04eba810  mov      x0, x8
04eba814  ldp      x29, x30, [sp, #0x10]
04eba818  ldp      x20, x19, [sp], #0x20
04eba81c  ret      
