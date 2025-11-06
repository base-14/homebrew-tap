class ClamreefAgent < Formula
  desc "Lightweight control plane agent for ClamAV antivirus monitoring and telemetry"
  homepage "https://github.com/base-14/clamreef-agent"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/base-14/clamreef-agent/releases/download/clamreed-agent-#{version}/clamreef-agent-Darwin-aarch64.tar.gz"
      sha256 "d1e79bec3c863220f7bbdc48f568b091694e7771955996f3b2cbe1afba369c10"
    elsif Hardware::CPU.intel?
      url "https://github.com/base-14/clamreef-agent/releases/download/clamreef-agent-#{version}/clamreef-agent-Darwin-x86_64.tar.gz"
      sha256 "PLACEHOLDER_SHA256_INTEL"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/base-14/clamreef-agent/releases/download/clamreed-agent-#{version}/clamreef-agent-Linux-aarch64.tar.gz"
      sha256 "d69c191cb102adec63983a488dadf9bf325f7e7a7c3c06848a3c56e467954bc4"
    else
      url "https://github.com/base-14/clamreef-agent/releases/download/clamreef-agent-#{version}/clamreef-agent-Linux-x86_64.tar.gz"
      sha256 "PLACEHOLDER_SHA256_LINUX_INTEL"
    end
  end

  depends_on "clamav"

  def install
    bin.install "clamreef-agent"

    # Install sample configuration file
    (buildpath/"config.toml.example").write <<~EOS
      # ClamReef Agent Configuration
      # Copy this file to #{etc}/clamreef/config.toml and modify as needed

      # ClamAV connection settings
      [clamav]
      socket_type = "unix"
      socket_path = "/tmp/clamd.socket"
      timeout = 30
      retry_attempts = 3
      retry_delay = 5

      # Telemetry settings
      [telemetry]
      enabled = false  # Disabled by default for privacy
      otlp_endpoint = "http://localhost:4317"
      service_name = "clamreef-agent"
      metrics_interval = 60

      # Scanning settings
      [scanning]
      watch_paths = [
        "/Users/*/Downloads",
        "/Users/*/Desktop"
      ]
      exclude_paths = [
        "/System",
        "/Library/Developer"
      ]
      max_file_size = 100
      recursive = true

      # Agent settings
      [agent]
      log_level = "info"

      [agent.health_check]
      enabled = true
      port = 8080
      path = "/health"
    EOS

    (etc/"clamreef").install "config.toml.example"
  end

  service do
    run [opt_bin/"clamreef-agent", "--config", etc/"clamreef/config.toml"]
    keep_alive true
    log_path var/"log/clamreef-agent.log"
    error_log_path var/"log/clamreef-agent.error.log"
    environment_variables RUST_LOG: "info"
    working_dir var
  end

  def post_install
    (etc/"clamreef").mkpath
    (var/"log").mkpath
    (var/"run").mkpath

    # Copy example config if actual config doesn't exist
    config_file = etc/"clamreef/config.toml"
    unless config_file.exist?
      cp etc/"clamreef/config.toml.example", config_file
      opoo "Created config file at #{config_file}"
      opoo "Please review and modify the configuration as needed."
    end

    # Ensure ClamAV is configured
    clamav_config = etc/"clamav/clamd.conf"
    unless clamav_config.exist?
      opoo "ClamAV configuration not found. Please configure ClamAV first:"
      opoo "  cp #{HOMEBREW_PREFIX}/etc/clamav/clamd.conf.sample #{clamav_config}"
      opoo "  sed -i '' 's/^Example$/# Example/' #{clamav_config}"
      opoo "  echo 'LocalSocket /tmp/clamd.socket' >> #{clamav_config}"
    end

    freshclam_config = etc/"clamav/freshclam.conf"
    unless freshclam_config.exist?
      opoo "FreshClam configuration not found. Please configure FreshClam:"
      opoo "  cp #{HOMEBREW_PREFIX}/etc/clamav/freshclam.conf.sample #{freshclam_config}"
      opoo "  sed -i '' 's/^Example$/# Example/' #{freshclam_config}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clamreef-agent --version")
  end

  def caveats
    <<~EOS
      Configuration:
        Config file: #{etc}/clamreef/config.toml
        Example config: #{etc}/clamreef/config.toml.example

      Edit the configuration file to customize:
        - ClamAV connection settings
        - Directories to monitor
        - Telemetry endpoints
        - Performance settings

      To start clamreef-agent as a service:
        brew services start clamreef-agent

      ClamAV Setup (if not already configured):
        1. Configure ClamAV daemon:
           cp #{HOMEBREW_PREFIX}/etc/clamav/clamd.conf.sample #{HOMEBREW_PREFIX}/etc/clamav/clamd.conf
           sed -i '' 's/^Example$/# Example/' #{HOMEBREW_PREFIX}/etc/clamav/clamd.conf
           echo 'LocalSocket /tmp/clamd.socket' >> #{HOMEBREW_PREFIX}/etc/clamav/clamd.conf

        2. Configure FreshClam for virus definition updates:
           cp #{HOMEBREW_PREFIX}/etc/clamav/freshclam.conf.sample #{HOMEBREW_PREFIX}/etc/clamav/freshclam.conf
           sed -i '' 's/^Example$/# Example/' #{HOMEBREW_PREFIX}/etc/clamav/freshclam.conf

        3. Update virus definitions:
           freshclam

        4. Start ClamAV service:
           brew services start clamav

      Check service status:
        brew services list
    EOS
  end
end