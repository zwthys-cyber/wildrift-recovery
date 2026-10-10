00439998: mov      w9, #0xaa30
0043999c: ldr      x8, [x0]
004399a0: mov      w0, wzr
004399a4: movk     w9, #0xc, lsl #16
004399a8: cmp      w1, w9
004399ac: b.gt     #0x439a04
004399b0: mov      w9, #0x12b8
004399b4: movk     w9, #3, lsl #16
004399b8: cmp      w1, w9
004399bc: b.le     #0x439a50
004399c0: mov      w9, #0x1895
004399c4: movk     w9, #3, lsl #16
004399c8: cmp      w1, w9
004399cc: b.le     #0x439a80
004399d0: mov      w9, #0x1896
004399d4: movk     w9, #3, lsl #16
004399d8: cmp      w1, w9
004399dc: b.eq     #0x439a70
004399e0: mov      w9, #0x18f9
004399e4: movk     w9, #3, lsl #16
004399e8: cmp      w1, w9
004399ec: b.eq     #0x439a70
004399f0: mov      w9, #0xf805
004399f4: movk     w9, #3, lsl #16
004399f8: cmp      w1, w9
004399fc: b.eq     #0x439a70
00439a00: b        #0x439ab0
00439a04: sub      w9, w1, #0xca, lsl #12
00439a08: sub      w9, w9, #0xced
00439a0c: cmp      w9, #0x14
00439a10: b.hi     #0x439a2c
00439a14: mov      w10, #1
00439a18: lsl      w9, w10, w9
00439a1c: mov      w10, #0x1b
00439a20: movk     w10, #0x10, lsl #16
00439a24: tst      w9, w10
00439a28: b.ne     #0x439a70
00439a2c: sub      w9, w1, #0xca, lsl #12
00439a30: sub      w9, w9, #0xa95
00439a34: cmp      w9, #2
00439a38: b.lo     #0x439aa0
00439a3c: sub      w9, w1, #0xca, lsl #12
00439a40: sub      w9, w9, #0xa31
00439a44: cmp      w9, #1
00439a48: b.ls     #0x439aa8
00439a4c: b        #0x439ab0
00439a50: sub      w9, w1, #0x31, lsl #12
00439a54: sub      w9, w9, #0x190
00439a58: cmp      w9, #2
00439a5c: b.lo     #0x439a70
00439a60: sub      w9, w1, #0x31, lsl #12
00439a64: sub      w9, w9, #0x1f1
00439a68: cmp      w9, #2
00439a6c: b.hs     #0x439ab0
00439a70: add      x8, x8, #0x696
00439a74: ldrb     w8, [x8]
00439a78: and      w0, w8, #1
00439a7c: ret      
00439a80: mov      w9, #0x12b9
00439a84: movk     w9, #3, lsl #16
00439a88: cmp      w1, w9
00439a8c: b.eq     #0x439aa8
00439a90: mov      w9, #0x12ba
00439a94: movk     w9, #3, lsl #16
00439a98: cmp      w1, w9
00439a9c: b.ne     #0x439ab0
00439aa0: add      x8, x8, #0x695
00439aa4: b        #0x439a74
00439aa8: add      x8, x8, #0x694
00439aac: b        #0x439a74
00439ab0: ret      
