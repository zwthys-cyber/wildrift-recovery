04eee6e8  stp      x20, x19, [sp, #-0x20]!
04eee6ec  stp      x29, x30, [sp, #0x10]
04eee6f0  add      x29, sp, #0x10
04eee6f4  mov      x19, x0
04eee6f8  adrp     x20, #0x10a9e000
04eee6fc  ldrb     w8, [x20, #0x7cd]
04eee700  tbnz     w8, #0, #0x4eee718
04eee704  adrp     x0, #0x1060e000
04eee708  add      x0, x0, #0x9c0
04eee70c  bl       #0x2c6b024
04eee710  mov      w8, #1
04eee714  strb     w8, [x20, #0x7cd]
04eee718  ldr      x19, [x19, #0x10]
04eee71c  adrp     x8, #0x1060e000
04eee720  ldr      x0, [x8, #0x9c0]
04eee724  ldr      w8, [x0, #0xe0]
04eee728  cbnz     w8, #0x4eee730
04eee72c  bl       #0x2c6b180
04eee730  mov      x0, x19
04eee734  bl       #0x7c12ad8
04eee738  cmp      w0, #0
04eee73c  cset     w0, ne
04eee740  ldp      x29, x30, [sp, #0x10]
04eee744  ldp      x20, x19, [sp], #0x20
04eee748  ret      
