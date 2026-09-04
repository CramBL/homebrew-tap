class Geotrace < Formula
  desc "High-performance GNSS data visualizer, with advanced debugging and anomaly detection capabitilies"
  homepage "https://github.com/CramBL/geotrace"
  version "0.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.15.0/geotrace-aarch64-apple-darwin.tar.gz"
      sha256 "7234ded303256b79fafc755244387d065087686b227a5b901e720417df33fe18"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.15.0/geotrace-x86_64-apple-darwin.tar.gz"
      sha256 "69cb5297417ec39f69bd2591560fe16296909ae7e7257f67502ef02cd37048d2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.15.0/geotrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "04d72a132f35791be741f9848dec7beefeb0e686b309aa38ce96fdfb78657b5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.15.0/geotrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ab232fa5e5717a11f6348d54139d52d70323b42bf0277caaa002bab2f62dd8b2"
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
