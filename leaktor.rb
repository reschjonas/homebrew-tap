class Leaktor < Formula
  desc "Secrets scanner with pattern matching, entropy analysis, and live validation"
  homepage "https://github.com/reschjonas/leaktor"
  url "https://github.com/reschjonas/leaktor/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "01448ab3ebcce77bf30ae8891358e17ad35bb24d622e5170c1dd3517eab92370"
  license "MIT"
  head "https://github.com/reschjonas/leaktor.git", branch: "master"

  depends_on "rust" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl@3"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "leaktor", shell_output("#{bin}/leaktor --version")

    # Create a test file with a fake secret
    (testpath/"test.txt").write("AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE")

    # Run leaktor scan
    output = shell_output("#{bin}/leaktor scan #{testpath} 2>&1")
    assert_match "AWS Access Key", output
  end
end
