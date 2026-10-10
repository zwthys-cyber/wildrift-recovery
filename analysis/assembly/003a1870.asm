003a1870: stp      d11, d10, [sp, #-0x80]!
003a1874: stp      d9, d8, [sp, #0x10]
003a1878: stp      x29, x30, [sp, #0x20]
003a187c: stp      x28, x27, [sp, #0x30]
003a1880: stp      x26, x25, [sp, #0x40]
003a1884: stp      x24, x23, [sp, #0x50]
003a1888: stp      x22, x21, [sp, #0x60]
003a188c: stp      x20, x19, [sp, #0x70]
003a1890: add      x29, sp, #0x20
003a1894: sub      sp, sp, #0x530
003a1898: mrs      x8, tpidr_el0
003a189c: mov      w19, w1
003a18a0: mov      x20, x0
003a18a4: str      x8, [sp, #0x18]
003a18a8: ldr      x8, [x8, #0x28]
003a18ac: stur     x8, [x29, #-0x38]
003a18b0: bl       #0x3a26d0
003a18b4: adrp     x9, #0x593000
003a18b8: add      x9, x9, #0xbc8
003a18bc: adrp     x0, #0x23000
003a18c0: add      x0, x0, #0x9b6
003a18c4: ldr      x8, [x9]
003a18c8: str      x8, [x9, #8]
003a18cc: adrp     x9, #0x593000
003a18d0: adrp     x8, #0x593000
003a18d4: ldp      s0, s1, [x20]
003a18d8: strb     w19, [x9, #0xc40]
003a18dc: adrp     x9, #0x593000
003a18e0: fcmp     s0, s1
003a18e4: fcsel    s8, s0, s1, gt
003a18e8: fcsel    s9, s1, s0, gt
003a18ec: str      s8, [x8, #0xbc0]
003a18f0: str      s9, [x9, #0xbc4]
003a18f4: bl       #0x554200 ; opendir
003a18f8: cbz      x0, #0x3a2620
003a18fc: mov      x19, x0
003a1900: bl       #0x554210 ; readdir
003a1904: mov      w25, wzr
003a1908: cbz      x0, #0x3a1934
003a190c: adrp     x20, #0x29000
003a1910: add      x20, x20, #0x385
003a1914: add      x0, x0, #0x13
003a1918: mov      x1, x20
003a191c: bl       #0x554220 ; strstr
003a1920: cmp      x0, #0
003a1924: mov      x0, x19
003a1928: cinc     w25, w25, ne
003a192c: bl       #0x554210 ; readdir
003a1930: cbnz     x0, #0x3a1914
003a1934: mov      w27, #0x4500
003a1938: mov      w24, #0x4521
003a193c: mov      w20, wzr
003a1940: movk     w27, #0x8018, lsl #16
003a1944: movk     w24, #0x8000, lsl #16
003a1948: str      x19, [sp, #0x10]
003a194c: str      w25, [sp, #0x24]
003a1950: b        #0x3a1970
003a1954: mov      x0, x22
003a1958: bl       #0x554230 ; free
003a195c: mov      w0, w21
003a1960: bl       #0x554080 ; close
003a1964: cmp      w20, w25
003a1968: add      w20, w20, #1
003a196c: b.eq     #0x3a1dc4
003a1970: sub      x0, x29, #0xc0
003a1974: mov      w3, w20
003a1978: bl       #0x3a284c
003a197c: sub      x0, x29, #0xc0
003a1980: mov      w1, #2
003a1984: bl       #0x554130 ; __open_2
003a1988: tbnz     w0, #0x1f, #0x3a1964
003a198c: add      w1, w24, #2
003a1990: mov      x2, xzr
003a1994: mov      w21, w0
003a1998: stp      xzr, xzr, [sp, #0x30]
003a199c: str      xzr, [sp, #0x40]
003a19a0: bl       #0x554240 ; ioctl
003a19a4: mov      x22, xzr
003a19a8: tbnz     w0, #0x1f, #0x3a1954
003a19ac: add      w19, w0, #0x10
003a19b0: mov      x0, x22
003a19b4: sbfiz    x1, x19, #1, #0x20
003a19b8: bl       #0x554250 ; realloc
003a19bc: add      w8, w24, #2
003a19c0: mov      x22, x0
003a19c4: mov      w0, w21
003a19c8: orr      w1, w8, w19, lsl #16
003a19cc: mov      x2, x22
003a19d0: bl       #0x554240 ; ioctl
003a19d4: cmp      w19, w0
003a19d8: b.le     #0x3a19ac
003a19dc: cmp      w0, #1
003a19e0: b.lt     #0x3a1954
003a19e4: ubfiz    x26, x0, #3, #0x20
003a19e8: mov      x24, xzr
003a19ec: mov      x28, xzr
003a19f0: mov      w25, wzr
003a19f4: mov      w19, wzr
003a19f8: mov      w23, wzr
003a19fc: b        #0x3a1a10
003a1a00: add      x24, x24, #8
003a1a04: add      x28, x28, #1
003a1a08: cmp      x26, x24
003a1a0c: b.eq     #0x3a1b48
003a1a10: ldrb     w8, [x22, x28]
003a1a14: tbnz     w8, #0, #0x3a1a30
003a1a18: tbnz     w8, #1, #0x3a1a4c
003a1a1c: tbnz     w8, #2, #0x3a1a68
003a1a20: tbnz     w8, #3, #0x3a1a84
003a1a24: tbnz     w8, #4, #0x3a1aa0
003a1a28: tbnz     w8, #5, #0x3a1abc
003a1a2c: b        #0x3a1ad4
003a1a30: add      w8, w24, #0x40
003a1a34: add      x2, sp, #0x30
003a1a38: mov      w0, w21
003a1a3c: orr      w1, w8, w27
003a1a40: bl       #0x554240 ; ioctl
003a1a44: ldrb     w8, [x22, x28]
003a1a48: tbz      w8, #1, #0x3a1a1c
003a1a4c: add      w8, w24, #0x41
003a1a50: add      x2, sp, #0x30
003a1a54: mov      w0, w21
003a1a58: orr      w1, w8, w27
003a1a5c: bl       #0x554240 ; ioctl
003a1a60: ldrb     w8, [x22, x28]
003a1a64: tbz      w8, #2, #0x3a1a20
003a1a68: add      w8, w24, #0x42
003a1a6c: add      x2, sp, #0x30
003a1a70: mov      w0, w21
003a1a74: orr      w1, w8, w27
003a1a78: bl       #0x554240 ; ioctl
003a1a7c: ldrb     w8, [x22, x28]
003a1a80: tbz      w8, #3, #0x3a1a24
003a1a84: add      w8, w24, #0x43
003a1a88: add      x2, sp, #0x30
003a1a8c: mov      w0, w21
003a1a90: orr      w1, w8, w27
003a1a94: bl       #0x554240 ; ioctl
003a1a98: ldrb     w8, [x22, x28]
003a1a9c: tbz      w8, #4, #0x3a1a28
003a1aa0: add      w8, w24, #0x44
003a1aa4: add      x2, sp, #0x30
003a1aa8: mov      w0, w21
003a1aac: orr      w1, w8, w27
003a1ab0: bl       #0x554240 ; ioctl
003a1ab4: ldrb     w8, [x22, x28]
003a1ab8: tbz      w8, #5, #0x3a1ad4
003a1abc: add      w8, w24, #0x45
003a1ac0: add      x2, sp, #0x30
003a1ac4: mov      w0, w21
003a1ac8: orr      w1, w8, w27
003a1acc: bl       #0x554240 ; ioctl
003a1ad0: cbz      w0, #0x3a1b30
003a1ad4: ldrb     w8, [x22, x28]
003a1ad8: tbz      w8, #6, #0x3a1b04
003a1adc: add      w8, w24, #0x46
003a1ae0: add      x2, sp, #0x30
003a1ae4: mov      w0, w21
003a1ae8: orr      w1, w8, w27
003a1aec: bl       #0x554240 ; ioctl
003a1af0: cbnz     w0, #0x3a1b00
003a1af4: cmp      w28, #6
003a1af8: cset     w8, eq
003a1afc: orr      w25, w8, w25
003a1b00: ldrb     w8, [x22, x28]
003a1b04: tbz      w8, #7, #0x3a1a00
003a1b08: add      w8, w24, #0x47
003a1b0c: add      x2, sp, #0x30
003a1b10: mov      w0, w21
003a1b14: orr      w1, w8, w27
003a1b18: bl       #0x554240 ; ioctl
003a1b1c: cbnz     w0, #0x3a1a00
003a1b20: cmp      w28, #5
003a1b24: cset     w8, eq
003a1b28: orr      w23, w8, w23
003a1b2c: b        #0x3a1a00
003a1b30: cmp      w28, #6
003a1b34: cset     w8, eq
003a1b38: orr      w19, w8, w19
003a1b3c: ldrb     w8, [x22, x28]
003a1b40: tbnz     w8, #6, #0x3a1adc
003a1b44: b        #0x3a1b04
003a1b48: and      w8, w23, w19
003a1b4c: mov      x0, x22
003a1b50: and      w19, w8, w25
003a1b54: bl       #0x554230 ; free
003a1b58: mov      w24, #0x4521
003a1b5c: ldr      w25, [sp, #0x24]
003a1b60: movk     w24, #0x8000, lsl #16
003a1b64: tbz      w19, #0, #0x3a195c
003a1b68: movi     v0.2d, #0000000000000000
003a1b6c: add      x8, sp, #0x30
003a1b70: add      w1, w27, #0x75
003a1b74: mov      w0, w21
003a1b78: stur     q0, [x8, #0xcc]
003a1b7c: stp      q0, q0, [x8, #0x90]
003a1b80: stp      q0, q0, [x8, #0xb0]
003a1b84: str      q0, [x8, #0x80]
003a1b88: add      x8, sp, #0x30
003a1b8c: add      x2, x8, #0xc
003a1b90: stp      q0, q0, [sp, #0x30]
003a1b94: stp      q0, q0, [sp, #0x50]
003a1b98: stp      q0, q0, [sp, #0x70]
003a1b9c: stp      q0, q0, [sp, #0x90]
003a1ba0: bl       #0x554240 ; ioctl
003a1ba4: cbnz     w0, #0x3a1964
003a1ba8: add      x8, sp, #0x30
003a1bac: add      w1, w27, #0x76
003a1bb0: mov      w0, w21
003a1bb4: add      x2, x8, #0x24
003a1bb8: bl       #0x554240 ; ioctl
003a1bbc: cbnz     w0, #0x3a1964
003a1bc0: adrp     x8, #0x593000
003a1bc4: add      x8, x8, #0xbd0
003a1bc8: str      w21, [sp, #0x30]
003a1bcc: ldp      x22, x8, [x8]
003a1bd0: cmp      x22, x8
003a1bd4: b.hs     #0x3a1c24
003a1bd8: ldp      q1, q0, [sp, #0x30]
003a1bdc: add      x8, sp, #0x30
003a1be0: add      x19, x22, #0xdc
003a1be4: stp      q1, q0, [x22]
003a1be8: ldp      q1, q0, [sp, #0x70]
003a1bec: ldp      q2, q3, [sp, #0x50]
003a1bf0: stp      q1, q0, [x22, #0x40]
003a1bf4: stp      q2, q3, [x22, #0x20]
003a1bf8: ldp      q1, q0, [x8, #0x80]
003a1bfc: ldp      q2, q3, [sp, #0x90]
003a1c00: stp      q1, q0, [x22, #0x80]
003a1c04: stp      q2, q3, [x22, #0x60]
003a1c08: ldp      q3, q1, [x8, #0xb0]
003a1c0c: ldur     q0, [x8, #0xcc]
003a1c10: ldr      q2, [x8, #0xa0]
003a1c14: stur     q0, [x22, #0xcc]
003a1c18: stp      q3, q1, [x22, #0xb0]
003a1c1c: str      q2, [x22, #0xa0]
003a1c20: b        #0x3a1db8
003a1c24: adrp     x9, #0x593000
003a1c28: mov      x10, #0xb587
003a1c2c: mov      x11, #0x29e4
003a1c30: ldr      x19, [x9, #0xbc8]
003a1c34: movk     x10, #0x586f, lsl #16
003a1c38: movk     x11, #0x9e41, lsl #16
003a1c3c: movk     x10, #0x86fb, lsl #32
003a1c40: movk     x11, #0xe412, lsl #32
003a1c44: sub      x9, x22, x19
003a1c48: movk     x10, #0x6fb5, lsl #48
003a1c4c: movk     x11, #0x129, lsl #48
003a1c50: asr      x9, x9, #2
003a1c54: mul      x23, x9, x10
003a1c58: add      x9, x23, #1
003a1c5c: cmp      x9, x11
003a1c60: b.hi     #0x3a26ac
003a1c64: sub      x8, x8, x19
003a1c68: asr      x8, x8, #2
003a1c6c: mul      x8, x8, x10
003a1c70: lsl      x10, x8, #1
003a1c74: cmp      x10, x9
003a1c78: csel     x9, x10, x9, hi
003a1c7c: mov      x10, #0x94f2
003a1c80: movk     x10, #0x4f20, lsl #16
003a1c84: movk     x10, #0xf209, lsl #32
003a1c88: movk     x10, #0x94, lsl #48
003a1c8c: cmp      x8, x10
003a1c90: csel     x21, x9, x11, lo
003a1c94: cbz      x21, #0x3a1cb0
003a1c98: cmp      x21, x11
003a1c9c: b.hi     #0x3a2694
003a1ca0: mov      w26, #0xdc
003a1ca4: mul      x0, x21, x26
003a1ca8: bl       #0x54dfc0
003a1cac: b        #0x3a1cb8
003a1cb0: mov      x0, xzr
003a1cb4: mov      w26, #0xdc
003a1cb8: madd     x8, x23, x26, x0
003a1cbc: add      x9, sp, #0x30
003a1cc0: cmp      x22, x19
003a1cc4: ldp      q0, q1, [x9, #0xa0]
003a1cc8: ldr      q2, [x9, #0xc0]
003a1ccc: mov      w10, #0xdc
003a1cd0: stp      q0, q1, [x8, #0xa0]
003a1cd4: ldur     q0, [x9, #0xcc]
003a1cd8: str      q2, [x8, #0xc0]
003a1cdc: ldp      q1, q2, [sp, #0x90]
003a1ce0: stur     q0, [x8, #0xcc]
003a1ce4: stp      q1, q2, [x8, #0x60]
003a1ce8: ldp      q0, q1, [x9, #0x80]
003a1cec: mov      x9, x8
003a1cf0: stp      q0, q1, [x8, #0x80]
003a1cf4: ldp      q2, q0, [sp, #0x50]
003a1cf8: stp      q2, q0, [x8, #0x20]
003a1cfc: ldp      q1, q0, [sp, #0x70]
003a1d00: stp      q1, q0, [x8, #0x40]
003a1d04: ldp      q2, q0, [sp, #0x30]
003a1d08: stp      q2, q0, [x8]
003a1d0c: b.eq     #0x3a1d94
003a1d10: ldur     q0, [x22, #-0xcc]
003a1d14: ldur     q1, [x22, #-0xdc]
003a1d18: stur     q0, [x9, #-0xcc]
003a1d1c: stur     q1, [x9, #-0xdc]
003a1d20: ldur     q0, [x22, #-0x8c]
003a1d24: ldur     q1, [x22, #-0x9c]
003a1d28: ldur     q2, [x22, #-0xbc]
003a1d2c: ldur     q3, [x22, #-0xac]
003a1d30: stur     q0, [x9, #-0x8c]
003a1d34: stur     q1, [x9, #-0x9c]
003a1d38: stur     q3, [x9, #-0xac]
003a1d3c: stur     q2, [x9, #-0xbc]
003a1d40: ldur     q0, [x22, #-0x4c]
003a1d44: ldur     q1, [x22, #-0x5c]
003a1d48: ldur     q2, [x22, #-0x7c]
003a1d4c: ldur     q3, [x22, #-0x6c]
003a1d50: stur     q0, [x9, #-0x4c]
003a1d54: stur     q1, [x9, #-0x5c]
003a1d58: stur     q3, [x9, #-0x6c]
003a1d5c: stur     q2, [x9, #-0x7c]
003a1d60: ldur     q0, [x22, #-0x10]
003a1d64: ldur     q1, [x22, #-0x1c]
003a1d68: ldur     q2, [x22, #-0x3c]
003a1d6c: ldur     q3, [x22, #-0x2c]
003a1d70: sub      x22, x22, #0xdc
003a1d74: stur     q0, [x9, #-0x10]
003a1d78: cmp      x22, x19
003a1d7c: stur     q1, [x9, #-0x1c]
003a1d80: stur     q3, [x9, #-0x2c]
003a1d84: stur     q2, [x9, #-0x3c]
003a1d88: sub      x9, x9, #0xdc
003a1d8c: b.ne     #0x3a1d10
003a1d90: mov      x22, x19
003a1d94: madd     x10, x21, x10, x0
003a1d98: add      x19, x8, #0xdc
003a1d9c: adrp     x8, #0x593000
003a1da0: add      x8, x8, #0xbc8
003a1da4: stp      x9, x19, [x8]
003a1da8: str      x10, [x8, #0x10]
003a1dac: cbz      x22, #0x3a1db8
003a1db0: mov      x0, x22
003a1db4: bl       #0x54e070
003a1db8: adrp     x8, #0x593000
003a1dbc: str      x19, [x8, #0xbd0]
003a1dc0: b        #0x3a1964
003a1dc4: ldr      x0, [sp, #0x10]
003a1dc8: bl       #0x554260 ; closedir
003a1dcc: adrp     x22, #0x593000
003a1dd0: adrp     x8, #0x593000
003a1dd4: ldrb     w9, [x22, #0xc40]
003a1dd8: cbz      w9, #0x3a2048
003a1ddc: mov      x24, #0xb587
003a1de0: strb     wzr, [x8, #0xc48]
003a1de4: movk     x24, #0x586f, lsl #16
003a1de8: movk     x24, #0x86fb, lsl #32
003a1dec: movk     x24, #0x6fb5, lsl #48
003a1df0: adrp     x21, #0x593000
003a1df4: add      x21, x21, #0xbc8
003a1df8: ldp      x9, x8, [x21]
003a1dfc: cmp      x9, x8
003a1e00: b.eq     #0x3a20c0
003a1e04: ldrb     w10, [x22, #0xc40]
003a1e08: ldr      w19, [x9, #0x14]
003a1e0c: ldr      w20, [x9, #0x2c]
003a1e10: cbz      w10, #0x3a20d0
003a1e14: adrp     x10, #0x593000
003a1e18: add      x10, x10, #0xc54
003a1e1c: mov      w11, #1
003a1e20: scvtf    s11, w19
003a1e24: scvtf    s10, w20
003a1e28: stlrb    w11, [x10]
003a1e2c: adrp     x11, #0x593000
003a1e30: add      x11, x11, #0xbe0
003a1e34: cmp      x8, x9
003a1e38: ldr      x10, [x11]
003a1e3c: str      x10, [x11, #8]
003a1e40: b.eq     #0x3a2014
003a1e44: mov      x19, xzr
003a1e48: mov      w23, #0xdc
003a1e4c: nop      
003a1e50: adr      x20, #0x3a28f0
003a1e54: adrp     x25, #0x593000
003a1e58: add      x25, x25, #0xbe8
003a1e5c: adrp     x22, #0x593000
003a1e60: b        #0x3a1ea0
003a1e64: ldr      x8, [sp, #0x30]
003a1e68: str      x8, [x28], #8
003a1e6c: mov      x27, x28
003a1e70: mov      x24, #0xb587
003a1e74: str      x27, [x22, #0xbe8]
003a1e78: movk     x24, #0x586f, lsl #16
003a1e7c: movk     x24, #0x86fb, lsl #32
003a1e80: movk     x24, #0x6fb5, lsl #48
003a1e84: ldp      x9, x8, [x21]
003a1e88: sub      x10, x8, x9
003a1e8c: add      x19, x19, #1
003a1e90: asr      x10, x10, #2
003a1e94: mul      x10, x10, x24
003a1e98: cmp      x10, x19
003a1e9c: b.ls     #0x3a2014
003a1ea0: madd     x10, x19, x23, x9
003a1ea4: ldr      s0, [x10, #0x14]
003a1ea8: ldr      s1, [x10, #0x2c]
003a1eac: ldr      w11, [x10]
003a1eb0: scvtf    s0, s0
003a1eb4: scvtf    s1, s1
003a1eb8: cmp      w11, #1
003a1ebc: fdiv     s0, s11, s0
003a1ec0: fdiv     s1, s10, s1
003a1ec4: stp      s0, s1, [x10, #4]
003a1ec8: b.lt     #0x3a1e88
003a1ecc: add      x0, sp, #0x30
003a1ed0: mov      x1, xzr
003a1ed4: mov      x2, x20
003a1ed8: mov      x3, x19
003a1edc: str      xzr, [sp, #0x30]
003a1ee0: bl       #0x554270 ; pthread_create
003a1ee4: cbnz     w0, #0x3a1e84
003a1ee8: ldp      x28, x8, [x25]
003a1eec: cmp      x28, x8
003a1ef0: b.lo     #0x3a1e64
003a1ef4: adrp     x9, #0x593000
003a1ef8: ldr      x21, [x9, #0xbe0]
003a1efc: sub      x26, x28, x21
003a1f00: asr      x27, x26, #3
003a1f04: add      x9, x27, #1
003a1f08: lsr      x10, x9, #0x3d
003a1f0c: cbnz     x10, #0x3a2674
003a1f10: sub      x8, x8, x21
003a1f14: asr      x10, x8, #2
003a1f18: cmp      x10, x9
003a1f1c: csel     x9, x10, x9, hi
003a1f20: mov      x10, #0x7ffffffffffffff8
003a1f24: cmp      x8, x10
003a1f28: mov      x8, #0x1fffffffffffffff
003a1f2c: csel     x24, x9, x8, lo
003a1f30: cbz      x24, #0x3a1f48
003a1f34: lsr      x8, x24, #0x3d
003a1f38: cbnz     x8, #0x3a2694
003a1f3c: lsl      x0, x24, #3
003a1f40: bl       #0x54dfc0
003a1f44: b        #0x3a1f4c
003a1f48: mov      x0, xzr
003a1f4c: add      x9, x0, x27, lsl #3
003a1f50: ldr      x10, [sp, #0x30]
003a1f54: subs     x8, x28, x21
003a1f58: mov      x27, x9
003a1f5c: str      x10, [x27], #8
003a1f60: b.eq     #0x3a1fe4
003a1f64: sub      x8, x8, #8
003a1f68: cmp      x8, #0x38
003a1f6c: b.lo     #0x3a1fcc
003a1f70: sub      x10, x28, x0
003a1f74: sub      x10, x10, x26
003a1f78: cmp      x10, #0x20
003a1f7c: b.lo     #0x3a1fcc
003a1f80: lsr      x8, x8, #3
003a1f84: sub      x13, x28, #0x10
003a1f88: add      x10, x8, #1
003a1f8c: and      x11, x10, #0x3ffffffffffffffc
003a1f90: lsl      x8, x11, #3
003a1f94: mov      x14, x11
003a1f98: sub      x12, x28, x8
003a1f9c: sub      x8, x9, x8
003a1fa0: sub      x9, x9, #0x10
003a1fa4: ldp      q1, q0, [x13, #-0x10]
003a1fa8: subs     x14, x14, #4
003a1fac: sub      x13, x13, #0x20
003a1fb0: stp      q1, q0, [x9, #-0x10]
003a1fb4: sub      x9, x9, #0x20
003a1fb8: b.ne     #0x3a1fa4
003a1fbc: cmp      x10, x11
003a1fc0: mov      x28, x12
003a1fc4: mov      x9, x8
003a1fc8: b.eq     #0x3a1fe8
003a1fcc: mov      x8, x9
003a1fd0: ldr      x9, [x28, #-8]!
003a1fd4: cmp      x28, x21
003a1fd8: str      x9, [x8, #-8]!
003a1fdc: b.ne     #0x3a1fd0
003a1fe0: b        #0x3a1fe8
003a1fe4: mov      x8, x9
003a1fe8: add      x9, x0, x24, lsl #3
003a1fec: adrp     x10, #0x593000
003a1ff0: add      x10, x10, #0xbe0
003a1ff4: stp      x8, x27, [x10]
003a1ff8: str      x9, [x10, #0x10]
003a1ffc: cbz      x21, #0x3a2008
003a2000: mov      x0, x21
003a2004: bl       #0x54e070
003a2008: adrp     x21, #0x593000
003a200c: add      x21, x21, #0xbc8
003a2010: b        #0x3a1e70
003a2014: adrp     x8, #0x593000
003a2018: adrp     x9, #0x593000
003a201c: mov      w0, #1
003a2020: ldrb     w8, [x8, #0xc4c]
003a2024: cmp      w8, #0
003a2028: adrp     x8, #0x593000
003a202c: fcsel    s0, s9, s8, eq
003a2030: fcsel    s1, s8, s9, eq
003a2034: fdiv     s0, s11, s0
003a2038: fdiv     s1, s10, s1
003a203c: str      s0, [x8, #0xbb8]
003a2040: str      s1, [x9, #0xbbc]
003a2044: b        #0x3a2620
003a2048: adrp     x9, #0x593000
003a204c: add      x9, x9, #0xbc8
003a2050: mov      x24, #0xb587
003a2054: ldp      x21, x20, [x9]
003a2058: movk     x24, #0x586f, lsl #16
003a205c: movk     x24, #0x86fb, lsl #32
003a2060: movk     x24, #0x6fb5, lsl #48
003a2064: sub      x9, x20, x21
003a2068: asr      x9, x9, #2
003a206c: mul      x9, x9, x24
003a2070: cmp      x9, #1
003a2074: cset     w9, hi
003a2078: strb     w9, [x8, #0xc48]
003a207c: b.hi     #0x3a1df0
003a2080: cmp      x21, x20
003a2084: b.eq     #0x3a1df0
003a2088: mov      w8, #0x5565
003a208c: movk     w8, #0x4004, lsl #16
003a2090: sub      w19, w8, #0xfd5
003a2094: b        #0x3a20a4
003a2098: add      x21, x21, #0xdc
003a209c: cmp      x21, x20
003a20a0: b.eq     #0x3a1df0
003a20a4: ldr      w0, [x21]
003a20a8: cmp      w0, #1
003a20ac: b.lt     #0x3a2098
003a20b0: mov      w1, w19
003a20b4: mov      w2, #1
003a20b8: bl       #0x554240 ; ioctl
003a20bc: b        #0x3a2098
003a20c0: adrp     x0, #0x2a000
003a20c4: add      x0, x0, #0xc91 ; '获取屏幕驱动失败'
003a20c8: bl       #0x553f60 ; puts
003a20cc: b        #0x3a261c
003a20d0: adrp     x0, #0x28000
003a20d4: add      x0, x0, #0x450 ; '/dev/uinput'
003a20d8: mov      w1, #0x801
003a20dc: bl       #0x554130 ; __open_2
003a20e0: adrp     x27, #0x593000
003a20e4: cmp      w0, #0
003a20e8: str      w0, [x27, #0xc44]
003a20ec: b.le     #0x3a2614
003a20f0: str      w20, [sp, #0x10]
003a20f4: mov      w20, #0x6141
003a20f8: str      w19, [sp, #0x24]
003a20fc: movk     w20, #0x30, lsl #16
003a2100: bl       #0x554030 ; rand
003a2104: mov      w8, #0x6667
003a2108: movi     v0.2d, #0000000000000000
003a210c: mov      w1, wzr
003a2110: movk     w8, #0x6666, lsl #16
003a2114: mov      w2, #0x45c
003a2118: smull    x8, w0, w8
003a211c: lsr      x9, x8, #0x3f
003a2120: asr      x8, x8, #0x22
003a2124: add      w8, w8, w9
003a2128: mov      w9, #0xa
003a212c: msub     w19, w8, w9, w0
003a2130: add      x8, sp, #0x30
003a2134: add      x0, sp, #0x30
003a2138: str      q0, [x8, #0x470]
003a213c: str      q0, [x8, #0x460]
003a2140: add      w21, w19, #5
003a2144: bl       #0x554090 ; memset
003a2148: mov      x0, xzr
003a214c: bl       #0x553ee0 ; time
003a2150: add      w0, w21, w0
003a2154: str      w21, [sp, #4]
003a2158: bl       #0x554020 ; srand
003a215c: sxtw     x8, w19
003a2160: cmn      w19, #3
003a2164: adrp     x28, #0x2c000
003a2168: add      x28, x28, #0xbc8
003a216c: str      x19, [sp, #8]
003a2170: add      x8, x8, #4
003a2174: mov      x23, x8
003a2178: mov      w22, w8
003a217c: b.lt     #0x3a21e8
003a2180: mov      w21, #0x5556
003a2184: sub      x26, x29, #0xc0
003a2188: mov      x25, x22
003a218c: movk     w21, #0x5555, lsl #16
003a2190: b        #0x3a21bc
003a2194: ubfiz    x9, x8, #3, #0x15
003a2198: ldr      w19, [x28, w8, uxtw #2]
003a219c: lsr      w24, w20, w9
003a21a0: bl       #0x554030 ; rand
003a21a4: sdiv     w8, w0, w19
003a21a8: msub     w8, w8, w19, w0
003a21ac: add      w8, w24, w8
003a21b0: subs     x25, x25, #1
003a21b4: strb     w8, [x26], #1
003a21b8: b.eq     #0x3a21e8
003a21bc: bl       #0x554030 ; rand
003a21c0: smull    x8, w0, w21
003a21c4: lsr      x9, x8, #0x3f
003a21c8: lsr      x8, x8, #0x20
003a21cc: add      w8, w8, w9
003a21d0: add      w8, w8, w8, lsl #1
003a21d4: sub      w8, w0, w8
003a21d8: cmp      w8, #2
003a21dc: b.ls     #0x3a2194
003a21e0: mov      w8, #0x78
003a21e4: b        #0x3a21b0
003a21e8: sub      x8, x29, #0xc0
003a21ec: mov      w26, #0x5565
003a21f0: add      x0, sp, #0x30
003a21f4: sub      x1, x29, #0xc0
003a21f8: mov      w2, #0x50
003a21fc: mov      w3, #0x50
003a2200: mov      w4, #0x20
003a2204: movk     w26, #0x4004, lsl #16
003a2208: mov      x25, x23
003a220c: strb     wzr, [x8, x23]
003a2210: bl       #0x554280 ; __strncpy_chk2
003a2214: strh     wzr, [sp, #0x80]
003a2218: bl       #0x554030 ; rand
003a221c: mov      w19, #0x6667
003a2220: mov      w21, #0xa
003a2224: movk     w19, #0x6666, lsl #16
003a2228: smull    x8, w0, w19
003a222c: lsr      x9, x8, #0x3f
003a2230: lsr      x8, x8, #0x22
003a2234: add      w8, w8, w9
003a2238: msub     w8, w8, w21, w0
003a223c: add      w8, w8, #5
003a2240: strh     w8, [sp, #0x82]
003a2244: bl       #0x554030 ; rand
003a2248: smull    x8, w0, w19
003a224c: lsr      x9, x8, #0x3f
003a2250: lsr      x8, x8, #0x22
003a2254: add      w8, w8, w9
003a2258: msub     w8, w8, w21, w0
003a225c: add      w8, w8, #5
003a2260: strh     w8, [sp, #0x84]
003a2264: bl       #0x554030 ; rand
003a2268: smull    x9, w0, w19
003a226c: ldr      w8, [x27, #0xc44]
003a2270: add      w1, w26, #9
003a2274: mov      w2, #1
003a2278: lsr      x10, x9, #0x3f
003a227c: lsr      x9, x9, #0x22
003a2280: add      w9, w9, w10
003a2284: msub     w9, w9, w21, w0
003a2288: mov      w0, w8
003a228c: add      w9, w9, #5
003a2290: strh     w9, [sp, #0x86]
003a2294: bl       #0x554240 ; ioctl
003a2298: ldr      w0, [x27, #0xc44]
003a229c: sub      w19, w26, #1
003a22a0: mov      w2, #3
003a22a4: mov      w1, w19
003a22a8: bl       #0x554240 ; ioctl
003a22ac: ldr      w0, [x27, #0xc44]
003a22b0: orr      w1, w26, #2
003a22b4: mov      w2, wzr
003a22b8: bl       #0x554240 ; ioctl
003a22bc: ldr      w0, [x27, #0xc44]
003a22c0: orr      w1, w26, #2
003a22c4: mov      w2, #1
003a22c8: bl       #0x554240 ; ioctl
003a22cc: ldr      w0, [x27, #0xc44]
003a22d0: orr      w1, w26, #2
003a22d4: mov      w2, #0x35
003a22d8: bl       #0x554240 ; ioctl
003a22dc: ldr      w0, [x27, #0xc44]
003a22e0: orr      w1, w26, #2
003a22e4: mov      w2, #0x36
003a22e8: bl       #0x554240 ; ioctl
003a22ec: ldr      w0, [x27, #0xc44]
003a22f0: orr      w1, w26, #2
003a22f4: mov      w2, #0x39
003a22f8: bl       #0x554240 ; ioctl
003a22fc: ldr      w0, [x27, #0xc44]
003a2300: mov      w1, w19
003a2304: mov      w2, wzr
003a2308: bl       #0x554240 ; ioctl
003a230c: ldr      w0, [x27, #0xc44]
003a2310: mov      w1, w19
003a2314: mov      w2, #1
003a2318: bl       #0x554240 ; ioctl
003a231c: ldr      w0, [x27, #0xc44]
003a2320: mov      w1, #0x5565
003a2324: mov      w2, #0x145
003a2328: movk     w1, #0x4004, lsl #16
003a232c: bl       #0x554240 ; ioctl
003a2330: ldr      w0, [x27, #0xc44]
003a2334: mov      w1, #0x5565
003a2338: mov      w2, #0x14a
003a233c: movk     w1, #0x4004, lsl #16
003a2340: bl       #0x554240 ; ioctl
003a2344: mov      x0, xzr
003a2348: bl       #0x553ee0 ; time
003a234c: ldr      w8, [sp, #4]
003a2350: add      w0, w8, w0
003a2354: bl       #0x554020 ; srand
003a2358: ldr      x8, [sp, #8]
003a235c: cmn      w8, #3
003a2360: b.lt     #0x3a23c8
003a2364: mov      w21, #0x5556
003a2368: sub      x19, x29, #0xc0
003a236c: movk     w21, #0x5555, lsl #16
003a2370: b        #0x3a239c
003a2374: ubfiz    x9, x8, #3, #0x15
003a2378: ldr      w23, [x28, w8, uxtw #2]
003a237c: lsr      w24, w20, w9
003a2380: bl       #0x554030 ; rand
003a2384: sdiv     w8, w0, w23
003a2388: msub     w8, w8, w23, w0
003a238c: add      w8, w24, w8
003a2390: subs     x22, x22, #1
003a2394: strb     w8, [x19], #1
003a2398: b.eq     #0x3a23c8
003a239c: bl       #0x554030 ; rand
003a23a0: smull    x8, w0, w21
003a23a4: lsr      x9, x8, #0x3f
003a23a8: lsr      x8, x8, #0x20
003a23ac: add      w8, w8, w9
003a23b0: add      w8, w8, w8, lsl #1
003a23b4: sub      w8, w0, w8
003a23b8: cmp      w8, #2
003a23bc: b.ls     #0x3a2374
003a23c0: mov      w8, #0x78
003a23c4: b        #0x3a2390
003a23c8: ldr      w0, [x27, #0xc44]
003a23cc: mov      w1, #0x556c
003a23d0: sub      x8, x29, #0xc0
003a23d4: sub      x2, x29, #0xc0
003a23d8: movk     w1, #0x4008, lsl #16
003a23dc: strb     wzr, [x8, x25]
003a23e0: bl       #0x554240 ; ioctl
003a23e4: adrp     x21, #0x593000
003a23e8: add      x21, x21, #0xbc8
003a23ec: ldp      x8, x9, [x21]
003a23f0: cmp      x8, x9
003a23f4: b.eq     #0x3a25bc
003a23f8: ldr      w20, [x8]
003a23fc: mov      w1, #0x4502
003a2400: add      x2, sp, #0x28
003a2404: movk     w1, #0x8008, lsl #16
003a2408: str      xzr, [sp, #0x28]
003a240c: mov      w0, w20
003a2410: bl       #0x554240 ; ioctl
003a2414: cbnz     w0, #0x3a2420
003a2418: ldr      d0, [sp, #0x28]
003a241c: str      d0, [sp, #0x80]
003a2420: mov      w1, #0x4521
003a2424: mov      w0, w20
003a2428: mov      x2, xzr
003a242c: movk     w1, #0x8000, lsl #16
003a2430: bl       #0x554240 ; ioctl
003a2434: mov      w22, #0x4521
003a2438: mov      x19, xzr
003a243c: movk     w22, #0x8000, lsl #16
003a2440: tbnz     w0, #0x1f, #0x3a25b4
003a2444: add      w21, w0, #0x10
003a2448: mov      x0, x19
003a244c: sbfiz    x1, x21, #1, #0x20
003a2450: bl       #0x554250 ; realloc
003a2454: orr      w1, w22, w21, lsl #16
003a2458: mov      x19, x0
003a245c: mov      w0, w20
003a2460: mov      x2, x19
003a2464: bl       #0x554240 ; ioctl
003a2468: cmp      w21, w0
003a246c: b.le     #0x3a2444
003a2470: cmp      w0, #1
003a2474: b.lt     #0x3a25ac
003a2478: ubfiz    x23, x0, #3, #0x20
003a247c: mov      x20, xzr
003a2480: mov      x24, x19
003a2484: adrp     x21, #0x593000
003a2488: add      x21, x21, #0xbc8
003a248c: b        #0x3a24a0
003a2490: add      x20, x20, #8
003a2494: add      x24, x24, #1
003a2498: cmp      x23, x20
003a249c: b.eq     #0x3a25b4
003a24a0: ldrb     w8, [x24]
003a24a4: tbnz     w8, #0, #0x3a24b4
003a24a8: tbnz     w8, #1, #0x3a24d0
003a24ac: tbnz     w8, #2, #0x3a24ec
003a24b0: b        #0x3a250c
003a24b4: ldr      w0, [x27, #0xc44]
003a24b8: mov      w1, #0x5565
003a24bc: mov      w2, w20
003a24c0: movk     w1, #0x4004, lsl #16
003a24c4: bl       #0x554240 ; ioctl
003a24c8: ldrb     w8, [x24]
003a24cc: tbz      w8, #1, #0x3a24ac
003a24d0: ldr      w0, [x27, #0xc44]
003a24d4: mov      w1, #0x5565
003a24d8: add      w2, w20, #1
003a24dc: movk     w1, #0x4004, lsl #16
003a24e0: bl       #0x554240 ; ioctl
003a24e4: ldrb     w8, [x24]
003a24e8: tbz      w8, #2, #0x3a250c
003a24ec: cmp      w20, #0x148
003a24f0: b.eq     #0x3a250c
003a24f4: ldr      w0, [x27, #0xc44]
003a24f8: mov      w1, #0x5565
003a24fc: add      x2, x20, #2
003a2500: movk     w1, #0x4004, lsl #16
003a2504: bl       #0x554240 ; ioctl
003a2508: ldrb     w8, [x24]
003a250c: tbnz     w8, #3, #0x3a251c
003a2510: tbnz     w8, #4, #0x3a2538
003a2514: tbnz     w8, #5, #0x3a2554
003a2518: b        #0x3a2574
003a251c: ldr      w0, [x27, #0xc44]
003a2520: mov      w1, #0x5565
003a2524: add      w2, w20, #3
003a2528: movk     w1, #0x4004, lsl #16
003a252c: bl       #0x554240 ; ioctl
003a2530: ldrb     w8, [x24]
003a2534: tbz      w8, #4, #0x3a2514
003a2538: ldr      w0, [x27, #0xc44]
003a253c: mov      w1, #0x5565
003a2540: add      w2, w20, #4
003a2544: movk     w1, #0x4004, lsl #16
003a2548: bl       #0x554240 ; ioctl
003a254c: ldrb     w8, [x24]
003a2550: tbz      w8, #5, #0x3a2574
003a2554: cmp      w20, #0x140
003a2558: b.eq     #0x3a2574
003a255c: ldr      w0, [x27, #0xc44]
003a2560: mov      w1, #0x5565
003a2564: add      x2, x20, #5
003a2568: movk     w1, #0x4004, lsl #16
003a256c: bl       #0x554240 ; ioctl
003a2570: ldrb     w8, [x24]
003a2574: tbz      w8, #6, #0x3a2590
003a2578: ldr      w0, [x27, #0xc44]
003a257c: mov      w1, #0x5565
003a2580: add      w2, w20, #6
003a2584: movk     w1, #0x4004, lsl #16
003a2588: bl       #0x554240 ; ioctl
003a258c: ldrb     w8, [x24]
003a2590: tbz      w8, #7, #0x3a2490
003a2594: ldr      w0, [x27, #0xc44]
003a2598: mov      w1, #0x5565
003a259c: add      w2, w20, #7
003a25a0: movk     w1, #0x4004, lsl #16
003a25a4: bl       #0x554240 ; ioctl
003a25a8: b        #0x3a2490
003a25ac: adrp     x21, #0x593000
003a25b0: add      x21, x21, #0xbc8
003a25b4: mov      x0, x19
003a25b8: bl       #0x554230 ; free
003a25bc: add      x8, sp, #0x30
003a25c0: ldr      w19, [sp, #0x24]
003a25c4: ldr      w20, [sp, #0x10]
003a25c8: add      x8, x8, #0x15c
003a25cc: ldr      w0, [x27, #0xc44]
003a25d0: add      x1, sp, #0x30
003a25d4: str      xzr, [x8]
003a25d8: mov      w8, #0xffff
003a25dc: mov      w2, #0x45c
003a25e0: str      w19, [sp, #0x160]
003a25e4: str      xzr, [sp, #0x260]
003a25e8: str      w20, [sp, #0x164]
003a25ec: stp      w19, w20, [sp, #0x8c]
003a25f0: str      wzr, [sp, #0x270]
003a25f4: str      w8, [sp, #0x170]
003a25f8: bl       #0x5541f0 ; write
003a25fc: ldr      w0, [x27, #0xc44]
003a2600: mov      w1, #0x5501
003a2604: bl       #0x554240 ; ioctl
003a2608: cbz      w0, #0x3a265c
003a260c: ldr      w0, [x27, #0xc44]
003a2610: bl       #0x554080 ; close
003a2614: str      wzr, [x27, #0xc44]
003a2618: bl       #0x3a26d0
003a261c: mov      w0, wzr
003a2620: ldr      x8, [sp, #0x18]
003a2624: ldr      x8, [x8, #0x28]
003a2628: ldur     x9, [x29, #-0x38]
003a262c: cmp      x8, x9
003a2630: b.ne     #0x3a26cc
003a2634: add      sp, sp, #0x530
003a2638: ldp      x20, x19, [sp, #0x70]
003a263c: ldp      x22, x21, [sp, #0x60]
003a2640: ldp      x24, x23, [sp, #0x50]
003a2644: ldp      x26, x25, [sp, #0x40]
003a2648: ldp      x28, x27, [sp, #0x30]
003a264c: ldp      x29, x30, [sp, #0x20]
003a2650: ldp      d9, d8, [sp, #0x10]
003a2654: ldp      d11, d10, [sp], #0x80
003a2658: ret      
003a265c: mov      x24, #0xb587
003a2660: ldp      x9, x8, [x21]
003a2664: movk     x24, #0x586f, lsl #16
003a2668: movk     x24, #0x86fb, lsl #32
003a266c: movk     x24, #0x6fb5, lsl #48
003a2670: b        #0x3a1e14
003a2674: ldr      x8, [sp, #0x18]
003a2678: ldr      x8, [x8, #0x28]
003a267c: ldur     x9, [x29, #-0x38]
003a2680: cmp      x8, x9
003a2684: b.ne     #0x3a26cc
003a2688: adrp     x0, #0x593000
003a268c: add      x0, x0, #0xbe0
003a2690: bl       #0x3a2fb4
003a2694: ldr      x8, [sp, #0x18]
003a2698: ldr      x8, [x8, #0x28]
003a269c: ldur     x9, [x29, #-0x38]
003a26a0: cmp      x8, x9
003a26a4: b.ne     #0x3a26cc
003a26a8: bl       #0x3927f0
003a26ac: ldr      x8, [sp, #0x18]
003a26b0: ldr      x8, [x8, #0x28]
003a26b4: ldur     x9, [x29, #-0x38]
003a26b8: cmp      x8, x9
003a26bc: b.ne     #0x3a26cc
003a26c0: adrp     x0, #0x593000
003a26c4: add      x0, x0, #0xbc8
003a26c8: bl       #0x3a2fa0
003a26cc: bl       #0x553f00 ; __stack_chk_fail
