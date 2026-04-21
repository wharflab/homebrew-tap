# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.35.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.35.0/tally_0.35.0_MacOS_arm64.tar.gz"
      sha256 "4489fa3492f2f34e9a4f5a39b6d17199441ada71ad714b9bd77f20777bc6000a"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.35.0/tally_0.35.0_MacOS_x86_64.tar.gz"
      sha256 "b366e7248399ea157ee0ae00a57b69e1af5b2e40ce06955065b4e14cc40fd109"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.35.0/tally_0.35.0_Linux_arm64.tar.gz"
      sha256 "f9fd3873bf1609751e6dd8d2a254b54a2d43e89746c8465eae7b7ca029f0492d"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.35.0/tally_0.35.0_Linux_x86_64.tar.gz"
      sha256 "03b46e4f8f2cc1f187f7f83d39ddb834390f9748546f880278cde450bfc63b6c"
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
