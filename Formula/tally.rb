# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.26.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.26.1/tally_0.26.1_MacOS_arm64.tar.gz"
      sha256 "bcea5bc96d70bf2ba44660bc21f3f3301ce3710ab7629e2caa0bf5541ce11965"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.26.1/tally_0.26.1_MacOS_x86_64.tar.gz"
      sha256 "3dd5ff07ae678b7d0e071465ca164150d443cd86e0e0ae51e372134f32bb72cc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.26.1/tally_0.26.1_Linux_arm64.tar.gz"
      sha256 "588d5075b7857eeeb5f754a3408db7bf3589547668d376dc0f95247d49eaaa65"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.26.1/tally_0.26.1_Linux_x86_64.tar.gz"
      sha256 "c705a40accd25eb24528ec91833d6917f27a6b1c5fb6314e482e9c4475b433db"
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
