04ef9844: stp      x20, x19, [sp, #-0x20]!
04ef9848: stp      x29, x30, [sp, #0x10]
04ef984c: add      x29, sp, #0x10
04ef9850: mov      x19, x0
04ef9854: ldr      x8, [x0, #0x18]
04ef9858: ldr      x0, [x8, #0x170]
04ef985c: cbz      x0, #0x4ef98ac
04ef9860: ldr      x8, [x19, #0x198]
04ef9864: cbz      x8, #0x4ef9880
04ef9868: ldr      x9, [x8, #0x10]
04ef986c: mov      w10, w9
04ef9870: cmp      x9, x0
04ef9874: mov      w9, #-0x22222223
04ef9878: ccmp     x10, x9, #4, eq
04ef987c: b.ne     #0x4ef989c
04ef9880: mov      x1, #0
04ef9884: bl       #0x4fa5d98
04ef9888: mov      x1, x0
04ef988c: str      x0, [x19, #0x198]
04ef9890: add      x0, x19, #0x198
04ef9894: bl       #0x2c6afb0
04ef9898: ldr      x8, [x19, #0x198]
04ef989c: mov      x0, x8
04ef98a0: ldp      x29, x30, [sp, #0x10]
04ef98a4: ldp      x20, x19, [sp], #0x20
04ef98a8: ret      
04ef98ac: str      xzr, [x19, #0x198]
04ef98b0: add      x0, x19, #0x198
04ef98b4: mov      x1, #0
04ef98b8: bl       #0x2c6afb0
04ef98bc: mov      x8, #0
04ef98c0: mov      x0, x8
04ef98c4: ldp      x29, x30, [sp, #0x10]
04ef98c8: ldp      x20, x19, [sp], #0x20
04ef98cc: ret      
