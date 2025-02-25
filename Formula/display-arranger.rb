class DisplayArranger < Formula
  desc "Command-line application for your Mac designed to make interacting with and arranging your external displays a bit simpler"
  homepage "https://github.com/namolnad/display-arranger"
  url "https://github.com/namolnad/display-arranger.git",
      tag:      "0.3.1",
      revision: "2aff6965a3138a89e5bb6cfd9a6fabb8d0ce859b"
  license "MIT"
  head "https://github.com/namolnad/display-arranger.git", branch: "main"

  depends_on macos: :catalina

  uses_from_macos "swift"

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "display-arranger"
    bin.install ".build/release/display-arranger"
  end

  test do
    expected_output = <<~EOS
            Use display-arranger to get information about your current displays,
            for setting the primary display, and for setting the positions of your other
            connected displays relative to another display's position (defaults to primary)

            Usage: display-arranger

            # Basic/Info commands
            [-h, --help] Shows the help text
            [-v, --version] Shows the version of the application

            # Query/List commands
            [-i, --info] Shows information about the connected displays
            [-l, --list-displays] Returns the ids for all connected displays
            [-L, --list-positions] Displays a list of the supported positions for --arrange argument

            # Action commands
            [-p, --primary <DisplayId>] Pass the id of the display that you want to make the primary display (dock/menu bar)
            [-a, --arrange <DisplayId> <Position> <ReferenceDisplayId>] Used in conjunction with --primary to
            control the position of your other displays. Order is important, see README for additional usage details.
            [-m, --mouse] Moves the mouse cursor to the given coordinates on the primary display (example: 100,100)

            Examples:
            display-arranger --info
            Returns information about your attached displays

            display-arranger --primary 69670848 -a 54019204 on-left:bottom-aligned
            Makes the display with the DisplayId 69670848 the primary display and
            positions 54019204 to the left of, and bottom-aligned to, the primary display

            Note: Global Position's origin is the upper-left corner of the display
    EOS
    assert_equal expected_output.strip, shell_output("#{bin}/display-arranger --help").strip
  end
end
