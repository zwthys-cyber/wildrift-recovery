05146ca4  stp      x20, x19, [sp, #-0x20]!
05146ca8  stp      x29, x30, [sp, #0x10]
05146cac  add      x29, sp, #0x10
05146cb0  mov      x19, x0
05146cb4  adrp     x20, #0x10b37000
05146cb8  ldrb     w8, [x20, #0xc82]
05146cbc  tbnz     w8, #0, #0x5146ce0
05146cc0  adrp     x0, #0x106c6000
05146cc4  add      x0, x0, #0xf90
05146cc8  bl       #0x2c6b024
05146ccc  adrp     x0, #0x10619000
05146cd0  add      x0, x0, #0xce0
05146cd4  bl       #0x2c6b024
05146cd8  mov      w8, #1
05146cdc  strb     w8, [x20, #0xc82]
05146ce0  ldr      x8, [x19, #0x18]
05146ce4  ldr      x20, [x8, #0x98]
05146ce8  cbz      x20, #0x5146d50
05146cec  ldr      x0, [x19, #0x38]!
05146cf0  cbz      x0, #0x5146d0c
05146cf4  ldr      x8, [x0, #0x10]
05146cf8  mov      w9, w8
05146cfc  cmp      x8, x20
05146d00  mov      w8, #-0x22222223
05146d04  ccmp     x9, x8, #4, eq
05146d08  b.ne     #0x5146d44
05146d0c  adrp     x8, #0x10619000
05146d10  ldr      x0, [x8, #0xce0]
05146d14  ldr      w8, [x0, #0xe0]
05146d18  cbnz     w8, #0x5146d20
05146d1c  bl       #0x2c6b180
05146d20  adrp     x8, #0x106c6000
05146d24  ldr      x1, [x8, #0xf90]
05146d28  mov      x0, x20
05146d2c  bl       #0xbf10d48
05146d30  mov      x1, x0
05146d34  str      x0, [x19]
05146d38  mov      x0, x19
05146d3c  bl       #0x2c6afb0
05146d40  ldr      x0, [x19]
05146d44  ldp      x29, x30, [sp, #0x10]
05146d48  ldp      x20, x19, [sp], #0x20
05146d4c  ret      
05146d50  str      xzr, [x19, #0x38]!
05146d54  mov      x0, x19
05146d58  mov      x1, #0
05146d5c  bl       #0x2c6afb0
05146d60  mov      x0, #0
05146d64  ldp      x29, x30, [sp, #0x10]
05146d68  ldp      x20, x19, [sp], #0x20
05146d6c  ret      
