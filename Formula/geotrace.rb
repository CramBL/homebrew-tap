class Geotrace < Formula
  desc "High-performance GNSS data visualizer, with advanced debugging and anomaly detection capabitilies"
  homepage "https://github.com/CramBL/geotrace"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.5.1/geotrace-aarch64-apple-darwin.tar.gz"
      sha256 "2d4ba464ad92383d17735fa683f50eb9a0753a20bde623816634b30bb2002131"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.5.1/geotrace-x86_64-apple-darwin.tar.gz"
      sha256 "8159f5716c58093608837ef0cdf50724ce43c80a1ce4e043743a4c0d8448cd9d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.5.1/geotrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "99fadc03ea1c420a9871302197deb216f985743367d7a8a8ebf9879f482e3f85"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.5.1/geotrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "38c6f62ea4b9ec7cca0035f4ae544b220c50655bfe8a88fcb58a036edfd35e85"
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
