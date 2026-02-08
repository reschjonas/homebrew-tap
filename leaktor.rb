class Leaktor < Formula
  desc "Secrets scanner with pattern matching, entropy analysis, and live validation"
  homepage "https://github.com/reschjonas/leaktor"
  url "https://github.com/reschjonas/leaktor/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "d5a298bac16b42a563897ad98d3ddb2a41b5d3ebba9b44c5c57d677e6fa95b32"
  license "MIT"
  head "https://github.com/reschjonas/leaktor.git", branch: "master"

  depends_on "rust" => :build

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
