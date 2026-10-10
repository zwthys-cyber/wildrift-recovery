# iOS 框架逆向、判断预览与只读悬浮窗

输入来自用户设备导出的 `lvlolm-ios-inputs.zip`，6 个条目 CRC 正确，元数据搜索完整。框架和主程序的文件 UUID 与设备报告一致。收集成功由这份真机文件支持；本环境没有连接手机执行游戏。

| 输入 | 大小 | SHA-256 |
| --- | ---: | --- |
| UnityFramework | 289,362,384 | `effa95dbbc2bf16f9474c7c99700b80b3e0b7c793537e2da7089bd01b6a5e394` |
| global-metadata.dat | 58,395,680 | `0ea4de1fdba5924e75f09a10911692c833ae996ec3df773aba4d9b32c39f90e3` |

框架 UUID 为 `085E1DDF-4A8D-34E2-9D73-A0A28BCC0B83`，cryptid 0。主程序 UUID 为 `34D7B1EF-409C-3BF1-BEC4-122FFAB05100`，cryptid 1。主程序未解密，也未用于执行或注入。Info.plist 为 `7.3.3`、构建 `2818`；游戏内 App／Res 字符串仍以用户报告为准，两种版本表达不直接等同。

## 自定义元数据

文件头是 `FMN!`，版本 31。普通 IL2CPP 解析器要求的标准魔数不适用，不能只替换魔数就声称解析成功。

从 `il2cpp_init` 跟踪到 `0x2cdef18`、`0x2cc3438`，定位了两个转换阶段：

- `0x2ca2b04` 调用纯 RAM 块函数 `0x2ca2c34`，处理头部 `[8, 40)`。采用恢复出的状态常量、32 字节 key、64 位计数器和 8 字节 nonce；块混合为 20 轮，常量不是标准 ChaCha 常量。
- `0x2cc4004` 读取头部 `+0x1c` / `+0x20` 的名称堆位置和大小，根据字符串索引计算 key 起点，再逐字节异或至 NUL。运行时以位图避免同一索引重复转换。离线解析器按索引缓存，不修改输入。

恢复出的名称堆为偏移 `0x1f973c`、大小 `0xd7092c`。v31 的类型、字段、方法、镜像和程序集记录尺寸分别为 88、12、36、40、64 字节。记录数为 47,894、495,160、390,601、86、86。名称和托管记录已经解析；方法体没有全部反编译。

