0050aaf8: paciasp  
0050aafc: sub      sp, sp, #0x20
0050ab00: stp      x29, x30, [sp, #0x10]
0050ab04: add      x29, sp, #0x10
0050ab08: mov      x1, sp
0050ab0c: mov      w0, #1
0050ab10: bl       #0x554540
0050ab14: cbnz     w0, #0x50ab38
0050ab18: ldp      x8, x10, [sp]
0050ab1c: mov      w9, #0xca00
0050ab20: movk     w9, #0x3b9a, lsl #16
0050ab24: madd     x0, x8, x9, x10
0050ab28: ldp      x29, x30, [sp, #0x10]
0050ab2c: add      sp, sp, #0x20
0050ab30: autiasp  
0050ab34: ret      
0050ab38: bl       #0x5541a0
0050ab3c: ldr      w0, [x0]
0050ab40: adrp     x1, #0x23000
0050ab44: add      x1, x1, #0x73f
0050ab48: bl       #0x50e1f8
0050ab4c: bl       #0x3860c0
