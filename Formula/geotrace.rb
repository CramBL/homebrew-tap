class Geotrace < Formula
  desc "High-performance GNSS data visualizer, with advanced debugging and anomaly detection capabitilies"
  homepage "https://github.com/CramBL/geotrace"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.4.0/geotrace-aarch64-apple-darwin.tar.gz"
      sha256 "986b95f99691244384a9a94c3bf485acfcd0da71bf0b6b2c88b728eb098a8bd7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.4.0/geotrace-x86_64-apple-darwin.tar.gz"
      sha256 "8b12c356f29d636ed399815a573c7e900bb5366f3e6edfbfe2addac50d59668d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.4.0/geotrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fe347453e404e0e00fccc39476f495745b9061c1b1936ad9b4dbab91eaa80fa0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.4.0/geotrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1528b156ac87452f1107bb0391462fe0d17aa3ef171a180710f35caede81a23c"
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
