class Geotrace < Formula
  desc "High-performance GNSS data visualizer, with advanced debugging and anomaly detection capabitilies"
  homepage "https://github.com/CramBL/geotrace"
  version "0.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.16.0/geotrace-aarch64-apple-darwin.tar.gz"
      sha256 "e9eedc6540312cf1ac860ee9ae031c976f7246a866d6854bdb1b0c20e2e0b4c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.16.0/geotrace-x86_64-apple-darwin.tar.gz"
      sha256 "d7e1dad5e79d626db38d3ec4b103c1db287d68be08ba65c476a3150524399a53"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.16.0/geotrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "792dcd55db0038d682541f376bcc76a09ac8973e44477e68b8b0a92c50fed631"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.16.0/geotrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31a1f1369c637e6d57f538ffa31ea4b94bde421d2f4068a016979334babf0a82"
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
