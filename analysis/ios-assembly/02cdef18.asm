02cdef18: sub      sp, sp, #0xa0
02cdef1c: stp      x28, x27, [sp, #0x40]
02cdef20: stp      x26, x25, [sp, #0x50]
02cdef24: stp      x24, x23, [sp, #0x60]
02cdef28: stp      x22, x21, [sp, #0x70]
02cdef2c: stp      x20, x19, [sp, #0x80]
02cdef30: stp      x29, x30, [sp, #0x90]
02cdef34: add      x29, sp, #0x90
02cdef38: adrp     x0, #0x10a91000
02cdef3c: add      x0, x0, #0xc88
02cdef40: adrp     x1, #0x10a91000
02cdef44: add      x1, x1, #0xc8c
02cdef48: bl       #0x2cc3438
02cdef4c: mov      x19, x0
02cdef50: cbz      w0, #0x2cdf2a8
02cdef54: str      w19, [sp, #4]
02cdef58: adrp     x19, #0x10a91000
02cdef5c: ldr      x8, [x19, #0xc78]
02cdef60: ldr      x0, [x8, #8]
02cdef64: ldr      w1, [x8]
02cdef68: bl       #0x2c88f18
02cdef6c: adrp     x20, #0x10a91000
02cdef70: ldr      x8, [x20, #0xc80]
02cdef74: ldr      w0, [x8, #4]
02cdef78: bl       #0x2c89238
02cdef7c: ldr      x8, [x20, #0xc80]
02cdef80: ldr      w0, [x8, #8]
02cdef84: bl       #0x2c89250
02cdef88: ldr      x8, [x19, #0xc78]
02cdef8c: ldrsw    x1, [x8, #0x10]
02cdef90: adrp     x0, #0x10a91000
02cdef94: add      x0, x0, #0xa18
02cdef98: bl       #0x2cdf310
02cdef9c: ldr      x8, [x19, #0xc78]
02cdefa0: ldr      w9, [x8, #0x10]
02cdefa4: cmp      w9, #1
02cdefa8: b.lt     #0x2cdefe4
02cdefac: mov      x21, #0
02cdefb0: mov      x22, #0
02cdefb4: adrp     x20, #0x10a91000
02cdefb8: add      x20, x20, #0xa18
02cdefbc: ldr      x8, [x8, #0x18]
02cdefc0: add      x1, x8, x21
02cdefc4: mov      x0, x20
02cdefc8: bl       #0x2cdf364
02cdefcc: add      x22, x22, #1
02cdefd0: ldr      x8, [x19, #0xc78]
02cdefd4: ldrsw    x9, [x8, #0x10]
02cdefd8: add      x21, x21, #8
02cdefdc: cmp      x22, x9
02cdefe0: b.lt     #0x2cdefbc
02cdefe4: adrp     x8, #0x10a91000
02cdefe8: ldr      x8, [x8, #0xc70]
02cdefec: ldr      x20, [x8, #0x60]
02cdeff0: ldr      w19, [x8, #0x58]
02cdeff4: adrp     x8, #0x10a91000
02cdeff8: ldrb     w8, [x8, #0xc38]
02cdeffc: cbz      w8, #0x2cdf010
02cdf000: adrp     x8, #0x10a91000
02cdf004: ldr      x0, [x8, #0xc28]
02cdf008: cbz      x0, #0x2cdf010
02cdf00c: bl       #0xe7484
02cdf010: mov      w8, #0x38
02cdf014: madd     x1, x19, x8, x20
02cdf018: clz      x8, x19
02cdf01c: mov      w9, #0x7e
02cdf020: sub      x8, x9, x8, lsl #1
02cdf024: cmp      w19, #0
02cdf028: csel     x3, xzr, x8, eq
02cdf02c: add      x2, sp, #0x20
02cdf030: mov      x0, x20
02cdf034: bl       #0x2ce713c
02cdf038: adrp     x8, #0x10a91000
02cdf03c: add      x8, x8, #0xc28
02cdf040: stp      x20, x19, [x8]
02cdf044: strb     wzr, [x8, #0x10]
02cdf048: adrp     x8, #0x10a91000
02cdf04c: ldr      x8, [x8, #0xc70]
02cdf050: ldr      x20, [x8, #0x70]
02cdf054: ldr      w19, [x8, #0x68]
02cdf058: adrp     x8, #0x10a91000
02cdf05c: ldrb     w8, [x8, #0xc50]
02cdf060: cbz      w8, #0x2cdf074
02cdf064: adrp     x8, #0x10a91000
02cdf068: ldr      x0, [x8, #0xc40]
02cdf06c: cbz      x0, #0x2cdf074
02cdf070: bl       #0xe7484
02cdf074: add      x1, x20, x19, lsl #4
02cdf078: clz      x8, x19
02cdf07c: mov      w9, #0x7e
02cdf080: sub      x8, x9, x8, lsl #1
02cdf084: cmp      w19, #0
02cdf088: csel     x3, xzr, x8, eq
02cdf08c: add      x2, sp, #0x20
02cdf090: mov      x0, x20
02cdf094: bl       #0x2ce8464
02cdf098: adrp     x8, #0x10a91000
02cdf09c: add      x8, x8, #0xc40
02cdf0a0: stp      x20, x19, [x8]
02cdf0a4: strb     wzr, [x8, #0x10]
02cdf0a8: adrp     x23, #0x10a91000
02cdf0ac: ldrsw    x0, [x23, #0xc88]
02cdf0b0: mov      w1, #0x48
02cdf0b4: bl       #0x2ca2ff8
02cdf0b8: adrp     x27, #0x10a91000
02cdf0bc: str      x0, [x27, #0xc90]
02cdf0c0: adrp     x8, #0x10a91000
02cdf0c4: ldrsw    x0, [x8, #0xc8c]
02cdf0c8: mov      w1, #0x58
02cdf0cc: bl       #0x2ca2ff8
02cdf0d0: adrp     x25, #0x10a91000
02cdf0d4: str      x0, [x25, #0xc98]
02cdf0d8: ldr      w8, [x23, #0xc88]
02cdf0dc: cmp      w8, #1
02cdf0e0: b.lt     #0x2cdf270
02cdf0e4: mov      x20, #0
02cdf0e8: mov      w22, #0x48
02cdf0ec: ldr      x19, [x27, #0xc90]
02cdf0f0: madd     x21, x20, x22, x19
02cdf0f4: add      x2, sp, #0x3c
02cdf0f8: mov      x0, x21
02cdf0fc: mov      x1, x20
02cdf100: bl       #0x2cc3f4c
02cdf104: ldrsw    x8, [sp, #0x3c]
02cdf108: ldr      x9, [x25, #0xc98]
02cdf10c: mov      w10, #0x58
02cdf110: madd     x9, x8, x10, x9
02cdf114: cmn      w8, #1
02cdf118: csel     x8, xzr, x9, eq
02cdf11c: str      x8, [x21, #0x10]
02cdf120: ldr      x1, [x21]
02cdf124: add      x0, sp, #8
02cdf128: bl       #0x2b2184
02cdf12c: add      x8, sp, #0x20
02cdf130: add      x0, sp, #8
02cdf134: bl       #0x2ca3f18
02cdf138: ldrsb    w8, [sp, #0x1f]
02cdf13c: tbz      w8, #0x1f, #0x2cdf148
02cdf140: ldr      x0, [sp, #8]
02cdf144: bl       #0xe5038
02cdf148: mov      x25, x23
02cdf14c: ldrb     w8, [sp, #0x37]
02cdf150: sxtb     w9, w8
02cdf154: ldr      x10, [sp, #0x28]
02cdf158: cmp      w9, #0
02cdf15c: csel     x8, x10, x8, lt
02cdf160: add      x0, x8, #1
02cdf164: mov      w1, #1
02cdf168: bl       #0x2ca2ff8
02cdf16c: mov      w23, #0x48
02cdf170: madd     x8, x20, x22, x19
02cdf174: str      x0, [x8, #8]
02cdf178: ldrsb    w8, [sp, #0x37]
02cdf17c: ldr      x9, [sp, #0x20]
02cdf180: cmp      w8, #0
02cdf184: add      x8, sp, #0x20
02cdf188: csel     x1, x9, x8, lt
02cdf18c: bl       #0x7c12250
02cdf190: adrp     x8, #0x10a91000
02cdf194: ldr      x22, [x8, #0xc70]
02cdf198: ldr      w26, [x22, #0x78]
02cdf19c: cbz      w26, #0x2cdf1dc
02cdf1a0: mov      x28, #0
02cdf1a4: madd     x8, x20, x23, x19
02cdf1a8: add      x23, x8, #0x38
02cdf1ac: ldr      x21, [x21]
02cdf1b0: ldr      x8, [x22, #0x80]
02cdf1b4: ldr      x24, [x8, x28, lsl #3]
02cdf1b8: ldr      x1, [x24]
02cdf1bc: mov      x0, x21
02cdf1c0: bl       #0x7c12384
02cdf1c4: cbnz     w0, #0x2cdf1d0
02cdf1c8: str      x24, [x23]
02cdf1cc: ldr      w26, [x22, #0x78]
02cdf1d0: add      x28, x28, #1
02cdf1d4: cmp      x28, w26, uxtw
02cdf1d8: b.lo     #0x2cdf1b0
02cdf1dc: mov      w22, #0x48
02cdf1e0: madd     x8, x20, x22, x19
02cdf1e4: strb     wzr, [x8, #0x44]
02cdf1e8: ldrsb    w8, [sp, #0x37]
02cdf1ec: tbz      w8, #0x1f, #0x2cdf1f8
02cdf1f0: ldr      x0, [sp, #0x20]
02cdf1f4: bl       #0xe5038
02cdf1f8: add      x20, x20, #1
02cdf1fc: mov      x23, x25
02cdf200: ldrsw    x8, [x25, #0xc88]
02cdf204: cmp      x20, x8
02cdf208: adrp     x25, #0x10a91000
02cdf20c: b.lt     #0x2cdf0ec
02cdf210: cmp      w8, #1
02cdf214: b.lt     #0x2cdf270
02cdf218: mov      x19, #0
02cdf21c: mov      x20, #0
02cdf220: mov      w22, #0x48
02cdf224: ldr      x8, [x25, #0xc98]
02cdf228: add      x21, x8, x19
02cdf22c: add      x2, sp, #0x20
02cdf230: mov      x0, x21
02cdf234: mov      x1, x20
02cdf238: bl       #0x2cc4104
02cdf23c: ldrsw    x8, [sp, #0x20]
02cdf240: ldr      x9, [x27, #0xc90]
02cdf244: madd     x9, x8, x22, x9
02cdf248: cmn      w8, #1
02cdf24c: csel     x8, xzr, x9, eq
02cdf250: str      x8, [x21]
02cdf254: mov      x0, x21
02cdf258: bl       #0x2ca8c4c
02cdf25c: add      x20, x20, #1
02cdf260: ldrsw    x8, [x23, #0xc88]
02cdf264: add      x19, x19, #0x58
02cdf268: cmp      x20, x8
02cdf26c: b.lt     #0x2cdf224
02cdf270: bl       #0x2cdf3dc
02cdf274: bl       #0x2cecfbc
02cdf278: ldr      w19, [sp, #4]
02cdf27c: tbz      w0, #0, #0x2cdf2a8
02cdf280: stp      xzr, xzr, [sp, #0x20]
02cdf284: str      xzr, [sp, #0x30]
02cdf288: add      x0, sp, #0x20
02cdf28c: bl       #0x2cc54dc
02cdf290: add      x0, sp, #0x20
02cdf294: bl       #0x2cecfc8
02cdf298: ldr      x0, [sp, #0x20]
02cdf29c: cbz      x0, #0x2cdf2a8
02cdf2a0: str      x0, [sp, #0x28]
02cdf2a4: bl       #0xe5038
02cdf2a8: mov      x0, x19
02cdf2ac: ldp      x29, x30, [sp, #0x90]
02cdf2b0: ldp      x20, x19, [sp, #0x80]
02cdf2b4: ldp      x22, x21, [sp, #0x70]
02cdf2b8: ldp      x24, x23, [sp, #0x60]
02cdf2bc: ldp      x26, x25, [sp, #0x50]
02cdf2c0: ldp      x28, x27, [sp, #0x40]
02cdf2c4: add      sp, sp, #0xa0
02cdf2c8: ret      
02cdf2cc: mov      x19, x0
02cdf2d0: ldr      x0, [sp, #0x20]
02cdf2d4: cbz      x0, #0x2cdf308
02cdf2d8: str      x0, [sp, #0x28]
02cdf2dc: b        #0x2cdf304
02cdf2e0: mov      x19, x0
02cdf2e4: ldrsb    w8, [sp, #0x37]
02cdf2e8: tbz      w8, #0x1f, #0x2cdf308
02cdf2ec: ldr      x0, [sp, #0x20]
02cdf2f0: b        #0x2cdf304
02cdf2f4: mov      x19, x0
02cdf2f8: ldrsb    w8, [sp, #0x1f]
02cdf2fc: tbz      w8, #0x1f, #0x2cdf308
02cdf300: ldr      x0, [sp, #8]
02cdf304: bl       #0xe5038
02cdf308: mov      x0, x19
02cdf30c: bl       #0x7c121f8
