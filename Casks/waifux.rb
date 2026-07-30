cask "waifux" do
  version "38.0.140"
  sha256 "15b673bc413d87b4a7966ca5df0b21ea26fc0288b11482f0c1e30f3947122a34"

  url "https://github.com/jipika/WaifuX/releases/download/v38.0.140/WaifuX.dmg"
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
  # lsregister -f 重新注册 App bundle（含内嵌 .appex），
  # pluginkit -e use 显式启用扩展，
  # 最后重启 WallpaperAgent 使其重新加载扩展列表（清除内存缓存）。
  postflight do
    system_command "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister",
      args: ["-f", "#{staged_path}/WaifuX.app"]
    system_command "/usr/bin/pluginkit",
      args: ["-e", "use", "-i", "com.waifux.app.wallpaperextension"]
    system_command "/usr/bin/killall",
      args: ["WallpaperAgent"],
      print_stderr: false
  end

  zap trash: [
    "~/Library/Application Support/WaifuX",
    "~/Library/Caches/com.waifux.app",
    "~/Library/Preferences/com.waifux.app.plist",
    "~/Library/Saved Application State/com.waifux.app.savedState",
  ]
end
