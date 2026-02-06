# typed: false
# frozen_string_literal: true

# Homebrew formula for container-source-policy - auto-generated, do not edit manually
class ContainerSourcePolicy < Formula
  desc "CLI tool for generating BuildKit source policy files"
  homepage "https://github.com/wharflab/container-source-policy"
  license "Apache-2.0"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/container-source-policy/releases/download/v0.6.0/container-source-policy_0.6.0_MacOS_arm64.tar.gz"
      sha256 "c29ed2e03a6535d2af4e110d9c910f25a36654672521ee2c55aaa430f819c7a2"
    else
      url "https://github.com/wharflab/container-source-policy/releases/download/v0.6.0/container-source-policy_0.6.0_MacOS_x86_64.tar.gz"
      sha256 "1712f1270aa669ade349c664edadc20652735414aff717a812c02a502c2e726b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/container-source-policy/releases/download/v0.6.0/container-source-policy_0.6.0_Linux_arm64.tar.gz"
      sha256 "a801013434bdb58eb013ee95fc0015af318c774038663740c598e20be3e3ad57"
    else
      url "https://github.com/wharflab/container-source-policy/releases/download/v0.6.0/container-source-policy_0.6.0_Linux_x86_64.tar.gz"
      sha256 "0339da35defed2e2f625c288a3a454a3407b7797998639edbe25223a23ce1db1"
    end
  end

  def install
    bin.install "container-source-policy"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/container-source-policy version")
    assert_match "pin", shell_output("#{bin}/container-source-policy --help")
  end
end
