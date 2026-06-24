class GeotraceC < Formula
  desc "C/C++ SDK for the GeoTrace .gtd navigation data format"
  homepage "https://github.com/CramBL/geotrace"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-aarch64-apple-darwin.tar.gz"
      sha256 "cdb8520fbb0da8586f4150538039848302f554c31011e63cdf6d15d8a1678d86"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-x86_64-apple-darwin.tar.gz"
      sha256 "ee4eed4153691c3b60ba0d788097799ca248bacf1a58a3357c414e743f03699d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f16f03eca1b526183340575862d966daf5bee396c5c99d76ca7c717a013daa43"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bf8cc219415468c40782e8657292f0184af7939a31e39d87f9710bb0a3ba7fc0"
    end
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_predicate include/"geotrace.h", :exist?
  end
end
