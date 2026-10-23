
; FrameEngine.Logic.ActorComponentSkillMgr.get_slots 0x3933574
03933574: stp      x20, x19, [sp, #-0x20]!
03933578: stp      x29, x30, [sp, #0x10]
0393357c: add      x29, sp, #0x10
03933580: mov      x19, x0
03933584: adrp     x20, #0xf276000
03933588: ldrb     w8, [x20, #0xc2b]
0393358c: tbnz     w8, #0, #0x39335a4
03933590: adrp     x0, #0xed8a000
03933594: add      x0, x0, #0x1a0
03933598: bl       #0x172b24c
0393359c: mov      w8, #1
039335a0: strb     w8, [x20, #0xc2b]
039335a4: ldr      x8, [x19, #0x18]
039335a8: adds     x0, x8, #0x88
039335ac: b.eq     #0x39335f4
039335b0: ldur     x8, [x19, #0x38]
039335b4: cbz      x8, #0x39335c4
039335b8: ldr      x9, [x8, #0x10]
039335bc: cmp      x9, x0
039335c0: b.eq     #0x39335e4
039335c4: adrp     x8, #0xed8a000
039335c8: ldr      x1, [x8, #0x1a0]
039335cc: bl       #0x7c0995c
039335d0: mov      x1, x0
039335d4: stur     x0, [x19, #0x38]
039335d8: add      x0, x19, #0x38
039335dc: bl       #0x172b1d8
039335e0: ldur     x8, [x19, #0x38]
039335e4: mov      x0, x8
039335e8: ldp      x29, x30, [sp, #0x10]
039335ec: ldp      x20, x19, [sp], #0x20
039335f0: ret      

; FrameEngine.Logic.ActorComponentSkillMgr.GetSkillSlotByIndexSync 0x3934950
03934950: stp      x22, x21, [sp, #-0x30]!
03934954: stp      x20, x19, [sp, #0x10]
03934958: stp      x29, x30, [sp, #0x20]
0393495c: add      x29, sp, #0x20
03934960: mov      x19, x1
03934964: mov      x20, x0
03934968: adrp     x21, #0xf1f4000
0393496c: ldrb     w8, [x21, #0x113]
03934970: tbnz     w8, #0, #0x39349a0
03934974: adrp     x0, #0xed68000
03934978: add      x0, x0, #0x880
0393497c: bl       #0x172b24c
03934980: adrp     x0, #0xee22000
03934984: add      x0, x0, #0x100
03934988: bl       #0x172b24c
0393498c: adrp     x0, #0xed74000
03934990: add      x0, x0, #0x100
03934994: bl       #0x172b24c
03934998: mov      w8, #1
0393499c: strb     w8, [x21, #0x113]
039349a0: ldr      x20, [x20, #0x10]
039349a4: adrp     x8, #0xed68000
039349a8: ldr      x0, [x8, #0x880]
039349ac: ldr      w8, [x0, #0xe0]
039349b0: cbnz     w8, #0x39349b8
039349b4: bl       #0x172b3a8
039349b8: mov      x0, x20
039349bc: mov      x1, x19
039349c0: bl       #0x7c0f888
039349c4: adrp     x8, #0xed74000
039349c8: ldr      x8, [x8, #0x100]
039349cc: ldr      w9, [x8, #0xe0]
039349d0: cbz      w9, #0x39349ec
039349d4: adrp     x8, #0xee22000
039349d8: ldr      x1, [x8, #0x100]
039349dc: ldp      x29, x30, [sp, #0x20]
039349e0: ldp      x20, x19, [sp, #0x10]
039349e4: ldp      x22, x21, [sp], #0x30
039349e8: b        #0xa9c76a0

; FrameEngine.Logic.ActorComponentSkillMgr.GetRSkillSync 0x3934bc0
03934bc0: stp      x20, x19, [sp, #-0x20]!
03934bc4: stp      x29, x30, [sp, #0x10]
03934bc8: add      x29, sp, #0x10
03934bcc: mov      x19, x0
03934bd0: adrp     x20, #0xf1f4000
03934bd4: ldrb     w8, [x20, #0x117]
03934bd8: tbz      w8, #0, #0x3934c1c
03934bdc: ldr      x19, [x19, #0x10]
03934be0: adrp     x8, #0xed68000
03934be4: ldr      x0, [x8, #0x880]
03934be8: ldr      w8, [x0, #0xe0]
03934bec: cbz      w8, #0x3934c5c
03934bf0: mov      x0, x19
03934bf4: bl       #0x7c0f898
03934bf8: adrp     x8, #0xed74000
03934bfc: ldr      x8, [x8, #0x100]
03934c00: ldr      w9, [x8, #0xe0]
03934c04: cbz      w9, #0x3934c78
03934c08: adrp     x8, #0xee22000
03934c0c: ldr      x1, [x8, #0x40]
03934c10: ldp      x29, x30, [sp, #0x10]
03934c14: ldp      x20, x19, [sp], #0x20
03934c18: b        #0xa9c76a0

; FrameEngine.Logic.ActorComponentSkillMgr.GetSkillIDByIndexSync 0x3935430
03935430: stp      x22, x21, [sp, #-0x30]!
03935434: stp      x20, x19, [sp, #0x10]
03935438: stp      x29, x30, [sp, #0x20]
0393543c: add      x29, sp, #0x20
03935440: mov      x19, x1
03935444: mov      x20, x0
03935448: adrp     x21, #0xf1f4000
0393544c: ldrb     w8, [x21, #0x123]
03935450: tbz      w8, #0, #0x3935480
03935454: ldr      x20, [x20, #0x10]
03935458: adrp     x8, #0xed68000
0393545c: ldr      x0, [x8, #0x880]
03935460: ldr      w8, [x0, #0xe0]
03935464: cbz      w8, #0x39354a8
03935468: mov      x0, x20
0393546c: mov      x1, x19
03935470: ldp      x29, x30, [sp, #0x20]
03935474: ldp      x20, x19, [sp, #0x10]
03935478: ldp      x22, x21, [sp], #0x30
0393547c: b        #0x7c0f8c8

; FrameEngine.Logic.ActorSkill.get_objId 0x39451d0
039451d0: ldr      x8, [x0, #0x18]
039451d4: ldr      w0, [x8, #0x20]
039451d8: ret      

; FrameEngine.Logic.ActorSkill.get_level 0x3945288
03945288: ldr      x8, [x0, #0x18]
0394528c: ldr      w0, [x8, #0x38]
03945290: ret      

; FrameEngine.Logic.ActorSkill.get_resId 0x39452ac
039452ac: ldr      x8, [x0, #0x18]
039452b0: ldr      w0, [x8, #0x44]
039452b4: ret      

; FrameEngine.Logic.ActorSkill.get__slot 0x3945480
03945480: stp      x20, x19, [sp, #-0x20]!
03945484: stp      x29, x30, [sp, #0x10]
03945488: add      x29, sp, #0x10
0394548c: mov      x19, x0
03945490: adrp     x20, #0xf276000
03945494: ldrb     w8, [x20, #0xc40]
03945498: tbnz     w8, #0, #0x39454bc
0394549c: adrp     x0, #0xee22000
039454a0: add      x0, x0, #0x100
039454a4: bl       #0x172b24c
039454a8: adrp     x0, #0xed74000
039454ac: add      x0, x0, #0x100
039454b0: bl       #0x172b24c
039454b4: mov      w8, #1
039454b8: strb     w8, [x20, #0xc40]
039454bc: ldr      x8, [x19, #0x18]
039454c0: ldr      x20, [x8, #0x108]
039454c4: cbz      x20, #0x394552c
039454c8: ldr      x0, [x19, #0x30]!
039454cc: cbz      x0, #0x39454e8
039454d0: ldr      x8, [x0, #0x10]
039454d4: mov      w9, w8
039454d8: cmp      x8, x20
039454dc: mov      w8, #-0x22222223
039454e0: ccmp     x9, x8, #4, eq
039454e4: b.ne     #0x3945520
039454e8: adrp     x8, #0xed74000
039454ec: ldr      x0, [x8, #0x100]
039454f0: ldr      w8, [x0, #0xe0]
039454f4: cbnz     w8, #0x39454fc
039454f8: bl       #0x172b3a8
039454fc: adrp     x8, #0xee22000
03945500: ldr      x1, [x8, #0x100]
03945504: mov      x0, x20
03945508: bl       #0xa9c76a0
0394550c: mov      x1, x0
03945510: str      x0, [x19]
03945514: mov      x0, x19
03945518: bl       #0x172b1d8
0394551c: ldr      x0, [x19]
03945520: ldp      x29, x30, [sp, #0x10]
03945524: ldp      x20, x19, [sp], #0x20
03945528: ret      

; FrameEngine.Logic.SkillSlot.get_level 0x3bd7de8
03bd7de8: ldr      x8, [x0, #0x18]
03bd7dec: ldr      w0, [x8, #0x30]
03bd7df0: ret      

; FrameEngine.Logic.SkillSlot.get_defaultSkill 0x3bd7f24
03bd7f24: stp      x20, x19, [sp, #-0x20]!
03bd7f28: stp      x29, x30, [sp, #0x10]
03bd7f2c: add      x29, sp, #0x10
03bd7f30: mov      x19, x0
03bd7f34: adrp     x20, #0xf276000
03bd7f38: ldrb     w8, [x20, #0xcf4]
03bd7f3c: tbnz     w8, #0, #0x3bd7f60
03bd7f40: adrp     x0, #0xee22000
03bd7f44: add      x0, x0, #0x40
03bd7f48: bl       #0x172b24c
03bd7f4c: adrp     x0, #0xed74000
03bd7f50: add      x0, x0, #0x100
03bd7f54: bl       #0x172b24c
03bd7f58: mov      w8, #1
03bd7f5c: strb     w8, [x20, #0xcf4]
03bd7f60: ldr      x8, [x19, #0x18]
03bd7f64: ldr      x20, [x8, #0x90]
03bd7f68: cbz      x20, #0x3bd7fd0
03bd7f6c: ldr      x0, [x19, #0x30]!
03bd7f70: cbz      x0, #0x3bd7f8c
03bd7f74: ldr      x8, [x0, #0x10]
03bd7f78: mov      w9, w8
03bd7f7c: cmp      x8, x20
03bd7f80: mov      w8, #-0x22222223
03bd7f84: ccmp     x9, x8, #4, eq
03bd7f88: b.ne     #0x3bd7fc4
03bd7f8c: adrp     x8, #0xed74000
03bd7f90: ldr      x0, [x8, #0x100]
03bd7f94: ldr      w8, [x0, #0xe0]
03bd7f98: cbnz     w8, #0x3bd7fa0
03bd7f9c: bl       #0x172b3a8
03bd7fa0: adrp     x8, #0xee22000
03bd7fa4: ldr      x1, [x8, #0x40]
03bd7fa8: mov      x0, x20
03bd7fac: bl       #0xa9c76a0
03bd7fb0: mov      x1, x0
03bd7fb4: str      x0, [x19]
03bd7fb8: mov      x0, x19
03bd7fbc: bl       #0x172b1d8
03bd7fc0: ldr      x0, [x19]
03bd7fc4: ldp      x29, x30, [sp, #0x10]
03bd7fc8: ldp      x20, x19, [sp], #0x20
03bd7fcc: ret      

; FrameEngine.Logic.SkillSlot.get_currentSkill 0x3bd7ff0
03bd7ff0: stp      x20, x19, [sp, #-0x20]!
03bd7ff4: stp      x29, x30, [sp, #0x10]
03bd7ff8: add      x29, sp, #0x10
03bd7ffc: mov      x19, x0
03bd8000: adrp     x20, #0xf276000
03bd8004: ldrb     w8, [x20, #0xcf5]
03bd8008: tbnz     w8, #0, #0x3bd802c
03bd800c: adrp     x0, #0xee22000
03bd8010: add      x0, x0, #0x40
03bd8014: bl       #0x172b24c
03bd8018: adrp     x0, #0xed74000
03bd801c: add      x0, x0, #0x100
03bd8020: bl       #0x172b24c
03bd8024: mov      w8, #1
03bd8028: strb     w8, [x20, #0xcf5]
03bd802c: ldr      x8, [x19, #0x18]
03bd8030: ldr      x20, [x8, #0x98]
03bd8034: cbz      x20, #0x3bd809c
03bd8038: ldr      x0, [x19, #0x38]!
03bd803c: cbz      x0, #0x3bd8058
03bd8040: ldr      x8, [x0, #0x10]
03bd8044: mov      w9, w8
03bd8048: cmp      x8, x20
03bd804c: mov      w8, #-0x22222223
03bd8050: ccmp     x9, x8, #4, eq
03bd8054: b.ne     #0x3bd8090
03bd8058: adrp     x8, #0xed74000
03bd805c: ldr      x0, [x8, #0x100]
03bd8060: ldr      w8, [x0, #0xe0]
03bd8064: cbnz     w8, #0x3bd806c
03bd8068: bl       #0x172b3a8
03bd806c: adrp     x8, #0xee22000
03bd8070: ldr      x1, [x8, #0x40]
03bd8074: mov      x0, x20
03bd8078: bl       #0xa9c76a0
03bd807c: mov      x1, x0
03bd8080: str      x0, [x19]
03bd8084: mov      x0, x19
03bd8088: bl       #0x172b1d8
03bd808c: ldr      x0, [x19]
03bd8090: ldp      x29, x30, [sp, #0x10]
03bd8094: ldp      x20, x19, [sp], #0x20
03bd8098: ret      

; FrameEngine.Logic.SkillSlot.get_orignalSkill 0x3bd80bc
03bd80bc: stp      x20, x19, [sp, #-0x20]!
03bd80c0: stp      x29, x30, [sp, #0x10]
03bd80c4: add      x29, sp, #0x10
03bd80c8: mov      x19, x0
03bd80cc: adrp     x20, #0xf276000
03bd80d0: ldrb     w8, [x20, #0xcf6]
03bd80d4: tbnz     w8, #0, #0x3bd80f8
03bd80d8: adrp     x0, #0xee22000
03bd80dc: add      x0, x0, #0x40
03bd80e0: bl       #0x172b24c
03bd80e4: adrp     x0, #0xed74000
03bd80e8: add      x0, x0, #0x100
03bd80ec: bl       #0x172b24c
03bd80f0: mov      w8, #1
03bd80f4: strb     w8, [x20, #0xcf6]
03bd80f8: ldr      x8, [x19, #0x18]
03bd80fc: ldr      x20, [x8, #0xa0]
03bd8100: cbz      x20, #0x3bd8168
03bd8104: ldr      x0, [x19, #0x40]!
03bd8108: cbz      x0, #0x3bd8124
03bd810c: ldr      x8, [x0, #0x10]
03bd8110: mov      w9, w8
03bd8114: cmp      x8, x20
03bd8118: mov      w8, #-0x22222223
03bd811c: ccmp     x9, x8, #4, eq
03bd8120: b.ne     #0x3bd815c
03bd8124: adrp     x8, #0xed74000
03bd8128: ldr      x0, [x8, #0x100]
03bd812c: ldr      w8, [x0, #0xe0]
03bd8130: cbnz     w8, #0x3bd8138
03bd8134: bl       #0x172b3a8
03bd8138: adrp     x8, #0xee22000
03bd813c: ldr      x1, [x8, #0x40]
03bd8140: mov      x0, x20
03bd8144: bl       #0xa9c76a0
03bd8148: mov      x1, x0
03bd814c: str      x0, [x19]
03bd8150: mov      x0, x19
03bd8154: bl       #0x172b1d8
03bd8158: ldr      x0, [x19]
03bd815c: ldp      x29, x30, [sp, #0x10]
03bd8160: ldp      x20, x19, [sp], #0x20
03bd8164: ret      

; FrameEngine.Logic.SkillSlot.get_owner 0x3bd82ac
03bd82ac: stp      x20, x19, [sp, #-0x20]!
03bd82b0: stp      x29, x30, [sp, #0x10]
03bd82b4: add      x29, sp, #0x10
03bd82b8: mov      x19, x0
03bd82bc: adrp     x20, #0xf1f5000
03bd82c0: ldrb     w8, [x20, #0x668]
03bd82c4: tbnz     w8, #0, #0x3bd82e8
03bd82c8: adrp     x0, #0xee22000
03bd82cc: add      x0, x0, #0x60
03bd82d0: bl       #0x172b24c
03bd82d4: adrp     x0, #0xed74000
03bd82d8: add      x0, x0, #0x100
03bd82dc: bl       #0x172b24c
03bd82e0: mov      w8, #1
03bd82e4: strb     w8, [x20, #0x668]
03bd82e8: ldr      x8, [x19, #0x18]
03bd82ec: ldr      x20, [x8, #0xb0]
03bd82f0: cbz      x20, #0x3bd8358
03bd82f4: ldr      x0, [x19, #0x50]!
03bd82f8: cbz      x0, #0x3bd8314
03bd82fc: ldr      x8, [x0, #0x10]
03bd8300: mov      w9, w8
03bd8304: cmp      x8, x20
03bd8308: mov      w8, #-0x22222223
03bd830c: ccmp     x9, x8, #4, eq
03bd8310: b.ne     #0x3bd834c
03bd8314: adrp     x8, #0xed74000
03bd8318: ldr      x0, [x8, #0x100]
03bd831c: ldr      w8, [x0, #0xe0]
03bd8320: cbnz     w8, #0x3bd8328
03bd8324: bl       #0x172b3a8
03bd8328: adrp     x8, #0xee22000
03bd832c: ldr      x1, [x8, #0x60]
03bd8330: mov      x0, x20
03bd8334: bl       #0xa9c76a0
03bd8338: mov      x1, x0
03bd833c: str      x0, [x19]
03bd8340: mov      x0, x19
03bd8344: bl       #0x172b1d8
03bd8348: ldr      x0, [x19]
03bd834c: ldp      x29, x30, [sp, #0x10]
03bd8350: ldp      x20, x19, [sp], #0x20
03bd8354: ret      

; FrameEngine.Logic.SkillSlot.get_index 0x3bd8378
03bd8378: ldr      x8, [x0, #0x18]
03bd837c: ldr      w0, [x8, #0xb8]
03bd8380: ret      

; GetRSkillSync -> _FE_TN276 -> FEProj 0xf624

; FEProj 0xf624
0000f624: stp      x20, x19, [sp, #-0x20]!
0000f628: stp      x29, x30, [sp, #0x10]
0000f62c: add      x29, sp, #0x10
0000f630: mov      x19, x0
0000f634: bl       #0xd03e60
0000f638: cbz      x0, #0xf660
0000f63c: bl       #0xd03e60
0000f640: ldrb     w8, [x0, #0x1e]
0000f644: cbz      w8, #0xf680
0000f648: cbz      x19, #0xf698
0000f64c: mov      x0, x19
0000f650: bl       #0xffa200
0000f654: ldp      x29, x30, [sp, #0x10]
0000f658: ldp      x20, x19, [sp], #0x20
0000f65c: ret      
0000f660: adrp     x2, #0x4590000
0000f664: add      x2, x2, #0x160
0000f668: mov      w1, #1
0000f66c: bl       #0x3ca7950
0000f670: mov      x0, #0
0000f674: ldp      x29, x30, [sp, #0x10]
0000f678: ldp      x20, x19, [sp], #0x20
0000f67c: ret      
0000f680: cbz      x19, #0xf698
0000f684: mov      x0, x19
0000f688: bl       #0xff9f88
0000f68c: ldp      x29, x30, [sp, #0x10]
0000f690: ldp      x20, x19, [sp], #0x20
0000f694: ret      
0000f698: adrp     x2, #0x4590000
0000f69c: add      x2, x2, #0x1aa
0000f6a0: mov      w0, #0
0000f6a4: mov      w1, #1
0000f6a8: bl       #0x3ca7950
0000f6ac: mov      x0, #0
0000f6b0: ldp      x29, x30, [sp, #0x10]
0000f6b4: ldp      x20, x19, [sp], #0x20
0000f6b8: ret      
0000f6bc: stp      x20, x19, [sp, #-0x20]!
0000f6c0: stp      x29, x30, [sp, #0x10]
0000f6c4: add      x29, sp, #0x10
0000f6c8: mov      x19, x0
0000f6cc: bl       #0xd03e60
0000f6d0: cbz      x0, #0xf6f8
0000f6d4: bl       #0xd03e60
0000f6d8: ldrb     w8, [x0, #0x1e]
0000f6dc: cbz      w8, #0xf718
0000f6e0: cbz      x19, #0xf730
0000f6e4: mov      x0, x19
0000f6e8: bl       #0xffa534
0000f6ec: ldp      x29, x30, [sp, #0x10]
0000f6f0: ldp      x20, x19, [sp], #0x20
0000f6f4: ret      
0000f6f8: adrp     x2, #0x4590000
0000f6fc: add      x2, x2, #0x1e4
0000f700: mov      w1, #1
0000f704: bl       #0x3ca7950
0000f708: mov      x0, #0
0000f70c: ldp      x29, x30, [sp, #0x10]
0000f710: ldp      x20, x19, [sp], #0x20
0000f714: ret      
0000f718: cbz      x19, #0xf730
0000f71c: mov      x0, x19
0000f720: bl       #0xffa478

; FEProj 0xd03e60
00d03e60: adrp     x8, #0x523c000
00d03e64: add      x8, x8, #0xf28
00d03e68: ldr      x8, [x8]
00d03e6c: cbz      x8, #0xd03e7c
00d03e70: ldr      x0, [x8, #0x18]
00d03e74: cbz      x0, #0xd03e7c
00d03e78: ret      
00d03e7c: mov      x0, #0
00d03e80: ret      
00d03e84: stp      x20, x19, [sp, #-0x20]!
00d03e88: stp      x29, x30, [sp, #0x10]
00d03e8c: add      x29, sp, #0x10
00d03e90: adrp     x8, #0x523c000
00d03e94: add      x8, x8, #0xf28
00d03e98: ldr      x19, [x8]
00d03e9c: ldr      x0, [x19, #0x38]
00d03ea0: cbz      x0, #0xd03eb0
00d03ea4: ldp      x29, x30, [sp, #0x10]
00d03ea8: ldp      x20, x19, [sp], #0x20
00d03eac: ret      
00d03eb0: adrp     x2, #0x45eb000
00d03eb4: add      x2, x2, #0x600
00d03eb8: mov      w1, #2
00d03ebc: bl       #0x3ca7950
00d03ec0: ldr      x0, [x19, #0x38]
00d03ec4: ldp      x29, x30, [sp, #0x10]
00d03ec8: ldp      x20, x19, [sp], #0x20
00d03ecc: ret      
00d03ed0: stp      x20, x19, [sp, #-0x20]!
00d03ed4: stp      x29, x30, [sp, #0x10]
00d03ed8: add      x29, sp, #0x10
00d03edc: adrp     x8, #0x523c000
00d03ee0: add      x8, x8, #0xf28
00d03ee4: ldr      x19, [x8]
00d03ee8: ldr      x0, [x19, #0x10]
00d03eec: cbz      x0, #0xd03efc
00d03ef0: ldp      x29, x30, [sp, #0x10]
00d03ef4: ldp      x20, x19, [sp], #0x20
00d03ef8: ret      
00d03efc: adrp     x2, #0x45eb000
00d03f00: add      x2, x2, #0x621
00d03f04: mov      w1, #2
00d03f08: bl       #0x3ca7950
00d03f0c: ldr      x0, [x19, #0x10]
00d03f10: ldp      x29, x30, [sp, #0x10]
00d03f14: ldp      x20, x19, [sp], #0x20
00d03f18: ret      
00d03f1c: adrp     x8, #0x523c000
00d03f20: add      x8, x8, #0xf28
00d03f24: ldr      x8, [x8]
00d03f28: cbz      x8, #0xd03f3c
00d03f2c: ldr      x8, [x8, #0x10]
00d03f30: cbz      x8, #0xd03f3c
00d03f34: ldr      x0, [x8, #0x10]
00d03f38: ret      
00d03f3c: mov      x0, #0
00d03f40: ret      
00d03f44: stp      x20, x19, [sp, #-0x20]!
00d03f48: stp      x29, x30, [sp, #0x10]
00d03f4c: add      x29, sp, #0x10
00d03f50: adrp     x8, #0x523c000
00d03f54: add      x8, x8, #0xf28
00d03f58: ldr      x19, [x8]
00d03f5c: ldr      x0, [x19, #0x20]

; FEProj 0xffa200
00ffa200: sub      sp, sp, #0x70
00ffa204: stp      x26, x25, [sp, #0x20]
00ffa208: stp      x24, x23, [sp, #0x30]
00ffa20c: stp      x22, x21, [sp, #0x40]
00ffa210: stp      x20, x19, [sp, #0x50]
00ffa214: stp      x29, x30, [sp, #0x60]
00ffa218: add      x29, sp, #0x60
00ffa21c: mov      x19, x0
00ffa220: adrp     x8, #0x51aa000
00ffa224: ldr      x8, [x8, #0xa70]
00ffa228: cbz      x8, #0xffa294
00ffa22c: sub      sp, sp, #0xa0
00ffa230: stp      x0, x1, [sp]
00ffa234: stp      x2, x3, [sp, #0x10]
00ffa238: stp      x4, x5, [sp, #0x20]
00ffa23c: stp      x6, x7, [sp, #0x30]
00ffa240: stp      x8, x19, [sp, #0x40]
00ffa244: stp      x20, x21, [sp, #0x50]
00ffa248: stp      x22, x23, [sp, #0x60]
00ffa24c: stp      x24, x25, [sp, #0x70]
00ffa250: stp      x26, x27, [sp, #0x80]
00ffa254: str      x28, [sp, #0x90]
00ffa258: mov      x0, sp
00ffa25c: mov      x1, x29
00ffa260: mov      w2, #0xa0
00ffa264: bl       #0x41fdc1c
00ffa268: ldp      x0, x1, [sp]
00ffa26c: ldp      x8, x2, [sp, #0x10]
00ffa270: ldp      x19, x20, [sp, #0x20]
00ffa274: ldp      x21, x22, [sp, #0x30]
00ffa278: ldp      x23, x24, [sp, #0x40]
00ffa27c: ldp      x25, x26, [sp, #0x50]
00ffa280: ldp      x27, x28, [sp, #0x60]
00ffa284: ldp      x29, x30, [sp, #0x70]
00ffa288: add      sp, sp, x2
00ffa28c: ret      
00ffa290: bl       #0x41fd89c
00ffa294: ldr      x20, [x19, #0x18]
00ffa298: cbz      x20, #0xffa438
00ffa29c: mov      x0, x20
00ffa2a0: bl       #0x101c560
00ffa2a4: cbz      w0, #0xffa438
00ffa2a8: ldr      x23, [x20, #0x78]
00ffa2ac: ldp      x9, x8, [x23, #0x78]
00ffa2b0: sub      x8, x8, x9
00ffa2b4: sbfx     x24, x8, #2, #0x20
00ffa2b8: mov      x22, sp
00ffa2bc: cmp      x24, #1
00ffa2c0: csinc    x8, x24, xzr, hi
00ffa2c4: lsl      x21, x8, #2
00ffa2c8: stp      xzr, xzr, [sp, #8]
00ffa2cc: str      xzr, [sp]
00ffa2d0: adrp     x3, #0x45b4000
00ffa2d4: add      x3, x3, #0x51b
00ffa2d8: mov      w25, #4
00ffa2dc: add      x0, x22, #0x10
00ffa2e0: mov      x1, x21
00ffa2e4: mov      w2, #4
00ffa2e8: bl       #0x3c916e4
00ffa2ec: mov      x20, x0
00ffa2f0: cbnz     x0, #0xffa30c
00ffa2f4: cbz      x21, #0xffa308
00ffa2f8: mov      x0, x21
00ffa2fc: bl       #0x4586464

; FEProj 0x3ca7950
03ca7950: stp      x22, x21, [sp, #-0x30]!
03ca7954: stp      x20, x19, [sp, #0x10]
03ca7958: stp      x29, x30, [sp, #0x20]
03ca795c: add      x29, sp, #0x20
03ca7960: sub      sp, sp, #0x440
03ca7964: adrp     x8, #0x4ab8000
03ca7968: ldr      x8, [x8, #0xc8]
03ca796c: ldr      x8, [x8]
03ca7970: stur     x8, [x29, #-0x28]
03ca7974: tbnz     w0, #0, #0x3ca79f8
03ca7978: add      x0, sp, #0x38
03ca797c: mov      w1, #0x400
03ca7980: mov      x19, x2
03ca7984: bl       #0x45860d4
03ca7988: add      x8, x29, #0x10
03ca798c: str      x8, [sp, #0x28]
03ca7990: add      x0, sp, #0x38
03ca7994: add      x3, x29, #0x10
03ca7998: mov      w1, #0x400
03ca799c: mov      x2, x19
03ca79a0: bl       #0x458695c
03ca79a4: add      x20, sp, #8
03ca79a8: add      x0, sp, #8
03ca79ac: add      x1, sp, #0x38
03ca79b0: add      x2, sp, #0x30
03ca79b4: bl       #0x230484
03ca79b8: add      x0, sp, #8
03ca79bc: bl       #0xd04a0c
03ca79c0: ldr      x19, [sp, #0x18]
03ca79c4: cbz      x19, #0x3ca79f8
03ca79c8: ldr      x21, [sp, #8]
03ca79cc: sub      w2, w21, w19
03ca79d0: adrp     x3, #0x45b4000
03ca79d4: add      x3, x3, #0xba2
03ca79d8: add      x0, x20, #0x10
03ca79dc: mov      x1, x19
03ca79e0: bl       #0x3c91930
03ca79e4: cmp      x21, x19
03ca79e8: csinc    w8, w0, wzr, ne
03ca79ec: tbnz     w8, #0, #0x3ca79f8
03ca79f0: mov      x0, x19
03ca79f4: bl       #0x4586278
03ca79f8: ldur     x8, [x29, #-0x28]
03ca79fc: adrp     x9, #0x4ab8000
03ca7a00: ldr      x9, [x9, #0xc8]
03ca7a04: ldr      x9, [x9]
03ca7a08: cmp      x9, x8
03ca7a0c: b.ne     #0x3ca7a24
03ca7a10: add      sp, sp, #0x440
03ca7a14: ldp      x29, x30, [sp, #0x20]
03ca7a18: ldp      x20, x19, [sp, #0x10]
03ca7a1c: ldp      x22, x21, [sp], #0x30
03ca7a20: ret      
03ca7a24: bl       #0x4585ffc
03ca7a28: bl       #0x1aa64
03ca7a2c: mov      x19, x0
03ca7a30: add      x0, sp, #8
03ca7a34: bl       #0x22feb0
03ca7a38: mov      x0, x19
03ca7a3c: bl       #0x4585984
03ca7a40: stp      x20, x19, [sp, #-0x20]!
03ca7a44: stp      x29, x30, [sp, #0x10]
03ca7a48: add      x29, sp, #0x10
03ca7a4c: sub      sp, sp, #0x430

; FEProj 0xff9f88
00ff9f88: sub      sp, sp, #0x70
00ff9f8c: stp      x26, x25, [sp, #0x20]
00ff9f90: stp      x24, x23, [sp, #0x30]
00ff9f94: stp      x22, x21, [sp, #0x40]
00ff9f98: stp      x20, x19, [sp, #0x50]
00ff9f9c: stp      x29, x30, [sp, #0x60]
00ff9fa0: add      x29, sp, #0x60
00ff9fa4: mov      x19, x0
00ff9fa8: adrp     x8, #0x51aa000
00ff9fac: ldr      x8, [x8, #0xa68]
00ff9fb0: cbz      x8, #0xffa01c
00ff9fb4: sub      sp, sp, #0xa0
00ff9fb8: stp      x0, x1, [sp]
00ff9fbc: stp      x2, x3, [sp, #0x10]
00ff9fc0: stp      x4, x5, [sp, #0x20]
00ff9fc4: stp      x6, x7, [sp, #0x30]
00ff9fc8: stp      x8, x19, [sp, #0x40]
00ff9fcc: stp      x20, x21, [sp, #0x50]
00ff9fd0: stp      x22, x23, [sp, #0x60]
00ff9fd4: stp      x24, x25, [sp, #0x70]
00ff9fd8: stp      x26, x27, [sp, #0x80]
00ff9fdc: str      x28, [sp, #0x90]
00ff9fe0: mov      x0, sp
00ff9fe4: mov      x1, x29
00ff9fe8: mov      w2, #0xa0
00ff9fec: bl       #0x41fdc1c
00ff9ff0: ldp      x0, x1, [sp]
00ff9ff4: ldp      x8, x2, [sp, #0x10]
00ff9ff8: ldp      x19, x20, [sp, #0x20]
00ff9ffc: ldp      x21, x22, [sp, #0x30]
00ffa000: ldp      x23, x24, [sp, #0x40]
00ffa004: ldp      x25, x26, [sp, #0x50]
00ffa008: ldp      x27, x28, [sp, #0x60]
00ffa00c: ldp      x29, x30, [sp, #0x70]
00ffa010: add      sp, sp, x2
00ffa014: ret      
00ffa018: bl       #0x41fd89c
00ffa01c: ldr      x20, [x19, #0x28]
00ffa020: cbz      x20, #0xffa1c0
00ffa024: mov      x0, x20
00ffa028: bl       #0x101c544
00ffa02c: cbz      w0, #0xffa1c0
00ffa030: ldr      x23, [x20, #0x190]
00ffa034: ldp      x9, x8, [x23, #0x78]
00ffa038: sub      x8, x8, x9
00ffa03c: sbfx     x24, x8, #2, #0x20
00ffa040: mov      x22, sp
00ffa044: cmp      x24, #1
00ffa048: csinc    x8, x24, xzr, hi
00ffa04c: lsl      x21, x8, #2
00ffa050: stp      xzr, xzr, [sp, #8]
00ffa054: str      xzr, [sp]
00ffa058: adrp     x3, #0x45b4000
00ffa05c: add      x3, x3, #0x51b
00ffa060: mov      w25, #4
00ffa064: add      x0, x22, #0x10
00ffa068: mov      x1, x21
00ffa06c: mov      w2, #4
00ffa070: bl       #0x3c916e4
00ffa074: mov      x20, x0
00ffa078: cbnz     x0, #0xffa094
00ffa07c: cbz      x21, #0xffa090
00ffa080: mov      x0, x21
00ffa084: bl       #0x4586464

; FEProj 0xffa534
00ffa534: stp      x20, x19, [sp, #-0x20]!
00ffa538: stp      x29, x30, [sp, #0x10]
00ffa53c: add      x29, sp, #0x10
00ffa540: mov      x19, x0
00ffa544: adrp     x8, #0x51aa000
00ffa548: ldr      x8, [x8, #0xa80]
00ffa54c: cbz      x8, #0xffa5b8
00ffa550: sub      sp, sp, #0xa0
00ffa554: stp      x0, x1, [sp]
00ffa558: stp      x2, x3, [sp, #0x10]
00ffa55c: stp      x4, x5, [sp, #0x20]
00ffa560: stp      x6, x7, [sp, #0x30]
00ffa564: stp      x8, x19, [sp, #0x40]
00ffa568: stp      x20, x21, [sp, #0x50]
00ffa56c: stp      x22, x23, [sp, #0x60]
00ffa570: stp      x24, x25, [sp, #0x70]
00ffa574: stp      x26, x27, [sp, #0x80]
00ffa578: str      x28, [sp, #0x90]
00ffa57c: mov      x0, sp
00ffa580: mov      x1, x29
00ffa584: mov      w2, #0xa0
00ffa588: bl       #0x41fdc1c
00ffa58c: ldp      x0, x1, [sp]
00ffa590: ldp      x8, x2, [sp, #0x10]
00ffa594: ldp      x19, x20, [sp, #0x20]
00ffa598: ldp      x21, x22, [sp, #0x30]
00ffa59c: ldp      x23, x24, [sp, #0x40]
00ffa5a0: ldp      x25, x26, [sp, #0x50]
00ffa5a4: ldp      x27, x28, [sp, #0x60]
00ffa5a8: ldp      x29, x30, [sp, #0x70]
00ffa5ac: add      sp, sp, x2
00ffa5b0: ret      
00ffa5b4: bl       #0x41fd89c
00ffa5b8: ldp      x8, x9, [x19, #0x98]
00ffa5bc: cmp      x9, x8
00ffa5c0: b.eq     #0xffa5ec
00ffa5c4: ldr      x8, [x8]
00ffa5c8: cbz      x8, #0xffa5dc
00ffa5cc: ldr      x0, [x8, #0x98]
00ffa5d0: ldp      x29, x30, [sp, #0x10]
00ffa5d4: ldp      x20, x19, [sp], #0x20
00ffa5d8: ret      
00ffa5dc: mov      x0, #0
00ffa5e0: ldp      x29, x30, [sp, #0x10]
00ffa5e4: ldp      x20, x19, [sp], #0x20
00ffa5e8: ret      
00ffa5ec: bl       #0xffeb10
00ffa5f0: stp      x20, x19, [sp, #-0x20]!
00ffa5f4: stp      x29, x30, [sp, #0x10]
00ffa5f8: add      x29, sp, #0x10
00ffa5fc: mov      x19, x0
00ffa600: adrp     x8, #0x51aa000
00ffa604: ldr      x8, [x8, #0xa88]
00ffa608: cbz      x8, #0xffa674
00ffa60c: sub      sp, sp, #0xa0
00ffa610: stp      x0, x1, [sp]
00ffa614: stp      x2, x3, [sp, #0x10]
00ffa618: stp      x4, x5, [sp, #0x20]
00ffa61c: stp      x6, x7, [sp, #0x30]
00ffa620: stp      x8, x19, [sp, #0x40]
00ffa624: stp      x20, x21, [sp, #0x50]
00ffa628: stp      x22, x23, [sp, #0x60]
00ffa62c: stp      x24, x25, [sp, #0x70]
00ffa630: stp      x26, x27, [sp, #0x80]

; FEProj 0xffa478
00ffa478: stp      x20, x19, [sp, #-0x20]!
00ffa47c: stp      x29, x30, [sp, #0x10]
00ffa480: add      x29, sp, #0x10
00ffa484: mov      x19, x0
00ffa488: adrp     x8, #0x51aa000
00ffa48c: ldr      x8, [x8, #0xa78]
00ffa490: cbz      x8, #0xffa4fc
00ffa494: sub      sp, sp, #0xa0
00ffa498: stp      x0, x1, [sp]
00ffa49c: stp      x2, x3, [sp, #0x10]
00ffa4a0: stp      x4, x5, [sp, #0x20]
00ffa4a4: stp      x6, x7, [sp, #0x30]
00ffa4a8: stp      x8, x19, [sp, #0x40]
00ffa4ac: stp      x20, x21, [sp, #0x50]
00ffa4b0: stp      x22, x23, [sp, #0x60]
00ffa4b4: stp      x24, x25, [sp, #0x70]
00ffa4b8: stp      x26, x27, [sp, #0x80]
00ffa4bc: str      x28, [sp, #0x90]
00ffa4c0: mov      x0, sp
00ffa4c4: mov      x1, x29
00ffa4c8: mov      w2, #0xa0
00ffa4cc: bl       #0x41fdc1c
00ffa4d0: ldp      x0, x1, [sp]
00ffa4d4: ldp      x8, x2, [sp, #0x10]
00ffa4d8: ldp      x19, x20, [sp, #0x20]
00ffa4dc: ldp      x21, x22, [sp, #0x30]
00ffa4e0: ldp      x23, x24, [sp, #0x40]
00ffa4e4: ldp      x25, x26, [sp, #0x50]
00ffa4e8: ldp      x27, x28, [sp, #0x60]
00ffa4ec: ldp      x29, x30, [sp, #0x70]
00ffa4f0: add      sp, sp, x2
00ffa4f4: ret      
00ffa4f8: bl       #0x41fd89c
00ffa4fc: ldp      x8, x9, [x19, #0x130]
00ffa500: cmp      x9, x8
00ffa504: b.eq     #0xffa530
00ffa508: ldr      x8, [x8]
00ffa50c: cbz      x8, #0xffa520
00ffa510: ldr      x0, [x8, #0x98]
00ffa514: ldp      x29, x30, [sp, #0x10]
00ffa518: ldp      x20, x19, [sp], #0x20
00ffa51c: ret      
00ffa520: mov      x0, #0
00ffa524: ldp      x29, x30, [sp, #0x10]
00ffa528: ldp      x20, x19, [sp], #0x20
00ffa52c: ret      
00ffa530: bl       #0xffeb0c
00ffa534: stp      x20, x19, [sp, #-0x20]!
00ffa538: stp      x29, x30, [sp, #0x10]
00ffa53c: add      x29, sp, #0x10
00ffa540: mov      x19, x0
00ffa544: adrp     x8, #0x51aa000
00ffa548: ldr      x8, [x8, #0xa80]
00ffa54c: cbz      x8, #0xffa5b8
00ffa550: sub      sp, sp, #0xa0
00ffa554: stp      x0, x1, [sp]
00ffa558: stp      x2, x3, [sp, #0x10]
00ffa55c: stp      x4, x5, [sp, #0x20]
00ffa560: stp      x6, x7, [sp, #0x30]
00ffa564: stp      x8, x19, [sp, #0x40]
00ffa568: stp      x20, x21, [sp, #0x50]
00ffa56c: stp      x22, x23, [sp, #0x60]
00ffa570: stp      x24, x25, [sp, #0x70]
00ffa574: stp      x26, x27, [sp, #0x80]

; FEProj 0x41fdc1c
041fdc1c: sub      sp, sp, #0x170
041fdc20: stp      x28, x27, [sp, #0x110]
041fdc24: stp      x26, x25, [sp, #0x120]
041fdc28: stp      x24, x23, [sp, #0x130]
041fdc2c: stp      x22, x21, [sp, #0x140]
041fdc30: stp      x20, x19, [sp, #0x150]
041fdc34: stp      x29, x30, [sp, #0x160]
041fdc38: add      x29, sp, #0x160
041fdc3c: mov      x21, x30
041fdc40: mov      x22, x1
041fdc44: mov      x20, x0
041fdc48: adrp     x8, #0x4ab8000
041fdc4c: ldr      x8, [x8, #0xc8]
041fdc50: ldr      x8, [x8]
041fdc54: stur     x8, [x29, #-0x60]
041fdc58: bl       #0x41fafb0
041fdc5c: mov      x19, x0
041fdc60: mov      x0, x21
041fdc64: bl       #0x41fb438
041fdc68: mov      x21, x0
041fdc6c: mov      x0, x19
041fdc70: mov      x1, x21
041fdc74: bl       #0x41fb5d8
041fdc78: tbz      w0, #0, #0x41fdce8
041fdc7c: ldr      x23, [x19, #0x250]
041fdc80: ldr      x0, [x19, #0x248]
041fdc84: str      wzr, [sp, #0x50]
041fdc88: movi     v0.16b, #0
041fdc8c: stp      q0, q0, [sp, #0x30]
041fdc90: stp      q0, q0, [sp, #0x10]
041fdc94: add      x2, sp, #0x10
041fdc98: mov      x1, x21
041fdc9c: bl       #0x41fb3cc
041fdca0: tbz      w0, #0, #0x41fdcf8
041fdca4: ldp      x24, x8, [x22]
041fdca8: ldr      w9, [sp, #0x50]
041fdcac: str      x8, [sp, #8]
041fdcb0: str      x8, [x19, #0x130]
041fdcb4: str      xzr, [sp, #0xf0]
041fdcb8: movi     v0.16b, #0
041fdcbc: stp      q0, q0, [sp, #0xd0]
041fdcc0: stp      q0, q0, [sp, #0xb0]
041fdcc4: add      x8, x20, #0x48
041fdcc8: ldrb     w11, [sp, #0x14]
041fdccc: cbz      w11, #0x41fdd40
041fdcd0: ldrsh    x10, [sp, #0x16]
041fdcd4: cbz      x10, #0x41fdd08
041fdcd8: cmp      w11, #4
041fdcdc: b.ne     #0x41fdd24
041fdce0: ldr      w10, [x22, x10]
041fdce4: b        #0x41fdd44

; FEProj 0x41fd89c
041fd89c: sub      sp, sp, #0x20
041fd8a0: stp      x29, x30, [sp, #0x10]
041fd8a4: add      x29, sp, #0x10
041fd8a8: adrp     x8, #0x41fd000
041fd8ac: add      x8, x8, #0x89c
041fd8b0: str      x8, [sp]
041fd8b4: adrp     x0, #0x46a4000
041fd8b8: add      x0, x0, #0x502
041fd8bc: bl       #0x45865d8
041fd8c0: ldp      x29, x30, [sp, #0x10]
041fd8c4: add      sp, sp, #0x20
041fd8c8: ret      
041fd8cc: mov      w8, #0
041fd8d0: cbz      x0, #0x41fdbb0
041fd8d4: cbz      x1, #0x41fdbb0
041fd8d8: ldrb     w8, [x0, #0xc]
041fd8dc: cbz      w8, #0x41fd91c
041fd8e0: cmp      w8, #8
041fd8e4: ccmp     w8, #4, #4, ne
041fd8e8: b.ne     #0x41fdb4c
041fd8ec: ldrb     w9, [x0, #0xd]
041fd8f0: cbz      w9, #0x41fd90c
041fd8f4: cmp      w9, #0xa
041fd8f8: b.lo     #0x41fd90c
041fd8fc: sub      w10, w9, #0x14
041fd900: and      w10, w10, #0xff
041fd904: cmp      w10, #9
041fd908: b.hi     #0x41fdb4c
041fd90c: strb     w8, [x1, #4]
041fd910: strb     w9, [x1, #5]
041fd914: ldrh     w8, [x0, #0xe]
041fd918: strh     w8, [x1, #6]
041fd91c: ldrb     w8, [x0, #0x10]
041fd920: cbz      w8, #0x41fd964
041fd924: cmp      w8, #4
041fd928: b.eq     #0x41fd934
041fd92c: cmp      w8, #8
041fd930: b.ne     #0x41fdb4c
041fd934: ldrb     w9, [x0, #0x11]
041fd938: cbz      w9, #0x41fd954
041fd93c: cmp      w9, #0xa
041fd940: b.lo     #0x41fd954
041fd944: sub      w10, w9, #0x14
041fd948: and      w10, w10, #0xff
041fd94c: cmp      w10, #9
041fd950: b.hi     #0x41fdb4c
041fd954: strb     w8, [x1, #8]
041fd958: strb     w9, [x1, #9]
041fd95c: ldrh     w8, [x0, #0x12]
041fd960: strh     w8, [x1, #0xa]
041fd964: ldrb     w8, [x0, #0x14]
041fd968: cbz      w8, #0x41fd9ac
041fd96c: cmp      w8, #8
041fd970: b.eq     #0x41fd97c
041fd974: cmp      w8, #4
041fd978: b.ne     #0x41fdb4c
041fd97c: ldrb     w9, [x0, #0x15]
041fd980: cbz      w9, #0x41fd99c
041fd984: cmp      w9, #0xa
041fd988: b.lo     #0x41fd99c
041fd98c: sub      w10, w9, #0x14
041fd990: and      w10, w10, #0xff
041fd994: cmp      w10, #9
041fd998: b.hi     #0x41fdb4c

; FEProj 0x101c560
0101c560: ldr      x8, [x0, #0xc0]
0101c564: cbz      x8, #0x101c574
0101c568: ldrb     w8, [x8, #0x88]
0101c56c: ubfx     w0, w8, #3, #1
0101c570: ret      
0101c574: mov      w0, #0
0101c578: ret      
0101c57c: ldr      x8, [x0, #0x1e0]
0101c580: cbz      x8, #0x101c5b4
0101c584: ldrb     w9, [x8, #0x51]
0101c588: cbz      w9, #0x101c594
0101c58c: mov      w0, #1
0101c590: ret      
0101c594: ldr      w9, [x8, #0xcc]
0101c598: cmp      w9, #1
0101c59c: b.lt     #0x101c5bc
0101c5a0: ldr      x9, [x8, #0x400]
0101c5a4: cmp      x9, #0
0101c5a8: b.gt     #0x101c5b4
0101c5ac: ldrb     w9, [x8, #0x41]
0101c5b0: cbz      w9, #0x101c5bc
0101c5b4: mov      w0, #0
0101c5b8: ret      
0101c5bc: ldr      w8, [x8, #0x51c]
0101c5c0: cmp      w8, #2
0101c5c4: cset     w0, eq
0101c5c8: ret      
0101c5cc: ldr      x8, [x0, #0xc0]
0101c5d0: cbz      x8, #0x101c604
0101c5d4: ldrb     w9, [x8, #0x32]
0101c5d8: cbz      w9, #0x101c5e4
0101c5dc: mov      w0, #1
0101c5e0: ret      
0101c5e4: ldr      w9, [x8, #0x74]
0101c5e8: cmp      w9, #1
0101c5ec: b.lt     #0x101c60c
0101c5f0: ldr      x9, [x8, #0x150]
0101c5f4: cmp      x9, #0
0101c5f8: b.gt     #0x101c604
0101c5fc: ldrb     w9, [x8, #0x25]
0101c600: cbz      w9, #0x101c60c
0101c604: mov      w0, #0
0101c608: ret      
0101c60c: ldr      w8, [x8, #0x22c]
0101c610: cmp      w8, #2
0101c614: cset     w0, eq
0101c618: ret      
0101c61c: ldr      x8, [x0, #0x1e0]
0101c620: cbz      x8, #0x101c634
0101c624: ldrb     w9, [x8, #0x51]
0101c628: cbz      w9, #0x101c63c
0101c62c: mov      w0, #1
0101c630: ret      
0101c634: mov      w0, #0
0101c638: ret      
0101c63c: ldr      w9, [x8, #0xcc]
0101c640: cmp      w9, #1
0101c644: b.lt     #0x101c65c
0101c648: ldr      x9, [x8, #0x400]
0101c64c: cmp      x9, #0
0101c650: b.gt     #0x101c670
0101c654: ldrb     w9, [x8, #0x41]
0101c658: cbnz     w9, #0x101c670
0101c65c: ldr      w9, [x8, #0x51c]
