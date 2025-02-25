class LocalWellKnown < Formula
  VERSION = "0.1.0".freeze

  desc "CLI to aid in testing Apple's Universal Links, Shared Web Credentials, etc."
  homepage "https://github.com/namolnad/local-well-known"
  url "https://github.com/namolnad/local-well-known.git",
      tag:      VERSION,
      revision: "30685e898d16c22f5d4ffce0bf0360fa8a2f2e75"
  license "MIT"
  head "https://github.com/namolnad/local-well-known.git", branch: "main"

  depends_on macos: :catalina

  uses_from_macos "swift"

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "local-well-known"
    bin.install ".build/release/local-well-known"
  end

  test do
    assert_equal "v#{VERSION}".strip, shell_output("#{bin}/local-well-known --version").strip
  end
end
