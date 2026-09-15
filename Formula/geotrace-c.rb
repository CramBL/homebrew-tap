class GeotraceC < Formula
  desc "C/C++ SDK for the GeoTrace .gtd navigation data format"
  homepage "https://github.com/CramBL/geotrace"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.7.0/geotrace-sdk-aarch64-apple-darwin.tar.gz"
      sha256 "a477db50e7e9a6b73b15cf78bfd0aefd5c62a3a67bafad69895c5f53a04f7fee"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.7.0/geotrace-sdk-x86_64-apple-darwin.tar.gz"
      sha256 "1f1d2e9c37db1dc117771254297bb772e60f5bb72eabca5eaee35b0f72f8eb82"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.7.0/geotrace-sdk-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cf97671cf874c1687ea7905caa28e299bca45a0b3506c5cc9c306d2af9870bac"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.7.0/geotrace-sdk-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c42da7a7386fcec938a09305c176c1104c1c87cdb7614df784d12f6dee87ebf4"
    end
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_predicate include/"geotrace.h", :exist?
  end
end
