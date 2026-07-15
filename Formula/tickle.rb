# Source-of-truth template for the homebrew tap formula (0626, feat/local-launcher).
# .github/workflows/release.yml renders this on every v* tag — swapping https://github.com/manwray/homebrew-tickle/releases/download/v0.6.1/tickle-0.6.1-darwin-universal.tar.gz,
# c6cc34fbb47e9cc90f3f13478305ddf4cb5e35e671ca46d275f031de731efc09, 0.6.1 for the just-published darwin universal tarball — and pushes
# the result to manwray/homebrew-tickle as Formula/tickle.rb (bump-on-release; no
# hand-editing). The committed Formula/tickle.rb in this repo is a rendered example
# of this template; brew always reads the tap copy.
class Tickle < Formula
  desc "CLI for the tickle board server (API + embedded SPA)"
  homepage "https://github.com/manwray/tickle"
  url "https://github.com/manwray/homebrew-tickle/releases/download/v0.6.1/tickle-0.6.1-darwin-universal.tar.gz"
  sha256 "c6cc34fbb47e9cc90f3f13478305ddf4cb5e35e671ca46d275f031de731efc09"
  version "0.6.1"
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
