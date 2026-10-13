class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.13/bnw-0.7.13-universal-apple-darwin.tar.gz"
  sha256 "4d5e1b4d21cdc6aae02b36906d7835bd6927d4e223caa76556eb2e780cb0a95e"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.13/bnw-0.7.13-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e40d2e089694b68f3cba00de7381370fcaeba4e6a8da50261e9a82f2a0ef4226"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.13/bnw-0.7.13-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c30f4b902f38997f67a5cf4f5c94b185b47b34bdbd3229cf5403275015fe0b76"
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
