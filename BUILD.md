# 构建说明

## 🚀 自动构建

本项目已配置 GitHub Actions 自动构建工作流，支持以下平台：

- **Windows (x64)** - `x86_64-pc-windows-msvc`
- **macOS (Intel)** - `x86_64-apple-darwin`  
- **macOS (Apple Silicon)** - `aarch64-apple-darwin`
- **Linux (x64)** - `x86_64-unknown-linux-gnu`

### 触发构建

构建会在以下情况自动触发：

1. **推送到主分支** (`main` 或 `master`) - 会创建发布版本
2. **Pull Request** - 仅构建，不发布
3. **手动发布** - 通过 GitHub Releases

### 构建产物

每次构建会生成以下便携版应用：

- `windows-x86_64-portable` - Windows 可执行文件和安装包
- `macos-x86_64-portable` - macOS Intel 版本应用包
- `macos-aarch64-portable` - macOS Apple Silicon 版本应用包  
- `linux-x86_64-portable` - Linux 可执行文件和包

## 🛠️ 本地构建

### 前置要求

1. **Node.js** (推荐 v20+)
2. **pnpm** 包管理器
3. **Rust** 工具链
4. **平台特定依赖**：
   - **Linux**: `libwebkit2gtk-4.1-dev libappindicator3-dev librsvg2-dev patchelf`
   - **macOS**: Xcode Command Line Tools
   - **Windows**: Microsoft C++ Build Tools

### 安装依赖

```bash
# 安装前端依赖
pnpm install

# 安装 Rust 目标平台（可选，用于交叉编译）
rustup target add x86_64-pc-windows-msvc
rustup target add x86_64-apple-darwin
rustup target add aarch64-apple-darwin
rustup target add x86_64-unknown-linux-gnu
```

### 开发模式

```bash
# 启动开发服务器
pnpm run tauri:dev
```

### 构建生产版本

```bash
# 构建当前平台
pnpm run tauri:build

# 构建指定平台（交叉编译）
pnpm run tauri build -- --target x86_64-pc-windows-msvc
pnpm run tauri build -- --target x86_64-apple-darwin
pnpm run tauri build -- --target aarch64-apple-darwin
pnpm run tauri build -- --target x86_64-unknown-linux-gnu
```

## 📁 构建输出

构建完成后，可执行文件和安装包位于：

```
src-tauri/target/[target]/release/bundle/
├── deb/           # Linux .deb 包
├── dmg/           # macOS .dmg 文件
├── msi/           # Windows .msi 安装包
├── nsis/          # Windows NSIS 安装程序
└── appimage/      # Linux AppImage
```

## 🔧 自定义配置

### 修改应用信息

编辑 `src-tauri/tauri.conf.json`：

```json
{
  "productName": "你的应用名称",
  "version": "1.0.0",
  "identifier": "com.yourcompany.yourapp"
}
```

### 添加构建目标

在 `.github/workflows/build.yml` 中的 `matrix.include` 部分添加新的平台配置。

### 修改图标

替换 `src-tauri/icons/` 目录下的图标文件，支持的格式：
- PNG: 32x32, 128x128, 128x128@2x
- ICO: Windows 图标
- ICNS: macOS 图标

## 🚨 常见问题

### 构建失败

1. **检查依赖** - 确保所有平台依赖已安装
2. **检查 Rust 版本** - 使用最新稳定版 Rust
3. **检查图标文件** - 确保所有必需的图标文件存在
4. **检查权限** - 确保 GitHub Actions 有足够权限创建 Release

### 跨平台编译问题

某些依赖可能不支持交叉编译，建议在对应平台上进行本地构建。

## 📝 更新日志

构建工作流会自动生成发布说明，包含：
- 提交信息
- 构建时间
- 下载链接
- 平台支持信息
