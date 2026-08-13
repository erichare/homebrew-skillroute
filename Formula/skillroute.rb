class Skillroute < Formula
  include Language::Python::Virtualenv

  desc "Local-first skill catalog and router for agent builders"
  homepage "https://github.com/erichare/skillroute"
  url "https://files.pythonhosted.org/packages/4f/8e/7f510c52467a162ff5b10e5d8a0d331f0596eed18d42190acc7041ee9a97/skillroute-0.3.0.tar.gz"
  sha256 "e9a76e06f136e9f03fb97743da9e864dc07f8cbf31dc750d6b72a1fc60ef61e6"
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
