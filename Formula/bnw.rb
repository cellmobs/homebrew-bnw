class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.10.2/bnw-0.10.2-universal-apple-darwin.tar.gz"
  sha256 "caa4ed4760afa837efdda045cdee78b3993d7e2aac0906381f2e1f5e21924185"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.10.2/bnw-0.10.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "84c51b0befdcb5c21c76e89659472e6f12c7184a4e560e995c1042329ca18f2c"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.10.2/bnw-0.10.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7a7e19352c00251c0985a1a802b7b4728fd7a2fae430bb05346bb8ddf3468f45"
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
