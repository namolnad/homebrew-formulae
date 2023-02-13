class LocalWellKnown < Formula
  desc "Command-line tool to aid in testing Apple's Universal Links, Shared Web Credentials, etc."
  homepage "https://github.com/namolnad/local-well-known"
  url "https://github.com/namolnad/local-well-known.git",
      tag:      "0.1.0",
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
    true
  end
end
