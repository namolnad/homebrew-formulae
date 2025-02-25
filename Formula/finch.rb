class Finch < Formula
  VERSION = "0.3.0".freeze
  BUILD = "240".freeze

  desc "CLI to return a subset of JSON input based on a simple schema"
  homepage "https://github.com/namolnad/finch"
  url "https://github.com/namolnad/finch.git",
    tag: VERSION,
    revision: "076cfd08cb59b4d90f76e3379e59951172cb4292"
  license "MIT"
  head "https://github.com/namolnad/finch.git", branch: "main"

  def install
    system "make", "build_with_disable_sandbox"
    bin.install ".build/release/finch"
  end

  test do
    assert_match "Version: #{VERSION} (#{BUILD})", shell_output("#{bin}/finch --version").strip
  end
end
