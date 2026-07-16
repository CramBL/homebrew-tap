class GeotraceC < Formula
  desc "C/C++ SDK for the GeoTrace .gtd navigation data format"
  homepage "https://github.com/CramBL/geotrace"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.0/geotrace-sdk-aarch64-apple-darwin.tar.gz"
      sha256 "f63885f288f647ab5a91a31e70078e99aca1efaec6257b57bd26d6db980a64ce"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.0/geotrace-sdk-x86_64-apple-darwin.tar.gz"
      sha256 "7c7b3d4e4df8caa8bda2cb99828281fdb9f77cc1e7e8eb49f756f66b4fbd4f68"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.0/geotrace-sdk-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "85d04e0c2412d71adbe8c6b597bf581052b699582fe626fd3b1a67b2e87eb89d"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.0/geotrace-sdk-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "71453da9e7ef693006782ecb3dd86d956ff34bafed7affa22a6da6f3939cf901"
    end
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_predicate include/"geotrace.h", :exist?
  end
end
