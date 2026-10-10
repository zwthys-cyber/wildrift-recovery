04ebb3d0  stp      x20, x19, [sp, #-0x20]!
04ebb3d4  stp      x29, x30, [sp, #0x10]
04ebb3d8  add      x29, sp, #0x10
04ebb3dc  mov      x19, x0
04ebb3e0  adrp     x20, #0x10b37000
04ebb3e4  ldrb     w8, [x20, #0xbbd]
04ebb3e8  tbnz     w8, #0, #0x4ebb400
04ebb3ec  adrp     x0, #0x1062f000
04ebb3f0  add      x0, x0, #0x7d0
04ebb3f4  bl       #0x2c6b024
04ebb3f8  mov      w8, #1
04ebb3fc  strb     w8, [x20, #0xbbd]
04ebb400  ldr      x8, [x19, #0x18]
04ebb404  adds     x0, x8, #0x208
04ebb408  b.eq     #0x4ebb450
04ebb40c  ldur     x8, [x19, #0xf8]
04ebb410  cbz      x8, #0x4ebb420
04ebb414  ldr      x9, [x8, #0x10]
04ebb418  cmp      x9, x0
04ebb41c  b.eq     #0x4ebb440
04ebb420  adrp     x8, #0x1062f000
04ebb424  ldr      x1, [x8, #0x7d0]
04ebb428  bl       #0xce537ec
04ebb42c  mov      x1, x0
04ebb430  stur     x0, [x19, #0xf8]
04ebb434  add      x0, x19, #0xf8
04ebb438  bl       #0x2c6afb0
04ebb43c  ldur     x8, [x19, #0xf8]
04ebb440  mov      x0, x8
04ebb444  ldp      x29, x30, [sp, #0x10]
04ebb448  ldp      x20, x19, [sp], #0x20
04ebb44c  ret      
04ebb450  stur     xzr, [x19, #0xf8]
04ebb454  add      x0, x19, #0xf8
04ebb458  mov      x1, #0
04ebb45c  bl       #0x2c6afb0
04ebb460  mov      x8, #0
04ebb464  mov      x0, x8
04ebb468  ldp      x29, x30, [sp, #0x10]
04ebb46c  ldp      x20, x19, [sp], #0x20
04ebb470  ret      
