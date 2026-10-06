class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.10/bnw-0.7.10-universal-apple-darwin.tar.gz"
  sha256 "214a9eacc8677489611f5a4fa2921bb44fae07d244c4cb48277fdcd48e91d9bc"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.10/bnw-0.7.10-x86_64-unknown-linux-musl.tar.gz"
      sha256 "81cddf16fc5dcaefe1d24878339540c4325699b63e5e88bf75a41216b36b2977"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.10/bnw-0.7.10-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1df0c59cbe85f6e93a393cdfed631dad3680d4a8cca5a804c8c116d0ddb60e14"
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
