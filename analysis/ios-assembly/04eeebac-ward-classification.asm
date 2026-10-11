Named cached ward classification getters. Initialization calls shown for context only; offline emulation executes only the byte load.
BattleActor.IsSummonedWards
04eeeb98: stp x20, x19, [sp, #-0x20]!
04eeeb9c: stp x29, x30, [sp, #0x10]
04eeeba0: add x29, sp, #0x10
04eeeba4: mov x19, x0
04eeeba8: bl #0x4eeb010
04eeebac: ldrb w0, [x19, #0x158]
04eeebb0: ldp x29, x30, [sp, #0x10]
04eeebb4: ldp x20, x19, [sp], #0x20
04eeebb8: ret 
IBattleActor.IsSummonedWards
04eec868: stp x20, x19, [sp, #-0x20]!
04eec86c: stp x29, x30, [sp, #0x10]
04eec870: add x29, sp, #0x10
04eec874: mov x19, x0
04eec878: bl #0x4eeb010
04eec87c: ldrb w0, [x19, #0x158]
04eec880: ldp x29, x30, [sp, #0x10]
04eec884: ldp x20, x19, [sp], #0x20
04eec888: ret 
