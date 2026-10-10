02cc42e8: sub      sp, sp, #0x70
02cc42ec: stp      x28, x27, [sp, #0x10]
02cc42f0: stp      x26, x25, [sp, #0x20]
02cc42f4: stp      x24, x23, [sp, #0x30]
02cc42f8: stp      x22, x21, [sp, #0x40]
02cc42fc: stp      x20, x19, [sp, #0x50]
02cc4300: stp      x29, x30, [sp, #0x60]
02cc4304: add      x29, sp, #0x60
02cc4308: cmn      w0, #1
02cc430c: b.eq     #0x2cc446c
02cc4310: mov      x20, x0
02cc4314: adrp     x8, #0x10a91000
02cc4318: ldr      x21, [x8, #0x5f8]
02cc431c: ldr      x19, [x21, w0, sxtw #3]
02cc4320: dmb      ishld
02cc4324: cbnz     x19, #0x2cc468c
02cc4328: sxtw     x22, w20
02cc432c: adrp     x1, #0x10b35000
02cc4330: add      x1, x1, #0xbf0
02cc4334: add      x0, sp, #8
02cc4338: bl       #0x2c6c080
02cc433c: ldr      x19, [x21, x22, lsl #3]
02cc4340: cbnz     x19, #0x2cc4684
02cc4344: adrp     x27, #0x10a91000
02cc4348: ldr      x8, [x27, #0x5d0]
02cc434c: adrp     x28, #0x10a91000
02cc4350: ldr      x9, [x28, #0x5d8]
02cc4354: ldrsw    x9, [x9, #0xa0]
02cc4358: add      x24, x8, x9
02cc435c: mov      w8, #0x58
02cc4360: adrp     x9, #0x10a91000
02cc4364: ldr      x9, [x9, #0x5c8]
02cc4368: ldr      x9, [x9, #0x68]
02cc436c: ldr      x26, [x9, x22, lsl #3]
02cc4370: madd     x25, x22, x8, x24
02cc4374: mov      x23, x25
02cc4378: ldrh     w8, [x23, #0x4a]!
02cc437c: lsl      x8, x8, #4
02cc4380: add      x1, x8, #0x138
02cc4384: mov      w0, #1
02cc4388: bl       #0x2ca2ff8
02cc438c: mov      x19, x0
02cc4390: str      x0, [x0, #0x78]
02cc4394: adrp     x8, #0x10a91000
02cc4398: ldr      w8, [x8, #0x5e0]
02cc439c: cmp      w8, #1
02cc43a0: b.lt     #0x2cc43dc
02cc43a4: adrp     x9, #0x10a91000
02cc43a8: ldr      x9, [x9, #0x5e8]
02cc43ac: add      x9, x9, #0x10
02cc43b0: ldur     w11, [x9, #-0x10]
02cc43b4: cmp      w11, w20
02cc43b8: b.gt     #0x2cc43d0
02cc43bc: ldr      x10, [x9]
02cc43c0: ldr      w12, [x10, #0x18]
02cc43c4: add      w11, w12, w11
02cc43c8: cmp      w11, w20
02cc43cc: b.hi     #0x2cc43e0
02cc43d0: add      x9, x9, #0x18
02cc43d4: subs     x8, x8, #1
02cc43d8: b.ne     #0x2cc43b0
02cc43dc: mov      x10, #0
02cc43e0: str      x10, [x19]
02cc43e4: ldr      w0, [x25]
02cc43e8: bl       #0x2cc4004
02cc43ec: str      x0, [x19, #0x10]
02cc43f0: mov      w8, #0x58
02cc43f4: madd     x8, x22, x8, x24
02cc43f8: ldr      w0, [x8, #4]
02cc43fc: bl       #0x2cc4004
02cc4400: str      x0, [x19, #0x18]
02cc4404: mov      w8, #0x58
02cc4408: madd     x9, x22, x8, x24
02cc440c: ldrsw    x8, [x9, #8]
02cc4410: adrp     x10, #0x10a91000
02cc4414: ldr      x10, [x10, #0x5c8]
02cc4418: ldr      x10, [x10, #0x38]
02cc441c: ldr      x8, [x10, x8, lsl #3]
02cc4420: add      x0, x19, #0x20
02cc4424: ldr      q0, [x8]
02cc4428: str      q0, [x19, #0x20]
02cc442c: ldr      q0, [x8]
02cc4430: str      q0, [x19, #0x30]
02cc4434: ldr      w8, [x19, #0x38]
02cc4438: and      w8, w8, #0x7fffffff
02cc443c: orr      w8, w8, #0x20000000
02cc4440: str      w8, [x19, #0x38]
02cc4444: str      x25, [x19, #0x68]
02cc4448: ldrsw    x8, [x9, #0x18]!
02cc444c: cmn      w8, #1
02cc4450: b.eq     #0x2cc4474
02cc4454: ldr      x10, [x27, #0x5d0]
02cc4458: ldr      x11, [x28, #0x5d8]
02cc445c: ldrsw    x11, [x11, #0x78]
02cc4460: add      x10, x10, x11
02cc4464: add      x8, x10, x8, lsl #4
02cc4468: b        #0x2cc4478
02cc446c: mov      x19, #0
02cc4470: b        #0x2cc468c
02cc4474: mov      x8, #0
02cc4478: str      x8, [x19, #0xf0]
02cc447c: ldr      w8, [x26]
02cc4480: str      w8, [x19, #0xf8]
02cc4484: ldr      w8, [x26]
02cc4488: str      w8, [x19, #0x100]
02cc448c: ldr      w8, [x26, #4]
02cc4490: str      w8, [x19, #0x108]
02cc4494: ldr      w8, [x26, #8]
02cc4498: str      w8, [x19, #0x10c]
02cc449c: ldr      w8, [x26, #0xc]
02cc44a0: str      w8, [x19, #0x110]
02cc44a4: mov      w8, #-1
02cc44a8: str      w8, [x19, #0x114]
02cc44ac: mov      w8, #0x58
02cc44b0: madd     x8, x22, x8, x24
02cc44b4: ldr      w10, [x8, #0x1c]
02cc44b8: str      w10, [x19, #0x118]
02cc44bc: ldrb     w10, [x8, #0x50]
02cc44c0: lsr      w10, w10, #1
02cc44c4: add      x20, x19, #0x135
02cc44c8: ldrb     w11, [x20, #2]
02cc44cc: ldrh     w12, [x20]
02cc44d0: bfi      w12, w11, #0x10, #0x10
02cc44d4: bfi      w12, w10, #2, #1
02cc44d8: strh     w12, [x20]
02cc44dc: ldr      w9, [x9]
02cc44e0: cmn      w9, #1
02cc44e4: cset     w9, ne
02cc44e8: bfi      w12, w9, #4, #1
02cc44ec: strh     w12, [x20]
02cc44f0: ldrb     w9, [x8, #0x50]
02cc44f4: ubfx     w9, w9, #2, #1
02cc44f8: bfi      w12, w9, #9, #1
02cc44fc: strh     w12, [x20]
02cc4500: ldrb     w9, [x8, #0x50]
02cc4504: ubfx     w9, w9, #3, #1
02cc4508: bfi      w12, w9, #0xa, #1
02cc450c: strh     w12, [x20]
02cc4510: eor      w9, w9, #1
02cc4514: str      w9, [x19, #0xe0]
02cc4518: ldrb     w9, [x8, #0x50]
02cc451c: ubfx     w9, w9, #4, #1
02cc4520: bfi      w12, w9, #0xb, #1
02cc4524: strh     w12, [x20]
02cc4528: ldrb     w9, [x8, #0x50]
02cc452c: ubfx     w9, w9, #5, #1
02cc4530: bfi      w12, w9, #0xc, #1
02cc4534: strh     w12, [x20]
02cc4538: ldr      w9, [x8, #0x50]
02cc453c: ubfx     w9, w9, #6, #4
02cc4540: sub      w9, w9, #1
02cc4544: lsl      x10, x9, #3
02cc4548: mov      x11, #0x201
02cc454c: movk     x11, #0x804, lsl #16
02cc4550: movk     x11, #0x2010, lsl #32
02cc4554: movk     x11, #0x8040, lsl #48
02cc4558: lsr      x10, x11, x10
02cc455c: cmp      w9, #8
02cc4560: csel     w9, w10, wzr, lo
02cc4564: strb     w9, [x19, #0x134]
02cc4568: ldr      w9, [x8, #0x50]
02cc456c: lsr      w9, w9, #2
02cc4570: and      w9, w9, #0x4000
02cc4574: and      w10, w12, #0xffffbfff
02cc4578: orr      w9, w9, w10
02cc457c: strh     w9, [x20]
02cc4580: ldrh     w9, [x8, #0x40]
02cc4584: strh     w9, [x19, #0x120]
02cc4588: ldrh     w9, [x8, #0x42]
02cc458c: strh     w9, [x19, #0x122]
02cc4590: ldrh     w9, [x8, #0x44]
02cc4594: strh     w9, [x19, #0x124]
02cc4598: ldrh     w9, [x8, #0x46]
02cc459c: strh     w9, [x19, #0x126]
02cc45a0: ldrh     w9, [x8, #0x48]
02cc45a4: strh     w9, [x19, #0x128]
02cc45a8: ldrh     w9, [x23]
02cc45ac: strh     w9, [x19, #0x12a]
02cc45b0: ldrh     w9, [x8, #0x4c]
02cc45b4: strh     w9, [x19, #0x12c]
02cc45b8: ldrh     w9, [x8, #0x4e]
02cc45bc: strh     w9, [x19, #0x12e]
02cc45c0: ldr      w8, [x8, #0x54]
02cc45c4: str      w8, [x19, #0x11c]
02cc45c8: bl       #0x2ce0578
02cc45cc: str      x0, [x19, #0x70]
02cc45d0: mov      w8, #0x58
02cc45d4: madd     x8, x22, x8, x24
02cc45d8: ldrsw    x8, [x8, #0x10]
02cc45dc: cmn      w8, #1
02cc45e0: b.eq     #0x2cc4600
02cc45e4: adrp     x9, #0x10a91000
02cc45e8: ldr      x9, [x9, #0x5c8]
02cc45ec: ldr      x9, [x9, #0x38]
02cc45f0: ldr      x0, [x9, x8, lsl #3]
02cc45f4: mov      w1, #1
02cc45f8: bl       #0x2cdadc8
02cc45fc: str      x0, [x19, #0x58]
02cc4600: mov      w8, #0x58
02cc4604: madd     x8, x22, x8, x24
02cc4608: ldrsw    x8, [x8, #0xc]
02cc460c: cmn      w8, #1
02cc4610: b.eq     #0x2cc4630
02cc4614: adrp     x9, #0x10a91000
02cc4618: ldr      x9, [x9, #0x5c8]
02cc461c: ldr      x9, [x9, #0x38]
02cc4620: ldr      x0, [x9, x8, lsl #3]
02cc4624: mov      w1, #1
02cc4628: bl       #0x2cdadc8
02cc462c: str      x0, [x19, #0x50]
02cc4630: stp      x19, x19, [x19, #0x40]
02cc4634: ldrb     w8, [x20, #2]
02cc4638: ldrh     w9, [x20]
02cc463c: bfi      w9, w8, #0x10, #8
02cc4640: tbz      w9, #2, #0x2cc467c
02cc4644: mov      w8, #0x58
02cc4648: madd     x8, x22, x8, x24
02cc464c: ldrsw    x8, [x8, #0x14]
02cc4650: cmn      w8, #1
02cc4654: b.eq     #0x2cc466c
02cc4658: adrp     x9, #0x10a91000
02cc465c: ldr      x9, [x9, #0x5c8]
02cc4660: ldr      x9, [x9, #0x38]
02cc4664: ldr      x0, [x9, x8, lsl #3]
02cc4668: b        #0x2cc4670
02cc466c: mov      x0, #0
02cc4670: mov      w1, #1
02cc4674: bl       #0x2cdadc8
02cc4678: stp      x0, x0, [x19, #0x40]
02cc467c: dmb      ish
02cc4680: str      x19, [x21, x22, lsl #3]
02cc4684: add      x0, sp, #8
02cc4688: bl       #0x2c6c104
02cc468c: mov      x0, x19
02cc4690: ldp      x29, x30, [sp, #0x60]
02cc4694: ldp      x20, x19, [sp, #0x50]
02cc4698: ldp      x22, x21, [sp, #0x40]
02cc469c: ldp      x24, x23, [sp, #0x30]
02cc46a0: ldp      x26, x25, [sp, #0x20]
02cc46a4: ldp      x28, x27, [sp, #0x10]
02cc46a8: add      sp, sp, #0x70
02cc46ac: ret      
02cc46b0: mov      x19, x0
02cc46b4: add      x0, sp, #8
02cc46b8: bl       #0x2c6c104
02cc46bc: mov      x0, x19
02cc46c0: bl       #0x7c121f8
