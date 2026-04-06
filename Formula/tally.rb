# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.32.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.32.0/tally_0.32.0_MacOS_arm64.tar.gz"
      sha256 "bcb7600052c9ffb8142541d4ecdc8eeec64a951623d59d2b05abfe80c606554a"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.32.0/tally_0.32.0_MacOS_x86_64.tar.gz"
      sha256 "e7b10c8a47238e1fa362b81dd228234b5491b9eaa989d5e23d41fced45360270"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.32.0/tally_0.32.0_Linux_arm64.tar.gz"
      sha256 "e8a3368fb946d260d6f2a9f96d964014e6d2b550900b4640cfb42e9913bb346a"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.32.0/tally_0.32.0_Linux_x86_64.tar.gz"
      sha256 "b621094edc98e6e3b8f5d40669a68e6c5b68896a902b0afd22531b7bc5796956"
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
