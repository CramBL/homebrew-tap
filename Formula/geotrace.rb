class Geotrace < Formula
  desc "High-performance GNSS data visualizer, with advanced debugging and anomaly detection capabitilies"
  homepage "https://github.com/CramBL/geotrace"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.12.0/geotrace-aarch64-apple-darwin.tar.gz"
      sha256 "1e6bfb45ce9afb48531f340eadab25958bf631d01fe02054195f324b0c58d62e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.12.0/geotrace-x86_64-apple-darwin.tar.gz"
      sha256 "a85a00108543d0571630d4bb237d74493dc7bd1b9f2ae8b2db0e8aad5eea85ea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.12.0/geotrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2fab131c3abbcfea62d8c53b599aa1c7d4ee36ee60b8809f3809ec93761dc240"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.12.0/geotrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "320cb4136bc38c1f1dc9204515ff2fe536a1ab7121cca956e922a78881ba5848"
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
