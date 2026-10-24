# 安装与部署

本包用于 GM6IX7B / i7-14650HX / RTX 4070 Laptop / AX211 / YT6801 的 macOS Tahoe 配置分享。
不是通用安装镜像。请先保留 Windows 数据与当前可启动的 EFI，使用备用启动 U 盘验证。

## 1. 解压发布附件

从 Releases 下载 `GM6IX7B-Tahoe-EFI-v0.1.0-preview.zip`。
解压后顶层为说明、准备脚本、`EFI/` 和 `ThirdParty/`。
核对发布页 SHA-256；不要把整个仓库源码 ZIP 当成已经准备好的 EFI。

## 2. 补齐 SimpleHDA

SimpleHDA 的 NOTICE 保留作者版权，且说明其嵌入了 Apple 专有 AppleHDA 组件。
因此本发布包不再次捆绑这一个 kext；配置中的加载项与声音适配仍然保留。

### 在 macOS 上准备

在“解压后的本地文件夹”里运行：

```bash
bash Prepare-EFI.command
```

脚本只从作者 GitHub 下载固定的 1.0.0 RELEASE，核对 ZIP 与驱动二进制 SHA-256，
然后复制到当前文件夹 `EFI/OC/Kexts/SimpleHDA.kext`。
无需 sudo，不挂载 EFI 分区，不安装系统驱动，不重建缓存。
如果该目录已有 SimpleHDA，脚本停止而不会覆盖。

### Windows 或手动准备

从 [SimpleHDA v1.0.0](https://github.com/laobamac/SimpleHDA/releases/tag/v1.0.0)
下载 `SimpleHDA-Tahoe-v1.0.0-RELEASE.zip`，将其中的完整 `SimpleHDA.kext` 文件夹复制进 `EFI/OC/Kexts/`。
不要使用 DEBUG 包，也不要把 kext 的 Contents 文件夹单独拷进去。

原包 SHA-256：

```text
89198256664078c91155d673ee7cebb08134dad1b71d5e34b0aa4ef0d4877f8f
```

## 3. 填写自己的 SMBIOS 身份

使用 OpenCore 官方 macserial 或 [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS) 为 `MacBookPro16,2` 生成独立信息。
编辑 `EFI/OC/config.template.plist` 的 `PlatformInfo -> Generic`：

| 字段 | 应填写 |
| --- | --- |
| SystemSerialNumber | 自己生成的序列号 |
| MLB | 配套的主板序列号 |
| SystemUUID | 自己生成的 UUID |
| ROM | 自己机器的稳定网络接口 MAC，保存为 6 字节 Data，不含冒号 |

填写后另存为 `EFI/OC/config.plist`。本包没有可直接复用的身份。
保持 `SystemProductName=MacBookPro16,2`，不要为清除身份而随意改机型。
用 **OpenCore 1.0.8** 对应的 ocvalidate 再校验填写后的 config。

## 4. 启动条件与系统侧驱动

- 本机已开启独显直连，这是当前显示方案的实测前提。
- BIOS 的其他精确版本与设置尚未完整记录，不把通用建议冒充本机已测设置。
- 从备用 U 盘 EFI 启动 macOS Tahoe。
- NVIDIA：使用官方 1401 为当前 macOS 安装匹配驱动。仅复制 EFI 不会安装 NVRM/NVAccel/用户态组件。
- 有线：单独安装作者修复的 YT6801 1.0.13 DEXT；本 config **没有 dk 参数**。
- 声音：使用包内的定制 AppleALC 与补齐的 SimpleHDA，保留 layout 21 和三条 Darwin 25 补丁。
- Wi-Fi：已配置 Tahoe 专用 AirportItlwm alpha，不另外同时启用 itlwm。

如果原系统曾加载 VoodooHDA 或其他恢复 AppleHDA 的方案，应先按对应上游方法处理冲突。
不要在未确定当前实际音频提供者时批量卸载驱动或重建缓存。

## 5. 验收与部署

确认正常启动、显卡流畅、实际亮度、Wi-Fi/有线、扬声器/麦克风和触控板。
测试外接显示与 USB 时逐个记录；睡眠尚未修复，不用反复触发睡死来验证日常使用。
验证后再按自己的磁盘布局部署 EFI；不能直接照抄别人的 disk0/disk1 编号。

进入系统后可运行 `sysctl -n kern.bootargs` 核对当前启动参数。
当前模板 `Misc -> Debug -> Target=3`，没有 0x40 文件日志位，应不再生成 OpenCore 普通启动日志文件。
