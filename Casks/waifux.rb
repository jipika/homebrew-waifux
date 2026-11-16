cask "waifux" do
  version "38.0.158"

  # 按架构分发：arm64 包含场景渲染器全家桶；x86_64 包不含（wgpu 生态暂为 arm64-only）。
  on_arm do
    sha256 "f6afe4d1a691342cdb31ff97a1913cd0b32fbfa048b9a307738ed76847b526bb"

    url "https://github.com/jipika/WaifuX/releases/download/v#{version}/WaifuX-arm64.dmg"
  end
  on_intel do
    sha256 "b8e45da4c29c1c0b56ffebc73453c2ad60ec6ba6c0f712a103a991d9a702ec17"

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
