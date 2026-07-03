cask "waifux" do
  version "38.0.127"
  sha256 "fd8c9d031d0ac1765104d7429aac3dde2c7d4c2de8148b274eaad0339c86a88c"

  url "https://github.com/jipika/WaifuX/releases/download/v38.0.127/WaifuX.dmg"
  name "WaifuX"
  desc "Beautiful anime wallpaper and content browser"
  homepage "https://github.com/jipika/WaifuX"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  auto_updates true

  app "WaifuX.app"

  zap trash: [
    "~/Library/Application Support/WaifuX",
    "~/Library/Caches/com.waifux.app",
    "~/Library/Preferences/com.waifux.app.plist",
    "~/Library/Saved Application State/com.waifux.app.savedState",
  ]
end
