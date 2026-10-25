# 机械革命耀世 16 Pro · GM6IX7B 黑苹果 EFI

**Intel Core i7-14650HX · NVIDIA RTX 4070 Laptop · macOS Tahoe 26 · OpenCore 1.0.8**

这是一台耀世 16 Pro 的实际使用配置，记录从安装、显示适配到网络、声音、亮度和触控板恢复的结果。
本次更新为 **`v0.2.0-preview`**，供相同硬件的用户交流与复现。

> 已实现日常使用的主要功能；睡眠/唤醒仍未解决；本次加入本机 USB 定制，地图定位与 App Store 已由用户确认恢复。
> 配置只在下表这台机器验证。同名不同批次、不同屏幕、网卡、CPU 或 AMD 机型不能直接套用。

## 下载与开始

从 [Releases](https://github.com/Sunburst0218/MECHREVO-GM6IX7B-i7-14650HX-RTX4070-Hackintosh/releases) 下载 **`GM6IX7B-Tahoe-EFI-v0.2.0-preview.zip`**，并核对同页 SHA-256。
仓库正文保存说明与配置模板，EFI 文件树位于 Release 附件中。

开始前有两项准备：

1. 补齐作者原版 **SimpleHDA 1.0.0 RELEASE**：按 [安装说明](INSTALL.md) 操作，或运行解压文件夹内的 `Prepare-EFI.command`。
2. 给 `EFI/OC/config.template.plist` 填写**自己的**序列号、MLB、UUID 和 ROM，另存为 `config.plist`。

公开包不提供共用三码。未补齐依赖、未填写身份信息时，不要直接覆盖正在使用的启动 EFI。

## 硬件清单

| 项目 | 这台机器的配置 |
| --- | --- |
| 品牌 / 型号 | 机械革命 MECHREVO 耀世 16 Pro / GM6IX7B |
| CPU | Intel Core i7-14650HX |
| GPU | NVIDIA GeForce RTX 4070 Laptop GPU，使用独显直连模式 |
| 内存 | 32 GB |
| 内置显示器 | B160QAN02.3，2560 × 1600，240 Hz |
| Wi-Fi | Intel AX211，PCI `8086:7A70` |
| 有线网卡 | Motorcomm YT6801，PCI `1F0A:6801` |
| 声卡 | Senary SN6140，Codec `14F1:1F87`，Intel HDA 控制器 `8086:7A50` |
| 触控板 | 当前 VoodooI2C / VoodooI2CHID 方案已可用 |
| SMBIOS | `MacBookPro16,2` |
| OpenCore | 1.0.8 RELEASE |
| macOS | 实机报告为 Tahoe 26.7.1 / Build 25G241，不据此承诺其他 Build |

## 功能状态

“正常”表示这台机器的实际反馈，不代表对所有应用与外设完成了兼容性测试。

| 功能 | 状态 | 备注 |
| --- | --- | --- |
| 系统启动 | ✅ 正常 | 当前配置已实际使用 |
| NVIDIA 显示 / 加速 | ✅ 已验证 | 用户反馈桌面流畅；需要系统侧安装 NullMoth / 1401 驱动 |
| 内屏 240 Hz | ✅ 正常 | 2560×1600 内置屏幕 |
| 原生 HiDPI / 缩放 | ✅ 可用 | 使用系统自带缩放，未另打 HiDPI 补丁 |
| 实际背光亮度调节 | ✅ 正常 | 滑块可改变屏幕实际亮度；保留 `nvrmacpibl=1` |
| Wi-Fi | ✅ 正常 | AirportItlwm Tahoe 2.4.0 alpha，已连接 5 GHz 网络 |
| 有线网络 | ✅ 正常 | 使用作者现场修复的 YT6801 1.0.13，**无需 `dk=0x8001`** |
| 蓝牙 | ✅ 可用 | 尚未穷尽外设兼容性测试 |
| 内置扬声器 | ✅ 正常 | 本机专用的 AppleALC + SimpleHDA 配置 |
| 麦克风 | ✅ 正常 | 用户已确认录音恢复 |
| 原有关机 / 重启爆音 | ✅ 当前反馈已消失 | 包含播放音乐时的用户测试；仍欢迎记录后续反馈 |
| 触控板 | ✅ 正常 | 当前配置可用 |
| 摄像头 | ⚠️ 基本可用 | 可拍照、可出画面；个别应用曾出现预览黑屏但可拍照 |
| 常规关机 / 重启 | ✅ 可用 | 与整机睡眠分开看 |
| 整机睡眠 / 唤醒 | ❌ 尚未解决 | 手动睡眠后灯闪烁，唤醒时灯常亮但屏幕黑，需强制重启，见 [已知问题](KNOWN-ISSUES.md) |
| 天气位置 | ✅ 用户反馈正常 | 不包含任何个人位置截图 |
| 地图当前位置 | ✅ 正常 | 开启“隐私与安全性 → 定位服务 → 地图”后用户确认恢复 |
| App Store | ✅ 登录与下载正常 | 用户完成系统侧网络接口重建后确认；不向下载者自动应用重建工具 |
| 本机 USB 映射 | ✅ 已加载并使用 | USBToolBox + 定制 UTBMap，两个控制器分别12/4项；不代表所有速率/方向都完整验收 |
| AirDrop / 接力等 | ❔ 未验证 | Intel 无线方案不承诺全部连续互通功能 |
| 外接显示、全部 USB 端口、读卡器、续航 | ❔ 未逐项验收 | 请勿依据内屏或其他功能正常推断它们已适配 |

## 这份配置的关键适配

### NVIDIA 独显与亮度

使用独显直连。保留已经实测可用的显卡启动参数和 `nvrmacpibl=1`。
NVIDIA 驱动的 NVRM、NVAccel 与用户态组件安装在 macOS 系统中，**复制 EFI 不会自动安装它们**。
请使用 [NullMoth 官方项目](https://github.com/nullmoth/nvidia-macos-driver) 的 1401 工具，遵循其系统版本说明。
本轮实机报告确认 NVIDIA 2.5.4。该版本在本机正常显示，但睡眠恢复失败；EFI 附件不捆绑其系统侧驱动。

### SN6140 声音

采用 **Lilu → AppleALC 1.9.8 → SimpleHDA 1.0.0**。
本机使用 `alcid=21`，另外保留 SN6140 的 PinConfig 和三条运行时补丁，补丁已覆盖 Darwin 25。
**仅填 `alcid=21` 或只换成上游原版 AppleALC，并不等同于这份适配。**
保留发布包的 AppleALC 配置与补丁，升级前另做副本。不要同时加载竞争的 VoodooHDA 音频方案。

### AX211 无线与 YT6801 有线

- Wi-Fi 使用 Tahoe 专用 AirportItlwm alpha，并限制在 Darwin 25 加载；保留的 `itlwm.kext` 当前禁用。
- YT6801 使用系统侧 DEXT，下载和后续公开版本见 [MiniYv/yt6801-for-macOS](https://github.com/MiniYv/yt6801-for-macOS)。
- 这台机器使用作者修复后的 **1.0.13**。如仓库未提供对应公开构建，请向作者获取该修复版本。
- 旧版本曾在 `provider entitlements check failed` 处失败。新版把 PCI 权限数组中的 `builtin` 声明放在匹配字典前，现场验证可不加 `dk` 使用。
- 本包不重新捆绑朋友提供的未公开驱动压缩包，也不将 DEXT 错放进 `OC/Kexts`。

### USB 与其他保留项

当前启用 **USBToolBox + 本机 UTBMap**，UTBDefault 已禁用，XhciPortLimit=false。

UTBMap 以 PCI 控制器匹配：`8086:7A60` 保留12项，`8086:1135` 保留4项；来自本机硬件采集，运行报告核对已实际加载，用户确认使用正常。
Type-C 的全部方向、SuperSpeed 组合与雷雳功能尚未逐项验收；映射并不等于雷雳热插拔/设备协议均可用。不同主板/批次请自行重新映射，不照抄端口号。
原配置内启用的 RealtekRTL8111 也予以保留，以便维持原有测试基线；它并非本机 YT6801 的驱动。
本次以 2026-10-25 用户导出的正常 EFI 为基线，清除个人身份、旧备份和元数据。保持驱动版本、机型和主题；不包含禁用显卡、限制 NVRAM 写入或 S4 写盘休眠实验。

## 使用说明

完整步骤见 [INSTALL.md](INSTALL.md)。先使用备用 U 盘测试，保留能启动的配置，再部署到自己的 EFI 分区。
接收者必须生成独立身份信息；本包中的四个身份字段已清空 / 置零。
不要把公开模板直接替换到发布者当前正在使用的机器上。

## 已知限制与反馈

详细症状及排查顺序见 [KNOWN-ISSUES.md](KNOWN-ISSUES.md)。
提交 Issue 时请写明：机器具体型号、CPU/GPU/网卡、BIOS 版本、macOS 版本与 Build、实际安装的 NVIDIA/YT6801 版本、复现步骤。
日志与截图请遮住序列号、MLB、UUID、MAC 地址、账户和精确位置。

此配置含第三方驱动所需的 SIP/AMFI 放宽项，不等同于原生 Mac 的默认安全策略。
去掉 `dk` 不代表其他策略全部恢复默认。不要为修复应用授权而随意删除显卡驱动所需参数。

## 版本与验证

- [变更记录](CHANGELOG.md)
- [组件版本](KEXT-VERSIONS.csv)
- [第三方来源与许可](THIRD-PARTY.md)
- Release 附件内提供 `FILE-SHA256SUMS.txt`；压缩包的校验值在同页 `SHA256SUMS.txt`。
- 当前公开配置通过 OpenCore 1.0.8 `ocvalidate`。模板身份为空，格式校验通过不代表已经可以启动。

## 致谢与许可

感谢 Acidanthera、Dortania、NullMoth、laobamac、OpenIntelWireless、VoodooI2C、USBToolBox、MiniYv 及参与测试的群友。
本仓库维护的是这台机器的配置与使用记录，各驱动及资源版权属于各自作者。

原创说明、配置整理和准备脚本采用仓库 [MIT 许可](LICENSE)；该许可**不覆盖第三方驱动、Apple 组件或上游资源**。
SimpleHDA 原版组件请从作者处取得；其他组件的原许可与来源见 Release 内 `ThirdParty/` 和 [THIRD-PARTY.md](THIRD-PARTY.md)。
