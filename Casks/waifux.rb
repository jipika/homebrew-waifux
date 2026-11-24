cask "waifux" do
  version "38.0.160"

  # 按架构分发：两个包各自携带本架构的渲染器全家桶（wgpu / DXC / ffmpeg / web daemon）。
  on_arm do
    sha256 "1770a5c28a99203d1548c4e1b30d45d3176c8fc6a96217c8d24c03129791ece8"

    url "https://github.com/jipika/WaifuX/releases/download/v#{version}/WaifuX-arm64.dmg"
  end
  on_intel do
    sha256 "6da6886a246cf14f01432477bc50f848e7b6fdb51deb07b957563fcc28dfe738"

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
