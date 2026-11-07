class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.7/bnw-0.8.7-universal-apple-darwin.tar.gz"
  sha256 "263852172c71166756e6a500618a069f39a7b07f1007eb3031c9c7a02d06045b"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.7/bnw-0.8.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "dc829f853abec0cdde70b45d40d2be48945c54c53d8c55308ce3c409d8f046d7"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.8.7/bnw-0.8.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a208b6b2b9752d07a3df9429292e4fe47f1785d77892fd92c18727799d391976"
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
