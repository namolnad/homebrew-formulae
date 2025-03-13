class Envcrypt < Formula
  VERSION = "0.3.1".freeze

  desc "Securely encrypt, manage, and load your `.env` files in public repositories"
  homepage "https://github.com/namolnad/envcrypt"
  url "https://github.com/namolnad/envcrypt.git",
      tag:      VERSION,
      revision: "fec727e80c4f870642345da6ea401da71c5f3866"
  license "MIT"
  head "https://github.com/namolnad/envcrypt.git", branch: "main"

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "envcrypt.gemspec"
    system "gem", "install", "envcrypt-#{VERSION}.gem"
    bin.install libexec/"bin/envcrypt"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    # Create a test .env file
    (testpath/".env").write("TEST=value")

    # Test encryption
    system bin/"envcrypt", "encrypt", "--key", "testkey"
    assert_path_exists testpath/".env.enc"

    # Test that the original content is not in the encrypted file
    refute_match "TEST=value", (testpath/".env.enc").read

    # Test decryption
    assert_match "TEST=value", system(bin/"envcrypt", "--key", "testkey", "decrypt", "#{testpath}/.env.enc").strip
  end
end
