class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.17/bnw-0.7.17-universal-apple-darwin.tar.gz"
  sha256 "63942f04401a8e44eaa973304806e4789926a17edf8fe7384753cf5c68ff4784"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.17/bnw-0.7.17-x86_64-unknown-linux-musl.tar.gz"
      sha256 "85682f5d9a24b1da9cd12a2fb3acbef8976922fe3a9edcb7cbd02f425b5a5a68"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.17/bnw-0.7.17-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9ea558b131013dd194d19e05589b9047db9bcb62790bb30d3a412d21186feccd"
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
