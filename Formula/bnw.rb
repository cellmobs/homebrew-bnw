class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.5/bnw-0.7.5-universal-apple-darwin.tar.gz"
  sha256 "ea28dd3cca2e22ce4424472213f50aab84b0d45f10d77dc8ecf99e38f2a53fca"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.5/bnw-0.7.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3d8f7c210c55cbf008f6d403014c5aa8a65777148a2ca15ba0b78baf307dfc5b"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.5/bnw-0.7.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b973a75ceb470b0bfeec313d0a1bdb83431e9494fa585a2fa9cee919c6d1033a"
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
