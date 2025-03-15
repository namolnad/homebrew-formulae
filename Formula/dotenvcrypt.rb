class Dotenvcrypt < Formula
  VERSION = "0.4.0".freeze

  desc "Securely encrypt, manage, and load your `.env` files in public repositories"
  homepage "https://github.com/namolnad/dotenvcrypt"
  url "https://github.com/namolnad/dotenvcrypt.git",
      tag:      VERSION,
      revision: "befe4e8eea5734404ad235ed6fe01c484b88955d"
  license "MIT"
  head "https://github.com/namolnad/dotenvcrypt.git", branch: "main"

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "dotenvcrypt.gemspec"
    system "gem", "install", "dotenvcrypt-#{VERSION}.gem"
    bin.install libexec/"bin/dotenvcrypt"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    # Create a test .env file
    (testpath/".env").write("TEST=value")

    # Test encryption
    system bin/"dotenvcrypt", "encrypt", "--key", "testkey"
    assert_path_exists testpath/".env.enc"

    # Test that the original content is not in the encrypted file
    refute_match "TEST=value", (testpath/".env.enc").read

    # Test decryption
    assert_match "TEST=value", system(bin/"dotenvcrypt", "--key", "testkey", "decrypt", "#{testpath}/.env.enc").strip
  end
end
