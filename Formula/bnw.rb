class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.4/bnw-0.8.4-universal-apple-darwin.tar.gz"
  sha256 "2ae07316451bc0e10f157380ba4ecafa209745915935021af18ecb2c191f7fa6"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.4/bnw-0.8.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d9a24bf53b08e7b9e14b888239a22c17d98bb0041bb46f6e97f6565b0cbf74c3"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.4/bnw-0.8.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7f52584deee4b42cac047472c5022e75fecd4f1eb38ee53670fc36bf38d9adf6"
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
