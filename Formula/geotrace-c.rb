class GeotraceC < Formula
  desc "C/C++ SDK for the GeoTrace .gtd navigation data format"
  homepage "https://github.com/CramBL/geotrace"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-aarch64-apple-darwin.tar.gz"
      sha256 "7b8a755a564bb46ea9c7538d255528ebd98b19a3e0e2299f6b4ad052a1c8e217"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-x86_64-apple-darwin.tar.gz"
      sha256 "ded1bf75dc52a2b04bcfd9767e77007a675cd73f8fa9f05a5d165f55c0b15677"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "064d3bcfdb97b8d79265000bc37d43e7176c76c25f131e101768ebeb02e15ed3"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f4377c41168f7484332cbae342b3523aad432926552a8b280800e59a9f276c6f"
    end
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_predicate include/"geotrace.h", :exist?
  end
end
