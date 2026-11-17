class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.6/bnw-0.11.6-universal-apple-darwin.tar.gz"
  sha256 "a224fa2b94bfeae1cd457649b778116da61a5df7fc78ff124a3202d9ff96f64d"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.6/bnw-0.11.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "80f5eeea48901c3d17daec3c3aaa6ef0cad53a65d00dd423f0f26658fdfb5f19"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.6/bnw-0.11.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b997dc21ead5918602bb83b26053064d0d4a4e9acb44d9e6c4df7d465f1c22ca"
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
