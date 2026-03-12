class Agentswap < Formula
  desc "Transfer conversation history between AI coding agents"
  homepage "https://github.com/nimishgj/agentswap"
  license "MIT"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nimishgj/agentswap/releases/download/v0.1.1/agentswap-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "899ecb2d77c5b29862aca43e6a9712c00b68547ed609b111c2ad1ea0176e687d"
    else
      url "https://github.com/nimishgj/agentswap/releases/download/v0.1.1/agentswap-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "f05edeceaf19a4f4d77e9ef07781fdb571e42bddd705d93dc66f70341290203f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nimishgj/agentswap/releases/download/v0.1.1/agentswap-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "df402fa083389934ef2facb1578b022660185824e0c090f42178b0f769e55b6b"
    else
      url "https://github.com/nimishgj/agentswap/releases/download/v0.1.1/agentswap-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5778e526cb557b1d0e381662f224d57df4665606a2dcf5682f8530366a7884e2"
    end
  end

  def install
    bin.install "agentswap" => "agentswap"
  end

  test do
    assert_match "agentswap", shell_output("#{bin}/agentswap --version 2>&1", 1)
  end
end
