class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.3/bnw-0.9.3-universal-apple-darwin.tar.gz"
  sha256 "d94d98124587af1a01df21a1c65b218f28ec013cd0e7d9fe15449e8e3f9ba646"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.3/bnw-0.9.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d902ed588d367f0bbc8b0e5f023c1b7395dd6b85d6dd83217e6975ca2d939db3"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.3/bnw-0.9.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3045b0117cda7b7aac366c45636a01ab6d5756f5ad6bcfeac69414a37b4a989d"
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
