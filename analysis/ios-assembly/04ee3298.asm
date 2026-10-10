04ee3298: stp      x20, x19, [sp, #-0x20]!
04ee329c: stp      x29, x30, [sp, #0x10]
04ee32a0: add      x29, sp, #0x10
04ee32a4: mov      x19, x0
04ee32a8: ldr      x8, [x0, #0x18]
04ee32ac: adds     x0, x8, #0x138
04ee32b0: b.eq     #0x4ee3300
04ee32b4: ldur     x8, [x19, #0x70]
04ee32b8: cbz      x8, #0x4ee32d4
04ee32bc: ldr      x9, [x8, #0x10]
04ee32c0: mov      w10, w9
04ee32c4: cmp      x9, x0
04ee32c8: mov      w9, #-0x22222223
04ee32cc: ccmp     x10, x9, #4, eq
04ee32d0: b.ne     #0x4ee32f0
04ee32d4: mov      x1, #0
04ee32d8: bl       #0x4ec8cb4
04ee32dc: mov      x1, x0
04ee32e0: stur     x0, [x19, #0x70]
04ee32e4: add      x0, x19, #0x70
04ee32e8: bl       #0x2c6afb0
04ee32ec: ldur     x8, [x19, #0x70]
04ee32f0: mov      x0, x8
04ee32f4: ldp      x29, x30, [sp, #0x10]
04ee32f8: ldp      x20, x19, [sp], #0x20
04ee32fc: ret      
04ee3300: stur     xzr, [x19, #0x70]
04ee3304: add      x0, x19, #0x70
04ee3308: mov      x1, #0
04ee330c: bl       #0x2c6afb0
04ee3310: mov      x8, #0
04ee3314: mov      x0, x8
04ee3318: ldp      x29, x30, [sp, #0x10]
04ee331c: ldp      x20, x19, [sp], #0x20
04ee3320: ret      
