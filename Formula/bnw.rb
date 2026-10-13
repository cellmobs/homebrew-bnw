class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.14/bnw-0.7.14-universal-apple-darwin.tar.gz"
  sha256 "27e7d3640596893be87670348433448bff2ab65eeea79f2d43732089f5669630"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.14/bnw-0.7.14-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ea80feb07bee1bd73a5c7fbace38c062e856decb0fcb5b0a2ffafdc014ab312a"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.14/bnw-0.7.14-aarch64-unknown-linux-musl.tar.gz"
      sha256 "22f5897a891c531a2977b92415ee8c9e383018d6de1c5235a0eba1aebb3c5eaa"
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
