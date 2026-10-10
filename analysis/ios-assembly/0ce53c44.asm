0ce53c44  stp      x22, x21, [sp, #-0x30]!
0ce53c48  stp      x20, x19, [sp, #0x10]
0ce53c4c  stp      x29, x30, [sp, #0x20]
0ce53c50  add      x29, sp, #0x20
0ce53c54  mov      x20, x2
0ce53c58  mov      x21, x1
0ce53c5c  mov      x19, x0
0ce53c60  adrp     x22, #0x10ac1000
0ce53c64  ldrb     w8, [x22, #0x493]
0ce53c68  tbnz     w8, #0, #0xce53ca4
0ce53c6c  adrp     x0, #0x10637000
0ce53c70  add      x0, x0, #0xc38
0ce53c74  bl       #0x7c0bcac
0ce53c78  adrp     x0, #0x10637000
0ce53c7c  add      x0, x0, #0xc10
0ce53c80  bl       #0x7c0bcac
0ce53c84  adrp     x0, #0x105e7000
0ce53c88  add      x0, x0, #0xbf8
0ce53c8c  bl       #0x7c0bcac
0ce53c90  adrp     x0, #0x10604000
0ce53c94  add      x0, x0, #0x3b8
0ce53c98  bl       #0x7c0bcac
0ce53c9c  mov      w8, #1
0ce53ca0  strb     w8, [x22, #0x493]
0ce53ca4  ldr      x8, [x20, #0x20]
0ce53ca8  ldr      x0, [x8, #0xc0]
0ce53cac  mov      w1, #1
0ce53cb0  bl       #0x7c0bdb8
0ce53cb4  ldr      x8, [x0, #0xb8]
0ce53cb8  ldr      x8, [x8]
0ce53cbc  cbz      x8, #0xce53cc8
0ce53cc0  cbnz     x21, #0xce53d50
0ce53cc4  b        #0xce53dfc
0ce53cc8  adrp     x8, #0x105e7000
0ce53ccc  ldr      x0, [x8, #0xbf8]
0ce53cd0  bl       #0x7c0bd0c
0ce53cd4  mov      x22, x0
0ce53cd8  adrp     x8, #0x10637000
0ce53cdc  ldr      x8, [x8, #0xc10]
0ce53ce0  ldr      x8, [x8, #0x20]
0ce53ce4  ldr      x0, [x8, #0xc0]
0ce53ce8  mov      w1, #0
0ce53cec  bl       #0x7c0bdc4
0ce53cf0  ldr      x8, [x0, #0x20]
0ce53cf4  ldr      x0, [x8, #0xc0]
0ce53cf8  mov      w1, #3
0ce53cfc  bl       #0x7c0bdc4
0ce53d00  bl       #0xbd1a034
0ce53d04  cbz      x0, #0xce53d18
0ce53d08  mov      x0, x22
0ce53d0c  str      xzr, [x0, #0x30]!
0ce53d10  mov      x1, #0
0ce53d14  bl       #0x7c0bc80
0ce53d18  ldr      x8, [x20, #0x20]
0ce53d1c  ldr      x0, [x8, #0xc0]
0ce53d20  mov      w1, #1
0ce53d24  bl       #0x7c0bdb8
0ce53d28  ldr      x8, [x0, #0xb8]
0ce53d2c  str      x22, [x8]
0ce53d30  ldr      x8, [x20, #0x20]
0ce53d34  ldr      x0, [x8, #0xc0]
0ce53d38  mov      w1, #1
0ce53d3c  bl       #0x7c0bdb8
0ce53d40  ldr      x0, [x0, #0xb8]
0ce53d44  mov      x1, x22
0ce53d48  bl       #0x7c0bc80
0ce53d4c  cbz      x21, #0xce53dfc
0ce53d50  stp      x21, x21, [x19, #0x10]
0ce53d54  adrp     x22, #0x10604000
0ce53d58  ldr      x0, [x22, #0x3b8]
0ce53d5c  ldr      w8, [x0, #0xe0]
0ce53d60  cbz      w8, #0xce53d78
0ce53d64  ldr      x8, [x0, #0xb8]
0ce53d68  ldr      x9, [x8, #0x28]
0ce53d6c  cmp      x9, x21
0ce53d70  b.lo     #0xce53d90
0ce53d74  b        #0xce53da4
0ce53d78  bl       #0x7c0bcf0
0ce53d7c  ldr      x0, [x22, #0x3b8]
0ce53d80  ldr      x8, [x0, #0xb8]
0ce53d84  ldr      x9, [x8, #0x28]
0ce53d88  cmp      x9, x21
0ce53d8c  b.hs     #0xce53da4
0ce53d90  ldr      w9, [x0, #0xe0]
0ce53d94  cbz      w9, #0xce53de4
0ce53d98  ldr      x8, [x8, #0x20]
0ce53d9c  cmp      x8, x21
0ce53da0  b.hs     #0xce53dfc
0ce53da4  ldr      x8, [x20, #0x20]
0ce53da8  ldr      x0, [x8, #0xc0]
0ce53dac  mov      w1, #1
0ce53db0  bl       #0x7c0bdb8
0ce53db4  ldr      x8, [x0, #0xb8]
0ce53db8  ldr      x0, [x8]
0ce53dbc  cbz      x0, #0xce53e0c
0ce53dc0  ldr      x1, [x19, #0x10]
0ce53dc4  adrp     x8, #0x10637000
0ce53dc8  ldr      x4, [x8, #0xc38]
0ce53dcc  mov      x2, x19
0ce53dd0  mov      w3, #1
0ce53dd4  ldp      x29, x30, [sp, #0x20]
0ce53dd8  ldp      x20, x19, [sp, #0x10]
0ce53ddc  ldp      x22, x21, [sp], #0x30
0ce53de0  b        #0xcfe10b4
0ce53de4  bl       #0x7c0bcf0
0ce53de8  ldr      x8, [x22, #0x3b8]
0ce53dec  ldr      x8, [x8, #0xb8]
0ce53df0  ldr      x8, [x8, #0x20]
0ce53df4  cmp      x8, x21
0ce53df8  b.lo     #0xce53da4
0ce53dfc  ldp      x29, x30, [sp, #0x20]
0ce53e00  ldp      x20, x19, [sp, #0x10]
0ce53e04  ldp      x22, x21, [sp], #0x30
0ce53e08  ret      
0ce53e0c  bl       #0x7c0bd18
