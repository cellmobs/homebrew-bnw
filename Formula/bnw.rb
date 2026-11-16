class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.5/bnw-0.11.5-universal-apple-darwin.tar.gz"
  sha256 "0f613937ddc5ac787a6d14f459adf49366aab5824c24f66dff31cc4bf23dd3c6"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.5/bnw-0.11.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ccf9dad8fd5bd07367d9417d7633faf436f0bce4a781075a58749512a2accf0f"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.5/bnw-0.11.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8a7e18d0d7340f977e7825b9f35f2e93a8c76afd590994b5c3fe645b20f43dff"
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
