#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

// 简化的入口点，委托给库函数
fn main() {
    sidecar_lib::run();
}
