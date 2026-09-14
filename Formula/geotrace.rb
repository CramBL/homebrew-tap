class Geotrace < Formula
  desc "High-performance GNSS data visualizer, with advanced debugging and anomaly detection capabitilies"
  homepage "https://github.com/CramBL/geotrace"
  version "0.17.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.17.0/geotrace-aarch64-apple-darwin.tar.gz"
      sha256 "bb8f603393dea09f83ddaafaf2be11bd02289f3731e25b8d5406c20c7b79b26e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.17.0/geotrace-x86_64-apple-darwin.tar.gz"
      sha256 "a9b4f505b8826dee6a5d010cf8635163faeb51e1998f9827144c49edee4d4352"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.17.0/geotrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2cd76c022de4cafdd67f141c3cd0a8daafc1e6024fb3a431fb46be9b621ac56a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/geotrace/releases/download/app/v0.17.0/geotrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fb5e6ba8b6a2758cb8818b95448c06044a8198b059296945b1276faf92bfe704"
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
