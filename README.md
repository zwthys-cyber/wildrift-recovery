# lvlolm 源码恢复与 iOS 移植

已从 `/root/lvlolm1.3.sh` 恢复 57 项配置的字段类型、默认值、序列化顺序和数值取值范围，以及自动水银与自动惩戒的主要判断逻辑，并实现可编译的 C 代码与 iOS 诊断应用。

**0.7.6 将英雄血量圈改为优先读取原生当前血量和最大血量，按比例绘制，不再依赖小地图 UI 血量缓存是否显示。** 已收到并核对 0.7.5 导出的 FEProj，恢复了最大血量 getter 的配置选择、属性向量与节点布局；新路径检查两份框架 UUID、对象身份及采样前后的一致性。读取失败时仍可使用已验证的 UI 比例，否则显示灰圈，不推算最大血量。新读取和画面效果尚未在手机上验证。

无视野实时位置仍未解决。[0.7.4 设备日志](analysis/device-0.7.4-summary.json) 显示存活英雄的主坐标和同步坐标一起变成 `(500, 0, 500)`。原生引擎有逻辑／同步两套布局，逻辑坐标含 XOR 解码，但尚未恢复这局同步对象与独立逻辑对象的可靠对应关系；不能把同步对象按逻辑偏移解码。新日志增加迷雾裁剪配置与 Fow 强制位置观测，候选坐标仍不用于绘制。现有头像、圆环、桌面图标、每 0.15 秒采样与移动补间保留。自动触控、实体投影与视角调整尚未实现。

目标设备：iPhone 15 Pro Max，iOS 17.0，已安装 TrollStore。用户提供的游戏内版本：App `7.3.0.2813`、Res `7.3.19.51`。已收到导出的游戏框架和元数据；Info.plist 为 `7.3.3` / `2818`，适配按框架 UUID 和精确哈希锁定。Info.plist 与游戏内版本字符串不能直接等同。

## 安装与检测

1. 先在旧版停止悬浮窗，再在 TrollStore 中打开 `dist/lvlolm-recovery-0.7.6.ipa`，覆盖更新旧版本。
2. 打开恢复应用，可以编辑、导入、导出 `dynamic_draw_lolm.ini`，或者恢复原始默认值。
3. 点“运行读取自检”。自检通过只证明本进程内存读取正常。
4. 进入游戏训练模式，选择携带惩戒，等待角色出现，再回到恢复应用，点“检测游戏并读取对局”，选择 `lolm`。
5. 点“查看对局与技能快照”查看惩戒预览、候选目标和阻止条件。靠近红／蓝 Buff 或龙采样，可核对目标类别、距离与阈值。保持技能有正常冷却，手动使用惩戒后立即再检测一次，可核对非零冷却、库存和状态。修改配置后重新检测，预览才会使用新配置。
6. 仅需要小地图敌方标记时，开启“绘制配置”中的“小地图绘制”，在“iOS 小地图对齐”关闭“显示对齐框”“显示信息面板”“显示本机定位点（＋）”，重新检测 `lolm` 后点“启动／更新只读悬浮窗”。信息面板和“＋”默认关闭，隐藏它们不停止采样。原有对齐参数保留；需要重新校准时才打开参考框和本机点，或点“应用推荐对齐”将左／上／宽／高设为 6.8／1.2／15.5／33.5%。修改配置后重新启动窗口。停止入口在恢复应用，游戏进程退出后窗口自行结束。
7. 游戏中观察窗口至少 10 秒后返回应用，点“导出诊断报告”，保存 `lvlolm-diagnostics.json`。`target_probe.game_snapshot.smite_preview` 是检测时的判断；`local_skills` 包含各技能的读取标记。`hud_launch` 保存启动请求结果，`hud.sampling` 保存最近一次窗口采样的结果、次数、间隔、惩戒数值及敌方／标记数量；`target_probe.game_snapshot.minimap` 保存检测时的映射状态与归一化位置；它与检测时快照分别记录。`fresh` 要求最近 3 秒内完成过采样，不能证明画面显示或数据可用于施法。角色 `ready` 只描述原有基础字段成功，技能列表 `ready` 描述身份／冷却成功；类别、库存、技能槽和施法状态有各自标记。冷却为零不代表可释放。
8. 如游戏框架 UUID 改变，再点“导出适配文件”，保持恢复应用在前台，保存或分享 `lvlolm-ios-inputs.zip`。完整导出现在也包含原生引擎。该功能收集原始文件，不解密或修改输入。

