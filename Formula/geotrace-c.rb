class GeotraceC < Formula
  desc "C/C++ SDK for the GeoTrace .gtd navigation data format"
  homepage "https://github.com/CramBL/geotrace"
  version "0.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.1/geotrace-sdk-aarch64-apple-darwin.tar.gz"
      sha256 "5abf80104f824deca219f024d4a7a37b1221ce46c24d10d947d90ceaab14ad92"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.1/geotrace-sdk-x86_64-apple-darwin.tar.gz"
      sha256 "e82ac38b00c79b46c2c032b61414fac0b7374133ed6a2c6cb1b7d36d3ee0e1fc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.1/geotrace-sdk-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ff2774361990c7b388971ee5009a9fde164be881c7eac322aee4a2b038e55fa7"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.1/geotrace-sdk-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "13d6bc2355bdb2ff647f8fee0ac15c7e92c709ddc18b28db4d21582c231c52d2"
    end
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_predicate include/"geotrace.h", :exist?
  end
end
