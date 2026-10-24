# Filee 一键安装指南

> 第三方部署指南 · 非 Filee 官方仓库。官方项目：[KnifeLemon/Filee](https://github.com/KnifeLemon/Filee)
> 内容来自官方文档（2026-10-24）。项目迭代快，请以[官方文档](https://github.com/KnifeLemon/Filee/blob/main/README.md)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己找安装包，让百度搭子按你的系统下载、校验并装好。

⚠️ 支持 Windows 10/11、macOS 13+（预览）、Linux x64/ARM64（Ubuntu 22.04+）。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/filee-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按你的系统下载对应的官方安装包、校验 SHA256 并执行安装，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## Filee 是什么？

Filee 是开源的拖拽即转换的离线文件转换器（协议：MIT，<img src="https://img.shields.io/github/stars/KnifeLemon/Filee?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

按住 Ctrl（macOS 为 Option）拖入文件，在鼠标旁的格式圆环上松手即可转换；覆盖 255+ 格式，全部在本地完成，不上传文件。

- 支持平台：Windows 10/11、macOS 13+（预览）、Linux x64/ARM64（Ubuntu 22.04+）
- 转换范围：图片、PDF、Office、HWP/HWPX、视频、音频、电子书、压缩包、字体、CAD、3D、地理数据
- 完全离线：文件不上传，转换结果保存在原文件旁
- 附带命令行：安装后可用 `filee` 命令

（来源：[官方仓库](https://github.com/KnifeLemon/Filee)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 255+ 格式 | 图片、PDF、Office、HWP/HWPX、视频、音频、电子书、压缩包等 |
| 完全本地 | 文件不上传，离线也能用 |
| 不依赖 Office | 无需 Office、Hancom Office 或 LibreOffice |
| 三平台 + 开源 | Windows / Linux / macOS，MIT 协议 |

| 需要注意 | 说明 |
|---|---|
| macOS 仍是预览 | 构建尚未公证，首次启动要手动放行 |
| Linux 平台限制 | 仅 Ubuntu 22.04+；拖拽手势需要 X11，Wayland 下受限 |
| 安装包较大 | 各平台约 113–147 MB |
| 老 Windows 10 可能启动失败 | 与 CET 冲突，需要先装最新系统更新 |

> 以上基于官方文档与社区反馈整理（2026-10-24），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
BASE=https://github.com/KnifeLemon/Filee/releases/download/v2.0.0
if [ "$(uname -s)" = "Darwin" ]; then
  if [ "$(uname -m)" = "arm64" ]; then PLAT=osx-arm64; else PLAT=osx-x64; fi
else
  if [ "$(uname -m)" = "aarch64" ] || [ "$(uname -m)" = "arm64" ]; then PLAT=linux-arm64; else PLAT=linux-x64; fi
fi
curl -fLO "$BASE/Filee-2.0.0-$PLAT.tar.gz"
curl -fLO "$BASE/Filee-2.0.0-$PLAT-SHA256SUMS.txt"
if command -v sha256sum >/dev/null 2>&1; then grep "  Filee-2.0.0-$PLAT.tar.gz$" "Filee-2.0.0-$PLAT-SHA256SUMS.txt" | sha256sum -c -; else grep "  Filee-2.0.0-$PLAT.tar.gz$" "Filee-2.0.0-$PLAT-SHA256SUMS.txt" | shasum -a 256 -c -; fi
tar -xzf "Filee-2.0.0-$PLAT.tar.gz"
INSTALL_SH=$(find . -maxdepth 2 -name install.sh | head -n 1)
[ -n "$INSTALL_SH" ] || { echo "安装包里没有找到 install.sh"; exit 1; }
( cd "$(dirname "$INSTALL_SH")" && ./install.sh )
```

安装包来源：[https://github.com/KnifeLemon/Filee/releases/tag/v2.0.0](https://github.com/KnifeLemon/Filee/releases/tag/v2.0.0)

## 验证状态

| 场景 | 状态 |
|---|---|
| Windows 下载 + SHA256 校验 | 已验证 2026-10-24 |
| Windows 静默安装 | 已验证 2026-10-24 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

Filee 自身不含 MCP，但提供 `filee` 命令行，可在安装后用于转换文件。本仓库的 MCP 只提供安装步骤、平台支持与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-24）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\filee-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装后怎么用

- Windows：开始菜单搜索 Filee；安装包同时提供 `filee` 命令
- macOS / Linux：`install.sh` 会带上 `filee` 命令
- 基本用法：按住 Ctrl（macOS 为 Option）拖入文件，在鼠标旁的格式圆环上选目标格式

macOS 构建尚未公证：首次打开若被系统拦截，到「系统设置 → 隐私与安全性」点「仍要打开」。

## 常见坑

- Windows 双击后无窗口也无报错：老版本 Windows 10 与 CET 冲突，先装最新累积更新；仍不行按官方说明执行 `Set-ProcessMitigation -Name Filee.exe -Disable UserShadowStack`（需管理员）
- macOS 构建未公证，首次启动需到「系统设置 → 隐私与安全性」点「仍要打开」
- Linux 拖拽手势需要 X11；Wayland 下改用拖放区或文件管理器右键菜单
- Linux / macOS 的 `install.sh` 不需要 root，但需要 Python 3
- 安装过程若弹出 UAC 授权窗口，需要手动点「是」

## 免责声明

本仓库为第三方指南，与 Filee 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-24），项目迭代快，请以[官方文档](https://github.com/KnifeLemon/Filee/blob/main/README.md)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
