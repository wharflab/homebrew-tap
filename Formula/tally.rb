# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.10.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.10.1/tally_0.10.1_MacOS_arm64.tar.gz"
      sha256 "dd5e4371ea552c906f4dd335131b216e0815d51f03a4d5c925926a8382cb80e2"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.10.1/tally_0.10.1_MacOS_x86_64.tar.gz"
      sha256 "ea9c8de4996c68dbb86be3a9660b2ebc7a10120bb5424f2f15339c6f6b7d5c96"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.10.1/tally_0.10.1_Linux_arm64.tar.gz"
      sha256 "4981ec765b82b6900f835bfbaa3dc352fd62882be836491ee22547c1fabafa52"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.10.1/tally_0.10.1_Linux_x86_64.tar.gz"
      sha256 "91304aed0d01ae4de0d060321b5ba4ef7ede0435f1df9620852178fdcefbea80"
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
