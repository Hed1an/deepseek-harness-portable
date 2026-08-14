@echo off
rem ============================================================
rem  DeepSeek Harness 便携版 —— 一键构建脚本
rem  用法:双击本文件,自动完成:下载 Node → 安装 dsh → 打包 zip
rem  产物输出到 dist\ 目录
rem ============================================================
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo [1/4] 下载便携 Node.js v24.18.0 ...
powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://nodejs.org/dist/v24.18.0/node-v24.18.0-win-x64.zip' -OutFile node.zip"
if errorlevel 1 goto :fail
tar -xf node.zip
if errorlevel 1 goto :fail
if exist node rmdir /s /q node
move /y node-v24.18.0-win-x64 node >nul
del node.zip

echo [2/4] 安装 dsh(含 Windows 原生模块)...
if not exist app mkdir app
> app\.npmrc echo allow-scripts[]=@deepseek-ai/dsh-subprocess-local
>> app\.npmrc echo allow-scripts[]=koffi
>> app\.npmrc echo allow-scripts[]=node-pty
>> app\.npmrc echo allow-scripts[]=@google/genai
>> app\.npmrc echo allow-scripts[]=protobufjs
node\node.exe node\node_modules\npm\bin\npm-cli.js install --prefix ./app @deepseek-ai/dsh
if errorlevel 1 goto :fail

echo [3/4] 打包 dist\dsh-portable.zip ...
if not exist dist mkdir dist
powershell -NoProfile -Command "$v=(Get-Content 'app\node_modules\@deepseek-ai\dsh\package.json' | ConvertFrom-Json).version; $items=@('node','app','launch.js','启动 DeepSeek Harness.bat','README.md','LICENSE'); $existing=$items | Where-Object { Test-Path $_ }; Compress-Archive -Path $existing -DestinationPath \"dist\dsh-portable-$v.zip\" -Force; Write-Host \"-> dist\dsh-portable-$v.zip\""
if errorlevel 1 goto :fail

echo [4/4] 完成!产物在 dist\ 目录,解压后双击「启动 DeepSeek Harness.bat」即可使用。
pause
exit /b 0

:fail
echo [错误] 构建失败,请检查网络后重试。
pause
exit /b 1
