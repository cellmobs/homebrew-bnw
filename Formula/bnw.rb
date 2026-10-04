class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.7/bnw-0.7.7-universal-apple-darwin.tar.gz"
  sha256 "33bf2c09ffb345cf8c8a23657485e263d68fad14f5a16c26e12282bac5620851"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.7/bnw-0.7.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "20cafefefe6ebd856bd472101bd37bcf586e3d4ab54b3daba84f79539579d1b8"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.7/bnw-0.7.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9020db448ec84ec3fce5455c1b72c37b17fb0d43f53b4f6f2367302ef74af20d"
    end
  end

  def install
    bin.install "bnw"
  end

  # `brew services start bnw` runs the node for the default data directory (~/.bnw).
  # `bnw service install` does the same without Homebrew; use one or the other.
  service do
    run [opt_bin/"bnw", "node", "start"]
    keep_alive crashed: true
    environment_variables RUST_LOG: "info"
    log_path var/"log/bnw.log"
    error_log_path var/"log/bnw.log"
  end

  def caveats
    <<~EOS
      Get started with:
        bnw setup
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bnw --version")
  end
end
