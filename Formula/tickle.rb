# Source-of-truth template for the homebrew tap formula (0626, feat/local-launcher).
# .github/workflows/release.yml renders this on every v* tag — swapping https://github.com/manwray/homebrew-tickle/releases/download/v0.5.0/tickle-0.5.0-darwin-universal.tar.gz,
# b37a36b471508cfad61c5677dfedcc9f34a3dde4c825604a519a825246331ab6, 0.5.0 for the just-published darwin universal tarball — and pushes
# the result to manwray/homebrew-tickle as Formula/tickle.rb (bump-on-release; no
# hand-editing). The committed Formula/tickle.rb in this repo is a rendered example
# of this template; brew always reads the tap copy.
class Tickle < Formula
  desc "CLI for the tickle board server (API + embedded SPA)"
  homepage "https://github.com/manwray/tickle"
  url "https://github.com/manwray/homebrew-tickle/releases/download/v0.5.0/tickle-0.5.0-darwin-universal.tar.gz"
  sha256 "b37a36b471508cfad61c5677dfedcc9f34a3dde4c825604a519a825246331ab6"
  version "0.5.0"
  license "MIT"

  # darwin-only for v1 (the tarball is a universal binary: arm64 + amd64).
  depends_on :macos
  # 1138: `tickle` is the same server binary and mints decisions via the cgo
  # onnxruntime embed path (go/internal/embed, all-MiniLM-L6-v2). The binding
  # dlopens libonnxruntime at runtime, and embed's candidateLibPaths resolves the
  # brew dylib (/opt/homebrew|/usr/local .../onnxruntime/lib/libonnxruntime.dylib),
  # so onnxruntime must be installed — otherwise minting fails loud.
  depends_on "onnxruntime"

  def install
    bin.install "tickle"
    man1.install "tickle.1"
  end

  test do
    assert_match "tickle #{version}", shell_output("#{bin}/tickle --version")
    assert_predicate man1/"tickle.1", :exist?
  end
end
