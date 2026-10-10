0512d290  sub      sp, sp, #0x40
0512d294  stp      x22, x21, [sp, #0x10]
0512d298  stp      x20, x19, [sp, #0x20]
0512d29c  stp      x29, x30, [sp, #0x30]
0512d2a0  add      x29, sp, #0x30
0512d2a4  mov      x19, x0
0512d2a8  adrp     x20, #0x10a9f000
0512d2ac  ldrb     w8, [x20, #0x976]
0512d2b0  tbz      w8, #0, #0x512d318
0512d2b4  adrp     x21, #0x10616000
0512d2b8  ldr      x8, [x21, #0xb70]
0512d2bc  ldr      x8, [x8, #0xb8]
0512d2c0  ldr      x8, [x8]
0512d2c4  cbz      x8, #0x512d394
0512d2c8  cbz      x19, #0x512d404
0512d2cc  mov      w8, #-0x22222223
0512d2d0  cmp      w19, w8
0512d2d4  b.ne     #0x512d420
0512d2d8  adrp     x8, #0x1061c000
0512d2dc  ldr      x0, [x8, #0x5b0]
0512d2e0  ldr      w8, [x0, #0xe0]
0512d2e4  cbnz     w8, #0x512d2ec
0512d2e8  bl       #0x2c6b180
0512d2ec  adrp     x8, #0x1071e000
0512d2f0  ldr      x0, [x8, #0xd30]
0512d2f4  mov      x1, #0
0512d2f8  bl       #0x98461e4
0512d2fc  mov      x20, #0
0512d300  mov      x0, x20
0512d304  ldp      x29, x30, [sp, #0x30]
0512d308  ldp      x20, x19, [sp, #0x20]
0512d30c  ldp      x22, x21, [sp, #0x10]
0512d310  add      sp, sp, #0x40
0512d314  ret      
0512d318  adrp     x0, #0x10637000
0512d31c  add      x0, x0, #0xc30
0512d320  bl       #0x2c6b024
0512d324  adrp     x0, #0x10637000
0512d328  add      x0, x0, #0xc38
0512d32c  bl       #0x2c6b024
0512d330  adrp     x0, #0x10637000
0512d334  add      x0, x0, #0xc10
0512d338  bl       #0x2c6b024
0512d33c  adrp     x0, #0x105e7000
0512d340  add      x0, x0, #0xbf8
0512d344  bl       #0x2c6b024
0512d348  adrp     x0, #0x10616000
0512d34c  add      x0, x0, #0xb70
0512d350  bl       #0x2c6b024
0512d354  adrp     x0, #0x1065b000
0512d358  add      x0, x0, #0x878
0512d35c  bl       #0x2c6b024
0512d360  adrp     x0, #0x1061c000
0512d364  add      x0, x0, #0x5b0
0512d368  bl       #0x2c6b024
0512d36c  adrp     x0, #0x1071e000
0512d370  add      x0, x0, #0xd30
0512d374  bl       #0x2c6b024
0512d378  mov      w8, #1
0512d37c  strb     w8, [x20, #0x976]
0512d380  adrp     x21, #0x10616000
0512d384  ldr      x8, [x21, #0xb70]
0512d388  ldr      x8, [x8, #0xb8]
0512d38c  ldr      x8, [x8]
0512d390  cbnz     x8, #0x512d2c8
0512d394  adrp     x8, #0x105e7000
0512d398  ldr      x0, [x8, #0xbf8]
0512d39c  bl       #0x2c6b2bc
0512d3a0  mov      x20, x0
0512d3a4  adrp     x8, #0x10637000
0512d3a8  ldr      x8, [x8, #0xc10]
0512d3ac  ldr      x8, [x8, #0x20]
0512d3b0  ldr      x0, [x8, #0xc0]
0512d3b4  mov      w1, #0
0512d3b8  bl       #0x2c6bf40
0512d3bc  ldr      x8, [x0, #0x20]
0512d3c0  ldr      x0, [x8, #0xc0]
0512d3c4  mov      w1, #3
0512d3c8  bl       #0x2c6bf40
0512d3cc  bl       #0xbd1a034
0512d3d0  cbz      x0, #0x512d3e4
0512d3d4  mov      x0, x20
0512d3d8  str      xzr, [x0, #0x30]!
0512d3dc  mov      x1, #0
0512d3e0  bl       #0x2c6afb0
0512d3e4  ldr      x8, [x21, #0xb70]
0512d3e8  ldr      x8, [x8, #0xb8]
0512d3ec  str      x20, [x8]
0512d3f0  ldr      x8, [x21, #0xb70]
0512d3f4  ldr      x0, [x8, #0xb8]
0512d3f8  mov      x1, x20
0512d3fc  bl       #0x2c6afb0
0512d400  cbnz     x19, #0x512d2cc
0512d404  mov      x20, #0
0512d408  mov      x0, x20
0512d40c  ldp      x29, x30, [sp, #0x30]
0512d410  ldp      x20, x19, [sp, #0x20]
0512d414  ldp      x22, x21, [sp, #0x10]
0512d418  add      sp, sp, #0x40
0512d41c  ret      
0512d420  ldr      x8, [x21, #0xb70]
0512d424  ldr      x8, [x8, #0xb8]
0512d428  ldr      x20, [x8]
0512d42c  cbz      x20, #0x512d560
0512d430  adrp     x8, #0x10637000
0512d434  ldr      x8, [x8, #0xc30]
0512d438  ldr      x8, [x8, #0x20]
0512d43c  ldr      x0, [x8, #0xc0]
0512d440  mov      w1, #0x1f
0512d444  bl       #0x2c6bf40
0512d448  mov      x2, x0
0512d44c  mov      x0, x20
0512d450  mov      x1, x19
0512d454  bl       #0xcfe0cb8
0512d458  tbnz     w0, #0x1f, #0x512d4b0
0512d45c  ldr      x8, [x20, #0x18]
0512d460  cbz      x8, #0x512d560
0512d464  ldr      w9, [x8, #0x18]
0512d468  cmp      w0, w9
0512d46c  b.hs     #0x512d564
0512d470  mov      w9, #0x18
0512d474  umaddl   x8, w0, w9, x8
0512d478  ldr      x1, [x8, #0x30]
0512d47c  str      x1, [sp, #8]
0512d480  add      x0, sp, #8
0512d484  bl       #0x2c6afb0
0512d488  ldr      x20, [sp, #8]
0512d48c  ldr      x0, [x21, #0xb70]
0512d490  cbz      x20, #0x512d4a0
0512d494  ldr      x9, [x20]
0512d498  cmp      x9, x0
0512d49c  b.eq     #0x512d300
0512d4a0  ldr      x8, [x0, #0xb8]
0512d4a4  ldr      x8, [x8, #8]
0512d4a8  cbnz     x8, #0x512d4c4
0512d4ac  b        #0x512d538
0512d4b0  str      xzr, [sp, #8]
0512d4b4  ldr      x0, [x21, #0xb70]
0512d4b8  ldr      x8, [x0, #0xb8]
0512d4bc  ldr      x8, [x8, #8]
0512d4c0  cbz      x8, #0x512d538
0512d4c4  ldr      w9, [x8, #0x18]
0512d4c8  cmp      w9, #1
0512d4cc  b.lt     #0x512d538
0512d4d0  adrp     x9, #0x1065b000
0512d4d4  ldr      x1, [x9, #0x878]
0512d4d8  mov      x0, x8
0512d4dc  bl       #0xca107e4
0512d4e0  cbz      x0, #0x512d560
0512d4e4  ldr      x9, [x21, #0xb70]
0512d4e8  ldr      x8, [x0]
0512d4ec  cmp      x8, x9
0512d4f0  b.ne     #0x512d560
0512d4f4  stp      x19, x19, [x0, #0x10]
0512d4f8  mov      x20, x0
0512d4fc  ldr      x9, [x9, #0xb8]
0512d500  ldr      x0, [x9]
0512d504  cbz      x0, #0x512d560
0512d508  adrp     x9, #0x10637000
0512d50c  ldr      x4, [x9, #0xc38]
0512d510  mov      x1, x19
0512d514  mov      x2, x20
0512d518  mov      w3, #1
0512d51c  bl       #0xcfe10b4
0512d520  mov      x0, x20
0512d524  ldp      x29, x30, [sp, #0x30]
0512d528  ldp      x20, x19, [sp, #0x20]
0512d52c  ldp      x22, x21, [sp, #0x10]
0512d530  add      sp, sp, #0x40
0512d534  ret      
0512d538  bl       #0x2c6b2bc
0512d53c  mov      x20, x0
0512d540  mov      x1, x19
0512d544  bl       #0x512d568
0512d548  mov      x0, x20
0512d54c  ldp      x29, x30, [sp, #0x30]
0512d550  ldp      x20, x19, [sp, #0x20]
0512d554  ldp      x22, x21, [sp, #0x10]
0512d558  add      sp, sp, #0x40
0512d55c  ret      
0512d560  bl       #0x2c6b2d0
0512d564  bl       #0x2c6b2dc
