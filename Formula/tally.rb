# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.23.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.23.0/tally_0.23.0_MacOS_arm64.tar.gz"
      sha256 "8fd1437a15e8c50463a0fc514069b068db43845198101c0ebff9984aed4a5376"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.23.0/tally_0.23.0_MacOS_x86_64.tar.gz"
      sha256 "dacdae230746b90c49064969cdbc0f63a2ee674a3f5665dd97b8e3fadcacdc69"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.23.0/tally_0.23.0_Linux_arm64.tar.gz"
      sha256 "5061820674d07615d57f6a903b0f16ee57b776a36a20ffb59fac80302881e5b7"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.23.0/tally_0.23.0_Linux_x86_64.tar.gz"
      sha256 "9e9235169ccf55a2b130d239ada9d7641cbbf8fbbc03bde6a7169d1e6e8ec777"
    end
  end

  def install
    bin.install "tally"
  end

  test do
    # Create a simple Dockerfile to test
    (testpath/"Dockerfile").write <<~DOCKERFILE
      FROM alpine:latest
      RUN echo "hello"
    DOCKERFILE

    # Run tally and check it executes successfully
    output = shell_output("#{bin}/tally check #{testpath}/Dockerfile --format json")
    assert_match "files_scanned", output

    # Verify version output
    assert_match version.to_s, shell_output("#{bin}/tally version")
  end
end
