class GeotraceC < Formula
  desc "C/C++ SDK for the GeoTrace .gtd navigation data format"
  homepage "https://github.com/CramBL/geotrace"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.6.0/geotrace-sdk-aarch64-apple-darwin.tar.gz"
      sha256 "a05571e70b43e9ce1d12c216c9ba680fa88974348a84020dab7520edbe79df38"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.6.0/geotrace-sdk-x86_64-apple-darwin.tar.gz"
      sha256 "f474431e76c48bfdd5c946658de2e766a6c70d3e301c527ed3005fa808d1e3a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.6.0/geotrace-sdk-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "32d483d5e248735696412a3776bacf10a12d9a78d10d249ba81f001efd8c4fa4"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.6.0/geotrace-sdk-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "24101744ada609fdbc0275b2585b5cd2f85e19f51b89a9c99e07a1ab946de058"
    end
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_predicate include/"geotrace.h", :exist?
  end
end
