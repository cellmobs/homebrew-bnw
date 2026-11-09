class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.2/bnw-0.9.2-universal-apple-darwin.tar.gz"
  sha256 "2d7a1e589a7de8d9de8afdb65cece4cc5a7371b9b2a7b471b023652748a1d520"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.2/bnw-0.9.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "79ae71fecb495a785e6f6c4de0784dd0eb1521692dd7b292dc40a628091fd928"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.2/bnw-0.9.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5b2fdb5118c242f2155355c3b37c2406655c6ca69f7595aa7c8bf235a9f83f38"
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
