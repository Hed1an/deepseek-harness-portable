# DeepSeek Harness 便携版 (Portable)

> 一键部署 DeepSeek Harness Web UI —— 免安装 Node.js,免命令行,双击即用。

把 [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness)(`dsh`)的 Web UI 和
Node.js 运行时打包成一个绿色文件夹,**目标电脑什么都不用装**。

## ✨ 特性

- 🚀 **一键启动**:双击 `启动 DeepSeek Harness.bat`,自动找空闲端口、自动打开浏览器
- 🟢 **绿色便携**:自带 Node v24 运行时,数据全存包内 `data\` 目录,不污染系统
- 🔌 **零依赖**:无需安装 Node.js / npm / 任何命令行工具
- 🔄 **自动更新**:启动时自动检查 npm 新版本并提示(可选)

## 🖥️ 想要"桌面应用"?(桌面版)

除了浏览器 Web UI 的便携版,同款产品还有一个 **Electron 桌面版**——独立原生窗口、黑金主题、托盘常驻、开机自启、自动更新:

[**goldfish-desktop**](https://github.com/Hed1an/goldfish-desktop) → 下载 `DeepSeek-Harness-Desktop-Setup-*.exe` 双击安装即可。

| | 便携版(本仓库) | 桌面版(goldfish-desktop) |
|---|---|---|
| 形态 | 浏览器 Web UI | Electron 原生窗口 |
| 安装 | 解压即用(zip) | 安装包 `.exe` |
| 数据 | 包内 `data\` | `%APPDATA%\...` |
| 升级 | 解压覆盖 | 自动更新 |
| 适合 | 绿色免安装 / U盘带走 | 原生应用感 / 自动更新 |

> 两种形态同一套 dsh 内核,按使用习惯二选一即可。

## 📦 快速开始

1. 下载最新版 `dsh-portable-*.zip`(见右侧 **Releases**)
2. 解压到任意目录(路径不要含中文/空格更稳妥)
3. 双击 **`启动 DeepSeek Harness.bat`**
4. 浏览器自动打开 `http://127.0.0.1:3080`
5. 首次使用:Settings → 模型 → 填入 DeepSeek API Key → 选择工作区 → 开聊

> 想要"桌面应用"体验:用 Chrome/Edge 打开后,地址栏 ⋯ →「将此页面安装为应用」,即生成独立窗口和桌面图标。

## 🛠 从源码构建

```bat
git clone https://github.com/Hed1an/deepseek-harness-portable.git
cd deepseek-harness-portable
build.bat
```

自动完成:下载便携 Node → 安装 dsh → 打包 zip 到 `dist\`。

## 📁 目录结构

```
dsh-portable/
├── 启动 DeepSeek Harness.bat   # 一键启动入口
├── launch.js                    # 启动器:找端口/起服务/开浏览器
├── build.bat                    # 一键构建(重新打包)
├── node/                        # 便携 Node.js 运行时(构建生成)
├── app/                         # dsh 及依赖(构建生成)
└── data/                        # 你的数据:配置/Key/会话(运行时生成,备份它即可迁移)
```

## ❓ 常见问题

- **端口被占用?** 启动器自动改用下一个空闲端口,浏览器会打开实际端口。
- **如何备份?** 复制 `data\` 目录即可(含 API Key 配置与会话记录)。
- **如何升级?** 下载新版 zip 解压覆盖,`data\` 目录保留即可无损升级。
- **API Key 存哪?** 只存在你本机 `data\` 内,不上传、不联网收集。

## 📄 License

MIT — 基于 [deepseek-ai/deepseek-harness](https://github.com/deepseek-ai/deepseek-harness)(MIT)。
