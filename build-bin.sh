#!/bin/bash

echo "🚀 构建 GUI 二进制文件（极简版）"

# 准备环境
mkdir -p empty_dist
echo "<!DOCTYPE html><html><body></body></html>" > empty_dist/index.html

# 进入 src-tauri 目录
cd src-tauri || exit 1

# 构建
echo "构建中..."
cargo build --release

# 复制二进制文件
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    cp target/release/gui.exe ../dist/gui-windows.exe
    echo "✅ 构建完成: gui-windows.exe"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ARCH=$(uname -m)
    if [ "$ARCH" = "arm64" ]; then
        cp target/release/gui ../dist/gui-macos-arm64
    else
        cp target/release/gui ../dist/gui-macos-intel
    fi
    chmod +x ../dist/gui-macos-*
    echo "✅ 构建完成: gui-macos-$ARCH"
else
    cp target/release/gui ../dist/gui-linux
    chmod +x ../dist/gui-linux
    echo "✅ 构建完成: gui-linux"
fi

cd ..
ls -lh dist
