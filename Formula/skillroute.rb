class Skillroute < Formula
  include Language::Python::Virtualenv

  desc "Local-first skill routing for coding agents, by JEStats"
  homepage "https://jestats.io"
  url "https://files.pythonhosted.org/packages/be/51/760e81cb44efd88c0162a23c655bfcc270aed6c4d10254e532445c42b41e/skillroute-0.6.0.tar.gz"
  sha256 "b8b6e6f3d535f1397b9745987d085813c6b07f587f0fe6c3b013fb2b42325ba4"
  license "MIT"

  depends_on "python@3.13"

  # No resources: skillroute has no runtime dependencies. The web UI's fastapi
  # and uvicorn live in the `ui` extra and are deliberately not installed here,
  # which is what keeps this formula free of pydantic-core and its Rust build.

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skillroute --version")
    # Exercises the bundled harness manifests, so a wheel that failed to package
    # skillroute/_harnesses fails the test rather than shipping broken.
    assert_match "claude-code", shell_output("#{bin}/skillroute harness list")
  end
end
