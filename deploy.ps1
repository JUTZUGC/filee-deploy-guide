# Filee 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/KnifeLemon/Filee/blob/main/README.md
# 更新日期：2026-10-24
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -fLO https://github.com/KnifeLemon/Filee/releases/download/v2.0.0/Filee-2.0.0-win-Setup.exe
curl.exe -fLO https://github.com/KnifeLemon/Filee/releases/download/v2.0.0/Filee-2.0.0-SHA256SUMS.txt
$expected = ((Select-String -Path Filee-2.0.0-SHA256SUMS.txt -Pattern 'Filee-2.0.0-win-Setup.exe').Line -split '\s+')[0].ToLower()
$actual = (Get-FileHash -Algorithm SHA256 -Path Filee-2.0.0-win-Setup.exe).Hash.ToLower()
if ($actual -ne $expected) { throw 'SHA256 校验失败，请重新下载' }
Start-Process -FilePath .\Filee-2.0.0-win-Setup.exe -ArgumentList '/VERYSILENT','/SUPPRESSMSGBOXES','/NORESTART' -Wait

Write-Host ''

Write-Host '安装完成：Windows 在开始菜单搜索 Filee；macOS / Linux 可用 filee 命令'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/KnifeLemon/Filee/blob/main/README.md'
