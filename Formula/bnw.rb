class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.4/bnw-0.7.4-universal-apple-darwin.tar.gz"
  sha256 "80a559e482ebfdf97b7c3f3308fe5ca2f5ad113b47ea50e16e6f65700bd01f50"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.4/bnw-0.7.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "725cccd7d8c938f7d37b85a9beb5ab4f6030bc90276f1cdfd83568e7ff2085b5"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.4/bnw-0.7.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c86105b2ca5aaafcdc516a7c93f73cac5423595c2db9ac203e21ba9acb59b1de"
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
