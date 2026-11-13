class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.1/bnw-0.11.1-universal-apple-darwin.tar.gz"
  sha256 "91d492a5307d4f152b6aacbf1b20f990f62751f3209a237750aeae213a27f832"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.1/bnw-0.11.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0497c922c56f33c790bab68733036d8ddde1cff0608100824a6a0fe55283eef2"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.1/bnw-0.11.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3175483f55a07017d8ecb42a67644c7c1bbe9cd138a7d9ad72ce53afd18b2aeb"
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
