class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.12/bnw-0.7.12-universal-apple-darwin.tar.gz"
  sha256 "5395ec0f5e1502321e81ab74f224f5a5f7abdb758ec66e4a4cd782a251912521"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.12/bnw-0.7.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ed9be58ed00fbf99b631199f15f1d767bcd4f06d2cd57ea6d0bee23454329830"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.12/bnw-0.7.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3b09b394cab9198547204ace7daaa7d8cc75d34538c99264eb753d45369fb887"
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
