class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.15/bnw-0.7.15-universal-apple-darwin.tar.gz"
  sha256 "dcf5518abbbe3d9e977049b032c7c983e9fe453d1d76e1f70917d8d3bf15a5c2"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.15/bnw-0.7.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6dcfa0577e1fb877db1381dcd2f58bd1116a23b94fc1b6a19929923f42b3a8ae"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.15/bnw-0.7.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6c74d0bd40bf8acd2efb7801d5d3ac7becbdd8604cae7e9e0df99f93093c33e9"
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
