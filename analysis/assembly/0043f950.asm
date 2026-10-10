0043f950: sub      sp, sp, #0x170
0043f954: stp      x29, x30, [sp, #0x130]
0043f958: str      x28, [sp, #0x140]
0043f95c: stp      x22, x21, [sp, #0x150]
0043f960: stp      x20, x19, [sp, #0x160]
0043f964: add      x29, sp, #0x130
0043f968: mrs      x22, tpidr_el0
0043f96c: mov      x20, x1
0043f970: ldr      x8, [x22, #0x28]
0043f974: cmp      w0, #2
0043f978: stur     x8, [x29, #-8]
0043f97c: b.eq     #0x43f9dc
0043f980: cmp      w0, #3
0043f984: b.ne     #0x43fae4
0043f988: mov      w0, #0x18
0043f98c: bl       #0x54dfc0
0043f990: mov      x19, x0
0043f994: mov      w1, #1
0043f998: mov      w2, wzr
0043f99c: bl       #0x43fd4c
0043f9a0: ldr      x0, [x19, #0x10]
0043f9a4: cbz      x20, #0x43fba8
0043f9a8: cbz      x0, #0x43fba8
0043f9ac: ldrb     w8, [x20]
0043f9b0: cbz      w8, #0x43fbac
0043f9b4: mov      x1, x20
0043f9b8: bl       #0x508c54
0043f9bc: cmp      w0, #0
0043f9c0: b.le     #0x43fba4
0043f9c4: ldrb     w8, [x19, #0xc]
0043f9c8: mov      w1, w0
0043f9cc: cbz      w8, #0x43fc2c
0043f9d0: adrp     x8, #0x59f000
0043f9d4: str      w1, [x8, #0x194]
0043f9d8: b        #0x43fc30
0043f9dc: mov      w0, #0x20
0043f9e0: bl       #0x54dfc0
0043f9e4: adrp     x8, #0x556000
0043f9e8: add      x8, x8, #0xe48
0043f9ec: mov      x19, x0
0043f9f0: str      wzr, [x0, #8]
0043f9f4: mov      w9, #-1
0043f9f8: mov      x21, x0
0043f9fc: strh     wzr, [x0, #0xc]
0043fa00: mov      w1, #0x9810
0043fa04: mov      w2, #0x2778
0043fa08: str      x8, [x0]
0043fa0c: movk     w1, #0x191, lsl #16
0043fa10: mov      w8, #0x8e
0043fa14: strb     wzr, [x0, #0x14]
0043fa18: str      wzr, [x0, #0x18]
0043fa1c: mov      w0, #0x4514
0043fa20: str      w9, [x21, #0x10]!
0043fa24: movk     w0, #0x11, lsl #16
0043fa28: mov      x3, x21
0043fa2c: svc      #0
0043fa30: ldr      w8, [x21]
0043fa34: tbz      w8, #0x1f, #0x43fa50
0043fa38: adrp     x1, #0x21000
0043fa3c: add      x1, x1, #0x20e
0043fa40: mov      x0, x19
0043fa44: bl       #0x4407d8
0043fa48: str      w0, [x21]
0043fa4c: tbnz     w0, #0x1f, #0x43fb80
0043fa50: mov      w8, #1
0043fa54: adrp     x0, #0x23000
0043fa58: add      x0, x0, #0x560 ; '\n[+] TwT 驱动连接成功。'
0043fa5c: strb     w8, [x19, #0xd]
0043fa60: bl       #0x553f60 ; puts
0043fa64: cbz      x20, #0x43fb90
0043fa68: ldrb     w8, [x19, #0xd]
0043fa6c: cbz      w8, #0x43fb90
0043fa70: ldrb     w8, [x20]
0043fa74: cbz      w8, #0x43fb90
0043fa78: movi     v0.2d, #0000000000000000
0043fa7c: adrp     x3, #0x25000
0043fa80: add      x3, x3, #0xdc7
0043fa84: add      x0, sp, #0x28
0043fa88: mov      w1, #0x100
0043fa8c: mov      w2, #0x100
0043fa90: mov      x4, x20
0043fa94: add      x20, sp, #0x28
0043fa98: stp      q0, q0, [sp]
0043fa9c: bl       #0x41dd88
0043faa0: ldr      w0, [x21]
0043faa4: mov      w1, #0x5400
0043faa8: mov      x2, sp
0043faac: movk     w1, #0x4020, lsl #16
0043fab0: str      wzr, [sp]
0043fab4: str      x20, [sp, #0x10]
0043fab8: bl       #0x554240 ; ioctl
0043fabc: ldr      w8, [sp]
0043fac0: cmp      w0, #0
0043fac4: csinv    w8, w8, wzr, eq
0043fac8: cmp      w8, #1
0043facc: b.lt     #0x43fb90
0043fad0: ldrb     w9, [x19, #0xc]
0043fad4: cbz      w9, #0x43fc24
0043fad8: adrp     x9, #0x59f000
0043fadc: str      w8, [x9, #0x194]
0043fae0: b        #0x43fbf8
0043fae4: cbz      x20, #0x43fbf4
0043fae8: mov      w19, w0
0043faec: mov      x0, x20
0043faf0: bl       #0x43fecc
0043faf4: cmp      w0, #1
0043faf8: b.lt     #0x43fbf4
0043fafc: mov      w20, w0
0043fb00: mov      w8, w19
0043fb04: cmp      w19, #3
0043fb08: mov      x19, xzr
0043fb0c: b.le     #0x43fb44
0043fb10: cmp      w8, #4
0043fb14: b.eq     #0x43fc44
0043fb18: cmp      w8, #5
0043fb1c: b.eq     #0x43fc8c
0043fb20: cmp      w8, #6
0043fb24: b.ne     #0x43fbf8
0043fb28: mov      w0, #0x18
0043fb2c: bl       #0x54dfc0
0043fb30: mov      x19, x0
0043fb34: mov      w1, #1
0043fb38: mov      w2, w20
0043fb3c: bl       #0x4402d4
0043fb40: b        #0x43fbf8
0043fb44: cbz      w8, #0x43fca8
0043fb48: cmp      w8, #1
0043fb4c: b.ne     #0x43fbf8
0043fb50: mov      w0, #0x20
0043fb54: bl       #0x54dfc0
0043fb58: adrp     x8, #0x556000
0043fb5c: add      x8, x8, #0xdd8
0043fb60: mov      x19, x0
0043fb64: str      x8, [x0]
0043fb68: mov      w8, #-1
0043fb6c: strh     wzr, [x0, #0xc]
0043fb70: str      w20, [x0, #8]
0043fb74: str      w8, [x0, #0x10]
0043fb78: bl       #0x4409e4
0043fb7c: b        #0x43fbf8
0043fb80: adrp     x0, #0x22000
0043fb84: add      x0, x0, #0x9ac ; '\n[-] TwT 驱动未加载或无 root 权限'
0043fb88: bl       #0x553f60 ; puts
0043fb8c: cbnz     x20, #0x43fa68
0043fb90: ldr      x8, [x19]
0043fb94: mov      x0, x19
0043fb98: ldr      x8, [x8, #8]
0043fb9c: blr      x8
0043fba0: b        #0x43fbf4
0043fba4: ldr      x0, [x19, #0x10]
0043fba8: cbz      x0, #0x43fbbc
0043fbac: mov      x20, x0
0043fbb0: bl       #0x508bf0
0043fbb4: mov      x0, x20
0043fbb8: bl       #0x54e070
0043fbbc: ldrb     w8, [x19, #0xc]
0043fbc0: adrp     x9, #0x556000
0043fbc4: add      x9, x9, #0xda0
0043fbc8: str      x9, [x19]
0043fbcc: cbz      w8, #0x43fbdc
0043fbd0: adrp     x8, #0x59f000
0043fbd4: ldr      w1, [x8, #0x194]
0043fbd8: b        #0x43fbe0
0043fbdc: ldr      w1, [x19, #8]
0043fbe0: adrp     x0, #0x27000
0043fbe4: add      x0, x0, #0x2b4
0043fbe8: bl       #0x553fa0 ; printf
0043fbec: mov      x0, x19
0043fbf0: bl       #0x54e070
0043fbf4: mov      x19, xzr
0043fbf8: ldr      x8, [x22, #0x28]
0043fbfc: ldur     x9, [x29, #-8]
0043fc00: cmp      x8, x9
0043fc04: b.ne     #0x43fd48
0043fc08: mov      x0, x19
0043fc0c: ldp      x20, x19, [sp, #0x160]
0043fc10: ldr      x28, [sp, #0x140]
0043fc14: ldp      x22, x21, [sp, #0x150]
0043fc18: ldp      x29, x30, [sp, #0x130]
0043fc1c: add      sp, sp, #0x170
0043fc20: ret      
0043fc24: str      w8, [x19, #8]
0043fc28: b        #0x43fbf8
0043fc2c: str      w1, [x19, #8]
0043fc30: ldr      x0, [x19, #0x10]
0043fc34: bl       #0x508c20
0043fc38: mov      w8, #1
0043fc3c: strb     w8, [x19, #0xd]
0043fc40: b        #0x43fbf8
0043fc44: mov      w0, #0x10
0043fc48: bl       #0x54dfc0
0043fc4c: adrp     x8, #0x563000
0043fc50: mov      x19, x0
0043fc54: ldr      x8, [x8, #0x198]
0043fc58: strh     wzr, [x0, #0xc]
0043fc5c: str      w20, [x0, #8]
0043fc60: ldr      x0, [x8]
0043fc64: adrp     x8, #0x557000
0043fc68: add      x8, x8, #0xa78
0043fc6c: str      x8, [x19]
0043fc70: strb     wzr, [x19, #0xe]
0043fc74: cbz      x0, #0x43fbf8
0043fc78: bl       #0x5093bc
0043fc7c: and      w8, w0, #1
0043fc80: strb     w8, [x19, #0xe]
0043fc84: strb     w8, [x19, #0xd]
0043fc88: b        #0x43fbf8
0043fc8c: mov      w0, #0x18
0043fc90: bl       #0x54dfc0
0043fc94: mov      x19, x0
0043fc98: mov      w1, #1
0043fc9c: mov      w2, w20
0043fca0: bl       #0x4401b4
0043fca4: b        #0x43fbf8
0043fca8: mov      w0, #0x18
0043fcac: bl       #0x54dfc0
0043fcb0: mov      x19, x0
0043fcb4: mov      w1, #1
0043fcb8: mov      w2, w20
0043fcbc: bl       #0x43ffd4
0043fcc0: b        #0x43fbf8
0043fcc4: mov      x21, x0
0043fcc8: adrp     x0, #0x27000
0043fccc: add      x0, x0, #0x2b4
0043fcd0: mov      w1, w20
0043fcd4: bl       #0x553fa0 ; printf
0043fcd8: b        #0x43fd28
0043fcdc: b        #0x43fd24
0043fce0: b        #0x43fcec
0043fce4: b        #0x43fd24
0043fce8: b        #0x43fd24
0043fcec: ldrb     w8, [x19, #0xc]
0043fcf0: mov      x21, x0
0043fcf4: adrp     x9, #0x556000
0043fcf8: add      x9, x9, #0xda0
0043fcfc: str      x9, [x19]
0043fd00: cbnz     w8, #0x43fd0c
0043fd04: ldr      w1, [x19, #8]
0043fd08: b        #0x43fd14
0043fd0c: adrp     x8, #0x59f000
0043fd10: ldr      w1, [x8, #0x194]
0043fd14: adrp     x0, #0x27000
0043fd18: add      x0, x0, #0x2b4
0043fd1c: bl       #0x553fa0 ; printf
0043fd20: b        #0x43fd28
0043fd24: mov      x21, x0
0043fd28: ldr      x8, [x22, #0x28]
0043fd2c: ldur     x9, [x29, #-8]
0043fd30: cmp      x8, x9
0043fd34: b.ne     #0x43fd48
0043fd38: mov      x0, x19
0043fd3c: bl       #0x54e070
0043fd40: mov      x0, x21
0043fd44: bl       #0x54fffc
0043fd48: bl       #0x553f00 ; __stack_chk_fail
