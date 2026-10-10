04ecc894  stp      x20, x19, [sp, #-0x20]!
04ecc898  stp      x29, x30, [sp, #0x10]
04ecc89c  add      x29, sp, #0x10
04ecc8a0  mov      x19, x0
04ecc8a4  ldr      x8, [x0, #0x18]
04ecc8a8  adds     x0, x8, #0x498
04ecc8ac  b.eq     #0x4ecc8fc
04ecc8b0  ldur     x8, [x19, #0x70]
04ecc8b4  cbz      x8, #0x4ecc8d0
04ecc8b8  ldr      x9, [x8, #0x10]
04ecc8bc  mov      w10, w9
04ecc8c0  cmp      x9, x0
04ecc8c4  mov      w9, #-0x22222223
04ecc8c8  ccmp     x10, x9, #4, eq
04ecc8cc  b.ne     #0x4ecc8ec
04ecc8d0  mov      x1, #0
04ecc8d4  bl       #0x5149c30
04ecc8d8  mov      x1, x0
04ecc8dc  stur     x0, [x19, #0x70]
04ecc8e0  add      x0, x19, #0x70
04ecc8e4  bl       #0x2c6afb0
04ecc8e8  ldur     x8, [x19, #0x70]
04ecc8ec  mov      x0, x8
04ecc8f0  ldp      x29, x30, [sp, #0x10]
04ecc8f4  ldp      x20, x19, [sp], #0x20
04ecc8f8  ret      
04ecc8fc  stur     xzr, [x19, #0x70]
04ecc900  add      x0, x19, #0x70
04ecc904  mov      x1, #0
04ecc908  bl       #0x2c6afb0
04ecc90c  mov      x8, #0
04ecc910  mov      x0, x8
04ecc914  ldp      x29, x30, [sp, #0x10]
04ecc918  ldp      x20, x19, [sp], #0x20
04ecc91c  ret      
