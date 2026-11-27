# Homebrew tap for the HelioFITS Suite

Three Mac casks live here: HelioFITS Studio (`hfstudio`), HelioFITS Peek (`hfpeek`) and Heliogram (`heliogram`).

```
brew tap GillySpace27/tap       # once
brew install hfstudio           # HelioFITS Studio
brew install hfpeek             # HelioFITS Peek
```

The one-line form works without tapping first: `brew install --cask GillySpace27/tap/hfstudio` (or `.../hfpeek`).

If a newer Homebrew says it refuses to load a cask from an untrusted tap, run `brew trust gillyspace27/tap` once
and repeat the install. Trusting is your decision about this tap; it changes a Homebrew setting on your Mac.

## HelioFITS Studio (`hfstudio`)

Apple Silicon and Intel Macs on macOS 14 (Sonoma) or later. Updates: `brew upgrade --cask hfstudio`.
The old name `heliofits-studio` still works (see `cask_renames.json`), so existing installs keep upgrading.
Windows and Linux downloads, and everything else: <https://gilly.space/heliofits-studio/>.

## HelioFITS Peek (`hfpeek`)

The notarized direct download of HelioFITS Peek, for Finder and Quick Look previews of solar FITS files
(macOS 14.5 or later; Apple Silicon and Intel). It installs the same app as the Mac App Store; use one
or the other. Updates: `brew upgrade --cask hfpeek`.

## Heliogram (`heliogram`)

The live Sun on your Mac's screens (macOS 13 or later; Apple Silicon and Intel). The app updates itself, so
`brew upgrade --cask --greedy heliogram` is only needed to make Homebrew check anyway. Details:
<https://gilly.space/heliogram/>. Not part of the HelioFITS Suite cask.

## HelioFITS Suite (both apps at once)

```
brew install --cask GillySpace27/tap/heliofits-suite
```

A meta-cask that installs HelioFITS Peek and HelioFITS Studio. It holds no app of its own, so uninstalling it
leaves the two apps in place. To add a suite app, add its cask to the `depends_on cask:` list in
`Casks/heliofits-suite.rb`.

## Why a tap

Homebrew's main cask repository (`homebrew/cask`) only accepts software that meets its notability
requirements, and neither app does yet, so a bare `brew install hfstudio` with no tap is not possible. A tap
needs no approval. If either app is later accepted into `homebrew/cask`, the token stays the same and this tap
can point at it.

## Releasing: bump both casks

Each release must update its cask here, or `brew upgrade` stays on the old version.

- **Studio:** `release/release.sh` in HelioFITS-Studio has a `tap` step. It runs `release/homebrew/bump_cask.py`
  on `Casks/hfstudio.rb` (version and both dmg checksums, read from the release notes), pushes to `main`, and checks
  the raw file serves the new version. Set `HFS_TAP_DIR` to a clone of this tap, or the step clones a fresh one;
  `HFS_TAP_DIR=skip` skips it and the cask must then be bumped by hand.
- **Peek:** bump `Casks/hfpeek.rb` by hand: `version "<version>,<build>"` and the zip's `sha256`
  (`shasum -a 256 HelioFITS-<version>-b<build>.zip`). Only do it when that release carries a zip; a release made
  only for the Mac App Store has none.
- Never put `--zap` in a test: Studio's zap trashes `~/HFStudio`, Peek's trashes its containers. Test with
  `brew install --cask --appdir=<temp dir> GillySpace27/tap/<token>`, then a plain `brew uninstall`.
- **Heliogram:** bump `Casks/heliogram.rb` by hand: `version "<version>"` and the `sha256` of
  `https://gilly.space/heliogram/Heliogram-<version>.dmg` (`shasum -a 256`). The numbered dmg must be on the site first.
- Renaming a cask: `git mv` the file and add `{"old": "new"}` to `cask_renames.json`; never delete the old mapping.
