# Source-of-truth template for the homebrew tap formula (0626, feat/local-launcher).
# .github/workflows/release.yml renders this on every v* tag — swapping https://github.com/manwray/tickle/releases/download/v0.1.0/tickle-0.1.0-darwin-universal.tar.gz,
# 3d4f6b13e5475bf02a44ac9c498f16503fd6b8b057d06ff362b8886b43606631, 0.1.0 for the just-published darwin universal tarball — and pushes
# the result to manwray/homebrew-tickle as Formula/tickle.rb (bump-on-release; no
# hand-editing). The committed Formula/tickle.rb in this repo is a rendered example
# of this template; brew always reads the tap copy.
class Tickle < Formula
  desc "Local launcher for the tickle board (one window: board + local claude)"
  homepage "https://github.com/manwray/tickle"
  url "https://github.com/manwray/tickle/releases/download/v0.1.0/tickle-0.1.0-darwin-universal.tar.gz"
  sha256 "3d4f6b13e5475bf02a44ac9c498f16503fd6b8b057d06ff362b8886b43606631"
  version "0.1.0"
  license "MIT"

  # darwin-only for v1 (the tarball is a universal binary: arm64 + amd64).
  depends_on :macos

  def install
    bin.install "tickle"
  end

  test do
    assert_match "tickle #{version}", shell_output("#{bin}/tickle --version")
  end
end
