00429fc8: stp      x29, x30, [sp, #-0x60]!
00429fcc: stp      x28, x27, [sp, #0x10]
00429fd0: stp      x26, x25, [sp, #0x20]
00429fd4: stp      x24, x23, [sp, #0x30]
00429fd8: stp      x22, x21, [sp, #0x40]
00429fdc: stp      x20, x19, [sp, #0x50]
00429fe0: mov      x29, sp
00429fe4: sub      sp, sp, #0x1b0
00429fe8: mrs      x8, tpidr_el0
00429fec: adrp     x26, #0x562000
00429ff0: mov      x19, x0
00429ff4: ldr      x26, [x26, #0xeb0]
00429ff8: str      x8, [sp]
00429ffc: mov      x25, xzr
0042a000: ldr      x8, [x8, #0x28]
0042a004: adrp     x21, #0x557000
0042a008: add      x21, x21, #0x3a8
0042a00c: adrp     x23, #0x23000
0042a010: add      x23, x23, #0xae3 ; 'drawBox='
0042a014: adrp     x22, #0x21000
0042a018: add      x22, x22, #0x12a ; 'drawRay='
0042a01c: stur     x8, [x29, #-0x10]
0042a020: add      x8, sp, #0x30
0042a024: orr      x9, x8, #1
0042a028: add      x8, sp, #0x58
0042a02c: adrp     x27, #0x24000
0042a030: add      x27, x27, #0x585 ; 'drawMinimap='
0042a034: add      x10, x8, #0x20
0042a038: add      x8, x0, #0x362
0042a03c: stp      x8, x9, [sp, #8]
0042a040: ldr      x8, [x26]
0042a044: adrp     x28, #0x26000
0042a048: add      x28, x28, #0x91f ; 'showMinimapBorder='
0042a04c: mov      w20, #0xa
0042a050: stp      x8, x10, [sp, #0x20]
0042a054: ldr      x8, [x26, #0x18]
0042a058: str      x8, [sp, #0x18]
0042a05c: ldr      x24, [x21, x25]
0042a060: add      x0, sp, #0x58
0042a064: mov      w2, #0x20
0042a068: mov      x1, x24
0042a06c: bl       #0x42ad68
0042a070: ldr      x8, [sp, #0x58]
0042a074: ldr      x9, [sp, #0x28]
0042a078: ldur     x8, [x8, #-0x18]
0042a07c: ldrb     w8, [x9, x8]
0042a080: mov      w9, #5
0042a084: tst      w8, w9
0042a088: b.ne     #0x42abec
0042a08c: add      x0, sp, #0x58
0042a090: adrp     x1, #0x2a000
0042a094: add      x1, x1, #0xe86
0042a098: mov      w2, #0xa
0042a09c: bl       #0x3a07c0
0042a0a0: ldr      x8, [x0]
0042a0a4: ldur     x9, [x8, #-0x18]
0042a0a8: add      x9, x0, x9
0042a0ac: ldr      w10, [x9, #8]
0042a0b0: and      w10, w10, #0xfffffeff
0042a0b4: orr      w10, w10, #4
0042a0b8: str      w10, [x9, #8]
0042a0bc: mov      w9, #4
0042a0c0: ldur     x8, [x8, #-0x18]
0042a0c4: add      x8, x0, x8
0042a0c8: str      x9, [x8, #0x10]
0042a0cc: add      x0, sp, #0x58
0042a0d0: mov      x1, x23
0042a0d4: mov      w2, #8
0042a0d8: bl       #0x3a07c0
0042a0dc: ldrb     w1, [x19, #0x48]
0042a0e0: bl       #0x50f700
0042a0e4: strb     w20, [sp, #0x30]
0042a0e8: add      x1, sp, #0x30
0042a0ec: mov      w2, #1
0042a0f0: bl       #0x3a07c0
0042a0f4: add      x0, sp, #0x58
0042a0f8: mov      x1, x22
0042a0fc: mov      w2, #8
0042a100: bl       #0x3a07c0
0042a104: ldrb     w1, [x19, #0x49]
0042a108: bl       #0x50f700
0042a10c: strb     w20, [sp, #0x30]
0042a110: add      x1, sp, #0x30
0042a114: mov      w2, #1
0042a118: bl       #0x3a07c0
0042a11c: add      x0, sp, #0x58
0042a120: mov      x1, x27
0042a124: mov      w2, #0xc
0042a128: bl       #0x3a07c0
0042a12c: ldrb     w1, [x19, #0x4a]
0042a130: bl       #0x50f700
0042a134: strb     w20, [sp, #0x30]
0042a138: add      x1, sp, #0x30
0042a13c: mov      w2, #1
0042a140: bl       #0x3a07c0
0042a144: add      x0, sp, #0x58
0042a148: mov      x1, x28
0042a14c: mov      w2, #0x12
0042a150: bl       #0x3a07c0
0042a154: ldrb     w1, [x19, #0x4b]
0042a158: bl       #0x50f700
0042a15c: strb     w20, [sp, #0x30]
0042a160: add      x1, sp, #0x30
0042a164: mov      w2, #1
0042a168: bl       #0x3a07c0
0042a16c: add      x0, sp, #0x58
0042a170: adrp     x1, #0x24000
0042a174: add      x1, x1, #0xf40 ; 'drawSkillPanel='
0042a178: mov      w2, #0xf
0042a17c: bl       #0x3a07c0
0042a180: ldrb     w1, [x19, #0x4c]
0042a184: bl       #0x50f700
0042a188: strb     w20, [sp, #0x30]
0042a18c: add      x1, sp, #0x30
0042a190: mov      w2, #1
0042a194: bl       #0x3a07c0
0042a198: add      x0, sp, #0x58
0042a19c: adrp     x1, #0x22000
0042a1a0: add      x1, x1, #0x8d6 ; 'hideSmallSkills='
0042a1a4: mov      w2, #0x10
0042a1a8: bl       #0x3a07c0
0042a1ac: ldrb     w1, [x19, #0x4d]
0042a1b0: bl       #0x50f700
0042a1b4: strb     w20, [sp, #0x30]
0042a1b8: add      x1, sp, #0x30
0042a1bc: mov      w2, #1
0042a1c0: bl       #0x3a07c0
0042a1c4: add      x0, sp, #0x58
0042a1c8: adrp     x1, #0x25000
0042a1cc: add      x1, x1, #0xeb6 ; 'hideEntityAvatar='
0042a1d0: mov      w2, #0x11
0042a1d4: bl       #0x3a07c0
0042a1d8: ldrb     w1, [x19, #0x4e]
0042a1dc: bl       #0x50f700
0042a1e0: strb     w20, [sp, #0x30]
0042a1e4: add      x1, sp, #0x30
0042a1e8: mov      w2, #1
0042a1ec: bl       #0x3a07c0
0042a1f0: add      x0, sp, #0x58
0042a1f4: adrp     x1, #0x25000
0042a1f8: add      x1, x1, #0x388 ; 'drawWards='
0042a1fc: mov      w2, #0xa
0042a200: bl       #0x3a07c0
0042a204: ldrb     w1, [x19, #0x4f]
0042a208: bl       #0x50f700
0042a20c: strb     w20, [sp, #0x30]
0042a210: add      x1, sp, #0x30
0042a214: mov      w2, #1
0042a218: bl       #0x3a07c0
0042a21c: add      x0, sp, #0x58
0042a220: adrp     x1, #0x24000
0042a224: add      x1, x1, #0xa8b ; 'drawMonsters='
0042a228: mov      w2, #0xd
0042a22c: bl       #0x3a07c0
0042a230: ldrb     w1, [x19, #0x50]
0042a234: bl       #0x50f700
0042a238: strb     w20, [sp, #0x30]
0042a23c: add      x1, sp, #0x30
0042a240: mov      w2, #1
0042a244: bl       #0x3a07c0
0042a248: add      x0, sp, #0x58
0042a24c: adrp     x1, #0x2b000
0042a250: add      x1, x1, #0x7cc ; 'hideMonsterHealth='
0042a254: mov      w2, #0x12
0042a258: bl       #0x3a07c0
0042a25c: ldrb     w1, [x19, #0x51]
0042a260: bl       #0x50f700
0042a264: strb     w20, [sp, #0x30]
0042a268: add      x1, sp, #0x30
0042a26c: mov      w2, #1
0042a270: bl       #0x3a07c0
0042a274: add      x0, sp, #0x58
0042a278: adrp     x1, #0x20000
0042a27c: add      x1, x1, #0xc57 ; 'showMonsterRespawn='
0042a280: mov      w2, #0x13
0042a284: bl       #0x3a07c0
0042a288: ldrb     w1, [x19, #0x52]
0042a28c: bl       #0x50f700
0042a290: strb     w20, [sp, #0x30]
0042a294: add      x1, sp, #0x30
0042a298: mov      w2, #1
0042a29c: bl       #0x3a07c0
0042a2a0: add      x0, sp, #0x58
0042a2a4: adrp     x1, #0x26000
0042a2a8: add      x1, x1, #0xdc8 ; 'autoSmite='
0042a2ac: mov      w2, #0xa
0042a2b0: bl       #0x3a07c0
0042a2b4: ldrb     w1, [x19, #0x53]
0042a2b8: bl       #0x50f700
0042a2bc: strb     w20, [sp, #0x30]
0042a2c0: add      x1, sp, #0x30
0042a2c4: mov      w2, #1
0042a2c8: bl       #0x3a07c0
0042a2cc: add      x0, sp, #0x58
0042a2d0: adrp     x1, #0x27000
0042a2d4: add      x1, x1, #0x2f5 ; 'smiteRequireEnemy='
0042a2d8: mov      w2, #0x12
0042a2dc: bl       #0x3a07c0
0042a2e0: ldrb     w1, [x19, #0x54]
0042a2e4: bl       #0x50f700
0042a2e8: strb     w20, [sp, #0x30]
0042a2ec: add      x1, sp, #0x30
0042a2f0: mov      w2, #1
0042a2f4: bl       #0x3a07c0
0042a2f8: add      x0, sp, #0x58
0042a2fc: adrp     x1, #0x26000
0042a300: add      x1, x1, #0x932 ; 'autoMercury='
0042a304: mov      w2, #0xc
0042a308: bl       #0x3a07c0
0042a30c: ldrb     w1, [x19, #0x55]
0042a310: bl       #0x50f700
0042a314: strb     w20, [sp, #0x30]
0042a318: add      x1, sp, #0x30
0042a31c: mov      w2, #1
0042a320: bl       #0x3a07c0
0042a324: add      x0, sp, #0x58
0042a328: adrp     x1, #0x28000
0042a32c: add      x1, x1, #0xb57 ; 'showMercuryMarker='
0042a330: mov      w2, #0x12
0042a334: bl       #0x3a07c0
0042a338: ldrb     w1, [x19, #0x56]
0042a33c: bl       #0x50f700
0042a340: strb     w20, [sp, #0x30]
0042a344: add      x1, sp, #0x30
0042a348: mov      w2, #1
0042a34c: bl       #0x3a07c0
0042a350: add      x0, sp, #0x58
0042a354: adrp     x1, #0x28000
0042a358: add      x1, x1, #0x237 ; 'showSmiteRange='
0042a35c: mov      w2, #0xf
0042a360: bl       #0x3a07c0
0042a364: ldrb     w1, [x19, #0x57]
0042a368: bl       #0x50f700
0042a36c: strb     w20, [sp, #0x30]
0042a370: add      x1, sp, #0x30
0042a374: mov      w2, #1
0042a378: bl       #0x3a07c0
0042a37c: add      x0, sp, #0x58
0042a380: adrp     x1, #0x29000
0042a384: add      x1, x1, #0x4ad ; 'showSmiteMarker='
0042a388: mov      w2, #0x10
0042a38c: bl       #0x3a07c0
0042a390: ldrb     w1, [x19, #0x58]
0042a394: bl       #0x50f700
0042a398: strb     w20, [sp, #0x30]
0042a39c: add      x1, sp, #0x30
0042a3a0: mov      w2, #1
0042a3a4: bl       #0x3a07c0
0042a3a8: add      x0, sp, #0x58
0042a3ac: adrp     x1, #0x23000
0042a3b0: add      x1, x1, #0xaec ; 'smiteRedBuff='
0042a3b4: mov      w2, #0xd
0042a3b8: bl       #0x3a07c0
0042a3bc: ldrb     w1, [x19, #0x59]
0042a3c0: bl       #0x50f700
0042a3c4: strb     w20, [sp, #0x30]
0042a3c8: add      x1, sp, #0x30
0042a3cc: mov      w2, #1
0042a3d0: bl       #0x3a07c0
0042a3d4: add      x0, sp, #0x58
0042a3d8: adrp     x1, #0x26000
0042a3dc: add      x1, x1, #0x93f ; 'smiteBlueBuff='
0042a3e0: mov      w2, #0xe
0042a3e4: bl       #0x3a07c0
0042a3e8: ldrb     w1, [x19, #0x5a]
0042a3ec: bl       #0x50f700
0042a3f0: strb     w20, [sp, #0x30]
0042a3f4: add      x1, sp, #0x30
0042a3f8: mov      w2, #1
0042a3fc: bl       #0x3a07c0
0042a400: add      x0, sp, #0x58
0042a404: adrp     x1, #0x2b000
0042a408: add      x1, x1, #0x7df ; 'smiteDragon='
0042a40c: mov      w2, #0xc
0042a410: bl       #0x3a07c0
0042a414: ldrb     w1, [x19, #0x5b]
0042a418: bl       #0x50f700
0042a41c: strb     w20, [sp, #0x30]
0042a420: add      x1, sp, #0x30
0042a424: mov      w2, #1
0042a428: bl       #0x3a07c0
0042a42c: add      x0, sp, #0x58
0042a430: adrp     x1, #0x26000
0042a434: add      x1, x1, #0x3f5 ; 'smiteHealthThreshold='
0042a438: mov      w2, #0x15
0042a43c: bl       #0x3a07c0
0042a440: ldr      w1, [x19, #0x5c]
0042a444: bl       #0x50f700
0042a448: strb     w20, [sp, #0x30]
0042a44c: add      x1, sp, #0x30
0042a450: mov      w2, #1
0042a454: bl       #0x3a07c0
0042a458: add      x0, sp, #0x58
0042a45c: adrp     x1, #0x28000
0042a460: add      x1, x1, #0xb6a ; 'smiteRange='
0042a464: mov      w2, #0xb
0042a468: bl       #0x3a07c0
0042a46c: ldr      w1, [x19, #0x60]
0042a470: bl       #0x50f700
0042a474: strb     w20, [sp, #0x30]
0042a478: add      x1, sp, #0x30
0042a47c: mov      w2, #1
0042a480: bl       #0x3a07c0
0042a484: add      x0, sp, #0x58
0042a488: adrp     x1, #0x2a000
0042a48c: add      x1, x1, #0xe91 ; 'smiteRangeCenterX='
0042a490: mov      w2, #0x12
0042a494: bl       #0x3a07c0
0042a498: ldr      s0, [x19, #0x64]
0042a49c: bl       #0x50fd68
0042a4a0: strb     w20, [sp, #0x30]
0042a4a4: add      x1, sp, #0x30
0042a4a8: mov      w2, #1
0042a4ac: bl       #0x3a07c0
0042a4b0: add      x0, sp, #0x58
0042a4b4: adrp     x1, #0x27000
0042a4b8: add      x1, x1, #0x308 ; 'smiteRangeCenterY='
0042a4bc: mov      w2, #0x12
0042a4c0: bl       #0x3a07c0
0042a4c4: ldr      s0, [x19, #0x68]
0042a4c8: bl       #0x50fd68
0042a4cc: strb     w20, [sp, #0x30]
0042a4d0: add      x1, sp, #0x30
0042a4d4: mov      w2, #1
0042a4d8: bl       #0x3a07c0
0042a4dc: add      x0, sp, #0x58
0042a4e0: adrp     x1, #0x20000
0042a4e4: add      x1, x1, #0xc6b ; 'smiteTouchX='
0042a4e8: mov      w2, #0xc
0042a4ec: bl       #0x3a07c0
0042a4f0: ldr      s0, [x19, #0x88]
0042a4f4: bl       #0x50fd68
0042a4f8: strb     w20, [sp, #0x30]
0042a4fc: add      x1, sp, #0x30
0042a500: mov      w2, #1
0042a504: bl       #0x3a07c0
0042a508: add      x0, sp, #0x58
0042a50c: adrp     x1, #0x29000
0042a510: add      x1, x1, #0x4be ; 'smiteTouchY='
0042a514: mov      w2, #0xc
0042a518: bl       #0x3a07c0
0042a51c: ldr      s0, [x19, #0x8c]
0042a520: bl       #0x50fd68
0042a524: strb     w20, [sp, #0x30]
0042a528: add      x1, sp, #0x30
0042a52c: mov      w2, #1
0042a530: bl       #0x3a07c0
0042a534: add      x0, sp, #0x58
0042a538: adrp     x1, #0x24000
0042a53c: add      x1, x1, #0x592 ; 'mercuryTouchX='
0042a540: mov      w2, #0xe
0042a544: bl       #0x3a07c0
0042a548: ldr      s0, [x19, #0x90]
0042a54c: bl       #0x50fd68
0042a550: strb     w20, [sp, #0x30]
0042a554: add      x1, sp, #0x30
0042a558: mov      w2, #1
0042a55c: bl       #0x3a07c0
0042a560: add      x0, sp, #0x58
0042a564: adrp     x1, #0x21000
0042a568: add      x1, x1, #0x133 ; 'mercuryTouchY='
0042a56c: mov      w2, #0xe
0042a570: bl       #0x3a07c0
0042a574: ldr      s0, [x19, #0x94]
0042a578: bl       #0x50fd68
0042a57c: strb     w20, [sp, #0x30]
0042a580: add      x1, sp, #0x30
0042a584: mov      w2, #1
0042a588: bl       #0x3a07c0
0042a58c: add      x0, sp, #0x58
0042a590: adrp     x1, #0x2b000
0042a594: add      x1, x1, #0xd2d ; 'godViewEnabled='
0042a598: mov      w2, #0xf
0042a59c: bl       #0x3a07c0
0042a5a0: ldrb     w1, [x19, #0x98]
0042a5a4: bl       #0x50f700
0042a5a8: strb     w20, [sp, #0x30]
0042a5ac: add      x1, sp, #0x30
0042a5b0: mov      w2, #1
0042a5b4: bl       #0x3a07c0
0042a5b8: add      x0, sp, #0x58
0042a5bc: adrp     x1, #0x28000
0042a5c0: add      x1, x1, #0x247 ; 'godViewValue='
0042a5c4: mov      w2, #0xd
0042a5c8: bl       #0x3a07c0
0042a5cc: ldr      s0, [x19, #0x9c]
0042a5d0: bl       #0x50fd68
0042a5d4: strb     w20, [sp, #0x30]
0042a5d8: add      x1, sp, #0x30
0042a5dc: mov      w2, #1
0042a5e0: bl       #0x3a07c0
0042a5e4: add      x0, sp, #0x58
0042a5e8: adrp     x1, #0x25000
0042a5ec: add      x1, x1, #0x393 ; 'forcedDrawCamp='
0042a5f0: mov      w2, #0xf
0042a5f4: bl       #0x3a07c0
0042a5f8: ldr      w1, [x19, #0xd8]
0042a5fc: bl       #0x50f700
0042a600: strb     w20, [sp, #0x30]
0042a604: add      x1, sp, #0x30
0042a608: mov      w2, #1
0042a60c: bl       #0x3a07c0
0042a610: add      x0, sp, #0x58
0042a614: adrp     x1, #0x25000
0042a618: add      x1, x1, #0xec8 ; 'minimapScale='
0042a61c: mov      w2, #0xd
0042a620: bl       #0x3a07c0
0042a624: ldr      s0, [x19, #0xec]
0042a628: bl       #0x50fd68
0042a62c: strb     w20, [sp, #0x30]
0042a630: add      x1, sp, #0x30
0042a634: mov      w2, #1
0042a638: bl       #0x3a07c0
0042a63c: add      x0, sp, #0x58
0042a640: adrp     x1, #0x20000
0042a644: add      x1, x1, #0xc78 ; 'minimapAvatarSpacing='
0042a648: mov      w2, #0x15
0042a64c: bl       #0x3a07c0
0042a650: ldr      s0, [x19, #0xf0]
0042a654: bl       #0x50fd68
0042a658: strb     w20, [sp, #0x30]
0042a65c: add      x1, sp, #0x30
0042a660: mov      w2, #1
0042a664: bl       #0x3a07c0
0042a668: add      x0, sp, #0x58
0042a66c: adrp     x1, #0x2b000
0042a670: add      x1, x1, #0xd3d ; 'minimapOffsetX='
0042a674: mov      w2, #0xf
0042a678: bl       #0x3a07c0
0042a67c: ldr      s0, [x19, #0xf4]
0042a680: bl       #0x50fd68
0042a684: strb     w20, [sp, #0x30]
0042a688: add      x1, sp, #0x30
0042a68c: mov      w2, #1
0042a690: bl       #0x3a07c0
0042a694: add      x0, sp, #0x58
0042a698: adrp     x1, #0x23000
0042a69c: add      x1, x1, #0x4ce ; 'minimapOffsetY='
0042a6a0: mov      w2, #0xf
0042a6a4: bl       #0x3a07c0
0042a6a8: ldr      s0, [x19, #0xf8]
0042a6ac: bl       #0x50fd68
0042a6b0: strb     w20, [sp, #0x30]
0042a6b4: add      x1, sp, #0x30
0042a6b8: mov      w2, #1
0042a6bc: bl       #0x3a07c0
0042a6c0: add      x0, sp, #0x58
0042a6c4: adrp     x1, #0x20000
0042a6c8: add      x1, x1, #0xc8e ; 'minimapWindowScale='
0042a6cc: mov      w2, #0x13
0042a6d0: bl       #0x3a07c0
0042a6d4: ldr      s0, [x19, #0xfc]
0042a6d8: bl       #0x50fd68
0042a6dc: strb     w20, [sp, #0x30]
0042a6e0: add      x1, sp, #0x30
0042a6e4: mov      w2, #1
0042a6e8: bl       #0x3a07c0
0042a6ec: add      x0, sp, #0x58
0042a6f0: adrp     x1, #0x2a000
0042a6f4: add      x1, x1, #0x3b2 ; 'minimapWindowOffsetX='
0042a6f8: mov      w2, #0x15
0042a6fc: bl       #0x3a07c0
0042a700: ldr      s0, [x19, #0x100]
0042a704: bl       #0x50fd68
0042a708: strb     w20, [sp, #0x30]
0042a70c: add      x1, sp, #0x30
0042a710: mov      w2, #1
0042a714: bl       #0x3a07c0
0042a718: add      x0, sp, #0x58
0042a71c: adrp     x1, #0x2b000
0042a720: add      x1, x1, #0x7ec ; 'minimapWindowOffsetY='
0042a724: mov      w2, #0x15
0042a728: bl       #0x3a07c0
0042a72c: ldr      s0, [x19, #0x104]
0042a730: bl       #0x50fd68
0042a734: strb     w20, [sp, #0x30]
0042a738: add      x1, sp, #0x30
0042a73c: mov      w2, #1
0042a740: bl       #0x3a07c0
0042a744: add      x0, sp, #0x58
0042a748: adrp     x1, #0x26000
0042a74c: add      x1, x1, #0x94e ; 'minimapAvatarSize='
0042a750: mov      w2, #0x12
0042a754: bl       #0x3a07c0
0042a758: ldr      s0, [x19, #0x108]
0042a75c: bl       #0x50fd68
0042a760: strb     w20, [sp, #0x30]
0042a764: add      x1, sp, #0x30
0042a768: mov      w2, #1
0042a76c: bl       #0x3a07c0
0042a770: add      x0, sp, #0x58
0042a774: adrp     x1, #0x2a000
0042a778: add      x1, x1, #0xea4 ; 'minimapHealthTextSize='
0042a77c: mov      w2, #0x16
0042a780: bl       #0x3a07c0
0042a784: ldr      s0, [x19, #0x10c]
0042a788: bl       #0x50fd68
0042a78c: strb     w20, [sp, #0x30]
0042a790: add      x1, sp, #0x30
0042a794: mov      w2, #1
0042a798: bl       #0x3a07c0
0042a79c: add      x0, sp, #0x58
0042a7a0: adrp     x1, #0x2a000
0042a7a4: add      x1, x1, #0xebb ; 'minimapAvatarBorderSize='
0042a7a8: mov      w2, #0x18
0042a7ac: bl       #0x3a07c0
0042a7b0: ldr      s0, [x19, #0x110]
0042a7b4: bl       #0x50fd68
0042a7b8: strb     w20, [sp, #0x30]
0042a7bc: add      x1, sp, #0x30
0042a7c0: mov      w2, #1
0042a7c4: bl       #0x3a07c0
0042a7c8: add      x0, sp, #0x58
0042a7cc: adrp     x1, #0x27000
0042a7d0: add      x1, x1, #0xc8a ; 'entityOffsetX='
0042a7d4: mov      w2, #0xe
0042a7d8: bl       #0x3a07c0
0042a7dc: ldr      s0, [x19, #0x114]
0042a7e0: bl       #0x50fd68
0042a7e4: strb     w20, [sp, #0x30]
0042a7e8: add      x1, sp, #0x30
0042a7ec: mov      w2, #1
0042a7f0: bl       #0x3a07c0
0042a7f4: add      x0, sp, #0x58
0042a7f8: adrp     x1, #0x22000
0042a7fc: add      x1, x1, #0x8e7 ; 'entityOffsetY='
0042a800: mov      w2, #0xe
0042a804: bl       #0x3a07c0
0042a808: ldr      s0, [x19, #0x118]
0042a80c: bl       #0x50fd68
0042a810: strb     w20, [sp, #0x30]
0042a814: add      x1, sp, #0x30
0042a818: mov      w2, #1
0042a81c: bl       #0x3a07c0
0042a820: add      x0, sp, #0x58
0042a824: adrp     x1, #0x28000
0042a828: add      x1, x1, #0x255 ; 'entityBoxWidthScale='
0042a82c: mov      w2, #0x14
0042a830: bl       #0x3a07c0
0042a834: ldr      s0, [x19, #0x11c]
0042a838: bl       #0x50fd68
0042a83c: strb     w20, [sp, #0x30]
0042a840: add      x1, sp, #0x30
0042a844: mov      w2, #1
0042a848: bl       #0x3a07c0
0042a84c: add      x0, sp, #0x58
0042a850: adrp     x1, #0x26000
0042a854: add      x1, x1, #0x40b ; 'entityBoxHeightScale='
0042a858: mov      w2, #0x15
0042a85c: bl       #0x3a07c0
0042a860: ldr      s0, [x19, #0x120]
0042a864: bl       #0x50fd68
0042a868: strb     w20, [sp, #0x30]
0042a86c: add      x1, sp, #0x30
0042a870: mov      w2, #1
0042a874: bl       #0x3a07c0
0042a878: add      x0, sp, #0x58
0042a87c: adrp     x1, #0x2b000
0042a880: add      x1, x1, #0x802 ; 'entityAvatarSize='
0042a884: mov      w2, #0x11
0042a888: bl       #0x3a07c0
0042a88c: ldr      s0, [x19, #0x124]
0042a890: bl       #0x50fd68
0042a894: strb     w20, [sp, #0x30]
0042a898: add      x1, sp, #0x30
0042a89c: mov      w2, #1
0042a8a0: bl       #0x3a07c0
0042a8a4: add      x0, sp, #0x58
0042a8a8: adrp     x1, #0x2b000
0042a8ac: add      x1, x1, #0x814 ; 'entityHealthTextSize='
0042a8b0: mov      w2, #0x15
0042a8b4: bl       #0x3a07c0
0042a8b8: ldr      s0, [x19, #0x128]
0042a8bc: bl       #0x50fd68
0042a8c0: strb     w20, [sp, #0x30]
0042a8c4: add      x1, sp, #0x30
0042a8c8: mov      w2, #1
0042a8cc: bl       #0x3a07c0
0042a8d0: add      x0, sp, #0x58
0042a8d4: adrp     x1, #0x29000
0042a8d8: add      x1, x1, #0x4cb ; 'monsterHealthTextSize='
0042a8dc: mov      w2, #0x16
0042a8e0: bl       #0x3a07c0
0042a8e4: ldr      s0, [x19, #0x12c]
0042a8e8: bl       #0x50fd68
0042a8ec: strb     w20, [sp, #0x30]
0042a8f0: add      x1, sp, #0x30
0042a8f4: mov      w2, #1
0042a8f8: bl       #0x3a07c0
0042a8fc: add      x0, sp, #0x58
0042a900: adrp     x1, #0x26000
0042a904: add      x1, x1, #0x421 ; 'entitySkillIconSize='
0042a908: mov      w2, #0x14
0042a90c: bl       #0x3a07c0
0042a910: ldr      s0, [x19, #0x130]
0042a914: bl       #0x50fd68
0042a918: strb     w20, [sp, #0x30]
0042a91c: add      x1, sp, #0x30
0042a920: mov      w2, #1
0042a924: bl       #0x3a07c0
0042a928: add      x0, sp, #0x58
0042a92c: adrp     x1, #0x2a000
0042a930: add      x1, x1, #0x3c8 ; 'skillPanelOffsetX='
0042a934: mov      w2, #0x12
0042a938: bl       #0x3a07c0
0042a93c: ldr      s0, [x19, #0x134]
0042a940: bl       #0x50fd68
0042a944: strb     w20, [sp, #0x30]
0042a948: add      x1, sp, #0x30
0042a94c: mov      w2, #1
0042a950: bl       #0x3a07c0
0042a954: add      x0, sp, #0x58
0042a958: adrp     x1, #0x2b000
0042a95c: add      x1, x1, #0xd4d ; 'skillPanelOffsetY='
0042a960: mov      w2, #0x12
0042a964: bl       #0x3a07c0
0042a968: ldr      s0, [x19, #0x138]
0042a96c: bl       #0x50fd68
0042a970: strb     w20, [sp, #0x30]
0042a974: add      x1, sp, #0x30
0042a978: mov      w2, #1
0042a97c: bl       #0x3a07c0
0042a980: add      x0, sp, #0x58
0042a984: adrp     x1, #0x26000
0042a988: add      x1, x1, #0x436 ; 'skillPanelSize='
0042a98c: mov      w2, #0xf
0042a990: bl       #0x3a07c0
0042a994: ldr      s0, [x19, #0x13c]
0042a998: bl       #0x50fd68
0042a99c: strb     w20, [sp, #0x30]
0042a9a0: add      x1, sp, #0x30
0042a9a4: mov      w2, #1
0042a9a8: bl       #0x3a07c0
0042a9ac: add      x0, sp, #0x58
0042a9b0: adrp     x1, #0x28000
0042a9b4: add      x1, x1, #0xf98 ; 'friendlyColor='
0042a9b8: mov      w2, #0xe
0042a9bc: bl       #0x3a07c0
0042a9c0: ldr      s0, [x19, #0x144]
0042a9c4: bl       #0x50fd68
0042a9c8: mov      w8, #0x2c
0042a9cc: strb     w8, [sp, #0x30]
0042a9d0: add      x1, sp, #0x30
0042a9d4: mov      w2, #1
0042a9d8: bl       #0x3a07c0
0042a9dc: ldr      s0, [x19, #0x148]
0042a9e0: bl       #0x50fd68
0042a9e4: mov      w8, #0x2c
0042a9e8: strb     w8, [sp, #0x30]
0042a9ec: add      x1, sp, #0x30
0042a9f0: mov      w2, #1
0042a9f4: bl       #0x3a07c0
0042a9f8: ldr      s0, [x19, #0x14c]
0042a9fc: bl       #0x50fd68
0042aa00: mov      w8, #0x2c
0042aa04: strb     w8, [sp, #0x30]
0042aa08: add      x1, sp, #0x30
0042aa0c: mov      w2, #1
0042aa10: bl       #0x3a07c0
0042aa14: ldr      s0, [x19, #0x150]
0042aa18: bl       #0x50fd68
0042aa1c: strb     w20, [sp, #0x30]
0042aa20: add      x1, sp, #0x30
0042aa24: mov      w2, #1
0042aa28: bl       #0x3a07c0
0042aa2c: add      x0, sp, #0x58
0042aa30: adrp     x1, #0x2a000
0042aa34: add      x1, x1, #0x3db ; 'enemyColor='
0042aa38: mov      w2, #0xb
0042aa3c: bl       #0x3a07c0
0042aa40: ldr      s0, [x19, #0x154]
0042aa44: bl       #0x50fd68
0042aa48: mov      w8, #0x2c
0042aa4c: strb     w8, [sp, #0x30]
0042aa50: add      x1, sp, #0x30
0042aa54: mov      w2, #1
0042aa58: bl       #0x3a07c0
0042aa5c: ldr      s0, [x19, #0x158]
0042aa60: bl       #0x50fd68
0042aa64: mov      w8, #0x2c
0042aa68: strb     w8, [sp, #0x30]
0042aa6c: add      x1, sp, #0x30
0042aa70: mov      w2, #1
0042aa74: bl       #0x3a07c0
0042aa78: ldr      s0, [x19, #0x15c]
0042aa7c: bl       #0x50fd68
0042aa80: mov      w8, #0x2c
0042aa84: strb     w8, [sp, #0x30]
0042aa88: add      x1, sp, #0x30
0042aa8c: mov      w2, #1
0042aa90: bl       #0x3a07c0
0042aa94: ldr      s0, [x19, #0x160]
0042aa98: bl       #0x50fd68
0042aa9c: strb     w20, [sp, #0x30]
0042aaa0: add      x1, sp, #0x30
0042aaa4: mov      w2, #1
0042aaa8: bl       #0x3a07c0
0042aaac: add      x0, sp, #0x58
0042aab0: adrp     x1, #0x23000
0042aab4: add      x1, x1, #0xafa ; 'wardColor='
0042aab8: mov      w2, #0xa
0042aabc: bl       #0x3a07c0
0042aac0: ldr      s0, [x19, #0x164]
0042aac4: bl       #0x50fd68
0042aac8: mov      w8, #0x2c
0042aacc: strb     w8, [sp, #0x30]
0042aad0: add      x1, sp, #0x30
0042aad4: mov      w2, #1
0042aad8: bl       #0x3a07c0
0042aadc: ldr      s0, [x19, #0x168]
0042aae0: bl       #0x50fd68
0042aae4: mov      w8, #0x2c
0042aae8: strb     w8, [sp, #0x30]
0042aaec: add      x1, sp, #0x30
0042aaf0: mov      w2, #1
0042aaf4: bl       #0x3a07c0
0042aaf8: ldr      s0, [x19, #0x16c]
0042aafc: bl       #0x50fd68
0042ab00: mov      w8, #0x2c
0042ab04: strb     w8, [sp, #0x30]
0042ab08: add      x1, sp, #0x30
0042ab0c: mov      w2, #1
0042ab10: bl       #0x3a07c0
0042ab14: ldr      s0, [x19, #0x170]
0042ab18: bl       #0x50fd68
0042ab1c: strb     w20, [sp, #0x30]
0042ab20: add      x1, sp, #0x30
0042ab24: mov      w2, #1
0042ab28: bl       #0x3a07c0
0042ab2c: add      x0, sp, #0x58
0042ab30: adrp     x1, #0x27000
0042ab34: add      x1, x1, #0x841 ; 'wardVisionRangeBrightness='
0042ab38: mov      w2, #0x1a
0042ab3c: bl       #0x3a07c0
0042ab40: ldr      s0, [x19, #0x174]
0042ab44: bl       #0x50fd68
0042ab48: strb     w20, [sp, #0x30]
0042ab4c: add      x1, sp, #0x30
0042ab50: mov      w2, #1
0042ab54: bl       #0x3a07c0
0042ab58: add      x0, sp, #0x58
0042ab5c: adrp     x1, #0x21000
0042ab60: add      x1, x1, #0x142 ; 'neutralColor='
0042ab64: mov      w2, #0xd
0042ab68: bl       #0x3a07c0
0042ab6c: ldr      s0, [x19, #0x178]
0042ab70: bl       #0x50fd68
0042ab74: mov      w8, #0x2c
0042ab78: strb     w8, [sp, #0x30]
0042ab7c: add      x1, sp, #0x30
0042ab80: mov      w2, #1
0042ab84: bl       #0x3a07c0
0042ab88: ldr      s0, [x19, #0x17c]
0042ab8c: bl       #0x50fd68
0042ab90: mov      w8, #0x2c
0042ab94: strb     w8, [sp, #0x30]
0042ab98: add      x1, sp, #0x30
0042ab9c: mov      w2, #1
0042aba0: bl       #0x3a07c0
0042aba4: ldr      s0, [x19, #0x180]
0042aba8: bl       #0x50fd68
0042abac: mov      w8, #0x2c
0042abb0: strb     w8, [sp, #0x30]
0042abb4: add      x1, sp, #0x30
0042abb8: mov      w2, #1
0042abbc: bl       #0x3a07c0
0042abc0: ldr      s0, [x19, #0x184]
0042abc4: bl       #0x50fd68
0042abc8: strb     w20, [sp, #0x30]
0042abcc: add      x1, sp, #0x30
0042abd0: mov      w2, #1
0042abd4: bl       #0x3a07c0
0042abd8: ldr      x8, [sp, #0x58]
0042abdc: ldr      x9, [sp, #0x28]
0042abe0: ldur     x8, [x8, #-0x18]
0042abe4: ldr      w8, [x9, x8]
0042abe8: cbz      w8, #0x42ac38
0042abec: mov      w24, #1
0042abf0: ldp      x9, x8, [sp, #0x18]
0042abf4: add      x20, sp, #0x58
0042abf8: add      x0, x20, #8
0042abfc: str      x8, [sp, #0x58]
0042ac00: ldur     x8, [x8, #-0x18]
0042ac04: str      x9, [x20, x8]
0042ac08: bl       #0x510f84
0042ac0c: add      x0, sp, #0x58
0042ac10: add      x1, x26, #8
0042ac14: bl       #0x50f560
0042ac18: add      x0, x20, #0xb0
0042ac1c: bl       #0x50eda8
0042ac20: tbz      w24, #0, #0x42acec
0042ac24: add      x25, x25, #8
0042ac28: mov      w20, #0xa
0042ac2c: cmp      x25, #0x10
0042ac30: b.ne     #0x42a05c
0042ac34: b        #0x42acdc
0042ac38: mov      w8, #0x22
0042ac3c: mov      w9, #0x20
0042ac40: strb     wzr, [sp, #0x42]
0042ac44: strb     w8, [sp, #0x30]
0042ac48: adrp     x8, #0x2b000
0042ac4c: add      x8, x8, #0x82a
0042ac50: ldr      q0, [x8]
0042ac54: ldr      x8, [sp, #0x10]
0042ac58: strb     w9, [x8, #0x10]
0042ac5c: str      q0, [x8]
0042ac60: add      x0, sp, #0x30
0042ac64: mov      x1, x24
0042ac68: bl       #0x50c46c
0042ac6c: ldrb     w24, [x0]
0042ac70: ldp      x8, x20, [x0, #8]
0042ac74: ldrb     w28, [x0, #1]
0042ac78: ldur     x9, [x0, #2]
0042ac7c: stp      xzr, xzr, [x0, #8]
0042ac80: str      xzr, [x0]
0042ac84: ldrb     w10, [x19, #0x360]
0042ac88: str      x9, [sp, #0x48]
0042ac8c: stur     x8, [sp, #0x4e]
0042ac90: tbz      w10, #0, #0x42ac9c
0042ac94: ldr      x0, [x19, #0x370]
0042ac98: bl       #0x54e070
0042ac9c: ldr      x8, [sp, #0x48]
0042aca0: ldur     x9, [sp, #0x4e]
0042aca4: ldrb     w10, [sp, #0x30]
0042aca8: ldr      x11, [sp, #8]
0042acac: strb     w24, [x19, #0x360]
0042acb0: strb     w28, [x19, #0x361]
0042acb4: str      x8, [x11]
0042acb8: stur     x9, [x11, #6]
0042acbc: str      x20, [x19, #0x370]
0042acc0: tbz      w10, #0, #0x42accc
0042acc4: ldr      x0, [sp, #0x40]
0042acc8: bl       #0x54e070
0042accc: mov      w24, wzr
0042acd0: adrp     x28, #0x26000
0042acd4: add      x28, x28, #0x91f ; 'showMinimapBorder='
0042acd8: b        #0x42abf0
0042acdc: adrp     x1, #0x24000
0042ace0: add      x1, x1, #0xa99
0042ace4: add      x0, x19, #0x360
0042ace8: bl       #0x50c208
0042acec: ldr      x8, [sp]
0042acf0: ldr      x8, [x8, #0x28]
0042acf4: ldur     x9, [x29, #-0x10]
0042acf8: cmp      x8, x9
0042acfc: b.ne     #0x42ad64
0042ad00: eor      w0, w24, #1
0042ad04: add      sp, sp, #0x1b0
0042ad08: ldp      x20, x19, [sp, #0x50]
0042ad0c: ldp      x22, x21, [sp, #0x40]
0042ad10: ldp      x24, x23, [sp, #0x30]
0042ad14: ldp      x26, x25, [sp, #0x20]
0042ad18: ldp      x28, x27, [sp, #0x10]
0042ad1c: ldp      x29, x30, [sp], #0x60
0042ad20: ret      
0042ad24: ldrb     w8, [sp, #0x30]
0042ad28: mov      x19, x0
0042ad2c: tbz      w8, #0, #0x42ad40
0042ad30: ldr      x0, [sp, #0x40]
0042ad34: bl       #0x54e070
0042ad38: b        #0x42ad40
0042ad3c: mov      x19, x0
0042ad40: add      x0, sp, #0x58
0042ad44: bl       #0x386ffc
0042ad48: ldr      x8, [sp]
0042ad4c: ldr      x8, [x8, #0x28]
0042ad50: ldur     x9, [x29, #-0x10]
0042ad54: cmp      x8, x9
0042ad58: b.ne     #0x42ad64
0042ad5c: mov      x0, x19
0042ad60: bl       #0x54fffc
0042ad64: bl       #0x553f00 ; __stack_chk_fail
