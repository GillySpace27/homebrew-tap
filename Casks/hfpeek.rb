cask "hfpeek" do
  version "1.5.2,14"
  sha256 "b665d09ae79519e185a04907a0b1b7324b2b0f40eaffd1cd0eb063b909a2992e"

  url "https://github.com/GillySpace27/HelioFITS-Peek/releases/download/v#{version.csv.first}-build.#{version.csv.second}/HelioFITS-#{version.csv.first}-b#{version.csv.second}.zip"
  name "HelioFITS Peek"
  desc "Finder and Quick Look previews, thumbnails and viewer for solar FITS files"
  homepage "https://gilly.space/heliofits"

  # Tags look like v1.5.1-build.13 and the zip is HelioFITS-1.5.1-b13.zip. A release made only for
  # the Mac App Store carries no zip, so bump this cask only when the new release has one.
  livecheck do
    url "https://github.com/GillySpace27/HelioFITS-Peek/releases.atom"
    regex(%r{releases/tag/v?(\d+(?:\.\d+)+)-build\.(\d+)"}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match[0]},#{match[1]}" }
    end
  end

  # The app targets macOS 14.5 (MACOSX_DEPLOYMENT_TARGET); brew can name Sonoma (14.0) but not 14.5.
  depends_on macos: :sonoma

  app "HelioFITS Peek.app"

  zap trash: [
    "~/Library/Containers/com.gillyspace27.HelioFITS",
    "~/Library/Group Containers/UB45PPC2JS.com.gillyspace27.fits",
  ]
end
