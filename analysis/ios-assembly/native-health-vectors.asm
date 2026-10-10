; Selected getter evidence from exact FEProj UUID/SHA input; no game code is invoked.
00fe29ec: stp      x29, x30, [sp, #-0x10]!
00fe29f0: mov      x29, sp
00fe29f4: sxtw     x8, w1
00fe29f8: ldp      x9, x10, [x0, #0x28]
00fe29fc: sub      x10, x10, x9
00fe2a00: cmp      x8, x10, asr #3
00fe2a04: b.hs     #0xfe2a18
00fe2a08: ldr      x0, [x9, x8, lsl #3]
00fe2a0c: bl       #0x1024524
00fe2a10: ldp      x29, x30, [sp], #0x10
00fe2a14: ret      
00fe2a18: bl       #0xfe361c
00fe2a1c: stp      x29, x30, [sp, #-0x10]!
00fe2a20: mov      x29, sp
00fe2a24: sxtw     x8, w1
00fe2a28: ldp      x9, x10, [x0, #0x28]
00fe2a2c: sub      x10, x10, x9
00fe2a30: cmp      x8, x10, asr #3
00fe2a34: b.hs     #0xfe2a48
00fe2a38: ldr      x0, [x9, x8, lsl #3]
00fe2a3c: bl       #0x1024530
00fe2a40: ldp      x29, x30, [sp], #0x10
00fe2a44: ret      
00fe2a48: bl       #0xfe3620
