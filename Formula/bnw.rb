class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.1/bnw-0.8.1-universal-apple-darwin.tar.gz"
  sha256 "887ea1023b10eaa3a3ddca325333786c275a815699fa7abcf0b6b5cb04d1e711"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.1/bnw-0.8.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0fc643ac41313b3633ff56815780e7f15323345f43e737ab9d5d26c7109f5260"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.1/bnw-0.8.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "28866b4a45ac10cbf18f848ef9781c944958c85e0ee909a84a99eb5e0ab325be"
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
