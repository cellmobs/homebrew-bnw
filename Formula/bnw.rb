class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.10.0/bnw-0.10.0-universal-apple-darwin.tar.gz"
  sha256 "f88518d9ae7317e26d13d2077196ac20a1e7cceea8e97e5dfc1754c87592464c"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.10.0/bnw-0.10.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e0278c4d23961cbcb3ec5f06239c5bcf9b7e9de54c7ff39ea502a389dc7b2202"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.10.0/bnw-0.10.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4b8f6eb9b7f4a142cf032156b3add6e10671e3ab77017ccbd88ae1240ffe840b"
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
