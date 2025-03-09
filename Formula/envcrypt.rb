class Envcrypt < Formula
  VERSION = "0.1.0".freeze

  desc "Securely encrypt, manage, and load your `.env` files in public repositories"
  homepage "https://github.com/namolnad/envcrypt"
  url "https://github.com/namolnad/envcrypt.git",
      tag:      VERSION,
      revision: "10bc5fd32e28d703d28b980ad6fa0a9715a208ca"
  license "MIT"
  head "https://github.com/namolnad/envcrypt.git", branch: "main"
  version VERSION

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "envcrypt.gemspec"
    system "gem", "install", "envcrypt-#{version}.gem"
    bin.install libexec/"bin/envcrypt"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    # Create a test .env file
    (testpath/".env").write("TEST=value")

    # Test encryption
    system bin/"envcrypt", "encrypt", "--key", "testkey"
    assert_predicate testpath/".env.enc", :exist?

    # Test that the original content is not in the encrypted file
    refute_match "TEST=value", (testpath/".env.enc").read

    # Test decryption
    assert_match "TEST=value", system(bin/"envcrypt", "--key", "testkey", "decrypt", "#{testpath}/.env.enc").strip
  end
end


