02cc4004: stp      x24, x23, [sp, #-0x40]!
02cc4008: stp      x22, x21, [sp, #0x10]
02cc400c: stp      x20, x19, [sp, #0x20]
02cc4010: stp      x29, x30, [sp, #0x30]
02cc4014: add      x29, sp, #0x30
02cc4018: mov      x20, x0
02cc401c: adrp     x8, #0x10a91000
02cc4020: ldr      x8, [x8, #0x5d0]
02cc4024: adrp     x9, #0x10a91000
02cc4028: ldr      x24, [x9, #0x5d8]
02cc402c: ldrsw    x9, [x24, #0x1c]
02cc4030: add      x8, x8, x9
02cc4034: add      x19, x8, w0, sxtw
02cc4038: adrp     x23, #0x10b35000
02cc403c: ldr      x21, [x23, #0x7d8]
02cc4040: cbnz     x21, #0x2cc406c
02cc4044: ldr      w8, [x24, #0x20]
02cc4048: asr      w8, w8, #5
02cc404c: add      w8, w8, #1
02cc4050: lsl      x22, x8, #2
02cc4054: mov      x0, x22
02cc4058: bl       #0xe7290
02cc405c: mov      x21, x0
02cc4060: str      x0, [x23, #0x7d8]
02cc4064: mov      x1, x22
02cc4068: bl       #0x7c12200
02cc406c: asr      w8, w20, #5
02cc4070: ldr      w10, [x21, w8, uxtw #2]
02cc4074: mov      w9, #1
02cc4078: lsl      w9, w9, w20
02cc407c: tst      w10, w9
02cc4080: b.ne     #0x2cc40ec
02cc4084: ldp      w10, w11, [x24, #0x1c]
02cc4088: add      w10, w10, w20
02cc408c: mul      w10, w10, w11
02cc4090: mov      w11, #0x8853
02cc4094: movk     w11, #0xe5b0, lsl #16
02cc4098: umull    x11, w10, w11
02cc409c: lsr      x11, x11, #0x30
02cc40a0: mov      w12, #0x1d53
02cc40a4: movk     w12, #1, lsl #16
02cc40a8: msub     w10, w11, w12, w10
02cc40ac: ubfiz    w10, w10, #4, #4
02cc40b0: adrp     x11, #0x10239000
02cc40b4: add      x11, x11, #0x480
02cc40b8: mov      x12, x19
02cc40bc: ldrb     w13, [x11, w10, uxtw]
02cc40c0: ldrb     w14, [x12]
02cc40c4: eor      w13, w14, w13
02cc40c8: strb     w13, [x12], #1
02cc40cc: add      w10, w10, #1
02cc40d0: and      w10, w10, #0xff
02cc40d4: tst      w13, #0xff
02cc40d8: b.ne     #0x2cc40bc
02cc40dc: ldr      x10, [x23, #0x7d8]
02cc40e0: ldr      w11, [x10, x8, lsl #2]
02cc40e4: orr      w9, w11, w9
02cc40e8: str      w9, [x10, x8, lsl #2]
02cc40ec: mov      x0, x19
02cc40f0: ldp      x29, x30, [sp, #0x30]
02cc40f4: ldp      x20, x19, [sp, #0x20]
02cc40f8: ldp      x22, x21, [sp, #0x10]
02cc40fc: ldp      x24, x23, [sp], #0x40
02cc4100: ret      
