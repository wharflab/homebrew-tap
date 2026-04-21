# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.35.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.35.1/tally_0.35.1_MacOS_arm64.tar.gz"
      sha256 "441f70757392c7e0fe1b9e00fba60c8c4c3aea8eb311f8902068058dc69c5e2c"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.35.1/tally_0.35.1_MacOS_x86_64.tar.gz"
      sha256 "602eb123872ab84aa8ced974d77651ef5db371d7246a57057067459b488abaa2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.35.1/tally_0.35.1_Linux_arm64.tar.gz"
      sha256 "364f3d5042748234fb43b9c96a74eab411998b319c299506b5227097fdd71f8a"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.35.1/tally_0.35.1_Linux_x86_64.tar.gz"
      sha256 "0b6683e2aeaecffe4d48bc38a37c37e53e2ee620a56c54fd8b486efd314c17c0"
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
