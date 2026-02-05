# typed: false
# frozen_string_literal: true

# Homebrew formula for container-source-policy - auto-generated, do not edit manually
class ContainerSourcePolicy < Formula
  desc "CLI tool for generating BuildKit source policy files"
  homepage "https://github.com/wharflab/container-source-policy"
  license "Apache-2.0"
  version "0.5.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/container-source-policy/releases/download/v0.5.2/container-source-policy_0.5.2_MacOS_arm64.tar.gz"
      sha256 "43bcb5402246f5f363fc0fa1b03155bbd3b2405f889f16f5214bbc47b08d86ed"
    else
      url "https://github.com/wharflab/container-source-policy/releases/download/v0.5.2/container-source-policy_0.5.2_MacOS_x86_64.tar.gz"
      sha256 "209e6116c2dd886e4f54771caf246c1207cf828b703eca542bef43a8d14cd5b0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/container-source-policy/releases/download/v0.5.2/container-source-policy_0.5.2_Linux_arm64.tar.gz"
      sha256 "54282777e5b8768fb161a63ad4a894ec9d20efad1630c393d2c72ee55a13bec9"
    else
      url "https://github.com/wharflab/container-source-policy/releases/download/v0.5.2/container-source-policy_0.5.2_Linux_x86_64.tar.gz"
      sha256 "b61a9320c1b3895b373b1338c165f778dfc1ed553f11b9f53bcb947bdfea46dc"
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
