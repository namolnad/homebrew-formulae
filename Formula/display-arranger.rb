class DisplayArranger < Formula
  VERSION = "0.3.1".freeze

  desc "Command-line app that makes interacting with/arranging your Mac's displays a bit simpler"
  homepage "https://github.com/namolnad/display-arranger"
  url "https://github.com/namolnad/display-arranger.git", tag: VERSION, revision: "2aff6965a3138a89e5bb6cfd9a6fabb8d0ce859b"
  license "MIT"
  head "https://github.com/namolnad/display-arranger.git", branch: "main"

  depends_on macos: :catalina

  uses_from_macos "swift"

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "display-arranger"
    bin.install ".build/release/display-arranger"
  end

  test do
    assert_equal "v#{VERSION}".strip, shell_output("#{bin}/display-arranger --version").strip
  end
end
