class Asleep < Formula
  desc "An advanced suspend-aware sleep utility with live countdown and flexible datetime parsing"
  homepage "https://github.com/CramBL/asleep"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/asleep/releases/download/v0.1.0/asleep-aarch64-apple-darwin.tar.xz"
      sha256 "afb9a0ea16577f5e4ecb45659cbec0760b58670a3049edca56822d040d3dcf06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/asleep/releases/download/v0.1.0/asleep-x86_64-apple-darwin.tar.xz"
      sha256 "e3a7c5be0fa40ad962fdce355c071fe360c142cd6ce01842005412cff32ba428"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/CramBL/asleep/releases/download/v0.1.0/asleep-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "284795bfeb985939aebbd62da6c374d8f73ff49dd00753966816cb36317d4a75"
    end
    if Hardware::CPU.intel?
      url "https://github.com/CramBL/asleep/releases/download/v0.1.0/asleep-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fb2c23d9e6fc62ab9133ea6f6ceecba2f6984b2f8f5554b571356047a91e97a2"
    end
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "asleep" if OS.mac? && Hardware::CPU.arm?
    bin.install "asleep" if OS.mac? && Hardware::CPU.intel?
    bin.install "asleep" if OS.linux? && Hardware::CPU.arm?
    bin.install "asleep" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
