class Bnw < Formula
  desc "Local-first peer-to-peer network for people, agents, and AI capabilities"
  homepage "https://github.com/cellmobs/bnw-releases"
  # The universal macOS build; Linux replaces it with its own below.
  url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.5/bnw-0.9.5-universal-apple-darwin.tar.gz"
  sha256 "721b8ac3e67074c1dab062d3c0a6f8faa95c9e375436cb729da15b66dd4e1308"
  license any_of: ["MIT", "Apache-2.0"]

  on_linux do
    on_intel do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.5/bnw-0.9.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "46adb0618caa211e327076e723f44525d8bade8acb21b7fc2fbc8b9cde3e9415"
    end
    on_arm do
      url "https://github.com/cellmobs/bnw-releases/releases/download/v0.9.5/bnw-0.9.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d2648cb688a990bd30eed2153eacc3b94a0be2166f2b96f5d8aecfbcb3b98a1f"
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
