class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.6/bnw-0.8.6-universal-apple-darwin.tar.gz"
  sha256 "bd1a0a69ce8c7f18c0ea43cb7a8c6f14b7c02ec18e77d54ede951926b34790aa"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.6/bnw-0.8.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e149275bf71b3c881932469c30aa683a838b5a03ac3b0340f3c1633250081ebb"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.6/bnw-0.8.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fd981940923cbbe69acfa878f4d42b8ba95c31d4b3665a1efaa634fff0811302"
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
