class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.10.1/bnw-0.10.1-universal-apple-darwin.tar.gz"
  sha256 "44ddd27ba1e30938fbcf797b56e764bc0aee054efa2c7d30aaf855e624e5780f"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.10.1/bnw-0.10.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c8b747aba87cc0479828b83a1534a6b72acbf6c8a13ed9fa2f8af88e5052cbbc"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.10.1/bnw-0.10.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bf3a8b42d9a0d2d49da252b0d0f6c099bd1413c6f241f25c80b8e4b5e047498d"
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
