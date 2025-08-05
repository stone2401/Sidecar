use clap::Parser;

/// 应用程序配置参数
#[derive(Parser, Debug, Clone)]
#[command(author, version, about, long_about = None)]
pub struct AppConfig {
    /// 要加载的 URL
    #[arg(short, long, default_value = "https://tauri.app")]
    pub url: String,
    
    /// 窗口标题
    #[arg(short, long, default_value = "Sidecar")]
    pub title: String,
    
    /// 窗口宽度
    #[arg(short = 'W', long, default_value_t = 1024.0)]
    pub width: f64,
    
    /// 窗口高度
    #[arg(short = 'H', long, default_value_t = 768.0)]
    pub height: f64,

    /// 是否自动调整窗口大小
    #[arg(short = 'A', long, default_value_t = false)]
    pub auto_resize: bool,
}

impl AppConfig {
    /// 解析命令行参数
    pub fn parse_args() -> Self {
        Self::parse()
    }

    /// 验证配置参数
    pub fn validate(&self) -> Result<(), String> {
        // 验证 URL 格式
        if let Err(e) = self.url.parse::<url::Url>() {
            return Err(format!("无效的 URL '{}': {}", self.url, e));
        }
        
        // 验证窗口尺寸
        if self.width <= 0.0 {
            return Err("窗口宽度必须大于 0".to_string());
        }
        
        if self.height <= 0.0 {
            return Err("窗口高度必须大于 0".to_string());
        }
        
        Ok(())
    }
}
