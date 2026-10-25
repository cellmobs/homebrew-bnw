class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.2/bnw-0.8.2-universal-apple-darwin.tar.gz"
  sha256 "283d6d9b58d97ed302f18a62f88d88d81c1560ba716d1ff132ccc4270d88debe"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.2/bnw-0.8.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7b096a6b09df9897b3dd4e4378101f6205946f5a4046213442f9070f3bd93d3b"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.2/bnw-0.8.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "455fd46a5efa54f2c5aabfa7ef131e665bdb8763ad7d468651fb50454c92b74f"
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
