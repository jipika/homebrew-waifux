cask "waifux" do
  version "38.0.150"
  sha256 "9afa5fe6449746120708c34c5fe3e960ac35215c60a947fd0603226027447612"

  url "https://github.com/jipika/WaifuX/releases/download/v38.0.150/WaifuX.dmg"
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
  postflight_steps do
    run "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister",
      args: ["-f", "{{staged_path}}/WaifuX.app"]
    run "/usr/bin/pluginkit",
      args: ["-e", "use", "-i", "com.waifux.app.wallpaperextension"]
    run "/usr/bin/killall",
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
