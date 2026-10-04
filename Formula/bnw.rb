class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.6/bnw-0.7.6-universal-apple-darwin.tar.gz"
  sha256 "9d65a9478efa6d7cef6fad63b696587d1cd4e109bc1f1b698b8452426e8cc83f"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.6/bnw-0.7.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7256635ce53284b3f527cb324ce006d1f30de506fd4700bbd942edd49bcf09ee"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.6/bnw-0.7.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cb17fce9e284935278e5cae5b5bb170a80e7bfec8edab304e9d6821f1316c935"
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
