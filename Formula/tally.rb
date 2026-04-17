# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.34.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.34.0/tally_0.34.0_MacOS_arm64.tar.gz"
      sha256 "111a560c3b143860cb872d2bcba5ea90b2db09d9a9228a3a2d9398cb1efc8ac7"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.34.0/tally_0.34.0_MacOS_x86_64.tar.gz"
      sha256 "8f836965edd576860bbd91f9cb134cb3f5261c312e897957c11f55f0b263b43a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.34.0/tally_0.34.0_Linux_arm64.tar.gz"
      sha256 "d62c8eb3cf8c696ada52c07794828e478611c8a0d099f73ddd2ff27ca708afa0"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.34.0/tally_0.34.0_Linux_x86_64.tar.gz"
      sha256 "735cc87fc7ae32b37826a0f87588b9d2b87119d25d0f1bc376df8fdfccf1f683"
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
