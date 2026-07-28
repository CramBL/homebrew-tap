class Geotrace < Formula
  desc "High-performance GNSS data visualizer, with advanced debugging and anomaly detection capabitilies"
  homepage "https://github.com/CramBL/geotrace"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.10.0/geotrace-aarch64-apple-darwin.tar.gz"
      sha256 "20493d6c90e605b367542847aa59c6a4bbe480febc02f75b3506e6de8f90a447"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.10.0/geotrace-x86_64-apple-darwin.tar.gz"
      sha256 "56343fadb10be4fae353c9d4b92d68dddd2fb107649b44c5ff6910a37448ddce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.10.0/geotrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a3a121dc690705465a91393e53df5a8fa212ac28c0aa70644d65f68900c082c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.10.0/geotrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6276607aed5a3ddd5c74a2b497793bb187be88747e5d89995dd7a086a178dbeb"
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
    bin.install "geotrace" if OS.mac? && Hardware::CPU.arm?
    bin.install "geotrace" if OS.mac? && Hardware::CPU.intel?
    bin.install "geotrace" if OS.linux? && Hardware::CPU.arm?
    bin.install "geotrace" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
