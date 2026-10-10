02cd7fe8: sub      sp, sp, #0x80
02cd7fec: stp      x24, x23, [sp, #0x40]
02cd7ff0: stp      x22, x21, [sp, #0x50]
02cd7ff4: stp      x20, x19, [sp, #0x60]
02cd7ff8: stp      x29, x30, [sp, #0x70]
02cd7ffc: add      x29, sp, #0x70
02cd8000: mov      x19, x0
02cd8004: adrp     x8, #0xfb5c000
02cd8008: ldr      x8, [x8, #0x50]
02cd800c: ldr      x8, [x8]
02cd8010: str      x8, [sp, #0x38]
02cd8014: adrp     x1, #0x10a91000
02cd8018: add      x1, x1, #0x7a0
02cd801c: add      x0, sp, #0x18
02cd8020: bl       #0x2c6c080
02cd8024: adrp     x20, #0x10a91000
02cd8028: ldr      w8, [x20, #0x818]
02cd802c: add      w9, w8, #1
02cd8030: str      w9, [x20, #0x818]
02cd8034: cmp      w8, #0
02cd8038: b.le     #0x2cd807c
02cd803c: mov      w19, #1
02cd8040: add      x0, sp, #0x18
02cd8044: bl       #0x2c6c104
02cd8048: ldr      x8, [sp, #0x38]
02cd804c: adrp     x9, #0xfb5c000
02cd8050: ldr      x9, [x9, #0x50]
02cd8054: ldr      x9, [x9]
02cd8058: cmp      x9, x8
02cd805c: b.ne     #0x2cd8d1c
02cd8060: mov      x0, x19
02cd8064: ldp      x29, x30, [sp, #0x70]
02cd8068: ldp      x20, x19, [sp, #0x60]
02cd806c: ldp      x22, x21, [sp, #0x50]
02cd8070: ldp      x24, x23, [sp, #0x40]
02cd8074: add      sp, sp, #0x80
02cd8078: ret      
02cd807c: bl       #0x2c987f4
02cd8080: bl       #0x2c9a2b0
02cd8084: bl       #0x2cbf758
02cd8088: adrp     x8, #0x10a91000
02cd808c: adrp     x9, #0xf901000
02cd8090: add      x9, x9, #0xea3
02cd8094: str      x9, [x8, #0x820]
02cd8098: bl       #0x2c99740
02cd809c: bl       #0x2c9697c
02cd80a0: adrp     x8, #0x102f5000
02cd80a4: add      x8, x8, #0x420
02cd80a8: ldr      x8, [x8]
02cd80ac: blr      x8
02cd80b0: bl       #0x2cdef18
02cd80b4: tbz      w0, #0, #0x2cd8d08
02cd80b8: bl       #0x2ca8d38
02cd80bc: bl       #0x2c6c284
02cd80c0: bl       #0x2cc74d0
02cd80c4: adrp     x0, #0x2ca2000
02cd80c8: add      x0, x0, #0xfc8
02cd80cc: adrp     x1, #0x2ca2000
02cd80d0: add      x1, x1, #0xfe0
02cd80d4: bl       #0x2c97d70
02cd80d8: adrp     x20, #0x10b35000
02cd80dc: add      x20, x20, #0x8e8
02cd80e0: mov      x0, x20
02cd80e4: mov      w1, #0x300
02cd80e8: bl       #0x7c12200
02cd80ec: adrp     x0, #0xf738000
02cd80f0: add      x0, x0, #0xad3
02cd80f4: bl       #0x2ca8a70
02cd80f8: mov      x22, x0
02cd80fc: adrp     x0, #0xf901000
02cd8100: add      x0, x0, #0x965
02cd8104: bl       #0x2ca8a70
02cd8108: mov      x21, x0
02cd810c: mov      x0, x22
02cd8110: bl       #0x2ca8950
02cd8114: adrp     x22, #0x10b35000
02cd8118: str      x0, [x22, #0x8e8]
02cd811c: mov      x0, x21
02cd8120: bl       #0x2ca8950
02cd8124: str      x0, [x20, #8]
02cd8128: ldr      x0, [x20]
02cd812c: adrp     x1, #0xf738000
02cd8130: add      x1, x1, #0x797
02cd8134: adrp     x2, #0xf71d000
02cd8138: add      x2, x2, #0x371
02cd813c: bl       #0x2cdddac
02cd8140: str      x0, [x20, #0x10]
02cd8144: ldr      x0, [x20]
02cd8148: adrp     x1, #0xf738000
02cd814c: add      x1, x1, #0x797
02cd8150: adrp     x2, #0xf901000
02cd8154: add      x2, x2, #0x971
02cd8158: bl       #0x2cdddac
02cd815c: str      x0, [x20, #0x20]
02cd8160: ldr      x0, [x20]
02cd8164: adrp     x1, #0xf738000
02cd8168: add      x1, x1, #0x797
02cd816c: adrp     x2, #0xf738000
02cd8170: add      x2, x2, #0x803
02cd8174: bl       #0x2cdddac
02cd8178: str      x0, [x20, #0x28]
02cd817c: ldr      x0, [x20]
02cd8180: adrp     x1, #0xf738000
02cd8184: add      x1, x1, #0x797
02cd8188: adrp     x2, #0xf738000
02cd818c: add      x2, x2, #0x7d1
02cd8190: bl       #0x2cdddac
02cd8194: str      x0, [x20, #0x18]
02cd8198: ldr      x0, [x20]
02cd819c: adrp     x1, #0xf738000
02cd81a0: add      x1, x1, #0x797
02cd81a4: adrp     x2, #0xf738000
02cd81a8: add      x2, x2, #0x7cb
02cd81ac: bl       #0x2cdddac
02cd81b0: str      x0, [x20, #0x30]
02cd81b4: ldr      x0, [x20]
02cd81b8: adrp     x1, #0xf738000
02cd81bc: add      x1, x1, #0x797
02cd81c0: adrp     x2, #0xf738000
02cd81c4: add      x2, x2, #0x7f7
02cd81c8: bl       #0x2cdddac
02cd81cc: str      x0, [x20, #0x38]
02cd81d0: ldr      x0, [x20]
02cd81d4: adrp     x1, #0xf738000
02cd81d8: add      x1, x1, #0x797
02cd81dc: adrp     x2, #0xf738000
02cd81e0: add      x2, x2, #0x7e2
02cd81e4: bl       #0x2cdddac
02cd81e8: str      x0, [x20, #0x40]
02cd81ec: ldr      x0, [x20]
02cd81f0: adrp     x1, #0xf738000
02cd81f4: add      x1, x1, #0x797
02cd81f8: adrp     x2, #0xf738000
02cd81fc: add      x2, x2, #0x7b7
02cd8200: bl       #0x2cdddac
02cd8204: str      x0, [x20, #0x48]
02cd8208: ldr      x0, [x20]
02cd820c: adrp     x1, #0xf738000
02cd8210: add      x1, x1, #0x797
02cd8214: adrp     x2, #0xf738000
02cd8218: add      x2, x2, #0x7e9
02cd821c: bl       #0x2cdddac
02cd8220: str      x0, [x20, #0x50]
02cd8224: ldr      x0, [x20]
02cd8228: adrp     x1, #0xf738000
02cd822c: add      x1, x1, #0x797
02cd8230: adrp     x2, #0xf901000
02cd8234: add      x2, x2, #0x976
02cd8238: bl       #0x2cdddac
02cd823c: str      x0, [x20, #0x60]
02cd8240: ldr      x0, [x20]
02cd8244: adrp     x1, #0xf738000
02cd8248: add      x1, x1, #0x797
02cd824c: adrp     x2, #0xf738000
02cd8250: add      x2, x2, #0x7db
02cd8254: bl       #0x2cdddac
02cd8258: str      x0, [x20, #0x58]
02cd825c: ldr      x0, [x20]
02cd8260: adrp     x1, #0xf738000
02cd8264: add      x1, x1, #0x797
02cd8268: adrp     x2, #0xf738000
02cd826c: add      x2, x2, #0x7fd
02cd8270: bl       #0x2cdddac
02cd8274: str      x0, [x20, #0x68]
02cd8278: ldr      x0, [x20]
02cd827c: adrp     x1, #0xf738000
02cd8280: add      x1, x1, #0x797
02cd8284: adrp     x2, #0xf738000
02cd8288: add      x2, x2, #0x7f0
02cd828c: bl       #0x2cdddac
02cd8290: str      x0, [x20, #0x70]
02cd8294: ldr      x0, [x20]
02cd8298: adrp     x1, #0xf738000
02cd829c: add      x1, x1, #0x797
02cd82a0: adrp     x2, #0xf738000
02cd82a4: add      x2, x2, #0x7bd
02cd82a8: bl       #0x2cdddac
02cd82ac: str      x0, [x20, #0x78]
02cd82b0: ldr      x0, [x20]
02cd82b4: adrp     x1, #0xf738000
02cd82b8: add      x1, x1, #0x797
02cd82bc: adrp     x2, #0xf738000
02cd82c0: add      x2, x2, #0x7c4
02cd82c4: bl       #0x2cdddac
02cd82c8: str      x0, [x20, #0x80]
02cd82cc: ldr      x0, [x20]
02cd82d0: adrp     x1, #0xf738000
02cd82d4: add      x1, x1, #0x797
02cd82d8: adrp     x2, #0xf738000
02cd82dc: add      x2, x2, #0x7d6
02cd82e0: bl       #0x2cdddac
02cd82e4: str      x0, [x20, #0x88]
02cd82e8: ldr      x0, [x20]
02cd82ec: adrp     x1, #0xf738000
02cd82f0: add      x1, x1, #0x797
02cd82f4: adrp     x2, #0xf72e000
02cd82f8: add      x2, x2, #0xb22
02cd82fc: bl       #0x2cdddac
02cd8300: str      x0, [x20, #0x90]
02cd8304: ldr      x0, [x20]
02cd8308: adrp     x1, #0xf738000
02cd830c: add      x1, x1, #0x797
02cd8310: adrp     x2, #0xf738000
02cd8314: add      x2, x2, #0x8df
02cd8318: bl       #0x2cdddac
02cd831c: str      x0, [x20, #0x98]
02cd8320: ldr      x0, [x20]
02cd8324: adrp     x1, #0xf738000
02cd8328: add      x1, x1, #0x797
02cd832c: adrp     x2, #0xf71a000
02cd8330: add      x2, x2, #0xfcc
02cd8334: bl       #0x2cdddac
02cd8338: str      x0, [x20, #0xa0]
02cd833c: ldr      x0, [x20]
02cd8340: adrp     x1, #0xf738000
02cd8344: add      x1, x1, #0x797
02cd8348: adrp     x2, #0xf738000
02cd834c: add      x2, x2, #0x7a3
02cd8350: bl       #0x2cdddac
02cd8354: str      x0, [x20, #0x250]
02cd8358: ldr      x0, [x20]
02cd835c: adrp     x1, #0xf738000
02cd8360: add      x1, x1, #0x797
02cd8364: adrp     x2, #0xf738000
02cd8368: add      x2, x2, #0x80b
02cd836c: bl       #0x2cdddac
02cd8370: str      x0, [x20, #0xa8]
02cd8374: ldr      x0, [x20]
02cd8378: adrp     x1, #0xf738000
02cd837c: add      x1, x1, #0x797
02cd8380: adrp     x2, #0xf738000
02cd8384: add      x2, x2, #0x814
02cd8388: bl       #0x2cdddac
02cd838c: str      x0, [x20, #0xb0]
02cd8390: ldr      x0, [x20]
02cd8394: adrp     x1, #0xf901000
02cd8398: add      x1, x1, #0x97e
02cd839c: adrp     x2, #0xf901000
02cd83a0: add      x2, x2, #0x9a0
02cd83a4: bl       #0x2cdddac
02cd83a8: str      x0, [x20, #0xb8]
02cd83ac: ldr      x0, [x20]
02cd83b0: adrp     x1, #0xf738000
02cd83b4: add      x1, x1, #0x797
02cd83b8: adrp     x2, #0xf901000
02cd83bc: add      x2, x2, #0x9ac
02cd83c0: bl       #0x2cdddac
02cd83c4: str      x0, [x20, #0x1e8]
02cd83c8: ldr      x0, [x20]
02cd83cc: adrp     x1, #0xf901000
02cd83d0: add      x1, x1, #0x55b
02cd83d4: adrp     x2, #0xf901000
02cd83d8: add      x2, x2, #0x9ba
02cd83dc: bl       #0x2cdddac
02cd83e0: str      x0, [x20, #0xc0]
02cd83e4: ldr      x0, [x20]
02cd83e8: adrp     x1, #0xf738000
02cd83ec: add      x1, x1, #0x797
02cd83f0: adrp     x2, #0xf738000
02cd83f4: add      x2, x2, #0x79e
02cd83f8: bl       #0x2cdddac
02cd83fc: str      x0, [x20, #0xe0]
02cd8400: ldr      x0, [x20]
02cd8404: adrp     x1, #0xf738000
02cd8408: add      x1, x1, #0x797
02cd840c: adrp     x2, #0xf901000
02cd8410: add      x2, x2, #0x9cb
02cd8414: bl       #0x2cdddac
02cd8418: str      x0, [x20, #0xe8]
02cd841c: ldr      x0, [x20]
02cd8420: adrp     x1, #0xf901000
02cd8424: add      x1, x1, #0x55b
02cd8428: adrp     x2, #0xf72e000
02cd842c: add      x2, x2, #0x8f7
02cd8430: bl       #0x2cdddac
02cd8434: str      x0, [x20, #0x100]
02cd8438: ldr      x0, [x20]
02cd843c: adrp     x1, #0xf901000
02cd8440: add      x1, x1, #0x55b
02cd8444: adrp     x2, #0xf901000
02cd8448: add      x2, x2, #0x9d4
02cd844c: bl       #0x2cdddac
02cd8450: str      x0, [x20, #0x108]
02cd8454: ldr      x0, [x20]
02cd8458: adrp     x1, #0xf738000
02cd845c: add      x1, x1, #0x797
02cd8460: adrp     x2, #0xf901000
02cd8464: add      x2, x2, #0x9e3
02cd8468: bl       #0x2cdddac
02cd846c: str      x0, [x20, #0x1a0]
02cd8470: ldr      x0, [x20]
02cd8474: adrp     x1, #0xf738000
02cd8478: add      x1, x1, #0x797
02cd847c: adrp     x2, #0xf901000
02cd8480: add      x2, x2, #0x9ef
02cd8484: bl       #0x2cdddac
02cd8488: str      x0, [x20, #0x110]
02cd848c: ldr      x0, [x20]
02cd8490: adrp     x1, #0xf738000
02cd8494: add      x1, x1, #0x797
02cd8498: adrp     x2, #0xf901000
02cd849c: add      x2, x2, #0x9f9
02cd84a0: bl       #0x2cdddac
02cd84a4: str      x0, [x20, #0x118]
02cd84a8: ldr      x0, [x20]
02cd84ac: adrp     x1, #0xf8fd000
02cd84b0: add      x1, x1, #0xf4a
02cd84b4: adrp     x2, #0xf901000
02cd84b8: add      x2, x2, #0xa08
02cd84bc: bl       #0x2cdddac
02cd84c0: str      x0, [x20, #0x120]
02cd84c4: ldr      x0, [x20]
02cd84c8: adrp     x1, #0xf8fd000
02cd84cc: add      x1, x1, #0xf4a
02cd84d0: adrp     x2, #0xf901000
02cd84d4: add      x2, x2, #0xa13
02cd84d8: bl       #0x2cdddac
02cd84dc: str      x0, [x20, #0x128]
02cd84e0: ldr      x0, [x20]
02cd84e4: adrp     x1, #0xf8fd000
02cd84e8: add      x1, x1, #0xf4a
02cd84ec: adrp     x2, #0xf901000
02cd84f0: add      x2, x2, #0xa1d
02cd84f4: bl       #0x2cdddac
02cd84f8: str      x0, [x20, #0x130]
02cd84fc: ldr      x0, [x20]
02cd8500: adrp     x1, #0xf8fd000
02cd8504: add      x1, x1, #0xf4a
02cd8508: adrp     x2, #0xf901000
02cd850c: add      x2, x2, #0xa28
02cd8510: bl       #0x2cdddac
02cd8514: str      x0, [x20, #0x138]
02cd8518: ldr      x0, [x20]
02cd851c: adrp     x1, #0xf8fd000
02cd8520: add      x1, x1, #0xf4a
02cd8524: adrp     x2, #0xf901000
02cd8528: add      x2, x2, #0xa35
02cd852c: bl       #0x2cdddac
02cd8530: str      x0, [x20, #0x140]
02cd8534: ldr      x0, [x20]
02cd8538: adrp     x1, #0xf901000
02cd853c: add      x1, x1, #0xa3f
02cd8540: adrp     x2, #0xf901000
02cd8544: add      x2, x2, #0xa4b
02cd8548: bl       #0x2cdddac
02cd854c: str      x0, [x20, #0x148]
02cd8550: ldr      x0, [x20]
02cd8554: adrp     x1, #0xf8fd000
02cd8558: add      x1, x1, #0xe61
02cd855c: adrp     x2, #0xf758000
02cd8560: add      x2, x2, #0xff
02cd8564: bl       #0x2cdddac
02cd8568: str      x0, [x20, #0x150]
02cd856c: ldr      x0, [x20]
02cd8570: adrp     x1, #0xf8fd000
02cd8574: add      x1, x1, #0xe61
02cd8578: adrp     x2, #0xf8fd000
02cd857c: add      x2, x2, #0xe74
02cd8580: bl       #0x2cdddac
02cd8584: str      x0, [x20, #0x158]
02cd8588: ldr      x0, [x20]
02cd858c: adrp     x1, #0xf738000
02cd8590: add      x1, x1, #0x797
02cd8594: adrp     x2, #0xf8fd000
02cd8598: add      x2, x2, #0xbb4
02cd859c: bl       #0x2cdddac
02cd85a0: str      x0, [x20, #0x168]
02cd85a4: ldr      x0, [x20]
02cd85a8: adrp     x1, #0xf901000
02cd85ac: add      x1, x1, #0x7e3
02cd85b0: adrp     x2, #0xf901000
02cd85b4: add      x2, x2, #0xa59
02cd85b8: bl       #0x2cdddac
02cd85bc: str      x0, [x20, #0x178]
02cd85c0: ldr      x0, [x20]
02cd85c4: adrp     x1, #0xf901000
02cd85c8: add      x1, x1, #0x7e3
02cd85cc: adrp     x2, #0xf901000
02cd85d0: add      x2, x2, #0xa61
02cd85d4: bl       #0x2cdddac
02cd85d8: str      x0, [x20, #0x180]
02cd85dc: ldr      x0, [x20]
02cd85e0: adrp     x1, #0xf901000
02cd85e4: add      x1, x1, #0x7e3
02cd85e8: adrp     x2, #0xf901000
02cd85ec: add      x2, x2, #0xa6f
02cd85f0: bl       #0x2cdddac
02cd85f4: str      x0, [x20, #0x188]
02cd85f8: ldr      x0, [x20]
02cd85fc: adrp     x1, #0xf901000
02cd8600: add      x1, x1, #0x7e3
02cd8604: adrp     x2, #0xf901000
02cd8608: add      x2, x2, #0xa7d
02cd860c: bl       #0x2cdddac
02cd8610: str      x0, [x20, #0x190]
02cd8614: ldr      x0, [x20]
02cd8618: adrp     x1, #0xf901000
02cd861c: add      x1, x1, #0x7e3
02cd8620: adrp     x2, #0xf901000
02cd8624: add      x2, x2, #0xa8d
02cd8628: bl       #0x2cdddac
02cd862c: str      x0, [x20, #0x198]
02cd8630: ldr      x0, [x20]
02cd8634: adrp     x1, #0xf738000
02cd8638: add      x1, x1, #0x797
02cd863c: adrp     x2, #0xf901000
02cd8640: add      x2, x2, #0xaa3
02cd8644: bl       #0x2cdddac
02cd8648: str      x0, [x20, #0x1a8]
02cd864c: ldr      x0, [x20]
02cd8650: adrp     x1, #0xf738000
02cd8654: add      x1, x1, #0x797
02cd8658: adrp     x2, #0xf784000
02cd865c: add      x2, x2, #0x6a1
02cd8660: bl       #0x2cdddac
02cd8664: str      x0, [x20, #0x1d8]
02cd8668: ldr      x0, [x20]
02cd866c: adrp     x1, #0xf901000
02cd8670: add      x1, x1, #0xaae
02cd8674: adrp     x2, #0xf901000
02cd8678: add      x2, x2, #0xac3
02cd867c: bl       #0x2cdddac
02cd8680: str      x0, [x20, #0x1e0]
02cd8684: ldr      x0, [x20]
02cd8688: adrp     x1, #0xf8fd000
02cd868c: add      x1, x1, #0xf4a
02cd8690: adrp     x2, #0xf901000
02cd8694: add      x2, x2, #0x180
02cd8698: bl       #0x2cdddac
02cd869c: str      x0, [x20, #0x1f0]
02cd86a0: ldr      x0, [x20]
02cd86a4: adrp     x1, #0xf8fd000
02cd86a8: add      x1, x1, #0xf4a
02cd86ac: adrp     x2, #0xf901000
02cd86b0: add      x2, x2, #0xacf
02cd86b4: bl       #0x2cdddac
02cd86b8: str      x0, [x20, #0x1f8]
02cd86bc: ldr      x0, [x20]
02cd86c0: adrp     x1, #0xf8fd000
02cd86c4: add      x1, x1, #0xf4a
02cd86c8: adrp     x2, #0xf901000
02cd86cc: add      x2, x2, #0x1c7
02cd86d0: bl       #0x2cdddac
02cd86d4: str      x0, [x20, #0x200]
02cd86d8: ldr      x0, [x20]
02cd86dc: adrp     x1, #0xf8fd000
02cd86e0: add      x1, x1, #0xf4a
02cd86e4: adrp     x2, #0xf901000
02cd86e8: add      x2, x2, #0x190
02cd86ec: bl       #0x2cdddac
02cd86f0: str      x0, [x20, #0x208]
02cd86f4: ldr      x0, [x20]
02cd86f8: adrp     x1, #0xf738000
02cd86fc: add      x1, x1, #0x797
02cd8700: adrp     x2, #0xf772000
02cd8704: add      x2, x2, #0xf88
02cd8708: bl       #0x2cdddac
02cd870c: str      x0, [x20, #0xf0]
02cd8710: ldr      x0, [x20]
02cd8714: adrp     x1, #0xf738000
02cd8718: add      x1, x1, #0x797
02cd871c: adrp     x2, #0xf901000
02cd8720: add      x2, x2, #0x4cf
02cd8724: bl       #0x2cdddac
02cd8728: str      x0, [x20, #0x210]
02cd872c: ldr      x0, [x20]
02cd8730: adrp     x1, #0xf738000
02cd8734: add      x1, x1, #0x797
02cd8738: adrp     x2, #0xf738000
02cd873c: add      x2, x2, #0xda6
02cd8740: bl       #0x2cdddac
02cd8744: str      x0, [x20, #0x218]
02cd8748: ldr      x0, [x20]
02cd874c: adrp     x1, #0xf738000
02cd8750: add      x1, x1, #0x797
02cd8754: adrp     x2, #0xf901000
02cd8758: add      x2, x2, #0xadc
02cd875c: bl       #0x2cdddac
02cd8760: adrp     x21, #0x10b35000
02cd8764: add      x21, x21, #0x8f0
02cd8768: str      x0, [x21, #0x168]
02cd876c: ldr      x0, [x21]
02cd8770: adrp     x1, #0xf738000
02cd8774: add      x1, x1, #0x797
02cd8778: adrp     x2, #0xf901000
02cd877c: add      x2, x2, #0xaef
02cd8780: bl       #0x2cdddac
02cd8784: str      x0, [x20, #0x1b0]
02cd8788: ldr      x0, [x20]
02cd878c: adrp     x1, #0xf738000
02cd8790: add      x1, x1, #0x88e
02cd8794: adrp     x2, #0xf901000
02cd8798: add      x2, x2, #0xb01
02cd879c: bl       #0x2cdddac
02cd87a0: str      x0, [x20, #0x228]
02cd87a4: ldr      x0, [x20]
02cd87a8: adrp     x1, #0xf901000
02cd87ac: add      x1, x1, #0xaae
02cd87b0: adrp     x2, #0xf901000
02cd87b4: add      x2, x2, #0xb0c
02cd87b8: bl       #0x2cdddac
02cd87bc: str      x0, [x20, #0x230]
02cd87c0: ldr      x0, [x20]
02cd87c4: adrp     x1, #0xf738000
02cd87c8: add      x1, x1, #0x797
02cd87cc: adrp     x2, #0xf901000
02cd87d0: add      x2, x2, #0x92b
02cd87d4: bl       #0x2cdddac
02cd87d8: str      x0, [x20, #0x238]
02cd87dc: ldr      x0, [x20]
02cd87e0: adrp     x1, #0xf738000
02cd87e4: add      x1, x1, #0x88e
02cd87e8: adrp     x2, #0xf901000
02cd87ec: add      x2, x2, #0xb14
02cd87f0: bl       #0x2cdddac
02cd87f4: str      x0, [x20, #0x240]
02cd87f8: ldr      x0, [x20]
02cd87fc: adrp     x1, #0xf8fd000
02cd8800: add      x1, x1, #0xf4a
02cd8804: adrp     x2, #0xf901000
02cd8808: add      x2, x2, #0x228
02cd880c: bl       #0x2cdddac
02cd8810: str      x0, [x20, #0x248]
02cd8814: ldr      x0, [x20]
02cd8818: adrp     x1, #0xf738000
02cd881c: add      x1, x1, #0x797
02cd8820: adrp     x2, #0xf738000
02cd8824: add      x2, x2, #0x7ad
02cd8828: bl       #0x2cdddac
02cd882c: str      x0, [x20, #0x1b8]
02cd8830: ldr      x0, [x20]
02cd8834: adrp     x1, #0xf8fd000
02cd8838: add      x1, x1, #0xf4a
02cd883c: adrp     x2, #0xf901000
02cd8840: add      x2, x2, #0xb21
02cd8844: bl       #0x2cdddac
02cd8848: str      x0, [x20, #0x1c0]
02cd884c: ldr      x0, [x20]
02cd8850: adrp     x1, #0xf8fd000
02cd8854: add      x1, x1, #0xf4a
02cd8858: adrp     x2, #0xf901000
02cd885c: add      x2, x2, #0xb35
02cd8860: bl       #0x2cdddac
02cd8864: str      x0, [x20, #0x1c8]
02cd8868: ldr      x0, [x20]
02cd886c: adrp     x1, #0xf8fd000
02cd8870: add      x1, x1, #0xf4a
02cd8874: adrp     x2, #0xf901000
02cd8878: add      x2, x2, #0xb52
02cd887c: bl       #0x2cdddac
02cd8880: str      x0, [x20, #0x1d0]
02cd8884: ldr      x0, [x20]
02cd8888: adrp     x1, #0xf901000
02cd888c: add      x1, x1, #0x7e3
02cd8890: adrp     x2, #0xf901000
02cd8894: add      x2, x2, #0x7fe
02cd8898: bl       #0x2cdddac
02cd889c: str      x0, [x20, #0x288]
02cd88a0: ldr      x0, [x20]
02cd88a4: adrp     x1, #0xf738000
02cd88a8: add      x1, x1, #0x797
02cd88ac: adrp     x2, #0xf8d0000
02cd88b0: add      x2, x2, #0xa7e
02cd88b4: bl       #0x2cdddac
02cd88b8: str      x0, [x20, #0x2a8]
02cd88bc: ldr      x0, [x20]
02cd88c0: adrp     x1, #0xf901000
02cd88c4: add      x1, x1, #0x55b
02cd88c8: adrp     x2, #0xf901000
02cd88cc: add      x2, x2, #0xb6f
02cd88d0: bl       #0x2cdddac
02cd88d4: str      x0, [x20, #0x258]
02cd88d8: ldr      x0, [x20]
02cd88dc: adrp     x1, #0xf901000
02cd88e0: add      x1, x1, #0x97e
02cd88e4: adrp     x2, #0xf901000
02cd88e8: add      x2, x2, #0xb87
02cd88ec: bl       #0x2cdddac
02cd88f0: adrp     x8, #0x10b35000
02cd88f4: add      x8, x8, #0xb40
02cd88f8: str      x0, [x8, #0x10]
02cd88fc: ldr      x0, [x8]
02cd8900: adrp     x1, #0xf901000
02cd8904: add      x1, x1, #0xb99
02cd8908: mov      w2, #0
02cd890c: bl       #0x2cdb95c
02cd8910: str      x0, [x20, #0x260]
02cd8914: ldr      x0, [x20]
02cd8918: adrp     x1, #0xf738000
02cd891c: add      x1, x1, #0x797
02cd8920: adrp     x2, #0xf901000
02cd8924: add      x2, x2, #0xbad
02cd8928: bl       #0x2cdddac
02cd892c: str      x0, [x20, #0x2b0]
02cd8930: ldr      x0, [x20]
02cd8934: adrp     x1, #0xf738000
02cd8938: add      x1, x1, #0x797
02cd893c: adrp     x2, #0xf901000
02cd8940: add      x2, x2, #0xbb7
02cd8944: bl       #0x2cdddac
02cd8948: str      x0, [x20, #0x2b8]
02cd894c: ldr      x0, [x20]
02cd8950: adrp     x1, #0xf738000
02cd8954: add      x1, x1, #0x797
02cd8958: adrp     x2, #0xf901000
02cd895c: add      x2, x2, #0xbc1
02cd8960: bl       #0x2cdddac
02cd8964: str      x0, [x20, #0x2c0]
02cd8968: ldr      x0, [x20]
02cd896c: adrp     x1, #0xf738000
02cd8970: add      x1, x1, #0x797
02cd8974: adrp     x2, #0xf901000
02cd8978: add      x2, x2, #0xbcb
02cd897c: bl       #0x2cdddac
02cd8980: str      x0, [x20, #0x2c8]
02cd8984: ldr      x0, [x20]
02cd8988: adrp     x1, #0xf738000
02cd898c: add      x1, x1, #0x797
02cd8990: adrp     x2, #0xf901000
02cd8994: add      x2, x2, #0xbd5
02cd8998: bl       #0x2cdddac
02cd899c: str      x0, [x20, #0x2d0]
02cd89a0: ldr      x0, [x20]
02cd89a4: adrp     x1, #0xf738000
02cd89a8: add      x1, x1, #0x797
02cd89ac: adrp     x2, #0xf901000
02cd89b0: add      x2, x2, #0xbde
02cd89b4: bl       #0x2cdddac
02cd89b8: str      x0, [x20, #0x2d8]
02cd89bc: ldr      x0, [x20]
02cd89c0: adrp     x1, #0xf738000
02cd89c4: add      x1, x1, #0x797
02cd89c8: adrp     x2, #0xf901000
02cd89cc: add      x2, x2, #0xbe9
02cd89d0: bl       #0x2cdddac
02cd89d4: str      x0, [x20, #0x2e0]
02cd89d8: ldr      x0, [x20]
02cd89dc: adrp     x1, #0xf738000
02cd89e0: add      x1, x1, #0x797
02cd89e4: adrp     x2, #0xf901000
02cd89e8: add      x2, x2, #0xbf4
02cd89ec: bl       #0x2cdddac
02cd89f0: str      x0, [x21, #0x2e0]
02cd89f4: ldr      x0, [x21]
02cd89f8: adrp     x1, #0xf901000
02cd89fc: add      x1, x1, #0xbff
02cd8a00: adrp     x2, #0xf901000
02cd8a04: add      x2, x2, #0xc15
02cd8a08: bl       #0x2cdddac
02cd8a0c: str      x0, [x21, #0x2e8]
02cd8a10: ldr      x0, [x21]
02cd8a14: adrp     x1, #0xf901000
02cd8a18: add      x1, x1, #0xbff
02cd8a1c: adrp     x2, #0xf901000
02cd8a20: add      x2, x2, #0xc34
02cd8a24: bl       #0x2cdddac
02cd8a28: adrp     x8, #0x10b35000
02cd8a2c: str      x0, [x8, #0xbe0]
02cd8a30: bl       #0x2cc3210
02cd8a34: bl       #0x2cacec4
02cd8a38: ldr      x0, [x22, #0x8e8]
02cd8a3c: bl       #0x2cd0888
02cd8a40: adrp     x0, #0xf738000
02cd8a44: add      x0, x0, #0x797
02cd8a48: bl       #0x2ca8a70
02cd8a4c: cbz      x0, #0x2cd8a70
02cd8a50: bl       #0x2ca8950
02cd8a54: adrp     x1, #0xf738000
02cd8a58: add      x1, x1, #0x797
02cd8a5c: adrp     x2, #0xf901000
02cd8a60: add      x2, x2, #0xc59
02cd8a64: bl       #0x2cdddac
02cd8a68: adrp     x8, #0x10b35000
02cd8a6c: str      x0, [x8, #0xb88]
02cd8a70: adrp     x0, #0xf900000
02cd8a74: add      x0, x0, #0xce7
02cd8a78: bl       #0x2ca8a70
02cd8a7c: cbz      x0, #0x2cd8b40
02cd8a80: bl       #0x2ca8950
02cd8a84: mov      x20, x0
02cd8a88: adrp     x1, #0xf901000
02cd8a8c: add      x1, x1, #0x7b1
02cd8a90: adrp     x2, #0xf901000
02cd8a94: add      x2, x2, #0x7c4
02cd8a98: bl       #0x2cdddac
02cd8a9c: adrp     x8, #0x10b35000
02cd8aa0: str      x0, [x8, #0xb58]
02cd8aa4: adrp     x1, #0xf901000
02cd8aa8: add      x1, x1, #0x7b1
02cd8aac: adrp     x2, #0xf901000
02cd8ab0: add      x2, x2, #0x7d1
02cd8ab4: mov      x0, x20
02cd8ab8: bl       #0x2cdddac
02cd8abc: adrp     x8, #0x10b35000
02cd8ac0: str      x0, [x8, #0xb60]
02cd8ac4: adrp     x1, #0xf901000
02cd8ac8: add      x1, x1, #0xc5d
02cd8acc: adrp     x2, #0xf901000
02cd8ad0: add      x2, x2, #0xc7c
02cd8ad4: mov      x0, x20
02cd8ad8: bl       #0x2cdddac
02cd8adc: adrp     x21, #0x10b35000
02cd8ae0: str      x0, [x21, #0xb68]
02cd8ae4: adrp     x1, #0xf901000
02cd8ae8: add      x1, x1, #0xc5d
02cd8aec: adrp     x2, #0xf901000
02cd8af0: add      x2, x2, #0xc7c
02cd8af4: mov      x0, x20
02cd8af8: bl       #0x2cdddac
02cd8afc: str      x0, [x21, #0xb68]
02cd8b00: adrp     x1, #0xf901000
02cd8b04: add      x1, x1, #0x7b1
02cd8b08: adrp     x2, #0xf901000
02cd8b0c: add      x2, x2, #0xc59
02cd8b10: mov      x0, x20
02cd8b14: bl       #0x2cdddac
02cd8b18: adrp     x8, #0x10b35000
02cd8b1c: str      x0, [x8, #0xb78]
02cd8b20: adrp     x1, #0xf901000
02cd8b24: add      x1, x1, #0x7b1
02cd8b28: adrp     x2, #0xf901000
02cd8b2c: add      x2, x2, #0xc8c
02cd8b30: mov      x0, x20
02cd8b34: bl       #0x2cdddac
02cd8b38: adrp     x8, #0x10b35000
02cd8b3c: str      x0, [x8, #0xb80]
02cd8b40: adrp     x23, #0x10b35000
02cd8b44: ldr      x0, [x23, #0x978]
02cd8b48: bl       #0x2cdb2a0
02cd8b4c: bl       #0x2c97768
02cd8b50: bl       #0x2cc3214
02cd8b54: mov      x20, x0
02cd8b58: bl       #0x2cc73c8
02cd8b5c: bl       #0x2cc81b0
02cd8b60: adrp     x8, #0x10b35000
02cd8b64: ldr      x0, [x8, #0xa00]
02cd8b68: bl       #0x2ca92f8
02cd8b6c: mov      x21, x0
02cd8b70: adrp     x8, #0x10b35000
02cd8b74: ldr      x0, [x8, #0x9f8]
02cd8b78: bl       #0x2ca92f8
02cd8b7c: mov      x22, x0
02cd8b80: add      x0, x0, #0x18
02cd8b84: mov      x1, x20
02cd8b88: bl       #0x2c6df70
02cd8b8c: mov      x0, x20
02cd8b90: mov      x1, x22
02cd8b94: bl       #0x2c6df70
02cd8b98: add      x0, x20, #8
02cd8b9c: mov      x1, x21
02cd8ba0: bl       #0x2c6df70
02cd8ba4: mov      w8, #1
02cd8ba8: str      w8, [x20, #0x28]
02cd8bac: mov      x0, x19
02cd8bb0: bl       #0x2cd7f20
02cd8bb4: str      x0, [x20, #0x20]
02cd8bb8: bl       #0x2cc59bc
02cd8bbc: bl       #0x2c6d7e4
02cd8bc0: bl       #0x2cdf80c
02cd8bc4: ldr      x0, [x23, #0x978]
02cd8bc8: bl       #0x2ca5f5c
02cd8bcc: ldr      x0, [x23, #0x978]
02cd8bd0: bl       #0x2cdb2a0
02cd8bd4: ldr      x0, [x23, #0x978]
02cd8bd8: adrp     x1, #0xf901000
02cd8bdc: add      x1, x1, #0xea7
02cd8be0: bl       #0x2cdb518
02cd8be4: mov      x19, x0
02cd8be8: bl       #0x2ca5fc0
02cd8bec: mov      x1, x0
02cd8bf0: mov      x0, x19
02cd8bf4: bl       #0x2cd7c24
02cd8bf8: adrp     x8, #0x10b35000
02cd8bfc: mov      w9, #1
02cd8c00: strb     w9, [x8, #0xbe8]
02cd8c04: adrp     x1, #0xf901000
02cd8c08: add      x1, x1, #0xc9d
02cd8c0c: mov      x0, sp
02cd8c10: bl       #0x2b2184
02cd8c14: adrp     x1, #0xf6ed000
02cd8c18: add      x1, x1, #0x449
02cd8c1c: add      x0, sp, #0x20
02cd8c20: bl       #0x2b2184
02cd8c24: mov      x0, sp
02cd8c28: add      x1, sp, #0x20
02cd8c2c: bl       #0x2c9ff3c
02cd8c30: ldrsb    w8, [sp, #0x37]
02cd8c34: tbz      w8, #0x1f, #0x2cd8c40
02cd8c38: ldr      x0, [sp, #0x20]
02cd8c3c: bl       #0xe5038
02cd8c40: ldrsb    w8, [sp, #0x17]
02cd8c44: tbz      w8, #0x1f, #0x2cd8c50
02cd8c48: ldr      x0, [sp]
02cd8c4c: bl       #0xe5038
02cd8c50: adrp     x1, #0xf901000
02cd8c54: add      x1, x1, #0xcb8
02cd8c58: mov      x0, sp
02cd8c5c: bl       #0x2b2184
02cd8c60: adrp     x1, #0xf6ed000
02cd8c64: add      x1, x1, #0x44d
02cd8c68: add      x0, sp, #0x20
02cd8c6c: bl       #0x2b2184
02cd8c70: mov      x0, sp
02cd8c74: add      x1, sp, #0x20
02cd8c78: bl       #0x2c9ff3c
02cd8c7c: ldrsb    w8, [sp, #0x37]
02cd8c80: tbz      w8, #0x1f, #0x2cd8c8c
02cd8c84: ldr      x0, [sp, #0x20]
02cd8c88: bl       #0xe5038
02cd8c8c: ldrsb    w8, [sp, #0x17]
02cd8c90: tbz      w8, #0x1f, #0x2cd8c9c
02cd8c94: ldr      x0, [sp]
02cd8c98: bl       #0xe5038
02cd8c9c: mov      x0, x20
02cd8ca0: bl       #0x2cc3270
02cd8ca4: ldr      x0, [x20, #0x10]
02cd8ca8: bl       #0x2cc32c0
02cd8cac: mov      x8, sp
02cd8cb0: bl       #0x2ca04b0
02cd8cb4: mov      x0, sp
02cd8cb8: bl       #0x2cd8da4
02cd8cbc: bl       #0x2ca3de0
02cd8cc0: cbnz     w0, #0x2cd8ce8
02cd8cc4: ldrsb    w8, [sp, #0x17]
02cd8cc8: ldr      x9, [sp]
02cd8ccc: cmp      w8, #0
02cd8cd0: mov      x8, sp
02cd8cd4: csel     x8, x9, x8, lt
02cd8cd8: str      x8, [sp, #0x20]
02cd8cdc: add      x0, sp, #0x20
02cd8ce0: mov      w1, #1
02cd8ce4: bl       #0x2ca3bb0
02cd8ce8: bl       #0x2cdf43c
02cd8cec: bl       #0x2cdf4c8
02cd8cf0: bl       #0x2cec844
02cd8cf4: ldrsb    w8, [sp, #0x17]
02cd8cf8: tbz      w8, #0x1f, #0x2cd803c
02cd8cfc: ldr      x0, [sp]
02cd8d00: bl       #0xe5038
02cd8d04: b        #0x2cd803c
02cd8d08: mov      w19, #0
02cd8d0c: ldr      w8, [x20, #0x818]
02cd8d10: sub      w8, w8, #1
02cd8d14: str      w8, [x20, #0x818]
02cd8d18: b        #0x2cd8040
02cd8d1c: bl       #0x7c1226c
02cd8d20: b        #0x2cd8d70
02cd8d24: b        #0x2cd8d90
02cd8d28: b        #0x2cd8d34
02cd8d2c: b        #0x2cd8d70
02cd8d30: b        #0x2cd8d90
02cd8d34: mov      x19, x0
02cd8d38: ldrsb    w8, [sp, #0x37]
02cd8d3c: tbz      w8, #0x1f, #0x2cd8d74
02cd8d40: ldr      x0, [sp, #0x20]
02cd8d44: bl       #0xe5038
02cd8d48: b        #0x2cd8d74
02cd8d4c: b        #0x2cd8d70
02cd8d50: b        #0x2cd8d90
02cd8d54: b        #0x2cd8d90
02cd8d58: b        #0x2cd8d90
02cd8d5c: b        #0x2cd8d90
02cd8d60: b        #0x2cd8d90
02cd8d64: b        #0x2cd8d90
02cd8d68: b        #0x2cd8d90
02cd8d6c: b        #0x2cd8d90
02cd8d70: mov      x19, x0
02cd8d74: ldrsb    w8, [sp, #0x17]
02cd8d78: tbz      w8, #0x1f, #0x2cd8d94
02cd8d7c: ldr      x0, [sp]
02cd8d80: bl       #0xe5038
02cd8d84: b        #0x2cd8d94
02cd8d88: b        #0x2cd8d90
02cd8d8c: b        #0x2cd8d90
02cd8d90: mov      x19, x0
02cd8d94: add      x0, sp, #0x18
02cd8d98: bl       #0x2c6c104
02cd8d9c: mov      x0, x19
02cd8da0: bl       #0x7c121f8
