class GeotraceC < Formula
  desc "C/C++ SDK for the GeoTrace .gtd navigation data format"
  homepage "https://github.com/CramBL/geotrace"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-aarch64-apple-darwin.tar.gz"
      sha256 "4d0d330e08816caf08bed3cd3e2a20c636ab32d34f9f4a7ef4468c5f1ba748e5"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-x86_64-apple-darwin.tar.gz"
      sha256 "a967291f780fdffc136eccfc8687c7d40fca098fe03e49e1aef08758c0f05981"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "06e4cdf8e2398b464e3fa9cc947103a909b950718760a27270518519b28ab232"
    end
    on_intel do
      url "https://github.com/CramBL/geotrace/releases/download/geotrace-sdk-v0.3.0/geotrace-sdk-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5a1fdaff66f2d3f3629799805fb2c6e49ed0cdc50c4c86c16cd3e172619f693e"
    end
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_predicate include/"geotrace.h", :exist?
  end
end
