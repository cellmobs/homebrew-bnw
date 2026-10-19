class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.0/bnw-0.8.0-universal-apple-darwin.tar.gz"
  sha256 "02cce0245767cbd075c5e3fe3a3566ad1ad65141c5ab788b0d53f4713bb24006"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.0/bnw-0.8.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e1789864152108d8315135e40ac5d7d72e53bbe666a9ce536390ddbe8bd0148f"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.0/bnw-0.8.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "702c55de39ed5c882e3e76a9883fad792c3f71df30b6900bcea7a2ed1e29fc99"
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