记录结构参考 [Il2CppDumper MetadataClass.cs](https://github.com/Perfare/Il2CppDumper/blob/master/Il2CppDumper/Il2Cpp/MetadataClass.cs)。自定义头部与名称转换依据本次二进制的加载指令单独恢复。

隔离对照执行仅限块函数及字符串函数；外部调用和系统调用被守卫拒绝。64 组状态、210 个索引以及每个索引重复读取均与原指令一致。没有执行框架入口、文件加载、网络或游戏动作。

## 注册表与字段位置

注册函数 `0xd8f6724` 将代码注册表 `0xfc1e1f8`、元数据注册表 `0xfe40a58` 传给 `il2cpp_codegen_register`。元数据注册表 `+0x58` 是每类字段偏移数组的指针表，`+0x68` 是类型大小表；字段偏移读取函数 `0x2cc4bf0` 证实了索引和数组访问。

代码注册表 `+0x80` 指向 86 个代码模块。方法必须按所属镜像和 token RID 查表；Assembly-CSharp 模块有 332,238 个方法指针。不能按模块数组第一个元素猜测所属模块，也不能把托管字段偏移当作 C++ 对象成员偏移。

恢复的关键入口：

| 类 / 字段 | 类型索引 | 偏移 | 所属区域 |
| --- | ---: | --- | --- |
| DriveEntryUnity._cur | 37468 | `0x0` | 托管静态字段 |
| DriveEntryUnity.visiActorMgr | 37468 | `0x10` | 托管对象 |
| VisiActorMgr.visiActorList | 37505 | `0x10` | 托管对象 |
| BattleActorVisi._actor | 37453 | `0xa0` | 托管对象 |
| FEVisi._myHero | 37473 | `0x30` | 托管静态字段 |
| BattleActor.__InstanceLongValue | 34683 / 继承 | `0x18` | 托管对象内保存的 native 地址 |

`0x2cc42e8` 从相对框架基址 `0x10a915f8` 取运行时类缓存，再按类型索引访问。类名和命名空间分别位于类对象 `+0x10`、`+0x18`，静态字段区域位于 `+0xb8`，由导出的 IL2CPP getter 指令验证。

已通过具体 getter 确认的 native 成员：

| 读取内容 | 指令入口 | native 偏移 |
| --- | --- | --- |
| BattleActor.ResID | `0x4ee53fc` | `0x2c`，32 位 |
| BattleActor.tid | `0x4ee5408` | `0x30`，32 位 |
| BattleActor.camp | `0x4ee5780` | `0x80`，32 位 |
| BattleActor.attribute | `0x4ee5be0` | `0xc0`，指针 |
| ActorComponentAttribute.curHP | `0x4ea20cc` | `0x150`，64 位 |
| ActorSkill.level | `0x4ecc1a4` | `0x38`，32 位 |
| ActorSkill.resId | `0x4ecc1c8` | `0x44`，32 位 |
| SkillCDNode.remainTime | `0x512cb80` | `0x20`，64 位 |

Fix64 的整数转换 `0x543fd90` 左移 14 位，与原安卓的 16384 血量除数一致。报告同时保留原始 signed 64 位值和除以 16384 后的展示值。

## 0.4.0 新增读取链

- `FixGameObject.get_objId`（`0x4f81308`）读 native actor `+0x18` 的 uint32。报告中 50 个 `tid` 全为 0，不能用 tid 代替该编号。
- `get_transform`（`0x4f81314`）读 native actor `+0x20` 的指针；`FixTransform.get_position`（`0x4f82550`）从 transform `+0x18` 复制三个 signed Fix64。保留三轴顺序，不先假定屏幕投影或地图比例。
- `BattleActor.get_skillMgr`（`0x4ee5d38`）读 native actor `+0xd0`。`ActorComponentSkillMgr.get_skills`（`0x4ebb3d0`）把 native manager `+0x208` 的内嵌 DataShellList 包装为托管对象；vector 在 DataShellList `+0x10`，即 manager `+0x218`。
- `get_summonerSkillMgr`（`0x4eba794`）读 native manager `+0x140` 的指针。`SummonerSkillMgr.get_skills`（`0x515d554`）对应 summoner manager `+0x18` 的内嵌 DataShellList，所以 vector 在 `+0x28`。不能按托管 List 的布局读取这个 C++ 容器。
- `GetSkillAt`（`0x4ebd8a0`）及 `GetSkill`（`0x515df2c`）验证 vector `begin +0`、`end +8`、int32 stride `+0x18` 的读取及索引运算。此处元素是 native skill 指针，要求 stride 8，最多 128 项；空且全零的头单独接受。头及元素数组均复读，变化时清空结果。
- `ActorSkill.get_objId`（`0x4ecc0ec`）、`get_level`、`get_resId` 分别读 native skill `+0x20`、`+0x38`、`+0x44`。采样后复核编号／资源 ID，检测对象复用。
- `ActorSkill.get_cdLeftTime`（`0x4ed1f94`）使用 skill `+0x420` 内嵌 CDTrigger；trigger `+0x20`，即 skill `+0x440`，指向 CDNode。节点 `+0x18` 的锁定标记非零时返回 Fix64.Zero；节点为空也返回 Zero，否则返回 `max(node.remainTime(+0x20), Zero)`。**零冷却不证明技能可以使用。**

独立 ARM64 指令对照覆盖 12 组对象／技能属性、3 组三维位置、15 组冷却锁定及有符号夹取、15 组 native vector 索引，使用超过 4 GiB 的合成指针。运行严格限制在选定 getter 内，拒绝外部调用／系统调用；vector 正常访问在类初始化和托管包装前停止，仅核对已选中的 native 地址。没有执行游戏入口、真实目标读取或动作。

## 对局采样的实现范围

0.3.0 的 root 辅助程序在用户选择进程后采样：加载框架 UUID → 类缓存 → DriveEntryUnity._cur → visiActorMgr → visiActorList → visual actor → 托管 actor → native actor → native attribute。通过 FEVisi._myHero 的 native 地址进行本机角色比对。

角色列表使用托管 List / array 布局，最多采样 512 个对象，数组容量有上限。快照读取结束重新检查列表长度、数组和 DriveEntryUnity 实例；发生变化时清空角色和技能结果并返回失败。每个读取失败都清空临时缓冲区。40 个受限内存场景通过 ASan／UBSan，覆盖基础角色、位置和新增技能容器的边界及变化检查。

用户粘贴的 0.3.0 报告确认 50 个对象基础读取成功；0.4.0 报告进一步确认 84 个对象的编号／位置和 8 个本机技能读取成功，包含资源编号 81110101。该份 0.4.0 报告的冷却样本均为零，没有画面对照或目标怪物；后续 0.5.0 数据见下文与 [设备分析](DEVICE.md)。列表检查不保证数值来自同一个游戏帧。角色 `ready` 只描述原有基础字段，位置／编号使用独立标记，本机技能使用单独的列表状态；不能把基础成功扩展解释为新增字段已验证。

## 0.5.0 新增读取与判断

[状态字段及 getter 证据](ios-state-layout.json) 保存托管元数据和选定方法地址。BattleActor 的托管 bool 缓存字段为 isBuilding `+0x138`、isHero `+0x13f`、isSoldier `+0x141`、isMonster `+0x143`、isRedBlueBuff `+0x15b`。这组 bool 要求值为 0／1；读取失败或对象指针／编号变化时不会用于分类。它们不是原生 IsValid／IsSkillable 函数。

| 读取链 | getter 指令入口 | native 偏移 |
| --- | --- | --- |
| ActorSkill.stockMgr 指针 | `0x4ecc580` | `+0x1d0` |
| SkillStockMgr.curStock / maxStock | `0x514b264` / `0x514b270` | `+0x1c` / `+0x20` |
| ActorSkill._slot 指针 | `0x4ecc39c` | `+0x108` |
| SkillSlot.slotState | `0x5146a6c` | `+0x18`，uint32 |
| ActorSkill.skillStateMgr 内嵌对象 | `0x4ecc894` | `+0x498` |
| SkillStateMgr.currentState | `0x514a0c4` | `+0x18`，即 skill `+0x4b0` |

IsUsed / IsCast / IsCasting / IsCastSuccess / IsFinished / IsManualFinish 的纯 getter 分别位于 `0x514a328`、`0x514a338`、`0x514a348`、`0x514a364`、`0x514a374`、`0x514a384`。其中 IsCasting 为 `(state & 0x50) == 0x40`。报告保留原始状态及这些谓词，技能槽状态没有猜测可释放语义。新增 12 组标量和 72 组状态谓词的原指令对照通过，累计 129 组；运行仍拒绝外部调用和系统调用。

`core/LVSmitePreview.c` 把这次快照接到原程序惩戒核心，传入检测开始时的配置。标准化只使用读取成功的对象 ID、血量及位置，拒绝 uint32 编号溢出到 signed ID；敌方列表只接入类别已确认的英雄。候选目标需命中原目标清单、已标为野怪，并满足位置／血量条件。锁定、已知施法中、已知库存耗尽会额外阻止模拟。34 个 ASan／UBSan 场景通过，包括边界冷却、血量截断、错误类别和失败读取。

模拟使用原始 X/Z Fix64 转 float，配置范围保持原始整数；默认 83000 换算约 5.066。跨平台比例尚未得到设备对照，JSON 明确标为假设。等级公式给出的原程序阈值也未核实为当前 iOS 实际伤害。纯核心使用合成单位画布进行一次判断，丢弃触点输出，不发送输入事件，不保持动作循环状态。`castability_verified` 和 `touch_backend_available` 均为 false。

用户随后提供两份 0.5.0 文件，各有 113 个对象、8 个本机技能和 6 个原清单目标。类别、库存、槽／状态读取成功，惩戒库存为 1/2 后变为 0/2，非零冷却原值 147130，换算约 8.98 秒。配置关闭和附近无敌方英雄阻止两次模拟，第二次还被冷却与库存阻止。两份所选数字快照回放当前原生核心，候选、距离和阻止原因一致，见 [设备反馈](DEVICE.md)。没有将这些结果扩展解释为实际可释放、实际伤害或施法范围已核对。

## 0.6.0 全局信息窗口

新增单独签名的 `LVHUD` ARM64 可执行文件，由已验证 root helper 启动，先核对目标 `lolm.app/lolm` 和 UnityFramework UUID，再启动 UIKit 插件并注册系统窗口。启动流程参考 [TrollSpeed 固定版本](https://github.com/Lessica/TrollSpeed/tree/a609be260c8261ead36509c3bc4ded8479da9c40)，保留完整 MIT 许可证并随 IPA 打包。未引入该项目的输入事件处理或安全窗口行为。

只读 HUD 复用快照与预览，每 0.5 秒发起一次后台采样，前一采样未结束时跳过，避免积压。失败帧清除旧数字。目标进程身份失效或本应用可执行文件消失时退出；配置采用启动时副本。横屏方向通过可用的 FBSOrientationObserver 调整，窗口请求触摸穿透。这里的文本信息窗不依赖世界坐标投影，也不实现自动触控。

启动握手限制为 8192 字节／6 秒，使用专用管道并关闭 HUD 的标准输出／错误输出，避免诊断辅助程序等待长期窗口进程。状态与停止走持久化随机会话的通知；状态中的 PID 还要匹配本应用的 HUD 可执行路径。停止不从文件读取 PID 或终止其他进程；只有启动失败的直接子进程可被启动器终止。通知错误会返回失败。

三个程序的架构、代码页及权限签名通过静态检查。HUD 权限包含显示上下文、系统窗口宿主及任务端口，不包含触控事件派发权限。用户提供的 0.6.0 JSON 确认启动／状态检查成功，并明确反馈窗口可见、数字持续更新、横屏与触摸正常。这是用户设备观察，没有直接设备连接或数值逐项画面对照，见 [设备记录](device-0.6.0-summary.json)。`hud_launch` 和 0.6.0 的 `hud` 字段本身只记录请求／存活，不能证明可见画面。自动触控、实体投影和完整移植仍未完成。

## 0.6.1 有限采样记录

新增 `core/LVHUDTelemetry.c`，以 8 个 64 位通知状态保存采样的进程／协议、提交序号、完成次数、单调时间、结果／对象数量／方向，以及惩戒冷却和库存。记录不包含角色指针或完整游戏快照。每次启动采用新会话，保证每组状态只有一个 HUD 写入者；停止仍使用持久化的会话通知。

写入先发布奇数序号，更新字段后发布偶数序号；读取前后复核 owner 与序号，最多尝试三次。PID 必须与路径验证通过的正在运行 HUD 相同，序号与次数必须一致，未知协议、字段越界及未来时间不接受。超过 3 秒的记录仍可报告，但 `fresh` 为 false；失败采样可有新鲜心跳，但 `latest_snapshot_usable` 为 false，不输出旧惩戒数据。

指标在采样结果交给 UILabel 后记录，不能证明窗口已经完成屏幕绘制。`hud.sampling` 与检测时的 `target_probe.game_snapshot` 分别记录。本环境原生测试通过 60 项 ASan／UBSan 检查；随后收到的 0.6.1 设备报告支持持续采样指标读取，见 device-0.6.1-summary.json；应用重启控制仍未验证。

原游戏文件存放在忽略的 `inputs/`。恢复源码包包含自己的实现、复现工具和选定分析证据，不包含这些游戏二进制或元数据文件。

## 0.7.0 原小地图叠加

`UIMiniMappingMgr` 类型编号 6839，静态 `Instance` 位于类 statics +0。普通分支按 `scaleX +0x44`、`scaleZ +0x48` 把旋转后的世界 X/Z 转换到地图，半尺寸位于 +0x64/+0x68。`UIMainBattleMiniMapCtrl` 类型编号 6835，其普通实例在 statics +0x18；全屏标记 +0x2d9，zoomState +0x330。UUID 与类名／命名空间、实例类指针核对后读取，复核实例及数据没有切换。当前忽略原生方法调用、iFix 分支和 Unity UI Transform；仅普通地图比例可用，屏幕矩形仍由 iOS 校准设置提供。

输出 `u=.5+rotatedX*scaleX/(2*halfWidth)`，`v=.5-rotatedZ*scaleZ/(2*halfHeight)`。世界原值先除 16384。默认按本机阵营 1/2 选择 0/180 度，是可覆盖的假设，并未复现复杂的原生相机旋转规则。50 组隔离原始指令对照验证比例计算；57 项 C 检查覆盖筛选、方向、缺失、重复编号、失败清空和配置回滚。字段记录与指令摘要见 [ios-minimap-layout.json](ios-minimap-layout.json)。

仅当前确认类别为英雄、对立阵营、对象编号唯一、位置读取成功且没有被确认死亡的对象绘制红色数字，不按资源编号猜英雄、不补足五个、不沿用上一帧。死亡英雄仍计入已确认人数；标记数量独立记录。青色本机参考点与边框可以关闭。0.5 秒采样，超过 2 秒没有新帧清除标记；竖屏不显示地图叠加层。

有限诊断升级协议 2，仍使用 8 个 uint64；原保留 word 7 保存敌方数、可准备标记数、未定位数及映射标记，含独立金标准的 80 项 ASan／UBSan 检查通过。不同协议不混读。矩形参数单独保存于本应用偏好，并在启动时以有限配置字符串传给打包 HUD。没有读取任意配置路径或派发输入事件。

随后收到的截图显示“游戏映射”及 1 个敌方标记，用户反馈“位置有些偏移 无视野时坐标也会持续更新”。这支持普通映射链已在该场景使用，但屏幕矩形尚未对齐；无视野更新是用户对测试场景的观察，尚无正常五人对局或红方方向验证，见 [设备摘要](device-0.7.0-summary.json)。

## 0.7.1 矩形校准修正

截图尺寸为 2009×612，画面并非可直接使用的完整手机屏幕矩形。按旧默认矩形 5／2／15／32% 及参考框内缩 1 点估算，青色框比游戏小地图偏左且稍小，本机点与敌方点均偏左约 60 个截图像素。因此只调整屏幕矩形为左 6.8%、上 1.2%、宽 15.5%、高 33.5%，保留世界坐标归一化公式。旧默认值是否仍在使用尚无单独配置报告确认，这些数值需移动角色到多个位置核对。

首次加载时以独立偏好版本标记控制迁移：四项全部等于旧默认值才替换，任一自定义值均保留。界面“应用推荐对齐”可主动替换四项，保留方向、手动范围、开关和标记大小；设置仍在重新启动 HUD 后生效。升级不会把原始 57 项配置重置。配置迁移的纯 C 检查和带 `-Werror` 的 UIKit 编译用于验证本次改动，画面修正尚未在设备验证。

新增 `hud_launch.display_geometry`，读取实际 `UIScreen.bounds` 点尺寸、`nativeBounds` 像素尺寸和两种缩放。它记录启动时屏幕信息，不从截图尺寸推断手机画布；后续报告可与 `minimap_calibration` 合并核对区域。

## 0.7.2 显示开关与平滑移动

用户确认 0.7.1 对齐可用，随后指出中央面板遮挡、要求去掉本机“＋”，并报告敌方标记移动卡顿。新增独立 iOS 键 `iosHUDInfoPanel` 和 `iosMapLocalPoint`，默认均为 0；旧九项设置导入时使用这两个默认值，不改变矩形。`iosMapReferences` 仅控制边框。隐藏 UILabel 在加入画布之前完成，采样和诊断继续运行；信息面板开关也控制地图下方文字。

采样计时器改为 150 毫秒、20 毫秒调度余量，仍只有一个在途读取。动画使用 CADisplayLink，目标 60 帧；只有坐标发生连续小幅变化时启动，完成、隐藏或移出窗口时停止。`core/LVMinimapMotion.c` 保存绘制起点和当前快照终点，以单调时间线性补间 150 毫秒。同一对象／资源／本机身份匹配才补间，归一化位移超过 0.12 直接定位。不存在的标记不进入新绘制状态，失败帧立即清空；地图比例、方向、手动模式或 drive 实例变动重置动画。它不外推坐标，不把旧绘制状态用于新快照判断。

本地小地图检查 71 项、动画检查 44 项及 IPA 静态检查 5 项通过；设备帧率与额外采样负载尚未验证。`hud_launch` 报告实际采样间隔、动画时长及请求帧率，不把请求帧率称为设备实测值。


## 0.7.3 图标和英雄头像

新增不透明 RGB 桌面图标，Info.plist 分别声明 iPhone 与 iPad 主图标；安装包带 120／180 点像素等所需 PNG 尺寸。图标由内置 image_gen 生成，原图、完整提示词和尺寸转换记录随源码保存。

小地图头像使用官方英雄目录的精确 heroId 对应原生 resource_id。下载并固定 142 张 128×128 的公开头像及其哈希，不把端游 ID、角色顺序或算术推测用于映射。目录原文保存在 official-hero-list.json，来源及每张头像 URL 保存在 ios/Assets/Heroes/manifest.json。

LVHeroPortraits 从 HUD 可执行文件所在目录读取资源；有界缓存最多 16 张，最新标记持有本帧图片。加载发生于采样呈现时，动画 drawRect 仅绘图；不在游戏运行中下载头像。UIKit 裁剪为圆形并描红边。未知资源或不可读图片保持原数字，无新增开关。本机参考点、信息面板隐藏规则及现有补间不变。

IPA 新增三项资源检查：两设备族图标声明、实际图像大小和不透明 RGB 格式；所有头像的 PNG CRC、压缩数据、哈希和目录匹配；报告中已出现的英雄 ID 与官方名称对应。合计八项 IPA 检查，原有五项签名检查继续运行。CI 无法验证 SpringBoard 实际图标缓存或设备画面，覆盖安装后需要手机观察。


## 0.7.4 血量圈与无视野排查

最新证据见 [0.7.3 对局摘要](device-0.7.3-summary.json)。两个检测快照相同：五个敌方英雄、四个 `(500,0,500)` 位置、一个略超边界的出生点；后来的 HUD 是不同时间，第一份生成四枚标记，第二份已不在对局。用户确认无视野时整枚头像间歇消失，并明确拒绝保留最后位置。

`lv_minimap_frame` 允许有效位置在血量读取失败时继续显示；只有已确认血量不大于零才按死亡处理。普通地图只对归一化坐标在 `[-0.04,1.04]` 内的小幅越界夹到边界；0.04 是本实现的有限边缘容差，不是恢复出的原始常量。远离地图的 `(500,500)` 不变成边缘标记。几何一致性只比较实际使用的比例、半尺寸、模式和缩放状态，不因无关的相机动画字段变化丢弃整帧；对局／几何读取变化有有限重试，失败仍清除。

血量来源是原游戏 UI 的 `UIMiniIconHeroCtrl.currentHpPercent`，通过静态实体控制器和 `Dictionary<UInt32,UIMiniIconBaseCtrl>` 匹配对象 ID 与 visual 回指。原 `UpdateHpPercent` 的两条指令执行 `(currentHP << 14) / maxHP`；缓存比例为 Q14。缓存必须初始化、启用、显示、未回收，已更新的时间有限且大于零，比例在 0～16384 内；指针、条目和相关字段重读不一致时拒绝。不是最大血量推断，也不是原子服务端血量。圈从 12 点顺时针绘制，超过半血绿、超过四分之一黄、其余红，未知灰。原游戏关闭血量功能或隐藏缓存时会未知。具体字段与短指令记录见 [血量及坐标证据](ios-minimap-health-layout.json)。

补采 `ActorComponentAttribute.lastPosition`、`ActorTransformSync._logicPos/_lastLogicTime`、host 角色逻辑位置与身份，以及 visual 可见标志／tick，各自有独立读取标记。同步代码同样从逻辑位置复制，因此不能直接认定它能提供无视野实时位置。候选数据不参与绘制，旧坐标也不参与绘制。新字段需要手机在视野切换时连续核对。

HUD 串行采样队列每秒保存一次最多 16 个英雄，保留同一对局的最后 32 个样本；最多 512 KiB，通过专属 root 所有的目录和原子文件写入存放，诊断 helper 导出 `hud.coordinate_trace`。不保存全内存或游戏二进制。纯 C 遥测协议 3 另增加当前有效标记、血量比例有效标记和边界夹取数量；这些数字不能证明画面已显示。0.7.4 的真机渲染、文件传输与无视野坐标未验证。
