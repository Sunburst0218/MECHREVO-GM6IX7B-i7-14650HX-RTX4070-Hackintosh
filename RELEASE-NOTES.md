# v0.2.0-preview — 本机USB映射与状态更新

机械革命耀世16 Pro GM6IX7B / i7-14650HX / RTX4070 Laptop / OpenCore1.0.8。

- 加入本机定制UTBMap，USBToolBox配合加载，禁用UTBDefault；主控制器12项、第二控制器4项。
- 用户与运行报告确认映射已加载使用；全部Type-C方向、USB3速率和雷雳功能仍未完整验收。
- 补录Tahoe26.7.1 /25G241、NVIDIA2.5.4实测组合。
- 地图定位开启隐私授权后正常，App Store已能登录下载；扬声器/麦克风及原有关机爆音保持用户已确认结果。
- 整机睡眠/唤醒仍失败，电源灯恢复常亮不代表桌面恢复；本版本不含禁用GPU、限制NVRAM写入或S4实验。

## 使用前必须准备

1. 阅读INSTALL.md，从原作者补齐SimpleHDA（包内Prepare-EFI.command提供固定下载与校验）。
2. 为MacBookPro16,2生成自己的Serial、MLB、UUID、ROM，填写config.template.plist并另存为config.plist，再用同版ocvalidate校验。
3. 使用备用U盘测试。附件不包含发布者的个人02号身份，也不提供所有人共用的随机三码。

从本Release下载EFI ZIP及SHA256SUMS.txt；仓库源码ZIP不是可直接启动EFI。
