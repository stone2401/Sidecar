mod config;
mod window;

use config::AppConfig;
use window::WindowManager;

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    // 解析命令行参数
    let config = AppConfig::parse_args();
    
    // 验证配置
    if let Err(e) = config.validate() {
        eprintln!("{}", e);
        std::process::exit(1);
    }
    
    tauri::Builder::default()
        .setup(move |app| {
            // 创建窗口
            WindowManager::create_window(app, &config)?;
            Ok(())
        })
        .plugin(tauri_plugin_opener::init())
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
