class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.4/bnw-0.11.4-universal-apple-darwin.tar.gz"
  sha256 "e41a55c403d54333428c46f410357c9547fe2a62cd637d00cfa4673f47d99194"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.4/bnw-0.11.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0dc06d433ebfc42eb9c4bc66b8aeba89292ed6f1dcf23c4822cf3d60495e4f06"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.4/bnw-0.11.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a138bd057672a2c2e04c4d38f45e68bb99dd80d9147f877985b0db2d24c2a631"
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
