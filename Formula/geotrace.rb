class Geotrace < Formula
  desc "High-performance GNSS data visualizer, with advanced debugging and anomaly detection capabitilies"
  homepage "https://github.com/CramBL/geotrace"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.2.0/geotrace-aarch64-apple-darwin.tar.gz"
      sha256 "87be43daa2ac0e0e40d1f93941a9c99007a0cbc9aeda832228830becb1ed150e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.2.0/geotrace-x86_64-apple-darwin.tar.gz"
      sha256 "09b1218e20cebc1828980df857e2f05486ca9c9e5dadda681c35c51d675a4f1d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.2.0/geotrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9e550cfe59bbfc08cc0b1c180865ad690c84da6d0328710a5ad1c664c267f50d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.2.0/geotrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e6e234057b6936a951f263e56dccc63e1492a10055b23c01e29299c2ec8532f"
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
