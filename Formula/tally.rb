# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.26.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.26.3/tally_0.26.3_MacOS_arm64.tar.gz"
      sha256 "84ff86b7cbded4f01b052f29efdcda653330db1a061bbc19a081d9018a1750f6"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.26.3/tally_0.26.3_MacOS_x86_64.tar.gz"
      sha256 "ebc108c7fe38e47ed09c9a4c7fdbf6521b3b8170633106da2080b4afb3f5d628"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.26.3/tally_0.26.3_Linux_arm64.tar.gz"
      sha256 "c259abb0b03b69ec6a1450966f9de6cccb7442fbc1b37b9b1d44c4bfc2314f24"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.26.3/tally_0.26.3_Linux_x86_64.tar.gz"
      sha256 "e11e5ec2c3e1061cb70a2558535e1380cf351ebc1c3db487fd0c148e3a695aa4"
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
