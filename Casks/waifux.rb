cask "waifux" do
  version "38.0.151"
  sha256 "82bfe1b10553c67fe9143febd62d5bc9b200771f2ff454f1b9ab643cb73ee6d1"

  url "https://github.com/jipika/WaifuX/releases/download/v#{version}/WaifuX.dmg"
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
