class Scout < Formula
  desc "CLI for the Scout observability platform"
  homepage "https://github.com/base-14/scout-cli"
  version "0.14.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "26c6d2ab56dac32194b7bc9380ef568177c5f1d0a2c99d670fbb8c9461ada642"
    end
    if Hardware::CPU.intel?
      url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "02a3bea20de7db1ff80fcdb39705d370d8363e56b64ffbb0825544e691581baa"
    end
  end

  on_linux do
    url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "04986ecb74dcb5245b3570ab047f795bc96d043a168f7442e163ca55cb79af0c"
  end

  def install
    bin.install "scout"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scout --version")
  end
end
