cask "hfpeek" do
  version "1.5.1,13"
  sha256 "d90ce8f8c63c9b909d47b152c2d2c2244ec0a9a93004fbc3dd59bd7d3652ef39"

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
  depends_on macos: ">= :sonoma"

  app "HelioFITS.app"

  zap trash: [
    "~/Library/Containers/com.gillyspace27.HelioFITS",
    "~/Library/Group Containers/UB45PPC2JS.com.gillyspace27.fits",
  ]
end
