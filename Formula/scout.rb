class Scout < Formula
  desc "CLI for the Scout observability platform"
  homepage "https://github.com/base-14/scout-cli"
  version "0.18.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "2c78df3348d7fec198d07d92f31eac1346b96f65f6f2089e5875397742111152"
    end
    if Hardware::CPU.intel?
      url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "c18cef81026daca9b4bc8af8a39933a0f48e63ebc0fed2efa8c53838a1679591"
    end
  end

  on_linux do
    url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "259c0f0d1d0832712b34a023b0150de7bc6436c55825323b572b1e13970a70ce"
  end

  def install
    bin.install "scout"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scout --version")
  end
end
