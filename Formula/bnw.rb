class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.8/bnw-0.7.8-universal-apple-darwin.tar.gz"
  sha256 "e8702456fc7487f4a482f418d13031b9b96ea67c0cc3fcc540c1ba61850de4a7"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.8/bnw-0.7.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ca531a4a3da40412e2d3c9064592e5c3bb715dea6ba2e7bd9f41f6429bff2eb3"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.7.8/bnw-0.7.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "364ff2192fca4e3bc84015ff0c142028aa2402dc8afb2b025138ef233a20f762"
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
