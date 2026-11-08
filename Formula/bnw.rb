class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.0/bnw-0.9.0-universal-apple-darwin.tar.gz"
  sha256 "7a01f32099a852474e42ba7e86d1c7f05dff0d79c384b9ac25cf9ff5677939b3"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.0/bnw-0.9.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "780f283f750a05b3939dff3a122490aa20d1ee8845142619865b0bd41eef3f5b"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.0/bnw-0.9.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dc4dd85e509487f0667640d4b94246a18672c160d9aafe118cf0bdefd863ed6a"
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
