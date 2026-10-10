04ecc764  stp      x20, x19, [sp, #-0x20]!
04ecc768  stp      x29, x30, [sp, #0x10]
04ecc76c  add      x29, sp, #0x10
04ecc770  mov      x19, x0
04ecc774  ldr      x8, [x0, #0x18]
04ecc778  adds     x0, x8, #0x420
04ecc77c  b.eq     #0x4ecc7cc
04ecc780  ldur     x8, [x19, #0x60]
04ecc784  cbz      x8, #0x4ecc7a0
04ecc788  ldr      x9, [x8, #0x10]
04ecc78c  mov      w10, w9
04ecc790  cmp      x9, x0
04ecc794  mov      w9, #-0x22222223
04ecc798  ccmp     x10, x9, #4, eq
04ecc79c  b.ne     #0x4ecc7bc
04ecc7a0  mov      x1, #0
04ecc7a4  bl       #0x512d290
04ecc7a8  mov      x1, x0
04ecc7ac  stur     x0, [x19, #0x60]
04ecc7b0  add      x0, x19, #0x60
04ecc7b4  bl       #0x2c6afb0
04ecc7b8  ldur     x8, [x19, #0x60]
04ecc7bc  mov      x0, x8
04ecc7c0  ldp      x29, x30, [sp, #0x10]
04ecc7c4  ldp      x20, x19, [sp], #0x20
04ecc7c8  ret      
04ecc7cc  stur     xzr, [x19, #0x60]
04ecc7d0  add      x0, x19, #0x60
04ecc7d4  mov      x1, #0
04ecc7d8  bl       #0x2c6afb0
04ecc7dc  mov      x8, #0
04ecc7e0  mov      x0, x8
04ecc7e4  ldp      x29, x30, [sp, #0x10]
04ecc7e8  ldp      x20, x19, [sp], #0x20
04ecc7ec  ret      
