# Source-of-truth template for the homebrew tap formula (0626, feat/local-launcher).
# .github/workflows/release.yml renders this on every v* tag — swapping https://github.com/manwray/homebrew-tickle/releases/download/v0.6.16/tickle-0.6.16-darwin-universal.tar.gz,
# e9253823106bf23725b9fcdcb930639a8aa0da1ad8a80ffae5ea8039b37af7f7, 0.6.16 for the just-published darwin universal tarball — and pushes
# the result to manwray/homebrew-tickle as Formula/tickle.rb (bump-on-release; no
# hand-editing). The committed Formula/tickle.rb in this repo is a rendered example
# of this template; brew always reads the tap copy.
class Tickle < Formula
  desc "Client CLI for the tickle board server"
  homepage "https://github.com/manwray/tickle"
  url "https://github.com/manwray/homebrew-tickle/releases/download/v0.6.16/tickle-0.6.16-darwin-universal.tar.gz"
  sha256 "e9253823106bf23725b9fcdcb930639a8aa0da1ad8a80ffae5ea8039b37af7f7"
  version "0.6.16"
  license "MIT"

  # darwin-only for v1 (the tarball is a universal binary: arm64 + amd64).
  depends_on :macos
  # #1258 two-cmd split (decision bff738fd): `tickle` is now the CLIENT-ONLY
  # binary — it imports zero server/db/embed packages, so it no longer carries the
  # cgo onnxruntime embed path (that moved to the server binary / Docker image).
  # No `depends_on "onnxruntime"` — the client is pure Go with no native deps.

  def install
    bin.install "tickle"
    man1.install "tickle.1"
  end

  test do
    assert_match "tickle #{version}", shell_output("#{bin}/tickle --version")
    assert_predicate man1/"tickle.1", :exist?
  end
end
