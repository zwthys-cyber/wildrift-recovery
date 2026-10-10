04ee5ac8: stp      x20, x19, [sp, #-0x20]!
04ee5acc: stp      x29, x30, [sp, #0x10]
04ee5ad0: add      x29, sp, #0x10
04ee5ad4: mov      x19, x0
04ee5ad8: ldr      x8, [x0, #0x18]
04ee5adc: ldr      x0, [x8, #0xb0]
04ee5ae0: cbz      x0, #0x4ee5b30
04ee5ae4: ldur     x8, [x19, #0x80]
04ee5ae8: cbz      x8, #0x4ee5b04
04ee5aec: ldr      x9, [x8, #0x10]
04ee5af0: mov      w10, w9
04ee5af4: cmp      x9, x0
04ee5af8: mov      w9, #-0x22222223
04ee5afc: ccmp     x10, x9, #4, eq
04ee5b00: b.ne     #0x4ee5b20
04ee5b04: mov      x1, #0
04ee5b08: bl       #0x4f01f84
04ee5b0c: mov      x1, x0
04ee5b10: stur     x0, [x19, #0x80]
04ee5b14: add      x0, x19, #0x80
04ee5b18: bl       #0x2c6afb0
04ee5b1c: ldur     x8, [x19, #0x80]
04ee5b20: mov      x0, x8
04ee5b24: ldp      x29, x30, [sp, #0x10]
04ee5b28: ldp      x20, x19, [sp], #0x20
04ee5b2c: ret      
04ee5b30: stur     xzr, [x19, #0x80]
04ee5b34: add      x0, x19, #0x80
04ee5b38: mov      x1, #0
04ee5b3c: bl       #0x2c6afb0
04ee5b40: mov      x8, #0
04ee5b44: mov      x0, x8
04ee5b48: ldp      x29, x30, [sp, #0x10]
04ee5b4c: ldp      x20, x19, [sp], #0x20
04ee5b50: ret      
