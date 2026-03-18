class Scout < Formula
  desc "CLI for the Scout observability platform"
  homepage "https://github.com/base-14/scout-cli"
  version "0.2.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "cb8b7b8f4ee6d4725affbfc63dea5a431312438c9a34e989cb0bb0d0156ee68f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "082fd058aa48cc708714dda1d2dbde300d7ecbbf4e3b13e8f7266b7eb42dd137"
    end
  end

  on_linux do
    url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "2c7db3a34f0f4e31522189ce23e45159e7dfec066c993d12de9f75194d7f9ace"
  end

  def install
    bin.install "scout"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scout --version")
  end
end
