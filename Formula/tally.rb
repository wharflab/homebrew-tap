# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.18.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.0/tally_0.18.0_MacOS_arm64.tar.gz"
      sha256 "c77060c42fc6c95175c4bc9da5f18215e978cd2f87c65a44ccce030973f6524a"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.0/tally_0.18.0_MacOS_x86_64.tar.gz"
      sha256 "14adf9c19118721631550b864dc7bebea64944c7746fbb70e41402b8702ab1c6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.0/tally_0.18.0_Linux_arm64.tar.gz"
      sha256 "0b06169ecedb44020f8fd3c8a89f5bac5840600fa5db79e16835a7a50e60fbff"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.0/tally_0.18.0_Linux_x86_64.tar.gz"
      sha256 "14da9c4b3e77ea0bd6ee33da41e46c484ccbdfae7cf543e6d1b3f9001f757b96"
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
