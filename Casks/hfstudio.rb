cask "hfstudio" do
  version "0.9.4"

  on_arm do
    sha256 "780fa9be8f86e3bd77ca1c4cf3bc18f94a948d96fb22cc6219f37c4f5a916155"
    url "https://github.com/GillySpace27/HelioFITS-Studio/releases/download/v#{version}/HFStudio-#{version}.dmg"
  end
  on_intel do
    sha256 "8af5d685861d613c26a40802f4c5cce3bfc0b7cd927bbdc977a71ac09c8b7638"
    url "https://github.com/GillySpace27/HelioFITS-Studio/releases/download/v#{version}/HFStudio-#{version}-intel.dmg"
  end

  name "HelioFITS Studio"
  desc "Viewer for solar and heliospheric FITS and JPEG 2000 data"
  homepage "https://gilly.space/heliofits-studio/"

  # Every release so far is a GitHub pre-release, which brew's github_releases strategy skips, and the
  # repository's tags include old JHelioviewer ones (v2.15.7) that outrank 0.9.x. The releases feed
  # lists only real releases, pre-releases included.
  livecheck do
    url "https://github.com/GillySpace27/HelioFITS-Studio/releases.atom"
    regex(%r{releases/tag/v?(\d+\.\d+\.\d+)"}i)
    strategy :page_match
  end

  # The app's Python extensions are built for macOS 14 (otool minos on the 0.9.2 dmgs).
  depends_on macos: :sonoma

  app "HelioFITS Studio.app"

  zap trash: "~/HFStudio"
end
