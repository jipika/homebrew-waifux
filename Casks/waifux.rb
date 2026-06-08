cask "waifux" do
  version "38.0.116"
  sha256 "102d53bc9f2b6a047c9696fbe4c7adfb2c30ed682e4adaf76031db14fc821f77"

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
