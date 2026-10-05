class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.9/bnw-0.7.9-universal-apple-darwin.tar.gz"
  sha256 "93cbcb3f65c1cad033a2ce7c46aa95bd5d32c4d599d0a3768840a8cf7119320a"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.9/bnw-0.7.9-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f815e89df203783a9851273b973aeb3a7f757b45f79930b3b4b39c104ad76751"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.9/bnw-0.7.9-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fb068fb5eab0872022a677e7b155164c75d76eed76b5e88ce69f1d75425f9436"
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
