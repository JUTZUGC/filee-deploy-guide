#!/usr/bin/env bash
set -euo pipefail
# Filee 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/KnifeLemon/Filee/blob/main/README.md
# 更新日期：2026-10-28
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

BASE=https://github.com/KnifeLemon/Filee/releases/download/v2.2.0
if [ "$(uname -s)" = "Darwin" ]; then
  if [ "$(uname -m)" = "arm64" ]; then PLAT=osx-arm64; else PLAT=osx-x64; fi
else
  if [ "$(uname -m)" = "aarch64" ] || [ "$(uname -m)" = "arm64" ]; then PLAT=linux-arm64; else PLAT=linux-x64; fi
fi
curl -fLO "$BASE/Filee-2.2.0-$PLAT.tar.gz"
curl -fLO "$BASE/Filee-2.2.0-$PLAT-SHA256SUMS.txt"
if command -v sha256sum >/dev/null 2>&1; then grep "  Filee-2.2.0-$PLAT.tar.gz$" "Filee-2.2.0-$PLAT-SHA256SUMS.txt" | sha256sum -c -; else grep "  Filee-2.2.0-$PLAT.tar.gz$" "Filee-2.2.0-$PLAT-SHA256SUMS.txt" | shasum -a 256 -c -; fi
tar -xzf "Filee-2.2.0-$PLAT.tar.gz"
INSTALL_SH=$(find . -maxdepth 2 -name install.sh | head -n 1)
[ -n "$INSTALL_SH" ] || { echo "安装包里没有找到 install.sh"; exit 1; }
( cd "$(dirname "$INSTALL_SH")" && ./install.sh )

echo ""

echo "安装完成：Windows 在开始菜单搜索 Filee；macOS / Linux 可用 filee 命令"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/KnifeLemon/Filee/blob/main/README.md"
