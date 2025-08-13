## 使用说明
### 安装
1. 打开下载完成的`AmethystRainbowV🔢.exe`
2. 根据安装器内容提示继续
3. 安装建议按顺序依次进行
   - 下载官方 Java 版 -> 安装 Zerotier -> 安装 Fabric -> 安装 Mods
4. 安装`1.21.1`版本
    - 官方启动器 -> 配置 -> 新配置 -> 版本 -> 选择`1.21.1`
      - 显示更多选项 -> JVM 参数 -> 调整 `-Xmx2G` 为 `-Xmx5G` 或更大
5. Fabric 安装完成后关闭 **Fabric Installer** 窗口即可
6. 完成后启动官方启动器，选择`fabric-loader-1.21.1`开始游戏

> [!TIP]
> 为了节约流量及过滤用户，加入服务器需要授权 Zerotier 虚拟局域网访问，
> 请在加入 [Discord](https://discord.gg/J5ERpVA5) 或 [QQ 群](https://qm.qq.com/q/eLQhn5RmpO)

> [!CAUTION]
> - 安装 Fabric Loader 之前应关闭官方启动器
> - JVM 参数内存默认分配 2 GB 会造成游戏闪退`-Xmx2G`表示最大内存占用`2 GB
> - 不建议随意调整 JVM 参数，可能导致无法启动、闪退、卡顿等问题
> - **调整现有配置**的 JVM 参数
>   - 启动器 -> 配置 -> fabric-loader-1.21.1 -> 右侧三个点`打开` -> 选择`编辑` -> 最下方点`显示更多选项`
> - JVM 参数也可参考其他的完整启动参数
>   - `-Xms6G -Xmx6G -XX:+UseZGC -XX:+ZGenerational`

### 更新
一般情况不需要更新 Zerotier，只需更新 Fabric 和 Mods

![安装介绍及步骤-Updated-V78](https://github.com/user-attachments/assets/0ad59bef-920f-4126-b76d-dd984809955a)

> [!IMPORTANT]
> [ins.exe](ThirdParty/Fabric/ins.exe)来自于[fabric-installer-1.0.1.exe](https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.1/fabric-installer-1.0.1.exe) [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh-hans)

> [!IMPORTANT]
> [tailscale.msi]("ThirdParty/Tailscale/tailscale.msi")来自于[tailscale-setup-latest.exe](https://pkgs.tailscale.com/stable/tailscale-setup-latest.exe) [Legal](https://tailscale.com/legal) [BSD-3-Clause](https://github.com/tailscale/tailscale?tab=BSD-3-Clause-1-ov-file#readme)

> [!IMPORTANT]
> [ZeroTierOne.msi]("ThirdParty/Zerotier/ZeroTierOne.msi")来自于[ZeroTier One.msi](https://download.zerotier.com/dist/ZeroTier%20One.msi) [BSL 1.1](https://github.com/zerotier/ZeroTierOne?tab=License-1-ov-file#)
