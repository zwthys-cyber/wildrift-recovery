# lvlolm1.3 逆向恢复报告

目标：iPhone 15 Pro Max，iOS 17.0，TrollStore 已安装。用户报告游戏版本为 App `7.3.0.2813`、Res `7.3.19.51`。这两个版本号目前是适配目标，尚未通过 iOS 游戏文件核实。

已恢复配置与部分判断逻辑，并制作配置恢复／设备检测 IPA。**用户确认只读全局窗口可见、数字持续更新、横屏与触摸正常，并确认 0.7.1 小地图对齐在测试场景可用，无视野时坐标也持续更新。0.7.4 增加头像外圈血量进度，修复边缘及读取过滤问题，保留桌面图标和离线头像。最新正常对局反馈在无视野时整枚头像消失；无视野实时来源尚未确认，新版自动采集多路坐标用于排查，不沿用最后位置。自动触控、实体投影与视角调整仍未实现，完整 iOS 移植仍未完成。** 重新实现的代码不是原始源码，也没有恢复原程序所有类、驱动、网络及渲染实现。

## 原文件与平台判断

`/root/lvlolm1.3.sh` 是 ARM64 Android ELF 可执行文件，而非 shell 文本脚本。大小 5,841,224 字节，SHA-256：

```text
e385f312ecbb5e575d2709a15a3b0157aa6fb37b52299075d9665f14df6fd111
```

解释器为 `/system/bin/linker64`，依赖 `libandroid.so`、`liblog.so`、EGL、GLESv3 等 Android 库。它不能直接放进 IPA 变成 iOS 程序。TrollStore 安装 iOS 应用；原 Android ABI、窗口、驱动和触控接口仍需要重新实现。

文件无 `.symtab` 和 DWARF 调试信息。已从 `.eh_frame` 读取 4,410 个函数范围，提取 277 项动态导入与 2,999 个只读段字符串。字符串和线性地址传播给出 118 个候选引用，需结合汇编人工核对；函数范围数量不等同于已恢复函数数量。编译注释包含 Android NDK 与 OLLVM 标记，不能据此断言每个函数均经过混淆。

## 已核对的关键位置

下面均为**原 Android ELF 静态虚拟地址**，不是运行时绝对地址，也不是 iOS 游戏地址。

| 地址 | 作用／证据 | 恢复程度 |
| --- | --- | --- |
| `0x426f24` | 配置构造初始化 | 154 条纯初始化指令，停止于首次调用之前 `0x42718c` |
| `0x427698` | INI 加载 | 字段与辅助函数参数已核对；完整解析器异常行为未恢复 |
| `0x429fc8` | INI 保存 | 57 项字段名、加载偏移、顺序与四位小数格式已核对 |
| `0x41a25c` | 水银判断 | 标准化快照的 C 重写；25 组原指令对照通过 |
| `0x419710` | 惩戒判断 | 主要分支与时序重写；54 组原指令对照通过 |
| `0x439998` | 惩戒目标类别 | 全函数指令对照，包含已识别类别与相邻未知类别 |
| `0x4396c0` | 惩戒伤害查询 | Android 指针链已记录；等级公式尾部已做指令对照 |
| `0x436454` | 野怪数据缓存更新 | 已保存汇编；未移植该内部缓存结构 |
| `0x50aaf8` | 单调时钟纳秒值 | 包装 `clock_gettime`；仿真由固定时间输入替代 |
| `0x422e88` | `libil2cpp.so` 模块查找 | Android 模块查询的候选定位，未得到 iOS 模块布局 |
| `0x43ebe0` | 内存后端选择 | 驱动及 `/proc` 路径候选定位；没有在主机执行原后端 |
| `0x448118` | Android Surface 相关代码 | Android 平台依赖，不能直接作为 iOS 悬浮窗口 |

汇编证据见 [assembly](assembly/)。候选调用关系与引用见 [calls.json](calls.json)、[references.json](references.json)。

## 配置恢复

从纯构造指令读取默认值，再将保存函数的字段加载偏移与加载函数的目的地址交叉核对。共 21 个布尔、3 个整数、29 个浮点及 4 个 RGBA 字段。表中数字便于阅读而有所舍入，准确 float32 默认值见 [recovered_config.json](recovered_config.json)。

以下偏移是 **Android 配置对象内部偏移**。颜色的四个偏移依次为 R、G、B、A；缺少范围表示未在加载参数中恢复到范围，不能理解为游戏接口允许任意值。

