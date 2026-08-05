class Geotrace < Formula
  desc "High-performance GNSS data visualizer, with advanced debugging and anomaly detection capabitilies"
  homepage "https://github.com/CramBL/geotrace"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.11.0/geotrace-aarch64-apple-darwin.tar.gz"
      sha256 "8bbfd34a4aad3f8d96b985dd1af83691c4af8995970abcd83f1cf0c53fcfff15"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.11.0/geotrace-x86_64-apple-darwin.tar.gz"
      sha256 "935369ff7c944c3f681223ebb012e3b5bc2a673755bbd5f10ead31aab3a78cad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.11.0/geotrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fe70782a1198f57cb7d18bda10caba750dec2d3f9d8a4b50cb3a317142266982"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.11.0/geotrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b2f3917988369919f4dba1a5e393a48843d338859dc166401b5ee11fa722b032"
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
