@echo off
rem DeepSeek Harness 便携版 —— 一键启动
rem 要求:本目录包含 node\ 和 app\ (由 build.bat 生成)
title DeepSeek Harness 一键启动
cd /d "%~dp0"
if not exist "node\node.exe" (
  echo [错误] 缺少 node\ 运行时,请先运行 build.bat 构建
  pause
  exit /b 1
)
if not exist "app\node_modules\.bin\dsh.cmd" (
  echo [错误] 缺少 app\ 组件,请先运行 build.bat 构建
  pause
  exit /b 1
)
start "" /min cmd /c "node\node.exe launch.js"