| 字段 | 类型 | 默认值 | 已恢复范围／规则 | 配置对象偏移 |
| --- | --- | --- | --- | --- |
| `drawBox` | bool | 1 | — | `0x48` |
| `drawRay` | bool | 1 | — | `0x49` |
| `drawMinimap` | bool | 1 | — | `0x4a` |
| `showMinimapBorder` | bool | 1 | — | `0x4b` |
| `drawSkillPanel` | bool | 1 | — | `0x4c` |
| `hideSmallSkills` | bool | 0 | — | `0x4d` |
| `hideEntityAvatar` | bool | 0 | — | `0x4e` |
| `drawWards` | bool | 1 | — | `0x4f` |
| `drawMonsters` | bool | 1 | — | `0x50` |
| `hideMonsterHealth` | bool | 0 | — | `0x51` |
| `showMonsterRespawn` | bool | 1 | — | `0x52` |
| `autoSmite` | bool | 0 | — | `0x53` |
| `smiteRequireEnemy` | bool | 1 | — | `0x54` |
| `autoMercury` | bool | 0 | — | `0x55` |
| `showMercuryMarker` | bool | 0 | — | `0x56` |
| `showSmiteRange` | bool | 1 | — | `0x57` |
| `showSmiteMarker` | bool | 0 | — | `0x58` |
| `smiteRedBuff` | bool | 1 | — | `0x59` |
| `smiteBlueBuff` | bool | 1 | — | `0x5a` |
| `smiteDragon` | bool | 1 | — | `0x5b` |
| `smiteHealthThreshold` | int | 1000 | 600／1000／1400；其他值回退 1000 | `0x5c` |
| `smiteRange` | int | 83000 | 10000 至 100000 | `0x60` |
| `smiteRangeCenterX` | float | 100 | -300 至 300 | `0x64` |
| `smiteRangeCenterY` | float | 20 | -300 至 300 | `0x68` |
| `smiteTouchX` | float | 0 | 0 至 10000 | `0x88` |
| `smiteTouchY` | float | 0 | 0 至 10000 | `0x8c` |
| `mercuryTouchX` | float | 0 | 0 至 10000 | `0x90` |
| `mercuryTouchY` | float | 0 | 0 至 10000 | `0x94` |
| `godViewEnabled` | bool | 0 | — | `0x98` |
| `godViewValue` | float | 6 | 1 至 55 | `0x9c` |
| `forcedDrawCamp` | int | 0 | 0 至 2 | `0xd8` |
| `minimapScale` | float | 1.04 | 0.5 至 1.5 | `0xec` |
| `minimapAvatarSpacing` | float | -149 | -200 至 0 | `0xf0` |
| `minimapOffsetX` | float | -27 | -500 至 500 | `0xf4` |
| `minimapOffsetY` | float | -25 | -500 至 500 | `0xf8` |
| `minimapWindowScale` | float | 1.39 | 0.7 至 5 | `0xfc` |
| `minimapWindowOffsetX` | float | 0 | 0 至 10000 | `0x100` |
| `minimapWindowOffsetY` | float | 0 | 0 至 10000 | `0x104` |
| `minimapAvatarSize` | float | 30 | 3 至 50 | `0x108` |
| `minimapHealthTextSize` | float | 30 | 8 至 60 | `0x10c` |
| `minimapAvatarBorderSize` | float | 2.5 | 0.5 至 8 | `0x110` |
| `entityOffsetX` | float | 0 | -210 至 210 | `0x114` |
| `entityOffsetY` | float | 0 | -210 至 210 | `0x118` |
| `entityBoxWidthScale` | float | 1 | 0.25 至 3 | `0x11c` |
| `entityBoxHeightScale` | float | 1 | 0.25 至 3 | `0x120` |
| `entityAvatarSize` | float | 50 | 3 至 80 | `0x124` |
| `entityHealthTextSize` | float | 40 | 8 至 80 | `0x128` |
| `monsterHealthTextSize` | float | 30 | 8 至 80 | `0x12c` |
| `entitySkillIconSize` | float | 50 | 4 至 100 | `0x130` |
| `skillPanelOffsetX` | float | 0 | 0 至 10000 | `0x134` |
| `skillPanelOffsetY` | float | 0 | 0 至 10000 | `0x138` |
| `skillPanelSize` | float | 0 | -30 至 80 | `0x13c` |
| `friendlyColor` | color | 0.2745098, 0.7450981, 1, 1 | — | `0x144, 0x148, 0x14c, 0x150` |
| `enemyColor` | color | 0.9411765, 0.2745098, 0.2745098, 1 | — | `0x154, 0x158, 0x15c, 0x160` |
| `wardColor` | color | 0.3137255, 0.8627451, 0.4705882, 1 | — | `0x164, 0x168, 0x16c, 0x170` |
| `wardVisionRangeBrightness` | float | 25 | 0 至 100 | `0x174` |
| `neutralColor` | color | 1, 0.8235294, 0.2352941, 1 | — | `0x178, 0x17c, 0x180, 0x184` |

