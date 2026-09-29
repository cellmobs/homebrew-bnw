class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.0/bnw-0.7.0-universal-apple-darwin.tar.gz"
  sha256 "a51f358f44066ec9098535a89442c3b2a9fa82172a86cfda5423f7cce8861ef9"
  license any_of: ["MIT", "Apache-2.0"]


  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.0/bnw-0.7.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e5cfb93d9af76ea011c15e0b9d8b7793145f8d3eb0113f9f07155752e7e3ba22"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.0/bnw-0.7.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8eaabe628e67fea88908f76439c71f7555b6b15b62cfcfb88041754d2ff5fcd1"
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
