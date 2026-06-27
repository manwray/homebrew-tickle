# Source-of-truth template for the homebrew tap formula (0626, feat/local-launcher).
# .github/workflows/release.yml renders this on every v* tag — swapping https://github.com/manwray/homebrew-tickle/releases/download/v0.2.0/tickle-0.2.0-darwin-universal.tar.gz,
# 45130adf513d7b094ef88d0e455be913a32370d51d33192228be18cd0501804f, 0.2.0 for the just-published darwin universal tarball — and pushes
# the result to manwray/homebrew-tickle as Formula/tickle.rb (bump-on-release; no
# hand-editing). The committed Formula/tickle.rb in this repo is a rendered example
# of this template; brew always reads the tap copy.
class Tickle < Formula
  desc "CLI for the tickle board server (API + embedded SPA)"
  homepage "https://github.com/manwray/tickle"
  url "https://github.com/manwray/homebrew-tickle/releases/download/v0.2.0/tickle-0.2.0-darwin-universal.tar.gz"
  sha256 "45130adf513d7b094ef88d0e455be913a32370d51d33192228be18cd0501804f"
  version "0.2.0"
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
