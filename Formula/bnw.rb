class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.8/bnw-0.8.8-universal-apple-darwin.tar.gz"
  sha256 "d4eb20ad1707a5c62a2ff689fd053c682e1e9000a1705531234adb601c76f8f3"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.8/bnw-0.8.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2042237e9d98f95e6567fdc601d17b26ca150d88aefb47883c5edb02b2ed9bc7"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.8/bnw-0.8.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "05940348d43492fd4562b08603c24677c1bb62f395e06e70ea325316e41d6f23"
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
