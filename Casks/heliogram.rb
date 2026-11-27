cask "heliogram" do
  version "0.8"
  sha256 "ce7e72536e678333ab1020e5da41c031a3a6847940adce4a3424594cb9154e07"

  # One universal disk image (Apple Silicon and Intel). gilly.space keeps a numbered copy of each
  # release beside the unnumbered Heliogram.dmg, so the checksum above stays valid for this version.
  url "https://gilly.space/heliogram/Heliogram-#{version}.dmg"
  name "Heliogram"
  desc "The live Sun on your Mac's screens: desktop picture, screen saver or wall of video"
  homepage "https://gilly.space/heliogram/"

  livecheck do
    url "https://gilly.space/heliogram/version.json"
    strategy :json do |json|
      json["version"]
    end
  end

  # Heliogram updates itself (Sparkle), so a plain `brew upgrade` skips it; use --greedy to check anyway.
  auto_updates true
  depends_on macos: :ventura

  app "Heliogram.app"
end