0.7.5 的原生引擎补充导出已收到，文件完整且 UUID 与设备日志一致，无需重复导出。血量圈新路径的原生证据见 [ios-native-health-layout.json](analysis/ios-native-health-layout.json)。诊断报告的 `minimap.native_health` 和每个英雄的 `native_health_status` 记录真实最大血量读取及失败原因；短时追踪也保留这些字段，便于核对视野变化期间的坐标、迷雾裁剪状态和血量。

快照先核对框架 UUID 和运行时类名，限制对象数量并检查列表切换。配置开关用于保存配置和这次模拟，尚未启用自动操作。预览按原始 X/Z 定点坐标比较配置范围：默认 83000 换算为约 5.066；Android／iOS 坐标比例是待核对假设，不能据此宣称真实施法范围已验证。600／1000／1400 来自原程序等级公式，尚不代表本版 iOS 游戏实际伤害。

用户已提供的 [设备诊断分析](analysis/DEVICE.md) 确认 0.1.0 辅助进程 UID 0、目标任务端口成功，以及远程镜像头读取成功。UnityFramework UUID 为 `085E1DDF-4A8D-34E2-9D73-A0A28BCC0B83`，运行时头的 cryptid 为 0；主程序的 cryptid 为 1。版本字段在旧诊断工具中为预设值，不能把它们当作安装游戏版本已核实的证据。

收到的 ZIP 完整，0.2.0 文件收集功能已得到真机输入支持。框架 cryptid 为 0，主程序为 1。已沿框架加载代码恢复自定义 `FMN!` v31 元数据，解析出 47,894 个类型、495,160 个字段记录、390,601 个方法记录和 86 个镜像。详见 [iOS 逆向分析](analysis/IOS.md) 和 [字段及方法位置](analysis/ios-layout.json)。

