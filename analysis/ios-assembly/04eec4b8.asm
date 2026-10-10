04eec4b8  stp      x20, x19, [sp, #-0x20]!
04eec4bc  stp      x29, x30, [sp, #0x10]
04eec4c0  add      x29, sp, #0x10
04eec4c4  mov      x19, x0
04eec4c8  ldr      x8, [x0, #0x18]
04eec4cc  ldr      x8, [x8, #0xc8]
04eec4d0  cbz      x8, #0x4eec53c
04eec4d4  mov      w20, #-0x22222223
04eec4d8  ldur     x0, [x19, #0x98]
04eec4dc  cbz      x0, #0x4eec4f4
04eec4e0  ldr      x9, [x0, #0x10]
04eec4e4  mov      w10, w9
04eec4e8  cmp      x9, x8
04eec4ec  ccmp     x10, x20, #4, eq
04eec4f0  b.ne     #0x4eec51c
04eec4f4  mov      x0, x8
04eec4f8  mov      x1, #0
04eec4fc  bl       #0x4eabdf0
04eec500  mov      x1, x0
04eec504  stur     x0, [x19, #0x98]
04eec508  add      x0, x19, #0x98
04eec50c  bl       #0x2c6afb0
04eec510  ldur     x0, [x19, #0x98]
04eec514  cbz      x0, #0x4eec530
04eec518  ldr      x8, [x0, #0x10]
04eec51c  mov      w9, w8
04eec520  cmp      x8, #0
04eec524  ccmp     x9, x20, #4, ne
04eec528  b.ne     #0x4eec55c
04eec52c  mov      w0, #0
04eec530  ldp      x29, x30, [sp, #0x10]
04eec534  ldp      x20, x19, [sp], #0x20
04eec538  ret      
04eec53c  stur     xzr, [x19, #0x98]
04eec540  add      x0, x19, #0x98
04eec544  mov      x1, #0
04eec548  bl       #0x2c6afb0
04eec54c  mov      w0, #0
04eec550  ldp      x29, x30, [sp, #0x10]
04eec554  ldp      x20, x19, [sp], #0x20
04eec558  ret      
04eec55c  ldr      x9, [x19, #0x18]
04eec560  ldr      x9, [x9, #0xc8]
04eec564  cbz      x9, #0x4eec5cc
04eec568  cmp      x8, x9
04eec56c  b.eq     #0x4eec594
04eec570  mov      x0, x9
04eec574  mov      x1, #0
04eec578  bl       #0x4eabdf0
04eec57c  mov      x1, x0
04eec580  stur     x0, [x19, #0x98]
04eec584  add      x0, x19, #0x98
04eec588  bl       #0x2c6afb0
04eec58c  ldur     x0, [x19, #0x98]
04eec590  cbz      x0, #0x4eec5dc
04eec594  mov      x1, #0
04eec598  bl       #0x4eac390
04eec59c  cbz      x0, #0x4eec530
04eec5a0  ldr      x8, [x0, #0x10]
04eec5a4  cbz      x8, #0x4eec5bc
04eec5a8  cmp      x20, w8, uxtw
04eec5ac  cset     w0, ne
04eec5b0  ldp      x29, x30, [sp, #0x10]
04eec5b4  ldp      x20, x19, [sp], #0x20
04eec5b8  ret      
04eec5bc  mov      w0, #0
04eec5c0  ldp      x29, x30, [sp, #0x10]
04eec5c4  ldp      x20, x19, [sp], #0x20
04eec5c8  ret      
04eec5cc  stur     xzr, [x19, #0x98]
04eec5d0  add      x0, x19, #0x98
04eec5d4  mov      x1, #0
04eec5d8  bl       #0x2c6afb0
04eec5dc  bl       #0x2c6b2d0