恢复数据还记录每个字段的 `serializer_reference`、`load_instructions` 和 `loader_reference`，可逐项回到机器码检查。

## 水银与惩戒判断

`core/LVActions.c` 使用标准化结构，**没有把这些结构假定为 iOS 游戏内存布局**。布尔字段供调用方标准化为 0／1。实际读取需经独立的 iOS 布局适配，当前 UIKit 应用没有调用这些判断执行游戏操作。

水银：选择列表中首个 ID 非负、标记为本地且血量大于零的记录；检查状态值为 1 或 2、道具可用、道具编号 2297 和冷却值。默认触点为宽度乘 0.78、高度乘 0.86；有效自定义触点覆盖默认值，坐标夹取到屏幕边界。原代码按触点编号 8 按下，等待 5,000 微秒，抬起；发出决策后设置 pending，并将下一次允许时间增加 250 毫秒。pending 的清除分支也已重写。

惩戒：检查首个本地记录及技能编号 81110101。可选要求范围内有对方阵营且血量大于零的记录；技能读取成功后，冷却值不得大于约 0.05。伤害查询每 200 毫秒刷新缓存，查询失败返回零时回退配置阈值。等级 1／2／3 对应 600／1000／1400。遍历首个启用类别、位置距离有效、血量读取成功且血量处于阈值内的野怪，血量原值为有符号 64 位数，除以 16,384 并向零截断。默认触点为宽高均乘 0.86；按下时间为 5 毫秒，下次允许时间增加 100 毫秒。

原 Android 伤害查询首先从内部对象 `+0x740` 的值减去 `0x3871b0`，随后读取并按 40 位掩码处理指针。模块查找函数 `0x422e88` 将 `libil2cpp.so:bss` 的结果写入 `+0x740`，因此它是模块 BSS 基址的保存位置。七级偏移表为 `0xb8, 0x30, 0xa0, 0x18, 0xd0, 0x140, 0x28`，末端候选技能对象校验编号后读取 `+0x38` 等级。这条链只作为 Android 逆向证据保留，不能移到 iOS 上使用。

| 配置类别 | 原程序目标编号 |
| --- | --- |
| 红 Buff | 201401、830001、830002 |
| 蓝 Buff | 201402、830101、830102 |
| 龙类别开关 | 201104、201105、201201、201202、202902、203001、260101、830701、830702、830704、830705、830721 |

以上编号来自该 Android 文件。用户的 0.5.0 iOS 报告中出现 830001、830101、830704、203001，均标为野怪；这不能证明清单中其他编号或实际施法条件。对照还发现，惩戒本地血量的 `B.HI` 与水银的 `B.GT` 在 NaN 下表现不同；核心重写保留了所测试的分支差异。读取适配层应在构建正常快照前验证数据。

重写增加了空指针／边界检查，极端时间戳溢出使用饱和处理。原函数中的读取驱动、时钟、打印、内部缓存与实际触控不属于纯判断实现；因此不能把该测试结果解释为全程序逐指令等价。

## iOS 工具与验证范围

IPA 中的 `LVRecovery`、`LVProbe` 与 `LVHUD` 都是已编译的 ARM64 iOS Mach-O，部署下限为 iOS 15.0。主应用恢复、编辑和导入导出配置；诊断辅助程序提供只读进程列表、任务端口／快照检查、原文件收集及本应用 HUD 控制；HUD 是复用只读快照的独立信息窗口。辅助进程按 TrollStore 公布的 persona 接口启动，UID 和任务端口返回码写入报告；拒绝访问会如实报告。

`task_for_pid` 是否允许访问这台设备上的游戏需要真机结果。读取本进程成功不能证明跨进程访问成功；跨进程端口成功也不能证明游戏数据布局适配。获得 root UID 本身不能保证所有目标访问权限。

