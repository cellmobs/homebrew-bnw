class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.2/bnw-0.11.2-universal-apple-darwin.tar.gz"
  sha256 "58ea73f8193be3cfd883cc81ad3a84cf67a05521bc063240ff39057e974c86ed"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.2/bnw-0.11.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3898d80fdf7c94ba9be6f172cab78fcded82ad3582818504cda0e2c7b2404262"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.11.2/bnw-0.11.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e47bbeb78aec190a0a61c35eefccf3c2d56a1d5e85c2d7929238052766b06fb8"
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
