# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.30.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.30.0/tally_0.30.0_MacOS_arm64.tar.gz"
      sha256 "7db002ab9f005efba3d982e8f9c8651893049d25963b2e13be58d8d72465aa8c"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.30.0/tally_0.30.0_MacOS_x86_64.tar.gz"
      sha256 "73af0852680bbd9aca0d68a6ad877fa818cd1f7818c9504c9fe7e66e5b034316"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.30.0/tally_0.30.0_Linux_arm64.tar.gz"
      sha256 "bd97d492dfb3b07301197a1fbfd216d3d0b3fc654ce157ad4b19fc1135eba7c7"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.30.0/tally_0.30.0_Linux_x86_64.tar.gz"
      sha256 "b33ce18081a7313becb9890e845fd69a79d49f112b6f6011059ee63d76eb22d7"
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
