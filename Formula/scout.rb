class Scout < Formula
  desc "CLI for the Scout observability platform"
  homepage "https://github.com/base-14/scout-cli"
  version "0.10.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "e5847369709ccdc37d3d99bf9ab2956c81860970579be7add9fd6e8e948d096e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "012c1f265913045604f5023afa0fbc055112e1bd763ef8c834198f3cca4ecea5"
    end
  end

  on_linux do
    url "https://github.com/base-14/public-apps/releases/download/scout-v#{version}/scout-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "81b6161f13cdcbbf1387162ea20f26ac08f5f0e0a15b5b91174e78061dc259da"
  end

  def install
    bin.install "scout"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scout --version")
  end
end
