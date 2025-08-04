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
    cp target/release/sidecar.exe ../dist/sidecar-windows.exe
    echo "✅ 构建完成: sidecar-windows.exe"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ARCH=$(uname -m)
    if [ "$ARCH" = "arm64" ]; then
        cp target/release/sidecar ../dist/sidecar-macos-arm64
    else
        cp target/release/sidecar ../dist/sidecar-macos-intel
    fi
    chmod +x ../dist/sidecar-macos-*
    echo "✅ 构建完成: sidecar-macos-$ARCH"
else
    cp target/release/sidecar ../dist/sidecar-linux
    chmod +x ../dist/sidecar-linux
    echo "✅ 构建完成: sidecar-linux"
fi

cd ..
ls -lh dist/sidecar-*
