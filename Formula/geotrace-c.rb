class GeotraceC < Formula
  desc "C/C++ SDK for the GeoTrace .gtd navigation data format"
  homepage "https://github.com/CramBL/geotrace"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.2.0/geotrace-sdk-aarch64-apple-darwin.tar.gz"
      sha256 "fcdc6330b3be75fb8fc62a24b319a8694aadde210e0b5b6773d35128922d2545"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.2.0/geotrace-sdk-x86_64-apple-darwin.tar.gz"
      sha256 "29f6a33ffa2deaaf741787f38cdb67a810966dbec1e964d607edcd6098f05612"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.2.0/geotrace-sdk-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "09c7abb9bb9a7d0c7de688f3e959a9193242103f12d470d8ef0815b3f2258456"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.2.0/geotrace-sdk-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0f9b9ae2f011035e30280aacd99f68b5a11878fbc3c368da423f97595a59ce87"
    end
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_predicate include/"geotrace.h", :exist?
  end
end
