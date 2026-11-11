class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.6/bnw-0.9.6-universal-apple-darwin.tar.gz"
  sha256 "1764edf4ca3cb533957cd1ea10e0affca2dc16d71c620577a9d92edb5f6f7614"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.6/bnw-0.9.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "87fec54e0156d6282461941b49a2e62daeaa4323ba48e88ed18515db84bd8bf5"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.6/bnw-0.9.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "63851275798684bd2aac64a7d3e269020a8f78a709ff13d25f1889ea9e7821b0"
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
