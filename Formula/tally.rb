# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.13.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.13.0/tally_0.13.0_MacOS_arm64.tar.gz"
      sha256 "5b3639ba3b943d40233f2dce2396f28c387338342fb987c281eea84af276a51f"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.13.0/tally_0.13.0_MacOS_x86_64.tar.gz"
      sha256 "ec83a2fbb1303ea9d882f7e07fbe8e251ef1b16cf707df62d0ed5049cb27a1f4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.13.0/tally_0.13.0_Linux_arm64.tar.gz"
      sha256 "3b5a0d58f367b081859952e83beae58f50e130a131ef68191a7d7c5ad7915145"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.13.0/tally_0.13.0_Linux_x86_64.tar.gz"
      sha256 "b29321ab1ac522bb70fbb8cbaed3183bb27ccf1287d26e3c222fffdd568f852b"
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
