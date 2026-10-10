004409e4: stp      x29, x30, [sp, #-0x40]!
004409e8: stp      x28, x23, [sp, #0x10]
004409ec: stp      x22, x21, [sp, #0x20]
004409f0: stp      x20, x19, [sp, #0x30]
004409f4: mov      x29, sp
004409f8: sub      sp, sp, #0x7e0
004409fc: mrs      x23, tpidr_el0
00440a00: adrp     x1, #0x2b000
00440a04: add      x1, x1, #0x8cf
00440a08: ldr      x8, [x23, #0x28]
00440a0c: mov      x19, x0
00440a10: stur     x8, [x29, #-8]
00440a14: bl       #0x440d94
00440a18: cbz      x0, #0x440c70
00440a1c: movi     v0.2d, #0000000000000000
00440a20: adrp     x1, #0x28000
00440a24: add      x1, x1, #0x6ee
00440a28: mov      x20, x0
00440a2c: str      xzr, [sp, #0x6c0]
00440a30: str      q0, [sp, #0x7c0]
00440a34: str      q0, [sp, #0x7b0]
00440a38: str      q0, [sp, #0x7a0]
00440a3c: str      q0, [sp, #0x790]
00440a40: str      q0, [sp, #0x780]
00440a44: str      q0, [sp, #0x770]
00440a48: str      q0, [sp, #0x760]
00440a4c: str      q0, [sp, #0x750]
00440a50: str      q0, [sp, #0x740]
00440a54: str      q0, [sp, #0x730]
00440a58: str      q0, [sp, #0x720]
00440a5c: str      q0, [sp, #0x710]
00440a60: str      q0, [sp, #0x700]
00440a64: str      q0, [sp, #0x6f0]
00440a68: str      q0, [sp, #0x6e0]
00440a6c: str      q0, [sp, #0x6d0]
00440a70: str      q0, [sp, #0x6b0]
00440a74: str      q0, [sp, #0x6a0]
00440a78: str      q0, [sp, #0x690]
00440a7c: bl       #0x554220 ; strstr
00440a80: cbz      x0, #0x440b3c
00440a84: add      x21, x0, #6
00440a88: mov      w1, #0x2f
00440a8c: mov      x0, x21
00440a90: bl       #0x554620 ; strchr
00440a94: sub      x22, x0, x21
00440a98: add      x0, sp, #0x690
00440a9c: mov      x1, x21
00440aa0: mov      x2, x22
00440aa4: mov      w3, #0x38
00440aa8: add      x21, sp, #0x690
00440aac: bl       #0x554a70 ; __strncpy_chk
00440ab0: adrp     x1, #0x25000
00440ab4: add      x1, x1, #0x406
00440ab8: mov      x0, x20
00440abc: strb     wzr, [x21, x22]
00440ac0: bl       #0x554220 ; strstr
00440ac4: add      x21, x0, #3
00440ac8: mov      x0, x20
00440acc: mov      w1, #0x28
00440ad0: bl       #0x554620 ; strchr
00440ad4: mvn      x8, x21
00440ad8: sub      x2, x0, x21
00440adc: mov      x1, x21
00440ae0: add      x22, x8, x0
00440ae4: add      x0, sp, #0x6d0
00440ae8: mov      w3, #0x100
00440aec: add      x21, sp, #0x6d0
00440af0: bl       #0x554a70 ; __strncpy_chk
00440af4: adrp     x1, #0x2a000
00440af8: add      x1, x1, #0x476
00440afc: add      x0, sp, #0x6d0
00440b00: strb     wzr, [x21, x22]
00440b04: bl       #0x554220 ; strstr
00440b08: cbz      x0, #0x440b3c
00440b0c: mov      x21, x0
00440b10: add      x0, x0, #3
00440b14: bl       #0x553f20 ; strlen
00440b18: mov      x8, x0
00440b1c: add      x0, x21, #2
00440b20: add      x1, x21, #3
00440b24: add      x2, x8, #1
00440b28: bl       #0x553f10 ; memmove
00440b2c: mov      w8, #0x6564
00440b30: mov      w9, #0x76
00440b34: strh     w8, [x21]
00440b38: strb     w9, [x21, #2]
00440b3c: mov      x0, x20
00440b40: bl       #0x554230 ; free
00440b44: movi     v0.2d, #0000000000000000
00440b48: mov      w8, #5
00440b4c: add      x9, sp, #0x6d0
00440b50: adrp     x3, #0x2a000
00440b54: add      x3, x3, #0xf80
00440b58: add      x0, sp, #0x520
00440b5c: orr      x4, x9, x8
00440b60: mov      w1, #0x64
00440b64: mov      w2, #0x64
00440b68: str      wzr, [sp, #0x580]
00440b6c: str      q0, [sp, #0x680]
00440b70: str      q0, [sp, #0x670]
00440b74: str      q0, [sp, #0x660]
00440b78: str      q0, [sp, #0x650]
00440b7c: str      q0, [sp, #0x640]
00440b80: str      q0, [sp, #0x630]
00440b84: str      q0, [sp, #0x620]
00440b88: str      q0, [sp, #0x610]
00440b8c: str      q0, [sp, #0x600]
00440b90: str      q0, [sp, #0x5f0]
00440b94: str      q0, [sp, #0x5e0]
00440b98: str      q0, [sp, #0x5d0]
00440b9c: str      q0, [sp, #0x5c0]
00440ba0: str      q0, [sp, #0x5b0]
00440ba4: str      q0, [sp, #0x5a0]
00440ba8: str      q0, [sp, #0x590]
00440bac: str      q0, [sp, #0x570]
00440bb0: str      q0, [sp, #0x560]
00440bb4: str      q0, [sp, #0x550]
00440bb8: str      q0, [sp, #0x540]
00440bbc: str      q0, [sp, #0x530]
00440bc0: str      q0, [sp, #0x520]
00440bc4: bl       #0x41dd88
00440bc8: adrp     x3, #0x22000
00440bcc: add      x3, x3, #0x993
00440bd0: add      x0, sp, #0x590
00440bd4: add      x4, sp, #0x690
00440bd8: mov      w1, #0x100
00440bdc: mov      w2, #0x100
00440be0: bl       #0x41dd88
00440be4: mov      x0, sp
00440be8: add      x1, sp, #0x520
00440bec: mov      w2, wzr
00440bf0: bl       #0x554a80 ; regcomp
00440bf4: cbnz     w0, #0x440d4c
00440bf8: add      x0, sp, #0x120
00440bfc: mov      w1, wzr
00440c00: mov      w2, #0x400
00440c04: bl       #0x554090 ; memset
00440c08: add      x1, sp, #0x590
00440c0c: mov      x2, sp
00440c10: add      x3, sp, #0x120
00440c14: mov      x0, x19
00440c18: bl       #0x440e98
00440c1c: cbz      w0, #0x440c7c
00440c20: adrp     x2, #0x29000
00440c24: add      x2, x2, #0x80c
00440c28: add      x0, sp, #0x20
00440c2c: add      x3, sp, #0x120
00440c30: mov      w1, #0x100
00440c34: bl       #0x440940
00440c38: add      x1, sp, #0x20
00440c3c: mov      x0, x19
00440c40: bl       #0x440d94
00440c44: cbz      x0, #0x440c88
00440c48: mov      x21, x0
00440c4c: bl       #0x553f20 ; strlen
00440c50: add      x8, x21, x0
00440c54: mov      x0, x21
00440c58: sturb    wzr, [x8, #-1]
00440c5c: bl       #0x554a40 ; atoi
00440c60: mov      w20, w0
00440c64: mov      x0, x21
00440c68: bl       #0x554230 ; free
00440c6c: b        #0x440c8c
00440c70: adrp     x0, #0x25000
00440c74: add      x0, x0, #0x41d
00440c78: b        #0x440d1c
00440c7c: adrp     x0, #0x29000
00440c80: add      x0, x0, #0x3a
00440c84: bl       #0x553f60 ; puts
00440c88: mov      w20, wzr
00440c8c: mov      x0, sp
00440c90: bl       #0x554a90 ; regfree
00440c94: ldrb     w8, [sp, #0x6d0]
00440c98: cbz      w8, #0x440d20
00440c9c: add      x1, sp, #0x6d0
00440ca0: mov      x0, x19
00440ca4: mov      w2, w20
00440ca8: mov      w3, wzr
00440cac: bl       #0x440fe8
00440cb0: add      x0, sp, #0x6d0
00440cb4: mov      w1, #1
00440cb8: mov      w20, #1
00440cbc: bl       #0x554130 ; __open_2
00440cc0: cmn      w0, #1
00440cc4: str      w0, [x19, #0x10]
00440cc8: b.eq     #0x440cfc
00440ccc: adrp     x0, #0x22000
00440cd0: add      x0, x0, #0x9d7 ; '\n[-] 驱动已经启动'
00440cd4: strb     w20, [x19, #0xd]
00440cd8: bl       #0x553f60 ; puts
00440cdc: add      x0, sp, #0x6d0
00440ce0: bl       #0x554aa0 ; unlink
00440ce4: cbnz     w0, #0x440d70
00440ce8: adrp     x0, #0x2b000
00440cec: add      x0, x0, #0x92d ; '[-] 驱动安全守护已激活'
00440cf0: bl       #0x553f60 ; puts
00440cf4: mov      w0, #1
00440cf8: b        #0x440d24
00440cfc: adrp     x0, #0x23000
00440d00: add      x0, x0, #0x57f ; '\n[-] 驱动链接失败'
00440d04: bl       #0x553f60 ; puts
00440d08: add      x0, sp, #0x6d0
00440d0c: bl       #0x554aa0 ; unlink
00440d10: cbnz     w0, #0x440d80
00440d14: adrp     x0, #0x2b000
00440d18: add      x0, x0, #0x92d ; '[-] 驱动安全守护已激活'
00440d1c: bl       #0x553f60 ; puts
00440d20: mov      w0, #-1
00440d24: ldr      x8, [x23, #0x28]
00440d28: ldur     x9, [x29, #-8]
00440d2c: cmp      x8, x9
00440d30: b.ne     #0x440d90
00440d34: add      sp, sp, #0x7e0
00440d38: ldp      x20, x19, [sp, #0x30]
00440d3c: ldp      x22, x21, [sp, #0x20]
00440d40: ldp      x28, x23, [sp, #0x10]
00440d44: ldp      x29, x30, [sp], #0x40
00440d48: ret      
00440d4c: adrp     x8, #0x563000
00440d50: adrp     x0, #0x2b000
00440d54: add      x0, x0, #0x914
00440d58: ldr      x8, [x8, #0x138]
00440d5c: mov      w1, #0x18
00440d60: mov      w2, #1
00440d64: ldr      x3, [x8]
00440d68: bl       #0x554510 ; fwrite
00440d6c: b        #0x440d20
00440d70: adrp     x0, #0x2a000
00440d74: add      x0, x0, #0xf9a ; '[-] 驱动安全守护执行错误\n'
00440d78: bl       #0x554ab0 ; perror
00440d7c: b        #0x440cf4
00440d80: adrp     x0, #0x2a000
00440d84: add      x0, x0, #0xf9a ; '[-] 驱动安全守护执行错误\n'
00440d88: bl       #0x554ab0 ; perror
00440d8c: b        #0x440d20
00440d90: bl       #0x553f00 ; __stack_chk_fail
