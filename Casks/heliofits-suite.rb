cask "heliofits-suite" do
  version "1.0"
  sha256 :no_check

  name "HelioFITS Suite"
  desc "HelioFITS Peek and HelioFITS Studio together"
  homepage "https://gilly.space/heliosoftware/"

  # A meta-cask: it installs nothing itself. Add a suite app by adding its cask to this list.
  depends_on cask: [
    "gillyspace27/tap/hfpeek",
    "gillyspace27/tap/hfstudio",
  ]
  depends_on macos: :sonoma

  stage_only true
end
