class DisplayArranger < Formula
  desc "Command-line application for your Mac designed to make interacting with and arranging your external displays a bit simpler"
  homepage "https://github.com/namolnad/display-arranger"
  url "https://github.com/namolnad/display-arranger.git",
      tag:      "0.2.0",
      revision: "7882845f399242bfddfdf1f0d01491133f8b0d6c"
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
            for setting the main display, and for setting the positions of your other
            connected displays relative to another display's position (defaults to main)

            Usage: display-arranger
            [-h, --help] Shows the help text
            [--ids] Returns the ids for all connected displays
            [-i, --info] Shows information about the connected displays
            [--moveMouse] Moves the mouse cursor to the given coordinates on the main display (example: 100-100)
            [--setMain <DisplayId>] Pass the id of the display that you want to make the main display (dock/menu bar)
            [--supportedPositions] Displays a list of the supported positions for --otherPosition command
            [-op, --otherPosition <DisplayId> <Position> <ReferenceDisplayId>] Used in conjunction with --setMain to
            control the position of your other displays. Order is important, see README for additional usage details.


            Examples:
            display-arranger --info
            Returns information about your attached displays

            display-arranger --setMain 69670848 -op 54019204 onLeft-bottomAligned
            Makes the display with the DisplayId 69670848 the main display and
            positions 54019204 to the left of, bottom-aligned to, the main display

            Note: Global Position's origin is the upper-left corner of the display
    EOS
    assert_match expected_output, shell_output("#{bin}/display-arranger --help").chomp
  end
end
