class Scout < Formula
  desc "CLI for the Scout observability platform"
  homepage "https://github.com/base-14/scout-cli"
  version "0.15.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "51be747a8ddc520a11b08512569b67078e6327fbe4bde0b5d196a9106ba4d4c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "aab97b5fdfdb404f157e511e3ad8109f07dd4f92fc91bd5419cb3cef985fb31b"
    end
  end

  on_linux do
    url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "6f7336c56d5f86e2f6d7958f01efde7b6913b98e8e575a7d31c6e4506f364ed7"
  end

  def install
    bin.install "scout"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scout --version")
  end
end