小地图恢复使用普通地图映射分支，字段和指令记录见 [小地图分析](analysis/ios-minimap-layout.json)。视口地图／全屏地图暂停标记；普通 UI 缩放与自定义布局需要重新对齐。超过 2 秒没有完成采样时清掉标记。用户已确认测试场景中无视野时坐标持续更新，见 [截图与反馈摘要](analysis/device-0.7.0-summary.json)；这条观察尚未覆盖正常五人对局。当前自动显示已收录英雄头像，未知英雄保留数字标记；头像来自[手游官方目录](https://lolm.qq.com/v2/champions.html)，无需新增开关，沿用标记大小与移动补间。可在“敌方标记直径（点）”中调整头像大小。

0.7.6 血量圈自动启用，无需增加恢复 App 的开关，也不要求开启游戏自身的小地图血量显示设置。优先读取原生当前／最大血量；该路径不可用时仅使用可验证的 UI 比例。两者都不可用时显示灰圈，失败原因记录在诊断报告中。

排查无视野丢标：让敌方从可见进入无视野，观察约 10 秒，返回恢复 App，先导出报告再停止窗口。`hud.coordinate_trace.samples` 包含最近最多 32 个有效样本、每秒至多一次的英雄坐标和同步时间；这些候选坐标仅用于分析，不用于绘制。报告中的检测快照与随后 HUD 状态不是同一时刻。

标记动画以对象编号、资源编号及本机标记匹配身份，在最新两个已读取位置之间过渡 0.15 秒，首帧、重新出现和大幅跳变直接定位。失败／死亡／消失立即清除；地图比例、方向或对局实例改变时重置动画。动画不外推未来位置，也不作为失败读取的备用数据。采样与动画分开，屏幕刷新目标 60 帧，实际帧率和 CPU 负载仍需手机观察。

0.7.1 的 `hud_launch.display_geometry` 同时记录 HUD 启动时的实际屏幕点尺寸、原生像素尺寸及缩放。再次核对偏差时，结合启动时矩形设置使用这些数值，避免把裁剪截图当作完整屏幕。

## 恢复证据

- 原文件是 Android ARM64 ELF，大小 5,841,224 字节，SHA-256 为 `e385f312ecbb5e575d2709a15a3b0157aa6fb37b52299075d9665f14df6fd111`。原文件未被改动。
- 已定位配置加载函数 `0x427698`、保存函数 `0x429fc8`、构造初始化函数 `0x426f24`。
- 默认值来自构造初始化的 154 条指令，停止地址 `0x42718c` 位于首次函数调用之前。使用隔离的 ARM64 仿真内存执行纯初始化；没有执行程序入口、系统调用、驱动调用或网络通信。
- 保存函数的字段加载与加载函数的字段地址逐项交叉核对。范围来自加载辅助函数实际传入的参数。`smiteHealthThreshold` 的 600／1000／1400 三选一规则来自显式机器码判断。
- 所有地址均是安卓 ELF 中的静态虚拟地址；配置偏移是安卓应用配置对象的偏移，**不是 iOS 游戏内存地址**。

详细结果见 [逆向报告](analysis/RECOVERY.md)、[配置恢复数据](analysis/recovered_config.json)、[默认配置](analysis/recovered_defaults.ini)。`analysis/assembly` 包含相关函数的 ARM64 汇编。

## 实现与验证

- `core/LVConfig.c`：57 项配置读写，保留原始字段名、顺序和四位小数输出；保留原有数值夹取规则和惩戒血量回退规则。
- `core/LVActions.c`：重写水银与惩戒的判断函数，输入标准化快照，输出触点及等待时间；不进行游戏读取或触控。惩戒读取结果、技能等级和时钟由调用方提供，Android 的读取链没有接入 iOS。
- `ios/main.m`：UIKit 配置编辑器，支持 INI 导入、导出、重置和诊断报告导出。
- `ios/LVMachReader.m`：实际 Mach 内存读取接口、自身读取校验、任务端口访问和镜像元数据读取。读取失败清空输出缓冲区。
- `ios/LVProbe.m`：提供进程列表、选中目标的只读诊断，以及本应用 HUD 的启动／状态／停止接口。没有任意 shell 命令接口。
- `ios/LVHelper.m`：按 TrollStore 公开的 persona 接口调用打包的诊断辅助程序；设置超时与输出上限。
- `ios/LVCollect.m`：收集选中 lolm 进程对应的游戏目录文件，输出限定为本应用已验证的 Documents 容器。采用临时文件和原子替换；只读取游戏文件。
- `core/LVZip.c`：限制大小的流式 ZIP 写入，保留原文件内容与 CRC32；无需将整个框架读入内存。
- `tools/inspect_ios_target.py`：离线检查 IPA／Mach-O／适配 ZIP 的架构、UUID、加密状态、函数入口与签名页哈希，不执行输入文件。适配 ZIP 的框架 UUID 会与设备清单核对。
- `tools/recover_ios_metadata.py`：按精确输入哈希恢复自定义名称表、托管字段偏移与方法地址。完整查询结果写入 `build/`；原游戏文件保存在忽略的 `inputs/`，不包含在源码包中。
- `core/LVTarget.c`、`ios/LVSnapshot.m`：读取已定位的对局对象。UUID 核对由 iOS 包装层执行，纯 C 核心可使用受限读回调独立测试；没有写入或触控接口。
- `core/LVSmitePreview.c`：实际快照接入原程序惩戒规则，只计入类别已确认的敌方英雄，逐项报告候选目标状态；已读到的冷却锁定、施法中或库存耗尽也会阻止模拟。没有真实触控后端，模拟丢弃触点输出，不保持动作状态。
- `ios/LVSnapshotController.m`：查看最近一次采样及判断条件；每个读取失败都明确显示，不用零值冒充成功。
- `ios/LVHUD.m`、`ios/LVHUDControl.m`：root HUD 插件与系统窗口注册，复用 UUID 限定的只读快照。状态／停止使用本应用持久化的随机会话通知，不从文件读取 PID 后杀进程。启动有大小限制和超时；只对本次直接创建且启动失败的子进程进行终止。窗口请求触摸穿透，没有输入生成接口。
- `core/LVMinimap.c`：按英雄分类、阵营及唯一对象编号选择敌方，生成原小地图归一化坐标；读取游戏普通小地图的映射比例和半尺寸，提供独立的 iOS 对齐参数。默认阵营方向可手动覆盖。失败帧、已确认死亡、无坐标或远离地图的对象不绘制；小幅边缘越界夹到边界。血量读取失败不影响有效位置，不缓存最后位置。
- `core/LVMinimapMotion.c`：独立的绘制补间状态，支持身份匹配、动画中途更新、消失清除和瞬移定位；不外推位置。
- `ios/LVHeroPortraits.m`：按精确英雄资源 ID 读取离线图片，缓存头像；屏幕刷新时仅绘图，不下载或重复读取文件。
- `ios/Assets`：桌面图标及官方英雄头像，来源、目录快照和校验值随源码保存，见 [图片说明](ios/Assets/README.md)。
- `ios/LVMinimapSettings.m`：设置小地图的横屏位置、大小、方向、定位点及手动映射；提供推荐矩形按钮和一次性旧默认矩形迁移，保留自定义矩形及其他选项。原 57 项安卓配置独立保留。
- `core/LVHUDTelemetry.c`：窗口最近一次采样的有限诊断记录。每次启动使用独立会话；读取核对进程、协议、序号、字段范围和时间。记录更新中、缺失、来自其他进程或过期时不会被当作正常更新，不包含目标指针或完整角色快照。

新解析器对无效输入采用整次导入回滚，并拒绝 NaN、无穷大、不完整颜色和未来配置版本。未知键忽略，重复有效键最后一个生效。这些输入校验是重新实现时增加的行为，不能称为已从原程序恢复的行为。

已通过 C 配置测试（AddressSanitizer／UndefinedBehaviorSanitizer）、水银的 25 组机器码对照、惩戒主判断的 54 组对照，以及怪物类别与伤害公式的指令对照。原函数的外部读取、触控、等待、时钟和部分缓存调用在仿真中被拦截，因此这些测试不能证明游戏适配完成。极端时间戳溢出采用饱和处理，与原整数回绕行为不同。

流式 ZIP 的内容已由独立 Python ZIP 读取器核对，损坏 CRC、遍历路径、重复名称、符号链接、文件类型与大小上限均有检查；原生测试采用 AddressSanitizer／UndefinedBehaviorSanitizer。适配 ZIP 检查器还验证了框架 UUID 不一致的报告行为与加密状态。

元数据转换已与两个纯 RAM 原函数做隔离对照：64 组转换状态、210 个字符串索引及重复读取。getter 对照覆盖 156 组输入，新增库存／技能槽／施法状态及 6 个状态谓词；禁止外部调用和系统调用，容器访问在类初始化及托管包装前停止。快照适配器通过 46 个 ASan／UBSan 场景，判断预览通过 34 个场景，包括错误类别、原始 X/Z 距离、读取失败、编号溢出、锁定、施法、库存及目标条件边界。

0.7.6 本地通过 8 项 IPA 静态检查，核对三个 ARM64 iOS 可执行文件及签名、桌面图标和 142 位头像；小地图 88 项、原生血量 50 项、UI 血量缓存 25 项、动画 49 项、遥测协议 93 项与目标读取 51 个场景通过 ASan／UBSan。用原始 FEProj 指令在合成内存中执行 5 项测试／72 组输入，验证最大血量 getter 的两种配置分支、向量索引、空节点、配置字段与两套 Fow 坐标布局；未知调用、断言处理、热修复回调和系统调用均被拒绝。原 Unity getter 的 9 项／156 组对照也通过。GitHub CI 重复 C 核心、IPA、ZIP 和收集检查器测试，私有引擎文件不上传 CI。0.7.5 引擎导出已由收到的文件验证；新血量读取／画面尚未获设备验证，无视野实时坐标仍未修复。

GitHub Actions 工作流见 `.github/workflows/ios-build.yml`。推送 `v*` 标签会在 Ubuntu 24.04 上下载按哈希固定的 SDK／ldid，用 clang/lld 18 编译、运行以上检查，并发布 IPA、源码与校验值。CI 另生成 `analysis/ci-validation.json`，记录实际 GitHub 编译器、提交、运行链接及 IPA 哈希；本地 clang 21 结果保存在 `analysis/validation.json`。

## 本地构建

Linux 已准备好本项目工具链。其他 Linux 主机可使用 Python 3.12+ 和下列软件包：

```sh
apt-get install python3-pyelftools python3-capstone python3-unicorn binutils-aarch64-linux-gnu clang-21 lld-21 gcc zlib1g-dev
python3 scripts/fetch_toolchain.py
python3 tools/analyze_binary.py /path/to/lvlolm1.3.sh --output analysis
python3 tools/recover_config.py /path/to/lvlolm1.3.sh --output analysis
python3 tools/generate_fields.py
python3 scripts/build_ios.py
gcc -std=c11 -D_POSIX_C_SOURCE=200809L -Wall -Wextra -Werror -fsanitize=address,undefined -g -Icore core/LVConfig.c tests/config_test.c -lm -o tests/config_test
./tests/config_test
LVLOLM_ANDROID_BINARY=/path/to/lvlolm1.3.sh python3 tests/test_mercury_equivalence.py
LVLOLM_ANDROID_BINARY=/path/to/lvlolm1.3.sh python3 tests/test_smite_equivalence.py
python3 tests/test_ipa.py
python3 tests/test_device_preview_replay.py
python3 tests/test_zip.py
python3 tests/test_collection_inspector.py
python3 tests/test_ios_metadata_equivalence.py
python3 tests/test_ios_getters_equivalence.py
gcc -std=c11 -Wall -Wextra -Werror -fsanitize=address,undefined -g -Icore core/LVTarget.c tests/target_test.c -o build/target_test
build/target_test
gcc -std=c11 -D_POSIX_C_SOURCE=200809L -Wall -Wextra -Werror -fsanitize=address,undefined -g -Icore core/LVSmitePreview.c core/LVConfig.c core/LVActions.c tests/smite_preview_test.c -lm -o build/smite_preview_test
build/smite_preview_test
gcc -std=c11 -Wall -Wextra -Werror -fsanitize=address,undefined -fno-omit-frame-pointer -no-pie -g -Icore core/LVHUDTelemetry.c tests/hud_telemetry_test.c -o build/hud_telemetry_test
build/hud_telemetry_test
gcc -std=c11 -D_POSIX_C_SOURCE=200809L -Wall -Wextra -Werror -fsanitize=address,undefined -fno-omit-frame-pointer -no-pie -g -Icore core/LVMinimap.c tests/minimap_test.c -lm -o build/minimap_test
build/minimap_test
python3 tests/test_ios_minimap_projection.py
```

`recover_config.py` 的硬编码地址只适用于已核对 SHA-256 的原文件。通用静态分析器的地址传播是线性启发式，只生成候选引用，不是自动反编译器。

提供 iOS 目标后可以先运行：

```sh
python3 tools/inspect_ios_target.py /path/to/Game.ipa --output analysis/ios-target.json
python3 tools/inspect_ios_target.py /path/to/lvlolm-ios-inputs.zip --output analysis/ios-inputs.json
python3 tools/recover_ios_metadata.py --framework /path/to/UnityFramework --metadata /path/to/global-metadata.dat
```

工具链下载版本和 SHA-256 保存在 `scripts/toolchain-manifest.json`。SDK／编译器／ldid 为第三方构建依赖，不包含在恢复源码压缩包中。仓库和版本下载托管在用户授权的私有 GitHub 仓库中。

## 资料

- [TrollStore 官方说明与限制](https://github.com/opa334/TrollStore#readme)：IPA 安装、私有权限和 root 辅助接口仍受系统限制。
- [TrollStore TSUtil.m](https://github.com/opa334/TrollStore/blob/main/Shared/TSUtil.m)：persona API 用法参考；本项目采用独立的只读探测实现。
- [TrollSpeed HUD 实现](https://github.com/Lessica/TrollSpeed/tree/a609be260c8261ead36509c3bc4ded8479da9c40)：插件启动与系统窗口注册参考，MIT 许可证保存在 `ios/TrollSpeed-LICENSE.txt` 并随 IPA 打包。
- [Clang 交叉编译文档](https://clang.llvm.org/docs/CrossCompilation.html)、[Mach-O LLD](https://lld.llvm.org/MachO/index.html)。
- [Theos SDK 发布](https://github.com/theos/sdks/releases/tag/master-146e41f)、[Procursus ldid](https://github.com/ProcursusTeam/ldid/releases/tag/v2.1.5-procursus7)。
- [PKWARE ZIP 格式规范](https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT)：导出 ZIP 的记录布局与 CRC32。
- [Il2CppDumper 元数据结构](https://github.com/Perfare/Il2CppDumper/blob/master/Il2CppDumper/Il2Cpp/MetadataClass.cs)：v31 记录布局的参考；自定义头和名称转换来自本次框架机器码。
