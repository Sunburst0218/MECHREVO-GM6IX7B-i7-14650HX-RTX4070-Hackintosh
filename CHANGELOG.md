# Changelog

## v0.2.0-preview · 2026-10-25

- 基于用户当天导出的正常EFI更新，不含睡眠实验参数。
- 加入本机UTBMap（主控制器12项、第二控制器4项），UTBDefault禁用，XhciPortLimit=false；记录实机加载验证和USB测试边界。
- 补录实机macOS Tahoe 26.7.1 / 25G241、NVIDIA2.5.4。
- 更新地图定位和App Store登录/下载为用户已确认正常。
- 睡眠/唤醒仍未解决，保留0x1F失败事实，不发布未经验证的修复承诺。
- 公开模板继续去除三码和ROM，要求接收者安装前生成独立身份；不提供共用随机三码。
- 保留SimpleHDA从原作者固定版本取得的准备流程，以及其他第三方许可。


## v0.1.0-preview · 2026-10-25

首次公开分享，以这台 GM6IX7B 当前实际使用的最新 EFI 为基线。

- OpenCore 1.0.8 RELEASE，MacBookPro16,2，公开模板去除个人身份。
- 保留已验证的独显直连、RTX 4070 Laptop、240 Hz 与实际亮度控制配置。
- 保留 AX211 Tahoe AirportItlwm 2.4.0 alpha，按 Darwin 25 加载。
- YT6801 1.0.13 系统侧驱动修复后不再需要 dk=0x8001，公开配置不含该参数。
- 保留 SN6140 14F1:1F87、layout 21、定制 PinConfig 与三条 Darwin 25 声音补丁。
- 用户确认扬声器、麦克风可用，当前反馈未再复现原有关机/重启爆音。
- 保留触控板与摄像头当前方案。
- 关闭普通 OpenCore 文件日志：Target=3。
- 排除历史 config 备份、AppleDouble 元数据和个人硬件报告。
- 第三方组件未统一升级；SimpleHDA 从作者固定版本补齐并校验，不重复捆绑。
- 标注睡眠/唤醒、地图当前位置、摄像头个别应用与未验收外设的限制。
