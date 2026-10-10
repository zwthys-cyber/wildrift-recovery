04ef995c  stp      x20, x19, [sp, #-0x20]!
04ef9960  stp      x29, x30, [sp, #0x10]
04ef9964  add      x29, sp, #0x10
04ef9968  mov      x19, x0
04ef996c  ldr      x8, [x0, #0x18]
04ef9970  ldr      x0, [x8, #0x180]
04ef9974  cbz      x0, #0x4ef99c4
04ef9978  ldr      x8, [x19, #0x1a8]
04ef997c  cbz      x8, #0x4ef9998
04ef9980  ldr      x9, [x8, #0x10]
04ef9984  mov      w10, w9
04ef9988  cmp      x9, x0
04ef998c  mov      w9, #-0x22222223
04ef9990  ccmp     x10, x9, #4, eq
04ef9994  b.ne     #0x4ef99b4
04ef9998  mov      x1, #0
04ef999c  bl       #0x4f98dc4
04ef99a0  mov      x1, x0
04ef99a4  str      x0, [x19, #0x1a8]
04ef99a8  add      x0, x19, #0x1a8
04ef99ac  bl       #0x2c6afb0
04ef99b0  ldr      x8, [x19, #0x1a8]
04ef99b4  mov      x0, x8
04ef99b8  ldp      x29, x30, [sp, #0x10]
04ef99bc  ldp      x20, x19, [sp], #0x20
04ef99c0  ret      
04ef99c4  str      xzr, [x19, #0x1a8]
04ef99c8  add      x0, x19, #0x1a8
04ef99cc  mov      x1, #0
04ef99d0  bl       #0x2c6afb0
04ef99d4  mov      x8, #0
04ef99d8  mov      x0, x8
04ef99dc  ldp      x29, x30, [sp, #0x10]
04ef99e0  ldp      x20, x19, [sp], #0x20
04ef99e4  ret      
