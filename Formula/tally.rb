# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.11.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.11.0/tally_0.11.0_MacOS_arm64.tar.gz"
      sha256 "72d6d4c3c6c15d94c8e5bfa859f2fa6d300ee188e559865fea68a743df8b6ce4"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.11.0/tally_0.11.0_MacOS_x86_64.tar.gz"
      sha256 "7b78c8c3a93b226663651536dd84cd0fde408f621b544f6ddc4fa24c8e730db6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.11.0/tally_0.11.0_Linux_arm64.tar.gz"
      sha256 "1085bb9a1535ad7e46a584d4981ad9ecdcb2ce8102ea7eea585ba1cb43bff304"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.11.0/tally_0.11.0_Linux_x86_64.tar.gz"
      sha256 "01213571c93d11f4eb095f3e4a1e48aba0f1f79d2a3ca049732e39a4b71bdedb"
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
