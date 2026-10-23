01015078: ldrb     w8, [x19, #0x10]
0101507c: cbz      w8, #0x1015090
01015080: mov      w0, #1
01015084: ldp      x29, x30, [sp, #0x10]
01015088: ldp      x20, x19, [sp], #0x20
0101508c: ret      
01015090: ldr      x8, [x19, #0x18]
01015094: cmp      x8, #0
01015098: cset     w8, gt
0101509c: lsl      w0, w8, #1
010150a0: ldp      x29, x30, [sp, #0x10]
010150a4: ldp      x20, x19, [sp], #0x20
; cooldown caller 0x62f0 -> 0x101516c
; cooldown caller 0x6328 -> 0x1015164
; cooldown caller 0x6424 -> 0x10249b0
; cooldown caller 0x645c -> 0x102498c
; cooldown caller 0xff5bf0 -> 0x102498c
00ff5b90: ldr      x8, [x19, #0x660]
00ff5b94: cmp      x8, x9
00ff5b98: b.eq     #0xff5ba0
00ff5b9c: cbnz     x8, #0xff5bac
00ff5ba0: ldp      x29, x30, [sp, #0x10]
00ff5ba4: ldp      x20, x19, [sp], #0x20
00ff5ba8: ret      
00ff5bac: ldr      x8, [x8]
00ff5bb0: cmp      x8, x9
00ff5bb4: b.ne     #0xff5bc8
00ff5bb8: mov      w0, #0
00ff5bbc: ldp      x29, x30, [sp, #0x10]
00ff5bc0: ldp      x20, x19, [sp], #0x20
00ff5bc4: ret      
00ff5bc8: mov      w0, #0
00ff5bcc: add      x8, x19, #0x570
00ff5bd0: cmp      x8, x9
00ff5bd4: b.eq     #0xff5ba0
00ff5bd8: cbz      x8, #0xff5ba0
00ff5bdc: ldr      x9, [x8]
00ff5be0: mov      x10, #-0x2222222222222223
00ff5be4: cmp      x9, x10
00ff5be8: b.eq     #0xff5bb8
00ff5bec: mov      x0, x8
00ff5bf0: bl       #0x102498c
00ff5bf4: cbz      w0, #0xff5ba0
00ff5bf8: adrp     x8, #0x51aa000
00ff5bfc: ldr      x8, [x8, #0x900]
00ff5c00: cbz      x8, #0xff5c6c
00ff5c04: sub      sp, sp, #0xa0
00ff5c08: stp      x0, x1, [sp]
00ff5c0c: stp      x2, x3, [sp, #0x10]
00ff5c10: stp      x4, x5, [sp, #0x20]
; cooldown caller 0xff5ca8 -> 0x1015164
00ff5c48: ldp      x19, x20, [sp, #0x20]
00ff5c4c: ldp      x21, x22, [sp, #0x30]
00ff5c50: ldp      x23, x24, [sp, #0x40]
00ff5c54: ldp      x25, x26, [sp, #0x50]
00ff5c58: ldp      x27, x28, [sp, #0x60]
00ff5c5c: ldp      x29, x30, [sp, #0x70]
00ff5c60: add      sp, sp, x2
00ff5c64: ret      
00ff5c68: bl       #0x41fd89c
00ff5c6c: mov      w0, #0
00ff5c70: ldr      x19, [x19, #0x590]
00ff5c74: mov      x8, #-0x2222222222222223
00ff5c78: cmp      x19, x8
00ff5c7c: b.eq     #0xff5ba0
00ff5c80: cbz      x19, #0xff5ba0
00ff5c84: ldr      x8, [x19]
00ff5c88: mov      x9, #-0x2222222222222223
00ff5c8c: cmp      x8, x9
00ff5c90: b.eq     #0xff5bb8
00ff5c94: mov      x0, x19
00ff5c98: bl       #0x1014ff4
00ff5c9c: cmp      w0, #2
00ff5ca0: b.ne     #0xff5bb8
00ff5ca4: mov      x0, x19
00ff5ca8: bl       #0x1015164
00ff5cac: cmp      x0, #0
00ff5cb0: cset     w0, gt
00ff5cb4: ldp      x29, x30, [sp, #0x10]
00ff5cb8: ldp      x20, x19, [sp], #0x20
; cooldown caller 0xff5de4 -> 0x102498c
; cooldown caller 0xff5eb4 -> 0x1015164
; cooldown caller 0xff6878 -> 0x10249b0
; cooldown caller 0xff6930 -> 0x101516c
; cooldown caller 0xff6a6c -> 0x10249b0
; cooldown caller 0xff6b3c -> 0x101516c
; selected native field/clock accessor 0xff1a6c
00ff1a6c: mov      x8, #-0x2222222222222223
00ff1a70: cmp      x0, x8
00ff1a74: ccmp     x0, #0, #4, ne
00ff1a78: b.ne     #0xff1a84
00ff1a7c: mov      x0, #0
00ff1a80: ret      
00ff1a84: ldr      x9, [x0]
00ff1a88: cmp      x9, x8
00ff1a8c: b.ne     #0xff1a98
00ff1a90: mov      x0, #0
00ff1a94: ret      
00ff1a98: ldr      x0, [x0, #0x668]
00ff1a9c: ret      
; selected native field/clock accessor 0x32edfb0
; named skill-manager string reference 0x358153c -> 0x465f494
; named skill-manager string reference 0x3586148 -> 0x465f494
; named skill-manager string reference 0x35f4b34 -> 0x465f494
035f4b34: adrp     x1, #0x465f000
035f4b38: add      x1, x1, #0x494
035f4b3c: adrp     x2, #0x395d000
035f4b40: add      x2, x2, #0xc7c
035f4b44: mov      x3, #0
035f4b48: mov      x4, #0
035f4b4c: mov      x5, #0
035f4b50: bl       #0x395da84
; named skillMgr property getter 0x395dc7c
0395dc7c: ldr      x0, [x0, #0x200]
0395dc80: ret      
; named skillMgr property getter 0x35f9dd8
; named skillMgr property getter 0x3619494
