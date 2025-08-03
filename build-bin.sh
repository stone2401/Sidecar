#!/bin/bash

echo "🔨 构建 GUI 二进制文件"

# 检查环境
if ! command -v cargo &> /dev/null; then
    echo "❌ 未找到 Rust/Cargo，请先安装"
    exit 1
fi

# 创建必要目录
mkdir -p empty_dist
echo "<!DOCTYPE html><html><body></body></html>" > empty_dist/index.html

# 进入 src-tauri 目录
cd src-tauri || { echo "❌ src-tauri 目录不存在"; exit 1; }

# 获取当前系统的目标三元组
TARGET=$(rustc -vV | sed -n 's|host: ||p')
echo "🎯 目标平台: $TARGET"

# 构建
echo "🚀 开始构建..."
cargo build --release --target "$TARGET"

# 检查构建结果
BINARY_NAME="gui"
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    BINARY_NAME="gui.exe"
fi

BINARY_PATH="target/$TARGET/release/$BINARY_NAME"

if [ -f "$BINARY_PATH" ]; then
    echo "✅ 构建成功！"
    echo "📍 二进制文件位置: $BINARY_PATH"
    echo "📏 文件大小: $(ls -lh "$BINARY_PATH" | awk '{print $5}')"
    
    # 创建输出目录
    mkdir -p ../dist
    cp "$BINARY_PATH" "../dist/gui-$TARGET$([[ $BINARY_NAME == *.exe ]] && echo .exe)"
    
    echo "📦 已复制到: dist/gui-$TARGET$([[ $BINARY_NAME == *.exe ]] && echo .exe)"
else
    echo "❌ 构建失败，未找到二进制文件"
    echo "查找路径: $BINARY_PATH"
    exit 1
fi
