# GitHub Actions 工作流

## build.yml

自动构建跨平台 Tauri 应用的工作流。

### 功能特性

- ✅ 支持 Windows x64、macOS (Intel & Apple Silicon)、Linux x64
- ✅ 自动缓存依赖以加速构建
- ✅ 生成便携版应用包
- ✅ 自动创建 GitHub Releases
- ✅ 上传构建产物为 Artifacts

### 触发条件

- 推送到 `main` 或 `master` 分支
- 创建 Pull Request
- 手动发布 Release

### 构建矩阵

| 平台 | 运行环境 | 目标架构 |
|------|----------|----------|
| Windows x64 | windows-latest | x86_64-pc-windows-msvc |
| macOS Intel | macos-latest | x86_64-apple-darwin |
| macOS Apple Silicon | macos-latest | aarch64-apple-darwin |
| Linux x64 | ubuntu-latest | x86_64-unknown-linux-gnu |

### 输出产物

每个平台会生成对应的安装包：

- **Windows**: `.exe`, `.msi`
- **macOS**: `.app`, `.dmg`  
- **Linux**: `.deb`, `.AppImage`

所有构建产物会作为 GitHub Artifacts 保存 30 天，并在推送到主分支时自动创建 Release。
