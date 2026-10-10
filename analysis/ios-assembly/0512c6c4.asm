0512c6c4  sub      sp, sp, #0x40
0512c6c8  stp      x22, x21, [sp, #0x10]
0512c6cc  stp      x20, x19, [sp, #0x20]
0512c6d0  stp      x29, x30, [sp, #0x30]
0512c6d4  add      x29, sp, #0x30
0512c6d8  mov      x19, x0
0512c6dc  adrp     x20, #0x10a9f000
0512c6e0  ldrb     w8, [x20, #0x96d]
0512c6e4  tbz      w8, #0, #0x512c74c
0512c6e8  adrp     x21, #0x10616000
0512c6ec  ldr      x8, [x21, #0xb58]
0512c6f0  ldr      x8, [x8, #0xb8]
0512c6f4  ldr      x8, [x8]
0512c6f8  cbz      x8, #0x512c7c8
0512c6fc  cbz      x19, #0x512c838
0512c700  mov      w8, #-0x22222223
0512c704  cmp      w19, w8
0512c708  b.ne     #0x512c854
0512c70c  adrp     x8, #0x1061c000
0512c710  ldr      x0, [x8, #0x5b0]
0512c714  ldr      w8, [x0, #0xe0]
0512c718  cbnz     w8, #0x512c720
0512c71c  bl       #0x2c6b180
0512c720  adrp     x8, #0x1071e000
0512c724  ldr      x0, [x8, #0xd28]
0512c728  mov      x1, #0
0512c72c  bl       #0x98461e4
0512c730  mov      x20, #0
0512c734  mov      x0, x20
0512c738  ldp      x29, x30, [sp, #0x30]
0512c73c  ldp      x20, x19, [sp, #0x20]
0512c740  ldp      x22, x21, [sp, #0x10]
0512c744  add      sp, sp, #0x40
0512c748  ret      
0512c74c  adrp     x0, #0x10637000
0512c750  add      x0, x0, #0xc30
0512c754  bl       #0x2c6b024
0512c758  adrp     x0, #0x10637000
0512c75c  add      x0, x0, #0xc38
0512c760  bl       #0x2c6b024
0512c764  adrp     x0, #0x10637000
0512c768  add      x0, x0, #0xc10
0512c76c  bl       #0x2c6b024
0512c770  adrp     x0, #0x105e7000
0512c774  add      x0, x0, #0xbf8
0512c778  bl       #0x2c6b024
0512c77c  adrp     x0, #0x10616000
0512c780  add      x0, x0, #0xb58
0512c784  bl       #0x2c6b024
0512c788  adrp     x0, #0x1065b000
0512c78c  add      x0, x0, #0x878
0512c790  bl       #0x2c6b024
0512c794  adrp     x0, #0x1061c000
0512c798  add      x0, x0, #0x5b0
0512c79c  bl       #0x2c6b024
0512c7a0  adrp     x0, #0x1071e000
0512c7a4  add      x0, x0, #0xd28
0512c7a8  bl       #0x2c6b024
0512c7ac  mov      w8, #1
0512c7b0  strb     w8, [x20, #0x96d]
0512c7b4  adrp     x21, #0x10616000
0512c7b8  ldr      x8, [x21, #0xb58]
0512c7bc  ldr      x8, [x8, #0xb8]
0512c7c0  ldr      x8, [x8]
0512c7c4  cbnz     x8, #0x512c6fc
0512c7c8  adrp     x8, #0x105e7000
0512c7cc  ldr      x0, [x8, #0xbf8]
0512c7d0  bl       #0x2c6b2bc
0512c7d4  mov      x20, x0
0512c7d8  adrp     x8, #0x10637000
0512c7dc  ldr      x8, [x8, #0xc10]
0512c7e0  ldr      x8, [x8, #0x20]
0512c7e4  ldr      x0, [x8, #0xc0]
0512c7e8  mov      w1, #0
0512c7ec  bl       #0x2c6bf40
0512c7f0  ldr      x8, [x0, #0x20]
0512c7f4  ldr      x0, [x8, #0xc0]
0512c7f8  mov      w1, #3
0512c7fc  bl       #0x2c6bf40
0512c800  bl       #0xbd1a034
0512c804  cbz      x0, #0x512c818
0512c808  mov      x0, x20
0512c80c  str      xzr, [x0, #0x30]!
0512c810  mov      x1, #0
0512c814  bl       #0x2c6afb0
0512c818  ldr      x8, [x21, #0xb58]
0512c81c  ldr      x8, [x8, #0xb8]
0512c820  str      x20, [x8]
0512c824  ldr      x8, [x21, #0xb58]
0512c828  ldr      x0, [x8, #0xb8]
0512c82c  mov      x1, x20
0512c830  bl       #0x2c6afb0
0512c834  cbnz     x19, #0x512c700
0512c838  mov      x20, #0
0512c83c  mov      x0, x20
0512c840  ldp      x29, x30, [sp, #0x30]
0512c844  ldp      x20, x19, [sp, #0x20]
0512c848  ldp      x22, x21, [sp, #0x10]
0512c84c  add      sp, sp, #0x40
0512c850  ret      
0512c854  ldr      x8, [x21, #0xb58]
0512c858  ldr      x8, [x8, #0xb8]
0512c85c  ldr      x20, [x8]
0512c860  cbz      x20, #0x512c994
0512c864  adrp     x8, #0x10637000
0512c868  ldr      x8, [x8, #0xc30]
0512c86c  ldr      x8, [x8, #0x20]
0512c870  ldr      x0, [x8, #0xc0]
0512c874  mov      w1, #0x1f
0512c878  bl       #0x2c6bf40
0512c87c  mov      x2, x0
0512c880  mov      x0, x20
0512c884  mov      x1, x19
0512c888  bl       #0xcfe0cb8
0512c88c  tbnz     w0, #0x1f, #0x512c8e4
0512c890  ldr      x8, [x20, #0x18]
0512c894  cbz      x8, #0x512c994
0512c898  ldr      w9, [x8, #0x18]
0512c89c  cmp      w0, w9
0512c8a0  b.hs     #0x512c998
0512c8a4  mov      w9, #0x18
0512c8a8  umaddl   x8, w0, w9, x8
0512c8ac  ldr      x1, [x8, #0x30]
0512c8b0  str      x1, [sp, #8]
0512c8b4  add      x0, sp, #8
0512c8b8  bl       #0x2c6afb0
0512c8bc  ldr      x20, [sp, #8]
0512c8c0  ldr      x0, [x21, #0xb58]
0512c8c4  cbz      x20, #0x512c8d4
0512c8c8  ldr      x9, [x20]
0512c8cc  cmp      x9, x0
0512c8d0  b.eq     #0x512c734
0512c8d4  ldr      x8, [x0, #0xb8]
0512c8d8  ldr      x8, [x8, #8]
0512c8dc  cbnz     x8, #0x512c8f8
0512c8e0  b        #0x512c96c
0512c8e4  str      xzr, [sp, #8]
0512c8e8  ldr      x0, [x21, #0xb58]
0512c8ec  ldr      x8, [x0, #0xb8]
0512c8f0  ldr      x8, [x8, #8]
0512c8f4  cbz      x8, #0x512c96c
0512c8f8  ldr      w9, [x8, #0x18]
0512c8fc  cmp      w9, #1
0512c900  b.lt     #0x512c96c
0512c904  adrp     x9, #0x1065b000
0512c908  ldr      x1, [x9, #0x878]
0512c90c  mov      x0, x8
0512c910  bl       #0xca107e4
0512c914  cbz      x0, #0x512c994
0512c918  ldr      x9, [x21, #0xb58]
0512c91c  ldr      x8, [x0]
0512c920  cmp      x8, x9
0512c924  b.ne     #0x512c994
0512c928  stp      x19, x19, [x0, #0x10]
0512c92c  mov      x20, x0
0512c930  ldr      x9, [x9, #0xb8]
0512c934  ldr      x0, [x9]
0512c938  cbz      x0, #0x512c994
0512c93c  adrp     x9, #0x10637000
0512c940  ldr      x4, [x9, #0xc38]
0512c944  mov      x1, x19
0512c948  mov      x2, x20
0512c94c  mov      w3, #1
0512c950  bl       #0xcfe10b4
0512c954  mov      x0, x20
0512c958  ldp      x29, x30, [sp, #0x30]
0512c95c  ldp      x20, x19, [sp, #0x20]
0512c960  ldp      x22, x21, [sp, #0x10]
0512c964  add      sp, sp, #0x40
0512c968  ret      
0512c96c  bl       #0x2c6b2bc
0512c970  mov      x20, x0
0512c974  mov      x1, x19
0512c978  bl       #0x512c99c
0512c97c  mov      x0, x20
0512c980  ldp      x29, x30, [sp, #0x30]
0512c984  ldp      x20, x19, [sp, #0x20]
0512c988  ldp      x22, x21, [sp, #0x10]
0512c98c  add      sp, sp, #0x40
0512c990  ret      
0512c994  bl       #0x2c6b2d0
0512c998  bl       #0x2c6b2dc
