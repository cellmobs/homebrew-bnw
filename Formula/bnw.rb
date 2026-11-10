class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.4/bnw-0.9.4-universal-apple-darwin.tar.gz"
  sha256 "3dd37c402a2442bfa559cfe7174a94e96913eae30b6986e7ce2d1d924d9f6afb"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.4/bnw-0.9.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a60c4004791d7629197da12bf62c124ec38cefc76c35b97620568cff4986f2c1"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.4/bnw-0.9.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "391f295e2d26090f9dd06666555a52acc99cee6c95a027459f058831646976a9"
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
