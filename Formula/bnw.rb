class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.1/bnw-0.9.1-universal-apple-darwin.tar.gz"
  sha256 "7a53f207e487033a7b6c4bb3a84d59673130f0d86320053c243a43c31debcad4"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.1/bnw-0.9.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0af880b98900af8ee59c1d97c796eb879daadd4dc293bb6fbcb7f4c6191a5c96"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.1/bnw-0.9.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5d5e9f6d7fb17e6c01b5235d1cb3f9f2b1e931e1bfba3acbad4077d523f29628"
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
