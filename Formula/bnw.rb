class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.11/bnw-0.7.11-universal-apple-darwin.tar.gz"
  sha256 "e360a180a80a96077f893ab5d91e983cab24f8f21c2618a2dbbfe84d55f3ce32"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.11/bnw-0.7.11-x86_64-unknown-linux-musl.tar.gz"
      sha256 "eef799f21f6a30839ae86e3caaf3fd74accdbe2f9c990591d2a9f0192b7e40b7"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.11/bnw-0.7.11-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6f1aedfbdde52461a847b234203e6cfed421bca8e8514429f1d53f07fe91aa45"
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
