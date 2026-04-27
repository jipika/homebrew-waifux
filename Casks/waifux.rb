cask "waifux" do
  version "38.0.82"
  sha256 "c4d3c5f0820022c30262ebb4f7479af8e6d9b47e323d70def1e185cea6bc6027"

  url "https://github.com/jipika/WaifuX/releases/download/v#{version}/WaifuX.dmg"
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
