use tauri::{App, WebviewUrl, WebviewWindowBuilder};

use crate::config::AppConfig;

/// 窗口管理器
pub struct WindowManager;

impl WindowManager {
    /// 根据配置创建窗口
    pub fn create_window(app: &App, config: &AppConfig) -> Result<(), Box<dyn std::error::Error>> {
        // 解析 URL
        let url = config.url.parse::<url::Url>()
            .map_err(|e| format!("无效的 URL '{}': {}", config.url, e))?
            .into();
        
        // 创建窗口构建器
        let mut webview_window = WebviewWindowBuilder::new(
            app,
            "main",
            WebviewUrl::External(url)
        )
        .title(&config.title)
        .inner_size(config.width, config.height);

        // 应用配置
        if config.auto_resize {
            webview_window = webview_window.auto_resize();
        }

        // 构建窗口
        webview_window.build()?;
        
        // 打印窗口信息
        Self::print_window_info(config);
        
        Ok(())
    }

    /// 打印窗口信息
    fn print_window_info(config: &AppConfig) {
        println!("窗口 '{}' 已创建", config.title);
        println!("URL: {}", config.url);
        println!("尺寸: {}x{}", config.width, config.height);
        println!("自动调整窗口大小: {}", config.auto_resize);
    }
}
