class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.3/bnw-0.11.3-universal-apple-darwin.tar.gz"
  sha256 "6485c44d01cdfe93bca12abd3895b31b9640aa5dfbc11b29085bae917351f7dc"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.3/bnw-0.11.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "58bcbecc88ea64952871c4df22e99debd6ccc9a40597d767f6d412c1bb217e35"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.3/bnw-0.11.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8c9a186d84f8051d058f18611a77b7c0d0ca387798a99aa71a0e97f7ae2259dd"
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