已通过配置解析的 AddressSanitizer／UndefinedBehaviorSanitizer 测试；水银 25 组及惩戒 54 组快照与隔离的原 ARM64 指令比较，类别辅助函数及等级公式也做了指令比较。对照没有执行原程序入口、系统调用、真实驱动、触控或网络操作；它不涵盖未知输入空间或未恢复内部副作用。

IPA 的 8 项检查中，5 项包含三个可执行文件的架构、平台、加密状态、CodeDirectory 代码页与 entitlement 哈希，以及 HUD 权限／许可证检查、损坏代码页与无效 Mach-O 的负例。另外 3 项核对桌面图标、全部英雄头像及精确资源 ID 映射。静态哈希检查不等于系统签名信任、安装成功或启动成功。用户输入已支持远程读取、文件导出和对局采样，见 [设备诊断分析](DEVICE.md)。**两份 0.5.0 报告各确认 113 个对象与 8 个技能读取，包含类别、槽／状态、6 个惩戒候选、1/2 到 0/2 的库存及约 8.98 秒非零冷却。仍无画面语义、实际伤害与完整施法条件对照。** 两份所选数字快照回放当前核心，候选、距离和阻止原因一致，2 项 ASan／UBSan 检查通过；它们不重测内存读取或输入接口。

0.2.0 导出框架、主程序、Info.plist 和找到的标准元数据文件，保留原磁盘内容，不解密。ZIP 包含设备 UUID 与实际 Info.plist 版本清单，输出仅限本应用身份已验证的 Documents 容器。流式 ZIP 已由独立读取器验证内容与 CRC，原生测试启用 ASan／UBSan；适配 ZIP 检查器验证 UUID 比对、加密标记及非法路径拒绝。

配置新解析器的原子回滚、拒绝非有限数、颜色参数完整性检查等是重新实现时增加的输入处理，未声称恢复了原解析器所有异常行为。

## iOS 布局与后续验证

框架与自定义元数据已提供，解析和验证见 [iOS 逆向分析](IOS.md)。已恢复类型名称、字段偏移和方法地址，并接入带 UUID 检查的只读角色快照。解码函数与隔离的原 iOS 指令对照，未执行框架入口。

0.5.0 将实际快照及当前配置接入原程序惩戒规则，显示候选目标与阻止条件，不发送触控；两份设备报告支持读取及预览的运行。原始 X/Z 坐标比例和等级伤害公式仍待核对。0.6.0 新增只读文本 HUD，显示本机血量、惩戒冷却／库存和附近目标；插件启动与窗口注册参考 [TrollSpeed 固定版本](https://github.com/Lessica/TrollSpeed/tree/a609be260c8261ead36509c3bc4ded8479da9c40)，完整 MIT 许可证随包保留。用户的新报告确认启动与存活，随后明确反馈窗口可见、持续更新、横屏和触摸正常。

0.6.1 报告记录了 127 次持续采样。0.7.0 增加原小地图敌方数字标记、iOS 对齐设置及协议 2 的敌方／标记数量。用户确认测试场景中无视野坐标持续更新，并在 0.7.1 修正矩形后确认可用。0.7.2 默认隐藏中央／地图下方信息及本机“＋”，提供独立开关；采样间隔缩短为 0.15 秒，CADisplayLink 对当前与上一有效显示位置补间，失败和消失立即清除，大幅跳变直接定位。小地图 71 项及动画 44 项 ASan／UBSan 检查通过；50 组原始指令对照和有限诊断的 80 项检查沿用旧结果。正常五人对局、新动画的设备流畅度和采样负载仍需核对。0.7.3 增加桌面 App 图标及 142 位英雄的离线头像，按官方 heroId 精确匹配 resource_id；未知或缺图时保留数字，不在游戏中下载。新界面尚待设备验证。0.7.4 加入血量圈和无视野坐标的有限连续诊断；新问题见 device-0.7.3-summary.json，字段证据见 ios-minimap-health-layout.json。用户要求的 GitHub 编译流程随源码提供。实际触控和其他游戏功能仍需实现；本次工作没有把磁盘主程序复制当作解密。

使用方法与可复现构建命令见 [README](../README.md)。官方接口依据：[TrollStore](https://github.com/opa334/TrollStore#readme)、[TSUtil.m](https://github.com/opa334/TrollStore/blob/main/Shared/TSUtil.m)、[Clang 交叉编译](https://clang.llvm.org/docs/CrossCompilation.html)、[Mach-O LLD](https://lld.llvm.org/MachO/index.html)。
