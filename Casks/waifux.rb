cask "waifux" do
  version "38.0.155"

  # 按架构分发：arm64 包含场景渲染器全家桶；x86_64 包不含（wgpu 生态暂为 arm64-only）。
  on_arm do
    sha256 "e44eb0c5319476bf307b845e0b30ddad8bb3256bc1b36ce7aa27ce5c4de15fda"

    url "https://github.com/jipika/WaifuX/releases/download/v#{version}/WaifuX-arm64.dmg"
  end
  on_intel do
    sha256 "c64e89c15672f339b22873470fac44a107b7ca9663b0ee5ece0629a0c5fa380b"

    url "https://github.com/jipika/WaifuX/releases/download/v#{version}/WaifuX-x86_64.dmg"
  end
  name "WaifuX"
  desc "Beautiful anime wallpaper and content browser"
  homepage "https://github.com/jipika/WaifuX"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  auto_updates true
  depends_on macos: :sonoma

  app "WaifuX.app"

  # Registration is best-effort because Homebrew 6 runs postflight steps in a
  # sandbox that cannot always reach LaunchServices, PlugInKit, or WallpaperAgent.
  # The app performs the authoritative registration when it starts.
  postflight_steps do
    run "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister",
        args:         ["-f", "{{staged_path}}/WaifuX.app"],
        must_succeed: false,
        print_stderr: false
    run "/usr/bin/pluginkit",
        args:         ["-e", "use", "-i", "com.waifux.app.wallpaperextension"],
        must_succeed: false,
        print_stderr: false
    run "/usr/bin/killall",
        args:         ["WallpaperAgent"],
        must_succeed: false,
        print_stderr: false
  end

  zap trash: [
    "~/Library/Application Support/WaifuX",
    "~/Library/Caches/com.waifux.app",
    "~/Library/Preferences/com.waifux.app.plist",
    "~/Library/Saved Application State/com.waifux.app.savedState",
  ]
end
