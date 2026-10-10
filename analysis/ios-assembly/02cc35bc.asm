02cc35bc: stp      x26, x25, [sp, #-0x50]!
02cc35c0: stp      x24, x23, [sp, #0x10]
02cc35c4: stp      x22, x21, [sp, #0x20]
02cc35c8: stp      x20, x19, [sp, #0x30]
02cc35cc: stp      x29, x30, [sp, #0x40]
02cc35d0: add      x29, sp, #0x40
02cc35d4: adrp     x21, #0x10a91000
02cc35d8: ldr      x8, [x21, #0x5c8]
02cc35dc: ldr      w9, [x8, #0x30]
02cc35e0: cmp      w9, #1
02cc35e4: b.lt     #0x2cc3654
02cc35e8: mov      x19, x1
02cc35ec: mov      x20, x0
02cc35f0: mov      x22, #0
02cc35f4: mov      w23, #1
02cc35f8: mov      w24, #0x7ffe
02cc35fc: movk     w24, #0x1346, lsl #16
02cc3600: mov      w25, #0x40080000
02cc3604: ldr      x8, [x8, #0x38]
02cc3608: ldr      x0, [x8, x22, lsl #3]
02cc360c: ldrb     w8, [x0, #0xa]
02cc3610: cmp      w8, #0x1e
02cc3614: b.hi     #0x2cc362c
02cc3618: lsl      w9, w23, w8
02cc361c: mov      x8, x20
02cc3620: tst      w9, w24
02cc3624: b.eq     #0x2cc3644
02cc3628: blr      x8
02cc362c: add      x22, x22, #1
02cc3630: ldr      x8, [x21, #0x5c8]
02cc3634: ldrsw    x9, [x8, #0x30]
02cc3638: cmp      x22, x9
02cc363c: b.lt     #0x2cc3604
02cc3640: b        #0x2cc3654
02cc3644: tst      w9, w25
02cc3648: b.eq     #0x2cc362c
02cc364c: mov      x8, x19
02cc3650: b        #0x2cc3628
02cc3654: ldp      x29, x30, [sp, #0x40]
02cc3658: ldp      x20, x19, [sp, #0x30]
02cc365c: ldp      x22, x21, [sp, #0x20]
02cc3660: ldp      x24, x23, [sp, #0x10]
02cc3664: ldp      x26, x25, [sp], #0x50
02cc3668: ret      
