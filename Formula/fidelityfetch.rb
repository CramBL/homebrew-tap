class Fidelityfetch < Formula
  desc "Seamlessly setup a webserver to serve files recursively from a specified path"
  homepage "https://github.com/CramBL/fidelityfetch"
  version "1.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.2.0/fidelityfetch-aarch64-apple-darwin.tar.gz"
      sha256 "e75e9f14081f86900959994077f954462c2f88e48d9979329d13b6970392e10e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.2.0/fidelityfetch-x86_64-apple-darwin.tar.gz"
      sha256 "04c2518717eaf118c4e3ff91dbfba7361fa1420e3593e59b9b112f4ace640dec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.2.0/fidelityfetch-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7cf4959d2edf5d56372403b52fa62de9a465c81d3556dbea1c25081340472879"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.2.0/fidelityfetch-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7b2ac627c0273767e686890f0ec4d08f88ea92cd174d8c623312268cdac56faa"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":                   {},
    "aarch64-unknown-linux-gnu":              {},
    "aarch64-unknown-linux-musl-dynamic":     {},
    "aarch64-unknown-linux-musl-static":      {},
    "arm-unknown-linux-gnueabihf":            {},
    "arm-unknown-linux-musl-dynamiceabihf":   {},
    "arm-unknown-linux-musl-staticeabihf":    {},
    "armv7-unknown-linux-gnueabihf":          {},
    "armv7-unknown-linux-musl-dynamiceabihf": {},
    "armv7-unknown-linux-musl-staticeabihf":  {},
    "x86_64-apple-darwin":                    {},
    "x86_64-pc-windows-gnu":                  {},
    "x86_64-unknown-linux-gnu":               {},
    "x86_64-unknown-linux-musl-dynamic":      {},
    "x86_64-unknown-linux-musl-static":       {},
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
    bin.install "fife" if OS.mac? && Hardware::CPU.arm?
    bin.install "fife" if OS.mac? && Hardware::CPU.intel?
    bin.install "fife" if OS.linux? && Hardware::CPU.arm?
    bin.install "fife" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
