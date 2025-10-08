class Fidelityfetch < Formula
  desc "Seamlessly setup a webserver to serve files recursively from a specified path"
  homepage "https://github.com/CramBL/fidelityfetch"
  version "1.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.3.0/fidelityfetch-aarch64-apple-darwin.tar.gz"
      sha256 "26d121f671538a12ff16d55c3e0d9c22a4e4b060a9d093edcb884bea3d3fb5b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.3.0/fidelityfetch-x86_64-apple-darwin.tar.gz"
      sha256 "57bf42dc4cc380c75b9a55782e3834b94096f7b5a21dab0f3f7c8105ec2d33ad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.3.0/fidelityfetch-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3196950993f6f1141357e2b7bb8bf931c689212a4bf8bd63ea77758ee8a0dff3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/fidelityfetch/releases/download/v1.3.0/fidelityfetch-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "75a816806f38b098e50faee8084b0dcb059ca7c86a518d35a28579950df91907"
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
