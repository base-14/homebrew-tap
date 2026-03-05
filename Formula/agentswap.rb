class Agentswap < Formula
  desc "Transfer conversation history between AI coding agents"
  homepage "https://github.com/nimishgj/agentswap"
  license "MIT"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nimishgj/agentswap/releases/download/v0.1.0/agentswap-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "0693fcc9e84611fed7fae837fe4e9a4bd32a32cdc2191ec2402584e42a00d6f5"
    else
      url "https://github.com/nimishgj/agentswap/releases/download/v0.1.0/agentswap-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "96b0e903125fa97b4d9effa63431f599c16ae733a101b2e785f9e2c120001dc0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nimishgj/agentswap/releases/download/v0.1.0/agentswap-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a17abb989e590757e5eca084119a3c5e1da0ba0c5662509977f9a28e90ec15b7"
    else
      url "https://github.com/nimishgj/agentswap/releases/download/v0.1.0/agentswap-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2576e5b5471e3cf41859b7141b32c1994dd4205722c0388499004c0c6cb722a8"
    end
  end

  def install
    bin.install "agentswap" => "agentswap"
  end

  test do
    assert_match "agentswap", shell_output("#{bin}/agentswap --version 2>&1", 1)
  end
end
