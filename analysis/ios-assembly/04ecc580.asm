04ecc580  stp      x20, x19, [sp, #-0x20]!
04ecc584  stp      x29, x30, [sp, #0x10]
04ecc588  add      x29, sp, #0x10
04ecc58c  mov      x19, x0
04ecc590  adrp     x20, #0x10b37000
04ecc594  ldrb     w8, [x20, #0xbcf]
04ecc598  tbnz     w8, #0, #0x4ecc5bc
04ecc59c  adrp     x0, #0x106c7000
04ecc5a0  add      x0, x0, #0x58
04ecc5a4  bl       #0x2c6b024
04ecc5a8  adrp     x0, #0x10619000
04ecc5ac  add      x0, x0, #0xce0
04ecc5b0  bl       #0x2c6b024
04ecc5b4  mov      w8, #1
04ecc5b8  strb     w8, [x20, #0xbcf]
04ecc5bc  ldr      x8, [x19, #0x18]
04ecc5c0  ldr      x20, [x8, #0x1d0]
04ecc5c4  cbz      x20, #0x4ecc62c
04ecc5c8  ldr      x0, [x19, #0x48]!
04ecc5cc  cbz      x0, #0x4ecc5e8
04ecc5d0  ldr      x8, [x0, #0x10]
04ecc5d4  mov      w9, w8
04ecc5d8  cmp      x8, x20
04ecc5dc  mov      w8, #-0x22222223
04ecc5e0  ccmp     x9, x8, #4, eq
04ecc5e4  b.ne     #0x4ecc620
04ecc5e8  adrp     x8, #0x10619000
04ecc5ec  ldr      x0, [x8, #0xce0]
04ecc5f0  ldr      w8, [x0, #0xe0]
04ecc5f4  cbnz     w8, #0x4ecc5fc
04ecc5f8  bl       #0x2c6b180
04ecc5fc  adrp     x8, #0x106c7000
04ecc600  ldr      x1, [x8, #0x58]
04ecc604  mov      x0, x20
04ecc608  bl       #0xbf10d48
04ecc60c  mov      x1, x0
04ecc610  str      x0, [x19]
04ecc614  mov      x0, x19
04ecc618  bl       #0x2c6afb0
04ecc61c  ldr      x0, [x19]
04ecc620  ldp      x29, x30, [sp, #0x10]
04ecc624  ldp      x20, x19, [sp], #0x20
04ecc628  ret      
04ecc62c  str      xzr, [x19, #0x48]!
04ecc630  mov      x0, x19
04ecc634  mov      x1, #0
04ecc638  bl       #0x2c6afb0
04ecc63c  mov      x0, #0
04ecc640  ldp      x29, x30, [sp, #0x10]
04ecc644  ldp      x20, x19, [sp], #0x20
04ecc648  ret      
