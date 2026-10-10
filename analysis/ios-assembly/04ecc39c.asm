04ecc39c  stp      x20, x19, [sp, #-0x20]!
04ecc3a0  stp      x29, x30, [sp, #0x10]
04ecc3a4  add      x29, sp, #0x10
04ecc3a8  mov      x19, x0
04ecc3ac  adrp     x20, #0x10b37000
04ecc3b0  ldrb     w8, [x20, #0xbce]
04ecc3b4  tbnz     w8, #0, #0x4ecc3d8
04ecc3b8  adrp     x0, #0x106c7000
04ecc3bc  add      x0, x0, #0x50
04ecc3c0  bl       #0x2c6b024
04ecc3c4  adrp     x0, #0x10619000
04ecc3c8  add      x0, x0, #0xce0
04ecc3cc  bl       #0x2c6b024
04ecc3d0  mov      w8, #1
04ecc3d4  strb     w8, [x20, #0xbce]
04ecc3d8  ldr      x8, [x19, #0x18]
04ecc3dc  ldr      x20, [x8, #0x108]
04ecc3e0  cbz      x20, #0x4ecc448
04ecc3e4  ldr      x0, [x19, #0x30]!
04ecc3e8  cbz      x0, #0x4ecc404
04ecc3ec  ldr      x8, [x0, #0x10]
04ecc3f0  mov      w9, w8
04ecc3f4  cmp      x8, x20
04ecc3f8  mov      w8, #-0x22222223
04ecc3fc  ccmp     x9, x8, #4, eq
04ecc400  b.ne     #0x4ecc43c
04ecc404  adrp     x8, #0x10619000
04ecc408  ldr      x0, [x8, #0xce0]
04ecc40c  ldr      w8, [x0, #0xe0]
04ecc410  cbnz     w8, #0x4ecc418
04ecc414  bl       #0x2c6b180
04ecc418  adrp     x8, #0x106c7000
04ecc41c  ldr      x1, [x8, #0x50]
04ecc420  mov      x0, x20
04ecc424  bl       #0xbf10d48
04ecc428  mov      x1, x0
04ecc42c  str      x0, [x19]
04ecc430  mov      x0, x19
04ecc434  bl       #0x2c6afb0
04ecc438  ldr      x0, [x19]
04ecc43c  ldp      x29, x30, [sp, #0x10]
04ecc440  ldp      x20, x19, [sp], #0x20
04ecc444  ret      
04ecc448  str      xzr, [x19, #0x30]!
04ecc44c  mov      x0, x19
04ecc450  mov      x1, #0
04ecc454  bl       #0x2c6afb0
04ecc458  mov      x0, #0
04ecc45c  ldp      x29, x30, [sp, #0x10]
04ecc460  ldp      x20, x19, [sp], #0x20
04ecc464  ret      
