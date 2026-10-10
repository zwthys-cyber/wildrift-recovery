; Selected getter evidence from exact FEProj UUID/SHA input; no game code is invoked.
0000cb3c: stp      x22, x21, [sp, #-0x30]!
0000cb40: stp      x20, x19, [sp, #0x10]
0000cb44: stp      x29, x30, [sp, #0x20]
0000cb48: add      x29, sp, #0x20
0000cb4c: mov      x19, x2
0000cb50: mov      x20, x1
0000cb54: mov      x21, x0
0000cb58: bl       #0xd03e60
0000cb5c: cbz      x0, #0xcb90
0000cb60: bl       #0xd03e60
0000cb64: ldrb     w8, [x0, #0x1e]
0000cb68: cbz      w8, #0xcbb0
0000cb6c: cbz      x21, #0xcbd4
0000cb70: mov      x0, x21
0000cb74: mov      x1, x20
0000cb78: bl       #0xfe2a1c
0000cb7c: str      x0, [x19]
0000cb80: ldp      x29, x30, [sp, #0x20]
0000cb84: ldp      x20, x19, [sp, #0x10]
0000cb88: ldp      x22, x21, [sp], #0x30
0000cb8c: ret      
