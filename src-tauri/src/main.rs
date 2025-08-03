#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use clap::Parser;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// 要加载的 URL
    #[arg(short, long, default_value = "https://tauri.app")]
    url: String,
    
    /// 窗口标题
    #[arg(short, long, default_value = "动态 GUI")]
    title: String,
    
    /// 窗口宽度
    #[arg(short, long, default_value_t = 1024.0)]
    width: f64,
    
    /// 窗口高度
    #[arg(short, long, default_value_t = 768.0)]
    height: f64,
}

fn main() {
    let args = Args::parse();
    
    tauri::Builder::default()
        .setup(move |app| {
            let url = match args.url.parse() {
                Ok(u) => u,
                Err(e) => {
                    eprintln!("无效的 URL '{}': {}", args.url, e);
                    std::process::exit(1);
                }
            };
            
            let _webview_window = tauri::WebviewWindowBuilder::new(
                app,
                "main",
                tauri::WebviewUrl::External(url)
            )
            .title(&args.title)
            .inner_size(args.width, args.height)
            .build()?;
            
            println!("窗口 '{}' 已创建", args.title);
            println!("URL: {}", args.url);
            println!("尺寸: {}x{}", args.width, args.height);

            Ok(())
        })
        .invoke_handler(tauri::generate_handler![])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
