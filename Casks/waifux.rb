cask "waifux" do
  version "38.0.149"
  sha256 "eafb7293b99bce22da27bdd6de7df48ed24c25acc1780c213e5a2ea310b422bb"

  url "https://github.com/jipika/WaifuX/releases/download/v38.0.149/WaifuX.dmg"
  name "WaifuX"
  desc "Beautiful anime wallpaper and content browser"
  homepage "https://github.com/jipika/WaifuX"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  auto_updates true

  app "WaifuX.app"

  # brew 更新是先删旧 bundle 再拷新 bundle，macOS 会重置扩展启用状态。
  # lsregister -f 重新注册 App bundle（含内嵌 .appex）。
  # 注意：brew 6 起 postflight_steps 的 run 在 Homebrew 沙箱内执行，
  # 系统守护进程会拒绝沙箱客户端：pkd 拒绝 pluginkit 的 PKDiscoverAll 全量发现，
  # lsregister 的 Spotlight 扫描在部分机器上也会 -10822 失败；
  # killall 在 WallpaperAgent 未运行时同样 exit 1。
  # 三步都标记 must_succeed: false 作为尽力而为的兜底，避免误伤整个安装；
  # 扩展注册/启用还有 App 启动时 LaunchServices 的自动注册兜底。
  postflight_steps do
    run "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister",
      args: ["-f", "{{staged_path}}/WaifuX.app"],
      must_succeed: false,
      print_stderr: false
    run "/usr/bin/pluginkit",
      args: ["-e", "use", "-i", "com.waifux.app.wallpaperextension"],
      must_succeed: false,
      print_stderr: false
    run "/usr/bin/killall",
      args: ["WallpaperAgent"],
      print_stderr: false,
      must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/WaifuX",
    "~/Library/Caches/com.waifux.app",
    "~/Library/Preferences/com.waifux.app.plist",
    "~/Library/Saved Application State/com.waifux.app.savedState",
  ]
end
