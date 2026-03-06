# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.21.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.21.1/tally_0.21.1_MacOS_arm64.tar.gz"
      sha256 "2fd5cf5b9af26af1c92dc56549f4bdcf03f60512ff6f121c3fd71a9aef6ae3e1"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.21.1/tally_0.21.1_MacOS_x86_64.tar.gz"
      sha256 "cf1bf39d4dc04fc42d5c19cb83785bdeffdda4dc3bbcf2e931553da8f6ec5011"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.21.1/tally_0.21.1_Linux_arm64.tar.gz"
      sha256 "3b80d9b4509a3c05265c6c73bf9edf9955adb51a25ea69db7c14b8626ebe17f0"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.21.1/tally_0.21.1_Linux_x86_64.tar.gz"
      sha256 "ac0af098f78110520bf36207ef5caa9b0e307b58bb7fc2edc46b244f3697c16a"
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
