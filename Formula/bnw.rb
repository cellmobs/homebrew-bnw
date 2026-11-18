class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.7/bnw-0.11.7-universal-apple-darwin.tar.gz"
  sha256 "2f9e43742229fbc6595e4b6dacb6902d9f25171a7d428ed668b63bd9de0b6568"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.7/bnw-0.11.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e6f32a50ca6137b0c80bd1c820478fea369683e83aae1475e43e4e72777edade"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.7/bnw-0.11.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bbdc55514f5052f05a2dbb3b1d33706fa92150a8c75f78c1f9dfadf1712ecc14"
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
