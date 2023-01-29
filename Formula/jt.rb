class Jt < Formula
  desc "Command-line tool to return a subset of JSON input based on a simple schema"
  homepage "https://github.com/namolnad/jt"
  url "https://github.com/namolnad/jt.git",
      tag:      "0.1.0",
      revision: "d4566fafdd294593509b16f33a5e371041b47dfc"
  license "MIT"
  head "https://github.com/namolnad/jt.git", branch: "main"

  depends_on macos: :catalina

  uses_from_macos "swift"

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "jt"
    bin.install ".build/release/jt"
  end

  test do
    input = '{"body":{"items":[{"name":"Dan","id":123},{"name":"Becca","id":456}]},"meta":{"result": "success"}}'
    expected_output = '{"body":{"items":[{"name":"Dan"},{"name":"Becca"}]}}'
    assert_match expected_output, shell_output("#{bin}/jt --input '#{input}' '{body{items[{name}]}}'").chomp
  end
end
