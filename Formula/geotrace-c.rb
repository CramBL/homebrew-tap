class GeotraceC < Formula
  desc "C/C++ SDK for the GeoTrace .gtd navigation data format"
  homepage "https://github.com/CramBL/geotrace"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.4.0/geotrace-sdk-aarch64-apple-darwin.tar.gz"
      sha256 "ed188d60649139f7e66d669f938effaab0d67c5995a089ca1430ad000f3febcb"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.4.0/geotrace-sdk-x86_64-apple-darwin.tar.gz"
      sha256 "bde91b9fb1c9c99877926bafbbcb50558b0a238710e57a097144624095d20f97"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.4.0/geotrace-sdk-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5a71157101fde2f2bc70ee35d24598730bd9ea64699398f8ae8393867eada9b"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.4.0/geotrace-sdk-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b19f3bf674e83f76f744a8cad340fcc4e916a51db104382ade04e6e0222a0678"
    end
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_predicate include/"geotrace.h", :exist?
  end
end
