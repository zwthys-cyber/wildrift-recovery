02cdb438: stp      x20, x19, [sp, #-0x20]!
02cdb43c: stp      x29, x30, [sp, #0x10]
02cdb440: add      x29, sp, #0x10
02cdb444: cbz      x1, #0x2cdb498
02cdb448: mov      x19, x1
02cdb44c: mov      x20, x0
02cdb450: ldr      x8, [x1]
02cdb454: cbz      x8, #0x2cdb478
02cdb458: add      x0, x8, #0x20
02cdb45c: ldr      x8, [x20, #0x80]
02cdb460: ldrh     w9, [x20, #0x124]
02cdb464: add      x8, x8, x9, lsl #5
02cdb468: cmp      x8, x0
02cdb46c: b.ls     #0x2cdb498
02cdb470: str      x0, [x19]
02cdb474: b        #0x2cdb49c
02cdb478: mov      x0, x20
02cdb47c: bl       #0x2cdb4a8
02cdb480: ldrh     w8, [x20, #0x124]
02cdb484: cbz      w8, #0x2cdb498
02cdb488: ldr      x8, [x20, #0x80]
02cdb48c: str      x8, [x19]
02cdb490: ldr      x0, [x20, #0x80]
02cdb494: b        #0x2cdb49c
02cdb498: mov      x0, #0
02cdb49c: ldp      x29, x30, [sp, #0x10]
02cdb4a0: ldp      x20, x19, [sp], #0x20
02cdb4a4: ret      
