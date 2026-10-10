0515d554  stp      x20, x19, [sp, #-0x20]!
0515d558  stp      x29, x30, [sp, #0x10]
0515d55c  add      x29, sp, #0x10
0515d560  mov      x19, x0
0515d564  adrp     x20, #0x10b37000
0515d568  ldrb     w8, [x20, #0xc8b]
0515d56c  tbnz     w8, #0, #0x515d584
0515d570  adrp     x0, #0x1062f000
0515d574  add      x0, x0, #0x7d0
0515d578  bl       #0x2c6b024
0515d57c  mov      w8, #1
0515d580  strb     w8, [x20, #0xc8b]
0515d584  ldr      x8, [x19, #0x18]
0515d588  adds     x0, x8, #0x18
0515d58c  b.eq     #0x515d5d4
0515d590  ldur     x8, [x19, #0x20]
0515d594  cbz      x8, #0x515d5a4
0515d598  ldr      x9, [x8, #0x10]
0515d59c  cmp      x9, x0
0515d5a0  b.eq     #0x515d5c4
0515d5a4  adrp     x8, #0x1062f000
0515d5a8  ldr      x1, [x8, #0x7d0]
0515d5ac  bl       #0xce537ec
0515d5b0  mov      x1, x0
0515d5b4  stur     x0, [x19, #0x20]
0515d5b8  add      x0, x19, #0x20
0515d5bc  bl       #0x2c6afb0
0515d5c0  ldur     x8, [x19, #0x20]
0515d5c4  mov      x0, x8
0515d5c8  ldp      x29, x30, [sp, #0x10]
0515d5cc  ldp      x20, x19, [sp], #0x20
0515d5d0  ret      
0515d5d4  stur     xzr, [x19, #0x20]
0515d5d8  add      x0, x19, #0x20
0515d5dc  mov      x1, #0
0515d5e0  bl       #0x2c6afb0
0515d5e4  mov      x8, #0
0515d5e8  mov      x0, x8
0515d5ec  ldp      x29, x30, [sp, #0x10]
0515d5f0  ldp      x20, x19, [sp], #0x20
0515d5f4  ret      
