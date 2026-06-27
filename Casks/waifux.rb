cask "waifux" do
  version "38.0.125"
  sha256 "9abb973f603eb9dbc20c4201ca8afa42456c960311b44adcc186f494bcfd1ac0"

  url "https://github.com/jipika/WaifuX/releases/download/v38.0.125/WaifuX.dmg"
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
