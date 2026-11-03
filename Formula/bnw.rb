class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.5/bnw-0.8.5-universal-apple-darwin.tar.gz"
  sha256 "62934a3a81e3819895337d72f1f68c9b2155c7941ba90075834ee4853c1c3ece"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.5/bnw-0.8.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0f970ff67f78835f96d48aa6cb33bf93b62978510a39b2a5178db449e39f2063"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.5/bnw-0.8.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "176cc83d3ed6f6799afa25b37d9c3408365095c0d8a697bb597f550720a5d86b"
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
