00427698: stp      x29, x30, [sp, #-0x60]!
0042769c: stp      x28, x27, [sp, #0x10]
004276a0: stp      x26, x25, [sp, #0x20]
004276a4: stp      x24, x23, [sp, #0x30]
004276a8: stp      x22, x21, [sp, #0x40]
004276ac: stp      x20, x19, [sp, #0x50]
004276b0: mov      x29, sp
004276b4: sub      sp, sp, #0x200
004276b8: mrs      x23, tpidr_el0
004276bc: adrp     x21, #0x562000
004276c0: adrp     x25, #0x562000
004276c4: ldr      x21, [x21, #0xea8]
004276c8: ldr      x8, [x23, #0x28]
004276cc: ldr      x25, [x25, #0xea0]
004276d0: add      x24, sp, #0xa0
004276d4: mov      x19, x0
004276d8: stur     x8, [x29, #-0x10]
004276dc: ldp      x8, x9, [x25, #8]
004276e0: add      x22, x21, #0x40
004276e4: str      x22, [sp, #0x158]
004276e8: str      x8, [sp, #0xa0]
004276ec: ldur     x8, [x8, #-0x18]
004276f0: str      xzr, [sp, #0xa8]
004276f4: str      x9, [x24, x8]
004276f8: ldr      x8, [sp, #0xa0]
004276fc: ldur     x8, [x8, #-0x18]
00427700: add      x20, x24, x8
00427704: add      x1, x24, #0x10
00427708: mov      x0, x20
0042770c: bl       #0x50ed04
00427710: mov      w8, #-1
00427714: add      x9, x21, #0x18
00427718: str      xzr, [x20, #0x88]
0042771c: str      w8, [x20, #0x90]
00427720: str      x9, [sp, #0xa0]
00427724: str      x22, [sp, #0x158]
00427728: add      x0, x24, #0x10
0042772c: bl       #0x510e4c
00427730: adrp     x1, #0x26000
00427734: add      x1, x1, #0xda8 ; '/DATA/ADB/dynamic_draw_lolm.ini'
00427738: add      x0, sp, #0xa0
0042773c: mov      w2, #8
00427740: add      x20, sp, #0xa0
00427744: bl       #0x510cd8
00427748: ldr      x8, [sp, #0xa0]
0042774c: mov      w21, #5
00427750: ldur     x8, [x8, #-0x18]
00427754: add      x0, x20, x8
00427758: ldrb     w8, [x0, #0x20]
0042775c: tst      w8, w21
00427760: b.eq     #0x4277c0
00427764: mov      w1, wzr
00427768: bl       #0x50ec24
0042776c: adrp     x1, #0x2a000
00427770: add      x1, x1, #0x392 ; '/data/adb/dynamic_draw_lolm.ini'
00427774: add      x0, sp, #0xa0
00427778: mov      w2, #8
0042777c: add      x20, sp, #0xa0
00427780: bl       #0x510cd8
00427784: ldr      x8, [sp, #0xa0]
00427788: mov      w9, #5
0042778c: ldur     x8, [x8, #-0x18]
00427790: add      x0, x20, x8
00427794: ldrb     w8, [x0, #0x20]
00427798: tst      w8, w9
0042779c: b.eq     #0x4277d0
004277a0: mov      w1, wzr
004277a4: bl       #0x50ec24
004277a8: adrp     x1, #0x2a000
004277ac: add      x1, x1, #0xef2
004277b0: add      x0, x19, #0x360
004277b4: bl       #0x50c208
004277b8: mov      w19, wzr
004277bc: b        #0x428258
004277c0: adrp     x8, #0x26000
004277c4: add      x8, x8, #0xda8 ; '/DATA/ADB/dynamic_draw_lolm.ini'
004277c8: str      x23, [sp, #8]
004277cc: b        #0x4277dc
004277d0: str      x23, [sp, #8]
004277d4: adrp     x8, #0x2a000
004277d8: add      x8, x8, #0x392 ; '/data/adb/dynamic_draw_lolm.ini'
004277dc: str      x8, [sp]
004277e0: add      x8, sp, #0x70
004277e4: add      x9, sp, #0x40
004277e8: add      x26, x8, #8
004277ec: add      x8, sp, #0x58
004277f0: stp      xzr, xzr, [sp, #0x78]
004277f4: orr      x28, x8, #1
004277f8: orr      x8, x9, #1
004277fc: str      x26, [sp, #0x70]
00427800: stp      xzr, xzr, [sp, #0x58]
00427804: adrp     x27, #0x562000
00427808: add      x23, sp, #0xa0
0042780c: str      x8, [sp, #0x10]
00427810: add      x8, sp, #0x88
00427814: ldr      x27, [x27, #0xe98]
00427818: orr      x8, x8, #1
0042781c: str      xzr, [sp, #0x68]
00427820: str      x8, [sp, #0x18]
00427824: ldr      x8, [sp, #0xa0]
00427828: ldur     x9, [x8, #-0x18]
0042782c: add      x8, sp, #0x40
00427830: add      x0, x23, x9
00427834: bl       #0x50eb5c
00427838: add      x0, sp, #0x40
0042783c: mov      x1, x27
00427840: bl       #0x52d1b4
00427844: ldr      x8, [x0]
00427848: ldr      x8, [x8, #0x38]
0042784c: mov      w1, #0xa
00427850: blr      x8
00427854: mov      w22, w0
00427858: add      x0, sp, #0x40
0042785c: bl       #0x52d0b4
00427860: add      x0, sp, #0xa0
00427864: add      x1, sp, #0x58
00427868: mov      w2, w22
0042786c: bl       #0x3a0e34
00427870: ldr      x8, [x0]
00427874: ldur     x8, [x8, #-0x18]
00427878: add      x8, x0, x8
0042787c: ldrb     w8, [x8, #0x20]
00427880: tst      w8, w21
00427884: b.ne     #0x427b2c
00427888: add      x0, sp, #0x58
0042788c: mov      w1, #0x3d
00427890: mov      x2, xzr
00427894: bl       #0x50bc48
00427898: add      x20, x0, #1
0042789c: cmp      x20, #2
004278a0: b.lo     #0x427824
004278a4: ldrb     w9, [sp, #0x58]
004278a8: ldr      x8, [sp, #0x60]
004278ac: lsr      x10, x9, #1
004278b0: tst      w9, #1
004278b4: csel     x8, x10, x8, eq
004278b8: subs     x23, x8, x20
004278bc: b.lo     #0x4282dc
004278c0: ldr      x10, [sp, #0x68]
004278c4: tst      w9, #1
004278c8: csel     x21, x28, x10, eq
004278cc: cmn      x23, #0x10
004278d0: b.hs     #0x4282f8
004278d4: mov      x22, x0
004278d8: cmp      x23, #0x17
004278dc: b.hs     #0x4278f8
004278e0: lsl      w9, w23, #1
004278e4: ldr      x25, [sp, #0x10]
004278e8: cmp      x8, x20
004278ec: strb     w9, [sp, #0x40]
004278f0: b.ne     #0x427918
004278f4: b        #0x427928
004278f8: orr      x8, x23, #0xf
004278fc: add      x24, x8, #1
00427900: mov      x0, x24
00427904: bl       #0x54dfc0
00427908: orr      x8, x24, #1
0042790c: mov      x25, x0
00427910: stp      x23, x0, [sp, #0x48]
00427914: str      x8, [sp, #0x40]
00427918: add      x1, x21, x20
0042791c: mov      x0, x25
00427920: mov      x2, x23
00427924: bl       #0x553f10 ; memmove
00427928: ldrb     w8, [sp, #0x58]
0042792c: strb     wzr, [x25, x23]
00427930: lsr      x9, x8, #1
00427934: tst      w8, #1
00427938: ldp      x10, x8, [sp, #0x60]
0042793c: csel     x9, x9, x10, eq
00427940: csel     x24, x28, x8, eq
00427944: cmp      x9, x22
00427948: csel     x22, x9, x22, lo
0042794c: cmn      x22, #0x10
00427950: b.hs     #0x4282c0
00427954: cmp      x22, #0x17
00427958: b.hs     #0x427970
0042795c: lsl      w8, w22, #1
00427960: ldr      x23, [sp, #0x18]
00427964: strb     w8, [sp, #0x88]
00427968: cbnz     x22, #0x427990
0042796c: b        #0x4279a0
00427970: orr      x8, x22, #0xf
00427974: add      x25, x8, #1
00427978: mov      x0, x25
0042797c: bl       #0x54dfc0
00427980: orr      x8, x25, #1
00427984: mov      x23, x0
00427988: stp      x22, x0, [sp, #0x90]
0042798c: str      x8, [sp, #0x88]
00427990: mov      x0, x23
00427994: mov      x1, x24
00427998: mov      x2, x22
0042799c: bl       #0x553f10 ; memmove
004279a0: ldr      x8, [sp, #0x78]
004279a4: strb     wzr, [x23, x22]
004279a8: mov      x23, x26
004279ac: mov      x25, x26
004279b0: cbz      x8, #0x427a6c
004279b4: ldrb     w9, [sp, #0x88]
004279b8: ldp      x11, x12, [sp, #0x90]
004279bc: lsr      x10, x9, #1
004279c0: tst      w9, #1
004279c4: ldr      x9, [sp, #0x18]
004279c8: csel     x20, x10, x11, eq
004279cc: csel     x22, x9, x12, eq
004279d0: b        #0x4279e0
004279d4: ldr      x8, [x25]
004279d8: mov      x23, x25
004279dc: cbz      x8, #0x427a6c
004279e0: mov      x25, x8
004279e4: ldrb     w8, [x8, #0x20]
004279e8: mov      x0, x22
004279ec: ldp      x9, x11, [x25, #0x28]
004279f0: lsr      x10, x8, #1
004279f4: tst      w8, #1
004279f8: add      x8, x25, #0x21
004279fc: csel     x21, x10, x9, eq
00427a00: csel     x23, x8, x11, eq
00427a04: cmp      x21, x20
00427a08: mov      x1, x23
00427a0c: csel     x24, x21, x20, lo
00427a10: mov      x2, x24
00427a14: bl       #0x553f50 ; memcmp
00427a18: cmp      x20, x21
00427a1c: cset     w8, lo
00427a20: cmp      w0, #0
00427a24: cset     w9, lt
00427a28: csel     w8, w8, w9, eq
00427a2c: cmp      w8, #1
00427a30: b.eq     #0x4279d4
00427a34: mov      x0, x23
00427a38: mov      x1, x22
00427a3c: mov      x2, x24
00427a40: bl       #0x553f50 ; memcmp
00427a44: cmp      x21, x20
00427a48: cset     w8, lo
00427a4c: cmp      w0, #0
00427a50: cset     w9, lt
00427a54: csel     w8, w8, w9, eq
00427a58: cmp      w8, #1
00427a5c: b.ne     #0x427ad4
00427a60: ldr      x8, [x25, #8]
00427a64: cbnz     x8, #0x4279e0
00427a68: add      x23, x25, #8
00427a6c: mov      w0, #0x50
00427a70: bl       #0x54dfc0
00427a74: mov      w21, #5
00427a78: ldur     q0, [sp, #0x88]
00427a7c: ldr      x8, [sp, #0x98]
00427a80: mov      x22, x0
00427a84: stp      xzr, xzr, [sp, #0x90]
00427a88: mov      x1, x0
00427a8c: str      q0, [x0, #0x20]
00427a90: str      xzr, [sp, #0x88]
00427a94: stp      x8, xzr, [x0, #0x30]
00427a98: stp      xzr, xzr, [x0, #0x40]
00427a9c: stp      xzr, xzr, [x0]
00427aa0: str      x25, [x0, #0x10]
00427aa4: str      x0, [x23]
00427aa8: ldr      x8, [sp, #0x70]
00427aac: ldr      x8, [x8]
00427ab0: cbz      x8, #0x427abc
00427ab4: str      x8, [sp, #0x70]
00427ab8: ldr      x1, [x23]
00427abc: ldr      x0, [sp, #0x78]
00427ac0: bl       #0x39885c
00427ac4: ldr      x8, [sp, #0x80]
00427ac8: add      x8, x8, #1
00427acc: str      x8, [sp, #0x80]
00427ad0: b        #0x427adc
00427ad4: mov      x22, x25
00427ad8: mov      w21, #5
00427adc: mov      x20, x22
00427ae0: add      x23, sp, #0xa0
00427ae4: ldrb     w8, [x20, #0x38]!
00427ae8: tbz      w8, #0, #0x427af4
00427aec: ldr      x0, [x22, #0x48]
00427af0: bl       #0x54e070
00427af4: ldr      q0, [sp, #0x40]
00427af8: ldr      x8, [sp, #0x50]
00427afc: ldrb     w9, [sp, #0x88]
00427b00: strh     wzr, [sp, #0x40]
00427b04: str      q0, [x20]
00427b08: str      x8, [x20, #0x10]
00427b0c: tbz      w9, #0, #0x427824
00427b10: ldr      x0, [sp, #0x98]
00427b14: bl       #0x54e070
00427b18: ldrb     w8, [sp, #0x40]
00427b1c: tbz      w8, #0, #0x427824
00427b20: ldr      x0, [sp, #0x50]
00427b24: bl       #0x54e070
00427b28: b        #0x427824
00427b2c: add      x8, sp, #0x70
00427b30: stp      x8, x8, [sp, #0x30]
00427b34: stp      x8, x8, [sp, #0x20]
00427b38: adrp     x1, #0x25000
00427b3c: add      x1, x1, #0x9bc
00427b40: add      x0, sp, #0x28
00427b44: add      x2, x19, #0x48
00427b48: ldr      x23, [sp, #8]
00427b4c: bl       #0x4326a4
00427b50: adrp     x25, #0x562000
00427b54: add      x24, sp, #0xa0
00427b58: ldr      x25, [x25, #0xea0]
00427b5c: adrp     x1, #0x23000
00427b60: add      x1, x1, #0x511
00427b64: add      x0, sp, #0x28
00427b68: add      x2, x19, #0x49
00427b6c: bl       #0x4326a4
00427b70: adrp     x1, #0x21000
00427b74: add      x1, x1, #0x6da
00427b78: add      x0, sp, #0x28
00427b7c: add      x2, x19, #0x4a
00427b80: bl       #0x4326a4
00427b84: adrp     x1, #0x2a000
00427b88: add      x1, x1, #0x8d9
00427b8c: add      x0, sp, #0x28
00427b90: add      x2, x19, #0x4b
00427b94: bl       #0x4326a4
00427b98: adrp     x1, #0x22000
00427b9c: add      x1, x1, #0x912
00427ba0: add      x0, sp, #0x28
00427ba4: add      x2, x19, #0x4c
00427ba8: bl       #0x4326a4
00427bac: adrp     x1, #0x21000
00427bb0: add      x1, x1, #0x192
00427bb4: add      x0, sp, #0x28
00427bb8: add      x2, x19, #0x4d
00427bbc: bl       #0x4326a4
00427bc0: adrp     x1, #0x22000
00427bc4: add      x1, x1, #0xea6
00427bc8: add      x0, sp, #0x28
00427bcc: add      x2, x19, #0x4e
00427bd0: bl       #0x4326a4
00427bd4: adrp     x1, #0x22000
00427bd8: add      x1, x1, #0x921
00427bdc: add      x0, sp, #0x28
00427be0: add      x2, x19, #0x4f
00427be4: bl       #0x4326a4
00427be8: adrp     x1, #0x25000
00427bec: add      x1, x1, #0x3d2
00427bf0: add      x0, sp, #0x28
00427bf4: add      x2, x19, #0x50
00427bf8: bl       #0x4326a4
00427bfc: adrp     x1, #0x2b000
00427c00: add      x1, x1, #0xd93
00427c04: add      x0, sp, #0x28
00427c08: add      x2, x19, #0x51
00427c0c: bl       #0x4326a4
00427c10: adrp     x1, #0x2a000
00427c14: add      x1, x1, #0x40a
00427c18: add      x0, sp, #0x28
00427c1c: add      x2, x19, #0x52
00427c20: bl       #0x4326a4
00427c24: ldrb     w8, [x19, #0x52]
00427c28: strb     w8, [x19, #0x37b]
00427c2c: adrp     x1, #0x21000
00427c30: add      x1, x1, #0x1a2
00427c34: add      x0, sp, #0x28
00427c38: add      x2, x19, #0x53
00427c3c: bl       #0x4326a4
00427c40: adrp     x1, #0x23000
00427c44: add      x1, x1, #0xb7e
00427c48: add      x0, sp, #0x28
00427c4c: add      x2, x19, #0x54
00427c50: bl       #0x4326a4
00427c54: adrp     x1, #0x25000
00427c58: add      x1, x1, #0x3df
00427c5c: add      x0, sp, #0x28
00427c60: add      x2, x19, #0x55
00427c64: bl       #0x4326a4
00427c68: adrp     x1, #0x21000
00427c6c: add      x1, x1, #0x1ac
00427c70: add      x0, sp, #0x28
00427c74: add      x2, x19, #0x56
00427c78: bl       #0x4326a4
00427c7c: adrp     x1, #0x23000
00427c80: add      x1, x1, #0xb90
00427c84: add      x0, sp, #0x28
00427c88: add      x2, x19, #0x57
00427c8c: bl       #0x4326a4
00427c90: adrp     x1, #0x23000
00427c94: add      x1, x1, #0xfaa
00427c98: add      x0, sp, #0x28
00427c9c: add      x2, x19, #0x58
00427ca0: bl       #0x4326a4
00427ca4: adrp     x1, #0x25000
00427ca8: add      x1, x1, #0x9c4
00427cac: add      x0, sp, #0x28
00427cb0: add      x2, x19, #0x59
00427cb4: bl       #0x4326a4
00427cb8: adrp     x1, #0x25000
00427cbc: add      x1, x1, #0xf16
00427cc0: add      x0, sp, #0x28
00427cc4: add      x2, x19, #0x5a
00427cc8: bl       #0x4326a4
00427ccc: adrp     x1, #0x23000
00427cd0: add      x1, x1, #0x519
00427cd4: add      x0, sp, #0x28
00427cd8: add      x2, x19, #0x5b
00427cdc: bl       #0x4326a4
00427ce0: adrp     x1, #0x28000
00427ce4: add      x1, x1, #0xb89
00427ce8: add      x0, sp, #0x30
00427cec: add      x2, x19, #0x5c
00427cf0: mov      w3, #0x64
00427cf4: mov      w4, #0x7d0
00427cf8: bl       #0x432854
00427cfc: ldur     w8, [x19, #0x5c]
00427d00: cmp      w8, #0x258
00427d04: b.eq     #0x427d20
00427d08: cmp      w8, #0x3e8
00427d0c: b.eq     #0x427d20
00427d10: cmp      w8, #0x578
00427d14: b.eq     #0x427d20
00427d18: mov      w8, #0x3e8
00427d1c: stur     w8, [x19, #0x5c]
00427d20: mov      w4, #0x86a0
00427d24: adrp     x1, #0x27000
00427d28: add      x1, x1, #0x344
00427d2c: add      x0, sp, #0x30
00427d30: add      x2, x19, #0x60
00427d34: mov      w3, #0x2710
00427d38: movk     w4, #1, lsl #16
00427d3c: bl       #0x432854
00427d40: mov      w8, #-0x3c6a0000
00427d44: mov      w9, #0x43960000
00427d48: adrp     x1, #0x24000
00427d4c: add      x1, x1, #0x5dd
00427d50: fmov     s0, w8
00427d54: fmov     s1, w9
00427d58: add      x0, sp, #0x38
00427d5c: add      x2, x19, #0x64
00427d60: bl       #0x4329d4
00427d64: mov      w8, #-0x3c6a0000
00427d68: mov      w9, #0x43960000
00427d6c: adrp     x1, #0x22000
00427d70: add      x1, x1, #0x92b
00427d74: fmov     s0, w8
00427d78: fmov     s1, w9
00427d7c: add      x0, sp, #0x38
00427d80: add      x2, x19, #0x68
00427d84: bl       #0x4329d4
00427d88: mov      w8, #0x4000
00427d8c: movi     d0, #0000000000000000
00427d90: adrp     x1, #0x23000
00427d94: add      x1, x1, #0xfba
00427d98: movk     w8, #0x461c, lsl #16
00427d9c: add      x0, sp, #0x38
00427da0: fmov     s1, w8
00427da4: add      x2, x19, #0x88
00427da8: bl       #0x4329d4
00427dac: mov      w8, #0x4000
00427db0: movi     d0, #0000000000000000
00427db4: adrp     x1, #0x24000
00427db8: add      x1, x1, #0x5ef
00427dbc: movk     w8, #0x461c, lsl #16
00427dc0: add      x0, sp, #0x38
00427dc4: fmov     s1, w8
00427dc8: add      x2, x19, #0x8c
00427dcc: bl       #0x4329d4
00427dd0: mov      w8, #0x4000
00427dd4: movi     d0, #0000000000000000
00427dd8: adrp     x1, #0x27000
00427ddc: add      x1, x1, #0x869
00427de0: movk     w8, #0x461c, lsl #16
00427de4: add      x0, sp, #0x38
00427de8: fmov     s1, w8
00427dec: add      x2, x19, #0x90
00427df0: bl       #0x4329d4
00427df4: mov      w8, #0x4000
00427df8: movi     d0, #0000000000000000
00427dfc: adrp     x1, #0x26000
00427e00: add      x1, x1, #0xe13
00427e04: movk     w8, #0x461c, lsl #16
00427e08: add      x0, sp, #0x38
00427e0c: fmov     s1, w8
00427e10: add      x2, x19, #0x94
00427e14: bl       #0x4329d4
00427e18: adrp     x1, #0x2b000
00427e1c: add      x1, x1, #0x875
00427e20: add      x0, sp, #0x28
00427e24: add      x2, x19, #0x98
00427e28: bl       #0x4326a4
00427e2c: mov      w8, #0x425c0000
00427e30: fmov     s0, #1.00000000
00427e34: adrp     x1, #0x2a000
00427e38: add      x1, x1, #0x8eb
00427e3c: fmov     s1, w8
00427e40: add      x0, sp, #0x38
00427e44: add      x2, x19, #0x9c
00427e48: bl       #0x4329d4
00427e4c: ldurb    w8, [x19, #0x98]
00427e50: cbz      w8, #0x427e64
00427e54: mov      w8, #1
00427e58: strb     w8, [x19, #0xb1]
00427e5c: bl       #0x50aaf8
00427e60: str      x0, [x19, #0xb8]
00427e64: adrp     x1, #0x22000
00427e68: add      x1, x1, #0xeb7
00427e6c: add      x0, sp, #0x30
00427e70: add      x2, x19, #0xd8
00427e74: mov      w3, wzr
00427e78: mov      w4, #2
00427e7c: bl       #0x432854
00427e80: fmov     s0, #0.50000000
00427e84: fmov     s1, #1.50000000
00427e88: adrp     x1, #0x22000
00427e8c: add      x1, x1, #0x93d
00427e90: add      x0, sp, #0x38
00427e94: add      x2, x19, #0xec
00427e98: bl       #0x4329d4
00427e9c: movi     d1, #0000000000000000
00427ea0: mov      w8, #-0x3cb80000
00427ea4: adrp     x1, #0x23000
00427ea8: add      x1, x1, #0xfc6
00427eac: fmov     s0, w8
00427eb0: add      x0, sp, #0x38
00427eb4: add      x2, x19, #0xf0
00427eb8: bl       #0x4329d4
00427ebc: mov      w8, #-0x3c060000
00427ec0: mov      w9, #0x43fa0000
00427ec4: adrp     x1, #0x21000
00427ec8: add      x1, x1, #0x6e6
00427ecc: fmov     s0, w8
00427ed0: fmov     s1, w9
00427ed4: add      x0, sp, #0x38
00427ed8: add      x2, x19, #0xf4
00427edc: bl       #0x4329d4
00427ee0: mov      w8, #-0x3c060000
00427ee4: mov      w9, #0x43fa0000
00427ee8: adrp     x1, #0x20000
00427eec: add      x1, x1, #0xd29
00427ef0: fmov     s0, w8
00427ef4: fmov     s1, w9
00427ef8: add      x0, sp, #0x38
00427efc: add      x2, x19, #0xf8
00427f00: bl       #0x4329d4
00427f04: mov      w8, #0x3333
00427f08: fmov     s1, #5.00000000
00427f0c: adrp     x1, #0x24000
00427f10: add      x1, x1, #0x5fb
00427f14: movk     w8, #0x3f33, lsl #16
00427f18: add      x0, sp, #0x38
00427f1c: fmov     s0, w8
00427f20: add      x2, x19, #0xfc
00427f24: bl       #0x4329d4
00427f28: mov      w8, #0x4000
00427f2c: movi     d0, #0000000000000000
00427f30: adrp     x1, #0x26000
00427f34: add      x1, x1, #0x981
00427f38: movk     w8, #0x461c, lsl #16
00427f3c: add      x0, sp, #0x38
00427f40: fmov     s1, w8
00427f44: add      x2, x19, #0x100
00427f48: bl       #0x4329d4
00427f4c: mov      w8, #0x4000
00427f50: movi     d0, #0000000000000000
00427f54: adrp     x1, #0x2b000
00427f58: add      x1, x1, #0xda5
00427f5c: movk     w8, #0x461c, lsl #16
00427f60: add      x0, sp, #0x38
00427f64: fmov     s1, w8
00427f68: add      x2, x19, #0x104
00427f6c: bl       #0x4329d4
00427f70: mov      w8, #0x42480000
00427f74: fmov     s0, #3.00000000
00427f78: adrp     x1, #0x20000
00427f7c: add      x1, x1, #0xd38
00427f80: fmov     s1, w8
00427f84: add      x0, sp, #0x38
00427f88: add      x2, x19, #0x108
00427f8c: bl       #0x4329d4
00427f90: mov      w8, #0x42700000
00427f94: fmov     s0, #8.00000000
00427f98: adrp     x1, #0x21000
00427f9c: add      x1, x1, #0x6f5
00427fa0: fmov     s1, w8
00427fa4: add      x0, sp, #0x38
00427fa8: add      x2, x19, #0x10c
00427fac: bl       #0x4329d4
00427fb0: fmov     s0, #0.50000000
00427fb4: fmov     s1, #8.00000000
00427fb8: adrp     x1, #0x2a000
00427fbc: add      x1, x1, #0x41d
00427fc0: add      x0, sp, #0x38
00427fc4: add      x2, x19, #0x110
00427fc8: bl       #0x4329d4
00427fcc: mov      w8, #-0x3cae0000
00427fd0: mov      w9, #0x43520000
00427fd4: adrp     x1, #0x2a000
00427fd8: add      x1, x1, #0xf1a
00427fdc: fmov     s0, w8
00427fe0: fmov     s1, w9
00427fe4: add      x0, sp, #0x38
00427fe8: add      x2, x19, #0x114
00427fec: bl       #0x4329d4
00427ff0: mov      w8, #-0x3cae0000
00427ff4: mov      w9, #0x43520000
00427ff8: adrp     x1, #0x29000
00427ffc: add      x1, x1, #0xe79
00428000: fmov     s0, w8
00428004: fmov     s1, w9
00428008: add      x0, sp, #0x38
0042800c: add      x2, x19, #0x118
00428010: bl       #0x4329d4
00428014: fmov     s0, #0.25000000
00428018: fmov     s1, #3.00000000
0042801c: adrp     x1, #0x29000
00428020: add      x1, x1, #0x7a1
00428024: add      x0, sp, #0x38
00428028: add      x2, x19, #0x11c
0042802c: bl       #0x4329d4
00428030: fmov     s0, #0.25000000
00428034: fmov     s1, #3.00000000
00428038: adrp     x1, #0x27000
0042803c: add      x1, x1, #0x34f
00428040: add      x0, sp, #0x38
00428044: add      x2, x19, #0x120
00428048: bl       #0x4329d4
0042804c: mov      w8, #0x42a00000
00428050: fmov     s0, #3.00000000
00428054: adrp     x1, #0x27000
00428058: add      x1, x1, #0x364
0042805c: fmov     s1, w8
00428060: add      x0, sp, #0x38
00428064: add      x2, x19, #0x124
00428068: bl       #0x4329d4
0042806c: mov      w8, #0x42a00000
00428070: fmov     s0, #8.00000000
00428074: adrp     x1, #0x21000
00428078: add      x1, x1, #0x70b
0042807c: fmov     s1, w8
00428080: add      x0, sp, #0x38
00428084: add      x2, x19, #0x128
00428088: bl       #0x4329d4
0042808c: mov      w8, #0x42a00000
00428090: fmov     s0, #8.00000000
00428094: adrp     x1, #0x24000
00428098: add      x1, x1, #0xaf2
0042809c: fmov     s1, w8
004280a0: add      x0, sp, #0x38
004280a4: add      x2, x19, #0x12c
004280a8: bl       #0x4329d4
004280ac: mov      w8, #0x42c80000
004280b0: fmov     s0, #4.00000000
004280b4: adrp     x1, #0x27000
004280b8: add      x1, x1, #0x375
004280bc: fmov     s1, w8
004280c0: add      x0, sp, #0x38
004280c4: add      x2, x19, #0x130
004280c8: bl       #0x4329d4
004280cc: mov      w8, #0x4000
004280d0: movi     d0, #0000000000000000
004280d4: adrp     x1, #0x21000
004280d8: add      x1, x1, #0x720
004280dc: movk     w8, #0x461c, lsl #16
004280e0: add      x0, sp, #0x38
004280e4: fmov     s1, w8
004280e8: add      x2, x19, #0x134
004280ec: bl       #0x4329d4
004280f0: mov      w8, #0x4000
004280f4: movi     d0, #0000000000000000
004280f8: adrp     x1, #0x28000
004280fc: add      x1, x1, #0x26a
00428100: movk     w8, #0x461c, lsl #16
00428104: add      x0, sp, #0x38
00428108: fmov     s1, w8
0042810c: add      x2, x19, #0x138
00428110: bl       #0x4329d4
00428114: mov      w8, #0x42a00000
00428118: fmov     s0, #-30.00000000
0042811c: adrp     x1, #0x28000
00428120: add      x1, x1, #0x27c
00428124: fmov     s1, w8
00428128: add      x0, sp, #0x38
0042812c: add      x2, x19, #0x13c
00428130: bl       #0x4329d4
00428134: adrp     x1, #0x22000
00428138: add      x1, x1, #0x94a
0042813c: add      x0, sp, #0x20
00428140: add      x2, x19, #0x144
00428144: bl       #0x432b50
00428148: adrp     x1, #0x28000
0042814c: add      x1, x1, #0x28b
00428150: add      x0, sp, #0x20
00428154: add      x2, x19, #0x154
00428158: bl       #0x432b50
0042815c: adrp     x1, #0x23000
00428160: add      x1, x1, #0xb9f
00428164: add      x0, sp, #0x20
00428168: add      x2, x19, #0x164
0042816c: bl       #0x432b50
00428170: movi     d0, #0000000000000000
00428174: mov      w8, #0x42c80000
00428178: adrp     x1, #0x23000
0042817c: add      x1, x1, #0x525
00428180: fmov     s1, w8
00428184: add      x0, sp, #0x38
00428188: add      x2, x19, #0x174
0042818c: bl       #0x4329d4
00428190: adrp     x1, #0x27000
00428194: add      x1, x1, #0xcda
00428198: add      x0, sp, #0x20
0042819c: add      x2, x19, #0x178
004281a0: bl       #0x432b50
004281a4: adrp     x9, #0x20000
004281a8: add      x9, x9, #0xd4a
004281ac: mov      w8, #1
004281b0: ldr      q0, [x9]
004281b4: mov      w10, #0x22
004281b8: strb     w8, [x19, #0x140]
004281bc: mov      w8, #0x20
004281c0: strb     w10, [sp, #0x40]
004281c4: stur     q0, [sp, #0x41]
004281c8: sturh    w8, [sp, #0x51]
004281cc: ldr      x1, [sp]
004281d0: add      x0, sp, #0x40
004281d4: bl       #0x50c46c
004281d8: ldur     x8, [x0, #2]
004281dc: ldrb     w22, [x0]
004281e0: ldrb     w21, [x0, #1]
004281e4: str      x8, [sp, #0x88]
004281e8: ldp      x8, x20, [x0, #8]
004281ec: stur     x8, [sp, #0x8e]
004281f0: stp      xzr, xzr, [x0, #8]
004281f4: str      xzr, [x0]
004281f8: ldrb     w8, [x19, #0x360]
004281fc: tbz      w8, #0, #0x428208
00428200: ldr      x0, [x19, #0x370]
00428204: bl       #0x54e070
00428208: ldur     x8, [sp, #0x8e]
0042820c: ldr      x9, [sp, #0x88]
00428210: add      x10, x19, #0x362
00428214: ldrb     w11, [sp, #0x40]
00428218: strb     w22, [x19, #0x360]
0042821c: strb     w21, [x19, #0x361]
00428220: str      x8, [x19, #0x368]
00428224: str      x9, [x10]
00428228: str      x20, [x19, #0x370]
0042822c: tbz      w11, #0, #0x428238
00428230: ldr      x0, [sp, #0x50]
00428234: bl       #0x54e070
00428238: ldrb     w8, [sp, #0x58]
0042823c: tbz      w8, #0, #0x428248
00428240: ldr      x0, [sp, #0x68]
00428244: bl       #0x54e070
00428248: ldr      x1, [sp, #0x78]
0042824c: add      x0, sp, #0x70
00428250: bl       #0x4332d4
00428254: mov      w19, #1
00428258: ldr      x8, [x25]
0042825c: ldr      x9, [x25, #0x18]
00428260: add      x10, sp, #0xa0
00428264: add      x0, x24, #0x10
00428268: str      x8, [sp, #0xa0]
0042826c: ldur     x8, [x8, #-0x18]
00428270: str      x9, [x10, x8]
00428274: bl       #0x510f84
00428278: add      x0, sp, #0xa0
0042827c: add      x1, x25, #8
00428280: bl       #0x50f0c4
00428284: add      x0, x24, #0xb8
00428288: bl       #0x50eda8
0042828c: ldr      x8, [x23, #0x28]
00428290: ldur     x9, [x29, #-0x10]
00428294: cmp      x8, x9
00428298: b.ne     #0x428400
0042829c: mov      w0, w19
004282a0: add      sp, sp, #0x200
004282a4: ldp      x20, x19, [sp, #0x50]
004282a8: ldp      x22, x21, [sp, #0x40]
004282ac: ldp      x24, x23, [sp, #0x30]
004282b0: ldp      x26, x25, [sp, #0x20]
004282b4: ldp      x28, x27, [sp, #0x10]
004282b8: ldp      x29, x30, [sp], #0x60
004282bc: ret      
004282c0: ldr      x8, [sp, #8]
004282c4: ldr      x8, [x8, #0x28]
004282c8: ldur     x9, [x29, #-0x10]
004282cc: cmp      x8, x9
004282d0: b.ne     #0x428400
004282d4: add      x0, sp, #0x88
004282d8: bl       #0x39e640
004282dc: ldr      x8, [sp, #8]
004282e0: ldr      x8, [x8, #0x28]
004282e4: ldur     x9, [x29, #-0x10]
004282e8: cmp      x8, x9
004282ec: b.ne     #0x428400
004282f0: add      x0, sp, #0x40
004282f4: bl       #0x3a072c
004282f8: ldr      x8, [sp, #8]
004282fc: ldr      x8, [x8, #0x28]
00428300: ldur     x9, [x29, #-0x10]
00428304: cmp      x8, x9
00428308: b.ne     #0x428400
0042830c: add      x0, sp, #0x40
00428310: bl       #0x39e640
00428314: b        #0x42835c
00428318: ldrb     w8, [sp, #0x40]
0042831c: mov      x19, x0
00428320: tbz      w8, #0, #0x4283c4
00428324: ldr      x0, [sp, #0x50]
00428328: bl       #0x54e070
0042832c: b        #0x4283c4
00428330: mov      x19, x0
00428334: add      x0, sp, #0xa0
00428338: add      x1, x25, #8
0042833c: add      x20, sp, #0xa0
00428340: bl       #0x50f0c4
00428344: b        #0x428350
00428348: add      x20, sp, #0xa0
0042834c: mov      x19, x0
00428350: add      x0, x20, #0xb8
00428354: bl       #0x50eda8
00428358: b        #0x4283e8
0042835c: mov      x19, x0
00428360: b        #0x4283e0
00428364: b        #0x428384
00428368: b        #0x4283bc
0042836c: ldrb     w8, [sp, #0x88]
00428370: mov      x19, x0
00428374: tbz      w8, #0, #0x428388
00428378: ldr      x0, [sp, #0x98]
0042837c: bl       #0x54e070
00428380: b        #0x428388
00428384: mov      x19, x0
00428388: ldrb     w8, [sp, #0x40]
0042838c: tbz      w8, #0, #0x428398
00428390: ldr      x0, [sp, #0x50]
00428394: bl       #0x54e070
00428398: ldr      x23, [sp, #8]
0042839c: b        #0x4283c4
004283a0: b        #0x4283bc
004283a4: b        #0x4283c0
004283a8: mov      x19, x0
004283ac: add      x0, sp, #0x40
004283b0: bl       #0x52d0b4
004283b4: ldr      x23, [sp, #8]
004283b8: b        #0x4283c4
004283bc: ldr      x23, [sp, #8]
004283c0: mov      x19, x0
004283c4: ldrb     w8, [sp, #0x58]
004283c8: tbz      w8, #0, #0x4283d4
004283cc: ldr      x0, [sp, #0x68]
004283d0: bl       #0x54e070
004283d4: ldr      x1, [sp, #0x78]
004283d8: add      x0, sp, #0x70
004283dc: bl       #0x4332d4
004283e0: add      x0, sp, #0xa0
004283e4: bl       #0x386c48
004283e8: ldr      x8, [x23, #0x28]
004283ec: ldur     x9, [x29, #-0x10]
004283f0: cmp      x8, x9
004283f4: b.ne     #0x428400
004283f8: mov      x0, x19
004283fc: bl       #0x54fffc
00428400: bl       #0x553f00 ; __stack_chk_fail
