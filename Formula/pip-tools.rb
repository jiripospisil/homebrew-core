class PipTools < Formula
  include Language::Python::Virtualenv

  desc "Locking and sync for Pip requirements files"
  homepage "https://pip-tools.readthedocs.io"
  url "https://files.pythonhosted.org/packages/62/f6/97bcd8a0c3c673ead0cbecfd7d0f98d856d94d4d791616f5989afcc17a9c/pip-tools-6.10.0.tar.gz"
  sha256 "7f9f7356052db6942b5aaabc8eba29983591ca0ad75affbf2f0a25d9361be624"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4154d524f99ae2a56da47856c76fb29de1aa3e5c714ad0c8b5340073b30e07ec"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "68fb24a82a2f8cde0979e39b3c4225a87c8442699113ea468160f9bd36028868"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "bfb9ede6d5804057bc62c951dc768c0fdc75adccc1ebff67449288ca59a8f098"
    sha256 cellar: :any_skip_relocation, ventura:        "212c13015bf9bcf1fee20c5862fb651b2b053d6dcba78fe55debef035a03ef45"
    sha256 cellar: :any_skip_relocation, monterey:       "488adaeb88f570a423ccef15fe4e920bec2851b909b76caa37714d6e878512af"
    sha256 cellar: :any_skip_relocation, big_sur:        "2e45d6346d2036440843650eabba72b1223be310ca142870930878c53298b1c3"
    sha256 cellar: :any_skip_relocation, catalina:       "04b6f6bf9c8ae31398ae28bb8600325924ba6b6a1f16d0611625277199d251d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1e01d40a60a9b56065c6c9ee76f2b364bb55a68d20c53258f53c73c8a32e65c9"
  end

  depends_on "python@3.11"

  resource "build" do
    url "https://files.pythonhosted.org/packages/0f/61/aaf43fbb36cc4308be8ac8088f52db9622b0dbf1f0880c1016ae6aa03f46/build-0.9.0.tar.gz"
    sha256 "1a07724e891cbd898923145eb7752ee7653674c511378eb9c7691aab1612bc3c"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/59/87/84326af34517fca8c58418d148f2403df25303e02736832403587318e9e8/click-8.1.3.tar.gz"
    sha256 "7682dc8afb30297001674575ea00d1814d808d6a36af415a82bd481d37ba7b8e"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/df/9e/d1a7217f69310c1db8fdf8ab396229f55a699ce34a203691794c5d1cad0c/packaging-21.3.tar.gz"
    sha256 "dd47c42927d89ab911e606518907cc2d3a1f38bbd026385970643f9c5b8ecfeb"
  end

  resource "pep517" do
    url "https://files.pythonhosted.org/packages/4d/19/e11fcc88288f68ae48e3aa9cf5a6fd092a88e629cb723465666c44d487a0/pep517-0.13.0.tar.gz"
    sha256 "ae69927c5c172be1add9203726d4b84cf3ebad1edcd5f71fcdc746e66e829f59"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/71/22/207523d16464c40a0310d2d4d8926daffa00ac1f5b1576170a32db749636/pyparsing-3.0.9.tar.gz"
    sha256 "2b020ecf7d21b687f219b71ecad3631f644a47f01403fa1d1036b0c6416d70fb"
  end

  resource "wheel" do
    url "https://files.pythonhosted.org/packages/a2/b8/6a06ff0f13a00fc3c3e7d222a995526cbca26c1ad107691b6b1badbbabf1/wheel-0.38.4.tar.gz"
    sha256 "965f5259b566725405b05e7cf774052044b1ed30119b5d586b2703aafe8719ac"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"requirements.in").write <<~EOS
      pip-tools
      typing-extensions
    EOS

    compiled = shell_output("#{bin}/pip-compile requirements.in -q -o -")
    assert_match "This file is autogenerated by pip-compile", compiled
    assert_match "# via pip-tools", compiled
  end
end
