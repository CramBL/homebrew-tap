class GeotraceC < Formula
  desc "C/C++ SDK for the GeoTrace .gtd navigation data format"
  homepage "https://github.com/CramBL/geotrace"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.0/geotrace-sdk-aarch64-apple-darwin.tar.gz"
      sha256 "00fae4bde7e9d642701687f8feb316e046f00dd1e3286bb09ae22d313e5141bc"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.0/geotrace-sdk-x86_64-apple-darwin.tar.gz"
      sha256 "4294bffaa35af5bf107d467e05e70d8d5f9c0ad9720bbe750ca97ab87242d644"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.0/geotrace-sdk-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2c4811b137efe88b79a8bee6dcaafc7aa9ecdb8eb081d2b12c05e78511e5b2b9"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.5.0/geotrace-sdk-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "937091e6cc630fbe854a2c512898f1e8d703064a50032b9e82a582bba867aad6"
    end
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_predicate include/"geotrace.h", :exist?
  end
end
