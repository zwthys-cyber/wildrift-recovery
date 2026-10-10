04e80084  stp      x22, x21, [sp, #-0x30]!
04e80088  stp      x20, x19, [sp, #0x10]
04e8008c  stp      x29, x30, [sp, #0x20]
04e80090  add      x29, sp, #0x20
04e80094  mov      x19, x1
04e80098  mov      x20, x0
04e8009c  adrp     x21, #0x10a9e000
04e800a0  ldrb     w8, [x21, #0x3c1]
04e800a4  tbnz     w8, #0, #0x4e800bc
04e800a8  adrp     x0, #0x1060e000
04e800ac  add      x0, x0, #0x9c0
04e800b0  bl       #0x2c6b024
04e800b4  mov      w8, #1
04e800b8  strb     w8, [x21, #0x3c1]
04e800bc  ldr      x20, [x20, #0x10]
04e800c0  adrp     x8, #0x1060e000
04e800c4  ldr      x0, [x8, #0x9c0]
04e800c8  ldr      w8, [x0, #0xe0]
04e800cc  cbnz     w8, #0x4e800d4
04e800d0  bl       #0x2c6b180
04e800d4  mov      x0, x20
04e800d8  mov      x1, x19
04e800dc  bl       #0x7c131b0
04e800e0  cmp      w0, #0
04e800e4  cset     w0, ne
04e800e8  ldp      x29, x30, [sp, #0x20]
04e800ec  ldp      x20, x19, [sp, #0x10]
04e800f0  ldp      x22, x21, [sp], #0x30
04e800f4  ret      
