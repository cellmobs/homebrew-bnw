class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.2/bnw-0.7.2-universal-apple-darwin.tar.gz"
  sha256 "a54452993edd5920f79a909d1ded4757b3bde97a8091349d8a95519aee488c2c"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.2/bnw-0.7.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b1c20cc6cf9a93f94bc9f68b4015bfd429a98b4cc17c4ac1e2c170ffb5aeaeb1"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.2/bnw-0.7.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ef6af0638a39f99881e9496e04425d119c368ff96e7bbaf556a72e95dd805b68"
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
