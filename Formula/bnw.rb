class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.16/bnw-0.7.16-universal-apple-darwin.tar.gz"
  sha256 "08b71cfc9582b0ed5198e6cc2ff93a20c9f8bf1ecb0e7f2af6afa0b22ac38c43"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.16/bnw-0.7.16-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3369f2725f44da7aca69f2fac8b7c3c47390df0f30636bf74c22b5274fd71e8e"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.16/bnw-0.7.16-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7b76d7b3a4a33db6aa539687b6fd4f60a00e0e648c703198f8086c66d99f00a4"
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
