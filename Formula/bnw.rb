class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.1/bnw-0.7.1-universal-apple-darwin.tar.gz"
  sha256 "b4081f90f1b841e5d8fcfb00fb2555d95b444df9d7b71c66c5eee66cc7b930c4"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.1/bnw-0.7.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "77fbcfdb810f7d8cb4c01c7979ce5c35689f262ae6ae71f00ba102dd0baf1ae0"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.1/bnw-0.7.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "127c695ddc51087dd0dc683521ae98be7b27a690c1492461d834c626221e586a"
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
