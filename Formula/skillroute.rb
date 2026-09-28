class Skillroute < Formula
  include Language::Python::Virtualenv

  desc "Local-first skill catalog and router for agent builders"
  homepage "https://github.com/erichare/skillroute"
  url "https://files.pythonhosted.org/packages/a5/8a/f20d4ddeb0d5ece6d723dbdbcf720a57e3b064de6ba007f1183e79cea74f/skillroute-0.5.0.tar.gz"
  sha256 "dfa1dc0a069558290c94ec92d33d47c856c1fdd55af9f09e3b42f7e06fb199f0"
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
