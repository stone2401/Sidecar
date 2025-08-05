#!/bin/bash

echo "🚀 设置 Sidecar 项目环境"

# 创建必要目录
mkdir -p empty_dist
mkdir -p src-tauri/icons

# 创建占位文件
echo "<!DOCTYPE html><html><head><title>Placeholder</title></head><body><!-- Tauri 动态加载占位文件 --></body></html>" > empty_dist/index.html

# 检查必要文件
files_to_check=(
    "src-tauri/Cargo.toml"
    "src-tauri/tauri.conf.json"
    "src-tauri/src/main.rs"
    "src-tauri/build.rs"
)

for file in "${files_to_check[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ 缺少文件: $file"
    else
        echo "✅ 文件存在: $file"
    fi
done

# 安装依赖
echo "📦 安装依赖..."
pnpm install

echo "✅ 环境设置完成！"
echo "💡 使用 'pnpm tauri dev' 启动开发服务器"
echo "💡 使用 'pnpm tauri build' 构建应用"
