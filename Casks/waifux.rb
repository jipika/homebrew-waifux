cask "waifux" do
  version "38.0.124"
  sha256 "83855a49768c5d4373dd1cc6ef9dd062fccf3bdaec5c6ab6735fa98cef6e12a1"

  url "https://github.com/jipika/WaifuX/releases/download/v38.0.124/WaifuX.dmg"
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
