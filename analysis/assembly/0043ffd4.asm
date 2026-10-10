0043ffd4: sub      sp, sp, #0x80
0043ffd8: stp      x29, x30, [sp, #0x50]
0043ffdc: stp      x22, x21, [sp, #0x60]
0043ffe0: stp      x20, x19, [sp, #0x70]
0043ffe4: add      x29, sp, #0x50
0043ffe8: mrs      x21, tpidr_el0
0043ffec: mov      x19, x0
0043fff0: adrp     x20, #0x556000
0043fff4: add      x20, x20, #0xda0
0043fff8: ldr      x8, [x21, #0x28]
0043fffc: cmp      w1, #0
00440000: stur     x8, [x29, #-8]
00440004: cset     w8, eq
00440008: cmp      w2, #1
0044000c: str      x20, [x0]
00440010: str      wzr, [x0, #8]
00440014: strb     w8, [x0, #0xc]
00440018: strb     wzr, [x0, #0xd]
0044001c: b.lt     #0x440050
00440020: movi     v0.2d, #0xffffffffffffffff
00440024: mov      w4, w2
00440028: add      x22, x19, #0x14
0044002c: cbz      w1, #0x440070
00440030: adrp     x8, #0x556000
00440034: add      x8, x8, #0xe10
00440038: str      w4, [x19, #8]
0044003c: str      x8, [x19]
00440040: mov      w8, #1
00440044: str      d0, [x19, #0x10]
00440048: strb     w8, [x19, #0xd]
0044004c: b        #0x4400b4
00440050: movi     v0.2d, #0xffffffffffffffff
00440054: adrp     x8, #0x556000
00440058: add      x8, x8, #0xe10
0044005c: str      x8, [x19]
00440060: str      d0, [x19, #0x10]
00440064: cbz      w1, #0x44008c
00440068: strb     wzr, [x19, #0xd]
0044006c: b        #0x440144
00440070: adrp     x8, #0x59f000
00440074: str      w4, [x8, #0x194]
00440078: adrp     x8, #0x556000
0044007c: add      x8, x8, #0xe10
00440080: str      x8, [x19]
00440084: str      d0, [x19, #0x10]
00440088: b        #0x440090
0044008c: add      x22, x19, #0x14
00440090: adrp     x8, #0x59f000
00440094: ldr      w9, [x8, #0x194]
00440098: cmp      w9, #0
0044009c: cset     w9, gt
004400a0: strb     w9, [x19, #0xd]
004400a4: ldr      w9, [x8, #0x194]
004400a8: cmp      w9, #1
004400ac: b.lt     #0x440144
004400b0: ldr      w4, [x8, #0x194]
004400b4: adrp     x3, #0x22000
004400b8: add      x3, x3, #0xee9
004400bc: add      x0, sp, #8
004400c0: mov      w1, #0x40
004400c4: mov      w2, #0x40
004400c8: bl       #0x41dd88
004400cc: mov      x0, #-0x64
004400d0: add      x1, sp, #8
004400d4: mov      w8, #0x38
004400d8: mov      x2, xzr
004400dc: mov      x3, xzr
004400e0: mov      x4, xzr
004400e4: mov      x5, xzr
004400e8: svc      #0
004400ec: str      w0, [x19, #0x10]
004400f0: ldrb     w8, [x19, #0xc]
004400f4: cbz      w8, #0x440104
004400f8: adrp     x8, #0x59f000
004400fc: ldr      w4, [x8, #0x194]
00440100: b        #0x440108
00440104: ldr      w4, [x19, #8]
00440108: adrp     x3, #0x25000
0044010c: add      x3, x3, #0xa02 ; '/proc/%d/mem'
00440110: add      x0, sp, #8
00440114: mov      w1, #0x40
00440118: mov      w2, #0x40
0044011c: bl       #0x41dd88
00440120: mov      x0, #-0x64
00440124: add      x1, sp, #8
00440128: mov      w8, #0x38
0044012c: mov      w2, #2
00440130: mov      x3, xzr
00440134: mov      x4, xzr
00440138: mov      x5, xzr
0044013c: svc      #0
00440140: str      w0, [x22]
00440144: ldr      x8, [x21, #0x28]
00440148: ldur     x9, [x29, #-8]
0044014c: cmp      x8, x9
00440150: b.ne     #0x4401b0
00440154: ldp      x20, x19, [sp, #0x70]
00440158: ldp      x22, x21, [sp, #0x60]
0044015c: ldp      x29, x30, [sp, #0x50]
00440160: add      sp, sp, #0x80
00440164: ret      
00440168: ldrb     w9, [x19, #0xc]
0044016c: mov      x8, x20
00440170: mov      x20, x0
00440174: str      x8, [x19]
00440178: cbnz     w9, #0x440184
0044017c: ldr      w1, [x19, #8]
00440180: b        #0x44018c
00440184: adrp     x8, #0x59f000
00440188: ldr      w1, [x8, #0x194]
0044018c: adrp     x0, #0x27000
00440190: add      x0, x0, #0x2b4
00440194: bl       #0x553fa0 ; printf
00440198: ldr      x8, [x21, #0x28]
0044019c: ldur     x9, [x29, #-8]
004401a0: cmp      x8, x9
004401a4: b.ne     #0x4401b0
004401a8: mov      x0, x20
004401ac: bl       #0x54fffc
004401b0: bl       #0x553f00 ; __stack_chk_fail
