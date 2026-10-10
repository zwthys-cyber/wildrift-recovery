02cdbc78: stp      x20, x19, [sp, #-0x20]!
02cdbc7c: stp      x29, x30, [sp, #0x10]
02cdbc80: add      x29, sp, #0x10
02cdbc84: cbz      x1, #0x2cdbc94
02cdbc88: mov      x20, x0
02cdbc8c: ldr      x8, [x0, #0x60]
02cdbc90: cbz      x8, #0x2cdbca4
02cdbc94: mov      x0, #0
02cdbc98: ldp      x29, x30, [sp, #0x10]
02cdbc9c: ldp      x20, x19, [sp], #0x20
02cdbca0: ret      
02cdbca4: mov      x19, x1
02cdbca8: ldr      x8, [x1]
02cdbcac: cbz      x8, #0x2cdbcd0
02cdbcb0: add      x8, x8, #8
02cdbcb4: ldr      x9, [x20, #0xa0]
02cdbcb8: ldrh     w10, [x20, #0x128]
02cdbcbc: add      x9, x9, x10, lsl #3
02cdbcc0: cmp      x9, x8
02cdbcc4: b.ls     #0x2cdbc94
02cdbcc8: str      x8, [x19]
02cdbccc: b        #0x2cdbcec
02cdbcd0: mov      x0, x20
02cdbcd4: bl       #0x2cdbcf4
02cdbcd8: ldrh     w8, [x20, #0x128]
02cdbcdc: cbz      w8, #0x2cdbc94
02cdbce0: ldr      x8, [x20, #0xa0]
02cdbce4: str      x8, [x19]
02cdbce8: ldr      x8, [x20, #0xa0]
02cdbcec: ldr      x0, [x8]
02cdbcf0: b        #0x2cdbc98
