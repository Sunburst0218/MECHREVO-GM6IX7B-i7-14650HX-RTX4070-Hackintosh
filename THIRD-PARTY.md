# 第三方组件、版权与来源

本仓库的 MIT 许可仅适用于原创说明、配置整理与准备脚本，不覆盖第三方二进制、固件、图标或 Apple 组件。
各上游原版权、许可与使用条件继续有效；请从原项目取得源码、发行版与许可全文。
发布附件内 ThirdParty/ 保存已取得的原许可/说明，文件名用于指向相应项目，不将不同组件统一改成 MIT。

| 组件 | 上游来源 / 对应源码入口 |
| --- | --- |
| OpenCore / OpenRuntime / OpenCanopy | https://github.com/acidanthera/OpenCorePkg/tree/1.0.8 |
| Lilu | https://github.com/acidanthera/Lilu |
| AppleALC | https://github.com/acidanthera/AppleALC/tree/1.9.8 |
| SimpleHDA (需自行从作者补齐) | https://github.com/laobamac/SimpleHDA/releases/tag/v1.0.0 |
| VirtualSMC / SMC 插件 | https://github.com/acidanthera/VirtualSMC |
| AMFIPass | https://github.com/dortania/OpenCore-Legacy-Patcher |
| BlueToolFixup | https://github.com/acidanthera/BrcmPatchRAM |
| BrightnessKeys | https://github.com/acidanthera/BrightnessKeys |
| CpuTopologyRebuild | https://github.com/b00t0x/CpuTopologyRebuild |
| IntelBluetoothFirmware / IntelBTPatcher | https://github.com/OpenIntelWireless/IntelBluetoothFirmware |
| NVMeFix | https://github.com/acidanthera/NVMeFix |
| RealtekRTL8111 | https://github.com/Mieze/RTL8111_driver_for_OS_X |
| RestrictEvents | https://github.com/acidanthera/RestrictEvents |
| USBToolBox / UTBMap（本机定制） / UTBDefault（禁用） | https://github.com/USBToolBox/kext |
| VoodooI2C / VoodooI2CHID / VoodooInput | https://github.com/VoodooI2C/VoodooI2C |
| VoodooPS2Controller | https://github.com/acidanthera/VoodooPS2 |
| WhateverGreen | https://github.com/acidanthera/WhateverGreen |
| XHCI-unsupported | https://github.com/RehabMan/OS-X-USB-Inject-All |
| itlwm | https://github.com/OpenIntelWireless/itlwm |
| AirportItlwm Tahoe alpha (738d4c6) | https://github.com/laobamac/itlwm/tree/738d4c6 |
| HfsPlus / OcBinaryData 资源 | https://github.com/acidanthera/OcBinaryData |
| NVIDIA / NullMothSafe / 1401 | https://github.com/nullmoth/nvidia-macos-driver |
| YT6801 1.0.13 (系统侧、未捆绑) | https://github.com/MiniYv/yt6801-for-macOS |

## 本机改动范围

公开模板保留了 SN6140 的 AppleALC PinConfig 与三条运行时补丁，实际改动均在本机配置与 AppleALC Info.plist。
AppleALC 的磁盘二进制保持 1.9.8 原版；对应源码入口见上表。
其他驱动从当前工作副本逐字节复制，未统一更新、重新编译或降级。
一些 Acidanthera 插件来自 1401 固定的 Dortania 按提交构建，版本高于上游最后 tag 并不意味着要降级。
实际版本与文件 SHA-256 见清单，不能只按文件名认定版本。

## 独立取得的组件

SimpleHDA 的 NOTICE 明示保留作者版权且包含 Apple 专有 AppleHDA。此包不重复分发 SimpleHDA.kext，
由使用者通过作者 Release 取得。Prepare-EFI.command 固定下载官方原版并核对 SHA-256，不修改其内容。
SimpleHDA 的原 NOTICE 作为说明附在 ThirdParty/ 中，不代表授予该组件额外权利。

NVIDIA 驱动需要使用者通过官方 1401 安装；该项目采用其自己的非商业/其他分组件许可，不能用本仓库 MIT 覆盖。
YT6801 现场修复包未作为本仓库附件再分发，以作者公开版本与许可为准。

## 使用目的

这里分享特定硬件的配置和验证记录；不以他人驱动的原创作者自居，不销售第三方驱动。
保留来源及原作者信息。转载第三方组件时继续遵循其相应条件。
