class Fidelityfetch < Formula
  desc "Seamlessly setup a webserver to serve files recursively from a specified path"
  homepage "https://github.com/CramBL/fidelityfetch"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.1.0/fidelityfetch-aarch64-apple-darwin.tar.gz"
      sha256 "71abe23f81c9986b784cc1c8ef86d91d7503b971e0ef65e2641359eba219f4c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.1.0/fidelityfetch-x86_64-apple-darwin.tar.gz"
      sha256 "037df34e6bb5eb9ecc8452c18fe6372fbc4d207a976a3a5208160e8ee68d8baa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.1.0/fidelityfetch-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "06ca4c562cf87c2b743426b1baf2e5380082d8e72c009a47074a17cf85b17dfb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.1.0/fidelityfetch-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fb6c4f2f75123c6d07ce66fdb2766f9ca689bd80e89f75f4e3eba22801074a15"
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
