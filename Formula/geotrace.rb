class Geotrace < Formula
  desc "High-performance GNSS data visualizer, with advanced debugging and anomaly detection capabitilies"
  homepage "https://github.com/CramBL/geotrace"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.14.0/geotrace-aarch64-apple-darwin.tar.gz"
      sha256 "4baa614ecec3bac4cae78a2e776e2011958c79849f22b1abd3565175d6d430d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.14.0/geotrace-x86_64-apple-darwin.tar.gz"
      sha256 "58a25040de23dbe24ed48220153fc73c82b1fb583668883a9504fd0f8ea7d974"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.14.0/geotrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a8d0a17ab5214854d151bf85a5613efa0f84983a7771fc0d30fcdadc729181eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.14.0/geotrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "570878c578a91bd7234069aac1ef1fc3d44541097c48d8ff6320e7b9d8e695ef"
    end
  end
  license "AGPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "geotrace"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "geotrace"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "geotrace"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "geotrace"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
